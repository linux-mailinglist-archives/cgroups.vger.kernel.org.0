Return-Path: <cgroups+bounces-10894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C42BEF8DA
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C9944E93DA
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164A72D9EE7;
	Mon, 20 Oct 2025 06:57:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE02D780C;
	Mon, 20 Oct 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943473; cv=none; b=EFqwD79njTwV+4/jVPH60WjYSUTBx0DBqzIwC1EKw0x1ZA0reNQRZ+WpcLOQwYcvgzHP2Jm501m1heaEiXrUSfeaz9MyZvA6d19+FSMRm6as0VFlDgSSrRXePL9NWNGsBOxouNJFaVRxyyVABqWhCmF7wbz/7VQSILTRTgaczPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943473; c=relaxed/simple;
	bh=q8naxR3K/bCtoiM4Cr6D3ZqvL+9SJItYOw5w0h1xC/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQQ/7OKts8I3IA8J/J8IrZhmO3SBJkTnefM4IkvURR8xhZ7btLM2AfcLLVRgOoeZq2JHy8VzAaHRRs5eOYdyoUBcxZaozYtGk94iIbxqD+QJqpno7M3e4V2arzEOIBj777I7hpf6GM/Fvp97eAWEesCrUECWnu+suW2Quk+iLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqmSL1f37zYQtgW;
	Mon, 20 Oct 2025 14:56:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE11F1A11F8;
	Mon, 20 Oct 2025 14:57:40 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXXEFj3fVorszpAw--.59424S2;
	Mon, 20 Oct 2025 14:57:40 +0800 (CST)
Message-ID: <57cf1fbe-8356-4c5d-864a-20b07d63de72@huaweicloud.com>
Date: Mon, 20 Oct 2025 14:57:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: Don't track # of local child
 partitions
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>
References: <20251020023207.177809-1-longman@redhat.com>
 <20251020023207.177809-2-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251020023207.177809-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXXEFj3fVorszpAw--.59424S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF43WF18uw4kJr4fuw17Wrg_yoW7KrWxpF
	yUGr47JFWUta4UCa4Dta929w1rKwsFqayqkwn5Wa4fAFy7t3W0yFyjva9aqF1UWrykuryU
	ZFs0qr4fW3ZFkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 10:32, Waiman Long wrote:
