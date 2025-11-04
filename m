Return-Path: <cgroups+bounces-11554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA925C2EF4D
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 03:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F863BA7C4
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 02:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B4C23EA8C;
	Tue,  4 Nov 2025 02:21:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B61239E88;
	Tue,  4 Nov 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222876; cv=none; b=q8liEgPu9PtphwnE7Ply//itT0U5g7hzpcgKzXuA9W/LAOtEgc7BrTIdDcpQ8icHvsf1YazMoBBpM0lwN7n/b7BxRWxo7T9BaAZlw7SrnMWeIksAjce2Y/bN1NF4m2F1XRsMZACHNPclo/dC8qPSjZoHNKMYAL+l4Mo6Gdl6zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222876; c=relaxed/simple;
	bh=hTjJI2sEDxld3XmRSatkLRSAROGgVC4Yc63EfV05gEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onY8zJFMAzglMCkEOmZkVEUeJAypknwDi9eRMErREYugBzAZ54levSQOMLJn9oRV+D4AmGlOktO/wzJr2RNa+5+O96MxLiPNIaggxt7YpcUfwn6rycP9E5dbBQwaouTNXidt66n7yTSa5zZ2SA/L1XJOHEj8ivHgkVstDGB804o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0sd60gclzYQthW;
	Tue,  4 Nov 2025 10:20:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 693D61A07BD;
	Tue,  4 Nov 2025 10:21:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB36EsYYwlpWaloCg--.17647S2;
	Tue, 04 Nov 2025 10:21:12 +0800 (CST)
Message-ID: <af394d1c-1a13-4322-ba79-913193a1b5e0@huaweicloud.com>
Date: Tue, 4 Nov 2025 10:21:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH v2 3/3] cgroup/cpuset: Globally track
 isolated_cpus update
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251104013037.296013-1-longman@redhat.com>
 <20251104013037.296013-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251104013037.296013-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB36EsYYwlpWaloCg--.17647S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw15AFyrGw1UZry7Zw4Dtwb_yoWfuw1UpF
	yUCFWxKFWUtw15u343tFsFkw4fKw4DtFnFyw15Wa4rZF9rXwn7ta4jka90yay5WrWDJrW5
	XFWqgws7WF4xCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/4 9:30, Waiman Long wrote:
