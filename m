Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29894268D54
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgINOUh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 10:20:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbgINOUb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 10:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600093225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=HtBSdfoUR8h4s3JfPJeC6QxKphf9QsZWctKie4ScbZc=;
        b=PdQNTFtZXazXcpJ5FSZgea6zH99q17ZEQVRyYNcXgCHkFgtzziW+nZnXhD9mMu555MOjLd
        VOLyvJEHQyvB1w0QonolHtKOMjwOIOaGyN2HyG40vgtwxCOvT+Y/NheIK8GtorUQrnZmfF
        CwJ8V85bGpkkDyVOpLQ87489vooIw6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-7AJo8FsCMz-PblnLrDL7sw-1; Mon, 14 Sep 2020 10:20:20 -0400
X-MC-Unique: 7AJo8FsCMz-PblnLrDL7sw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DDA6884E47;
        Mon, 14 Sep 2020 14:20:18 +0000 (UTC)
Received: from llong.com (ovpn-118-85.rdu2.redhat.com [10.10.118.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F9A727BCB;
        Mon, 14 Sep 2020 14:20:14 +0000 (UTC)
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
Subject: [PATCH v3 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Date:   Mon, 14 Sep 2020 10:19:55 -0400
Message-Id: <20200914141955.2145-1-longman@redhat.com>
In-Reply-To: <20200914024452.19167-1-longman@redhat.com>
References: <20200914024452.19167-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 mm/memcontrol.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c74f1200261..2331d4bc7c4d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1633,17 +1633,19 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
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
+		if (mem_cgroup_swappiness(memcg)) {
+			unsigned long memsw = READ_ONCE(memcg->memsw.max);
+
+			if (memsw > max)
+				max += min(memsw - max, (unsigned long)total_swap_pages);
+		}
 	}
 	return max;
 }
-- 
2.18.1

