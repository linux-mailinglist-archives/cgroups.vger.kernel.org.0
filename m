Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11351BD8D5
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD2JzP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 05:55:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37277 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2JzP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 05:55:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so1743498wrx.4
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 02:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sg8Tz6tQxMDdS54hQV9uwBugxcS97FS4fYId4HAYn2c=;
        b=svd4GjeeRWCuLA60mOTOAF6GyJjmIIuBF6sQSZPFRz+O1WBKyxNuLwzvpii4mMFgTF
         dZgKc98MjXe5/5mNSsYle5MUvWBK+/k4dT0egn3zWrZJKtH4f41dkcgZguaEQ/RDn/0O
         /AV1tpIiwNU/VlZshRoxQ68npDKr6y5Sri+bpMsgIapnOMYKMvkDhV1TQi4/ggKRHtnM
         SNQE3+W1gG6Nqr3v4JWVDcn6998qefjHRHBtnK8xAGJWkvGl0RrMeH+VT8Ub4b00RSaS
         VOptpQ8ajPGN5pi8enLcO6vcHSFj70MxA6uFbVKNfConGL5B6WwMNwzFgEHPtxG++xYU
         X7QA==
X-Gm-Message-State: AGi0Puahh2Mnq0AUQJdWiqOEuaFqkHOYjdQXWL+553hY9La1wdXHvcdI
        IIjxFvHBjkq5IqMZ8sLdj94=
X-Google-Smtp-Source: APiQypKn+ILf+UUtQl2ut294MFU9C1akyxpvKsPzuEiQEuLBpHwv6HN74LhEBV7dyQl72ToCvYMguw==
X-Received: by 2002:a5d:6582:: with SMTP id q2mr38537095wru.343.1588154111913;
        Wed, 29 Apr 2020 02:55:11 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id 91sm31607381wra.37.2020.04.29.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:55:11 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:55:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200429095509.GY28637@dhcp22.suse.cz>
References: <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
 <20200422154318.GK30312@dhcp22.suse.cz>
 <20200422171328.GC362484@cmpxchg.org>
 <20200422184921.GB4206@dhcp22.suse.cz>
 <20200423150015.GE362484@cmpxchg.org>
 <20200424150510.GH11591@dhcp22.suse.cz>
 <20200428142432.GA78561@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428142432.GA78561@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-04-20 10:24:32, Johannes Weiner wrote:
> On Fri, Apr 24, 2020 at 05:05:10PM +0200, Michal Hocko wrote:
> > On Thu 23-04-20 11:00:15, Johannes Weiner wrote:
> > > On Wed, Apr 22, 2020 at 08:49:21PM +0200, Michal Hocko wrote:
> > > > On Wed 22-04-20 13:13:28, Johannes Weiner wrote:
> > > > > On Wed, Apr 22, 2020 at 05:43:18PM +0200, Michal Hocko wrote:
> > > > > > On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
> > > > > > I am also missing some information about what the user can actually do
> > > > > > about this situation and call out explicitly that the throttling is
> > > > > > not going away until the swap usage is shrunk and the kernel is not
> > > > > > capable of doing that on its own without a help from the userspace. This
> > > > > > is really different from memory.high which has means to deal with the
> > > > > > excess and shrink it down in most cases. The following would clarify it
> > > > > 
> > > > > I think we may be talking past each other. The user can do the same
> > > > > thing as in any OOM situation: wait for the kill.
> > > > 
> > > > That assumes that reaching swap.high is going to converge to the OOM
> > > > eventually. And that is far from the general case. There might be a
> > > > lot of other reclaimable memory to reclaim and stay in the current
> > > > state.
> > > 
> > > No, that's really the general case. And that's based on what users
> > > widely experience, including us at FB. When swap is full, it's over.
> > > Multiple parties have independently reached this conclusion.
> > 
> > But we are talking about two things. You seem to be focusing on the full
> > swap (quota) while I am talking about swap.high which doesn't imply
> > that the quota/full swap is going to be reached soon.
> 
> Hm, I'm not quite sure I understand. swap.high is supposed to set this
> quota. It's supposed to say: the workload has now shown such an
> appetite for swap that it's unlikely to survive for much longer - draw
> out its death just long enough for userspace OOM handling.
> 
> Maybe this is our misunderstanding?

