Return-Path: <cgroups+bounces-10567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E9BBEE52
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 021A84E222F
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC827A444;
	Mon,  6 Oct 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CS5gBvo9"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DE38FA6;
	Mon,  6 Oct 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774487; cv=none; b=pOZ1tARYZX+pTDORnPJXpUBiVbas/54r+RN7asRH6jAGMgZBZFfcnMqZmcupseE9CyqeWsOpCNRPL5qiPWowOdROSr4ucHL5+xrM8GLFcdqH2YT4UM6Y5bgEqXDhjEzs71EbGZbdofld8hTGKgZTIwCtJuFL7KesoAu8+mBmyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774487; c=relaxed/simple;
	bh=3uRNiWVly4CAnAg3uAC85gdadwgEoKVbIoyClmEJbK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5I2rwqOl3d6l7PfwbZsAVsP3A8DtHR1pC9FdwvFLdwNRNsIWAJ/nKxJRP7O9vCTKMzNxD2rhTZ827d2CR6d5k2+9PAvROhKPGkKndh8U8F/P4ycicEeH7hZUTPfDSCZOJw/aDxhTi2S6MLMTY7ioGRF3CS5lG+D+Tsje+KNJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CS5gBvo9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xaUexNMvUYJY72kamRxZMI7KBSdMfJKNfOgDc1kRXDw=; b=CS5gBvo9jMBljOpCsFx5Zwh95q
	CT2/DA4FLbY+lWr3EbLy2XrTUlQ85h3xMzSq8NGqJLyNbUTT5LJN6EthVm4Smgn0IJv3qr7DXdEeq
	wWLBWrbDeX3+ha/pMSuew4xs0uwt0//W21XJm+3EvhFtgsDju7PdchGnsVgD3puPbK47plvIEi8dB
	+VnzgzR9382/sg1CTO4hLc/ECNv8078qlKKgdJaykChW/sEoD55DQIbAN83YehYxhNTiuvks/bFgv
	o/ChssjCCmnoboDsAbq/aLb7rYV/Tqy2Lm0tgsVcziZ/lSKev7aXc58XxA9ePE/cLKhDsDWJJ6O13
	jegZRMbw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5pjG-0000000H6Cb-0C5Z;
	Mon, 06 Oct 2025 18:14:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1EAA1300212; Mon, 06 Oct 2025 20:14:29 +0200 (CEST)
Date: Mon, 6 Oct 2025 20:14:29 +0200
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
Message-ID: <20251006181429.GV3245006@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
 <fee0edd5-86d1-4dff-9e07-70fd2208b073@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee0edd5-86d1-4dff-9e07-70fd2208b073@linux.ibm.com>

On Mon, Oct 06, 2025 at 08:51:27PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 9/10/25 9:14 PM, Peter Zijlstra wrote:
> > As proposed a long while ago -- and half done by scx -- wrap the
> > scheduler's 'change' pattern in a guard helper.
> > 
> [...]>   		put_task_struct(p);
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3860,23 +3860,22 @@ extern void check_class_changed(struct r
> >   extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
> >   extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
> > -#ifdef CONFIG_SCHED_CLASS_EXT
> > -/*
> > - * Used by SCX in the enable/disable paths to move tasks between sched_classes
> > - * and establish invariants.
> > - */
> > -struct sched_enq_and_set_ctx {
> > +struct sched_change_ctx {
> >   	struct task_struct	*p;
> > -	int			queue_flags;
> > +	int			flags;
> >   	bool			queued;
> >   	bool			running;
> >   };
> > -void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> > -			    struct sched_enq_and_set_ctx *ctx);
> > -void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
> > +struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags);
> > +void sched_change_end(struct sched_change_ctx *ctx);
> > -#endif /* CONFIG_SCHED_CLASS_EXT */
> > +DEFINE_CLASS(sched_change, struct sched_change_ctx *,
> > +	     sched_change_end(_T),
> > +	     sched_change_begin(p, flags),
> > +	     struct task_struct *p, unsigned int flags)
> > +
> > +DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
> >   #include "ext.h"
> could you please add a comment on matching flags on dequeue/enqueue
> here?

Would something like so be okay? This assumes at least the second patch
is applied as well.

---

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10783,6 +10783,12 @@ struct sched_change_ctx *sched_change_be
 	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
 
+	/*
+	 * Must exclusively use matched flags since this is both dequeue and
+	 * enqueue.
+	 */
+	WARN_ON_ONCE(flags & 0xFFFF0000);
+
 	lockdep_assert_rq_held(rq);
 
 	if (!(flags & DEQUEUE_NOCLOCK)) {

