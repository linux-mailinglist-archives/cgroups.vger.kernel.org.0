Return-Path: <cgroups+bounces-11642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6ECC38925
	for <lists+cgroups@lfdr.de>; Thu, 06 Nov 2025 01:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0618849F9
	for <lists+cgroups@lfdr.de>; Thu,  6 Nov 2025 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE64217648;
	Thu,  6 Nov 2025 00:55:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991A1E570D;
	Thu,  6 Nov 2025 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390550; cv=none; b=GfwfLVAHBMFNOCNQD4hP6hOMsTlbDwl5QRZJNmdkY7WJDyfU/zkxvz2HL9VUod+tAZryqjXiotUcy/5YdEunaZ+i70E0qN2eH5s0ZwPuEdP3V/Wce/0XxkFCBG7pPVie6txGhks+lSJgPBQFwXN4AWyRYUw7p1ak7OFRA1w2/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390550; c=relaxed/simple;
	bh=QLck3GIt8vPMfgt0eHGXCkrpAXE3TypTezixglxPgog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdrXmZjJqZFOGRzen93rFSIOAuTG8lvfhNhusi9r9RSemPogi7AHHAnMEy5gI2q4a/Z6K4GfbFw4pofG+GURF8xV2gn0NhHIeMlvswQMQx4wfsgNwREb+ab7Q2Hb75MqzfPe/EY6xSmcA/L7y7WY1o4R3OUXHs0kuUaCkgl7fPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d23dj4RvPzKHMSC;
	Thu,  6 Nov 2025 08:55:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 95FAD1A0C0B;
	Thu,  6 Nov 2025 08:55:45 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgDXR0sO8gtpxr9CCw--.11206S2;
	Thu, 06 Nov 2025 08:55:44 +0800 (CST)
Message-ID: <e0b3f050-ef2e-478e-9e22-5f800b86ee42@huaweicloud.com>
Date: Thu, 6 Nov 2025 08:55:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/31] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251105210348.35256-1-frederic@kernel.org>
 <20251105210348.35256-18-frederic@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251105210348.35256-18-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXR0sO8gtpxr9CCw--.11206S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw47CFWUurWDGFyfZFWfAFb_yoW7Jw17pF
	Z8CFW8Kay0q3y5u3s8Jws2kr47Kw4kKF17Kwn7Ww1Fyryaqwn7Zw1jgrZIvryFqr98Gr15
	ZFZ0g39rGF40kwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j6a0PUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/6 5:03, Frederic Weisbecker wrote:
> Until now, cpuset would propagate isolated partition changes to
> workqueues so that unbound workers get properly reaffined.
> 
> Since housekeeping now centralizes, synchronize and propagates isolation
> cpumask changes, perform the work from that subsystem for consolidation
> and consistency purposes.
> 
> For simplification purpose, the target function is adapted to take the
> new housekeeping mask instead of the isolated mask.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/workqueue.h |  2 +-
>  init/Kconfig              |  1 +
>  kernel/cgroup/cpuset.c    | 14 ++++++--------
>  kernel/sched/isolation.c  |  4 +++-
>  kernel/workqueue.c        | 17 ++++++++++-------
>  5 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index dabc351cc127..a4749f56398f 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -588,7 +588,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
>  void free_workqueue_attrs(struct workqueue_attrs *attrs);
>  int apply_workqueue_attrs(struct workqueue_struct *wq,
>  			  const struct workqueue_attrs *attrs);
> -extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
> +extern int workqueue_unbound_housekeeping_update(const struct cpumask *hk);
>  
>  extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
>  			struct work_struct *work);
> diff --git a/init/Kconfig b/init/Kconfig
> index cab3ad28ca49..a1b3a3b66bfc 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1247,6 +1247,7 @@ config CPUSETS
>  	bool "Cpuset controller"
>  	depends on SMP
>  	select UNION_FIND
> +	select CPU_ISOLATION
>  	help
>  	  This option will let you create and manage CPUSETs which
>  	  allow dynamically partitioning a system into sets of CPUs and
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b04a4242f2fa..ea102e4695a5 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1392,7 +1392,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	return isolcpus_updated;
>  }
>  
> -static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
> +static void update_housekeeping_cpumask(bool isolcpus_updated)
>  {
>  	int ret;
>  
> @@ -1401,8 +1401,6 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
>  	if (!isolcpus_updated)
>  		return;
>  
> -	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
>  	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
>  	WARN_ON_ONCE(ret < 0);
>  }
> @@ -1558,7 +1556,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	list_add(&cs->remote_sibling, &remote_children);
>  	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_housekeeping_cpumask(isolcpus_updated);
>  	cpuset_force_rebuild();
>  	cs->prs_err = 0;
>  
> @@ -1599,7 +1597,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  	compute_excpus(cs, cs->effective_xcpus);
>  	reset_partition_data(cs);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_housekeeping_cpumask(isolcpus_updated);
>  	cpuset_force_rebuild();
>  
>  	/*
> @@ -1668,7 +1666,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  	if (xcpus)
>  		cpumask_copy(cs->exclusive_cpus, xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_housekeeping_cpumask(isolcpus_updated);
>  	if (adding || deleting)
>  		cpuset_force_rebuild();
>  
> @@ -2027,7 +2025,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		WARN_ON_ONCE(parent->nr_subparts < 0);
>  	}
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_housekeeping_cpumask(isolcpus_updated);
>  
>  	if ((old_prs != new_prs) && (cmd == partcmd_update))
>  		update_partition_exclusive_flag(cs, new_prs);
> @@ -3047,7 +3045,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	else if (isolcpus_updated)
>  		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_housekeeping_cpumask(isolcpus_updated);
>  

The patch [1] has been applied to cgroup/for-next, you may have to adapt it.

[1]: https://lore.kernel.org/cgroups/20251105043848.382703-6-longman@redhat.com/T/#u

-- 
Best regards,
Ridong


