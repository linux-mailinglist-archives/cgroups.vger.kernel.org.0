Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90873366355
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 03:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhDUBTR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 21:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhDUBTQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 21:19:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB968C06174A
        for <cgroups@vger.kernel.org>; Tue, 20 Apr 2021 18:18:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so24861614lfp.0
        for <cgroups@vger.kernel.org>; Tue, 20 Apr 2021 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuYkrU1zcW7Z65oSaWVLBz+0IZ221pOBrSimYNtby7s=;
        b=ndkdt3mjYlW+H/QWZc671xlRMDK4yybhmgXbvu53LBPocwBLlpjTZ783Rd2QVNzrGj
         IkSdWhxhBQo0UbqFvs6XPv6hCdPKkg3b7FMjuPdJLz2w54a+Wyfrp6CFYDZyPmDZ3IkE
         W0vUtwV0T3yekrghgmLcCS164X9lDUDwgvhq916QgiJMH6wfzNW5C5/XrLnNN1ph/GiG
         K9J+ZM292B32Iy7S2ga4b5yxthPArwSwjdGo+ryLUmzGMwC6X6Vm5f3VEnJDlzd6Fanr
         5Tu901R+Odid1zCgNaLUEr0kwh4Mm7azowTlPf+njENOsLhgr4i1ixuDJo8Jn+I4+guT
         /+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuYkrU1zcW7Z65oSaWVLBz+0IZ221pOBrSimYNtby7s=;
        b=awnUgfRo15QGm/hMz8S/fsZkGPyqOOeqg2cSX0Q/r5XX/kFvH/dFDaniG+243Lq/vM
         8U6uKU0FEbSj7/Ndb2KomC57/y49yrNRpLLSx6BLbrThJ3aVC6qvSSn+8Y3jTHiaW+Cu
         PmON+ZdP1xV3dNRsNid0fSAqerpOUw+drsA233ASfMdMb0m5pEZDn9WC3bMCs9MB4jPR
         32W7z7VPBspm7i9CXoABulgvyrQTPhGSAASo9/mGHtngQg7Gq8+kiGcLxHN7bnyT9VYF
         HoP/9lWFj1DajiDsyrAF7FAkY0F+xsEegCCPT40/wkvK7Gqr+MzEBwEkVcv6FfALyjEl
         rF/g==
X-Gm-Message-State: AOAM5333iil8QTv/IxyD8HGkf4xi8jzYVZPwAOOQuclztdfQaCtEj9rf
        SfdSSxCQkPnlNSNhB3vJbSBo7P8RKWB2mAz1CcPclQ==
X-Google-Smtp-Source: ABdhPJxpxXiVbMCgfjPsAKK51JzwZPy6+zbSmmw770y0uEFu9+qDNgQV48FCOjkzQcNHaQ2ZAMShaBbuBCdhR7VK8ec=
X-Received: by 2002:a05:6512:2037:: with SMTP id s23mr17393868lfs.358.1618967921088;
 Tue, 20 Apr 2021 18:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
In-Reply-To: <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Apr 2021 18:18:29 -0700
Message-ID: <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 20, 2021 at 12:18 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Apr 19, 2021 at 06:44:02PM -0700, Shakeel Butt wrote:
[...]
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

Please note that these are not allocation failures but rather reclaim
on allocations (which is very normal). Our observation is that this
reclaim is very unpredictable and depends on the type of memory
present on the system which depends on the workload. If there is a
good amount of easily reclaimable memory (e.g. clean file pages), the
reclaim would be really fast. However for other types of reclaimable
memory the reclaim time varies a lot. The unreclaimable memory, pinned
memory, too many direct reclaimers, too many isolated memory and many
other things/heuristics/assumptions make the reclaim further
non-deterministic.

In our observation the global reclaim is very non-deterministic at the
tail and dramatically impacts the reliability of the system. We are
looking for a solution which is independent of the global reclaim.

> Allowing to use reserves just pushes this even further, so we're risking
> the kernel stability for no good reason.

Michal has suggested ALLOC_OOM which is less risky.

>
> But I agree that throttling the oom daemon in direct reclaim makes no sense.
> I wonder if we can introduce a per-task flag which will exclude the task from
> throttling, but instead all (large) allocations will just fail under a
> significant memory pressure more easily. In this case if there is a significant
> memory shortage the oom daemon will not be fully functional (will get -ENOMEM
> for an attempt to read some stats, for example), but still will be able to kill
> some processes and make the forward progress.

So, the suggestion is to have a per-task flag to (1) indicate to not
throttle and (2) fail allocations easily on significant memory
pressure.

For (1), the challenge I see is that there are a lot of places in the
reclaim code paths where a task can get throttled. There are
filesystems that block/throttle in slab shrinking. Any process can get
blocked on an unrelated page or inode writeback within reclaim.

For (2), I am not sure how to deterministically define "significant
memory pressure". One idea is to follow the __GFP_NORETRY semantics
and along with (1) the userspace oom-killer will see ENOMEM more
reliably than stucking in the reclaim.

So, the oom-killer maintains a list of processes to kill in extreme
conditions, have their pidfds open and keep that list fresh. Whenever
any syscalls returns ENOMEM, it starts doing
pidfd_send_signal(SIGKILL) to that list of processes, right?

The idea has merit but I don't see how this is any simpler. The (1) is
challenging on its own and my main concern is that it will be very
hard to maintain as reclaim code (particularly shrinkers) callbacks
into many diverse subsystems.

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

IMHO it is not an over-kill and easier to do then to remove all
instances of potential blocking/throttling sites in memory reclaim.

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
>

Are there any examples of gathering existing metrics from bpf? Suren
has given a list of metrics useful for Android. Is it possible to
gather those metrics?

BTW thanks a lot for taking a look and I really appreciate your time.

thanks,
Shakeel