Probably. We already have a quota for swap (swap.max). Workload is not
allowed to swap out when the quota is reached. swap.high is supposed to
act as a preliminary action towards slowing down swap consumption beyond
its limit.

> It certainly doesn't make much sense to set swap.high to 0 or
> relatively low values. Should we add the above to the doc text?
> 
> > > Once the workload expands its set of *used* pages past memory.high, we
> > > are talking about indefinite slowdowns / OOM situations. Because at
> > > that point, reclaim cannot push the workload back and everything will
> > > be okay: the pages it takes off mean refaults and continued reclaim,
> > > i.e. throttling. You get slowed down either way, and whether you
> > > reclaim or sleep() is - to the workload - an accounting difference.
> > >
> > > Reclaim does NOT have the power to help the workload get better. It
> > > can only do amputations to protect the rest of the system, but it
> > > cannot reduce the number of pages the workload is trying to access.
> > 
> > Yes I do agree with you here and I believe this scenario wasn't really
> > what the dispute is about. As soon as the real working set doesn't
> > fit into the high limit and still growing then you are effectively
> > OOM and either you do handle that from the userspace or you have to
> > waaaaaaaaait for the kernel oom killer to trigger.
> > 
> > But I believe this scenario is much easier to understand because the
> > memory consumption is growing. What I find largely unintuitive from the
> > user POV is that the throttling will remain in place without a userspace
> > intervention even when there is no runaway.
> > 
> > Let me give you an example. Say you have a peak load which pushes
> > out a large part of an idle memory to swap. So much it fills up the
> > swap.high. The peak eventually finishes freeing up its resources.  The
> > swap situation remains the same because that memory is not refaulted and
> > we do not pro-actively swap in memory (aka reclaim the swap space). You
> > are left with throttling even though the overall memcg consumption is
> > really low. Kernel is currently not able to do anything about that
> > and the userspace would need to be aware of the situation to fault in
> > swapped out memory back to get a normal behavior. Do you think this
> > is something so obvious that people would keep it in mind when using
> > swap.high?
> 
> Okay, thanks for clarifying, I understand your concern now.

Great that we are on the same page!

[...]

> No, I agree we should document this. How about the following?
> 
>   memory.swap.high
>        A read-write single value file which exists on non-root
>        cgroups.  The default is "max".
> 
>        Swap usage throttle limit.  If a cgroup's swap usage exceeds
>        this limit, all its further allocations will be throttled to
>        allow userspace to implement custom out-of-memory procedures.
> 
>        This limit marks a point of no return for the cgroup. It is NOT
>        designed to manage the amount of swapping a workload does
>        during regular operation. Compare to memory.swap.max, which
>        prohibits swapping past a set amount, but lets the cgroup
>        continue unimpeded as long as other memory can be reclaimed.

OK, this makes the intented use much more clear. I believe that it would
be helpful to also add your note that the value should be set to "we
don't expect healthy workloads to get here".

The usecase is quite narrow and I expect people will start asking about
something to help to manage the swap space somehow and this will not be
a good fit. This would require much more work to achieve a sane semantic
though. I am not aware of usacases at this moment so this is really hard
to argue about. I hope this will not backfire when we reach that point
though.

That being said, I am not a huge fan of the new interface but I can see
how it can be useful. I will not ack the patchset but I will not block
it either.

Thanks for refining the documentation and please make sure that
changelogs in the next version describe the intented usecase as
mentioned in this email thread.
-- 
Michal Hocko
SUSE Labs
