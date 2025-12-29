Return-Path: <cgroups+bounces-12786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85230CE5DE2
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 04:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561DB3014D95
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04228A72B;
	Mon, 29 Dec 2025 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S5oznL7E"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0532877E5;
	Mon, 29 Dec 2025 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766978653; cv=none; b=RlcgOzTk6h660ISKxhs0EgxDLEWdx7vGqJ0x/HCcsyZ/R6QZyWl6W9nHwnuwM8kmOF1so6W07RTk8b29fOf97ONBEpBiVfpjw0Dde3UL1OZkKO1x17PyjkOS1YrFjxMVP8CHp3Y1o3XHw5QugNqS2IJtCKYkqcIwi6Rk3N0LzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766978653; c=relaxed/simple;
	bh=ZJEzZz24I4SkxEyQ42RbH6MATyuV3CWjO1JRtGv7kWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8MGeFERcxEwlX2n24O5rc2g3dpxi8fyEr8NV2lLd43uHTYr7gT9tUAvbJHU3lhiUYnKNvI5Tb0BCQ035yFqS+9vbgkGvjT6HIfu7rmuLSwSr5kpQ4ZcRRGTKuptO5PWmp88/reDoNSy8qrHZdsCuQM0Etk0RA5QfBJfNpiemsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S5oznL7E; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+BDGPe6Wz623mn9DQDdS+J7GvS2xhqJ99bp8antJarY=;
	b=S5oznL7E1P+omaU+fUcM+wvPVZ/3cp/IsoQKCRwXkrHP4luHaqG+eOUxh9smTTkbEqw7uNvL0
	c4F1Wz+fPO5F6LWQgHy3huRbvjOsFw6aJ5tzPzxeXifnT01IAPtQc9PeSF0XS6pqphA89L2jlAL
	eTXaNu0tOj/1OwY7Cqz7TxY=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dfhLm6PbPzmVYJ;
	Mon, 29 Dec 2025 11:20:48 +0800 (CST)
Received: from dggpemf100017.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B2D440565;
	Mon, 29 Dec 2025 11:23:59 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpemf100017.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Dec 2025 11:23:57 +0800
Message-ID: <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Date: Mon, 29 Dec 2025 11:23:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent isolated
 cpuset change
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, Andrew Morton
	<akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar
	<mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Phil Auld
	<pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Simon
 Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Waiman Long
	<longman@redhat.com>, Will Deacon <will@kernel.org>,
	<cgroups@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-2-frederic@kernel.org>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20251224134520.33231-2-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100017.china.huawei.com (7.185.36.74)

Hi, Weisbecker，

在 2025/12/24 21:44, Frederic Weisbecker 写道:
> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> therefore be made modifiable at runtime. Synchronize against the cpumask
> update using RCU.
> 
> The RCU locked section includes both the housekeeping CPU target
> election for the PCI probe work and the work enqueue.
> 
> This way the housekeeping update side will simply need to flush the
> pending related works after updating the housekeeping mask in order to
> make sure that no PCI work ever executes on an isolated CPU. This part
> will be handled in a subsequent patch.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 47 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d596258..786d6ce40999 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -302,9 +302,8 @@ struct drv_dev_and_id {
>  	const struct pci_device_id *id;
>  };
>  
> -static long local_pci_probe(void *_ddi)
> +static int local_pci_probe(struct drv_dev_and_id *ddi)
>  {
> -	struct drv_dev_and_id *ddi = _ddi;
>  	struct pci_dev *pci_dev = ddi->dev;
>  	struct pci_driver *pci_drv = ddi->drv;
>  	struct device *dev = &pci_dev->dev;
> @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
>  	return 0;
>  }
>  
> +struct pci_probe_arg {
> +	struct drv_dev_and_id *ddi;
> +	struct work_struct work;
> +	int ret;
> +};
> +
> +static void local_pci_probe_callback(struct work_struct *work)
> +{
> +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
> +
> +	arg->ret = local_pci_probe(arg->ddi);
> +}
> +
>  static bool pci_physfn_is_probed(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_PCI_IOV
> @@ -362,34 +374,51 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	dev->is_probed = 1;
>  
>  	cpu_hotplug_disable();
> -
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>  	 * device is probed from work_on_cpu() of the Physical device.
>  	 */
>  	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>  	    pci_physfn_is_probed(dev)) {
> -		cpu = nr_cpu_ids;
> +		error = local_pci_probe(&ddi);
>  	} else {
>  		cpumask_var_t wq_domain_mask;
> +		struct pci_probe_arg arg = { .ddi = &ddi };
> +
> +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
>  
>  		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
>  			error = -ENOMEM;

If we return from here, arg.work will not be destroyed.



>  			goto out;
>  		}
> +
> +		/*
> +		 * The target election and the enqueue of the work must be within
> +		 * the same RCU read side section so that when the workqueue pool
> +		 * is flushed after a housekeeping cpumask update, further readers
> +		 * are guaranteed to queue the probing work to the appropriate
> +		 * targets.
> +		 */
> +		rcu_read_lock();
>  		cpumask_and(wq_domain_mask,
>  			    housekeeping_cpumask(HK_TYPE_WQ),
>  			    housekeeping_cpumask(HK_TYPE_DOMAIN));
>  
>  		cpu = cpumask_any_and(cpumask_of_node(node),
>  				      wq_domain_mask);
> +		if (cpu < nr_cpu_ids) {
> +			schedule_work_on(cpu, &arg.work);
> +			rcu_read_unlock();
> +			flush_work(&arg.work);
> +			error = arg.ret;
> +		} else {
> +			rcu_read_unlock();
> +			error = local_pci_probe(&ddi);
> +		}
> +
>  		free_cpumask_var(wq_domain_mask);
> +		destroy_work_on_stack(&arg.work);
>  	}
> -
> -	if (cpu < nr_cpu_ids)
> -		error = work_on_cpu(cpu, local_pci_probe, &ddi);
> -	else
> -		error = local_pci_probe(&ddi);
>  out:
>  	dev->is_probed = 0;
>  	cpu_hotplug_enable();
> 

