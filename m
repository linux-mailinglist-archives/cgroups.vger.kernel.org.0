Return-Path: <cgroups+bounces-12138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E663C7570F
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EE3579A8
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3729236BCF0;
	Thu, 20 Nov 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aG1Us5DA"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A436B051
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656495; cv=none; b=Wx3UpVdGYggfzwut4gNA98BpCpYL1xzE/vL0d5Gx6OL1xb9N2bTDeFZee4rFpVMFnP/G7Db1LuGGVZPsziJZyPW45Ov2tNVPQJRcv+EbUVxodSKX9Sr7GrdMzPs4g/SUIosBe7hPDQKlf6LpGKEBVtBNjsgIm5iPEIwuCVn6xoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656495; c=relaxed/simple;
	bh=L8e01bVeRpJNa2xXlevIZ6rEwVJmrNFuaJknDvmBMIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=P8x0LvPHs5X49/pVKITXcpsNbQ4nP77sSmqOJpfJNeT4KCesofSPKnvB83cbmbhzQAh/AVUQFS50UpOMLy+Jqhw2cp4lASvZctLwfuZFURB5GKdBJw0Atrw1T0UGiQobn5b3aTq2QTm93xolBKgzH3ZxPgRUJhf6x+V47ksJbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aG1Us5DA; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251120163444euoutp01297acd81729e92ea9110510c50701fcc~5xDqPZttu0783907839euoutp01O
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 16:34:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251120163444euoutp01297acd81729e92ea9110510c50701fcc~5xDqPZttu0783907839euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763656484;
	bh=/4l9bxW2WG98+D244ekjYvpiLBiJr1pAm9r+mZr1TmU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aG1Us5DAKrZtqovWN4X0RZxCpNTehq3aMnFH3Dv2tlOFiJ5gfIcIG2nftg3aXipq8
	 kZokzfeEuTxVe+4bo6tJ4XjM7FWcUeL2RexBTr93Z3WV9VVb80mge2wtWglY8ee4x9
	 A6lqvfnZIU/bGdf0A+/JcKXObPWr7X6dEtR5vdeg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251120163444eucas1p2617aaf878354a84cbbd5e7471fcef66c~5xDp8JYvO2219922199eucas1p2s;
	Thu, 20 Nov 2025 16:34:44 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251120163443eusmtip2a8436a3720603c140345965c56ee9928~5xDpWIzJ92439624396eusmtip2E;
	Thu, 20 Nov 2025 16:34:43 +0000 (GMT)
Message-ID: <13ba4125-8972-4ddb-b630-96e89bdd7248@samsung.com>
Date: Thu, 20 Nov 2025 17:34:43 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
	<marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <87tsyokaug.ffs@tglx>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251120163444eucas1p2617aaf878354a84cbbd5e7471fcef66c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28
X-EPHeader: CA
X-CMS-RootMailID: 20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28
References: <20251118143052.68778-1-frederic@kernel.org>
	<20251118143052.68778-2-frederic@kernel.org>
	<CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>
	<73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
	<aR8VoUxBncOu4H47@localhost.localdomain> <87tsyokaug.ffs@tglx>

