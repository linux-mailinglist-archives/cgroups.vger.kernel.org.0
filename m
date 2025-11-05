Return-Path: <cgroups+bounces-11596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 059FCC367F2
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 16:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1E484FBF7A
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19566342C90;
	Wed,  5 Nov 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW/SfRcZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851D341AD0;
	Wed,  5 Nov 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357360; cv=none; b=QtZDRBdX3Ki1EoqK0ujLYcyzdjUU5YHZPv5QFujZUkk0fKqbjQmeQkc6ljtrJImKeqAaGvQX+NY0ST44FP5413taGTKVLpaHdP1b3r0W3MXEOWh0SO3+pjWmioxBV1o0FsZP53JlMCr5FdWI3fhmRCfRJMDbsHrV1CJZQFxsk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357360; c=relaxed/simple;
	bh=boPYeqvdKW7/3CnEhFVgNn0FsAC8XrMy6K95gzM+WjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcljYRw4sDGQfyH1RhyXPozjNOcLxUBE509iyZLCdacf9HrVYRbn5DDnCnOGi60+7q9EFLB1urREoiV3BCEpThepLFGusQQfYznTSmQGr1X77Rm7BeUbX58BZFo5wq4YjDf42Je/hpFJOYb+jNKOFeMBdGivLzJ4B4u+hmEqqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW/SfRcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C476DC4CEF5;
	Wed,  5 Nov 2025 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762357360;
	bh=boPYeqvdKW7/3CnEhFVgNn0FsAC8XrMy6K95gzM+WjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW/SfRcZancAa0hsqKFnQRd29sYyNjQPo/6bgXUIdWQkQrCQ8SrjNfLEv2gd6QIbJ
	 KNvHuiS8u4kGDpix1rUv2FrtZNIpRj8+YRbgkYtOcqokgdP5Lelomta91mDjj2utK2
	 pJNN+t5ySqiy5B4IWOvfB+wUu7vtmplfUpxRFlJl/ItWWlSKTIKtO8NPw3lyVBm6hy
	 PX81LQiCi7jb6e0lest8AkXP8Ttp7CHR2CEtZJBks+yM2bue/m166kiurBIXHdyHQN
	 xXNTc0DdAqJPwKz19FVfa5KCbSwDOT4ZdNrwR2USJYY4x2nd++Gx+PqPUsZ/tGWHsn
	 0JuvFbPfX+vtQ==
Date: Wed, 5 Nov 2025 16:42:37 +0100
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
Message-ID: <aQtwbRrFBCUoQ2Yj@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
 <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e02915f-bde7-4b04-b760-89f34fb0a436@redhat.com>

Le Tue, Oct 21, 2025 at 12:10:16AM -0400, Waiman Long a écrit :
> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
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
> >   include/linux/sched/isolation.h |  2 +
> >   kernel/cgroup/cpuset.c          |  2 +
> >   kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
> >   kernel/sched/sched.h            |  1 +
> >   4 files changed, 74 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index da22b038942a..94d5c835121b 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -32,6 +32,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
> >   extern bool housekeeping_enabled(enum hk_type type);
> >   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
> >   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> > +extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
> >   extern void __init housekeeping_init(void);
> >   #else
> > @@ -59,6 +60,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
> >   	return true;
> >   }
> > +static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
> >   static inline void housekeeping_init(void) { }
> >   #endif /* CONFIG_CPU_ISOLATION */
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index aa1ac7bcf2ea..b04a4242f2fa 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1403,6 +1403,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
> >   	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
> >   	WARN_ON_ONCE(ret < 0);
> > +	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> > +	WARN_ON_ONCE(ret < 0);
> >   }
> >   /**
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index b46c20b5437f..95d69c2102f6 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
> >   bool housekeeping_enabled(enum hk_type type)
> >   {
> > -	return !!(housekeeping.flags & BIT(type));
> > +	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
> >   }
> >   EXPORT_SYMBOL_GPL(housekeeping_enabled);
> > +static bool housekeeping_dereference_check(enum hk_type type)
> > +{
> > +	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
> > +		/* Cpuset isn't even writable yet? */
> > +		if (system_state <= SYSTEM_SCHEDULING)
> > +			return true;
> > +
> > +		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
> > +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> > +			return true;
> > +
> > +		/* Cpuset lock held, partitions not writable */
> > +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> > +			return true;
> 
> I have some doubt about this condition as the cpuset_mutex may be held in
> the process of making changes to an isolated partition that will impact
> HK_TYPE_DOMAIN cpumask.

Indeed and therefore if the current process is holding the cpuset mutex,
it is guaranteed that no other process will update the housekeeping cpumask
concurrently.

So the housekeeping mask is guaranteed to be stable, right? Of course
the current task may be changing it but while it is changing it, it is
not reading it.

Thanks.

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

