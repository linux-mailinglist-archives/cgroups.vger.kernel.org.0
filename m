Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74D264AE3
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIJROx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 13:14:53 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:2620 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgIJQfa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 12:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599755729; x=1631291729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=sMYF1yObi7M5yLm8bSdKKWnVop6J5D4MwnjeLCnWRnU=;
  b=ffTsIwi42LWAMokF2ZdV46qZ4TzTAnWMsbjotPkqjoi8jozcfBinQ1AL
   yrFn3TBe2joGVSuoIROsr/N5sG5AU3YVaC7SSBRmM2kcersKcDarKtEa5
   bqZ+LjH9alQvWqpIilfwZEwHC08JQdY7Hwd/1WfMcD9yHiULgOTRILof9
   U=;
X-IronPort-AV: E=Sophos;i="5.76,413,1592870400"; 
   d="scan'208";a="66995981"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Sep 2020 16:34:58 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 10C7D2249C5;
        Thu, 10 Sep 2020 16:34:57 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 16:34:50 +0000
From:   SeongJae Park <sjpark@amazon.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Date:   Thu, 10 Sep 2020 18:34:33 +0200
Message-ID: <20200910163433.29792-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7y0kTVU5Y6-678OW8pLF8P4n3rNoWg8CXrem-diSMXXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> On Wed, Sep 9, 2020 at 11:37 PM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On 2020-09-09T14:57:52-07:00 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> > >
> > > Use cases:
> > > ----------
> > >
> > > 1) Per-memcg uswapd:
> > >
> > > Usually applications consists of combination of latency sensitive and
> > > latency tolerant tasks. For example, tasks serving user requests vs
> > > tasks doing data backup for a database application. At the moment the
> > > kernel does not differentiate between such tasks when the application
> > > hits the memcg limits. So, potentially a latency sensitive user facing
> > > task can get stuck in high reclaim and be throttled by the kernel.
> > >
> > > Similarly there are cases of single process applications having two set
> > > of thread pools where threads from one pool have high scheduling
> > > priority and low latency requirement. One concrete example from our
> > > production is the VMM which have high priority low latency thread pool
> > > for the VCPUs while separate thread pool for stats reporting, I/O
> > > emulation, health checks and other managerial operations. The kernel
> > > memory reclaim does not differentiate between VCPU thread or a
> > > non-latency sensitive thread and a VCPU thread can get stuck in high
> > > reclaim.
> > >
> > > One way to resolve this issue is to preemptively trigger the memory
> > > reclaim from a latency tolerant task (uswapd) when the application is
> > > near the limits. Finding 'near the limits' situation is an orthogonal
> > > problem.
> > >
> > > 2) Proactive reclaim:
> > >
> > > This is a similar to the previous use-case, the difference is instead of
> > > waiting for the application to be near its limit to trigger memory
> > > reclaim, continuously pressuring the memcg to reclaim a small amount of
> > > memory. This gives more accurate and uptodate workingset estimation as
> > > the LRUs are continuously sorted and can potentially provide more
> > > deterministic memory overcommit behavior. The memory overcommit
> > > controller can provide more proactive response to the changing behavior
> > > of the running applications instead of being reactive.
> > >
> > > Benefit of user space solution:
> > > -------------------------------
> > >
> > > 1) More flexible on who should be charged for the cpu of the memory
> > > reclaim. For proactive reclaim, it makes more sense to centralized the
> > > overhead while for uswapd, it makes more sense for the application to
> > > pay for the cpu of the memory reclaim.
> > >
> > > 2) More flexible on dedicating the resources (like cpu). The memory
> > > overcommit controller can balance the cost between the cpu usage and
> > > the memory reclaimed.
> > >
> > > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > > under memory pressure better reclaim candidates are selected. This also
> > > gives more accurate and uptodate notion of working set for an
> > > application.
> > >
> > > Questions:
> > > ----------
> > >
> > > 1) Why memory.high is not enough?
> > >
> > > memory.high can be used to trigger reclaim in a memcg and can
> > > potentially be used for proactive reclaim as well as uswapd use cases.
> > > However there is a big negative in using memory.high. It can potentially
> > > introduce high reclaim stalls in the target application as the
> > > allocations from the processes or the threads of the application can hit
> > > the temporary memory.high limit.
> > >
> > > Another issue with memory.high is that it is not delegatable. To
> > > actually use this interface for uswapd, the application has to introduce
> > > another layer of cgroup on whose memory.high it has write access.
> > >
> > > 2) Why uswapd safe from self induced reclaim?
> > >
> > > This is very similar to the scenario of oomd under global memory
> > > pressure. We can use the similar mechanisms to protect uswapd from self
> > > induced reclaim i.e. memory.min and mlock.
> > >
> > > Interface options:
> > > ------------------
> > >
> > > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > > trigger reclaim in the target memory cgroup.
> > >
> > > In future we might want to reclaim specific type of memory from a memcg,
> > > so, this interface can be extended to allow that. e.g.
> > >
> > > $ echo 10M [all|anon|file|kmem] > memory.reclaim
> > >
> > > However that should be when we have concrete use-cases for such
> > > functionality. Keep things simple for now.
> > >
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
> > >  mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
> > >  2 files changed, 46 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 6be43781ec7f..58d70b5989d7 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1181,6 +1181,15 @@ PAGE_SIZE multiple when read back.
> > >       high limit is used and monitored properly, this limit's
> > >       utility is limited to providing the final safety net.
> > >
> > > +  memory.reclaim
> > > +     A write-only file which exists on non-root cgroups.
> > > +
> > > +     This is a simple interface to trigger memory reclaim in the
> > > +     target cgroup. Write the number of bytes to reclaim to this
> > > +     file and the kernel will try to reclaim that much memory.
> > > +     Please note that the kernel can over or under reclaim from
> > > +     the target cgroup.
> > > +
> > >    memory.oom.group
> > >       A read-write single value file which exists on non-root
> > >       cgroups.  The default value is "0".
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 75cd1a1e66c8..2d006c36d7f3 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6456,6 +6456,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> > >       return nbytes;
> > >  }
> > >
> > > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > > +                           size_t nbytes, loff_t off)
> > > +{
> > > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > > +     int err;
> > > +
> > > +     buf = strstrip(buf);
> > > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     while (nr_reclaimed < nr_to_reclaim) {
> > > +             unsigned long reclaimed;
> > > +
> > > +             if (signal_pending(current))
> > > +                     break;
> > > +
> > > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > +                                             nr_to_reclaim - nr_reclaimed,
> > > +                                             GFP_KERNEL, true);
> > > +
> > > +             if (!reclaimed && !nr_retries--)
> > > +                     break;
> >
> > Shouldn't the if condition use '||' instead of '&&'?
> 
> I copied the pattern from memory_high_write().
> 
> > I think it could be
> > easier to read if we put the 'nr_retires' condition in the while condition as
> > below (just my personal preference, though).
> >
> >     while (nr_reclaimed < nr_to_reclaim && nr_retires--)
> >
> 
> The semantics will be different. In my version, it means tolerate
> MAX_RECLAIM_RETRIES reclaim failures and your suggestion means total
> MAX_RECLAIM_RETRIES tries.
> 
> Please note that try_to_free_mem_cgroup_pages() internally does
> 'nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX)', so, we might need
> more than MAX_RECLAIM_RETRIES successful tries to actually reclaim the
> amount of memory the user has requested.

Thanks, understood your intention and agreed on the point.

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park
