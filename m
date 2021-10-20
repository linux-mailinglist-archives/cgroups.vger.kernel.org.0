Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8691F434677
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJTIJn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 04:09:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:54762 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhJTIJm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 04:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=YevvvMCiVzqy7JB/kdiCKehop5AjB5KIhCsQIr9tEAc=; b=NAreMZ+5hH/sWOc1gxX
        2mH912t5b4sW5Wf2EthHkT/c49tt/iyxt1ZmyZf3SR6o37YHs1tRRGDpmXYHPLxgDBdLUHK6O9aRA
        Monh6lpkMbpPhLL2k3UE/1qO6tiwuSKzN4CaesJdLSkcrbKYSPtB+LcUFHCP1jKSosW7g17Wd1s=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1md6d9-006ZO7-NW; Wed, 20 Oct 2021 11:07:23 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v4] memcg: prohibit unconditional exceeding the limit of
 dying tasks
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
References: <3c76e2d7-e545-ef34-b2c3-a5f63b1eff51@virtuozzo.com>
Message-ID: <f40cd82c-f03a-4d36-e953-f89399cb8f58@virtuozzo.com>
Date:   Wed, 20 Oct 2021 11:07:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3c76e2d7-e545-ef34-b2c3-a5f63b1eff51@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Memory cgroup charging allows killed or exiting tasks to exceed the hard
limit. It is assumed that the amount of the memory charged by those
tasks is bound and most of the memory will get released while the task
is exiting. This is resembling a heuristic for the global OOM situation
when tasks get access to memory reserves. There is no global memory
shortage at the memcg level so the memcg heuristic is more relieved.

The above assumption is overly optimistic though. E.g. vmalloc can scale
to really large requests and the heuristic would allow that. We used to
have an early break in the vmalloc allocator for killed tasks but this
has been reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
the current task is killed""). There are likely other similar code paths
which do not check for fatal signals in an allocation&charge loop.
Also there are some kernel objects charged to a memcg which are not
bound to a process life time.

It has been observed that it is not really hard to trigger these
bypasses and cause global OOM situation.

One potential way to address these runaways would be to limit the amount
of excess (similar to the global OOM with limited oom reserves). This is
certainly possible but it is not really clear how much of an excess is
desirable and still protects from global OOMs as that would have to
consider the overall memcg configuration.

This patch is addressing the problem by removing the heuristic
altogether. Bypass is only allowed for requests which either cannot fail
or where the failure is not desirable while excess should be still
limited (e.g. atomic requests). Implementation wise a killed or dying
task fails to charge if it has passed the OOM killer stage. That should
give all forms of reclaim chance to restore the limit before the
failure (ENOMEM) and tell the caller to back off.

In addition, this patch renames should_force_charge() helper
to task_is_dying() because now its use is not associated witch forced
charging.

If try_charge_memcg() is called from #PF, its new failres can force
pagefault_out_of_memory() to execute the global OOM. To prevent it
pagefault_out_of_memory() was updated to properly handle memcg-related
restrictions.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v4: updated pagefault_out_of_memory() to properly handle new memcg-related 
     restrictions and not allow false global OOM 
v3: no functional changes, just improved patch description
v2: swicthed to patch version proposed by mhocko@

 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++---------------------
 mm/oom_kill.c   |  3 +++
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..b09d3c64f63f 100644
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
@@ -1810,11 +1810,21 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 		mem_cgroup_oom_notify(memcg);
 
 	mem_cgroup_unmark_under_oom(memcg);
-	if (mem_cgroup_out_of_memory(memcg, mask, order))
+	if (mem_cgroup_out_of_memory(memcg, mask, order)) {
 		ret = OOM_SUCCESS;
-	else
+	} else {
 		ret = OOM_FAILED;
-
+		/*
+		 * In some rare cases mem_cgroup_out_of_memory() can return false.
+		 * If it was called from #PF it forces handle_mm_fault()
+		 * return VM_FAULT_OOM and executes pagefault_out_of_memory().
+		 * memcg_in_oom is set here to notify pagefault_out_of_memory()
+		 * that it was a memcg-related failure and not allow to run
+		 * global OOM.
+		 */
+		if (current->in_user_fault)
+			current->memcg_in_oom = (struct mem_cgroup *)ret;
+	}
 	if (locked)
 		mem_cgroup_oom_unlock(memcg);
 
@@ -1848,6 +1858,15 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	if (!memcg)
 		return false;
 
+	/* OOM is memcg, however out_of_memory() found no victim */
+	if (memcg == (struct mem_cgroup *)OOM_FAILED) {
+		/*
+		 * Should be called from pagefault_out_of_memory() only,
+		 * where it is used to prevent false global OOM.
+		 */
+		current->memcg_in_oom = NULL;
+		return true;
+	}
 	if (!handle)
 		goto cleanup;
 
@@ -2530,6 +2549,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
+	bool passed_oom = false;
 	bool may_swap = true;
 	bool drained = false;
 	unsigned long pflags;
@@ -2564,15 +2584,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2630,8 +2641,9 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
-	if (fatal_signal_pending(current))
-		goto force;
+	/* Avoid endless loop for tasks bypassed by the oom killer */
+	if (passed_oom && task_is_dying())
+		goto nomem;
 
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
@@ -2640,14 +2652,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..1deef8c7a71b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1137,6 +1137,9 @@ void pagefault_out_of_memory(void)
 	if (mem_cgroup_oom_synchronize(true))
 		return;
 
+	if (fatal_signal_pending(current))
+		return;
+
 	if (!mutex_trylock(&oom_lock))
 		return;
 	out_of_memory(&oc);
-- 
2.32.0

