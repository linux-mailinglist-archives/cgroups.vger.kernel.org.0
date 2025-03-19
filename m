Return-Path: <cgroups+bounces-7159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC4A6962D
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DF33B21A1
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5870F1DF974;
	Wed, 19 Mar 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HdZqR9VH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E31E25E8
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404695; cv=none; b=K5lTs1aOA3OG0o1avc1NO6p8X9NYo2yYTIUDOs6funQXEX7Cd6OJinz+1w73M2TJXbBGfYWNH8T4zn2SP8wfBlnhOjR86ohhVpGA0xT9KouMgpyQn5AX+pStPjC+6ycLVrbo6p53Jy7CpA4LHABsoa4l6mV4T4cKt7cNuL5dxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404695; c=relaxed/simple;
	bh=2N1I1hdeBWQPI7auZeAI698brc7nrs/XghJbD30nyDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfE5eeoPpB+tUvreUoLgO0IHC9BBmwcBS7pthQAFbDgZKaM0dld8/34UPQZdGcFpRzkQKxFvLdlFI5//B8ljszsyQ8wutidzNIYO15JvJNHg97W/H3eqNg5IoURZ+2GUXyy54UfK7NmWIAM2vU1domw5A3He8jbGCCsyatjASLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HdZqR9VH; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 17:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742404690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wndCWRL/SlUJGjwqRG41pyacoMp3XEgXcXkWL0LBY/I=;
	b=HdZqR9VHfoQsq62CuzECJXjB804i6k0wcp0SW45XsU+pmf0fr3HyejFyAQgrGuXtjaJ+Lc
	D3CEKccPxBG7+3kPRLc8m7s0uuG26KJj+guFboQcKNIZZ1QOObRIY5Bh6Gbt4yafvfL/s9
	ad/qi2bgDwNTHSP/qEg3FzTS7SozrCw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z9r8TX0WiPWVffI0@google.com>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
> On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> > iterating all possible cpus. It only drops the lock if there is
> > scheduler or spin lock contention. If neither, then interrupts can be
> > disabled for a long time. On large machines this can disable interrupts
> > for a long enough time to drop network packets. On 400+ CPU machines
> > I've seen interrupt disabled for over 40 msec.
> > 
> > Prevent rstat from disabling interrupts while processing all possible
> > cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> > approach was previously discussed in
> > https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> > though this was in the context of an non-irq rstat spin lock.
> > 
> > Benchmark this change with:
> > 1) a single stat_reader process with 400 threads, each reading a test
> >    memcg's memory.stat repeatedly for 10 seconds.
> > 2) 400 memory hog processes running in the test memcg and repeatedly
> >    charging memory until oom killed. Then they repeat charging and oom
> >    killing.
> > 
> > v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> > interrupts are disabled by rstat for 45341 usec:
> >   #  => started at: _raw_spin_lock_irq
> >   #  => ended at:   cgroup_rstat_flush
> >   #
> >   #
> >   #                    _------=> CPU#
> >   #                   / _-----=> irqs-off/BH-disabled
> >   #                  | / _----=> need-resched
> >   #                  || / _---=> hardirq/softirq
> >   #                  ||| / _--=> preempt-depth
> >   #                  |||| / _-=> migrate-disable
> >   #                  ||||| /     delay
> >   #  cmd     pid     |||||| time  |   caller
> >   #     \   /        ||||||  \    |    /
> >   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
> >   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
> >   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
> >   stat_rea-96532    52d.... 45343us : <stack trace>
> >    => memcg1_stat_format
> >    => memory_stat_format
> >    => memory_stat_show
> >    => seq_read_iter
> >    => vfs_read
> >    => ksys_read
> >    => do_syscall_64
> >    => entry_SYSCALL_64_after_hwframe
> > 
> > With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> > longest holder. The longest irqs-off holder has irqs disabled for
> > 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> > 
> > Running stat_reader memory.stat reader for 10 seconds:
> > - without memory hogs: 9.84M accesses => 12.7M accesses
> > -    with memory hogs: 9.46M accesses => 11.1M accesses
> > The throughput of memory.stat access improves.
> > 
> > The mode of memory.stat access latency after grouping by of 2 buckets:
> > - without memory hogs: 64 usec => 16 usec
> > -    with memory hogs: 64 usec =>  8 usec
> > The memory.stat latency improves.
> > 
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > Tested-by: Greg Thelen <gthelen@google.com>
> > ---
> >  kernel/cgroup/rstat.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index aac91466279f..976c24b3671a 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
> >  			rcu_read_unlock();
> >  		}
> >  
> > -		/* play nice and yield if necessary */
> > -		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
> > -			__cgroup_rstat_unlock(cgrp, cpu);
> > -			if (!cond_resched())
> > -				cpu_relax();
> > -			__cgroup_rstat_lock(cgrp, cpu);
> > -		}
> > +		/* play nice and avoid disabling interrupts for a long time */
> > +		__cgroup_rstat_unlock(cgrp, cpu);
> > +		if (!cond_resched())
> > +			cpu_relax();
> > +		__cgroup_rstat_lock(cgrp, cpu);
> >  	}
> >  }
> 
> Is not this going a little too far?
> 
> the lock + irq trip is quite expensive in its own right and now is
> going to be paid for each cpu, as in the total time spent executing
> cgroup_rstat_flush_locked is going to go up.
> 
> Would your problem go away toggling this every -- say -- 8 cpus?

I was concerned about this too, and about more lock bouncing, but the
testing suggests that this actually overall improves the latency of
cgroup_rstat_flush_locked() (at least on tested HW).

So I don't think we need to do something like this unless a regression
is observed.

> 
> Just a suggestion.
> 

