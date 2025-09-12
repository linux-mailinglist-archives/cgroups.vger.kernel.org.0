Return-Path: <cgroups+bounces-10046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E280B550D1
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DFF1C821C2
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1A3112D3;
	Fri, 12 Sep 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYP94Yvm"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B230F959;
	Fri, 12 Sep 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686759; cv=none; b=nLiuim2hm7VAOupAAd+McctaHx/10BM4fZ5VISXLHZ8Yu2IoWrCmO+Wr5O1cvkMmDaX4+m5wwM0FuEWaE0qTt0h7doGl4IQ54YqmFK4x+TbTAla5Jp9yQBy9Dq+2fJdTYOr8olaS/XpH70ETuR+JOLxuRN1sHGbIn4DU1TbY1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686759; c=relaxed/simple;
	bh=IThJc79ZMqu+nxxQpWPHTn5+ZM5siQtLtI07yjgNoxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAc12d2+o60dOHo8thoqmN2td6km4nX04w1Wyc307I7GAvVqeLpUcIPGt+QmPTxdiXcc0V/1KMYA+w0YAWlgi8AG3WUD8+nwzlwEZRW2gH0SCQiRg8iK7XEl6atFw8TQif+huwUrgCy74wSRs34pOQjFp77tCGCKWG8ThnmADtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYP94Yvm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JtzadXmaZhLTqqwgtcx6yBg2tzYSUH/6NHLfE6xeaaU=; b=AYP94Yvmz1IDsfKDos14Mq84md
	tC6BTBSpfh0VnI9tU4WRvEOb7n3pGi9AYXJ+V71f/ofs/OzoY+1O0FRG6yIOG1SYYcLbra+eQzU6W
	Fj/N1Nv40TaoI0IZ3grtxW2pmgId9Ymk9uEkFYrUUm4piPHfXVdhP8a7T5nQ061aCXUm7wSZUNTg1
	p2K600Dk5SBY/a2n4UywZoosgUL1cZSQN7RBnfal7Q77DgWoXQuY5w042mKbQbk9eDOLwzw0p55aY
	PrZ5eKPgiklGYt0/dN42JZlOh2826LdiU1Ou20xr9hZSS6ACeLK60KNBPC21N7F+E3SNzLK8e3HxV
	xGrqbb8g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux4cD-0000000HJ1J-3tKA;
	Fri, 12 Sep 2025 14:19:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31FBE3002EB; Fri, 12 Sep 2025 16:19:04 +0200 (CEST)
Date: Fri, 12 Sep 2025 16:19:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
Message-ID: <20250912141904.GA3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155809.800554594@infradead.org>
 <aMItk3c5H6Z2CD4X@slm.duckdns.org>
 <20250911094240.GW3289052@noisy.programming.kicks-ass.net>
 <aMMzpnyx__ZgZGRc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMMzpnyx__ZgZGRc@slm.duckdns.org>

On Thu, Sep 11, 2025 at 10:40:06AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 11, 2025 at 11:42:40AM +0200, Peter Zijlstra wrote:
> ...
> > I didn't immediately see how to do that. Doesn't that
> > list_for_each_entry_safe_reverse() rely on rq->lock to retain integrity?
> 
> Ah, sorry, I was thinking it was iterating scx_tasks list. Yes, as
> implemented, it needs to hold rq lock throughout.
> 
> > Moreover, since the goal is to allow:
> > 
> >  __schedule()
> >    lock(rq->lock);
> >    next = pick_task() := pick_task_scx()
> >      lock(dsq->lock);
> >      p = some_dsq_task(dsq);
> >      task_unlink_from_dsq(p, dsq);
> >      set_task_cpu(p, cpu_of(rq));
> >      move_task_to_local_dsq(p, ...);
> >      return p;
> > 
> > without dropping rq->lock, by relying on dsq->lock to serialize things,
> > I don't see how we can retain the runnable list at all.
> >
> > And at this point, I'm not sure I understand ext well enough to know
> > what this bypass stuff does at all, let alone suggest means to
> > re architect this.
> 
> Bypass mode is enabled when the kernel side can't trust the BPF scheduling
> anymore and wants to fall back to dumb FIFO scheduling to guarantee forward
> progress (e.g. so that we can switch back to fair).
> 
> It comes down to flipping scx_rq_bypassing() on, which makes scheduling
> paths bypass most BPF parts and fall back to FIFO behavior, and then making
> sure every thread is on FIFO behavior. The latter part is what the loop is
> doing. It scans all currently runnable tasks and dequeues and re-enqueues
> them. As scx_rq_bypass() is true at this point, if a task were queued on the
> BPF side, the cycling takes it out of the BPF side and puts it on the
> fallback FIFO queue.
> 
> If we want to get rid of the locking requirement:
> 
> - Walk scx_tasks list which is iterated with a cursor and allows dropping
>   locks while iterating. However, on some hardware, there are cases where
>   CPUs are extremely slowed down from BPF scheduler making bad decisions and
>   causing a lot of sync cacheline pingponging across e.g. NUMA nodes. As
>   scx_bypass() is what's supposed to extricate the system from this state,
>   walking all tasks while going through each's locking probably isn't going
>   to be great.
> 
> - We can update ->runnable_list iteration to allow dropping rq lock e.g.
>   with a cursor based iteration. Maybe some code can be shared with
>   scx_tasks iteration. Cycling through locks still isn't going to be great
>   but here it's likely a lot fewer of them at least.
> 
> Neither option is great. Leave it as-is for now?

Ah, but I think we *have* to change it :/ The thing is that with the new
pick you can change 'rq' without holding the source rq->lock. So we
can't maintain this list.

Could something like so work?

	scoped_guard (rcu) for_each_process_thread(g, p) {
		if (p->flags & PF_EXITING || p->sched_class != ext_sched_class)
			continue;

		guard(task_rq_lock)(p);
		scoped_guard (sched_change, p) {
			/* no-op */
		}
	}	



