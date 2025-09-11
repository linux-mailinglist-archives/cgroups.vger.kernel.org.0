Return-Path: <cgroups+bounces-9987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3075B52DBC
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DEA5A0049
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6142EB5B7;
	Thu, 11 Sep 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxTCr3fm"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2C223DFF;
	Thu, 11 Sep 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584533; cv=none; b=YVdmb7iZ5CsQKi81PRtH1Y4OO6KKWD8k0pLSsxnrYS3p3OQUxWm9ZSRPzChhfHF7uyH4Ro6I5fYzjwFVesqDFJVlqZgrkD83+VFP3z6Dz189QuT3iCwkGmHUd9V8h5NAx09Jei7ljVmNtVfZ18GqGUGeztDMlmml3z3jY7GT3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584533; c=relaxed/simple;
	bh=C9z8iqUg96bilsMO+t9QQtQ4ag3zFq/DgMPcgUCxLOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulPFK6MKWONY/zMTzeaSKrkhl6O5x9ofub3CNApogxUFM+O/g5K9ZWXyjKfuH3mJhnSoLjIefEnB77G2mbZ5t3u/ch4O5gCBFWgm7LWC5RwuFN97PyAcGxZQH2YcVsXrMCRlYDEgSJIDpAHhI6KwnXFgLkcpeimvjpTw4ApxkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pxTCr3fm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BOS4I5IYgSD1VNmtbolQZZYGtmhRtxyqsFfetvR+zas=; b=pxTCr3fmMIJYYZCeI/eQRpuQnk
	ygzmmhAlKXS9jrvn+z6iOAbWhrjWbgfvwglrzKdLZ+W2HLV0ayyhXX/Qn7+ianD/9nxEqfJ3pt0E+
	AE7q6Axf+kuqOUETSs5xHmnW1jImjy/vEdDSAFy+kpjC6DyIGsj0bfDWZwPpg0BLy1uw0aVGQ+b1O
	1gI/uXwEtg48TwzWUP5BaHIkniYuvZ4/BKAvU5iliB3U0K09tjlK2A5NCiwSXLIxrmagkg4z3WdOQ
	6h76uv+I24uu9GXZfOCvjSuwP6IFmcCJEB50TtxQeOc+V8Zi97xTZTl0cNqANF34wSSMLmGFqcLNe
	eGAFmKbA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwe1T-00000008hqS-2Acm;
	Thu, 11 Sep 2025 09:55:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15ECE3002EB; Thu, 11 Sep 2025 11:55:23 +0200 (CEST)
Date: Thu, 11 Sep 2025 11:55:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 01/14] sched: Employ sched_change guards
Message-ID: <20250911095523.GX3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
 <c4955d95-8d23-49da-9214-da481f28f797@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4955d95-8d23-49da-9214-da481f28f797@amd.com>

On Thu, Sep 11, 2025 at 02:36:21PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 9/10/2025 9:14 PM, Peter Zijlstra wrote:
> > @@ -9240,8 +9213,9 @@ static void sched_change_group(struct ta
> >   */
> >  void sched_move_task(struct task_struct *tsk, bool for_autogroup)
> >  {
> > -	int queued, running, queue_flags =
> > +	unsigned int queue_flags =
> >  		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
> 
> nit.
> 
> Since we don't do a complete dequeue for delayed task in
> sched_move_task(), can we get rid of that DEQUEUE_NOCLOCK and ...
> 
> > +	bool resched = false;
> >  	struct rq *rq;
> >  
> >  	CLASS(task_rq_lock, rq_guard)(tsk);
> > @@ -9249,28 +9223,12 @@ void sched_move_task(struct task_struct
> >  
> >  	update_rq_clock(rq);
> 
> ... this clock update and instead rely on sched_change_begin() to
> handle it within the guard?

Yeah, I suppose we could. But let me try and do that in a later patch,
on-top of all this.

> > -	running = task_current_donor(rq, tsk);
> > -	queued = task_on_rq_queued(tsk);
> > -
> > -	if (queued)
> > -		dequeue_task(rq, tsk, queue_flags);
> > -	if (running)
> > -		put_prev_task(rq, tsk);
> > -
> > -	sched_change_group(tsk);
> > -	if (!for_autogroup)
> > -		scx_cgroup_move_task(tsk);
> > -
> > -	if (queued)
> > -		enqueue_task(rq, tsk, queue_flags);
> > -	if (running) {
> > -		set_next_task(rq, tsk);
> > -		/*
> > -		 * After changing group, the running task may have joined a
> > -		 * throttled one but it's still the running task. Trigger a
> > -		 * resched to make sure that task can still run.
> > -		 */
> > -		resched_curr(rq);
> > +	scoped_guard (sched_change, tsk, queue_flags) {
> > +		sched_change_group(tsk);
> > +		if (!for_autogroup)
> > +			scx_cgroup_move_task(tsk);
> > +		if (scope->running)
> > +			resched = true;
> >  	}
> 
> Also, are we missing a:
> 
> 	if (resched)
> 		resched_curr(rq);
> 
> here after the guard? I don't see anything in sched_change_end() at this
> point that would trigger a resched.

Bah, yes. That hunk must've gone missing in one of the many rebases I
did while folding back fixes :/

