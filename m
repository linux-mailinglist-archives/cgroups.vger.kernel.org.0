Return-Path: <cgroups+bounces-13374-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HnhGM1ZcmkpiwAAu9opvQ
	(envelope-from <cgroups+bounces-13374-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:09:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C86AD87
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63CE53094D88
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E23E041D;
	Thu, 22 Jan 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLh5e7xw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712873E03E6;
	Thu, 22 Jan 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098507; cv=none; b=tu5gvMwZwFLaBkqNZCaFvw9ytNVJdquy9/8vxI/DCl8rcIjI8DDX7EjIZwbKVV4pwn0n9msZIkhDowqpoD9w6boIiJE8cr+BSDoipk7jo9CJksvhPqrunrqc7UJuggTFOXdxMPQoN8sB0e2DnSvuy2s3VPz7ms/p0DLvS9jr/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098507; c=relaxed/simple;
	bh=SJFHQ6Dsh1f3ySZRRJ37Il23iv7ykfQoJASPEADlhj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hLxrJl9ralebwsMj9UQq6NFs0VyuQ99IPKlv671WcCL+ATutbniZv1ZQhvSrxjUi8ld/hzOAiJQFfL7jV+zE7jECgSTqfkypVuav2Ti4kMGWbSFOvTatCE25pkH+8x3e8FXxLoVSXdD4te/rEai4ZyAtP+v+X/66S8ZNiSARank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLh5e7xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086AC116C6;
	Thu, 22 Jan 2026 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098506;
	bh=SJFHQ6Dsh1f3ySZRRJ37Il23iv7ykfQoJASPEADlhj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tLh5e7xwyLi35ByP+P/zx+FUIZG0/Y/cKNIGwGFiXAL/PUM7LOTUcK1jbPF0zrhbW
	 QfWcHJziaTjycIc0UZky0Lxqkn5JXMqzA8amcf0V+QDYCC6W+IF0ubb4WgKlUZj5gc
	 2fhR+uq+lWXlGDORM4eoBcJ8MpPpG8puVbwZ4QnvuSU2bbfCDufoO668SdQkAa2w0Y
	 m9HgVWsHLrT86aXF56xvPBBAM1ivknGyvZ3Z2g9KgKceVnABiMNnxJqLkQQy53rbvp
	 5weW0+uOX4bDc/i0DBPfurqkJVpfu0nO90iejA1w1Euge0UvXu/MHizO9U1La6QwEY
	 GDcYIFh5457qg==
Date: Thu, 22 Jan 2026 10:15:05 -0600
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
Subject: Re: [PATCH 23/33] PCI: Remove superfluous HK_TYPE_WQ check
Message-ID: <20260122161505.GA1250310@bhelgaas>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101221359.22298-24-frederic@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-13374-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 033C86AD87
X-Rspamd-Action: no action

On Thu, Jan 01, 2026 at 11:13:48PM +0100, Frederic Weisbecker wrote:
> It doesn't make sense to use nohz_full without also isolating the
> related CPUs from the domain topology, either through the use of
> isolcpus= or cpuset isolated partitions.
> 
> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
> 
> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_WQ is only an
> alias) should always be a subset of HK_TYPE_DOMAIN.
> 
> Therefore sane configurations verify:
> 
> 	HK_TYPE_KERNEL_NOISE | HK_TYPE_DOMAIN == HK_TYPE_DOMAIN
> 
> Simplify the PCI probe target election accordingly.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-driver.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index b902d8adf9a5..a9590601835a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -384,16 +384,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	    pci_physfn_is_probed(dev)) {
>  		error = local_pci_probe(&ddi);
>  	} else {
> -		cpumask_var_t wq_domain_mask;
>  		struct pci_probe_arg arg = { .ddi = &ddi };
>  
> -		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
> -			error = -ENOMEM;
> -			goto out;
> -		}
> -
>  		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
> -
>  		/*
>  		 * The target election and the enqueue of the work must be within
>  		 * the same RCU read side section so that when the workqueue pool
> @@ -402,12 +395,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  		 * targets.
>  		 */
>  		rcu_read_lock();
> -		cpumask_and(wq_domain_mask,
> -			    housekeeping_cpumask(HK_TYPE_WQ),
> -			    housekeeping_cpumask(HK_TYPE_DOMAIN));
> -
>  		cpu = cpumask_any_and(cpumask_of_node(node),
> -				      wq_domain_mask);
> +				      housekeeping_cpumask(HK_TYPE_DOMAIN));
> +
>  		if (cpu < nr_cpu_ids) {
>  			struct workqueue_struct *wq = pci_probe_wq;
>  
> @@ -422,10 +412,9 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  			error = local_pci_probe(&ddi);
>  		}
>  
> -		free_cpumask_var(wq_domain_mask);
>  		destroy_work_on_stack(&arg.work);
>  	}
> -out:
> +
>  	dev->is_probed = 0;
>  	cpu_hotplug_enable();
>  	return error;
> -- 
> 2.51.1
> 

