Return-Path: <cgroups+bounces-5654-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44A9D414E
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 18:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BE3B27CFA
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BE156677;
	Wed, 20 Nov 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqnvYNDf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACB13C3D3;
	Wed, 20 Nov 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123035; cv=none; b=i49CsnaicSKKw0ex5VOdtkf5mKgRvU5fHPCIGZsRqz3rc3d+iw5auRkpLrcYIIvKmkEyU3FiYjLeUlQ8ymjefmZ+u0IQCGZ/L3DTDYRWr3J12TGKt6Qa9ZH852/0+L1v20Fa5e49kiHmMyN+iRFLxEniNQ/zra2OAzlfkJ4El7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123035; c=relaxed/simple;
	bh=XSTI8qSDI8nzAd273YQlOxRFW4NXlzDEQhC2Mn2ewWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDXeDooepGNo6cYIZKfrCPyk8lXENpWwk+gRdv4G9iTiVj5fwGpe2hGrNjllTkp4y26tDUbnpvhFv6iYxXCWLiba5zJATJTTNPzGuyrCN4eO2E/awfjEP1Jmn605tY0MVP6iYNrXjxpx0hw/MsirtV4h29BsWHXmW3VF15eyF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqnvYNDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB23C4CECD;
	Wed, 20 Nov 2024 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732123033;
	bh=XSTI8qSDI8nzAd273YQlOxRFW4NXlzDEQhC2Mn2ewWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqnvYNDfXBafb0H0k4oNLgsu31WTaKZz6RpmVfsLGMfFDA8XbLWYPrnp6HFOrQWuh
	 Zops5Z7qo1vUDtcLiFLKWByksLCb+3Dw1FINOiX3e4waw+poAAdXEnnGR9V1JTv/vz
	 8Tazi+8sAxoZAXKC/zTTgupBvLfuZrDUNSbyf4C7sFpMG+E/SomoxeDjGESKFQYY9R
	 5keBjHFSrXncj9MrMQ71fF1NkE2G1J04Cz92T0y74MMChrYpEApbThzMR0WSTsG1DT
	 q3chvx0WkdFXJJZeVwwH0T2alWdWffdt+i4wqnBAMYQkPE46NzyF26+7d6iskOUWUZ
	 ETuZrhEghzk9Q==
Date: Wed, 20 Nov 2024 18:17:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH v2 1/2] sched/isolation: Exclude dynamically isolated
 CPUs from housekeeping masks
Message-ID: <Zz4ZlnzeZQIyUfeR@localhost.localdomain>
References: <20240821142312.236970-1-longman@redhat.com>
 <20240821142312.236970-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821142312.236970-2-longman@redhat.com>

Le Wed, Aug 21, 2024 at 10:23:11AM -0400, Waiman Long a écrit :
> The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
> boot command line options, are used at boot time to exclude selected CPUs
> from running some kernel background processes to minimize disturbance
> to latency sensitive userspace applications. Some of housekeeping CPU
> masks are also checked at run time to avoid using those isolated CPUs.
> 
> The cpuset subsystem is now able to dynamically create a set of isolated
> CPUs to be used in isolated cpuset partitions. The long term goal is
> to make the degree of isolation as close as possible to what can be
> done statically using those boot command line options.
> 
> This patch is a step in that direction by making the housekeeping CPU
> mask APIs exclude the dynamically isolated CPUs when they are called
> at run time. The housekeeping CPU masks will fall back to the bootup
> default when all the dynamically isolated CPUs are released.
> 
> A new housekeeping_exlude_isolcpus() function is added which is to be
> called by the cpuset subsystem to provide a list of isolated CPUs to
> be excluded.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

It's a bit hard to review this for several reasons:

* first, because I'm doing it three months late, sorry about that

* We need to get the HK_TYPE_KERNEL_NOISE patchset in because the
  gazillions types don't help. Let's ping again scheduler people
  once -rc1 is released. I'm setting an alarm!

* It's hard to forecast what kind of synchronization will be needed
  against housekeeping cpumask updates. I need to audit all the users.
  But since all target CPUs are offline, there are just a few things left
  to consider. One of them is kthreads affinity and that should be at
  least partially solved by the kthread affinity patchset
  (https://lore.kernel.org/lkml/20241112142248.20503-1-frederic@kernel.org/)
  Hopefully I'll manage to get that in for the upcoming merge window.
  
Some more thoughts:

> ---
>  include/linux/sched/isolation.h |   8 +++
>  kernel/sched/isolation.c        | 112 +++++++++++++++++++++++++++++++-
>  2 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fa..d64fa4e60138 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -27,6 +27,8 @@ extern bool housekeeping_enabled(enum hk_type type);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>  extern void __init housekeeping_init(void);
> +extern int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus,
> +					unsigned long flags);
>  
>  #else
>  
> @@ -54,6 +56,12 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  }
>  
>  static inline void housekeeping_init(void) { }
> +
> +static inline int housekeeping_exlude_isolcpus(struct cpumask *isolcpus,
> +					       unsigned long flags)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_CPU_ISOLATION */
>  
>  static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5891e715f00d..3018ba81eb65 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -28,7 +28,16 @@ struct housekeeping {
>  	unsigned long flags;
>  };
>  
> -static struct housekeeping housekeeping;
> +static struct housekeeping housekeeping __read_mostly;
> +
> +/*
> + * Boot time housekeeping cpumask and flags
> + *
> + * If more than one of nohz_full or isolcpus are specified, the cpumask must
> + * be the same or the setup will fail.
> + */
> +static cpumask_var_t boot_hk_cpumask;
> +static unsigned long  boot_hk_flags;
>  
>  bool housekeeping_enabled(enum hk_type type)
>  {
> @@ -253,3 +262,104 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  	return housekeeping_setup(str, flags);
>  }
>  __setup("isolcpus=", housekeeping_isolcpus_setup);
> +
> +/*
> + * Save bootup housekeeping cpumask and flags
> + */
> +static int housekeeping_save(void)
> +{
> +	enum hk_type type;
> +
> +	boot_hk_flags = housekeeping.flags;
> +	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
> +		if (!alloc_cpumask_var(&boot_hk_cpumask, GFP_KERNEL))
> +			return -ENOMEM;

So this leaks and overwrites the mask for each flags?
Also only HK_TYPE_KERNEL_NOISE will be interesting.

> +		cpumask_copy(boot_hk_cpumask, housekeeping.cpumasks[type]);
> +		break;
> +	}
> +	return 0;
> +}

Should it be done on boot when housekeeping is allocated?

Thanks.

