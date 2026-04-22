Return-Path: <cgroups+bounces-15451-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM+GJZVu6GkSKQIAu9opvQ
	(envelope-from <cgroups+bounces-15451-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 08:45:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D6442924
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 08:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E55303853E
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7EF32692B;
	Wed, 22 Apr 2026 06:39:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062F31D366;
	Wed, 22 Apr 2026 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839991; cv=none; b=ubi8fsCt1YlwNTO9/+7yFf0518ZUd/bmrMffppvDWwXhORJgACdXz9lbQHS/VnSj2YifgtubvKAkSxf6UnygfxLqG9pafVRfhOslpg7idv4JX/K9ia+ze3rxBvBFkxFMJsr9jPYW6hSYZ4pqJOcrUsYIwMPkEBOPjGqVx8X2ePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839991; c=relaxed/simple;
	bh=8auo9fApI0AJJbM0oVqd4iDvIZsHR0GHU8PCbKdtgfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEhnGlESkxk5sTuFyBRbXIkhzrOCb3a9m6NVJMgX5h698N9L6IaDoJzJnGGMxyXwfdPUnlx1I3gpIIZb/V8RPGtu/hmYgiGiRa6PX89OP81YlWNyIueKxfpE6A0OBr8SHCHG7g1GSK05fbutgELtbW6ibiBjAWzTBpLWKfF088Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g0qMJ3lLGzKHMN6;
	Wed, 22 Apr 2026 14:39:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CB50540600;
	Wed, 22 Apr 2026 14:39:44 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBnBMIubehpzQ43BQ--.59576S2;
	Wed, 22 Apr 2026 14:39:44 +0800 (CST)
Message-ID: <48f5e1f5-bfb0-44cc-ae6a-14f66158796f@huaweicloud.com>
Date: Wed, 22 Apr 2026 14:39:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] sched/isolation: Enhance housekeeping_update() to
 support updating more than one HK cpumask
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260421030351.281436-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnBMIubehpzQ43BQ--.59576S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyrGF4kGw1fAF4xGFyxAFb_yoW7Kw4Dpr
	Z8W3y3GFWkJr13G3s8Zw1DJr4rWw4kCw1vk3sxWw15tFy2g3WkA3409F9xJr97ur9rCr17
	ZFZ8KwsIgFyjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVZ2-UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15451-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: E35D6442924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/21 11:03, Waiman Long wrote:
