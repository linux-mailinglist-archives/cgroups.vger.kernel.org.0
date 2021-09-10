Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB815406CA0
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhIJNIh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 09:08:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:56714 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhIJNIg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 10 Sep 2021 09:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=l7hmjLfN17DbZOQPBxo/TqxgI8vIdto//52MwwSU7PQ=; b=BpOK4WoUO/4tXrAau
        TRcdC2XSuXj0Ic8FwK0NFxxlBjQsbt4ktXk9tdSeD3N1o+7AkrOugDDW3jvbc1skztujg9iLtOuVi
        wNZR4g4wQCDE+D6KA+x6fERePPROTvDOx9lPMKAJybqEBgdDtHCcK7RYva2S34CevMoQUmvaBpKRA
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mOgFJ-001Uxj-5n; Fri, 10 Sep 2021 16:07:09 +0300
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
Message-ID: <4d61c7fd-ee33-4dc9-0ab1-8eca4d3297b0@virtuozzo.com>
Date:   Fri, 10 Sep 2021 16:07:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/10/21 3:39 PM, Vasily Averin wrote:
> The kernel currently allows dying tasks to exceed the memcg limits.
> The allocation is expected to be the last one and the occupied memory
> will be freed soon.
> This is not always true because it can be part of the huge vmalloc
> allocation. Allowed once, they will repeat over and over again.
> Moreover lifetime of the allocated object can differ from
> In addition the lifetime of the dying task.
> Multiple such allocations running concurrently can not only overuse
> the memcg limit, but can lead to a global out of memory and,
> in the worst case, cause the host to panic.

btw should_force_charge() function name become wrong with this.
Is it make sense to replace it by something like is_task_dying() ?

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/memcontrol.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 389b5766e74f..67195fcfbddf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1834,6 +1834,9 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		return OOM_ASYNC;
>  	}
>  
> +	if (should_force_charge())
> +		return OOM_SKIPPED;
> +
>  	mem_cgroup_mark_under_oom(memcg);
>  
>  	locked = mem_cgroup_oom_trylock(memcg);
> @@ -2622,15 +2625,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
> @@ -2688,9 +2682,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (gfp_mask & __GFP_RETRY_MAYFAIL)
>  		goto nomem;
>  
> -	if (fatal_signal_pending(current))
> -		goto force;
> -
>  	/*
>  	 * keep retrying as long as the memcg oom killer is able to make
>  	 * a forward progress or bypass the charge if the oom killer
> @@ -2698,15 +2689,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 */
>  	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
>  		       get_order(nr_pages * PAGE_SIZE));
> -	switch (oom_status) {
> -	case OOM_SUCCESS:
> +	if (oom_status == OOM_SUCCESS) {
>  		nr_retries = MAX_RECLAIM_RETRIES;
>  		goto retry;
> -	case OOM_FAILED:
> +	} else if (oom_status == OOM_FAILED)
>  		goto force;
> -	default:
> -		goto nomem;
> -	}
>  nomem:
>  	if (!(gfp_mask & __GFP_NOFAIL))
>  		return -ENOMEM;
> 

