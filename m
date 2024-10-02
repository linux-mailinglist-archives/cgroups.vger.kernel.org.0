Return-Path: <cgroups+bounces-5010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F001698D0DB
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 12:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE131F2264B
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4881E500A;
	Wed,  2 Oct 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b26alOTI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fA9Mcmqw"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB801FA5;
	Wed,  2 Oct 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863782; cv=none; b=PP4AJ4ygdhAzzHOpRvm5+Yl/BoGZOqnDaWyzdZj5vqT7iLfZC7OMRAspIaHxPwYdDbvLFcLPT8ca9KbvfmF3kXd6B/JXPngNWS+2vxwZQb97eZ6czIs4QCkgrFTa+uzo2QIQrahJN+PG2NLULAshtV/lS44aM9L3iIgeZm6TrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863782; c=relaxed/simple;
	bh=Y/9vQqpgJi3I0jIE80HY19tENyoegZHs3BQLz5bYcAs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t38kjXGpno2R7d4P57yx/1Kg28TeoxJFrYLnUoyNi+ZmyB9Zt7zWcdxUNed6acBNscdNzoJP/86E2KVJgi6ZD95ZX4aaPrMkosBTfs8cuVoCjJfqTEQN9CojgRnB3/SK7j0M2dlNyoyxEHoSI6rSx2PX6xJcmuYMx3fKxNggBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b26alOTI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fA9Mcmqw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727863778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mb59KJjSNfWC20EAWGOc9Up2meyWMry61XLe9mm8SOA=;
	b=b26alOTIwPE5WQO32GirhS4TLbLM6kdt4huW1uEKHWHg9REQ6vZVCPRpVuK+f0pQDmamCH
	Lg4WAgXV/D9nzTHeP7fVXL2qUxgnrR2EstRe+oPdc3RsC7px9oJ80Ny0UG4F9kRLyYVjxx
	mxRyuOcw7k+jIYgfANjqLbtcaoXnB//Fgakt/3JJ02yp0O60r3FO9QeF9wdN0p4EmqJZrR
	itmId45Crqo8YFSybbpl/qvNb5YR4Wnl4e1x9GedI0QHoCV9dMsWo4jl09TsDW4uH2W/rz
	6blpbcma4rsw+YpKUvjy/NH8r7vJJShlxRbTzNLfhyHEYW9QjswS1z5smu+yRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727863778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mb59KJjSNfWC20EAWGOc9Up2meyWMry61XLe9mm8SOA=;
	b=fA9McmqwiGJ2Uze93z7x2HZAlLxru5KvfJP6wS+2KS+YLtwYcvd0qpbxmQ2Rfx9rHbrjPO
	MHvcSHCeSlTUSIBg==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 ming.lei@redhat.com, pauld@redhat.com, juri.lelli@redhat.com,
 vschneid@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Costa Shulyupin <costa.shul@redhat.com>, Bjorn
 Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] genirq/cpuhotplug: Adjust managed irqs
 according to change of housekeeping CPU
In-Reply-To: <20240916122044.3056787-3-costa.shul@redhat.com>
References: <20240916122044.3056787-1-costa.shul@redhat.com>
 <20240916122044.3056787-3-costa.shul@redhat.com>
Date: Wed, 02 Oct 2024 12:09:38 +0200
Message-ID: <87h69uyfx9.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 16 2024 at 15:20, Costa Shulyupin wrote:

> Interrupts disturb real-time tasks on affined cpus.
> To ensure CPU isolation for real-time tasks, interrupt handling must
> be adjusted accordingly.
> Non-managed interrupts can be configured from userspace,
> while managed interrupts require adjustments in kernelspace.
>
> Adjust status of managed interrupts according change
> of housekeeping CPUs to support dynamic CPU isolation.

What means 'adjust status' ?

> +
> +/*
> + * managed_irq_isolate() - Deactivate managed interrupts if necessary
> + */
> +// derived from migrate_one_irq, irq_needs_fixup, irq_fixup_move_pending