> The current cpuset code passes a local isolcpus_updated flag around in a
> number of functions to determine if external isolation related cpumasks
> like wq_unbound_cpumask should be updated. It is a bit cumbersome and
> makes the code more complex. Simplify the code by using a global boolean
> flag "isolated_cpus_updating" to track this. This flag will be set in
> isolated_cpus_update() and cleared in update_isolation_cpumasks().
> 
> No functional change is expected.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 73 ++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0c49905df394..854fe4cc1358 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -81,6 +81,13 @@ static cpumask_var_t	subpartitions_cpus;
>   */
>  static cpumask_var_t	isolated_cpus;
>  
> +/*
> + * isolated_cpus updating flag (protected by cpuset_mutex)
> + * Set if isolated_cpus is going to be updated in the current
> + * cpuset_mutex crtical section.
> + */
> +static bool isolated_cpus_updating;
> +
>  /*
>   * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
>   */
> @@ -1327,6 +1334,8 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>  		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
>  	else
>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
> +
> +	isolated_cpus_updating = true;
>  }
>  
>  /*
> @@ -1334,15 +1343,12 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>   * @new_prs: new partition_root_state
>   * @parent: parent cpuset
>   * @xcpus: exclusive CPUs to be added
> - * Return: true if isolated_cpus modified, false otherwise
>   *
>   * Remote partition if parent == NULL
>   */
> -static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
> +static void partition_xcpus_add(int new_prs, struct cpuset *parent,
>  				struct cpumask *xcpus)
>  {
> -	bool isolcpus_updated;
> -
>  	WARN_ON_ONCE(new_prs < 0);
>  	lockdep_assert_held(&callback_lock);
>  	if (!parent)
> @@ -1352,13 +1358,11 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>  	if (parent == &top_cpuset)
>  		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
>  
> -	isolcpus_updated = (new_prs != parent->partition_root_state);
> -	if (isolcpus_updated)
> +	if (new_prs != parent->partition_root_state)
>  		isolated_cpus_update(parent->partition_root_state, new_prs,
>  				     xcpus);
>  
>  	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
> -	return isolcpus_updated;
>  }
>  
>  /*
> @@ -1366,15 +1370,12 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>   * @old_prs: old partition_root_state
>   * @parent: parent cpuset
>   * @xcpus: exclusive CPUs to be removed
> - * Return: true if isolated_cpus modified, false otherwise
>   *
>   * Remote partition if parent == NULL
>   */
> -static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
> +static void partition_xcpus_del(int old_prs, struct cpuset *parent,
>  				struct cpumask *xcpus)
>  {
> -	bool isolcpus_updated;
> -
>  	WARN_ON_ONCE(old_prs < 0);
>  	lockdep_assert_held(&callback_lock);
>  	if (!parent)
> @@ -1383,14 +1384,12 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	if (parent == &top_cpuset)
>  		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
>  
> -	isolcpus_updated = (old_prs != parent->partition_root_state);
> -	if (isolcpus_updated)
> +	if (old_prs != parent->partition_root_state)
>  		isolated_cpus_update(old_prs, parent->partition_root_state,
>  				     xcpus);
>  
>  	cpumask_and(xcpus, xcpus, cpu_active_mask);
>  	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
> -	return isolcpus_updated;
>  }
>  
>  /*
> @@ -1432,17 +1431,24 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>  	return res;
>  }
>  
> -static void update_isolation_cpumasks(bool isolcpus_updated)
> +/*
> + * update_isolation_cpumasks - Update external isolation related CPU masks
> + *
> + * The following external CPU masks will be updated if necessary:
> + * - workqueue unbound cpumask
> + */
> +static void update_isolation_cpumasks(void)
>  {
>  	int ret;
>  
> -	lockdep_assert_cpus_held();
> -
> -	if (!isolcpus_updated)
> +	if (!isolated_cpus_updating)
>  		return;
>  
> +	lockdep_assert_cpus_held();
> +
>  	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>  	WARN_ON_ONCE(ret < 0);
> +	isolated_cpus_updating = false;
>  }
>  
>  /**
> @@ -1567,8 +1573,6 @@ static inline bool is_local_partition(struct cpuset *cs)
>  static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  				   struct tmpmasks *tmp)
>  {
> -	bool isolcpus_updated;
> -
>  	/*
>  	 * The user must have sysadmin privilege.
>  	 */
> @@ -1595,11 +1599,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  		return PERR_HKEEPING;
>  
>  	spin_lock_irq(&callback_lock);
> -	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> +	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>  	list_add(&cs->remote_sibling, &remote_children);
>  	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  	cpuset_force_rebuild();
>  	cs->prs_err = 0;
>  
> @@ -1622,15 +1626,12 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   */
>  static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  {
> -	bool isolcpus_updated;
> -
>  	WARN_ON_ONCE(!is_remote_partition(cs));
>  	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
>  
>  	spin_lock_irq(&callback_lock);
>  	list_del_init(&cs->remote_sibling);
> -	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
> -					       NULL, cs->effective_xcpus);
> +	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
>  	if (cs->prs_err)
>  		cs->partition_root_state = -cs->partition_root_state;
>  	else
> @@ -1640,7 +1641,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  	compute_excpus(cs, cs->effective_xcpus);
>  	reset_partition_data(cs);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  	cpuset_force_rebuild();
>  
>  	/*
> @@ -1665,7 +1666,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  {
>  	bool adding, deleting;
>  	int prs = cs->partition_root_state;
> -	int isolcpus_updated = 0;
>  
>  	if (WARN_ON_ONCE(!is_remote_partition(cs)))
>  		return;
> @@ -1701,9 +1701,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  
>  	spin_lock_irq(&callback_lock);
>  	if (adding)
> -		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
> +		partition_xcpus_add(prs, NULL, tmp->addmask);
>  	if (deleting)
> -		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
> +		partition_xcpus_del(prs, NULL, tmp->delmask);
>  	/*
>  	 * Need to update effective_xcpus and exclusive_cpus now as
>  	 * update_sibling_cpumasks() below may iterate back to the same cs.
> @@ -1712,7 +1712,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  	if (xcpus)
>  		cpumask_copy(cs->exclusive_cpus, xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  	if (adding || deleting)
>  		cpuset_force_rebuild();
>  
> @@ -1793,7 +1793,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
>  	int old_prs, new_prs;
>  	int part_error = PERR_NONE;	/* Partition error? */
> -	int isolcpus_updated = 0;
>  	struct cpumask *xcpus = user_xcpus(cs);
>  	int parent_prs = parent->partition_root_state;
>  	bool nocpu;
> @@ -2072,14 +2071,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	 * and vice versa.
>  	 */
>  	if (adding)
> -		isolcpus_updated += partition_xcpus_del(old_prs, parent,
> -							tmp->addmask);
> +		partition_xcpus_del(old_prs, parent, tmp->addmask);
>  	if (deleting)
> -		isolcpus_updated += partition_xcpus_add(new_prs, parent,
> -							tmp->delmask);
> +		partition_xcpus_add(new_prs, parent, tmp->delmask);
>  
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  
>  	if ((old_prs != new_prs) && (cmd == partcmd_update))
>  		update_partition_exclusive_flag(cs, new_prs);
> @@ -3102,7 +3099,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	else if (isolcpus_updated)
>  		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  
>  	/* Force update if switching back to member & update effective_xcpus */
>  	update_cpumasks_hier(cs, &tmpmask, !new_prs);

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


