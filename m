Return-Path: <cgroups+bounces-11463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D33C25DD3
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 16:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3801A27725
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F9E2E093C;
	Fri, 31 Oct 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgZioyMf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1732D9EE0;
	Fri, 31 Oct 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924966; cv=none; b=LFSgZrGfvp1rH24TGF9JnpZ1yl8O5MJDIA675l2SiE1VtA6+fHx6lCl0CApQZ489ORialwLeuYeFSB3+SW2T1JLbiS9c7U1wPORzSsW9EEZMLB25xaLeGqJHf6/OcMzD04MCTLi97zbRHZR8eqYkvB9WV7JvDASBEKe+48CO0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924966; c=relaxed/simple;
	bh=f2kdcTzIgflTZpNVJcpB/wXw4Pn7v3oe8LGnD3Ghpv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNs+RM3QtDWkDhDH5hv9rLUYC/XW9hFzBPQ9AtrF911at0jFjw7SejBJZB9DvKVPdylrsz8B9eX20ZnTNruL3al40CMVwwfSRHokNITtI66ImNEpZcaub/0g0p6E0A3Z97+Ft3o1QjhmArcO3ls8YLea/9cYd5OeMbKK1Z/tLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgZioyMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3AEC4CEE7;
	Fri, 31 Oct 2025 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924964;
	bh=f2kdcTzIgflTZpNVJcpB/wXw4Pn7v3oe8LGnD3Ghpv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgZioyMfejcWWV0MS6C05S2LbsEdxX50diKJLFbw9ByzTss1Ijd602OkOPk5VfJ9K
	 BRKcnvMU8FhGuOYJD6IlhqxkvqA74T7C11v39u1D+WoQbt6yJqS7412XtCYdJe0PHy
	 Ln62jNHD5VjGRqjBBZSBa4jUMaVRdwp5bzP89/ZWKaQCzVlnK86qZsU+w4X0SXlEbI
	 lRkg7pYEBULQLbHiEuqIewp4ucaxmKc3j/liAl9yD7UK/IyLDT6JMbpqc1UA7U21O9
	 xfmguuXRFsOBFWFtnYsZeHmVkddUjMRhYiHjr9QoNL/wS5AGPYJo2404lc9S1uCEeI
	 AAsxziPBgXXWA==
Date: Fri, 31 Oct 2025 16:36:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
Message-ID: <aQTXYSyPS65nhkvl@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-6-frederic@kernel.org>
 <xhsmhecqtoc4b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhecqtoc4b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Thu, Oct 23, 2025 at 05:45:40PM +0200, Valentin Schneider a écrit :
> On 13/10/25 22:31, Frederic Weisbecker wrote:
> > HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> > but also cpuset isolated partitions.
> >
> > Housekeeping still needs a way to record what was initially passed
> > to isolcpus= in order to keep these CPUs isolated after a cpuset
> > isolated partition is modified or destroyed while containing some of
> > them.
> >
> > Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > ---
> >  include/linux/sched/isolation.h | 1 +
> >  kernel/sched/isolation.c        | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index d8501f4709b5..da22b038942a 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/tick.h>
> >
> >  enum hk_type {
> > +	HK_TYPE_DOMAIN_BOOT,
> >       HK_TYPE_DOMAIN,
> >       HK_TYPE_MANAGED_IRQ,
> >       HK_TYPE_KERNEL_NOISE,
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index a4cf17b1fab0..8690fb705089 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -11,6 +11,7 @@
> >  #include "sched.h"
> >
> >  enum hk_flags {
> > +	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
> >       HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
> >       HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
> >       HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> > @@ -216,7 +217,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >
> >               if (!strncmp(str, "domain,", 7)) {
> >                       str += 7;
> > -			flags |= HK_FLAG_DOMAIN;
> > +			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
> >                       continue;
> >               }
> >
> > @@ -246,7 +247,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >
> >       /* Default behaviour for isolcpus without flags */
> >       if (!flags)
> > -		flags |= HK_FLAG_DOMAIN;
> > +		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
> 
> I got stupidly confused by the cpumask_andnot() used later on since these
> are housekeeping cpumasks and not isolated ones; AFAICT HK_FLAG_DOMAIN_BOOT
> is meant to be a superset of HK_FLAG_DOMAIN - or, put in a way my brain
> comprehends, NOT(HK_FLAG_DOMAIN) (i.e. runtime isolated cpumask) is a
> superset of NOT(HK_FLAG_DOMAIN_BOOT) (i.e. boottime isolated cpumask),
> thus the final shape of cpu_is_isolated() makes sense:
> 
>   static inline bool cpu_is_isolated(int cpu)
>   {
>           return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
>   }

Right, I get confused myself as well. I've been thinking several times about
inverting those housekeeping masks to work instead with isolated masks. But I'm
not sure that would make the APIs easier to use.

> Could we document that to make it a bit more explicit? Maybe something like
> 
>   enum hk_type {
>         /* Set at boot-time via the isolcpus= cmdline argument */
>         HK_TYPE_DOMAIN_BOOT,
>         /*
>          * Updated at runtime via isolated cpusets; strict subset of
>          * HK_TYPE_DOMAIN_BOOT as it accounts for boot-time isolated CPUs.
>          */
>         HK_TYPE_DOMAIN,
>         ...
>   }

I thought I did already but obviously not. Let me fix that...

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

