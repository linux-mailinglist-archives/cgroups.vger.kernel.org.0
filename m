Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73343745E
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJVJMY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 05:12:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhJVJMW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Oct 2021 05:12:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E278E212C8;
        Fri, 22 Oct 2021 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634893803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vr4YC4Ootp7YmZVbnn2IeZzn/hRDb/zTjl1sQmsj3Y4=;
        b=R9XstMmNBuTc8yClgMbVxDC5C6GgjMu70ghewFBYZCpoiP06QqDFRqWH3wnrvhv/IQmgaP
        QS2K0ayylJY9+kzYN4p8QdPHBeCm1vg7vQognKVqlhHNuUEVuZ4huerfiP8txsHMEmJmv4
        59ZPx7m1v06coMsJDaEm6dUfI9Dilp0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B35CDA3B81;
        Fri, 22 Oct 2021 09:10:03 +0000 (UTC)
Date:   Fri, 22 Oct 2021 11:10:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg v2 2/2] memcg: prohibit unconditional exceeding the
 limit of dying tasks
Message-ID: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
References: <YXGZoVhROdFG2Wym@dhcp22.suse.cz>
 <cover.1634889066.git.vvs@virtuozzo.com>
 <4b315938-5600-b7f5-bde9-82f638a2e595@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b315938-5600-b7f5-bde9-82f638a2e595@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 22-10-21 11:11:29, Vasily Averin wrote:
> Memory cgroup charging allows killed or exiting tasks to exceed the hard
> limit. It is assumed that the amount of the memory charged by those
> tasks is bound and most of the memory will get released while the task
> is exiting. This is resembling a heuristic for the global OOM situation
> when tasks get access to memory reserves. There is no global memory
> shortage at the memcg level so the memcg heuristic is more relieved.
> 
> The above assumption is overly optimistic though. E.g. vmalloc can scale
> to really large requests and the heuristic would allow that. We used to
> have an early break in the vmalloc allocator for killed tasks but this
> has been reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
> the current task is killed""). There are likely other similar code paths
> which do not check for fatal signals in an allocation&charge loop.
> Also there are some kernel objects charged to a memcg which are not
> bound to a process life time.
> 
> It has been observed that it is not really hard to trigger these
> bypasses and cause global OOM situation.
> 
> One potential way to address these runaways would be to limit the amount
> of excess (similar to the global OOM with limited oom reserves). This is
> certainly possible but it is not really clear how much of an excess is
> desirable and still protects from global OOMs as that would have to
> consider the overall memcg configuration.
> 
> This patch is addressing the problem by removing the heuristic
> altogether. Bypass is only allowed for requests which either cannot fail
> or where the failure is not desirable while excess should be still
> limited (e.g. atomic requests). Implementation wise a killed or dying
> task fails to charge if it has passed the OOM killer stage. That should
> give all forms of reclaim chance to restore the limit before the
> failure (ENOMEM) and tell the caller to back off.
> 
> In addition, this patch renames should_force_charge() helper
> to task_is_dying() because now its use is not associated witch forced
> charging.

I would explicitly mention that this depends on pagefault_out_of_memory
to not trigger out_of_memory because then a memcg failure can unwind to
VM_FAULT_OOM and cause a global OOM killer.

Maybe it would be even better to fold the removal to this patch so the
dependency is more obvious. I will live that to you.

> Fixes: a636b327f731 ("memcg: avoid unnecessary system-wide-oom-killer")

Fixes tag would be quite hard here. For example you certainly didn't
have a practically unbound vector to go over the hard limit - like
vmalloc. At least not after __GFP_ACCOUNT has been introduced. So I
would just not bother with a Fixes tag at all rather than cause it more
questions than answers.

> Cc: stable@vger.kernel.org
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Other than that looks good to me.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6da5020a8656..87e41c3cac10 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -239,7 +239,7 @@ enum res_type {
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -static inline bool should_force_charge(void)
> +static inline bool task_is_dying(void)
>  {
>  	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
>  		(current->flags & PF_EXITING);
> @@ -1575,7 +1575,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * A few threads which were not waiting at mutex_lock_killable() can
>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>  	 */
> -	ret = should_force_charge() || out_of_memory(&oc);
> +	ret = task_is_dying() || out_of_memory(&oc);
>  
>  unlock:
>  	mutex_unlock(&oom_lock);
> @@ -2530,6 +2530,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	struct page_counter *counter;
>  	enum oom_status oom_status;
>  	unsigned long nr_reclaimed;
> +	bool passed_oom = false;
>  	bool may_swap = true;
>  	bool drained = false;
>  	unsigned long pflags;
> @@ -2564,15 +2565,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (gfp_mask & __GFP_ATOMIC)
>  		goto force;
>  
> -	/*
> -	 * Unlike in global OOM situations, memcg is not in a physical
> -	 * memory shortage.  Allow dying and OOM-killed tasks to
> -	 * bypass the last charges so that they can exit quickly and
> -	 * free their memory.
> -	 */
> -	if (unlikely(should_force_charge()))
> -		goto force;
> -
>  	/*
>  	 * Prevent unbounded recursion when reclaim operations need to
>  	 * allocate memory. This might exceed the limits temporarily,
> @@ -2630,8 +2622,9 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (gfp_mask & __GFP_RETRY_MAYFAIL)
>  		goto nomem;
>  
> -	if (fatal_signal_pending(current))
> -		goto force;
> +	/* Avoid endless loop for tasks bypassed by the oom killer */
> +	if (passed_oom && task_is_dying())
> +		goto nomem;
>  
>  	/*
>  	 * keep retrying as long as the memcg oom killer is able to make
> @@ -2640,14 +2633,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 */
>  	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
>  		       get_order(nr_pages * PAGE_SIZE));
> -	switch (oom_status) {
> -	case OOM_SUCCESS:
> +	if (oom_status == OOM_SUCCESS) {
> +		passed_oom = true;
>  		nr_retries = MAX_RECLAIM_RETRIES;
>  		goto retry;
> -	case OOM_FAILED:
> -		goto force;
> -	default:
> -		goto nomem;
>  	}
>  nomem:
>  	if (!(gfp_mask & __GFP_NOFAIL))
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
