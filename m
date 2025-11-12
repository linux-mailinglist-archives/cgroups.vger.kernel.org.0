Return-Path: <cgroups+bounces-11863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728FC52607
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7CE3B0679
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD632C95D;
	Wed, 12 Nov 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY7dS6CT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DA328B73;
	Wed, 12 Nov 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952187; cv=none; b=tAfnx230yJxBf5qbGFcPT1m88gMcDVMWC5EAsyrsxCOACjLY+7eCfAwJ04fJ9TJoc5fiMi65UqbWHSyoOwI3HyPUmt2V2t7UUtF7bgySEmtSRqDv3bWj3AF1XQ16EWss9zbEgrCg3fp9Z2lIalkGF6P5DdldWDLwbJZOSPX9utU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952187; c=relaxed/simple;
	bh=J+FO8rTuxAuIuSLNonP5wf90/amTae3wDl1vcSvuonk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7LlKVZMSWW67KkB7ZadghHj3l+5sWVpliUd++1vamurp6I6TTPHp4TpLTFxufJ20HNNV7R7tDU+8Z3p7gsq/kHBU7R6Wp9pb5Dl4R7AYL0SUryDzDNEqg/6/6U0W+wM3oAytWFdP7jDlVbJUU29iwTdP/3CVU6tNe4BU18tCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY7dS6CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2E7C116B1;
	Wed, 12 Nov 2025 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762952187;
	bh=J+FO8rTuxAuIuSLNonP5wf90/amTae3wDl1vcSvuonk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dY7dS6CTElHmVc1niZeY+/LX7O6VVu+Wn/9n2JnlkQ3fu3W6EsJuxGufCtYjh+/AI
	 CsJxMpd5FHncxpEXKy7BYdDQV6+rXc0eg8XuH4qQPhohRe28pjTy+Kd7WYMaSpllk+
	 dW1bK5rMQGCW5098wV2IP5Bkfr5GYN8FVZnj+dzdAdOhEt8lYDpG49z4Wk6dM8WjXS
	 DVWslIn3SBF9L/oryv76A0nd+O8TJ3qXikt/tLfFLn5LxDp17EekgRJCUnx8g7H4O7
	 UkSqgG5fWrql9wBXQ62IZqua6ZqtzTHsWWTCkDfyL5qRgBtXnk05cVA/2mML4DbgCS
	 /iP6izZJzZ+IA==
Date: Wed, 12 Nov 2025 13:56:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
Message-ID: <aRSD-Fyy87qhCR6C@localhost.localdomain>
References: <20251105131726.46364-1-frederic@kernel.org>
 <5d3d80dd-00ca-464d-bebf-c0fd4836b947@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d3d80dd-00ca-464d-bebf-c0fd4836b947@redhat.com>

Le Mon, Nov 10, 2025 at 04:28:49PM -0500, Waiman Long a écrit :
> On 11/5/25 8:17 AM, Frederic Weisbecker wrote:
> > When a cpuset isolated partition is created / updated or destroyed,
> > the IRQ threads are affine blindly to all the non-isolated CPUs. And
> > this happens without taking into account the IRQ thread initial
> > affinity that becomes ignored.
> > 
> > For example in a system with 8 CPUs, if an IRQ and its kthread are
> > initially affine to CPU 5, creating an isolated partition with only
> > CPU 2 inside will eventually end up affining the IRQ kthread to all
> > CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for
> > CPU 5.
> > 
> > Besides the blind re-affinity, this doesn't take care of the actual
> > low level interrupt which isn't migrated. As of today the only way to
> > isolate non managed interrupts, along with their kthreads, is to
> > overwrite their affinity separately, for example through /proc/irq/
> > 
> > To avoid doing that manually, future development should focus on
> > updating the IRQs affinity whenever cpuset isolated partitions are
> > updated.
> > 
> > In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
> > To prevent from that, set the PF_NO_SETAFFINITY flag to them.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   kernel/irq/manage.c | 33 ++++++++++++++++++++-------------
> >   1 file changed, 20 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index 400856abf672..5ca000c9f4a7 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -176,7 +176,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
> >   }
> >   /**
> > - * irq_set_thread_affinity - Notify irq threads to adjust affinity
> > + * irq_thread_update_affinity - Notify irq threads to adjust affinity
> >    * @desc:	irq descriptor which has affinity changed
> >    *
> >    * Just set IRQTF_AFFINITY and delegate the affinity setting to the
> > @@ -184,7 +184,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
> >    * we hold desc->lock and this code can be called from hard interrupt
> >    * context.
> >    */
> > -static void irq_set_thread_affinity(struct irq_desc *desc)
> > +static void irq_thread_update_affinity(struct irq_desc *desc)
> >   {
> >   	struct irqaction *action;
> > @@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >   		fallthrough;
> >   	case IRQ_SET_MASK_OK_NOCOPY:
> >   		irq_validate_effective_affinity(data);
> > -		irq_set_thread_affinity(desc);
> > +		irq_thread_update_affinity(desc);
> >   		ret = 0;
> >   	}
> > @@ -1035,8 +1035,23 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
> >   		set_cpus_allowed_ptr(current, mask);
> >   	free_cpumask_var(mask);
> >   }
> > +
> > +static inline void irq_thread_set_affinity(struct task_struct *t,
> > +					   struct irq_desc *desc)
> > +{
> > +	const struct cpumask *mask;
> > +
> > +	if (cpumask_available(desc->irq_common_data.affinity))
> > +		mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
> > +	else
> > +		mask = cpu_possible_mask;
> > +
> > +	kthread_bind_mask(t, mask);
> > +}
> 
> This function seems to mirror what is done in irq_thread_check_affinity()
> when the affinity cpumask is available.  But if affinity isn't defined, it
> will make this irq kthread immune from changes in the set of isolated CPUs.
> Should we use IRQD_AFFINITY_SET flag to check if affinity has been set and
> then set PF_NO_SETAFFINITY only in this case?

So IIUC, the cpumask_available() failure can't really happen because an allocation
failure would make irq_alloc_descs() fail.

__irq_alloc_descs() -> alloc_descs() -> alloc_desc() -> init_desc() - > alloc_mask()

The error doesn't seem as well handled in early_irq_init() but the desc is freed
anyway if that happens.

So this is just a sanity check at best.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

