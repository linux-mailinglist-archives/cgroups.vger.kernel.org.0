Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB50264960
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgIJQL2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgIJQKd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 12:10:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035E4C061757
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 09:10:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so3903423lfr.4
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQgWv8tP/mIsTIaHVB2pZNWYND0t5P9IhVZh51psRFQ=;
        b=v4rilgN8QHJIugdS3zS0eNDdG0npIlrnqrIbjqTj/ttxLW42RtR+GzpuyFpCHQWt5D
         uyEUfNGcSMoqzxO1I+k+YF8A8HDx/L4R+QXilCE4oLNqZHx7Vd9y3zDfmRsTRPc2fFqg
         YEGBEfpU03XmHqkWmMvgsVatFOtQaatdc9jKQS9BbxxenINMx2NLxDvculChxaEUeNXg
         3I1Mur4xaujZQzLrOsFwxMA3B0p+UgmXqs1coDdaO7ZAEL4xJ/aSVmKOQbHsZpkEReeI
         mx3Or9pu5gtiTmey8HgXRd7MNtBiOIkZ8N+kQB6UnYoy5vTvI5PdOvHDKPCFPal0lbUP
         aNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQgWv8tP/mIsTIaHVB2pZNWYND0t5P9IhVZh51psRFQ=;
        b=ihqTLXWjUa6OxSXaUYarIRcx8axrpMe1q3RFLQGwqpUdC4afb5SE7i7icBOfbY3dF+
         em2nICZMjDNojTN7joS1LSKmRUbsZFFodzBeUWQGG905vFP/MhhkC5DdxhfxY2P2+XNZ
         8tfb0dv37nnPs1Mi4gtNxH6bbgfPphvNywo3/+w1pePiYWjoYbGEhGUMaMlk3C3sm27S
         jt4AxLdz1EJx8mjBFrHhdyqXNkb76EAg8tVsQwjKT1Ms4UaQGvDMdwqs4go8aqbaXdCk
         bV1J4WuDY6O+N1sYuaJ8k3ytdQUxlGlwsYEFPe46ZbvAyPJ3voMi59/Iuj1j5SLzYDe9
         Ahbw==
X-Gm-Message-State: AOAM532EAhytNQWe+G5JTB2R9f6TyyTwIs7ckC3ZXD80cIEviXGVnIGX
        RUy0K/H2T0juz8NbsVI9bGfUkbruOATfo/vrPM8HOg==
X-Google-Smtp-Source: ABdhPJzijWg3vU9ZGbZG+XZJK8d4PmQ5H9p4dDg/+jvyg8Egp0XxgKSmR90qRecpk+XJ1GkepMOB+U2QDWHZbX3NBAA=
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr4615627lff.125.1599754229862;
 Thu, 10 Sep 2020 09:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200910063656.25038-1-sjpark@amazon.com>
