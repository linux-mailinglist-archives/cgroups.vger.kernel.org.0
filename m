Return-Path: <cgroups+bounces-10597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66564BC3892
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11957402B22
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 07:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13E12F0C73;
	Wed,  8 Oct 2025 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYgeZ3ax"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861019F137;
	Wed,  8 Oct 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907072; cv=none; b=MyxSuJPtZAwfjiPVSgpsEPUioE5AMWmiTsE5Dy3r9TupflXEvrnKpNqS6GCloeaqzJ6LiHu8PDZacns4VCSEILdd+iDhqslkVSAVGcWd26cJWIQowy68DYQ4VQ2uywVO/+m3DhQQKc/Vtd4Ne/YoJ77oLaYvvMs0ZypkYOvSOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907072; c=relaxed/simple;
	bh=Cn0hwA5a0OPNVqc8nD8QyTB2FElVcotJTS3Sy75LIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRKkfdM+3As7lCLw491hhfa75n++2AV6Z30BllcUor4G+CQDvKy5u59GOXAk4H9hRTOcjml9x4QmUSQvkqbKIiStuWGv+5A5qMf4EzHB2Fjm2cn2NFUmrWrsb6zYPFrPj47xWOwoNgqcbZVAj5ppT2LECrB3rN2hoWcRSzeNg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oYgeZ3ax; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m7/Waz38jPwvduLs9rjuvwGuLFIpbXU37o2+qitla4A=; b=oYgeZ3axbWt9sN8mFGCxFNJ1aD
	/9CywViu+n9+hW2cwcDMLgkCCBj7SiZuRZw2JMjjqoSfms5bg9uHimDZcoHhUYzztskfCFAh3Fl/C
	t6pJs8EwL+j+94KMJLhCuG1fizF/oRHOpIHxXHCxV9ZDXakhJhES2lJuvXRJcsPPc/pY3pVdJalVN
	ZhB3KI3F1iRRvjF8mevg+OVqFDVHXO2RdHIhm+eQK7ePMUCi+goeCk8+lOVJJrpb8qNMnCPGifw2X
	hH2TGbLNtcJb0cezMnBtnneXFLrmOBwGP5CNBxPW2ae46/zK8Zk4HyIar+Wn0d20iKVLL2xYjS0NG
	XO1JBVBQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ODj-000000001Av-1Fd4;
	Wed, 08 Oct 2025 07:04:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1743D300230; Wed, 08 Oct 2025 09:04:19 +0200 (CEST)
Date: Wed, 8 Oct 2025 09:04:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <20251008070419.GR4067720@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
 <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Oct 07, 2025 at 11:54:18AM +0200, Juri Lelli wrote:

> Not for this patch, but I wondered if, while we are at it, we wanted to
> complete documentation of these flags. My new AI friend is suggesting
> the following, is it very much garbage? :)

Heh; its not terrible. I've been playing with local LLMs, but mostly
I've found they struggle with getting enough context to not be utterly
demented. And when you up the context window, they get unusable slow :/

Setting up and configuring the whole pile of subtly interlocking stacks
of software to get anything useful out of this stuff is non-trivial (it
reminds me of the sendmail m4 days).

> ---
> 
> From: Claude <claude-sonnet-4-5@anthropic.com>
> Date: Mon, 7 Oct 2025 12:44:13 +0200
> Subject: sched: Document remaining DEQUEUE/ENQUEUE flags
> 
> Complete the flag documentation by adding descriptions for the three
> previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
> ENQUEUE_INITIAL.
> 
> DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
> traced, parked, dead, or frozen) that don't use the normal wait-loop
> pattern and must not use delayed dequeue.
> 
> DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
> CFS bandwidth throttling, preventing delayed dequeue to ensure proper
> throttling behavior.
> 
> ENQUEUE_INITIAL is used when enqueueing newly created tasks in
> wake_up_new_task(), allowing the fair scheduler to give them preferential
> initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).
> 
> Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
> Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>

Is this the generally acceptable form of attribution for these things?
I'm not sure what the official guidance is on using these AI tools.

Greg, you have any insights here?

> ---
>  kernel/sched/sched.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4c222fa8f908..1a2b3c8d9e4f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2364,10 +2364,20 @@ extern const u32		sched_prio_to_wmult[40];
>   * CLASS - going to update p->sched_class; makes sched_change call the
>   *         various switch methods.
>   *
> + * DEQUEUE_SPECIAL - task is in a special state (STOPPED, TRACED, PARKED,
> + *                   DEAD, FROZEN) that doesn't use the normal wait-loop;
> + *                   disables delayed dequeue.
> + *
> + * DEQUEUE_THROTTLE - dequeuing due to CFS bandwidth throttling; disables
> + *                    delayed dequeue to ensure proper throttling.
> + *
>   * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
>   * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
>   * ENQUEUE_MIGRATED  - the task was migrated during wakeup
> + * ENQUEUE_INITIAL   - enqueuing a newly created task in wake_up_new_task();
> + *                     fair scheduler may give preferential initial placement
> + *                     (e.g., half vslice with PLACE_DEADLINE_INITIAL).
>   * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
>   *
>   */
> 

