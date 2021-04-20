Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D31366042
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 21:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhDTThk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTThj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 15:37:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126EC06174A
        for <cgroups@vger.kernel.org>; Tue, 20 Apr 2021 12:37:05 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v3so42023791ybi.1
        for <cgroups@vger.kernel.org>; Tue, 20 Apr 2021 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzjYTJVYGK1cUYkBfmKqZ45DGnjAWx/7ND0PEQ2w/K8=;
        b=GXKxY0AvNG2k78o1KudjUBrSM82uqefXrpum6p/8y5k2c+FLa1pwBlahcJ1dZdwcUx
         L0lSRS5XlyQCPUEbQT26fLNqS9RaEw/tm37CwYA/5raBP1MnfEXAFz2nfs+GFS+gHGz9
         vEMzxYKLAj311WmpK45+Mg9v7BgAiYRKthc8fMdkoxPCPU0QFUme6VVFLJgiRJjqyTJW
         MbqaKG8k7BOM45gPxl10nrl7UGatbd0uvX8a4lT5yKksuz9CvSZQ3tlkPQwkHJjRFZVd
         5wVaEpjxISkFFydI5ljxrOv9lKzhuC8x/bcPM71v57ysdANsstnes+f3a9SY9lecmLCf
         nhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzjYTJVYGK1cUYkBfmKqZ45DGnjAWx/7ND0PEQ2w/K8=;
        b=gMLtrNopDxvJ2OHhPIvXPmr9fyMX60eyS+Dv+xEPCIy+gxp5ZlwGPtTvKzXT8FwIuB
         jITBquWTqwq4Imx8hWCEuEEI4lYRbqG7ZocYXw8T+2SU9G4butGxHoX0jtHdVR1j7Mk0
         py/wdxnPTGH/ISGGuKrB2amW/qQVtPaDzABsqOac1FRO5c9CTQlPTw7xxaowkOo5BWJM
         KOGOC4EZhzS6ELAO8661v7hOivcCX/HHWEIuPAkqrcp4k8wTGVtsM2uQKmfzn+PwdXT8
         35emSEDP86DNIxesPs+JMYOnTA1AL9VsokS8xHcQorX4EuILdvKkO/ZN/eavP+1hIoK3
         gacQ==
X-Gm-Message-State: AOAM533GZ9fVBWUU1jqlMXmdyKIdxL24fjSwMOjW1drI9Ot8wsc5T0WL
        Fwet6Q2DzJBg8XAmvtp2LCeROWrjOmKztMkxtUxVhA==
X-Google-Smtp-Source: ABdhPJy7JZrzNPVHBSzUCtqNpNPEaLdEsKlzmcj/jpMQ5bVhImpdmkc9pm6SgT0A7tsq8nad3v3phmCEW6braBpcTbU=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr27168111ybq.190.1618947424907;
 Tue, 20 Apr 2021 12:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
In-Reply-To: <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 20 Apr 2021 12:36:54 -0700
Message-ID: <CAJuCfpGWdghXpSr9OaoWEdXwLq_qES=Pxg9BojqJ2N+Wx9NwFQ@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Folks,