In-Reply-To: <20200910063656.25038-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Sep 2020 09:10:18 -0700
Message-ID: <CALvZod7y0kTVU5Y6-678OW8pLF8P4n3rNoWg8CXrem-diSMXXQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 9, 2020 at 11:37 PM SeongJae Park <sjpark@amazon.com> wrote:
>
> On 2020-09-09T14:57:52-07:00 Shakeel Butt <shakeelb@google.com> wrote:
>
> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> >
> > Use cases:
> > ----------
> >
> > 1) Per-memcg uswapd:
> >
> > Usually applications consists of combination of latency sensitive and
> > latency tolerant tasks. For example, tasks serving user requests vs
> > tasks doing data backup for a database application. At the moment the
> > kernel does not differentiate between such tasks when the application
> > hits the memcg limits. So, potentially a latency sensitive user facing
> > task can get stuck in high reclaim and be throttled by the kernel.
> >
> > Similarly there are cases of single process applications having two set
> > of thread pools where threads from one pool have high scheduling
> > priority and low latency requirement. One concrete example from our
> > production is the VMM which have high priority low latency thread pool
> > for the VCPUs while separate thread pool for stats reporting, I/O
> > emulation, health checks and other managerial operations. The kernel
> > memory reclaim does not differentiate between VCPU thread or a
> > non-latency sensitive thread and a VCPU thread can get stuck in high
> > reclaim.
> >
> > One way to resolve this issue is to preemptively trigger the memory
> > reclaim from a latency tolerant task (uswapd) when the application is
> > near the limits. Finding 'near the limits' situation is an orthogonal
> > problem.
> >
> > 2) Proactive reclaim:
> >
> > This is a similar to the previous use-case, the difference is instead of
> > waiting for the application to be near its limit to trigger memory
> > reclaim, continuously pressuring the memcg to reclaim a small amount of
> > memory. This gives more accurate and uptodate workingset estimation as
> > the LRUs are continuously sorted and can potentially provide more
> > deterministic memory overcommit behavior. The memory overcommit
> > controller can provide more proactive response to the changing behavior
> > of the running applications instead of being reactive.
> >
> > Benefit of user space solution:
> > -------------------------------
> >
> > 1) More flexible on who should be charged for the cpu of the memory
> > reclaim. For proactive reclaim, it makes more sense to centralized the
> > overhead while for uswapd, it makes more sense for the application to
> > pay for the cpu of the memory reclaim.
> >
> > 2) More flexible on dedicating the resources (like cpu). The memory
> > overcommit controller can balance the cost between the cpu usage and
> > the memory reclaimed.
> >
> > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > under memory pressure better reclaim candidates are selected. This also
> > gives more accurate and uptodate notion of working set for an
> > application.
> >
> > Questions:
> > ----------
> >
> > 1) Why memory.high is not enough?
> >
> > memory.high can be used to trigger reclaim in a memcg and can
> > potentially be used for proactive reclaim as well as uswapd use cases.
> > However there is a big negative in using memory.high. It can potentially
> > introduce high reclaim stalls in the target application as the
> > allocations from the processes or the threads of the application can hit
> > the temporary memory.high limit.
> >
> > Another issue with memory.high is that it is not delegatable. To
> > actually use this interface for uswapd, the application has to introduce
> > another layer of cgroup on whose memory.high it has write access.
> >
> > 2) Why uswapd safe from self induced reclaim?
> >
> > This is very similar to the scenario of oomd under global memory
> > pressure. We can use the similar mechanisms to protect uswapd from self
> > induced reclaim i.e. memory.min and mlock.
> >
> > Interface options:
> > ------------------
> >
> > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > trigger reclaim in the target memory cgroup.
> >
> > In future we might want to reclaim specific type of memory from a memcg,
> > so, this interface can be extended to allow that. e.g.
> >
> > $ echo 10M [all|anon|file|kmem] > memory.reclaim
> >
> > However that should be when we have concrete use-cases for such
> > functionality. Keep things simple for now.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
> >  mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 6be43781ec7f..58d70b5989d7 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1181,6 +1181,15 @@ PAGE_SIZE multiple when read back.
> >       high limit is used and monitored properly, this limit's
> >       utility is limited to providing the final safety net.
> >
> > +  memory.reclaim
> > +     A write-only file which exists on non-root cgroups.
> > +
> > +     This is a simple interface to trigger memory reclaim in the
> > +     target cgroup. Write the number of bytes to reclaim to this
> > +     file and the kernel will try to reclaim that much memory.
> > +     Please note that the kernel can over or under reclaim from
> > +     the target cgroup.
> > +
> >    memory.oom.group
> >       A read-write single value file which exists on non-root
> >       cgroups.  The default value is "0".
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 75cd1a1e66c8..2d006c36d7f3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6456,6 +6456,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> >       return nbytes;
> >  }
> >
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +                           size_t nbytes, loff_t off)
> > +{
> > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +     int err;
> > +
> > +     buf = strstrip(buf);
> > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > +     if (err)
> > +             return err;
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     break;
> > +
> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                             nr_to_reclaim - nr_reclaimed,
> > +                                             GFP_KERNEL, true);
> > +
> > +             if (!reclaimed && !nr_retries--)
> > +                     break;
>
> Shouldn't the if condition use '||' instead of '&&'?

I copied the pattern from memory_high_write().

> I think it could be
> easier to read if we put the 'nr_retires' condition in the while condition as
> below (just my personal preference, though).
>
>     while (nr_reclaimed < nr_to_reclaim && nr_retires--)
>

The semantics will be different. In my version, it means tolerate
MAX_RECLAIM_RETRIES reclaim failures and your suggestion means total
MAX_RECLAIM_RETRIES tries.

Please note that try_to_free_mem_cgroup_pages() internally does
'nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX)', so, we might need
more than MAX_RECLAIM_RETRIES successful tries to actually reclaim the
amount of memory the user has requested.

>
> Thanks,
> SeongJae Park
