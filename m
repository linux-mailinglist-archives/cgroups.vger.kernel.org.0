Return-Path: <cgroups+bounces-13172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE31D1E023
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3835D30559E0
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9336838A9D3;
	Wed, 14 Jan 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YT96lzgj"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29D38A295;
	Wed, 14 Jan 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386239; cv=none; b=AmCc9Otpm8lgaKS3MMudlUTyasHnjhYnWBCLZNtlRHz+RLL+7jYvYmAmLkcr2+2bnQJ5okyNKdiSuFuvqmYXrvQHb+BwsqAeqO4/AQQbtQDV1orWTkdoXtV0Z6THZDdl0VmHSVRrl5PVfT2otpRa9yZhFvq5GhhKWOZm46ARcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386239; c=relaxed/simple;
	bh=3Ix4afPeQjdcWE9fZR4jtymub+Jury9YoLN/FdFXaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2kcFPZszADfTxlrHIwD5gF24zYdXRXG+BvfUgFKJbwkZxye6L6FYZFHkMyc+vOiuduVXm3vvLaYVmyd7pi3I2mZE2jQxaWUyuh4ozFNGSw93xW9iIy/QMiDiYoWqLdrKQ17CpJN6Mf6kO0g36s5DHH/Lr67csamfajGvmiyQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YT96lzgj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6Ak/cbXseHYJCWkQ2A879bSxoxmTdXya+GIiGj/y6Co=; b=YT96lzgjeNUVaEST9HzCPOXFvF
	/w179ickZa81QrlG1OAvHhZ/bqtsFU8pfI6cR5VMfr5XTubvsi9/T5z4zS336TyV2pIMBk98mKrlY
	dx6lgLwm3krt2595G0URvrCnDF5dRo3/3DATKoXC1eSGa5YdLX6N22+Bg8UFSg/0vXV6bN28m+wkK
	hoXz9pQE+UzzMh4sO5UISrQEtRRDWdh0SYC4qQhQ6xEaUc8A67TN5dQX/UPaw3NH1VKSY+QZl1Tng
	zrOn9YkhK4Pgp2EXqBGGjxqxcxMTPcN5hQqJyMhvZiczgJq29XkcGschwO/mRNnWQ8IHjqo4zBx8t
	mJkb1fkQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfy2R-000000062kC-37jk;
	Wed, 14 Jan 2026 10:23:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98F423005AA; Wed, 14 Jan 2026 11:23:36 +0100 (CET)
Date: Wed, 14 Jan 2026 11:23:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>

On Wed, Jan 14, 2026 at 12:17:11PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 1/13/2026 5:17 PM, Peter Zijlstra wrote:
> > Hum... so this one is a little more tricky.
> > 
> > So the normal rules are that DEQUEUE_SAVE + ENQUEUE_RESTORE should be as
> > invariant as possible.
> > 
> > But what I think happens here is that at the point of dequeue we are
> > effectively ready to throttle/replenish, but we don't.
> > 
> > Then at enqueue, we do. The replenish changes the deadline and we're up
> > a creek.
> 
> I've the following data from the scenario in which I observe
> the same splat as Pierre splat wit the two fixes on top of tip:
> 
>     yes-4108    [194] d..2.    53.396872: get_prio_dl: get_prio_dl: clock(53060728757)
>     yes-4108    [194] d..2.    53.396873: update_curr_dl_se: update_curr_dl_se: past throttle label
>     yes-4108    [194] d..2.    53.396873: update_curr_dl_se: dl_throttled(0) dl_overrun(0) timer_queued(0) server?(0)
>     yes-4108    [194] d..2.    53.396873: update_curr_dl_se: dl_se->runtime(190623) rq->dl.overloaded(0)
>     yes-4108    [194] d..2.    53.396874: get_prio_dl: get_prio_dl: deadline(53060017809)
> 
>     yes-4108    [194] d..2.    53.396878: enqueue_dl_entity: ENQUEUE_RESTORE update_dl_entity
>     yes-4108    [194] d..2.    53.396878: enqueue_dl_entity: setup_new_dl_entity
>     yes-4108    [194] d..2.    53.396878: enqueue_dl_entity: Replenish: Old: 53060017809 dl_deadline(1000000)
>     yes-4108    [194] d..2.    53.396879: enqueue_dl_entity: Replenish: New: 53061728757
>     yes-4108    [194] d..2.    53.396882: prio_changed_dl.part.0: Woops! prio_changed_dl: CPU(194) clock(53060728757) overloaded(0): Task: yes(4108), Curr: yes(4108) deadline: 53060017809 -> 53061728757
> 
> get_prio_dl() sees "deadline < rq->clock" but dl_se->runtime is still
> positive so update_curr_dl_se() doesn't fiddle with the deadline.
> 
> ENQUEUE_RESTORE sees "deadline" before "rq->clock" and calls
> setup_new_dl_entity() which calls replenish.

Right this. That's more or less where I ended up as well. Just don't
know what to do about that. It doesn't feel right.

That is, it means that a task behaves differently depending on if a
(unrelated) sched_change comes in between.

If undisturbed it will be allowed to exhaust its runtime, irrespective
of it missing its deadline (valid for G-EDF); while when it gets
disturbed it will be forced to replenish.

Juri, Luca, I'm tempted to suggest to simply remove the replenish on
RESTORE entirely -- that would allow the task to continue as it had
been, irrespective of it being 'late'.

Something like so -- what would this break?

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2214,10 +2214,6 @@ enqueue_dl_entity(struct sched_dl_entity
 		update_dl_entity(dl_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
-	} else if ((flags & ENQUEUE_RESTORE) &&
-		   !is_dl_boosted(dl_se) &&
-		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
-		setup_new_dl_entity(dl_se);
 	}
 
 	/*

> > Let me think about this for a bit...
> 
> Should prio_changed_dl() care about "dl_se->dl_deadline" having changed
> within the sched_change guard since that is the attribute that can be
> changed using sched_setattr() right?

__setparam_dl() changes dl_se->dl_deadline, as you say, but that does
not immediately affect the current dl_se->deadline. It will take effect
the next replenish.

That is, changing dl task attributes changes the next activation, not
the current. And since DL is a dynamic priority scheme, it doesn't
affect the current priority.

