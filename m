Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4177108
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2019 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfGZSOl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Jul 2019 14:14:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGZSOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Jul 2019 14:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u+lpT/JDYChvPfnGwY3zyoUNga/MspVT2AZ3BOnHYeQ=; b=J3AuEJhibZaQ59WWz9Dvs5SAk
        tOZGBHDTys1MvF7IVIK5qPubajsPiDKhUytHxHBBscw9SNUy6DQy/582GKYNvQsg78TR8QXcdScud
        /bhuddvQ/zZMqs6JwKgaSG8ATDmFg1jnRA4tGWiX+rQPQmgfrYE5toK+TNIlFrIlkqRJsGM8yHD9l
        ormVs4nN6UzJyvmrohztWz0cHfxy/Fy66kMDw0EgZUQ01XyKe8ytvfUtnvs6SDb1TaU4X+YbIikdA
        Qtr+thdejB5X7lSa+R9yq9E0Pxscj0Xqi+kjopmF1FpKPBZDYTFwiazYN4pproqO084VLip1k/Uwy
        LyFo72VLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr4jj-0002xL-0n; Fri, 26 Jul 2019 18:14:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA44520227073; Fri, 26 Jul 2019 20:14:32 +0200 (CEST)
Date:   Fri, 26 Jul 2019 20:14:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Dave Chiluk <chiluk+linux@indeed.com>,
        Ben Segall <bsegall@google.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/1] sched/fair: Fix low cpu usage with high
 throttling by removing expiration of cpu-local slices
Message-ID: <20190726181432.GR31381@hirez.programming.kicks-ass.net>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1563900266-19734-1-git-send-email-chiluk+linux@indeed.com>
 <1563900266-19734-2-git-send-email-chiluk+linux@indeed.com>
 <20190723171307.GC2947@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723171307.GC2947@lorien.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 23, 2019 at 01:13:09PM -0400, Phil Auld wrote:
> Hi Dave,
> 
> On Tue, Jul 23, 2019 at 11:44:26AM -0500 Dave Chiluk wrote:
> > It has been observed, that highly-threaded, non-cpu-bound applications
> > running under cpu.cfs_quota_us constraints can hit a high percentage of
> > periods throttled while simultaneously not consuming the allocated
> > amount of quota. This use case is typical of user-interactive non-cpu
> > bound applications, such as those running in kubernetes or mesos when
> > run on multiple cpu cores.
> > 
> > This has been root caused to cpu-local run queue being allocated per cpu
> > bandwidth slices, and then not fully using that slice within the period.
> > At which point the slice and quota expires. This expiration of unused
> > slice results in applications not being able to utilize the quota for
> > which they are allocated.
> > 
> > The non-expiration of per-cpu slices was recently fixed by
> > 'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
> > condition")'. Prior to that it appears that this had been broken since
> > at least 'commit 51f2176d74ac ("sched/fair: Fix unlocked reads of some
> > cfs_b->quota/period")' which was introduced in v3.16-rc1 in 2014. That
> > added the following conditional which resulted in slices never being
> > expired.
> > 
> > if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
> > 	/* extend local deadline, drift is bounded above by 2 ticks */
> > 	cfs_rq->runtime_expires += TICK_NSEC;
> > 
> > Because this was broken for nearly 5 years, and has recently been fixed
> > and is now being noticed by many users running kubernetes
> > (https://github.com/kubernetes/kubernetes/issues/67577) it is my opinion
> > that the mechanisms around expiring runtime should be removed
> > altogether.
> > 
> > This allows quota already allocated to per-cpu run-queues to live longer
> > than the period boundary. This allows threads on runqueues that do not
> > use much CPU to continue to use their remaining slice over a longer
> > period of time than cpu.cfs_period_us. However, this helps prevent the
> > above condition of hitting throttling while also not fully utilizing
> > your cpu quota.
> > 
> > This theoretically allows a machine to use slightly more than its
> > allotted quota in some periods. This overflow would be bounded by the
> > remaining quota left on each per-cpu runqueueu. This is typically no
> > more than min_cfs_rq_runtime=1ms per cpu. For CPU bound tasks this will
> > change nothing, as they should theoretically fully utilize all of their
> > quota in each period. For user-interactive tasks as described above this
> > provides a much better user/application experience as their cpu
> > utilization will more closely match the amount they requested when they
> > hit throttling. This means that cpu limits no longer strictly apply per
> > period for non-cpu bound applications, but that they are still accurate
> > over longer timeframes.
> > 
> > This greatly improves performance of high-thread-count, non-cpu bound
> > applications with low cfs_quota_us allocation on high-core-count
> > machines. In the case of an artificial testcase (10ms/100ms of quota on
> > 80 CPU machine), this commit resulted in almost 30x performance
> > improvement, while still maintaining correct cpu quota restrictions.
> > That testcase is available at https://github.com/indeedeng/fibtest.
> > 
> > Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
> > Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
> > Reviewed-by: Ben Segall <bsegall@google.com>
> 
> This still works for me. The documentation reads pretty well, too. Good job.
> 
> Feel free to add my Acked-by: or Reviewed-by: Phil Auld <pauld@redhat.com>.

Thanks guys!
