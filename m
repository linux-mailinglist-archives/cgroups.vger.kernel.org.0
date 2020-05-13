Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2E1D1D97
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbgEMSg0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 14:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgEMSg0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 13 May 2020 14:36:26 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228C3205CB;
        Wed, 13 May 2020 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589394986;
        bh=7xeHDUO2UcI3LIaK5NObk1DiE5/xCvLjBsBS1p7mx9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bm7hCZnq6MvMYDE2z1ZIbxpKad33tP5vKMdjHPw4SfAY2IZdwQO2ZiFsRksvOUcra
         FdzsQnPJQ/LUNaBDuNiu2g6Duk/sO0OPJb7jbbCPPq0Kz+UgL0FWbnJaLBonzDNHtt
         xfKwHJmrVYuDHKh1bPlikZPPBNxURp2izCkGKy1g=
Date:   Wed, 13 May 2020 11:36:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200513113623.0659e4c4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200513083249.GS29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
        <20200511225516.2431921-4-kuba@kernel.org>
        <20200512072634.GP29153@dhcp22.suse.cz>
        <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200513083249.GS29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 13 May 2020 10:32:49 +0200 Michal Hocko wrote:
> On Tue 12-05-20 10:55:36, Jakub Kicinski wrote:
> > On Tue, 12 May 2020 09:26:34 +0200 Michal Hocko wrote:  
> > > On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:  
> > > > Use swap.high when deciding if swap is full.    
> > > 
> > > Please be more specific why.  
> > 
> > How about:
> > 
> >     Use swap.high when deciding if swap is full to influence ongoing
> >     swap reclaim in a best effort manner.  
> 
> This is still way too vague. The crux is why should we treat hard and
> high swap limit the same for mem_cgroup_swap_full purpose. Please
> note that I am not saying this is wrong. I am asking for a more
> detailed explanation mostly because I would bet that somebody
> stumbles over this sooner or later.

Stumbles in what way? Isn't it expected for the kernel to take
reasonable precautions to avoid hitting limits?  We expect the
application which breaches swap.high to get terminated by user 
space OOM, kernel best be careful about approaching that limit, 
no?

> mem_cgroup_swap_full is an odd predicate. It doesn't really want to
> tell that the swap is really full. I haven't studied the original
> intention but it is more in line of mem_cgroup_swap_under_pressure
> based on the current usage to (attempt) scale swap cache size.

Perhaps Johannes has some experience here?  The 50% means full 
heuristic predates git :(

> > > > Perform reclaim and count memory over high events.    
> > > 
> > > Please expand on this and explain how this is working and why the
> > > semantic is subtly different from MEMCG_HIGH. I suspect the reason
> > > is that there is no reclaim for the swap so you are only emitting
> > > an event on the memcg which is actually throttled. This is in
> > > line with memory.high but the difference is that we do reclaim
> > > each memcg subtree in the high limit excess. That means that the
> > > counter tells us how many times the specific memcg was in excess
> > > which would be impossible with your implementation.  
> > 
> > Right, with memory all cgroups over high get penalized with the
> > extra reclaim work. For swap we just have the delay, so the event is
> > associated with the worst offender, anything lower didn't really
> > matter.
> > 
> > But it's easy enough to change if you prefer. Otherwise I'll just
> > add this to the commit message:
> > 
> >   Count swap over high events. Note that unlike memory over high
> > events we only count them for the worst offender. This is because
> > the delay penalties for both swap and memory over high are not
> > cumulative, i.e. we use the max delay.  
> 
> Well, memory high penalty is in fact cumulative, because the reclaim
> would happen for each memcg subtree up the hierarchy. Sure the
> additional throttling is not cumulative but that is not really that
> important because the exact amount of throttling is an implementation
> detail. The swap high is an odd one here because we do not reclaim
> swap so the cumulative effect of that is 0 and there is only the
> additional throttling happening. I suspect that your current
> implementation is exposing an internal implementation to the
> userspace but considering how the current memory high event is
> documented high
>                 The number of times processes of the cgroup are
>                 throttled and routed to perform direct memory reclaim
>                 because the high memory boundary was exceeded.  For a
>                 cgroup whose memory usage is capped by the high limit
>                 rather than global memory pressure, this event's
>                 occurrences are expected.
> 
> it talks about throttling rather than excess (like max) so I am not
> really sure. I believe that it would be much better if both events
> were more explicit about counting an excess and a throttling is just
> a side effect of that situation.
> 
> I do not expect that we will have any form of the swap reclaim anytime
> soon (if ever) but I fail to see why to creat a small little trap like
> this now.

Right, let me adjust then.

> > > I would also suggest to explain or ideally even separate the swap
> > > penalty scaling logic to a seprate patch. What kind of data it is
> > > based on?  
> > 
> > It's a hard thing to get production data for since, as we mentioned
> > we don't expect the limit to be hit. It was more of a process of
> > experimentation and finding a gradual slope that "felt right"...
> > 
> > Is there a more scientific process we can follow here? We want the
> > delay to be small at first for a first few pages and then grow to
> > make sure we stop the task from going too much over high. The square
> > function works pretty well IMHO.  
> 
> If there is no data to showing this to be an improvement then I would
> just not add an additional scaling factor. Why? Mostly because once we
> have it there it would be extremely hard to change. MM is full of
> these little heuristics that are copied over because nobody dares to
> touch them. If a different scaling is really needed it can always be
> added later with some data to back that.

Oh, I misunderstood the question, you were asking about the scaling
factor.. The allocation of swap is in larger batches, according to 
my tests, example below (AR - after reclaim, swap overage changes 
after memory reclaim). 
                                    mem overage AR
     swap pages over_high AR        |    swap overage AR
 swap pages over at call.   \       |    |      . mem sleep
   mem pages over_high.  \   \      |    |     /  . swap sleep
                       v  v   v     v    v    v  v
 [   73.360533] sleep (32/10->67) [-35|13379] 0+253
 [   73.631291] sleep (32/ 3->54) [-18|13430] 0+205
 [   73.851629] sleep (32/22->35) [-20|13443] 0+133
 [   74.021396] sleep (32/ 3->60) [-29|13500] 0+230
 [   74.263355] sleep (32/28->79) [-44|13551] 0+306
 [   74.585689] sleep (32/29->91) [-17|13627] 0+355
 [   74.958675] sleep (32/27->79) [-31|13679] 0+311
 [   75.293021] sleep (32/29->86) [ -9|13750] 0+344
 [   75.654218] sleep (32/22->72) [-24|13800] 0+290
 [   75.962467] sleep (32/22->73) [-39|13865] 0+296

That's for a process slowly leaking memory. Swap gets over the high by
about 2.5x MEMCG_CHARGE_BATCH on average. Hence to keep the same slope
I was trying to scale it back.

But you make a fair point, someone more knowledgeable can add the
heuristic later if it's really needed.
