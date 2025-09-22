Return-Path: <cgroups+bounces-10355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D4B91D2B
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F358C7A5A64
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EB2D593F;
	Mon, 22 Sep 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAUiY9mD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AC2D5408;
	Mon, 22 Sep 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553058; cv=none; b=ICXYIOyTO5UzA5ScJ5Tb5KTUYbX//EHCkZjN2Qt2rFc5lNf5gbHXDyUOU+oYCrjymcGFObWunz4VXGAwUK81XAsY+fgYmu4msg1Seu9ArUs5YTMVrNn01qcfiX5e2DAtkRtWynRw0G/VaGuR5pZXZywhQvcJUDsY9vk3NBWpMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553058; c=relaxed/simple;
	bh=+6gfKEUNMAwKMtTRlinwIuvb/XRsQAbUEHGroBjA/5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp+QTWed/A2/KvSnJk1CnMttQa9JMTyloeHVyp+2g9nTi3XuxIAhj72gZGpI5dOnjqeP9gEipI9TRFSVzENXcfXMS+mPGh2ZzKSCIAqXJrizQCHxU/azzJrDfDUEQLSYBVJ6KOcZboEaS0A3e8cKYwXa71gjXONImnpAMtElyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAUiY9mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A1C4CEF0;
	Mon, 22 Sep 2025 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758553057;
	bh=+6gfKEUNMAwKMtTRlinwIuvb/XRsQAbUEHGroBjA/5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAUiY9mDsV6F1PUUaFV+M0b+5gYSWuv8O4r0I6xzqOXyZtnGdI6GhZzCeNyFF1uF5
	 lf90NWRBiS7QW1P1aS32x73fJO1Whcn0sSzbtBAXaSaAzdbh+X5sE5i0ajgzKHKx0v
	 0TBqwa/drLrn1BuKKwpN8NjxFqQNbEOcUCEv/PMf5XhjBsg8WlPWQkIe/XdanngNDo
	 nQ7zV9vnIGjb759ZSTUJUDfcPdZ8WeEfslGZey8UsOVFYcFkXmblQqBmfT8TlwdKtq
	 N0tJTq7o0/946VLQe37Wk6NcaZn5zA0auY1ktWu1BOlLgea+F00Vl0Npv3rTF1kv15
	 hAqTFMmDWUdqA==
Date: Mon, 22 Sep 2025 16:57:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Message-ID: <aNFj3nkdiAofU3O7@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-15-frederic@kernel.org>
 <a8cdeb85-2629-440d-9c11-69f6e19f8cb6@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8cdeb85-2629-440d-9c11-69f6e19f8cb6@redhat.com>

Le Sun, Aug 31, 2025 at 08:40:36PM -0400, Waiman Long a écrit :
> On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> > Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
> > CPUs passed through isolcpus= boot option. Users interested in also
> > knowing the runtime defined isolated CPUs through cpuset must use
> > different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
> > 
> > There are many drawbacks to that approach:
> > 
> > 1) Most interested subsystems want to know about all isolated CPUs, not
> >    just those defined on boot time.
> > 
> > 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
> >    concurrent cpuset changes.
> > 
> > 3) Further cpuset modifications are not propagated to subsystems
> > 
> > Solve 1) and 2) and centralize all isolated CPUs within the
> > HK_TYPE_DOMAIN housekeeping cpumask.
> > 
> > Subsystems can rely on RCU to synchronize against concurrent changes.
> > 
> > The propagation mentioned in 3) will be handled in further patches.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   include/linux/sched/isolation.h |  4 +-
> >   kernel/cgroup/cpuset.c          |  2 +
> >   kernel/sched/isolation.c        | 65 ++++++++++++++++++++++++++++++---
> >   kernel/sched/sched.h            |  1 +
> >   4 files changed, 65 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 5ddb8dc5ca91..48f3b6b20604 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -23,16 +23,39 @@ EXPORT_SYMBOL_GPL(housekeeping_flags);
> >   bool housekeeping_enabled(enum hk_type type)
> >   {
> > -	return !!(housekeeping_flags & BIT(type));
> > +	return !!(READ_ONCE(housekeeping_flags) & BIT(type));
> >   }
> >   EXPORT_SYMBOL_GPL(housekeeping_enabled);
> > +static bool housekeeping_dereference_check(enum hk_type type)
> > +{
> > +	if (type == HK_TYPE_DOMAIN) {
> > +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> > +			return true;
> > +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> > +			return true;
> > +
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> Both lockdep_is_cpuset_held() and lockdep_is_cpus_write_held() may be
> defined only if CONFIG_LOCKDEP is set. However, this function is currently
> referenced by __housekeeping_cpumask() via RCU_LOCKDEP_WARN(). So it is not
> invoked if CONFIG_LOCKDEP is not set. You are assuming that static function
> not referenced is not being compiled into the object file. Should we bracket
> it with "ifdef CONFIG_LOCKDEP" just to make this clear?

Yes you're right. And I remember some O-day warnings about that on earlier
dev versions. I thought the issue was gone somehow but I think 0-day actually
finally concluded I ignored it :-)

> > +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> > +{
> > +	struct cpumask *trial, *old = NULL;
> > +
> > +	if (type != HK_TYPE_DOMAIN)
> > +		return -ENOTSUPP;
> > +
> > +	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
> > +	if (!trial)
> > +		return -ENOMEM;
> > +
> > +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> > +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> > +		kfree(trial);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (housekeeping_flags & BIT(type))
> > +		old = __housekeeping_cpumask(type);
> > +	else
> > +		WRITE_ONCE(housekeeping_flags, housekeeping_flags | BIT(type));
> 
> Should we use to READ_ONCE() to retrieve the current housekeeping_flags
> value?

Not here, this path is the only updater and it's locked by cpuset mutex.

Thanks.

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

