Return-Path: <cgroups+bounces-11864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA4C52649
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791E23A1CF5
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592F33557B;
	Wed, 12 Nov 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXMxI5CO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2223ABA1;
	Wed, 12 Nov 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952410; cv=none; b=Uz3znbygou+97Pf/cj2ULhhkhDAPflwpJngumcIstq6YxNH4cgAMeXYr7LzquTfeSRyJUKbqEurdoskbJb8RGolRPnaT8lDn3yXozJVHsqytwBr74JxHSm3RkXSVnQVtwMACwkUSo3tkQOpS+N+8cOTpvcsslr1p53ALAsdTXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952410; c=relaxed/simple;
	bh=0HaLe2gNL7ont5LOICHqqQrLuo+dYo01HdsnDzUuumI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grOZl0g+OHYYTHhGrJogMMPB2NEImgRgffa1LILVshOo5gj1AFWbSxADvNw/E8m8T3qH2CCsiilY6mYzyYHXjPuNkzvqQZcz+vrMvPkJbG71/esgc8KrO+l9p46YU6XdVnf3bmRwbnGy/f6/omT9XYYUjgf1Ct90bCEg3n0GqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXMxI5CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06D8C4CEF8;
	Wed, 12 Nov 2025 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762952410;
	bh=0HaLe2gNL7ont5LOICHqqQrLuo+dYo01HdsnDzUuumI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXMxI5COf7TJMZFSLGF2JbY6TWMpb+swhx2IgZ6EUrTfQoM5GLWkM/q6iSQLIloLV
	 ebccs9QJZ2K87HU7jAC/Xlh3l37Bbc4qB5o0nCIuNoteOcsQtMjjsFXRWwCzxqL2jq
	 tOQZz2YWHOJurjDXOSJzMXVpLQRlwKDgZeiSW7bmzKNtY6sX3f2/6TsUOYsMHKBq3S
	 srcFfzVZRebz1rnHmUyPQRdFz06qfrO3KGpbFgHut9qlGFR9AtwSH6JcCwZEoX62BV
	 Zxm5x1aeLrttCtKPoTYkw/hP5QSMden0PeXjCwc7fl4cbLDJEP6gKfgKNOcrZBHz15
	 DWtnyl3auf3eQ==
Date: Wed, 12 Nov 2025 14:00:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
Message-ID: <aRSE17zEW7IdYkCA@localhost.localdomain>
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

Oh and if IRQD_AFFINITY_SET hasn't been set, then the cpuset shouldn't touch
the kthread affinity directly either but reaffine the whole IRQ so that both
the vector and its kthreads are moved away and not just the kthreads.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