> The cpuset structure has a nr_subparts field which tracks the number
> of child local partitions underneath a particular cpuset. Right now,
> nr_subparts is only used in partition_is_populated() to avoid iteration
> of child cpusets if the condition is right. So by always performing the
> child iteration, we can avoid tracking the number of child partitions
> and simplify the code a bit.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset-internal.h |  3 ---
>  kernel/cgroup/cpuset.c          | 41 +++++++++++----------------------
>  2 files changed, 13 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 337608f408ce..5cac42c5fd97 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -155,9 +155,6 @@ struct cpuset {
>  	/* for custom sched domain */
>  	int relax_domain_level;
>  
> -	/* number of valid local child partitions */
> -	int nr_subparts;
> -
>  	/* partition root state */
>  	int partition_root_state;
>  
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..7aef59ea9627 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -358,8 +358,13 @@ static inline bool is_in_v2_mode(void)
>   * @excluded_child: a child cpuset to be excluded in task checking
>   * Return: true if there are tasks, false otherwise
>   *
> - * It is assumed that @cs is a valid partition root. @excluded_child should
> - * be non-NULL when this cpuset is going to become a partition itself.
> + * @cs should be a valid partition root or going to become a partition root.
> + * @excluded_child should be non-NULL when this cpuset is going to become a
> + * partition itself.
> + *
> + * Note that a remote partition is not allowed underneath a valid local
> + * or remote partition. So if a non-partition root child is populated,
> + * the whole partition is considered populated.
>   */
>  static inline bool partition_is_populated(struct cpuset *cs,
>  					  struct cpuset *excluded_child)
> @@ -369,8 +374,6 @@ static inline bool partition_is_populated(struct cpuset *cs,
>  
>  	if (cs->css.cgroup->nr_populated_csets)
>  		return true;
> -	if (!excluded_child && !cs->nr_subparts)
> -		return cgroup_is_populated(cs->css.cgroup);
>  
>  	rcu_read_lock();
>  	cpuset_for_each_child(child, css, cs) {
> @@ -1302,7 +1305,6 @@ static void reset_partition_data(struct cpuset *cs)
>  
>  	lockdep_assert_held(&callback_lock);
>  
> -	cs->nr_subparts = 0;
>  	if (cpumask_empty(cs->exclusive_cpus)) {
>  		cpumask_clear(cs->effective_xcpus);
>  		if (is_cpu_exclusive(cs))
> @@ -1746,7 +1748,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
>  	int old_prs, new_prs;
>  	int part_error = PERR_NONE;	/* Partition error? */
> -	int subparts_delta = 0;
>  	int isolcpus_updated = 0;
>  	struct cpumask *xcpus = user_xcpus(cs);
>  	bool nocpu;
> @@ -1771,10 +1772,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		if (is_partition_valid(parent))
>  			adding = cpumask_and(tmp->addmask,
>  					     xcpus, parent->effective_xcpus);
> -		if (old_prs > 0) {
> +		if (old_prs > 0)
>  			new_prs = -old_prs;
> -			subparts_delta--;
> -		}
> +
>  		goto write_error;
>  	}
>  
> @@ -1829,7 +1829,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
>  
>  		deleting = true;
> -		subparts_delta++;
>  	} else if (cmd == partcmd_disable) {
>  		/*
>  		 * May need to add cpus back to parent's effective_cpus
> @@ -1840,7 +1839,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		if (is_partition_valid(cs)) {
>  			cpumask_copy(tmp->addmask, cs->effective_xcpus);
>  			adding = true;
> -			subparts_delta--;
>  		}
>  		new_prs = PRS_MEMBER;
>  	} else if (newmask) {
> @@ -1963,17 +1961,13 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		switch (cs->partition_root_state) {
>  		case PRS_ROOT:
>  		case PRS_ISOLATED:
> -			if (part_error) {
> +			if (part_error)
>  				new_prs = -old_prs;
> -				subparts_delta--;
> -			}
>  			break;
>  		case PRS_INVALID_ROOT:
>  		case PRS_INVALID_ISOLATED:
> -			if (!part_error) {
> +			if (!part_error)
>  				new_prs = -old_prs;
> -				subparts_delta++;
> -			}
>  			break;
>  		}
>  	}
> @@ -2002,11 +1996,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	 * newly deleted ones will be added back to effective_cpus.
>  	 */
>  	spin_lock_irq(&callback_lock);
> -	if (old_prs != new_prs) {
> +	if (old_prs != new_prs)
>  		cs->partition_root_state = new_prs;
> -		if (new_prs <= 0)
> -			cs->nr_subparts = 0;
> -	}
> +
>  	/*
>  	 * Adding to parent's effective_cpus means deletion CPUs from cs
>  	 * and vice versa.
> @@ -2018,10 +2010,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		isolcpus_updated += partition_xcpus_add(new_prs, parent,
>  							tmp->delmask);
>  
> -	if (is_partition_valid(parent)) {
> -		parent->nr_subparts += subparts_delta;
> -		WARN_ON_ONCE(parent->nr_subparts < 0);
> -	}
>  	spin_unlock_irq(&callback_lock);
>  	update_unbound_workqueue_cpumask(isolcpus_updated);
>  
> @@ -2105,8 +2093,6 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
>  			 */
>  			spin_lock_irq(&callback_lock);
>  			make_partition_invalid(child);
> -			cs->nr_subparts--;
> -			child->nr_subparts = 0;
>  			spin_unlock_irq(&callback_lock);
>  			notify_partition_change(child, old_prs);
>  			continue;
> @@ -4021,7 +4007,6 @@ static void cpuset_handle_hotplug(void)
>  		 */
>  		if (!cpumask_empty(subpartitions_cpus)) {
>  			if (cpumask_subset(&new_cpus, subpartitions_cpus)) {
> -				top_cpuset.nr_subparts = 0;
>  				cpumask_clear(subpartitions_cpus);
>  			} else {
>  				cpumask_andnot(&new_cpus, &new_cpus,

LGTM

-- 
Best regards,
Ridong


