Return-Path: <cgroups+bounces-10159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAE4B590B6
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4D167957
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645C281368;
	Tue, 16 Sep 2025 08:32:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363D277CBD;
	Tue, 16 Sep 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011523; cv=none; b=oi2/jtcFNlqePxJfZZNwM3bgPHPMx8cCxhtuo5vhtSp3GkDAV489Hs1Ee6olrJZAdwFSTuZL+VI5nFncsDRKoVIEJGleg8+ozno5VEWaHUKTJxv/jTSoV/s78mlwLVoGOQ7/+9oDF9WITYfTb4iUh+SGkvRmD9T0nGnR98d7UU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011523; c=relaxed/simple;
	bh=TV2YpNqkr2/HVhtBb1Qdjz/zFEuFyZxjryfOwa4Mzos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOzHfEcjAvki7aoROGKoeImXQIMgt6wfgj1JzBSgollocqEcQ6vOzvQju+x/+UGXgYIgGZoLpRE3KJd7NOZxiGDKyE2pSKmPzzXAYEfDaDfZMAktOOZMk2EVrqLbeDboUT9CcW+KxRwkP/eBUqpqP7JE1NXcMvmXKwbFPYnwDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cQw9l6gg2zKHMwL;
	Tue, 16 Sep 2025 16:31:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8F49A1A1D93;
	Tue, 16 Sep 2025 16:31:56 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgA3YJd7IMlofN+gCg--.43662S2;
	Tue, 16 Sep 2025 16:31:56 +0800 (CST)
Message-ID: <b7f61f22-5769-4c54-913d-302d18769db2@huaweicloud.com>
Date: Tue, 16 Sep 2025 16:31:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/9] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-18-gmonaco@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250915145920.140180-18-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3YJd7IMlofN+gCg--.43662S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw17Xr1fKF4xuw1fWr4fuFg_yoW7Zw47pF
	yUKrW3AayUtr13G343JF4kurnY9w4kJry2k3ZxG34rZF17t3WktryUC3Z0yFWru39xWry8
	XrZ09rs2ga47ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/15 22:59, Gabriele Monaco wrote:
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
> 
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 81a9239053a7..3cedc3580373 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
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

Hi all,

I'm a bit confused about the logic for updating isolated CPUs.

As I understand it, the isolated_cpus set should be updated in two scenarios:
1. When changing to an isolated partition.
2. When a valid isolated partition becomes invalid or changes its membership.

However, I find the current approach of comparing the parent's partition_root_state with prs to
determine whether to update the isolated CPUs somewhat difficult to follow.

Wouldn't a more straightforward approach be something like this?

static bool isolated_cpus_should_update(int old_prs, int new_prs)
{
    if (old_prs == new_prs)
        return false;

    /* Changing to an isolated partition */
    if (new_prs == PRS_ISOLATED)
        return true;

    /* Isolated partition changing to another state */
    if (old_prs == PRS_ISOLATED)
        return true;

    return false;
}

I'd greatly appreciate it if someone could help clarify this. Thank you.

>  /*
>   * partition_xcpus_add - Add new exclusive CPUs to partition
>   * @new_prs: new partition_root_state
> @@ -1339,6 +1352,42 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
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
>  static void update_exclusion_cpumasks(bool isolcpus_updated)
>  {
>  	int ret;
> @@ -1464,6 +1513,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>  	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>  		return PERR_INVCPUS;
> +	if (isolated_cpus_should_update(new_prs, NULL) &&
> +	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
> +		return PERR_HKEEPING;
>  
>  	spin_lock_irq(&callback_lock);
>  	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> @@ -1563,6 +1615,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>  			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>  			cs->prs_err = PERR_NOCPUS;
> +		else if (isolated_cpus_should_update(prs, NULL) &&
> +			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
> +			cs->prs_err = PERR_HKEEPING;
>  		if (cs->prs_err)
>  			goto invalidate;
>  	}
> @@ -1914,6 +1969,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
> @@ -2934,6 +2995,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  		 * Need to update isolated_cpus.
>  		 */
>  		isolcpus_updated = true;
> +		if (!isolated_cpus_can_update(cs->effective_xcpus, NULL))
> +			err = PERR_HKEEPING;
>  	} else {
>  		/*
>  		 * Switching back to member is always allowed even if it

-- 
Best regards,
Ridong


