Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB801BC11C
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 16:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgD1OYq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgD1OYp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 10:24:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F23C03C1AB
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 07:24:44 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ep1so10447876qvb.0
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I6AbEn76tF7ilFMynEexuwTbZLLuOZ/x0hiX+p73flg=;
        b=LwMQfy+rgLQKCygQ1YlP0dg9puBRV2xLN/oWrxUJiCVsPg1b5y6qQbvcZ0ti0N3m/N
         ZzJ4EBVhJdWgvp7VrlQuflDkFSQC8MhPc62QsPla+/ARGn6qu2cNGOoK8gJ0JSDfyTsC
         pEMUG6uhNf4TASDhGJWecX9ieWDJl6kY5lvRabRN7EvJC7/dLSZFUsqHBj1cTyGXATUO
         ma1gGPo7a4bqHUpNYsnjXCFZGC8nhtBG0+LljCvquyTMldykhz2rAurU1r1hq8uNJZn8
         gVYl3M2MXnybJXdXE7/QlG4HtzNR060TfEM/KgeaBZGca+REGSPAtXt34DfEFNR8Slay
         US7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6AbEn76tF7ilFMynEexuwTbZLLuOZ/x0hiX+p73flg=;
        b=qjwyqSP3LyccD7WeZvrTxuY6sFKMFYscZacpwNjD9ZPR+5maUbt2PMUk6qHugSzUOa
         MkHyzXVXhvpdoZhemo3sqpRkY1n3DKg6erfushfBBEjT6VFkKbshM4eLq9T40jLXj/IV
         y/xVm8O8IDG2Pq58qJ9v2rZN+lP0BVU3a8Ao0/6M8khs/s2KqfsrpLt4ky2molofhdST
         ck7yBJhJOc+lKKrtEnaAvQ8MsNu8ZyCaPFKBH0LAoe4t+MCWQc/P71Nah2GkkFzbXdR6
         lAHcQ34+DPaDH5YxbHeq7mTs2kyx061lE30APfpEsq3ih8FRatls8MpiscbCULJttxDR
         Wz4w==
X-Gm-Message-State: AGi0PubDDfSdrf4TChAQzNNFYRGcqMiewAVvLlj4bD7zZ+8v9DMECm1D
        w4cy8OcoT3lU50evglJCtkIshA==
X-Google-Smtp-Source: APiQypIcBOsXGdosTH6SMt9azxV72npB1N1wUw6BQbwyHbcz5IVJWVennaqO0kD9MTrvgemRDiOD3w==
X-Received: by 2002:a05:6214:28d:: with SMTP id l13mr29074624qvv.181.1588083883102;
        Tue, 28 Apr 2020 07:24:43 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c139sm13614680qkg.8.2020.04.28.07.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 07:24:42 -0700 (PDT)
Date:   Tue, 28 Apr 2020 10:24:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200428142432.GA78561@cmpxchg.org>
References: <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
 <20200422154318.GK30312@dhcp22.suse.cz>
 <20200422171328.GC362484@cmpxchg.org>
 <20200422184921.GB4206@dhcp22.suse.cz>
 <20200423150015.GE362484@cmpxchg.org>
 <20200424150510.GH11591@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424150510.GH11591@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 24, 2020 at 05:05:10PM +0200, Michal Hocko wrote:
> On Thu 23-04-20 11:00:15, Johannes Weiner wrote:
> > On Wed, Apr 22, 2020 at 08:49:21PM +0200, Michal Hocko wrote:
> > > On Wed 22-04-20 13:13:28, Johannes Weiner wrote:
> > > > On Wed, Apr 22, 2020 at 05:43:18PM +0200, Michal Hocko wrote:
> > > > > On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
> > > > > I am also missing some information about what the user can actually do
> > > > > about this situation and call out explicitly that the throttling is
> > > > > not going away until the swap usage is shrunk and the kernel is not
> > > > > capable of doing that on its own without a help from the userspace. This
> > > > > is really different from memory.high which has means to deal with the
> > > > > excess and shrink it down in most cases. The following would clarify it
> > > > 
> > > > I think we may be talking past each other. The user can do the same
> > > > thing as in any OOM situation: wait for the kill.
> > > 
> > > That assumes that reaching swap.high is going to converge to the OOM
> > > eventually. And that is far from the general case. There might be a
> > > lot of other reclaimable memory to reclaim and stay in the current
> > > state.
> > 
> > No, that's really the general case. And that's based on what users
> > widely experience, including us at FB. When swap is full, it's over.
> > Multiple parties have independently reached this conclusion.
> 
> But we are talking about two things. You seem to be focusing on the full
> swap (quota) while I am talking about swap.high which doesn't imply
> that the quota/full swap is going to be reached soon.