On Tue, Apr 20, 2021 at 12:18 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Apr 19, 2021 at 06:44:02PM -0700, Shakeel Butt wrote:
> > Proposal: Provide memory guarantees to userspace oom-killer.
> >
> > Background:
> >
> > Issues with kernel oom-killer:
> > 1. Very conservative and prefer to reclaim. Applications can suffer
> > for a long time.
> > 2. Borrows the context of the allocator which can be resource limited
> > (low sched priority or limited CPU quota).
> > 3. Serialized by global lock.
> > 4. Very simplistic oom victim selection policy.
> >
> > These issues are resolved through userspace oom-killer by:
> > 1. Ability to monitor arbitrary metrics (PSI, vmstat, memcg stats) to
> > early detect suffering.
> > 2. Independent process context which can be given dedicated CPU quota
> > and high scheduling priority.
> > 3. Can be more aggressive as required.
> > 4. Can implement sophisticated business logic/policies.
> >
> > Android's LMKD and Facebook's oomd are the prime examples of userspace
> > oom-killers. One of the biggest challenges for userspace oom-killers
> > is to potentially function under intense memory pressure and are prone
> > to getting stuck in memory reclaim themselves. Current userspace
> > oom-killers aim to avoid this situation by preallocating user memory
> > and protecting themselves from global reclaim by either mlocking or
> > memory.min. However a new allocation from userspace oom-killer can
> > still get stuck in the reclaim and policy rich oom-killer do trigger
> > new allocations through syscalls or even heap.
> >
> > Our attempt of userspace oom-killer faces similar challenges.
> > Particularly at the tail on the very highly utilized machines we have
> > observed userspace oom-killer spectacularly failing in many possible
> > ways in the direct reclaim. We have seen oom-killer stuck in direct
> > reclaim throttling, stuck in reclaim and allocations from interrupts
> > keep stealing reclaimed memory. We have even observed systems where
> > all the processes were stuck in throttle_direct_reclaim() and only
> > kswapd was running and the interrupts kept stealing the memory
> > reclaimed by kswapd.
> >
> > To reliably solve this problem, we need to give guaranteed memory to
> > the userspace oom-killer. At the moment we are contemplating between
> > the following options and I would like to get some feedback.
> >
> > 1. prctl(PF_MEMALLOC)
> >
> > The idea is to give userspace oom-killer (just one thread which is
> > finding the appropriate victims and will be sending SIGKILLs) access
> > to MEMALLOC reserves. Most of the time the preallocation, mlock and
> > memory.min will be good enough but for rare occasions, when the
> > userspace oom-killer needs to allocate, the PF_MEMALLOC flag will
> > protect it from reclaim and let the allocation dip into the memory
> > reserves.
> >
> > The misuse of this feature would be risky but it can be limited to
> > privileged applications. Userspace oom-killer is the only appropriate
> > user of this feature. This option is simple to implement.
>
> Hello Shakeel!
>
> If ordinary PAGE_SIZE and smaller kernel allocations start to fail,
> the system is already in a relatively bad shape. Arguably the userspace
> OOM killer should kick in earlier, it's already a bit too late.

I tend to agree here. This is how we are trying to avoid issues with
such severe memory shortages - by tuning the killer a bit more
aggressively. But a more reliable mechanism would definitely be an
improvement.

> Allowing to use reserves just pushes this even further, so we're risking
> the kernel stability for no good reason.
>
> But I agree that throttling the oom daemon in direct reclaim makes no sense.
> I wonder if we can introduce a per-task flag which will exclude the task from
> throttling, but instead all (large) allocations will just fail under a
> significant memory pressure more easily. In this case if there is a significant
> memory shortage the oom daemon will not be fully functional (will get -ENOMEM
> for an attempt to read some stats, for example), but still will be able to kill
> some processes and make the forward progress.

This sounds like a good idea to me.

> But maybe it can be done in userspace too: by splitting the daemon into
> a core- and extended part and avoid doing anything behind bare minimum
> in the core part.
>
> >
> > 2. Mempool
> >
> > The idea is to preallocate mempool with a given amount of memory for
> > userspace oom-killer. Preferably this will be per-thread and
> > oom-killer can preallocate mempool for its specific threads. The core
> > page allocator can check before going to the reclaim path if the task
> > has private access to the mempool and return page from it if yes.
> >
> > This option would be more complicated than the previous option as the
> > lifecycle of the page from the mempool would be more sophisticated.
> > Additionally the current mempool does not handle higher order pages
> > and we might need to extend it to allow such allocations. Though this
> > feature might have more use-cases and it would be less risky than the
> > previous option.
>
> It looks like an over-kill for the oom daemon protection, but if there
> are other good use cases, maybe it's a good feature to have.
>
> >
> > Another idea I had was to use kthread based oom-killer and provide the
> > policies through eBPF program. Though I am not sure how to make it
> > monitor arbitrary metrics and if that can be done without any
> > allocations.
>
> To start this effort it would be nice to understand what metrics various
> oom daemons use and how easy is to gather them from the bpf side. I like
> this idea long-term, but not sure if it has been settled down enough.
> I imagine it will require a fair amount of work on the bpf side, so we
> need a good understanding of features we need.

For a reference, on Android, where we do not really use memcgs,
low-memory-killer reads global data from meminfo, vmstat, zoneinfo
procfs nodes.
Thanks,
Suren.

>
> Thanks!
