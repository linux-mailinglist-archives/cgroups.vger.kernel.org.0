Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675BE36661B
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 09:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhDUHQw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 03:16:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234052AbhDUHQw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Apr 2021 03:16:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618989376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/t8yc2lQ3pLQ4sfUDYcnlZrhBPSE43fDoX7RlTCbrYU=;
        b=oz0tPCAnFgexhSXdu2bypRgSNPkmuFx2oBUto0IsTOm7T3MUgl/JhML9WF6kinDHrFrVOJ
        IS5PbSD5CKpAsNC4PlCXPuwL+EcVCRnxa0oA0IGADjtUOAMQAdi/ymAjuKIk/ClNmYMU/+
        v+8nf1NboN5d1MbJTAFteM/dOvHUqKo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A005AEAC;
        Wed, 21 Apr 2021 07:16:16 +0000 (UTC)
Date:   Wed, 21 Apr 2021 09:16:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
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
Message-ID: <YH/RPydqhwXdyG80@dhcp22.suse.cz>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz>
 <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 20-04-21 09:04:21, Shakeel Butt wrote:
> On Mon, Apr 19, 2021 at 11:46 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 19-04-21 18:44:02, Shakeel Butt wrote:
> [...]
> > > memory.min. However a new allocation from userspace oom-killer can
> > > still get stuck in the reclaim and policy rich oom-killer do trigger
> > > new allocations through syscalls or even heap.
> >
> > Can you be more specific please?
> >
> 
> To decide when to kill, the oom-killer has to read a lot of metrics.
> It has to open a lot of files to read them and there will definitely
> be new allocations involved in those operations. For example reading
> memory.stat does a page size allocation. Similarly, to perform action
> the oom-killer may have to read cgroup.procs file which again has
> allocation inside it.

True but many of those can be avoided by opening the file early. At
least seq_file based ones will not allocate later if the output size
doesn't increase. Which should be the case for many. I think it is a
general improvement to push those who allocate during read to an open
time allocation.

> Regarding sophisticated oom policy, I can give one example of our
> cluster level policy. For robustness, many user facing jobs run a lot
> of instances in a cluster to handle failures. Such jobs are tolerant
> to some amount of failures but they still have requirements to not let
> the number of running instances below some threshold. Normally killing
> such jobs is fine but we do want to make sure that we do not violate
> their cluster level agreement. So, the userspace oom-killer may
> dynamically need to confirm if such a job can be killed.

What kind of data do you need to examine to make those decisions?

> [...]
> > > To reliably solve this problem, we need to give guaranteed memory to
> > > the userspace oom-killer.
> >
> > There is nothing like that. Even memory reserves are a finite resource
> > which can be consumed as it is sharing those reserves with other users
> > who are not necessarily coordinated. So before we start discussing
> > making this even more muddy by handing over memory reserves to the
> > userspace we should really examine whether pre-allocation is something
> > that will not work.
> >
> 
> We actually explored if we can restrict the syscalls for the
> oom-killer which does not do memory allocations. We concluded that is
> not practical and not maintainable. Whatever the list we can come up
> with will be outdated soon. In addition, converting all the must-have
> syscalls to not do allocations is not possible/practical.

I am definitely curious to learn more.

[...]
> > > 2. Mempool
> > >
> > > The idea is to preallocate mempool with a given amount of memory for
> > > userspace oom-killer. Preferably this will be per-thread and
> > > oom-killer can preallocate mempool for its specific threads. The core
> > > page allocator can check before going to the reclaim path if the task
> > > has private access to the mempool and return page from it if yes.
> >
> > Could you elaborate some more on how this would be controlled from the
> > userspace? A dedicated syscall? A driver?
> >
> 
> I was thinking of simply prctl(SET_MEMPOOL, bytes) to assign mempool
> to a thread (not shared between threads) and prctl(RESET_MEMPOOL) to
> free the mempool.

I am not a great fan of prctl. It has become a dumping ground for all
mix of unrelated functionality. But let's say this is a minor detail at
this stage. So you are proposing to have a per mm mem pool that would be
used as a fallback for an allocation which cannot make a forward
progress, right? Would that pool be preallocated and sitting idle? What
kind of allocations would be allowed to use the pool? What if the pool
is depleted?
-- 
Michal Hocko
SUSE Labs
