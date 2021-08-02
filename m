Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA853DCEAD
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 04:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhHBC3F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 1 Aug 2021 22:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhHBC3F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 1 Aug 2021 22:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627871336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=We5uPnQeByis91o/AyYOCOo9vmw3X7xwMVyvzEdXeeY=;
        b=YUiZKimBiV9cFsQUeSGSLbLIFvAL4m8W9NK/p8jvZnznyInzzVA+j6QxSuHivUkgtY3qlj
        S5dKBSkGJyH6OiCMWAnkZ+jWAZsukcjBFOvpip57RVzQML9jXljw+e5ix3xJNcQLUMsRv3
        XmBmQs19ITpbRriCkzWEW3lFDnqG3UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Ts4DyE5DPWyoOBve8zP2Qg-1; Sun, 01 Aug 2021 22:28:53 -0400
X-MC-Unique: Ts4DyE5DPWyoOBve8zP2Qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA0C1853027;
        Mon,  2 Aug 2021 02:28:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2424427CB4;
        Mon,  2 Aug 2021 02:28:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/memcg: Fix incorrect flushing of lruvec data in obj_stock
Date:   Sun,  1 Aug 2021 22:28:27 -0400
Message-Id: <20210802022827.10192-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When mod_objcg_state() is called with a pgdat that is different from
that in the obj_stock, the old lruvec data cached in obj_stock are
flushed out. Unfortunately, they were flushed to the new pgdat and
hence the wrong node, not the one cached in obj_stock.

Fix that by flushing the data to the cached pgdat instead.

Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..881ec4ddddcd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3106,17 +3106,19 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		stock->cached_pgdat = pgdat;
 	} else if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
+		struct pglist_data *oldpg = stock->cached_pgdat;
+
+		stock->cached_pgdat = pgdat;
 		if (stock->nr_slab_reclaimable_b) {
-			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_RECLAIMABLE_B,
+			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_UNRECLAIMABLE_B,
+			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
-		stock->cached_pgdat = pgdat;
 	}
 
 	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
-- 
2.18.1

