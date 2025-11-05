Return-Path: <cgroups+bounces-11583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF5C3424A
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 08:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3863618926A8
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAA2D0C79;
	Wed,  5 Nov 2025 07:06:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAF2C324F;
	Wed,  5 Nov 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326390; cv=none; b=ThLVTBscSBReEqRscsmXTsB/Tvbq29X+V7iqcbzldw+ZK8cRBp619+kFOHxexlZ+zLCklsR4rNuVZ6w2DH9aJf7wgTG6oB5LCi1pLL4W8R84cvhnUjl8Z9RNih1vmFzzcjJ09oRPxJXDBPIXasbITk+1FjmeA+Im2bgtlEHzM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326390; c=relaxed/simple;
	bh=hj/oHee/MX5miINZCh7iap38DPL99bXKDriLoQr/CG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNQCIX9BQ9KBMwQZxC4lBPpwJWYBjtNfSIGkWJ8oPrd4c8u5MgxAe+IDaVEatMprojA9E2OEp02IHtDoG99YWLF+FrPDVUnBWk9/4rF7u7MKQYFsTk2jomyYzJ13M+S3BBgSsQKCcclerbsSmOHQ4H8NJqo9h/9V4xT0hrHqBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d1bvm0Z6LzKHMv2;
	Wed,  5 Nov 2025 15:06:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F24AF1A0359;
	Wed,  5 Nov 2025 15:06:18 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgA3qEtp9wpp5FDvCg--.27148S2;
	Wed, 05 Nov 2025 15:06:18 +0800 (CST)
Message-ID: <606bbc24-53e3-4e09-b48b-d6f72f3194de@huaweicloud.com>
Date: Wed, 5 Nov 2025 15:06:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH v3 2/5] cgroup/cpuset: Fail if isolated
 and nohz_full don't leave any housekeeping
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251105043848.382703-1-longman@redhat.com>
 <20251105043848.382703-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251105043848.382703-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgA3qEtp9wpp5FDvCg--.27148S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1rCry8WFy8Zr4kAr4xJFb_yoW7KrW5pr
	yUGFW3GFWUtr13G343t3Zruw1Fkw4ktFy2k3ZxGa4rZFy7X3WvyryUW3Z0qFWru39xW34U
	ZrZ0gw4Iga4xAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/5 12:38, Waiman Long wrote:
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
> 
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
> 
> [longman: Remove isolated_cpus_should_update() and rewrite the checking
>  in update_prstate() and update_parent_effective_cpumask()]
> 
> Originally-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 74 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index da770dac955e..99622e90991a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1393,6 +1393,45 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	return isolcpus_updated;
>  }
>  
> +/*
> + * isolated_cpus_can_update - check for isolated & nohz_full conflicts
> + * @add_cpus: cpu mask for cpus that are going to be isolated
> + * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
> + * Return: false if there is conflict, true otherwise
> + *
> + * If nohz_full is enabled and we have isolated CPUs, their combination must
> + * still leave housekeeping CPUs.
> + *
> + * TBD: Should consider merging this function into
> + *      prstate_housekeeping_conflict().
> + */
> +static bool isolated_cpus_can_update(struct cpumask *add_cpus,
> +				     struct cpumask *del_cpus)
> +{
> +	cpumask_var_t full_hk_cpus;
> +	int res = true;
> +
> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> +		return true;
> +
> +	if (del_cpus && cpumask_weight_and(del_cpus,
> +			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
> +		return true;
> +
> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> +		return false;
> +
> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_active_mask);
> +	if (!cpumask_weight_andnot(full_hk_cpus, add_cpus))
> +		res = false;
> +
> +	free_cpumask_var(full_hk_cpus);
> +	return res;
> +}
> +
>  static void update_isolation_cpumasks(bool isolcpus_updated)
>  {
>  	int ret;
> @@ -1551,6 +1590,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>  	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>  		return PERR_INVCPUS;
> +	if ((new_prs == PRS_ISOLATED) &&
> +	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
> +		return PERR_HKEEPING;
>  
>  	spin_lock_irq(&callback_lock);
>  	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1650,6 +1692,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>  			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>  			cs->prs_err = PERR_NOCPUS;
> +		else if ((prs == PRS_ISOLATED) &&
> +			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
> +			cs->prs_err = PERR_HKEEPING;
>  		if (cs->prs_err)
>  			goto invalidate;
>  	}
> @@ -1750,6 +1795,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	int part_error = PERR_NONE;	/* Partition error? */
>  	int isolcpus_updated = 0;
>  	struct cpumask *xcpus = user_xcpus(cs);
> +	int parent_prs = parent->partition_root_state;
>  	bool nocpu;
>  
>  	lockdep_assert_held(&cpuset_mutex);
> @@ -1813,6 +1859,10 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		if (prstate_housekeeping_conflict(new_prs, xcpus))
>  			return PERR_HKEEPING;
>  
> +		if ((new_prs == PRS_ISOLATED) && (new_prs != parent_prs) &&
> +		    !isolated_cpus_can_update(xcpus, NULL))
> +			return PERR_HKEEPING;
> +
>  		if (tasks_nocpu_error(parent, cs, xcpus))
>  			return PERR_NOCPUS;
>  
> @@ -1866,6 +1916,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		 *
>  		 * For invalid partition:
>  		 *   delmask = newmask & parent->effective_xcpus
> +		 *   The partition may become valid soon.
>  		 */
>  		if (is_partition_invalid(cs)) {
>  			adding = false;
> @@ -1880,6 +1931,23 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			deleting = cpumask_and(tmp->delmask, tmp->delmask,
>  					       parent->effective_xcpus);
>  		}
> +
> +		/*
> +		 * TBD: Invalidate a currently valid child root partition may
> +		 * still break isolated_cpus_can_update() rule if parent is an
> +		 * isolated partition.
> +		 */
> +		if (is_partition_valid(cs) && (old_prs != parent_prs)) {
> +			if ((parent_prs == PRS_ROOT) &&
> +			    /* Adding to parent means removing isolated CPUs */
> +			    !isolated_cpus_can_update(tmp->delmask, tmp->addmask))
> +				part_error = PERR_HKEEPING;
> +			if ((parent_prs == PRS_ISOLATED) &&
> +			    /* Adding to parent means adding isolated CPUs */
> +			    !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
> +				part_error = PERR_HKEEPING;
> +		}
> +
>  		/*
>  		 * The new CPUs to be removed from parent's effective CPUs
>  		 * must be present.
> @@ -2994,7 +3062,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  		 * A change in load balance state only, no change in cpumasks.
>  		 * Need to update isolated_cpus.
>  		 */
> -		isolcpus_updated = true;
> +		if ((new_prs == PRS_ISOLATED) &&
> +		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
> +			err = PERR_HKEEPING;
> +		else
> +			isolcpus_updated = true;
>  	} else {
>  		/*
>  		 * Switching back to member is always allowed even if it

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


