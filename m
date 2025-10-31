Return-Path: <cgroups+bounces-11460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2134C252BE
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45E114F47B1
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD871A2C04;
	Fri, 31 Oct 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aawpblLi"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478203451D1
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915617; cv=none; b=FpN3ltjytjZAGBc9Nmo3+pd4AJ9dXUH2dRevwWQvKQ72rEZQDS3mkshgk8z8AJiE8iB/Gq04qUDvfPPtys+WQPSbvU1BV2eRo4qv4dP+t/tHfXx+8VlkVmwYpRSICRSVRWyRFMhU4JUH9hkBrG+rkkEYwEAtvvsa+l+p66sU29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915617; c=relaxed/simple;
	bh=0gvffhtHm9TKGqAoa6OvbnQN2GBuYskUEFqtaqSKDrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLvAAB6wTsIJ0v/AdvzeiZ/ENI2s/MKadBwW98Q2f1U1y4B8/5V11Vv50x+qboRnLnoYe9BrneyzNtffTaS/dbM0XkVmc9baoEM0GABCQUunSJAomHY18BtKtkSkLEpDnwILTskUGbhvctXiZzzr8oRUiR1dfPCa9TVkKWNfljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aawpblLi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761915614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLDwt+NU3vvKrlrQRKfDo5aEPn3HnX2ZWzIgGku0kDc=;
	b=aawpblLiJBSomgn/tACuXWqcbngMnWrm2V+DfGvyz7+L+ypG1jpoyICEziYwcO0OqD35Ny
	EGoAqtZeHjIXVX0UDwJ2qECYVI6aYsIYwFhTJr1ZkpjXJiPOFAT15z3YqXl3Tj2exFXNLU
	HyMiHZJHi6fLgjlxgIIra+p+ZQgvzts=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-qDUMAdLUOq24oc-NOEKyLQ-1; Fri,
 31 Oct 2025 09:00:10 -0400
X-MC-Unique: qDUMAdLUOq24oc-NOEKyLQ-1
X-Mimecast-MFC-AGG-ID: qDUMAdLUOq24oc-NOEKyLQ_1761915606
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB1101955F3E;
	Fri, 31 Oct 2025 13:00:03 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.244])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2491A1955BE3;
	Fri, 31 Oct 2025 12:59:53 +0000 (UTC)
Date: Fri, 31 Oct 2025 08:59:51 -0400
From: Phil Auld <pauld@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
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
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Message-ID: <20251031125951.GA430420@pauld.westford.csb>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013203146.10162-14-frederic@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Frederic,

On Mon, Oct 13, 2025 at 10:31:26PM +0200 Frederic Weisbecker wrote:
> Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
> CPUs passed through isolcpus= boot option. Users interested in also
> knowing the runtime defined isolated CPUs through cpuset must use
> different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...
> 
> There are many drawbacks to that approach:
> 
> 1) Most interested subsystems want to know about all isolated CPUs, not
>   just those defined on boot time.
> 
> 2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
>   concurrent cpuset changes.
> 
> 3) Further cpuset modifications are not propagated to subsystems
> 
> Solve 1) and 2) and centralize all isolated CPUs within the
> HK_TYPE_DOMAIN housekeeping cpumask.
> 
> Subsystems can rely on RCU to synchronize against concurrent changes.
> 
> The propagation mentioned in 3) will be handled in further patches.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/sched/isolation.h |  2 +
>  kernel/cgroup/cpuset.c          |  2 +
>  kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h            |  1 +
>  4 files changed, 74 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index da22b038942a..94d5c835121b 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -32,6 +32,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>  extern bool housekeeping_enabled(enum hk_type type);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
>  extern void __init housekeeping_init(void);
>  
>  #else
> @@ -59,6 +60,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  	return true;
>  }
>  
> +static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
>  static inline void housekeeping_init(void) { }
>  #endif /* CONFIG_CPU_ISOLATION */
>  
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aa1ac7bcf2ea..b04a4242f2fa 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1403,6 +1403,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
>  
>  	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>  	WARN_ON_ONCE(ret < 0);
> +	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> +	WARN_ON_ONCE(ret < 0);
>  }
>  
>  /**
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index b46c20b5437f..95d69c2102f6 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
>  
>  bool housekeeping_enabled(enum hk_type type)
>  {
> -	return !!(housekeeping.flags & BIT(type));
> +	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_enabled);
>  
> +static bool housekeeping_dereference_check(enum hk_type type)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
> +		/* Cpuset isn't even writable yet? */
> +		if (system_state <= SYSTEM_SCHEDULING)
> +			return true;
> +
> +		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
> +			return true;
> +
> +		/* Cpuset lock held, partitions not writable */
> +		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
> +			return true;
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static inline struct cpumask *housekeeping_cpumask_dereference(enum hk_type type)
> +{
> +	return rcu_dereference_check(housekeeping.cpumasks[type],
> +				     housekeeping_dereference_check(type));
> +}
> +
>  const struct cpumask *housekeeping_cpumask(enum hk_type type)
>  {
> +	const struct cpumask *mask = NULL;
> +
>  	if (static_branch_unlikely(&housekeeping_overridden)) {
> -		if (housekeeping.flags & BIT(type)) {
> -			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> -		}
> +		if (READ_ONCE(housekeeping.flags) & BIT(type))
> +			mask = housekeeping_cpumask_dereference(type);
>  	}
> -	return cpu_possible_mask;
> +	if (!mask)
> +		mask = cpu_possible_mask;
> +	return mask;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>  
> @@ -80,12 +110,45 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
>  
>  bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  {
> -	if (housekeeping.flags & BIT(type))
> +	if (READ_ONCE(housekeeping.flags) & BIT(type))
>  		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>  
> +int housekeeping_update(struct cpumask *mask, enum hk_type type)
> +{
> +	struct cpumask *trial, *old = NULL;
> +
> +	if (type != HK_TYPE_DOMAIN)
> +		return -ENOTSUPP;
> +
> +	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
> +	if (!trial)
> +		return -ENOMEM;
> +
> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
> +		kfree(trial);
> +		return -EINVAL;
> +	}
> +
> +	if (!housekeeping.flags)
> +		static_branch_enable(&housekeeping_overridden);
> +
> +	if (!(housekeeping.flags & BIT(type)))
> +		old = housekeeping_cpumask_dereference(type);
> +	else
> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));

Isn't this backwards?   If the bit is not set you save old to free it
and if the bit is set you set it again.


Cheers,
Phil


> +	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
> +
> +	synchronize_rcu();
> +
> +	kfree(old);
> +
> +	return 0;
> +}
> +
>  void __init housekeeping_init(void)
>  {
>  	enum hk_type type;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0c0ef8999fd6..8fac8aa451c6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -30,6 +30,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask_api.h>
> +#include <linux/cpuset.h>
>  #include <linux/ctype.h>
>  #include <linux/file.h>
>  #include <linux/fs_api.h>
> -- 
> 2.51.0
> 

-- 


