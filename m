Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D1437410
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhJVI5i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 04:57:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52416 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJVI5i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Oct 2021 04:57:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2B641FD58;
        Fri, 22 Oct 2021 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634892919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i3+Uq4UVNBn028/JKXLqD4OiZxT03waqoqBrFgoR68s=;
        b=rYy6eAW81DVWQ4qIapbCVxcjYhvwbEUMsRYrCuUlK8wERzwwrBAADvSBBCEGowtQyGVW2G
        1+Q4WlTvriLaT/KtIsrsaiz97VnyIm+h89JuaaJUEFfbqfiE/+x00hqwNIWoSSMHda2jl7
        wlQTz0oymuS2IXzMxFDWXMJmNcYymvk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 65512A3B89;
        Fri, 22 Oct 2021 08:55:18 +0000 (UTC)
Date:   Fri, 22 Oct 2021 10:55:17 +0200
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
Subject: Re: [PATCH memcg v2 1/2] mm, oom: do not trigger out_of_memory from
 the #PF
Message-ID: <YXJ8daC9Ex1x1Rbq@dhcp22.suse.cz>
References: <YXGZoVhROdFG2Wym@dhcp22.suse.cz>
 <cover.1634889066.git.vvs@virtuozzo.com>
 <91d9196e-842a-757f-a3f2-caeb4a89a0d8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d9196e-842a-757f-a3f2-caeb4a89a0d8@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 22-10-21 11:11:09, Vasily Averin wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Any allocation failure during the #PF path will return with VM_FAULT_OOM
> which in turn results in pagefault_out_of_memory. This can happen for
> 2 different reasons. a) Memcg is out of memory and we rely on
> mem_cgroup_oom_synchronize to perform the memcg OOM handling or b)
> normal allocation fails.
> 
> The later is quite problematic because allocation paths already trigger
> out_of_memory and the page allocator tries really hard to not fail
> allocations. Anyway, if the OOM killer has been already invoked there
> is no reason to invoke it again from the #PF path. Especially when the
> OOM condition might be gone by that time and we have no way to find out
> other than allocate.
> 
> Moreover if the allocation failed and the OOM killer hasn't been
> invoked then we are unlikely to do the right thing from the #PF context
> because we have already lost the allocation context and restictions and
> therefore might oom kill a task from a different NUMA domain.
> 
> An allocation might fail also when the current task is the oom victim
> and there are no memory reserves left and we should simply bail out
> from the #PF rather than invoking out_of_memory.
> 
> This all suggests that there is no legitimate reason to trigger
> out_of_memory from pagefault_out_of_memory so drop it. Just to be sure
> that no #PF path returns with VM_FAULT_OOM without allocation print a
> warning that this is happening before we restart the #PF.

Thanks for reviving my old patch! I still do think this is the right
direction. I would argue that we should split this into two stages as
already mentioned. First to add a bail out on fatal_signal_pending
because that is a trivial thing to do and it should be obviously safer.
Then we can remove out_of_memory completely. That should be obviously
right thing to do but if it turns out we have missed something we would
need to revert that part.

> [VvS: #PF allocation can hit into limit of cgroup v1 kmem controlle.
> This is a local problem related to memcg, however, it causes unnecessary
> global OOM kills that are repeated over and over again and escalate into
> a real disaster.  It was broken long time ago, most likely since
> 6a1a0d3b625a ("mm: allocate kernel pages to the right memcg").
> In upstream the problem will be fixed by removing the outdated kmem limit,
> however stable and LTS kernels cannot do it and are still affected.
> This patch fixes the problem and should be backported into stable.]
> 
> Fixes: 6a1a0d3b625a ("mm: allocate kernel pages to the right memcg")

I am not sure the sha1 is the right one but the issue is there since
kmem accounting has been introduced so it should be around that time.
Maybe do not name the specific commit but stick to something like
"This has been broken since kmem accounting has been introduced for
cgroup v1 (3.8). There was no kmem specific reclaim for the separate
limit so the only way to handle kmem hard limit was to return with
ENOMEM."

> Cc: stable@vger.kernel.org

I am still not sure this really needs a stable backport. There are no
bug reports for years so I strongly suspect people are simply not using
kmem hard limit with cgroup v1.

> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Vasily Averin <vvs@virtuozzo.com>

Btw. you should be adding your s-o-b here.

> ---
>  mm/oom_kill.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 831340e7ad8b..f98954befafb 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1120,27 +1120,24 @@ bool out_of_memory(struct oom_control *oc)
>  }
>  
>  /*
> - * The pagefault handler calls here because it is out of memory, so kill a
> - * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
> - * killing is already in progress so do nothing.
> + * The pagefault handler calls here because some allocation has failed. We have
> + * to take care of the memcg OOM here because this is the only safe context without
> + * any locks held but let the oom killer triggered from the allocation context care
> + * about the global OOM.
>   */
>  void pagefault_out_of_memory(void)
>  {
> -	struct oom_control oc = {
> -		.zonelist = NULL,
> -		.nodemask = NULL,
> -		.memcg = NULL,
> -		.gfp_mask = 0,
> -		.order = 0,
> -	};
> +	static DEFINE_RATELIMIT_STATE(pfoom_rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
>  
>  	if (mem_cgroup_oom_synchronize(true))
>  		return;
>  
> -	if (!mutex_trylock(&oom_lock))
> +	if (fatal_signal_pending(current))
>  		return;
> -	out_of_memory(&oc);
> -	mutex_unlock(&oom_lock);
> +
> +	if (__ratelimit(&pfoom_rs))
> +		pr_warn("Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF\n");
>  }
>  
>  SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
