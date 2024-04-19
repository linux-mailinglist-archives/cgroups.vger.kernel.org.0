Return-Path: <cgroups+bounces-2625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624068AB2F4
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 18:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29901F21795
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E464E131BBE;
	Fri, 19 Apr 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K1flVzQT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD7130AFC
	for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543104; cv=none; b=NAX44Wfagrfgt5AIZx1HiZb2f+q1vgficNXCBpQMTru22RTopb/O9Fhqoyb26s9Tp681PUIR0sxWqeeImQCGAk+5MviNPTVC4B0yBRC8JmVwJ8zsskpgpD/DWL6FNdK76JdiARxktwf9Bri5ARpgwR828pkV1Rjo++OJtQ7WZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543104; c=relaxed/simple;
	bh=YiIo7bwh+JygPxi96MWkEdF0Xun4ILTm7Qlbps8sJxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5z4YrGRdriYPpWEuFuOOXcNOeUFwfDfnm3DKl/i26snMGAwacQxcLWbTao7Hvv7vFiXkBlNcR+DYzLULunjvxtH+rBn39QNfCXRllWQzVU/X1dPcG+MFhETnW8UaalrRSQVl2BP523XRBmBvqi3D4VzQ57n3UhiDsMvt+D+37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K1flVzQT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Apr 2024 09:11:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713543100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1M1JrcjILmKzY/pZvXVWiYtUaqkIh9p05oVmfNf0rww=;
	b=K1flVzQTM+oFA2r7zbEZfWL1Cx45FZeshKvy/vWeELZmkSdsf1KvuEo2B1ZxDCkvrBw2te
	R6sUPQwVqPUrsBOcAs0PiOqaZKW0Z3YrHoCJbASaz+8VkxORdept/DSJTLhjQW4N4ye1xQ
	25T+Xm6zatF7tmP04YMcsMfql4Xb+M0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to
 mutex
Message-ID: <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul>
 <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
 <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
 <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
 <6392f7e8-d14c-40f4-8a19-110dfffb9707@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6392f7e8-d14c-40f4-8a19-110dfffb9707@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 19, 2024 at 03:15:01PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 18/04/2024 22.39, Yosry Ahmed wrote:
> > On Thu, Apr 18, 2024 at 7:49 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > 
> > > On Thu, Apr 18, 2024 at 11:02:06AM +0200, Jesper Dangaard Brouer wrote:
> > > > 
> > > > 
> > > > On 18/04/2024 04.19, Yosry Ahmed wrote:
> > > [...]
> > > > > 
> > > > > I will keep the high-level conversation about using the mutex here in
> > > > > the cover letter thread, but I am wondering why we are keeping the
> > > > > lock dropping logic here with the mutex?
> > > > > 
> > > > 
> > > > I agree that yielding the mutex in the loop makes less sense.
> > > > Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
> > > > will be a preemption point for my softirq.   But I kept it because, we
> > > > are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
> > > > there was no sched point for other userspace processes while holding the
> > > > mutex, but I don't fully know the sched implication when holding a mutex.
> > > > 
> > > 
> > > Are the softirqs you are interested in, raised from the same cpu or
> > > remote cpu? What about local_softirq_pending() check in addition to
> > > need_resched() and spin_needbreak() checks? If softirq can only be
> > > raised on local cpu then convert the spin_lock to non-irq one (Please
> > > correct me if I am wrong but on return from hard irq and not within bh
> > > or irq disabled spin_lock, the kernel will run the pending softirqs,
> > > right?). Did you get the chance to test these two changes or something
> > > similar in your prod environment?
> > 
> > I tried making the spinlock a non-irq lock before, but Tejun objected [1].
> > [1] https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/
> > 
> 
> After reading [1], I think using a mutex is a better approach (than non-irq
> spinlock).
> 
> 
> > Perhaps we could experiment with always dropping the lock at CPU
> > boundaries instead?
> > 
> 
> I don't think this will be enough (always dropping the lock at CPU
> boundaries).  My measured "lock-hold" times that is blocking IRQ (and
> softirq) for too long.  When looking at prod with my new cgroup
> tracepoint script[2]. When contention occurs, I see many Yields
> happening and with same magnitude as Contended. But still see events
> with long "lock-hold" times, even-though yields are high.
> 
>  [2] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt
> 
> Example output:
> 
>  12:46:56 High Lock-contention: wait: 739 usec (0 ms) on CPU:56 comm:kswapd7
>  12:46:56 Long lock-hold time: 6381 usec (6 ms) on CPU:27 comm:kswapd3
>  12:46:56 Long lock-hold time: 18905 usec (18 ms) on CPU:100
> comm:kworker/u261:12
> 
>  12:46:56  time elapsed: 36 sec (interval = 1 sec)
>   Flushes(2051) 15/interval (avg 56/sec)
>   Locks(44464) 1340/interval (avg 1235/sec)
>   Yields(42413) 1325/interval (avg 1178/sec)
>   Contended(42112) 1322/interval (avg 1169/sec)
> 
> There is reported 15 flushes/sec, but locks are yielded quickly.
> 
> More problematically (for softirq latency) we see a Long lock-hold time
> reaching 18 ms.  For network RX softirq I need lower than 0.5ms latency,
> to avoid RX-ring HW queue overflows.
> 
> 
> --Jesper
> p.s. I'm seeing a pattern with kswapdN contending on this lock.
> 
> @stack[697, kswapd3]:
>         __cgroup_rstat_lock+107
>         __cgroup_rstat_lock+107
>         cgroup_rstat_flush_locked+851
>         cgroup_rstat_flush+35
>         shrink_node+226
>         balance_pgdat+807
>         kswapd+521
>         kthread+228
>         ret_from_fork+48
>         ret_from_fork_asm+27
> 
> @stack[698, kswapd4]:
>         __cgroup_rstat_lock+107
>         __cgroup_rstat_lock+107
>         cgroup_rstat_flush_locked+851
>         cgroup_rstat_flush+35
>         shrink_node+226
>         balance_pgdat+807
>         kswapd+521
>         kthread+228
>         ret_from_fork+48
>         ret_from_fork_asm+27
> 
> @stack[699, kswapd5]:
>         __cgroup_rstat_lock+107
>         __cgroup_rstat_lock+107
>         cgroup_rstat_flush_locked+851
>         cgroup_rstat_flush+35
>         shrink_node+226
>         balance_pgdat+807
>         kswapd+521
>         kthread+228
>         ret_from_fork+48
>         ret_from_fork_asm+27
> 

Can you simply replace mem_cgroup_flush_stats() in
prepare_scan_control() with the ratelimited version and see if the issue
still persists for your production traffic?

Also were you able to get which specific stats are getting the most
updates?

