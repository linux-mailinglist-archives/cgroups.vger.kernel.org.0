Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780A4434AF3
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJTMQY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 08:16:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:43956 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhJTMQX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 08:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=sUtfqX3vH75qqCOKFcLO4ftwwfJuASZg/BHthju0tgY=; b=IgZ81foHaZvO7TJsKcl
        yzEbZ910pbQpBRn2icjnDn2zJp5Hjhel+UwzbgScwCjZ0/iUhZy9QiW8IBhadYh12T/GQzf/i6897
        AjNbTT8OCMxUBz6qBxqqj/rndTNEpKj4VFnjy+6AMY6jUuAS36q8pvlliwRQ5878Orp9MtBnvhM=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdATv-006bBe-KV; Wed, 20 Oct 2021 15:14:07 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg 2/3] memcg: remove charge forcinig for dying tasks
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
Message-ID: <56180e53-b705-b1be-9b60-75e141c8560c@virtuozzo.com>
Date:   Wed, 20 Oct 2021 15:13:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1634730787.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ToDo: should we keep task_is_dying() in mem_cgroup_out_of_memory() ?

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/memcontrol.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..74a7379dbac1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -239,7 +239,7 @@ enum res_type {
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-static inline bool should_force_charge(void)
+static inline bool task_is_dying(void)
 {
 	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
 		(current->flags & PF_EXITING);
@@ -1575,7 +1575,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * A few threads which were not waiting at mutex_lock_killable() can
 	 * fail to bail out. Therefore, check again after holding oom_lock.
 	 */
-	ret = should_force_charge() || out_of_memory(&oc);
+	ret = task_is_dying() || out_of_memory(&oc);
 
 unlock:
 	mutex_unlock(&oom_lock);
@@ -2530,6 +2530,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
+	bool passed_oom = false;
 	bool may_swap = true;
 	bool drained = false;
 	unsigned long pflags;
@@ -2564,15 +2565,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_ATOMIC)
 		goto force;
 
-	/*
-	 * Unlike in global OOM situations, memcg is not in a physical
-	 * memory shortage.  Allow dying and OOM-killed tasks to
-	 * bypass the last charges so that they can exit quickly and
-	 * free their memory.
-	 */
-	if (unlikely(should_force_charge()))
-		goto force;
-
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2630,8 +2622,9 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	if (fatal_signal_pending(current))
-		goto force;
+	/* Avoid endless loop for tasks bypassed by the oom killer */
+	if (passed_oom && task_is_dying())
+		goto nomem;
 
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
@@ -2642,6 +2635,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
 	switch (oom_status) {
 	case OOM_SUCCESS:
+		passed_oom = true;
 		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
 	case OOM_FAILED:
-- 
2.32.0