If at all then this needs to be integrated with migrate_one_irq()

> +static int managed_irq_isolate(struct irq_desc *desc)
> +{
> +	struct irq_data *d = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(d);
> +	const struct cpumask *a;
> +	bool maskchip;
> +	int err;
> +
> +	/*
> +	 * Deactivate if:
> +	 * - Interrupt is managed
> +	 * - Interrupt is not per cpu
> +	 * - Interrupt is started
> +	 * - Effective affinity mask includes isolated CPUs
> +	 */
> +	if (!irqd_affinity_is_managed(d) || irqd_is_per_cpu(d) || !irqd_is_started(d)
> +	    || cpumask_subset(irq_data_get_effective_affinity_mask(d),
> +			      housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
> +		return 0;
> +	// TBD: it is required?
> +	/*
> +	 * Complete an eventually pending irq move cleanup. If this
> +	 * interrupt was moved in hard irq context, then the vectors need
> +	 * to be cleaned up. It can't wait until this interrupt actually
> +	 * happens and this CPU was involved.
> +	 */
> +	irq_force_complete_move(desc);
> +
> +	if (irqd_is_setaffinity_pending(d)) {
> +		irqd_clr_move_pending(d);
> +		if (cpumask_intersects(desc->pending_mask,
> +		    housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
> +			a = irq_desc_get_pending_mask(desc);
> +	} else {
> +		a = irq_data_get_affinity_mask(d);
> +	}
> +
> +	maskchip = chip->irq_mask && !irq_can_move_pcntxt(d) && !irqd_irq_masked(d);
> +	if (maskchip)
> +		chip->irq_mask(d);
> +
> +	if (!cpumask_intersects(a, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ))) {
> +		/*
> +		 * Shut managed interrupt down and leave the affinity untouched.
> +		 * The effective affinity is reset to the first online CPU.
> +		 */
> +		irqd_set_managed_shutdown(d);
> +		irq_shutdown_and_deactivate(desc);
> +		return 0;

Seriously? The interrupt is active and the queue might have outstanding
requests which will never complete because the interrupt is taken away.

On CPU hotplug the related subsystem has shut down the device queue and
drained all outstanding requests. But none of this happens here.

> +	}
> +
> +	/*
> +	 * Do not set the force argument of irq_do_set_affinity() as this
> +	 * disables the masking of offline CPUs from the supplied affinity
> +	 * mask and therefore might keep/reassign the irq to the outgoing
> +	 * CPU.

Which outgoing CPU?

> +	 */
> +	err = irq_do_set_affinity(d, a, false);
> +	if (err)
> +		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
> +				    d->irq, err);
> +
> +	if (maskchip)
> +		chip->irq_unmask(d);
> +
> +	return err;
> +}
> +
> +/** managed_irq_affinity_adjust() - Deactivate of restore managed interrupts
> + * according to change of housekeeping cpumask.
> + *
> + * @enable_mask:	CPUs for which interrupts should be restored
> + */
> +int managed_irq_affinity_adjust(struct cpumask *enable_mask)
> +{
> +	unsigned int irq;
> +
> +	for_each_active_irq(irq) {

What ensures that this iteration is safe?

> +		struct irq_desc *desc = irq_to_desc(irq);

And that the descriptor is valid?

> +		unsigned int cpu;
> +
> +		for_each_cpu(cpu, enable_mask)
> +			irq_restore_affinity_of_irq(desc, cpu);

And what protects irq_restore_affinity_of_irq() against other operations
on @desc?

> +		raw_spin_lock(&desc->lock);

What disables interrupts here in the runtime case?

> +		managed_irq_isolate(desc);
> +		raw_spin_unlock(&desc->lock);
> +	}
> +
> +	return 0;

That return value has which purpose?

None of this can work at runtime.

Thanks,

        tglx

