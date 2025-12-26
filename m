Return-Path: <cgroups+bounces-12747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE76CDE83D
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 09:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3AC6300F314
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F06279907;
	Fri, 26 Dec 2025 08:48:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F6A945;
	Fri, 26 Dec 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738899; cv=none; b=MGmSbaXy9v3SMVuTqhhJnfLHigKV7KXGGAuXUtJjE8rGdrvZnBVoJEMWkdgIcbJN1/kzMHZ9Iw4bbba489wKGkzgaM2hTTtsxuBUYLvLgrFCCdpndUCKn74TFkVf5R+LZixD8pciLdzGAye+DzNu2qiV+CjDC79x3yK+snFkNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738899; c=relaxed/simple;
	bh=Qe1ViFaURpXZO7boMFNR0+RIbaHQHv+MQXT0F1X1lvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMbEOkD71IG7u16yKdvY7a+gDdWvdZM/RLRSTRbtYToNg0DioyapHpFzDgOwewAXbNqdqNR2KyXZkqpGS+KOKcu6+kmmj1F8/hzMAnh8IdM5Rmc3To+ekRdGAPw9xQDgCPxDKzQmzt76N4v2Np4Y3olN4xpkodgJ6GHT4HxFE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dczlT5D1fzKHMNb;
	Fri, 26 Dec 2025 16:47:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 571224057D;
	Fri, 26 Dec 2025 16:48:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3F_jKS05pTcYjBg--.59999S2;
	Fri, 26 Dec 2025 16:48:11 +0800 (CST)
Message-ID: <c724aac7-5647-4253-bf7b-4ea92ea5d167@huaweicloud.com>
Date: Fri, 26 Dec 2025 16:48:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] PCI: Flush PCI probe workqueue on cpuset isolated
 partition change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-18-frederic@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251224134520.33231-18-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3F_jKS05pTcYjBg--.59999S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4kAF45AF1rAr47XryDAwb_yoWrAF4fpF
	Z8AFW5tr48tFWUW3s0vF17Ar1S9wn2va4Ikr47Gw1Fvry2ya4vqasavry8tryfWrWDuF12
	yFW5KrZxuayjyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVZ2-UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/24 21:45, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask is now modifiable at runtime. In
> order to synchronize against PCI probe works and make sure that no
> asynchronous probing is still pending or executing on a newly isolated
> CPU, the housekeeping subsystem must flush the PCI probe works.
> 
> However the PCI probe works can't be flushed easily since they are
> queued to the main per-CPU workqueue pool.
> 
> Solve this with creating a PCI probe-specific pool and provide and use
> the appropriate flushing API.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 17 ++++++++++++++++-
>  include/linux/pci.h      |  3 +++
>  kernel/sched/isolation.c |  2 ++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 786d6ce40999..d87f781e5ce9 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -337,6 +337,8 @@ static int local_pci_probe(struct drv_dev_and_id *ddi)
>  	return 0;
>  }
>  
> +static struct workqueue_struct *pci_probe_wq;
> +
>  struct pci_probe_arg {
>  	struct drv_dev_and_id *ddi;
>  	struct work_struct work;
> @@ -407,7 +409,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  		cpu = cpumask_any_and(cpumask_of_node(node),
>  				      wq_domain_mask);
>  		if (cpu < nr_cpu_ids) {
> -			schedule_work_on(cpu, &arg.work);
> +			struct workqueue_struct *wq = pci_probe_wq;
> +
> +			if (WARN_ON_ONCE(!wq))
> +				wq = system_percpu_wq;
> +			queue_work_on(cpu, wq, &arg.work);
>  			rcu_read_unlock();
>  			flush_work(&arg.work);
>  			error = arg.ret;
> @@ -425,6 +431,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	return error;
>  }
>  
> +void pci_probe_flush_workqueue(void)
> +{
> +	flush_workqueue(pci_probe_wq);
> +}
> +
>  /**
>   * __pci_device_probe - check if a driver wants to claim a specific PCI device
>   * @drv: driver to call to check if it wants the PCI device
> @@ -1762,6 +1773,10 @@ static int __init pci_driver_init(void)
>  {
>  	int ret;
>  
> +	pci_probe_wq = alloc_workqueue("sync_wq", WQ_PERCPU, 0);
> +	if (!pci_probe_wq)
> +		return -ENOMEM;
> +
>  	ret = bus_register(&pci_bus_type);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..f14f467e50de 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1206,6 +1206,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  				    struct pci_ops *ops, void *sysdata,
>  				    struct list_head *resources);
>  int pci_host_probe(struct pci_host_bridge *bridge);
> +void pci_probe_flush_workqueue(void);
>  int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
>  int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
>  void pci_bus_release_busn_res(struct pci_bus *b);
> @@ -2079,6 +2080,8 @@ static inline int pci_has_flag(int flag) { return 0; }
>  _PCI_NOP_ALL(read, *)
>  _PCI_NOP_ALL(write,)
>  
> +static inline void pci_probe_flush_workqueue(void) { }
> +
>  static inline struct pci_dev *pci_get_device(unsigned int vendor,
>  					     unsigned int device,
>  					     struct pci_dev *from)
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 8aac3c9f7c7f..7dbe037ea8df 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -8,6 +8,7 @@
>   *
>   */
>  #include <linux/sched/isolation.h>
> +#include <linux/pci.h>
>  #include "sched.h"
>  
>  enum hk_flags {
> @@ -145,6 +146,7 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
>  
>  	synchronize_rcu();
>  
> +	pci_probe_flush_workqueue();
>  	mem_cgroup_flush_workqueue();
>  	vmstat_flush_workqueue();
>  

I am concerned that this flush work may slow down writes to the cpuset interface. I am not sure how
significant the impact will be.

I'm concerned about potential deadlock risks. While preliminary investigation hasn't uncovered any
issues, we must ensure that the cpu write lock is not held during the work(writing cpuset interface
needs cpu read lock).

-- 
Best regards,
Ridong


