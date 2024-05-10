Return-Path: <cgroups+bounces-2854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7248C1EDC
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 09:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156EA1F21AEB
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48F15E7E2;
	Fri, 10 May 2024 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFcOzdRk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A91DFEA;
	Fri, 10 May 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325433; cv=none; b=mB1m8PS1PQjKkKnpckQRniUC8FHhyMN7SxatS+427lQueYw7/8tBx2wzs/mIB897phrg+3zS+03sAIOepkTZ3iblfSt5crX4kHj32jwMskC95ujRuEo75zYVNWO7jdtMwgIchF6tTl3D0sVJZKBTILcJGe+uMOnxG17/BfY/mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325433; c=relaxed/simple;
	bh=Se36TeyOV23tCQdBo7ZZPsSV1p4+JpJJkKofMHtmkxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ2DEoaEt2/+BQ9FbIx2QjWssYzPACCEWK9GB1qBTgfoDdxzaJ+tNBrgpQxmBL44v+Ku637u3wi5wAhPmG4qpC4y2AFLfdmlCU57C1g95sqCpssmhl0G6Y4k0pXobqpvwPKvyjjcPAxAILP0wxOKcVLD44/WRbxRlWNPlNJSpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFcOzdRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F76C2BD11;
	Fri, 10 May 2024 07:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715325432;
	bh=Se36TeyOV23tCQdBo7ZZPsSV1p4+JpJJkKofMHtmkxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFcOzdRksDFfrR9aahCMVwWroPfisyaJoidR+0nl0EvcTVpk7bowmNiTnLG9ZUOBk
	 TU2atMATMjyZtyS/YMUy/jt0mnOns7f99zYxDVcmzh3KQORERWwRcKEi7otKiL6YaW
	 3Cyb1DaijbM3qxPrNxxu6TSZ39GCsRTkYR9Qa4Ky4gFh6+ZFydVumDDdCjUyeY6dKH
	 0AEy3GKz9aELAG5QuOJ01r1Y++1uwd/P8oRH6LtO00dJjoy82ogBPRk8nEMR+xUqHr
	 VTYH82VcuVBy83K5mEZ16mNL2uazPnuPaqyRR+kQOzk3BY0ujqQzXBS3ZAZ7gcVFIi
	 wlrhqLh3VatUA==
