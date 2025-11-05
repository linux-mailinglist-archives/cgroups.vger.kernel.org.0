Return-Path: <cgroups+bounces-11597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB3C36B12
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BABD6284A7
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AD335553;
	Wed,  5 Nov 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V49Bcvv4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55731DDBB;
	Wed,  5 Nov 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357556; cv=none; b=fho5PErUcRgMplVWpPBwM0ZY1oo04RWe5D5r6yVyOqtL4SdGOZ1peiStdNQdYiNza5dZM98sKl66GMZGfYFLV3FxJkXWu7N9jZVs7aAgVqBOcalh7GIsFVsertxISR7eGy61nsKwEVJwJHgOOsV99K2DBsqNMqtiU6pPc1mEY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357556; c=relaxed/simple;
	bh=xmm6nLsTXBCwCytcbyH8QsnB2JeBdkkjUjdkaJjSew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s31xmmMlh0tns6mjY13B9Q+0fUna/sS0wojQx/n/SF2mSCjVDewDjZvxIyi5IqWNO9nORNN+UL6qNBbGkW0MbidfZ1Cfl9alotDM/Sv0ctwnsJ6v9wWMjQe0ETAMMg7+l32p4gCjzsvGsv3iSk2aT5sMPUm8MuqdpKQVrxdNZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V49Bcvv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A62C4CEF5;
	Wed,  5 Nov 2025 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762357555;
	bh=xmm6nLsTXBCwCytcbyH8QsnB2JeBdkkjUjdkaJjSew8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V49Bcvv4Vr1XD0d8nGugzn6nEJFHU94wKaZlMJvIc+YJdz7x5ju9aDQoREW8ASZJU
	 MW1hUDPpNZJmSffEhIdGydas6VB+w4ctZOakowcXZPe9VCVSOUxeNYJArgQ7UxDpnN
	 G8fLk11CiNYat6qGWS6sf3enIsQ6suuzdkc/xJ+96sXJyCgwm/VCvwN3kn/uST4kQ/
	 n2/u4JFfGzZ4lnX2yMvrfbCe1/yIkfyrIb0MDZJtSXAoqGFqJvvBcFvCehuflcypjt
	 eNy+hH/+vmLM4JvkGDmULWA4wY5yEEwNvPSk59QeVOmmqB4U/icu2vG2nFt6e1YuOS
	 ZRjYiAhWKqFrQ==
Date: Wed, 5 Nov 2025 16:45:53 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Message-ID: <aQtxMYmwzfg2NW1O@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
 <ea2d3e0e-b1ee-4b58-a93a-b9d127258e75@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea2d3e0e-b1ee-4b58-a93a-b9d127258e75@redhat.com>

Le Tue, Oct 21, 2025 at 09:39:10AM -0400, Waiman Long a écrit :
> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> > @@ -80,12 +110,45 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
> >   bool housekeeping_test_cpu(int cpu, enum hk_type type)
> >   {
> > -	if (housekeeping.flags & BIT(type))
> > +	if (READ_ONCE(housekeeping.flags) & BIT(type))
> >   		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
> >   	return true;
> >   }
> >   EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> > +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> > +{
> > +	struct cpumask *trial, *old = NULL;
> > +
> > +	if (type != HK_TYPE_DOMAIN)
> > +		return -ENOTSUPP;
> > +
> > +	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
> Should you use cpumask_size() instead of sizeof(*trial) as the latter can be
> much bigger?

Good point!

> > +	if (!trial)
> > +		return -ENOMEM;
> > +
> > +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> > +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> > +		kfree(trial);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!housekeeping.flags)
> > +		static_branch_enable(&housekeeping_overridden);
> > +
> > +	if (!(housekeeping.flags & BIT(type)))
> > +		old = housekeeping_cpumask_dereference(type);
> > +	else
> > +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
> > +	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
> > +
> > +	synchronize_rcu();
> > +
> > +	kfree(old);
> 
> If "isolcpus" boot command line option is set, old can be a pointer to the
> boot time memblock area which isn't a pointer that can be handled by the
> slab allocator AFAIU. I don't know the exact consequence, but it may not be
> good. One possible solution I can think of is to make HK_TYPE_DOMAIN and
> HK_TYPE_DOMAIN_ROOT point to the same memblock pointer and don't pass the
> old HK_TYPE_DOMAIN pointer to kfree() if it matches HK_TYPE_DOMAIN_BOOT one.
> Alternatively, we can just set the HK_TYPE_DOMAIN_BOOT pointer at boot and
> make HK_TYPE_DOMAIN falls back to HK_TYPE_DOMAIN_BOOT if not set.

Have a look at housekeeping_init() which reallocates the memblock
allocated memory with kmalloc to avoid these troubles.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

