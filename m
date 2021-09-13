Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9836B40898D
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhIMK4m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 06:56:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50876 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbhIMK4k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 06:56:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A7AB41FFCE;
        Mon, 13 Sep 2021 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631530522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1UGM9JLTi4/yHsh8pdylCNFEn0IEPb6s7+Trsqo/UA=;
        b=exLocUfD64t8HpX7hoYhSAtzG0u1WHBku4YnVDStTcJJ9WDBF6FG7HHpdl5z8GvPbJuFbJ
        +w2i7+TST/X8vrdm47iBmGkuT7HZA1nOJQjt1yOLFcnPKY2zb8aaRAfnEO5bS5skR2pRrA
        9p158A0kh7iTmexl7FkWO7DNJW+nkDI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DB52A3B84;
        Mon, 13 Sep 2021 10:55:22 +0000 (UTC)
Date:   Mon, 13 Sep 2021 12:55:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
Message-ID: <YT8uGUMQ7K+/0gyA@dhcp22.suse.cz>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <YT8RjxShvfEVe4YU@dhcp22.suse.cz>
 <7af26106-388c-6f99-e018-669a8f0cf9b5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af26106-388c-6f99-e018-669a8f0cf9b5@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 13:35:00, Vasily Averin wrote:
> On 9/13/21 11:53 AM, Michal Hocko wrote:
> > On Fri 10-09-21 15:39:28, Vasily Averin wrote:
> >> The kernel currently allows dying tasks to exceed the memcg limits.
> >> The allocation is expected to be the last one and the occupied memory
> >> will be freed soon.
> >> This is not always true because it can be part of the huge vmalloc
> >> allocation. Allowed once, they will repeat over and over again.
> >> Moreover lifetime of the allocated object can differ from
> >> In addition the lifetime of the dying task.
> >> Multiple such allocations running concurrently can not only overuse
> >> the memcg limit, but can lead to a global out of memory and,
> >> in the worst case, cause the host to panic.
> >>
> >> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> >> ---
> >>  mm/memcontrol.c | 23 +++++------------------
> >>  1 file changed, 5 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 389b5766e74f..67195fcfbddf 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -1834,6 +1834,9 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> >>  		return OOM_ASYNC;
> >>  	}
> >>  
> >> +	if (should_force_charge())
> >> +		return OOM_SKIPPED;
> > 
> > mem_cgroup_out_of_memory already check for the bypass, now you are
> > duplicating that check with a different answer to the caller. This is
> > really messy. One of the two has to go away.
> 
> In this case mem_cgroup_out_of_memory() takes locks and mutexes but doing nothing
> useful and its success causes try_charge_memcg() to repeat the loop unnecessarily.
> 
> I cannot change mem_cgroup_out_of_memory internals, because it is used in other places too.The check inside mem_cgroup_out_of_memory is required because situation can be changed after
> check added into mem_cgroup_oom().
> 
> Though I got your argument, and will think how to improve the patch.
> Anyway we'll need to do something with name of should_force_charge() function
> that will NOT lead to forced charge.

Here is what I would do.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 702a81dfe72d..58269721d438 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
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
+	if (passed_oom && should_force_charge())
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
Michal Hocko
SUSE Labs
