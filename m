Return-Path: <cgroups+bounces-12834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F1CEACA6
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 23:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26279301619D
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 22:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4672BE047;
	Tue, 30 Dec 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2cOJ8YL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E803A1E94;
	Tue, 30 Dec 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134293; cv=none; b=DsU9ExFeZpQLf3LgXrU/csOUCvV7sP49pIVvjgjnlEoJLQlyZzgf13qyN6EI6irAo7d8s5jFetZ3WjC/x8rLWUsBI2pSRCRW+8aN8ryyhXkVW2Bc1UGswXiwczB0Z0TBy01E51X5hFhxzLq2b+K/VRUfoAB3xSDjhVIk9kCH6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134293; c=relaxed/simple;
	bh=Tb3tynnxxnwuANiHqkonp4fihfVrESQp6TRTMLE8/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJrfDkpfeXjLSYcJWvwD1W7xBh1FYhPymnoFwjgrXd8X8AcOmOYUE3djMkwOqAPRyyiO4dFNQfruPEFp8633QtbgUt8QuNflpFjxHaZjWbEoJ9XzwJc0qw9Z51qxo+aQ9bNhjvx2FVFJzqzYl7dJeiStQvF9V1478AcIGk7Ba+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2cOJ8YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69369C4CEFB;
	Tue, 30 Dec 2025 22:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767134292;
	bh=Tb3tynnxxnwuANiHqkonp4fihfVrESQp6TRTMLE8/iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2cOJ8YL9H3+tcxp0RAQnc5CQYnXPXOwJghUPMxwUA9nJ6+jdDVbBaf+CVtGr49mj
	 NcFoZvSde20KbB6f29qNdHoYvCrrD9KXIKSkLSESSZU3CeFKhgKvmeLsIKz36l3BDv
	 ZqHDMjOeFqTCfC1E3RRn+MqTIhX3ZzoVKL9GVwFxgm5PZpPnoEShKS6g+GEHhM3T5R
	 Ak3KCLfwYwDPNgJrx7tv306BftuJfE5/umRJJVfDTi/6tf7wCvTJtzXWSTNibia4VO
	 e+wO+Ccg/vgWi85o7qxny3KxKBVON1mdMm8lbrc3w/6NSbRmm//YBotNrxpr9frRna
	 8XuNauqTZD6tg==
Date: Tue, 30 Dec 2025 23:38:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
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
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aVRUUXa6kJKHHQ_n@pavilion.home>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-2-frederic@kernel.org>
 <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>

Le Mon, Dec 29, 2025 at 11:23:56AM +0800, Zhang Qiao a écrit :
> Hi, Weisbecker，
> 
> 在 2025/12/24 21:44, Frederic Weisbecker 写道:
> > HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> > therefore be made modifiable at runtime. Synchronize against the cpumask
> > update using RCU.
> > 
> > The RCU locked section includes both the housekeeping CPU target
> > election for the PCI probe work and the work enqueue.
> > 
> > This way the housekeeping update side will simply need to flush the
> > pending related works after updating the housekeeping mask in order to
> > make sure that no PCI work ever executes on an isolated CPU. This part
> > will be handled in a subsequent patch.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  drivers/pci/pci-driver.c | 47 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 38 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 7c2d9d596258..786d6ce40999 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -302,9 +302,8 @@ struct drv_dev_and_id {
> >  	const struct pci_device_id *id;
> >  };
> >  
> > -static long local_pci_probe(void *_ddi)
> > +static int local_pci_probe(struct drv_dev_and_id *ddi)
> >  {
> > -	struct drv_dev_and_id *ddi = _ddi;
> >  	struct pci_dev *pci_dev = ddi->dev;
> >  	struct pci_driver *pci_drv = ddi->drv;
> >  	struct device *dev = &pci_dev->dev;
> > @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
> >  	return 0;
> >  }
> >  
> > +struct pci_probe_arg {
> > +	struct drv_dev_and_id *ddi;
> > +	struct work_struct work;
> > +	int ret;
> > +};
> > +
> > +static void local_pci_probe_callback(struct work_struct *work)
> > +{
> > +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
> > +
> > +	arg->ret = local_pci_probe(arg->ddi);
> > +}
> > +
> >  static bool pci_physfn_is_probed(struct pci_dev *dev)
> >  {
> >  #ifdef CONFIG_PCI_IOV
> > @@ -362,34 +374,51 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
> >  	dev->is_probed = 1;
> >  
> >  	cpu_hotplug_disable();
> > -
> >  	/*
> >  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
> >  	 * device is probed from work_on_cpu() of the Physical device.
> >  	 */
> >  	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
> >  	    pci_physfn_is_probed(dev)) {
> > -		cpu = nr_cpu_ids;
> > +		error = local_pci_probe(&ddi);
> >  	} else {
> >  		cpumask_var_t wq_domain_mask;
> > +		struct pci_probe_arg arg = { .ddi = &ddi };
> > +
> > +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
> >  
> >  		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
> >  			error = -ENOMEM;
> 
> If we return from here, arg.work will not be destroyed.

Good catch! Thanks.

-- 
Frederic Weisbecker
SUSE Labs

