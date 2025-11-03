Return-Path: <cgroups+bounces-11489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E408C2A3A0
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 07:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C05D4E7784
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15125111A8;
	Mon,  3 Nov 2025 06:46:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3778488;
	Mon,  3 Nov 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152390; cv=none; b=KX6/m3vsFz/wO/e9wjjLde2xtqYJopgLtslWJ1PxsLZuLdBaLNbc8CS1rRxNnuegS5Tpc0My0G4BDP3q0t72zMriPuQzTPLOsYI13P1YfZr2suiXNKPCd7H92oJTLHdOvSJpig21P7WfghJp7LjubhRxVwPl5vNyGTOyc7JGmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152390; c=relaxed/simple;
	bh=MvK/sVL/GMRf1EE+aA4FT7Yydp12nA+OqKYU9tDhPlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0RhgK6H9LZGqqCZOs9LVGt6Wwh7gHtD3QwSkcLJL8vmLdP7k7tKVCY+UEY8xLvkAvGz07psNxDfxUYRZCBL/0gLKXXFznO6XBwPvhfOn8WMWXA4nWDlfRgddPIHwjRWtpJgkWhXzHJMN5NQ5HbwXYo9bk4hDDqqGH7k3nBgZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0MYc0sn0zYQtwq;
	Mon,  3 Nov 2025 14:46:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 161E11A07BB;
	Mon,  3 Nov 2025 14:46:25 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHnUW_TwhpLCouCg--.9161S2;
	Mon, 03 Nov 2025 14:46:24 +0800 (CST)
Message-ID: <ffe1d7ec-70fc-44cd-879c-23902929a24a@huaweicloud.com>
Date: Mon, 3 Nov 2025 14:46:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 3/3] cgroup/cpuset: Globally track
 isolated_cpus update
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251103013411.239610-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnUW_TwhpLCouCg--.9161S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CFWfJw1ftr15tFyDJFyxXwb_yoWDWFW5pF
	yUCFWxKFWUtw15u343tFsFkw4Skw4DtF12kw15Wa4rZF9rXwn7ta4jka90yayrWrZ8JrW5
	XFWqgws7WF1xCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/3 9:34, Waiman Long wrote:
> The current cpuset code passes a local isolcpus_updated flag around in a
> number of functions to determine if external isolation related cpumasks
> like wq_unbound_cpumask should be updated. It is a bit cumbersome and
> makes the code more complex. Simplify the code by using a global boolean

Agree.

> flag "isolated_cpus_updating" to track this. This flag will be set in
> isolated_cpus_update() and cleared in update_isolation_cpumasks().
> 
> No functional change is expected.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 74 ++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d6d459c95d82..406a1c3789f5 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -81,6 +81,13 @@ static cpumask_var_t	subpartitions_cpus;
>   */
>  static cpumask_var_t	isolated_cpus;
>  

Is isolated_cpus protected by cpuset_mutex or callback_lock?

If isolated_cpus is indeed protected by cpuset_mutex, perhaps we can move the update of
isolated_cpus outside the critical section of callback_lock. This would allow us to call
update_isolation_cpumasks in isolated_cpus_update, making the isolated_cpus_updating variable
unnecessary. Reducing a global variable would be beneficial.

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
> @@ -1327,13 +1334,14 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>  		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
>  	else
>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
> +
> +	isolated_cpus_updating = true;
>  }
>  
>  /*
>   * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>   * @prs: new or old partition_root_state
>   * @parent: parent cpuset
> - * Return: true if isolated_cpus needs modification, false otherwise
>   */
>  static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>  {
> @@ -1347,15 +1355,12 @@ static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
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
> @@ -1365,13 +1370,11 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>  	if (parent == &top_cpuset)
>  		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
>  
> -	isolcpus_updated = (new_prs != parent->partition_root_state);
> -	if (isolcpus_updated)
> +	if (new_prs != parent->partition_root_state)

Can this if statement be replaced with new helper isolated_cpus_should_update？

>  		isolated_cpus_update(parent->partition_root_state, new_prs,
>  				     xcpus);
>  
>  	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
> -	return isolcpus_updated;
>  }
>  
>  /*
> @@ -1379,15 +1382,12 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
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
> @@ -1396,14 +1396,12 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	if (parent == &top_cpuset)
>  		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
>  
> -	isolcpus_updated = (old_prs != parent->partition_root_state);
> -	if (isolcpus_updated)
> +	if (old_prs != parent->partition_root_state)
>  		isolated_cpus_update(old_prs, parent->partition_root_state,
>  				     xcpus);
>  

Ditto

>  	cpumask_and(xcpus, xcpus, cpu_active_mask);
>  	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
> -	return isolcpus_updated;
>  }
>  
>  /*
> @@ -1442,17 +1440,24 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
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
> @@ -1577,8 +1582,6 @@ static inline bool is_local_partition(struct cpuset *cs)
>  static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  				   struct tmpmasks *tmp)
>  {
> -	bool isolcpus_updated;
> -
>  	/*
>  	 * The user must have sysadmin privilege.
>  	 */
> @@ -1605,11 +1608,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
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
> @@ -1632,15 +1635,12 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
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
> @@ -1650,7 +1650,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  	compute_excpus(cs, cs->effective_xcpus);
>  	reset_partition_data(cs);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  	cpuset_force_rebuild();
>  
>  	/*
> @@ -1675,7 +1675,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  {
>  	bool adding, deleting;
>  	int prs = cs->partition_root_state;
> -	int isolcpus_updated = 0;
>  
>  	if (WARN_ON_ONCE(!is_remote_partition(cs)))
>  		return;
> @@ -1711,9 +1710,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
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
> @@ -1722,7 +1721,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  	if (xcpus)
>  		cpumask_copy(cs->exclusive_cpus, xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  	if (adding || deleting)
>  		cpuset_force_rebuild();
>  
> @@ -1803,7 +1802,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
>  	int old_prs, new_prs;
>  	int part_error = PERR_NONE;	/* Partition error? */
> -	int isolcpus_updated = 0;
>  	struct cpumask *xcpus = user_xcpus(cs);
>  	bool nocpu;
>  
> @@ -2065,14 +2063,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
> @@ -3094,7 +3090,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	else if (isolcpus_updated)
>  		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_isolation_cpumasks(isolcpus_updated);
> +	update_isolation_cpumasks();
>  
>  	/* Force update if switching back to member & update effective_xcpus */
>  	update_cpumasks_hier(cs, &tmpmask, !new_prs);

-- 
Best regards,
Ridong


