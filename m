Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16E129B94
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbfEXP7T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 11:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389385AbfEXP7T (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 May 2019 11:59:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8C84F9E7B;
        Fri, 24 May 2019 15:59:09 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-116-199.phx2.redhat.com [10.3.116.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5026917CCB;
        Fri, 24 May 2019 15:59:06 +0000 (UTC)
Date:   Fri, 24 May 2019 11:59:04 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ben Segall <bsegall@google.com>
Subject: Re: [PATCH v2 1/1] sched/fair: Fix low cpu usage with high
 throttling by removing expiration of cpu-local slices
Message-ID: <20190524155904.GE4684@lorien.usersys.redhat.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-2-git-send-email-chiluk+linux@indeed.com>
 <CAFTs51W0KdK4nw6wydn2HjNYvFRC8DYMmVeKX9FAe+4YUGEAZg@mail.gmail.com>
 <20190524143204.GB4684@lorien.usersys.redhat.com>
 <CAC=E7cXxsyMLw1PR+8QchTH8FYL7WX6_8LBVdqueR1yjW+VVkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=E7cXxsyMLw1PR+8QchTH8FYL7WX6_8LBVdqueR1yjW+VVkQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 24 May 2019 15:59:18 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 24, 2019 at 10:14:36AM -0500 Dave Chiluk wrote:
> On Fri, May 24, 2019 at 9:32 AM Phil Auld <pauld@redhat.com> wrote:
> > On Thu, May 23, 2019 at 02:01:58PM -0700 Peter Oskolkov wrote:
> 
> > > If the machine runs at/close to capacity, won't the overallocation
> > > of the quota to bursty tasks necessarily negatively impact every other
> > > task? Should the "unused" quota be available only on idle CPUs?
> > > (Or maybe this is the behavior achieved here, and only the comment and
> > > the commit message should be fixed...)
> > >
> >
> > It's bounded by the amount left unused from the previous period. So
> > theoretically a process could use almost twice its quota. But then it
> > would have nothing left over in the next period. To repeat it would have
> > to not use any that next period. Over a longer number of periods it's the
> > same amount of CPU usage.
> >
> > I think that is more fair than throttling a process that has never used
> > its full quota.
> >
> > And it removes complexity.
> >
> > Cheers,
> > Phil
> 
> Actually it's not even that bad.  The overallocation of quota to a
> bursty task in a period is limited to at most one slice per cpu, and
> that slice must not have been used in the previous periods.  The slice
> size is set with /proc/sys/kernel/sched_cfs_bandwidth_slice_us and
> defaults to 5ms.  If a bursty task goes from underutilizing quota to
> using it's entire quota, it will not be able to burst in the
> subsequent periods.  Therefore in an absolute worst case contrived
> scenario, a bursty task can add at most 5ms to the latency of other
> threads on the same CPU.  I think this worst case 5ms tradeoff is
> entirely worth it.
> 
> This does mean that a theoretically a poorly written massively
> threaded application on an 80 core box, that spreads itself onto 80
> cpu run queues, can overutilize it's quota in a period by at most 5ms
> * 80 CPUs in a sincle period (slice * number of runqueues the
> application is running on).  But that means that each of those threads
>  would have had to not be use their quota in a previous period, and it
> also means that the application would have to be carefully written to
> exacerbate this behavior.
> 
> Additionally if cpu bound threads underutilize a slice of their quota
> in a period due to the cfs choosing a bursty task to run, they should
> theoretically be able to make it up in the following periods when the
> bursty task is unable to "burst".
> 
> Please be careful here quota and slice are being treated differently.
> Quota does not roll-over between periods, only slices of quota that
> has already been allocated to per cpu run queues. If you allocate
> 100ms of quota per period to an application, but it only spreads onto
> 3 cpu run queues that means it can in the worst case use 3 x slice
> size = 15ms in periods following underutilization.
> 
> So why does this matter.  Well applications that use thread pools
> *(*cough* java *cough*) with lots of tiny little worker threads, tend
> to spread themselves out onto a lot of run queues.  These worker
> threads grab quota slices in order to run, then rarely use all of
> their slice (1 or 2ms out of the 5ms).  This results in those worker
> threads starving the main application of quota, and then expiring the
> remainder of that quota slice on the per-cpu.  Going back to my
> earlier 100ms quota / 80 cpu example.  That means only
> 100ms/cfs_bandwidth_slice_us(5ms) = 20 slices are available in a
> period.  So only 20 out of these 80 cpus ever get a slice allocated to
> them.  By allowing these per-cpu run queues to use their remaining
> slice in following periods these worker threads do not need to be
> allocated additional slice, and thereby the main threads are actually
> able to use the allocated cpu quota.
> 
> This can be experienced by running fibtest available at
> https://github.com/indeedeng/fibtest/.
> $ runfibtest 1
> runs a single fast thread taskset to cpu 0
> $ runfibtest 8
> Runs a single fast thread taskset to cpu 0, and 7 slow threads taskset
> to cpus 1-7.  This run is expected to show less iterations, but the
> worse problem is that the cpu usage is far less than the 500ms that it
> should have received.
> 
> Thanks for the engagement on this,
> Dave Chiluk

Thanks for the clarification. This is an even better explanation. 

Fwiw, I ran some of my cfs throttling tests with this, none of which are
designed to measure or hit this particular issue. They are more focused
on starvation and hard lockups that I've hit. But I did not see any issues
or oddities with this patch. 

Cheers,
Phil

-- 
