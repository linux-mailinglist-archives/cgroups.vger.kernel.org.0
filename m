Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE23740AB71
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhINKLZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 06:11:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:60568 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhINKLY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 Sep 2021 06:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=87Usn2aUyaGukdvTQyAtkwgJSSvFWpDAI/0/mAUhfC4=; b=Eri6QZEdGzXIi6+R334
        MJpM9u15Zah1NXvVDf73rRVgwcCQIRy7ETslE/3Nnh1JPqIagnOR3jsiiXGO51H6WySfgswpGti8d
        ewNeU1Hl5U0GGI1TjYT+IcLjNRElnHlQr6VYemDwhb4E5pI/L2xEBgk51AuwEbgsEHQ+vVIlWaE=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mQ5O9-001wA6-K9; Tue, 14 Sep 2021 13:10:05 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v2] memcg: prohibit unconditional exceeding the limit of
 dying tasks
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <bab6c1d2-38d8-9098-206f-54894f9871b6@virtuozzo.com>
Message-ID: <817a6ce2-4da9-72ac-c5b9-edd398d28a15@virtuozzo.com>
Date:   Tue, 14 Sep 2021 13:10:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bab6c1d2-38d8-9098-206f-54894f9871b6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The kernel currently allows dying tasks to exceed the memcg limits.
The allocation is expected to be the last one and the occupied memory
will be freed soon.
This is not always true because it can be part of the huge vmalloc
allocation. Allowed once, they will repeat over and over again.
Moreover lifetime of the allocated object can differ from the lifetime
of the dying task.
Multiple such allocations running concurrently can not only overuse
the memcg limit, but can lead to a global out of memory and,
in the worst case, cause the host to panic.

This patch removes checks forced exceed of the memcg limit for dying
tasks. Also it breaks endless loop for tasks bypassed by the oom killer.
In addition, it renames should_force_charge() helper to task_is_dying()
because now its use do not lead to the forced charge.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/memcontrol.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 389b5766e74f..707f6640edda 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -234,7 +234,7 @@ enum res_type {
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-static inline bool should_force_charge(void)
+static inline bool task_is_dying(void)
 {
 	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
 		(current->flags & PF_EXITING);
@@ -1607,7 +1607,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * A few threads which were not waiting at mutex_lock_killable() can
 	 * fail to bail out. Therefore, check again after holding oom_lock.
 	 */
-	ret = should_force_charge() || out_of_memory(&oc);
+	ret = task_is_dying() || out_of_memory(&oc);
 
 unlock:
 	mutex_unlock(&oom_lock);
@@ -2588,6 +2588,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
+	bool passed_oom = false;
 	bool may_swap = true;
 	bool drained = false;
 	unsigned long pflags;
@@ -2622,15 +2623,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2688,8 +2680,9 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	if (fatal_signal_pending(current))
-		goto force;
+	/* Avoid endless loop for tasks bypassed by the oom killer */
+	if (passed_oom && task_is_dying())
+		goto nomem;
 
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
@@ -2698,14 +2691,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
-	switch (oom_status) {
-	case OOM_SUCCESS:
+	if (oom_status == OOM_SUCCESS) {
+		passed_oom = true;
 		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
-	case OOM_FAILED:
-		goto force;
-	default:
-		goto nomem;
 	}
 nomem:
 	if (!(gfp_mask & __GFP_NOFAIL))
-- 
2.31.1

