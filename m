Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0B3DDB39
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhHBOjF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 10:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234338AbhHBOjE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 10:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627915135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NvQqjHxDjWIl9I04pyF+RZqtMWv/K6HRiVTburrWufE=;
        b=WUGqEeuCo7SYyQ0j/kJrrvtU6UpIJhl9y7A1zagtSQcJvrHHY86cCKYWk61Opu53pzIcvG
        UumAPU6yOWwxvSP4yRbdPtXG+aK4f87Xi4tg9NcgP6gVBSklrr5YUjAOmcrM0IkfUch4lj
        gIe54RZq811uAk3Xf4Nll3jLrcaPuxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-SRPPV-nUOr-33tcaUuMzHw-1; Mon, 02 Aug 2021 10:38:54 -0400
X-MC-Unique: SRPPV-nUOr-33tcaUuMzHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F84801B3C;
        Mon,  2 Aug 2021 14:38:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A469C10493BD;
        Mon,  2 Aug 2021 14:38:43 +0000 (UTC)
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
Subject: [PATCH v2] mm/memcg: Fix incorrect flushing of lruvec data in obj_stock
Date:   Mon,  2 Aug 2021 10:38:34 -0400
Message-Id: <20210802143834.30578-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When mod_objcg_state() is called with a pgdat that is different from
that in the obj_stock, the old lruvec data cached in obj_stock are
flushed out. Unfortunately, they were flushed to the new pgdat and
so the data go to the wrong node. This will screw up the slab data
reported in /sys/devices/system/node/node*/meminfo.

Fix that by flushing the data to the cached pgdat instead.

Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..87c883227f90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3106,13 +3106,15 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		stock->cached_pgdat = pgdat;
 	} else if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
+		struct pglist_data *oldpg = stock->cached_pgdat;
+
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
-- 
2.18.1

