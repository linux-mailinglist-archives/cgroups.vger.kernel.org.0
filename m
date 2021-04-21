Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235EF36663A
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhDUHXl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 03:23:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhDUHXk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Apr 2021 03:23:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618989786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dp1wmWCgke/XdGEWD5zHfkjSz85fgdsugbIVZroCUDQ=;
        b=OJYaL42cTzaT6k4aidF/zvvFEKpsBC2O/ZqXbkPl3IoRTDZBfNGIMNGZzKtGLCemXvKfwX
        +FQvLaLFMwqMFGhbpw3AVFG0nvk5LPhAmPZhvPqECINdfpbP4Xp/mfLBJ9XRhFH+9Clikz
        OgYnoCY12/z+efAZmQ/qQqHw6RY+hOs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 425B4B13D;
        Wed, 21 Apr 2021 07:23:06 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:23:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
Message-ID: <YH/S2dVxk2le8SMw@dhcp22.suse.cz>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH8o5iIau85FaeLw@carbon.DHCP.thefacebook.com>
 <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7dXuFPeMv5NGu96uCosFpWY_Gy07iDsfSORCA0dT_zsA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 20-04-21 18:18:29, Shakeel Butt wrote:
> On Tue, Apr 20, 2021 at 12:18 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Apr 19, 2021 at 06:44:02PM -0700, Shakeel Butt wrote:
> [...]
> > > 1. prctl(PF_MEMALLOC)
> > >
> > > The idea is to give userspace oom-killer (just one thread which is
> > > finding the appropriate victims and will be sending SIGKILLs) access
> > > to MEMALLOC reserves. Most of the time the preallocation, mlock and
> > > memory.min will be good enough but for rare occasions, when the
> > > userspace oom-killer needs to allocate, the PF_MEMALLOC flag will
> > > protect it from reclaim and let the allocation dip into the memory
> > > reserves.
> > >
> > > The misuse of this feature would be risky but it can be limited to
> > > privileged applications. Userspace oom-killer is the only appropriate
> > > user of this feature. This option is simple to implement.
> >
> > Hello Shakeel!
> >
> > If ordinary PAGE_SIZE and smaller kernel allocations start to fail,
> > the system is already in a relatively bad shape. Arguably the userspace
> > OOM killer should kick in earlier, it's already a bit too late.
> 
> Please note that these are not allocation failures but rather reclaim
> on allocations (which is very normal). Our observation is that this
> reclaim is very unpredictable and depends on the type of memory
> present on the system which depends on the workload. If there is a
> good amount of easily reclaimable memory (e.g. clean file pages), the
> reclaim would be really fast. However for other types of reclaimable
> memory the reclaim time varies a lot. The unreclaimable memory, pinned
> memory, too many direct reclaimers, too many isolated memory and many
> other things/heuristics/assumptions make the reclaim further
> non-deterministic.
> 
> In our observation the global reclaim is very non-deterministic at the
> tail and dramatically impacts the reliability of the system. We are
> looking for a solution which is independent of the global reclaim.

I believe it is worth purusing a solution that would make the memory
reclaim more predictable. I have seen direct reclaim memory throttling
in the past. For some reason which I haven't tried to examine this has
become less of a problem with newer kernels. Maybe the memory access
patterns have changed or those problems got replaced by other issues but
an excessive throttling is definitely something that we want to address
rather than work around by some user visible APIs.

> > Allowing to use reserves just pushes this even further, so we're risking
> > the kernel stability for no good reason.
> 
> Michal has suggested ALLOC_OOM which is less risky.
> 
> >
> > But I agree that throttling the oom daemon in direct reclaim makes no sense.
> > I wonder if we can introduce a per-task flag which will exclude the task from
> > throttling, but instead all (large) allocations will just fail under a
> > significant memory pressure more easily. In this case if there is a significant
> > memory shortage the oom daemon will not be fully functional (will get -ENOMEM
> > for an attempt to read some stats, for example), but still will be able to kill
> > some processes and make the forward progress.
> 
> So, the suggestion is to have a per-task flag to (1) indicate to not
> throttle and (2) fail allocations easily on significant memory
> pressure.
> 
> For (1), the challenge I see is that there are a lot of places in the
> reclaim code paths where a task can get throttled. There are
> filesystems that block/throttle in slab shrinking. Any process can get
> blocked on an unrelated page or inode writeback within reclaim.
> 
> For (2), I am not sure how to deterministically define "significant
> memory pressure". One idea is to follow the __GFP_NORETRY semantics
> and along with (1) the userspace oom-killer will see ENOMEM more
> reliably than stucking in the reclaim.

Some of the interfaces (e.g. seq_file uses GFP_KERNEL reclaim strength)
could be more relaxed and rather fail than OOM kill but wouldn't your
OOM handler be effectivelly dysfunctional when not able to collect data
to make a decision?
-- 
Michal Hocko
SUSE Labs
