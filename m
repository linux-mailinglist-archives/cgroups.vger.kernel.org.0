Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75B40DA64
	for <lists+cgroups@lfdr.de>; Thu, 16 Sep 2021 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhIPM4l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 08:56:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhIPM4i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 08:56:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C6243223B2;
        Thu, 16 Sep 2021 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631796916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYKdelj+oFdcGiCk7kkpLhRtmRMrCPTuav2tsbzxk2I=;
        b=KuXbdw1R6U5OZ1VB91ytgygjZKYdim02RcG/E9ysdYmbDYVdtm+BLQR6EOm1JijaW6bqp5
        VYWG/HMeLaba6LEIsa070rq5hAPvKHP7Ur4D/Ch7UWYJkgQsuR6QLpz70or3nCcbPMVt5w
        2qrZQ8GndjNeBADjF4PfcwPem4d2STk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57144A3B90;
        Thu, 16 Sep 2021 12:55:16 +0000 (UTC)
Date:   Thu, 16 Sep 2021 14:55:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg v2] memcg: prohibit unconditional exceeding the
 limit of dying tasks
Message-ID: <YUM+saaJEce0TJyF@dhcp22.suse.cz>
References: <bab6c1d2-38d8-9098-206f-54894f9871b6@virtuozzo.com>
 <817a6ce2-4da9-72ac-c5b9-edd398d28a15@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817a6ce2-4da9-72ac-c5b9-edd398d28a15@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-09-21 13:10:04, Vasily Averin wrote:
> The kernel currently allows dying tasks to exceed the memcg limits.
> The allocation is expected to be the last one and the occupied memory
> will be freed soon.
>
> This is not always true because it can be part of the huge vmalloc
> allocation. Allowed once, they will repeat over and over again.
> Moreover lifetime of the allocated object can differ from the lifetime
> of the dying task.
> Multiple such allocations running concurrently can not only overuse
> the memcg limit, but can lead to a global out of memory and,
> in the worst case, cause the host to panic.
> 
> This patch removes checks forced exceed of the memcg limit for dying
> tasks. Also it breaks endless loop for tasks bypassed by the oom killer.
> In addition, it renames should_force_charge() helper to task_is_dying()
> because now its use do not lead to the forced charge.

I would rephrase the changelog as follows to give a broader picture.
"
Memory cgroup charging allows killed or exiting tasks to exceed the hard
limit. It is assumed that the amount of the memory charged by those
tasks is bound and most of the memory will get released while the task
is exiting. This is resembling a heuristic for the global OOM situation
when tasks get access to memory reserves. There is no global memory
shortage at the memcg level so the memcg heuristic is more relieved.

The above assumption is overly optimistic though. E.g. vmalloc can scale
to really large requests and the heuristic would allow that. We used to
have an early break in the vmalloc allocator for killed tasks but this
has been reverted by b8c8a338f75e (Revert "vmalloc: back off when the
current task is killed"). There are likely other similar code paths
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
"
feel free to use parts or whole of it.
 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/memcontrol.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 389b5766e74f..707f6640edda 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -234,7 +234,7 @@ enum res_type {
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -static inline bool should_force_charge(void)
> +static inline bool task_is_dying(void)
>  {
>  	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
>  		(current->flags & PF_EXITING);
> @@ -1607,7 +1607,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * A few threads which were not waiting at mutex_lock_killable() can
>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>  	 */
> -	ret = should_force_charge() || out_of_memory(&oc);
> +	ret = task_is_dying() || out_of_memory(&oc);

task_is_dying check will prevent the oom killer for dying tasks. There
is an additional bail out at out_of_memory layer. These checks are now
leading to a completely different behavior. Currently we simply use
"unlimited" reserves and therefore we do not have to kill any task. Now
the charge fails without using all reclaim measures. So I believe we
should drop those checks for memcg oom paths. I have to think about this
some more because I might be missing some other side effects.
-- 
Michal Hocko
SUSE Labs