> The housekeeping_update() function currently allows update to the
> HK_TYPE_DOMAIN cpumask only. As we are going to enable dynamic
> modification of the other housekeeping cpumasks, we need to extend
> it to support passing in the information about the HK cpumask(s) to
> be updated.  In cases where some HK cpumasks happen to be the same,
> it will be more efficient to update multiple HK cpumasks in one single
> call instead of calling it multiple times. Extend housekeeping_update()
> to support that as well.
> 
> Also add the restriction that passed in isolated cpumask parameter
> of housekeeping_update() must include all the CPUs isolated at boot
> time. This is currently the case for cpuset anyway.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched/isolation.h |  2 +-
>  kernel/cgroup/cpuset.c          |  2 +-
>  kernel/sched/isolation.c        | 99 +++++++++++++++++++++++----------
>  3 files changed, 71 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d1707f121e20..a17f16e0156e 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -51,7 +51,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
>  extern bool housekeeping_enabled(enum hk_type type);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> -extern int housekeeping_update(struct cpumask *isol_mask);
> +extern int housekeeping_update(struct cpumask *isol_mask, unsigned long flags);
>  extern void __init housekeeping_init(void);
>  
>  #else
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..a4eccb0ec0d1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1354,7 +1354,7 @@ static void cpuset_update_sd_hk_unlock(void)
>  		 */
>  		mutex_unlock(&cpuset_mutex);
>  		cpus_read_unlock();
> -		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
> +		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
>  		mutex_unlock(&cpuset_top_mutex);
>  	} else {
>  		cpuset_full_unlock();
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 9ec9ae510dc7..965d6f8fe344 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -120,48 +120,87 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>  
> -int housekeeping_update(struct cpumask *isol_mask)
> -{
> -	struct cpumask *trial, *old = NULL;
> -	int err;
> +/* HK type processing table */
> +static struct {
> +	int type;
> +	int boot_type;
> +} hk_types[] = {
> +	{ HK_TYPE_DOMAIN,       HK_TYPE_DOMAIN_BOOT	  },
> +	{ HK_TYPE_MANAGED_IRQ,  HK_TYPE_MANAGED_IRQ_BOOT  },
> +	{ HK_TYPE_KERNEL_NOISE, HK_TYPE_KERNEL_NOISE_BOOT }
> +};
>  
> -	trial = kmalloc(cpumask_size(), GFP_KERNEL);
> -	if (!trial)
> -		return -ENOMEM;
> +#define HK_TYPE_CNT	ARRAY_SIZE(hk_types)
>  
> -	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), isol_mask);
> -	if (!cpumask_intersects(trial, cpu_online_mask)) {
> -		kfree(trial);
> -		return -EINVAL;
> +int housekeeping_update(struct cpumask *isol_mask, unsigned long flags)
> +{
> +	struct cpumask *trial[HK_TYPE_CNT];
> +	int i, err = 0;
> +
> +	for (i = 0; i < HK_TYPE_CNT; i++) {
> +		int type = hk_types[i].type;
> +		int boot = hk_types[i].boot_type;
> +
> +		trial[i] = NULL;
> +		if (flags & BIT(type)) {
> +			trial[i] = kmalloc(cpumask_size(), GFP_KERNEL);
> +			if (!trial[i]) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +			/*
> +			 * The new HK cpumask must be a subset of its boot
> +			 * cpumask.
> +			 */
> +			cpumask_andnot(trial[i], cpu_possible_mask, isol_mask);
> +			if (!cpumask_intersects(trial[i], cpu_online_mask) ||
> +			    !cpumask_subset(trial[i], housekeeping_cpumask(boot))) {
> +				i++;
> +				err = -EINVAL;
> +				goto out;
> +			}
> +		}
>  	}
>  

The i++ here is confusing. Wouldn't it be more readable to just use
kfree(trial[i]) and then break out?

>  	if (!housekeeping.flags)
>  		static_branch_enable(&housekeeping_overridden);
>  
> -	if (housekeeping.flags & HK_FLAG_DOMAIN)
> -		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
> -	else
> -		WRITE_ONCE(housekeeping.flags, housekeeping.flags | HK_FLAG_DOMAIN);
> -	rcu_assign_pointer(housekeeping.cpumasks[HK_TYPE_DOMAIN], trial);
> -
> -	synchronize_rcu();
> -
> -	pci_probe_flush_workqueue();
> -	mem_cgroup_flush_workqueue();
> -	vmstat_flush_workqueue();
> +	for (i = 0; i < HK_TYPE_CNT; i++) {
> +		int type =  hk_types[i].type;
> +		struct cpumask *old;
>  
> -	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(HK_TYPE_DOMAIN));
> -	WARN_ON_ONCE(err < 0);
> +		if (!trial[i])
> +			continue;
> +		old = NULL;
> +		if (housekeeping.flags & BIT(type))
> +			old = housekeeping_cpumask_dereference(type);
> +		rcu_assign_pointer(housekeeping.cpumasks[type], trial[i]);
> +		trial[i] = old;
> +	}
>  
> -	err = tmigr_isolated_exclude_cpumask(isol_mask);
> -	WARN_ON_ONCE(err < 0);
> +	if ((housekeeping.flags & flags) != flags)
> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | flags);
>  
> -	err = kthreads_update_housekeeping();
> -	WARN_ON_ONCE(err < 0);
> +	synchronize_rcu();
>  
> -	kfree(old);
> +	if (flags & HK_FLAG_DOMAIN) {
> +		/*
> +		 * HK_TYPE_DOMAIN specific callbacks
> +		 */
> +		pci_probe_flush_workqueue();
> +		mem_cgroup_flush_workqueue();
> +		vmstat_flush_workqueue();
> +
> +		WARN_ON_ONCE(workqueue_unbound_housekeeping_update(
> +				housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0);
> +		WARN_ON_ONCE(tmigr_isolated_exclude_cpumask(isol_mask) < 0);
> +		WARN_ON_ONCE(kthreads_update_housekeeping() < 0);
> +	}
>  
> -	return 0;
> +out:
> +	while (--i >= 0)
> +		kfree(trial[i]);
> +	return err;
>  }
>  
>  void __init housekeeping_init(void)

-- 
Best regards,
Ridong


