Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F932682BD
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 04:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgINCpa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 22:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgINCpZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 22:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600051523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ac1RMJJ983xTNNkjK3Roq6fpubHne8/578b+AWco/Fo=;
        b=K7NgPFJMH9E18S6T7zwY7cmdDRRe6dSPTY8pNF6BOYWq0gQ3RR23Bqt46+YofJSJfafCbo
        /VsP1qrK4K+nRFTML3HlixS9V3kcpJIS2xlrJpcFOmc3jMZrIf1LVdnzjrX73QRdT0p73T
        uXPdivf5cx+Lna5UYNS2w0pHWlRfzzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-oltS5sNFMYymUwryPBaNlw-1; Sun, 13 Sep 2020 22:45:18 -0400
X-MC-Unique: oltS5sNFMYymUwryPBaNlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87F3F1074657;
        Mon, 14 Sep 2020 02:45:16 +0000 (UTC)
Received: from llong.com (ovpn-113-90.rdu2.redhat.com [10.10.113.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38A2460BF3;
        Mon, 14 Sep 2020 02:45:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Date:   Sun, 13 Sep 2020 22:44:51 -0400
Message-Id: <20200914024452.19167-3-longman@redhat.com>
In-Reply-To: <20200914024452.19167-1-longman@redhat.com>
References: <20200914024452.19167-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The mem_cgroup_get_max() function used to get memory+swap max from
both the v1 memsw and v2 memory+swap page counters & return the maximum
of these 2 values. This is redundant and it is more efficient to just
get either the v1 or the v2 values depending on which one is currently
in use.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c74f1200261..ca36bed588d1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1633,17 +1633,15 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
  */
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
-	unsigned long max;
-
-	max = READ_ONCE(memcg->memory.max);
-	if (mem_cgroup_swappiness(memcg)) {
-		unsigned long memsw_max;
-		unsigned long swap_max;
-
-		memsw_max = memcg->memsw.max;
-		swap_max = READ_ONCE(memcg->swap.max);
-		swap_max = min(swap_max, (unsigned long)total_swap_pages);
-		max = min(max + swap_max, memsw_max);
+	unsigned long max = READ_ONCE(memcg->memory.max);
+
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		if (mem_cgroup_swappiness(memcg))
+			max += min(READ_ONCE(memcg->swap.max),
+				   (unsigned long)total_swap_pages);
+	} else { /* v1 */
+		if (mem_cgroup_swappiness(memcg))
+			max = memcg->memsw.max;
 	}
 	return max;
 }
-- 
2.18.1

