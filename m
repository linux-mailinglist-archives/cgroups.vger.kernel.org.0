Return-Path: <cgroups+bounces-13238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A378DD231CF
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4383830D032D
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73532FA1B;
	Thu, 15 Jan 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFUp94qq"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2266329391;
	Thu, 15 Jan 2026 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465489; cv=none; b=P6nX7DECY9fGs5/Qb43ZE6Ie39nIz/NqHP657v9/Ua+fEsIdYRfYu4mlTWdU4Afx0ecvHA2lp179oqPnPp4oBCJV6dNcEXvmAf5jw1HjHeu2luIr11bcbW2yP52cJhc/ANQHdjraAfSkAi+lN+w8U+GlxFujBjE/8EpapviSCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465489; c=relaxed/simple;
	bh=GEaJaYja87liXR/q22FlYoPhaUg3S5zvknrgF1mAW8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPpBhJnEehJvAi9vIRLntFA+IDU2ryd963vPmX5RG8AUvsUxvRxDriAWW5hWSRCt+kd5AdNUNqN/O5lnyqFc9BWYxvGZ05yjqbeHBw/XNFzCBwRhGu1LDRAGpZMJZ0lh4iThsLWRfrXyV06k4qBgYU4T/euT95sFrVhxEjQnfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IFUp94qq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e8bAwWOZUjeh0Al8L+kGdtyWhBXYH7ec6q2qya2+mgM=; b=IFUp94qqSjhIRMhAwhzWLblRyM
	8mLv1AoTNZQBe30imwXjgVnSC26vrj68N/qQU/VqfVimaVgoDTAx2xFJkCvzZrZZRbaSM/oxRYv4V
	ppFKA/nGg30+k4VoBFCJoEpaftVvv8t3TbU5G08zlLMoFWcOoWFTE0VqhbATRkm8AS+32cqZv1rps
	oOVJ3qbm7nXC8Ei8xwT9EPIxJu15gJyXBXvYxD4cBqY4QkTP+f1F/ARaWPLakIAtNy8IRXOkBr+Ki
	nTM4opEQpJriyUsO9zO7Y/50Xb1ZJPqRAZbxWUwuJgkhkLfR2NbACweBziuJDOppvlDZy7pYSYbU1
	gkFJHZ/g==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgIee-00000006J0Q-0WWn;
	Thu, 15 Jan 2026 08:24:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 758CF30049A; Thu, 15 Jan 2026 09:24:31 +0100 (CET)
Date: Thu, 15 Jan 2026 09:24:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260115082431.GE830755@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
 <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>

On Wed, Jan 14, 2026 at 03:20:48PM +0100, Juri Lelli wrote:

> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
> >  		 * itself.
> >  		 */
> >  		newprio = rt_effective_prio(p, newprio);
> > -		if (newprio == oldprio)
> > +		if (newprio == oldprio && !dl_prio(newprio))
> >  			queue_flags &= ~DEQUEUE_MOVE;
> >  	}
> 
> We have been using (improperly?) ENQUEUE_SAVE also to know when a new
> entity gets setscheduled to DEADLINE (or its parameters are changed) and
> it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
> quick first look, it does sound good to me.

If this is strictly about tasks coming into SCHED_DEADLINE there are a
number of alternative options:

 - there are the sched_class::switch{ing,ed}_to() callbacks;
 - there is (the fairly recent) ENQUEUE_CLASS.

Anyway, let me break up this one patch into individual bits and write
changelogs. I'll stick them in queue/sched/urgent for now; hopefully
Pierre can given them a spin and report back if it all sorts his
problem).