On 20.11.2025 16:00, Thomas Gleixner wrote:
> On Thu, Nov 20 2025 at 14:20, Frederic Weisbecker wrote:
>> Le Thu, Nov 20, 2025 at 12:51:31PM +0100, Marek Szyprowski a écrit :
>>> On 18.11.2025 15:30, Frederic Weisbecker wrote:
>>>> When a cpuset isolated partition is created / updated or destroyed,
>>>> the IRQ threads are affine blindly to all the non-isolated CPUs. And
>>>> this happens without taking into account the IRQ thread initial
>>>> affinity that becomes ignored.
>>>>
>>>> For example in a system with 8 CPUs, if an IRQ and its kthread are
>>>> initially affine to CPU 5, creating an isolated partition with only
>>>> CPU 2 inside will eventually end up affining the IRQ kthread to all
>>>> CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for
>>>> CPU 5.
>>>>
>>>> Besides the blind re-affinity, this doesn't take care of the actual
>>>> low level interrupt which isn't migrated. As of today the only way to
>>>> isolate non managed interrupts, along with their kthreads, is to
>>>> overwrite their affinity separately, for example through /proc/irq/
>>>>
>>>> To avoid doing that manually, future development should focus on
>>>> updating the IRQs affinity whenever cpuset isolated partitions are
>>>> updated.
>>>>
>>>> In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
>>>> To prevent from that, set the PF_NO_SETAFFINITY flag to them.
>>>>
>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> This patch landed in today's linux-next as commit 844dcacab287 ("genirq:
>>> Fix interrupt threads affinity vs. cpuset isolated partitions"). In my
>>> tests I found that it triggers a warnings on some of my test systems.
>>> This is example of such warning:
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 1 at kernel/kthread.c:599 kthread_bind_mask+0x2c/0x84
>> Erm, does this means that the IRQ thread got awaken before the first official
>> wakeup in wake_up_and_wait_for_irq_thread_ready()? This looks wrong...
>>
>> irq_startup() may be called on a few occcasions before. So perhaps
>> the IRQ already fired and woke up the kthread once before the "official"
>> first wake up?
>>
>> There seem to be some initialization ordering issue here...
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
>        1) Bind the thread right after kthread_create() to a random
>           housekeeping task and let move itself over to the real place
>           once it came up (at this point the affinity is established)
>
>        2) Serialize the setup so that the thread (even, when woken up
>           early) get's stuck in UNINTERRUPTIBLE state _before_ it can
>           reach wait_for_interrupt() which waits with INTERRUPTIBLE
>
>        3) Teach kthread_create() that the thread is subject to being
>           bound to something later on and implement that serialization
>           there.
>
> #1 is pretty straight forward. See untested below.

This fixes the observed issue. The only problem with that patch is 
incorrect set of arguments to kthread_create_on_cpu() (it doesn't 
support printf-style args).

If that matters:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> #2 is ugly (I tried)
>
> #3 could be useful in general, but that needs more thoughts
>
> Thanks
>
>          tglx
> ---
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -133,7 +133,15 @@ void __irq_wake_thread(struct irq_desc *
>   	 */
>   	atomic_inc(&desc->threads_active);
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
>   }
>   
>   static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1026,16 +1026,8 @@ static void irq_thread_check_affinity(st
>   	set_cpus_allowed_ptr(current, mask);
>   	free_cpumask_var(mask);
>   }
> -
> -static inline void irq_thread_set_affinity(struct task_struct *t,
> -					   struct irq_desc *desc)
> -{
> -	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
> -}
>   #else
>   static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
> -static inline void irq_thread_set_affinity(struct task_struct *t,
> -					   struct irq_desc *desc) { }
>   #endif
>   
>   static int irq_wait_for_interrupt(struct irq_desc *desc,
> @@ -1220,7 +1212,6 @@ static void wake_up_and_wait_for_irq_thr
>   	if (!action || !action->thread)
>   		return;
>   
> -	irq_thread_set_affinity(action->thread, desc);
>   	wake_up_process(action->thread);
>   	wait_event(desc->wait_for_threads,
>   		   test_bit(IRQTF_READY, &action->thread_flags));
> @@ -1389,26 +1380,35 @@ static void irq_nmi_teardown(struct irq_
>   static int
>   setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>   {
> +	/*
> +	 * At this point interrupt affinity is not known. just assume that
> +	 * the current CPU is not isolated and valid to bring the thread
> +	 * up. The thread will move itself over to the right place once the
> +	 * whole setup is complete.
> +	 */
> +	unsigned int cpu = raw_smp_processor_id();
>   	struct task_struct *t;
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
> +		t = kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-s-%s", irq, new->name);
>   
>   	if (IS_ERR(t))
>   		return PTR_ERR(t);
>   
>   	/*
> -	 * We keep the reference to the task struct even if
> -	 * the thread dies to avoid that the interrupt code
> -	 * references an already freed task_struct.
> +	 * We keep the reference to the task struct even if the thread dies
> +	 * to avoid that the interrupt code references an already freed
> +	 * task_struct.
>   	 */
>   	new->thread = get_task_struct(t);
>   
> +	/*
> +	 * Ensure the thread adjusts the affinity once it reaches the
> +	 * thread function.
> +	 */
> +	new->thread_flags = BIT(IRQTF_AFFINITY);
>   	return 0;
>   }
>   
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


