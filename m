Return-Path: <cgroups+bounces-12137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8FC752A2
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2DAD355BAE
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A43376AC;
	Thu, 20 Nov 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REqgaIUH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D952DF12F;
	Thu, 20 Nov 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653808; cv=none; b=MWSc0zg8Bp02l10uxokZK52MQLBFalpOt2skIR88d5/Cez1Om7hgKzVhCr4jBp7aBeqStM+0gvzPfVGFb0nezv1fBpcvYizq1X+sHJ20DigE/Ufn+R2MdZvi2gC1IHaHLxe6B2ZK/Na4FWrPOqMozsefJESAeUjoWm3pzp+OvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653808; c=relaxed/simple;
	bh=E8W5wB9ILRFWlkosDe9UYAaPJB4ebzVmIqBoyO1Qi4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX7jDjfMdhMs+6G7cY28C1dT1dy5q6kTiJueQ6A8hAoPG+nUyTzwsPt88aBTYXe9ecTBwcrpE5TcqamH8WQ/HYg3SHeufL7gTwSdrzqYKeVLKtzMqDPE+hS9ajJE/397//Dl7TShBHv26jeaQd2hK2oszIJpjxHmCe2hts5s6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REqgaIUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2BCC4CEF1;
	Thu, 20 Nov 2025 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653806;
	bh=E8W5wB9ILRFWlkosDe9UYAaPJB4ebzVmIqBoyO1Qi4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REqgaIUH3Oq/EWHYRFJDzqd3/POWOwZyw0KeH1RH4jetHVfOMuUGSR5AwXAZSucB/
	 ee9llV366ohMgQIka1COzoFZXc8Mp5ObGztPke2m+QjcMJX+Y5e+64HJfbETXM3JEw
	 W4qVbsVmucEtb51OKLsUYPLWt8b9ODTJse3GMViICmpfpLU513RB0QoXFbkU52s0gy
	 lbYPBSKIKgCzoLCG4/E7eqQBT6VMMK2ZPuDWvGwJIaIGrzJ2lgEPCAZh0h5i0pMqoh
	 /IzlqjNuuyefR8MNLS2c9/8fQTuhmVN3dpCDAHtJT2FSss2cOImlZObirQtbBYFLaJ
	 ZG9TZSKxZWwfA==
Date: Thu, 20 Nov 2025 16:50:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
Message-ID: <aR84qyZp3PyH5xFg@localhost.localdomain>
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>
 <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
 <aR8VoUxBncOu4H47@localhost.localdomain>
 <87tsyokaug.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsyokaug.ffs@tglx>

Le Thu, Nov 20, 2025 at 04:00:39PM +0100, Thomas Gleixner a écrit :
> On Thu, Nov 20 2025 at 14:20, Frederic Weisbecker wrote:
> > Erm, does this means that the IRQ thread got awaken before the first official
> > wakeup in wake_up_and_wait_for_irq_thread_ready()? This looks wrong...
> >
> > irq_startup() may be called on a few occcasions before. So perhaps
> > the IRQ already fired and woke up the kthread once before the "official"
> > first wake up?
> >
> > There seem to be some initialization ordering issue here...
> 
> That's unavoidable because of locking and hen and egg ordering problems.
> 
> When the thread is created the interrupt is not yet started up and
> therefore effective affinity is not known. So doing a bind there is
> pointless.
> 
> The action has to be made visible _before_ starting it up as once the
> interrupt is unmasked it might fire. That's even more true for shared
> interrupts.
> 
> The wakeup/bind/... muck cannot be invoked with the descriptor lock
> held, so it has to be done _after_ the thing went live.
> 
> So yes an interrupt which fires before kthread_bind() is invoked might
> exactly have that effect. It wakes it from the kthread() wait and it
> goes straight through to the thread function.
> 
> That's why the original code just set the affinity bit and let the
> thread itself handle it.
> 
> There are three options to solve that:
> 
>       1) Bind the thread right after kthread_create() to a random
>          housekeeping task and let move itself over to the real place
>          once it came up (at this point the affinity is established)
> 
>       2) Serialize the setup so that the thread (even, when woken up
>          early) get's stuck in UNINTERRUPTIBLE state _before_ it can
>          reach wait_for_interrupt() which waits with INTERRUPTIBLE
> 
>       3) Teach kthread_create() that the thread is subject to being
>          bound to something later on and implement that serialization
>          there.
> 
> #1 is pretty straight forward. See untested below.

Right.

> 
> #2 is ugly (I tried)

Ok...

> 
> #3 could be useful in general, but that needs more thoughts

A lot of thoughts yes given the many things to consider (kthread
automatic affinity handling, etc...).

And if we do that we must always affine the IRQ threads remotely
to avoid conflict with them. But that can be a problem with locking,
etc...

> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -133,7 +133,15 @@ void __irq_wake_thread(struct irq_desc *
>  	 */
>  	atomic_inc(&desc->threads_active);
>  
> -	wake_up_process(action->thread);
> +	/*
> +	 * This might be a premature wakeup before the thread reached the
> +	 * thread function and set the IRQTF_READY bit. It's waiting in
> +	 * kthread code with state UNINTERRUPTIBLE. Once it reaches the
> +	 * thread function it waits with INTERRUPTIBLE. The wakeup is not
> +	 * lost in that case because the thread is guaranteed to observe
> +	 * the RUN flag before it goes to sleep in wait_for_interrupt().
> +	 */
> +	wake_up_state(action->thread, TASK_INTERRUPTIBLE);
>  }
>  
>  static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1026,16 +1026,8 @@ static void irq_thread_check_affinity(st
>  	set_cpus_allowed_ptr(current, mask);
>  	free_cpumask_var(mask);
>  }
> -
> -static inline void irq_thread_set_affinity(struct task_struct *t,
> -					   struct irq_desc *desc)
> -{
> -	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
> -}
>  #else
>  static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
> -static inline void irq_thread_set_affinity(struct task_struct *t,
> -					   struct irq_desc *desc) { }
>  #endif
>  
>  static int irq_wait_for_interrupt(struct irq_desc *desc,
> @@ -1220,7 +1212,6 @@ static void wake_up_and_wait_for_irq_thr
>  	if (!action || !action->thread)
>  		return;
>  
> -	irq_thread_set_affinity(action->thread, desc);
>  	wake_up_process(action->thread);
>  	wait_event(desc->wait_for_threads,
>  		   test_bit(IRQTF_READY, &action->thread_flags));
> @@ -1389,26 +1380,35 @@ static void irq_nmi_teardown(struct irq_
>  static int
>  setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>  {
> +	/*
> +	 * At this point interrupt affinity is not known. just assume that
> +	 * the current CPU is not isolated and valid to bring the thread
> +	 * up. The thread will move itself over to the right place once the
> +	 * whole setup is complete.
> +	 */
> +	unsigned int cpu = raw_smp_processor_id();
>  	struct task_struct *t;
>  
> -	if (!secondary) {
> -		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
> -				   new->name);
> -	} else {
> -		t = kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
> -				   new->name);
> -	}
> +	if (!secondary)
> +		t = kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-%s", irq, new->name);
> +	else
> +		t = kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-s-%s",
> -		irq, new->name);

Right I though about something like that, it involved:

kthread_bind_mask(t, cpu_possible_mask);

Which do you prefer? Also do you prefer such a fixup or should I refactor my
patches you merged?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

