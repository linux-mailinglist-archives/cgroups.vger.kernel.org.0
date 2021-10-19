Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC962433823
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhJSOPg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 10:15:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhJSOPd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 10:15:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 858E72196D;
        Tue, 19 Oct 2021 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634652799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hh4cTDoB691a4aDWi4pwU2Luw6LUBVER2ejZ1+gX5jY=;
        b=l3MWILDG/rS2ZjOfIv675NfHLdc5hR/inlQhJEY2yiA5E8yx/b4RWSjIAObQQwai45CIVq
        bkXWzzNwzrW04hogbvcc04IU8B22ONkC+MHkajrT3q1rU7ptGwcMLPluenx/GCcaA6rMsN
        pGP2qY+LA0ONdqaaqPazDtf0qVu3nUk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5438EA3B8E;
        Tue, 19 Oct 2021 14:13:19 +0000 (UTC)
Date:   Tue, 19 Oct 2021 16:13:18 +0200
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
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
Message-ID: <YW7SfkZR/ZsabkXV@dhcp22.suse.cz>
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <339ae4b5-6efd-8fc2-33f1-2eb3aee71cb2@virtuozzo.com>
 <YW6GoZhFUJc1uLYr@dhcp22.suse.cz>
 <687bf489-f7a7-5604-25c5-0c1a09e0905b@virtuozzo.com>
 <YW6yAeAO+TeS3OdB@dhcp22.suse.cz>
 <YW60Rs1mi24sJmp4@dhcp22.suse.cz>
 <6c422150-593f-f601-8f91-914c6c5e82f4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c422150-593f-f601-8f91-914c6c5e82f4@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 19-10-21 16:26:50, Vasily Averin wrote:
> On 19.10.2021 15:04, Michal Hocko wrote:
> > On Tue 19-10-21 13:54:42, Michal Hocko wrote:
> >> On Tue 19-10-21 13:30:06, Vasily Averin wrote:
> >>> On 19.10.2021 11:49, Michal Hocko wrote:
> >>>> On Tue 19-10-21 09:30:18, Vasily Averin wrote:
> >>>> [...]
> >>>>> With my patch ("memcg: prohibit unconditional exceeding the limit of dying tasks") try_charge_memcg() can fail:
> >>>>> a) due to fatal signal
> >>>>> b) when mem_cgroup_oom -> mem_cgroup_out_of_memory -> out_of_memory() returns false (when select_bad_process() found nothing)
> >>>>>
> >>>>> To handle a) we can follow to your suggestion and skip excution of out_of_memory() in pagefault_out_of memory()
> >>>>> To handle b) we can go to retry: if mem_cgroup_oom() return OOM_FAILED.
> >>>
> >>>> How is b) possible without current being killed? Do we allow remote
> >>>> charging?
> >>>
> >>> out_of_memory for memcg_oom
> >>>  select_bad_process
> >>>   mem_cgroup_scan_tasks
> >>>    oom_evaluate_task
> >>>     oom_badness
> >>>
> >>>         /*
> >>>          * Do not even consider tasks which are explicitly marked oom
> >>>          * unkillable or have been already oom reaped or the are in
> >>>          * the middle of vfork
> >>>          */
> >>>         adj = (long)p->signal->oom_score_adj;
> >>>         if (adj == OOM_SCORE_ADJ_MIN ||
> >>>                         test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
> >>>                         in_vfork(p)) {
> >>>                 task_unlock(p);
> >>>                 return LONG_MIN;
> >>>         }
> >>>
> >>> This time we handle userspace page fault, so we cannot be kenrel thread,
> >>> and cannot be in_vfork().
> >>> However task can be marked as oom unkillable, 
> >>> i.e. have p->signal->oom_score_adj == OOM_SCORE_ADJ_MIN
> >>
> >> You are right. I am not sure there is a way out of this though. The task
> >> can only retry for ever in this case. There is nothing actionable here.
> >> We cannot kill the task and there is no other way to release the memory.
> > 
> > Btw. don't we force the charge in that case?
> 
> We should force charge for allocation from inside page fault handler,
> to prevent endless cycle in retried page faults.
> However we should not do it for allocations from task context,
> to prevent memcg-limited vmalloc-eaters from to consume all host memory.

I don't see a big difference between those two. Because the #PF could
result into the very same situation depleting all the memory by
overcharging. A different behavior just leads to a confusion and
unexpected behavior. E.g. in the past we only triggered memcg OOM killer
from the #PF path and failed the charge otherwise. That is something
different but it shows problems we haven't anticipated and had user
visible problems. See 29ef680ae7c2 ("memcg, oom: move out_of_memory back
to the charge path").

> Also I would like to return to the following hunk.
> @@ -1575,7 +1575,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * A few threads which were not waiting at mutex_lock_killable() can
>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>  	 */
> -	ret = should_force_charge() || out_of_memory(&oc);
> +	ret = task_is_dying() || out_of_memory(&oc);
>  
>  unlock:
>  	mutex_unlock(&oom_lock);
> 
> Now I think it's better to keep task_is_dying() check here.
> if task is dying, it is not necessary to push other task to free the memory.
> We broke vmalloc cycle already, so it looks like nothing should prevent us
> from returning to userspace, handle fatal signal, exit and free the memory.

That patch has to be discuss in its full length. There were other
details I have brought up AFAIU.
-- 
Michal Hocko
SUSE Labs
