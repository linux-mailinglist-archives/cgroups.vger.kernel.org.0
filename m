Return-Path: <cgroups+bounces-11486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39195C29FE2
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B113AD09B
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6538F28BA95;
	Mon,  3 Nov 2025 03:48:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166A1F130A;
	Mon,  3 Nov 2025 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141689; cv=none; b=o485Zf3K4oCAVnvIHq8ZmjeenoetoAv3AUOPoSVOKxlY7LChC0PwTkJvxwBHpRULqhi2Ybw9VpJtaLeAgJ7kff4GxZuuNb1QzfLlbOiKvOkQppWEt/pKdO7N+CmeUpkLDjrkPHg75y9alEnASmJ/nT4qlw6yjSEa2wE9ixMil+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141689; c=relaxed/simple;
	bh=PrB2vUv0D0kSB7EjYwVzpUkP7cQR7ig5+NdpH1++wF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2J6RV4tFT4MnT0A9DzUBzJbSFLk5jT9twVVwLtN4Or25qMpq6FKtQd09FugRUdJrGy7eyLRcNIfAtlBL2aQkho5KJS+2zmHMi+1gSptcp4EbzsiD9RLgLtMGF2fRBkXmCdIDeL7iOtYYiLhemJpJi4BJ5DHd9l5T7JllTC0SIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0Hbm6KbZzYQtsC;
	Mon,  3 Nov 2025 11:47:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A09ED1A018D;
	Mon,  3 Nov 2025 11:48:01 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgC3J0vwJQhprpf+CQ--.49970S2;
	Mon, 03 Nov 2025 11:48:01 +0800 (CST)
Message-ID: <474e7133-0d43-4eb8-ae75-5e9a352c0eec@huaweicloud.com>
Date: Mon, 3 Nov 2025 11:47:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251103013411.239610-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3J0vwJQhprpf+CQ--.49970S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw17trWrCFy5GF1UKF4Durg_yoW7Zr48pF
	yUKFW3CayUtr13G343tF1v9r1Fkw4kJry2kasxG34rZFnrt3WktryUu3Z8A3yru39xWryU
	XrWqgrs2ga47ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/3 9:34, Waiman Long wrote:
> From: Gabriele Monaco <gmonaco@redhat.com>
> 
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
> 
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 67 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index da770dac955e..d6d459c95d82 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1329,6 +1329,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>  }
>  
> +/*
> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
> + * @prs: new or old partition_root_state
> + * @parent: parent cpuset
> + * Return: true if isolated_cpus needs modification, false otherwise
> + */
> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
> +{
> +	if (!parent)
> +		parent = &top_cpuset;
> +	return prs != parent->partition_root_state;
> +}
> +
>  /*
>   * partition_xcpus_add - Add new exclusive CPUs to partition
>   * @new_prs: new partition_root_state
> @@ -1393,6 +1406,42 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
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
> @@ -1551,6 +1600,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>  	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>  		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
> +		return PERR_HKEEPING;
>  
>  	spin_lock_irq(&callback_lock);
>  	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1650,6 +1702,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>  			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>  			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
> +			cs->prs_err = PERR_HKEEPING;
>  		if (cs->prs_err)
>  			goto invalidate;
>  	}
> @@ -1988,6 +2043,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			return err;
>  	}
>  
> +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> +	    !isolated_cpus_can_update(tmp->delmask, tmp->addmask)) {
> +		cs->prs_err = PERR_HKEEPING;
> +		return PERR_HKEEPING;
> +	}
> +
>  	/*
>  	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>  	 * only).
> @@ -2994,7 +3055,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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

I'm considering whether I should introduce a new function that consolidates
isolated_cpus_should_update, isolated_cpus_can_update, and prstate_housekeeping_conflict.

Just like:

bool housekeeping_conflict(...)
{
	if (isolated_cpus_should_update && !isolated_cpus_can_update) {
		return ture;
	}
	return prstate_housekeeping_conflict();
}

Since all of these are related to isolated CPUs, putting them into a centralized function would make
the code much easier to maintain.

-- 
Best regards,
Ridong


