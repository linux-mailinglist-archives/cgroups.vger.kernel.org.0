Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE31D0AE4
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgEMIcy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 04:32:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgEMIcy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 04:32:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id s8so19763674wrt.9
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 01:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+f+QilQVsu4P2ljX9LPVuTNe1NN4O3Lb8MgmL8yTK0=;
        b=SVzij7F9xTJ3BVYz9zbDMezYZDXG5aFrAasO7bSwhStqP/ixJI5qngDyixUxKJxfSi
         Zhi7qKvgWvYKb6r1Cso3ASMsBkkOfXuCNCuMghrZoxhRRVt+rjFT+9JFfWKlW5glPE1L
         XSkrZ80R//jpEwYHm5EqBiTO9vO4+0XUDWKhlPrKrghAbvGJyr299mwlVWoLHWYEZk+V
         ZuNw7aYKXpy9qXCh50YIfzfbdgMeEAdziE/pMA4LLZfwOYrz+EAzXoLAbQLJgfh6iSWC
         CVLUJoquWiIh6pCFim8M5s5dSlo82VCEkVfQRSil7SWZO0mOA7YC9oIn187QO+XgDK+U
         MAXw==
X-Gm-Message-State: AGi0PuYreR6CJVGZvW5UwTJoOIX6TUYbo3kWpk4RQaYI2ozVF/rh/faP
        ssbWA3w9KeQ7ywgPidEmrVo7yL95
X-Google-Smtp-Source: APiQypJVfFWeEyp6tW6NTr2G+1GUPOmxgeMRTrVtNz88KUKZ+6bj1jfVbKlP8yBjD5xeRn3lDBjvCQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr14136764wrn.268.1589358771802;
        Wed, 13 May 2020 01:32:51 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id m3sm10858138wrn.96.2020.05.13.01.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:32:50 -0700 (PDT)
Date:   Wed, 13 May 2020 10:32:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200513083249.GS29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-4-kuba@kernel.org>
 <20200512072634.GP29153@dhcp22.suse.cz>
 <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512105536.748da94e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 12-05-20 10:55:36, Jakub Kicinski wrote:
> On Tue, 12 May 2020 09:26:34 +0200 Michal Hocko wrote:
> > On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:
> > > Use swap.high when deciding if swap is full.  
> > 
> > Please be more specific why.
> 
> How about:
> 
>     Use swap.high when deciding if swap is full to influence ongoing
>     swap reclaim in a best effort manner.

This is still way too vague. The crux is why should we treat hard and
high swap limit the same for mem_cgroup_swap_full purpose. Please note
that I am not saying this is wrong. I am asking for a more detailed
explanation mostly because I would bet that somebody stumbles over this
sooner or later.

mem_cgroup_swap_full is an odd predicate. It doesn't really want to tell
that the swap is really full. I haven't studied the original intention
but it is more in line of mem_cgroup_swap_under_pressure based on the
current usage to (attempt) scale swap cache size.

> > > Perform reclaim and count memory over high events.  
> > 
> > Please expand on this and explain how this is working and why the
> > semantic is subtly different from MEMCG_HIGH. I suspect the reason
> > is that there is no reclaim for the swap so you are only emitting an
> > event on the memcg which is actually throttled. This is in line with
> > memory.high but the difference is that we do reclaim each memcg subtree
> > in the high limit excess. That means that the counter tells us how many
> > times the specific memcg was in excess which would be impossible with
> > your implementation.
> 
> Right, with memory all cgroups over high get penalized with the extra
> reclaim work. For swap we just have the delay, so the event is
> associated with the worst offender, anything lower didn't really matter.
> 
> But it's easy enough to change if you prefer. Otherwise I'll just add
> this to the commit message:
> 
>   Count swap over high events. Note that unlike memory over high events
>   we only count them for the worst offender. This is because the
>   delay penalties for both swap and memory over high are not cumulative,
>   i.e. we use the max delay.

Well, memory high penalty is in fact cumulative, because the reclaim
would happen for each memcg subtree up the hierarchy. Sure the
additional throttling is not cumulative but that is not really that
important because the exact amount of throttling is an implementation detail.
The swap high is an odd one here because we do not reclaim swap so the
cumulative effect of that is 0 and there is only the additional
throttling happening. I suspect that your current implementation is
exposing an internal implementation to the userspace but considering how
the current memory high event is documented
          high
                The number of times processes of the cgroup are
                throttled and routed to perform direct memory reclaim
                because the high memory boundary was exceeded.  For a
                cgroup whose memory usage is capped by the high limit
                rather than global memory pressure, this event's
                occurrences are expected.

it talks about throttling rather than excess (like max) so I am not
really sure. I believe that it would be much better if both events were
more explicit about counting an excess and a throttling is just a side
effect of that situation.

I do not expect that we will have any form of the swap reclaim anytime
soon (if ever) but I fail to see why to creat a small little trap like
this now.

> > I would also suggest to explain or ideally even separate the swap
> > penalty scaling logic to a seprate patch. What kind of data it is based
> > on?
> 
> It's a hard thing to get production data for since, as we mentioned we
> don't expect the limit to be hit. It was more of a process of
> experimentation and finding a gradual slope that "felt right"...
> 
> Is there a more scientific process we can follow here? We want the
> delay to be small at first for a first few pages and then grow to make
> sure we stop the task from going too much over high. The square
> function works pretty well IMHO.

If there is no data to showing this to be an improvement then I would
just not add an additional scaling factor. Why? Mostly because once we
have it there it would be extremely hard to change. MM is full of these
little heuristics that are copied over because nobody dares to touch
them. If a different scaling is really needed it can always be added
later with some data to back that.

-- 
Michal Hocko
SUSE Labs
