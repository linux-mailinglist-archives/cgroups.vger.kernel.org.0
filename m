Return-Path: <cgroups+bounces-2955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607A8C8F0B
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 03:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715981C211D6
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 01:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764910E5;
	Sat, 18 May 2024 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="og1rA74f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1lmw0SV5"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AA637;
	Sat, 18 May 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715995048; cv=none; b=lN0zMegt/mJ/cl6fMW75XKSLPaSvk+MfBQ2ipXRBO2s1BHQ1sXoOEYog607lygZ4XDqGmGjco9X1YYf5tw8BbBsY7jj2KrhJbSq4gs3kiUHHDYu8foa4vRBKCGaKIJBPm+g5bY34E/8s9tvk7STwSFj063nAPV4k9FewfT3o7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715995048; c=relaxed/simple;
	bh=jl2/O6SsEzi4qBJJPJxENY9IyDg4cYXwXf3Gw42XRBE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktcPWDQ3jIt4zfjN+h2qdUw/WJCswdINLS3PAKfp4ksQ4wANDUenHfIhbLKvfm94FWghLRTNpbA3MD14yw2UEkqQu/g6Brq3s8z3CZ7DsKxyHwAFGkd+vaatxUb99Ey8MRiTG0XEpzqqPYGzNMvcwxHcmhR37T0z2C4IDpEy2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=og1rA74f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1lmw0SV5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715995045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKkeJQ6Dmsf/dRgxmgzUJWJVJs34oG/JmnsLODFboy4=;
	b=og1rA74f9epq34KedtsKdAHOvqUTX6vrRcpS9A83i9JH5ON1YsHERohzXdGR0SCsMyDyRG
	3z2hrBFbtXVzZR2NhsY+ooO6gUJzvEbyeUxPnF3LChfMirjXgssy6VXSdu1aTfg84DqkN6
	BrkmeR+nU1NEOZpdsQSoIATTydfQaCnTxZOjyVJscnjafyUJusL4raczKILKNYKBSYJ+AI
	phULBml8IS87h9pdYcArlqHL2sm6kwDYmaYMbqZ/Zwp/Muxxy2O8n+Sk8nejwTT9Z7kuI2
	4oJeKI9ZPISWw86cm/uoZsjjDBoUXBLqbpB//ZJMQa5xho8WQtOtTqdH39hLRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715995045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKkeJQ6Dmsf/dRgxmgzUJWJVJs34oG/JmnsLODFboy4=;
	b=1lmw0SV5TcVRgrtoM+9+YFgeKaKrydRHRINsNPvdIdw4QYVz81VPI6bBM061EmZe3RxPzF
	Z4By2FS/MfyIttBA==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 pauld@redhat.com, juri.lelli@redhat.com, prarit@redhat.com,
 vschneid@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Costa
 Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v1 4/7] sched/isolation: Adjust affinity of managed irqs
 according to change of housekeeping cpumask
In-Reply-To: <20240516190437.3545310-5-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-5-costa.shul@redhat.com>
Date: Sat, 18 May 2024 03:17:24 +0200
Message-ID: <87wmnrj4uz.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 16 2024 at 22:04, Costa Shulyupin wrote:
> irq_affinity_adjust() is prototyped from irq_affinity_online_cpu()
> and irq_restore_affinity_of_irq().

I'm used to this prototyped phrase by now. It still does not justify to
expose me to this POC hackery.

My previous comments about change logs still apply.

> +static int irq_affinity_adjust(cpumask_var_t disable_mask)
> +{
> +	unsigned int irq;
> +	cpumask_var_t mask;
> +
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	irq_lock_sparse();
> +	for_each_active_irq(irq) {
> +		struct irq_desc *desc = irq_to_desc(irq);
> +
> +		raw_spin_lock_irq(&desc->lock);

That's simply broken. This is not CPU hotplug on an outgoing CPU. Why
are you assuming that your isolation change code can rely on the
implicit guarantees of CPU hot(un)plug?

Also there is a reason why interrupt related code is in kernel/irq/* and
not in some random other location. Even if C allows you to fiddle with
everything that does not mean that hiding random hacks in other places
is correct in any way.

> +		struct irq_data *data = irq_desc_get_irq_data(desc);
> +
> +		if (irqd_affinity_is_managed(data) && cpumask_weight_and(disable_mask,
> +			irq_data_get_affinity_mask(data))) {

Interrupt target isolation is only relevant for managed interrupts and
non-managed interrupts clearly are going to migrate themself away
magically, right?

> +
> +			cpumask_and(mask, cpu_online_mask, irq_default_affinity);
> +			cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));

There are clearly a lot of comments explaining what this is doing and
why it is correct as there is a guarantee that these masks overlap by
definition.

> +			irq_set_affinity_locked(data, mask, true);

Plus the extensive explanation why using 'force=true' is even remotely
correct here.

I conceed that the documentation of that function and its arguments is
close to non-existant, but if you follow the call chain of that function
there are enough hints down the road, no?

> +			WARN_ON(cpumask_weight_and(irq_data_get_effective_affinity_mask(data),
> +						disable_mask));
> +			WARN_ON(!cpumask_subset(irq_data_get_effective_affinity_mask(data),
> +						cpu_online_mask));
> +			WARN_ON(!cpumask_subset(irq_data_get_effective_affinity_mask(data),
> +						housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)));

These warnings are required and useful within the spinlock held and
interrupt disabled section because of what?

 - Because the resulting stack trace provides a well known call chain

 - Because the resulting warnings do not tell anything about the
   affected interrupt number

 - Because the resulting warnings do not tell anything about the CPU
   masks which cause the problem

 - Because the aggregate information of the above is utterly useless

Impressive...

Thanks,

       tglx