Hm, I'm not quite sure I understand. swap.high is supposed to set this
quota. It's supposed to say: the workload has now shown such an
appetite for swap that it's unlikely to survive for much longer - draw
out its death just long enough for userspace OOM handling.

Maybe this is our misunderstanding?

It certainly doesn't make much sense to set swap.high to 0 or
relatively low values. Should we add the above to the doc text?

> > Once the workload expands its set of *used* pages past memory.high, we
> > are talking about indefinite slowdowns / OOM situations. Because at
> > that point, reclaim cannot push the workload back and everything will
> > be okay: the pages it takes off mean refaults and continued reclaim,
> > i.e. throttling. You get slowed down either way, and whether you
> > reclaim or sleep() is - to the workload - an accounting difference.
> >
> > Reclaim does NOT have the power to help the workload get better. It
> > can only do amputations to protect the rest of the system, but it
> > cannot reduce the number of pages the workload is trying to access.
> 
> Yes I do agree with you here and I believe this scenario wasn't really
> what the dispute is about. As soon as the real working set doesn't
> fit into the high limit and still growing then you are effectively
> OOM and either you do handle that from the userspace or you have to
> waaaaaaaaait for the kernel oom killer to trigger.
> 
> But I believe this scenario is much easier to understand because the
> memory consumption is growing. What I find largely unintuitive from the
> user POV is that the throttling will remain in place without a userspace
> intervention even when there is no runaway.
> 
> Let me give you an example. Say you have a peak load which pushes
> out a large part of an idle memory to swap. So much it fills up the
> swap.high. The peak eventually finishes freeing up its resources.  The
> swap situation remains the same because that memory is not refaulted and
> we do not pro-actively swap in memory (aka reclaim the swap space). You
> are left with throttling even though the overall memcg consumption is
> really low. Kernel is currently not able to do anything about that
> and the userspace would need to be aware of the situation to fault in
> swapped out memory back to get a normal behavior. Do you think this
> is something so obvious that people would keep it in mind when using
> swap.high?

Okay, thanks for clarifying, I understand your concern now.

This is not a scenario that swap.high is supposed to handle. It should
*not* be set to an amount of memory that the workload can reasonably
have sitting around idle. For example, if your memory allowance is
10G, it doesn't make sense to have swap.high at 200M or something.

It should be set to "we don't expect healthy workloads to get here".

And now I also understand what you mean by being different to
memory.high. memory.high is definitely *expected* to get hit because
of the cache trimming usecase. We just don't expect the *throttling*
part to get into play unless the workload is truly unhealthy. But I
can see how user expectations toward swap.high could be different.

> Anyway, it seems that we are not making progress here. As I've said I
> believe that swap.high might lead to a surprising behavior and therefore
> I would appreciate more clarity in the documentation. If you see a
> problem with that for some reason then I can live with that. This is not
> a reason to nack.

No, I agree we should document this. How about the following?

  memory.swap.high
       A read-write single value file which exists on non-root
       cgroups.  The default is "max".

       Swap usage throttle limit.  If a cgroup's swap usage exceeds
       this limit, all its further allocations will be throttled to
       allow userspace to implement custom out-of-memory procedures.

       This limit marks a point of no return for the cgroup. It is NOT
       designed to manage the amount of swapping a workload does
       during regular operation. Compare to memory.swap.max, which
       prohibits swapping past a set amount, but lets the cgroup
       continue unimpeded as long as other memory can be reclaimed.
