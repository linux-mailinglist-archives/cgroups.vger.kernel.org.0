Return-Path: <cgroups+bounces-10658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB12BD2B73
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1681188C15F
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2D3064A2;
	Mon, 13 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lU8uA0ly"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8E30594F;
	Mon, 13 Oct 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353503; cv=none; b=CsTK3upsgBbC5SK+NksIiJK6kbeohQFUVCsx9jywx2kZgZ77XMHZ14NIyCn6pna07EOTUbkpEZ8nMhdE20lugiLqvIHWAeYCczT1n9UKDWQqlQjjkiEPyMgKUEQ/vQFO/PdNCtHtLNyJxG3Qh6VhJJO5ogQo7rnd2WJGRYqJ6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353503; c=relaxed/simple;
	bh=aEBv73qgNri7ca0Pq0aqKkR21tCOcBeU+pRiNPqzNyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPXlf67bzbX4TX5mruNl7HuytzId2Ajb1LggnFbxxrMj0LDYBOAsg0fmaZydUyPbUiG/y1Q9Ysmu2vceP+iKlVxj87+/Dw8Nj+58hl22G4p0x/EX1h0jQ7GkQMppwTCTpcJYr5VkJ4OP0vnyb/EfsMU8JMKi3DjWZlr7N+o7xMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lU8uA0ly; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hEJEPHH6+qRvStpKd5XdIHIdQOqqchEZEQhUF+w5fyA=; b=lU8uA0lyTraUTgk65p0zRKnUqO
	x1k/hLjU0mqYDZy0/FCEtgTw+o7oCMsVpuegZ3MaXImIG3JEWBdR8XdX+Fp7A4IyCa1OPDpouVwAN
	X9ZWh5/aUU9ewlTtyva44YC8D0fs1oJfPI51U98ACyNH9oUJYBKoddVMJeOvV4w6VIdItnGdC9yy5
	XNNi2p0iBV/Bf8ackZ1qPYx0nD8LcnJ28hxp3VefD5B9rhh5LF6A2bnFWrZdgV6/EYZd1BsKAPqqV
	UC7MXuXv8W3HSR0xGognmy5WjgMEEGHjc4HK17VO6ewSFv6HC0jfyKsk1pEQcEfbjurDcT66k7Oli
	lv69tzog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8GMD-00000004elR-2K9B;
	Mon, 13 Oct 2025 11:04:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9BD25300325; Mon, 13 Oct 2025 13:04:49 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:04:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
Message-ID: <20251013110449.GJ4067720@noisy.programming.kicks-ass.net>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
 <aObK2MfxPyFcovwr@slm.duckdns.org>
 <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>

On Thu, Oct 09, 2025 at 09:17:44AM +0200, Vincent Guittot wrote:
> On Wed, 8 Oct 2025 at 22:34, Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Oct 08, 2025 at 05:22:42PM +0200, Vincent Guittot wrote:
> > > On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
> > > >
> > > > > > +static struct task_struct *
> > > > > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > > > >  {
> > > > > > -       return pick_next_task_fair(rq, prev, NULL);
> > > > >
> > > > > The special case of a NULL rf pointer is used to skip
> > > > > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > > > > pick_next_task() slo path when prev_balance has already it. This means
> > > > > that it will be called twice if prev is not a fair task.
> > > >
> > > > Oh right. I suppose we can simply remove balance_fair.
> > >
> > > That was the option that I also had in mind but this will change from
> > > current behavior and I'm afraid that sched_ext people will complain.
> > > Currently, if prev is sched_ext, we don't call higher class.balance()
> > > which includes the fair class balance_fair->sched_balance_newidle.  If
> > > we now always call sched_balance_newidle() at the end
> > > pick_next_task_fair(), we will try to pull a fair task at each
> > > schedule between sched_ext tasks
> >
> > If we pass in @prev into pick(), can't pick() decide whether to newidle
> > balance or not based on that?
> 
> The problem is that with dl_server, you can has a prev of a lower prio
> but still want to run a newidle balance :
> -cfs task preempted by dl server
> -cfs task migrates to another cpu
> -we want to run newidle balance when cpu become idle

Bah; so yeah, this new behaviour is better for indeed always calling
newidle when it is needed, but you're also right that in case of ext
this might not be ideal.

So I have a pile of newidle hacks here:

  https://lkml.kernel.org/r/20251010170937.GG4067720@noisy.programming.kicks-ass.net

and while I don't particularly like NI_SPARE (the has_spare_tasks thing
is fickle); the idea seems to have some merit for this situation --
where we know we'll not be having fair tasks at all.

I mean, we can always do something like this to sched_balance_newidle():

	if (scx_switched_all())
		return 0;

Not pretty, but should do the job.

