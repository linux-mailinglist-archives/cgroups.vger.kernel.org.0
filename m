Return-Path: <cgroups+bounces-11553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C0C2EF38
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 03:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0881A420BAC
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2423EA89;
	Tue,  4 Nov 2025 02:19:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA96239E88;
	Tue,  4 Nov 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222780; cv=none; b=BiVBNBxwk1czQ6qnqPL5tzg4xZzKeqJYk77zf46aqn1ZmLYFhVAEWudQuIgpssb6ZYu51npktr124ZqrgvevAvaSm8bTcnKLNfkN+aItUXKKszOAkah7AOVbLVaFt9/hH4QVtmw5DV+K8bOoaIyY7CJPd4v+1Ws7XFyueMMlvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222780; c=relaxed/simple;
	bh=sSyoX6CE8h+VSCSmw6IDX2Rj6tJ/eKyGoMxNuXtMuKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqUjCsnvd7ip5VRWFzs21IyQOFQrj6kb58JDlZJVbmqlBnemgNit6E0UFsGiMshe4KvKjyw6cn2V9Y4ZFvYOu7w2FitXVy0B/iQvBDChgWaxW09mWq+nI3YaxDBgfmNuq3CL1ZBjkjNdfMfsaJgmWb4uBcFoSI851UNv4ClRdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0sb72LWszYQtlS;
	Tue,  4 Nov 2025 10:19:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9F6D11A0359;
	Tue,  4 Nov 2025 10:19:29 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB36UyuYglpKIVoCg--.12355S2;
	Tue, 04 Nov 2025 10:19:27 +0800 (CST)
Message-ID: <c4fc973a-e142-4b29-b41f-366d93cdfd0d@huaweicloud.com>
Date: Tue, 4 Nov 2025 10:19:25 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH v2 2/3] cgroup/cpuset: Fail if isolated
 and nohz_full don't leave any housekeeping
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251104013037.296013-1-longman@redhat.com>
 <20251104013037.296013-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251104013037.296013-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB36UyuYglpKIVoCg--.12355S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw17JF15ur45Jr4xGFyxAFb_yoWxAr13pr
	yUGFW3GFWUtr13W343t3Z7ur1Fkw4ktFy2k3ZxGa4rZFy7X3Wvyryj93Z0yrWru39xW34U
	Z390gw4Iga4xAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/4 9:30, Waiman Long wrote:
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
> 
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
> 
> [longman: Remove isolated_cpus_should_update() and rewrite the checking
>  in update_prstate() and update_parent_effective_cpumask(), also add
>  prstate_housekeeping_conflict() check in update_prstate() as
>  suggested by Chen Ridong]
> 
> Originally-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 75 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index da770dac955e..0c49905df394 100644
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

Do we also need to check prstate_housekeeping_conflict here?

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

Ditto.

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

I think isolated_cpus_can_update check should be also added to validate_partition function.

If deemed necessary, you may consider applying the patch below, which reuses validate_partition to
enable the local partition, so validate_partition can be common block.

https://lore.kernel.org/cgroups/20251025064844.495525-4-chenridong@huaweicloud.com/


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
> @@ -2994,7 +3062,12 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  		 * A change in load balance state only, no change in cpumasks.
>  		 * Need to update isolated_cpus.
>  		 */
> -		isolcpus_updated = true;
> +		if (((new_prs == PRS_ISOLATED) &&
> +		     !isolated_cpus_can_update(cs->effective_xcpus, NULL)) ||
> +		    prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
> +			err = PERR_HKEEPING;
> +		else
> +			isolcpus_updated = true;
>  	} else {
>  		/*
>  		 * Switching back to member is always allowed even if it

-- 
Best regards,
Ridong


