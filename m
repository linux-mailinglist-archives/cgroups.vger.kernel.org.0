Return-Path: <cgroups+bounces-13373-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIiCELZZcmkpiwAAu9opvQ
	(envelope-from <cgroups+bounces-13373-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:09:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C26E6AD4A
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28CB330459E0
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCC3DF5AE;
	Thu, 22 Jan 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpSHO+gh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF073DEDB2;
	Thu, 22 Jan 2026 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098477; cv=none; b=rTj3tkJV3mLuekWAM6cwtwoqD2ejzg2Ed96lgatvcCVb25isCesnmPoRRxjdE+4SxlkmvdtgIPPCXnuwBniZP7X0+Fq/toQaJszt1tpoGBl12zaABckrRZChbgUjYkThUt5PahM0KrXTqTrrzoElrcmstO9mgQpfTu4R4G1X7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098477; c=relaxed/simple;
	bh=GrBl0GmB4EskXynUW6bH8pp7knC2vNONOphZtdopzwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BhmWlMy/oh7sa1sNs7eYkOn1kM0aoWbW3yXohg8cTt9OgpbWy+yOuabpwy45vFBYn8zvtqtmxYnYb7XwrfMkjzgVso8n4239cjCOVN1Riy9Ix4o88vQgIrz7/heqGAqaLelYe4gteThNoOhrQUlH1tDCSXS1yJZ4rJNbTwUlZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpSHO+gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A5C116C6;
	Thu, 22 Jan 2026 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098476;
	bh=GrBl0GmB4EskXynUW6bH8pp7knC2vNONOphZtdopzwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hpSHO+ghl6+V/2A9sZcw97dKURkfaqnoh6fz57v7b/GtWXdfzXyy1Yby0UyhDjKvn
	 2W+GC9cq47CPQ+TyiGLDn45Swl8siTnsyFJ7on/xxPH49i5KT8MfQ3vmfWawrqtvS/
	 e0XgagEPSQy8S8MSzhOzpR/YURn2bktJ0b47/jNeBbGfV3QYbH+giEwsut0bvtVELK
	 rpWCghXqtrEljSmHQ2BL3Elb1FNkrsKZfXYGCYyUHca2y5JEbBVE6ebqtSPa8N/6sE
	 xvWIAneDy9J19bcgL4eE88SS3YXNHupckNIR5dM3vOtcnyqIgrEjM/GhgZcu+RgECE
	 P9HBLzh+xmLPQ==
Date: Thu, 22 Jan 2026 10:14:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 17/33] PCI: Flush PCI probe workqueue on cpuset isolated
 partition change
Message-ID: <20260122161435.GA1250260@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101221359.22298-18-frederic@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13373-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C26E6AD4A
X-Rspamd-Action: no action

On Thu, Jan 01, 2026 at 11:13:42PM +0100, Frederic Weisbecker wrote:
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-driver.c | 17 ++++++++++++++++-
>  include/linux/pci.h      |  3 +++
>  kernel/sched/isolation.c |  2 ++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a6111140755c..b902d8adf9a5 100644
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
> index ec3f15164fd1..5239f556745d 100644
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
> @@ -142,6 +143,7 @@ int housekeeping_update(struct cpumask *isol_mask)
>  
>  	synchronize_rcu();
>  
> +	pci_probe_flush_workqueue();
>  	mem_cgroup_flush_workqueue();
>  	vmstat_flush_workqueue();
>  
> -- 
> 2.51.1
> 

