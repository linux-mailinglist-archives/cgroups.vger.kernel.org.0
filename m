Return-Path: <cgroups+bounces-4653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F9966D82
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 02:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547B2281150
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 00:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1E3C00;
	Sat, 31 Aug 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6wMSfol"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68B3C3C
	for <cgroups@vger.kernel.org>; Sat, 31 Aug 2024 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064048; cv=none; b=E4xo3LbWxk3u1dCILRL64X6Hdp0zOnYkjj9hVifW5hIfV5Pr7eA7W4Te/y4h/oUZ6FzI24TY9ZRF26Mz6eGACJGwBw2uXtGtzqceyS5P2t0+9xR0rqZuZBi0Uw/WohCBH3rPjeyU3pdxB+xO1SpWVaj4UDZ0NimKSPXcw1FoMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064048; c=relaxed/simple;
	bh=qjy0F2D7JFwR+9Y8cigngslE+eD+AhDYpK38RXmGbUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ1Z5b1Zc/a9AXCSv1Eyy/PdyHuuhxfx0IEvStBNqhsjoLJJkfV/8/lCSMmrigZgRc4zRhcSoi7kENNEKOHooJDHSlb3ZXlTGKQTZN+CmSX025BNWHnQHOOb7rXH+NY0yQJsNkV0c/WWC4HWqcEWcN/mkmO9YSFxBEBEZysnQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6wMSfol; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725064045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHBWnT4k6dco0n9/t0HZDWA/5sCtUSV1D+k6nHMThu0=;
	b=Y6wMSfol4bNhDn/uIsGnEiTuOcdc3zFhIQ/G4iCkDITTroO9Wv0yAgE5LzydZNQ1RUdwwh
	9OFTS/ada+9V21rhLTDQCJ5l7zhPKmDsYAT/aegGOm9nCHDNUFRfUTNFfqSSL0CoTQjX3U
	lhrg4E5Rd6Jfbet9qHfgeUiOzu0nlew=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-MysWu4bdO-6OwJbXq1_Q0Q-1; Fri,
 30 Aug 2024 20:27:21 -0400
X-MC-Unique: MysWu4bdO-6OwJbXq1_Q0Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 064CD19560A3;
	Sat, 31 Aug 2024 00:27:19 +0000 (UTC)
Received: from [10.2.16.45] (unknown [10.2.16.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D45B71955DD8;
	Sat, 31 Aug 2024 00:27:14 +0000 (UTC)
Message-ID: <db28db41-41aa-4f3e-bb32-4bb58d746dbc@redhat.com>
Date: Fri, 30 Aug 2024 20:27:13 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/isolation: Exclude dynamically isolated CPUs
 from housekeeping masks
To: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240821142312.236970-1-longman@redhat.com>
 <20240821142312.236970-2-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240821142312.236970-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 8/21/24 10:23, Waiman Long wrote:
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
> ---
>   include/linux/sched/isolation.h |   8 +++
>   kernel/sched/isolation.c        | 112 +++++++++++++++++++++++++++++++-
>   2 files changed, 119 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fa..d64fa4e60138 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -27,6 +27,8 @@ extern bool housekeeping_enabled(enum hk_type type);
>   extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>   extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>   extern void __init housekeeping_init(void);
> +extern int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus,
> +					unsigned long flags);
>   
>   #else
>   
> @@ -54,6 +56,12 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   }
>   
>   static inline void housekeeping_init(void) { }
> +
> +static inline int housekeeping_exlude_isolcpus(struct cpumask *isolcpus,
> +					       unsigned long flags)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif /* CONFIG_CPU_ISOLATION */
>   
>   static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5891e715f00d..3018ba81eb65 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -28,7 +28,16 @@ struct housekeeping {
>   	unsigned long flags;
>   };
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
>   bool housekeeping_enabled(enum hk_type type)
>   {
> @@ -253,3 +262,104 @@ static int __init housekeeping_isolcpus_setup(char *str)
>   	return housekeeping_setup(str, flags);
>   }
>   __setup("isolcpus=", housekeeping_isolcpus_setup);
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
> +		cpumask_copy(boot_hk_cpumask, housekeeping.cpumasks[type]);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Exclude the given dynamically isolated CPUs from the housekeeping CPUs
> + * External synchronization is required to make sure that concurrent call to
> + * this function will not happen.
> + *
> + * [TODO] The housekeeping cpumasks and flags at bootup time are currently
> + * preserved as cpuset dynamic CPU isolation isn't as good as boot time CPU
> + * isolation yet. Once dynamic CPU isolation is close to boot time isolation,
> + * we will not need to save the bootup values and will allow them to be
> + * overridden.
> + *
> + * Return: 0 if successful, an error code if not
> + */
> +int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long flags)
> +{
> +	static unsigned long alloc_flags;
> +	static cpumask_var_t tmp_mask;
> +	static bool excluded;	/* @true if some CPUs have been excluded */
> +	static bool inited;	/* @true if called before */
> +
> +	bool isolate_none = !isolcpus || cpumask_empty(isolcpus);
> +	enum hk_type type;
> +
> +	lockdep_assert_cpus_held();
> +
> +	if (isolate_none && (!inited || !excluded))
> +		return 0;
> +
> +	if (unlikely(!inited)) {
> +		if (!alloc_cpumask_var(&tmp_mask, GFP_KERNEL))
> +			return -ENOMEM;
> +		if (housekeeping.flags) {
> +			int err = housekeeping_save();
> +
> +			if (err)
> +				return err;
> +		}
> +		alloc_flags = housekeeping.flags;
> +		inited = true;
> +	}
> +
> +	if (isolate_none) {
> +		excluded = false;
> +
> +		/*
> +		 * Reset housekeeping to bootup default
> +		 */
> +		for_each_set_bit(type, &boot_hk_flags, HK_TYPE_MAX)
> +			cpumask_copy(housekeeping.cpumasks[type], boot_hk_cpumask);
> +
> +		WRITE_ONCE(housekeeping.flags, boot_hk_flags);
> +		if (!boot_hk_flags && static_key_enabled(&housekeeping_overridden))
> +			static_key_disable_cpuslocked(&housekeeping_overridden.key);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Setting up the new housekeeping cpumasks
> +	 */
> +	for_each_set_bit(type, &flags, HK_TYPE_MAX) {
> +		const struct cpumask *src_mask;
> +
> +		if (!(BIT(type) & alloc_flags)) {
> +			if (!alloc_cpumask_var(&housekeeping.cpumasks[type], GFP_KERNEL))
> +				return -ENOMEM;
> +			alloc_flags |= BIT(type);
> +		}
> +		src_mask = (BIT(type) & boot_hk_flags)
> +			 ? boot_hk_cpumask : cpu_possible_mask;
> +		/*
> +		 * Make sure there is at least one online housekeeping CPU
> +		 */
> +		cpumask_andnot(tmp_mask, src_mask, isolcpus);
> +		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
> +			return -EINVAL;	/* Invalid isolated CPUs */
> +		cpumask_copy(housekeeping.cpumasks[type], tmp_mask);
> +	}
> +	WRITE_ONCE(housekeeping.flags, boot_hk_flags | flags);
> +	excluded = true;
> +	if (!static_key_enabled(&housekeeping_overridden))
> +		static_key_enable_cpuslocked(&housekeeping_overridden.key);
> +	return 0;
> +}

Any comment or suggestion about this patch?

Thanks,
Longman


