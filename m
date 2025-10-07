Return-Path: <cgroups+bounces-10580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB746BC0FD2
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 12:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EE53AD522
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F92D6E6E;
	Tue,  7 Oct 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WdB1oNoM"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE322579E;
	Tue,  7 Oct 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832182; cv=none; b=fG6kyggHh85V3JuKTv3BtKKsuDj3hbDnw7xgxh62sM1wtgN6tSM1U5sV1HGfPXc5/d1pB07vZ4ZTR4cXAWX/rraedoSnlEbbNnKcKjdc+O1VnF0TmVSWkkVlcERoCrN55PZx/NeptYj32d8JilO2VmgfhNLOu4o2rA3u5Ieb44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832182; c=relaxed/simple;
	bh=cu5WgrnaZH+RK73IluvxZt1kldsqWNC5A84/kComYHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8zZu5yiU/OQNjFXMvfnIjk3GGLJoFcVU948/4UJTlJxKQNu+hjUqPS/OaklcQGH9owuEI9LiS6L5rUiPMSEYB+P6JQTtnakQmlMVY+whTOzsi90z6Cyt78+tbVrmPQO9wxwVHT7C0rtYSjDHXobtjaRN83poct5QAK7A6wmxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WdB1oNoM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iwif9ExfXZYFRG5YTH8P10iLbyGNxofX7BDXhWql0DM=; b=WdB1oNoM0PZjs3DNOrLnDhkZa7
	s14Dw1cbIFWC+1iPrfLldF2q7gCtWi9uqTV/XWm0mJKt2o3C+JQhPmZUpGy+fOyn7+BUA5GikR1rD
	Qf2A+N4tStT1EC4Ko5Za2PlzYs5qXMKmSARrpyLON2LAwZbKT0vsd0crPT3Y2elZMthPgeFRfKL8p
	19BmFp/sQBRi/0j3XkiRfNEwYBJmtmVyG66s0AOw5n4OiPi0xIo5LUMlm4SAqiko5GBqvcaadJdTs
	m5J2JOjrHVF+ZWOc9P6tV8RFTZPcZROdO2o1JDq4lIyhZoHjzmPenwVv8Avs35UFEbz2q9qE7lyaD
	+ILz82qw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v64jr-0000000HY5o-0w5r;
	Tue, 07 Oct 2025 10:16:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20B68300220; Tue, 07 Oct 2025 12:16:10 +0200 (CEST)
Date: Tue, 7 Oct 2025 12:16:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <20251007101610.GD3245006@noisy.programming.kicks-ass.net>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
 <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Oct 07, 2025 at 12:08:03PM +0200, Juri Lelli wrote:
> Hi Peter,
> 
> On 06/10/25 12:46, Peter Zijlstra wrote:
> > Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> > enables easy tracking of which runqueues are modified over a
> > lock-break.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> Nice.
> 
> > @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
> >  	if (this_rq->cfs.h_nr_queued && !pulled_task)
> >  		pulled_task = 1;
> >  
> > -	/* Is there a task of a high priority class? */
> > -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> > +	/* If a higher prio class was modified, restart the pick */
> > +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
> >  		pulled_task = -1;
> 
> Does this however want a self-documenting inline helper or macro to make
> it even more clear? If this is always going to be the only caller maybe
> not so much.

There's another one in patch 3. I suppose we can do that. Maybe
something like:

static inline bool rq_modified_above(struct rq *rq, struct sched_class *class)
{
	unsigned int mask = class->queue_mask;
	return rq->queue_mask & ~((mask << 1) - 1);
}

This then writes the above like:

	if (rq_modified_above(this_rq, &fair_sched_class))