Message-ID: <2ac54036-6245-466f-b8fa-aaf56db72d1e@kernel.org>
Date: Fri, 10 May 2024 16:17:09 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme: add 'latency' iopolicy
To: John Meneghini <jmeneghi@redhat.com>, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com, hare@kernel.org
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-3-jmeneghi@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240509204324.832846-3-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 05:43, John Meneghini wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Add a latency-based I/O policy for multipathing. It uses the blk-nodelat
> latency tracker to provide latencies for each node, and schedules
> I/O on the path with the least latency for the submitting node.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> 
> Make this compile when CONFIG_BLK_NODE_LATENCY is not set.
> Advertise the 'latency' iopolicy in modinfo.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/multipath.c | 63 ++++++++++++++++++++++++++++++-----
>  drivers/nvme/host/nvme.h      |  1 +
>  2 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d916a5ddf5d4..e9330bb1990b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -18,6 +18,7 @@ static const char *nvme_iopolicy_names[] = {
>  	[NVME_IOPOLICY_NUMA]	= "numa",
>  	[NVME_IOPOLICY_RR]	= "round-robin",
>  	[NVME_IOPOLICY_QD]      = "queue-depth",
> +	[NVME_IOPOLICY_LAT]	= "latency",
>  };
>  
>  static int iopolicy = NVME_IOPOLICY_NUMA;
> @@ -32,6 +33,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>  		iopolicy = NVME_IOPOLICY_RR;
>  	else if (!strncmp(val, "queue-depth", 11))
>  		iopolicy = NVME_IOPOLICY_QD;
> +#ifdef CONFIG_BLK_NODE_LATENCY
> +	else if (!strncmp(val, "latency", 7))
> +		iopolicy = NVME_IOPOLICY_LAT;
> +#endif
>  	else
>  		return -EINVAL;
>  
> @@ -43,10 +48,36 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>  	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
>  }
>  
> +static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ns_head *h;
> +	struct nvme_ns *ns;
> +	bool enable = iopolicy == NVME_IOPOLICY_LAT;
> +	int ret = 0;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(h, &subsys->nsheads, entry) {
> +		list_for_each_entry_rcu(ns, &h->list, siblings) {
> +			if (enable) {
> +				ret = blk_nlat_enable(ns->disk);
> +				if (ret)
> +					break;
> +			} else
> +				blk_nlat_disable(ns->disk);

Missing curly brackets for the else.

> +		}
> +	}
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}
> +
>  module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>  	&iopolicy, 0644);
>  MODULE_PARM_DESC(iopolicy,
> +#if defined(CONFIG_BLK_NODE_LATENCY)

What is so special about the latency policy that it needs to be conditionally
defined ? I missed that point. Why not drop CONFIG_BLK_NODE_LATENCY ?

> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin', 'queue-depth' or 'latency'");
> +#else
>  	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
> +#endif
>  
>  void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>  {
> @@ -250,14 +281,16 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>  {
>  	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
>  	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
> +	int iopolicy = READ_ONCE(head->subsys->iopolicy);
>  
>  	list_for_each_entry_rcu(ns, &head->list, siblings) {
>  		if (nvme_path_is_disabled(ns))
>  			continue;
>  
> -		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
> -		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> +		if (iopolicy == NVME_IOPOLICY_NUMA)
>  			distance = node_distance(node, ns->ctrl->numa_node);
> +		else if (iopolicy == NVME_IOPOLICY_LAT)
> +			distance = blk_nlat_latency(ns->disk, node);
>  		else
>  			distance = LOCAL_DISTANCE;
>  
> @@ -381,8 +414,8 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>  
>  inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>  {
> -	int iopolicy = READ_ONCE(head->subsys->iopolicy);
>  	int node;
> +	int iopolicy = READ_ONCE(head->subsys->iopolicy);

No need to move this line.

>  	struct nvme_ns *ns;
>  
>  	/*
> @@ -401,8 +434,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>  
>  	if (iopolicy == NVME_IOPOLICY_RR)
>  		return nvme_round_robin_path(head, node, ns);
> -
> -	if (unlikely(!nvme_path_is_optimized(ns)))
> +	if (iopolicy == NVME_IOPOLICY_LAT ||
> +	    unlikely(!nvme_path_is_optimized(ns)))
>  		return __nvme_find_path(head, node);
>  	return ns;
>  }
> @@ -872,15 +905,18 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>  {
>  	struct nvme_subsystem *subsys =
>  		container_of(dev, struct nvme_subsystem, dev);
> -	int i;
> +	int i, ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
>  		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
> -			nvme_subsys_iopolicy_update(subsys, i);
> -			return count;
> +			ret = nvme_activate_iopolicy(subsys, i);
> +			if (!ret) {
> +				nvme_subsys_iopolicy_update(subsys, i);
> +				return count;
> +			}
> +			return ret;

It would be nicer to have this as:

			if (ret)
				break
			nvme_subsys_iopolicy_update(subsys, i);
			return count;

>  		}
>  	}
> -

whiteline change.

>  	return -EINVAL;

And "return ret;" here with ret initialized to -EINVAL when declared.

>  }
>  SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
> @@ -916,6 +952,15 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>  
>  void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>  {
> +	if (!blk_nlat_init(ns->disk) &&
> +	    READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_LAT) {
> +		int ret = blk_nlat_enable(ns->disk);
> +
> +		if (unlikely(ret))
> +			pr_warn("%s: Failed to enable latency tracking, error %d\n",
> +				ns->disk->disk_name, ret);
> +	}
> +
>  	if (nvme_ctrl_use_ana(ns->ctrl)) {
>  		struct nvme_ana_group_desc desc = {
>  			.grpid = anagrpid,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a557b4577c01..66bf003a6c48 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -411,6 +411,7 @@ enum nvme_iopolicy {
>  	NVME_IOPOLICY_NUMA,
>  	NVME_IOPOLICY_RR,
>  	NVME_IOPOLICY_QD,
> +	NVME_IOPOLICY_LAT,
>  };
>  
>  struct nvme_subsystem {

-- 
Damien Le Moal
Western Digital Research


