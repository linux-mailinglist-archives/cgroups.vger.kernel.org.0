Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADA624BD60
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgHTNEl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 09:04:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730078AbgHTNEZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 09:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597928658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kBu3kMgySM1JmJ3UbrHPhytTu9PiX289muKYqVsxxD0=;
        b=cleW8DPeygNMfRwKU0pSoyW/rhS/k607AR/mDmGP6wcLQhqSs/LGHtEyGDr0qPfEHoOD9D
        +K+uHNH+B/cQboo4AQ/PBM7NbLJ7HOBkiJcCy4QwGc/QAMyxltEVvVhVycj6oU0f+tBQge
        NzUIBcgyZY7FjuD4YC80X7DvBQg44UA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-_GR2kcr7MCGriJw5680LiA-1; Thu, 20 Aug 2020 09:04:14 -0400
X-MC-Unique: _GR2kcr7MCGriJw5680LiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9AE1006296;
        Thu, 20 Aug 2020 13:04:12 +0000 (UTC)
Received: from llong.com (unknown [10.10.115.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2997A1F4;
        Thu, 20 Aug 2020 13:04:11 +0000 (UTC)
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
Subject: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Date:   Thu, 20 Aug 2020 09:03:49 -0400
Message-Id: <20200820130350.3211-3-longman@redhat.com>
In-Reply-To: <20200820130350.3211-1-longman@redhat.com>
References: <20200820130350.3211-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 mm/memcontrol.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 26b7a48d3afb..d219dca5239f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
  */
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
-	unsigned long max;
+	unsigned long max = READ_ONCE(memcg->memory.max);
 
-	max = READ_ONCE(memcg->memory.max);
 	if (mem_cgroup_swappiness(memcg)) {
-		unsigned long memsw_max;
-		unsigned long swap_max;
-
-		memsw_max = memcg->memsw.max;
-		swap_max = READ_ONCE(memcg->swap.max);
-		swap_max = min(swap_max, (unsigned long)total_swap_pages);
-		max = min(max + swap_max, memsw_max);
+		if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+			max += READ_ONCE(memcg->swap.max);
+		else
+			max = memcg->memsw.max;
 	}
 	return max;
 }
-- 
2.18.1

