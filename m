Return-Path: <cgroups+bounces-10576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E931BC0DCD
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 11:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351003BF65D
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0402D6E53;
	Tue,  7 Oct 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJdWj2Ui"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFE3207;
	Tue,  7 Oct 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829716; cv=none; b=YkGNFkAP8pu6KQ1Cy5QHpExGcuqQ0NFI7g/bg+OUYAx0/9jtzAqnu32w08+6bPoGDNMmjdu8UB5TTgywJRLtPqh+HEfynDJfrUHroh7sjMIA4EbpisNKBBi5zrwBMJk7G6peOYv7N0Q0pzhMPAgslQ3tW8821Ts5pBhO40GpJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829716; c=relaxed/simple;
	bh=CpHSJxldJGUmua//0ARbaJ1d4uPkotPp8oo+L2MXqBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/+8vLAr95sz7l2DyZ2JJIA4qy6nGxiVqtzv3VrsKVmu258W2cr9oY1XlcVL/DdRWuA4tU/HOxFjihwUGdjb3wMNQmtqXVBlbIae9twI3YKXTs/gfRejfIK8e4w+9bOpibf2Alu5SJBo0rlK2MJMV8CL1Wn1o8yiyWW0Kn2ZHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qJdWj2Ui; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lIDqpP0aQZGw92fNmehm1NTPBgNKs/DwZnYkZGr5ZVg=; b=qJdWj2UibmFOp1KxbE2KB3rbOC
	nFFWNlTG1qt+yPZknjvcFGPS63eUGvaP6cnPPMd1zDr0qzXqMf9XetP/MWD4crO0DpPHMVDTqFfaD
	bsydrqMJSoXEn/8+ijrFx4vY3+NLSY+0mjJJXl9rhOjGDfiLdbAFHnwOkF+yugKgBKU4NxM1EAJ4f
	qhtSu5xbm96qGvxKBzLBlfwkVlHwJMYjFNEDq5KmDxKxu7xGRPMYZ1v1PBTI7OEsQzsGwx6DbIuja
	+tNuGw5YWVgPwX+/NsLFeVwjovlUYPAb+n1rzOHaG/uu6xI+UhH3qkhd8y7ES23vQTV5XmRE16zft
	OiF2oo+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v645u-0000000HWqi-0tSS;
	Tue, 07 Oct 2025 09:34:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 010E4300220; Tue, 07 Oct 2025 11:34:53 +0200 (CEST)
Date: Tue, 7 Oct 2025 11:34:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	tj@kernel.org
Subject: Re: [PATCH 01/14] sched: Employ sched_change guards
Message-ID: <20251007093452.GC3245006@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
 <fee0edd5-86d1-4dff-9e07-70fd2208b073@linux.ibm.com>
 <20251006181429.GV3245006@noisy.programming.kicks-ass.net>
 <2b37d74f-7a5d-486b-98df-679bd7e2b0c2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b37d74f-7a5d-486b-98df-679bd7e2b0c2@linux.ibm.com>

On Tue, Oct 07, 2025 at 10:42:29AM +0530, Shrikanth Hegde wrote:
> On 10/6/25 11:44 PM, Peter Zijlstra wrote:

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -10783,6 +10783,12 @@ struct sched_change_ctx *sched_change_be
> >   	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
> >   	struct rq *rq = task_rq(p);
> > +	/*
> > +	 * Must exclusively use matched flags since this is both dequeue and
> > +	 * enqueue.
> > +	 */
> 
> yes. Something like that. Unless callsites explicitly change the flags using
> the scope, enqueue will happen with matching flags.
> 
> > +	WARN_ON_ONCE(flags & 0xFFFF0000);
> > +
> 
> A mythical example:
> scope_guard(sched_change, p, DEQUEUE_THROTTLE)
> 	scope->flags &= ~DEQUEUE_THROTTLE;
> 	scope->flags |= ENQUEUE_HEAD;
> 
> But, One could still do this right? for such users the warning may be wrong.

Right, I suppose this would be possible. Lets worry about it if/when it
ever comes up though.

