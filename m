Return-Path: <cgroups+bounces-13929-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPUzLnqajmkKDQEAu9opvQ
	(envelope-from <cgroups+bounces-13929-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 04:28:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA8132A83
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 04:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B7C1300BC85
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC26218AC4;
	Fri, 13 Feb 2026 03:28:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B326299;
	Fri, 13 Feb 2026 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770953331; cv=none; b=M36Bv5VHrxXqcxplc6GbCjMZtGgfboBMJLfaCpFoYF3wTHccx2EO212KJAdsA9Q/wfr8Td7qEVwnzLdWTkjWJzqKMV4gmLjFMkRdDyG4lHr4x8f9+8NCwQim+ZQdHYIs7Jb1yvEy1X8fCWe8yFOd40GQYP88c4Ch+iD5iNTsQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770953331; c=relaxed/simple;
	bh=rfy7PjBQo/Ta9UEAQ42EDtHCuBiXRtu8hKXLdU453Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tloyYf9SpIamt6KHaWnkF6h0R5LIO9EHADqYfkco+v3toYFstbeWVNxy7p2BSpd1q+Mm+dZR4l2/tBI545dQS4FaFu5SojrOt2uceWAqjqROgXG5uVB0zc+3A621rCL1ScFFlXJHjtdTbXVCAi3o+ql0wIZ0+BcSYZF3lTUKt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fByLf0CvHzYQv6X;
	Fri, 13 Feb 2026 11:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CC5A24058D;
	Fri, 13 Feb 2026 11:28:44 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPhrmo5pqTz_HA--.43909S2;
	Fri, 13 Feb 2026 11:28:44 +0800 (CST)
Message-ID: <de1cf3d0-8922-4740-9e4f-501cc38c70b0@huaweicloud.com>
Date: Fri, 13 Feb 2026 11:28:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] cgroup/cpuset: Don't update isolated_cpus from CPU
 hotplug
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260212164640.2408295-1-longman@redhat.com>
 <20260212164640.2408295-5-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260212164640.2408295-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAniPhrmo5pqTz_HA--.43909S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr13ZF4rtw1kGF1fKFyUWrg_yoW8XrW8uo
	W7JF4rAw1fXw15ZFs8W342kFykW3yqy3ZIyw45Zr1DuFy3Ar9Fyasxt3Zavr1fWFWrtrW5
	JFyIv3yFkrZ7A3Zxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13929-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E5CA8132A83
X-Rspamd-Action: no action



On 2026/2/13 0:46, Waiman Long wrote:
> As any change to isolated_cpus is going to be propagated to the
> HK_TYPE_DOMAIN housekeeping cpumask, it can be problematic if
> housekeeping cpumasks are directly being modified from the CPU hotplug
> code path. This is especially the case if we are going to enable dynamic
> update to the nohz_full housekeeping cpumask (HK_TYPE_KERNEL_NOISE)
> in the near future with the help of CPU hotplug.
> 
> Avoid these potential problems by changing the cpuset code to not
> updating isolated_cpus when calling from CPU hotplug. A new special
> PRS_INVALID_ISOLCPUS is added to indicate the current cpuset is an
> invalid partition but its effective_xcpus are still in isolated_cpus.
> This special state will be set if an isolated partition becomes invalid
> due to the shutdown of the last active CPU in that partition. We also
> need to keep the effective_xcpus even if exclusive_cpus isn't set.
> 
> When changes are made to "cpuset.cpus", "cpuset.cpus.exclusive" or
> "cpuset.cpus.partition" of a PRS_INVALID_ISOLCPUS cpuset, its state
> will be reset back to PRS_INVALID_ISOLATED and its effective_xcpus will
> be removed from isolated_cpus before proceeding.
> 
> As CPU hotplug will no longer update isolated_cpus, some of the test
> cases in test_cpuset_prs.h will have to be updated to match the new
> expected results. Some new test cases are also added to confirm that
> "cpuset.cpus.isolated" and HK_TYPE_DOMAIN housekeeping cpumask will
> both be updated.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c                        | 85 ++++++++++++++++---
>  .../selftests/cgroup/test_cpuset_prs.sh       | 21 +++--
>  2 files changed, 87 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c792380f9b60..48b7f275085b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -159,6 +159,8 @@ static bool force_sd_rebuild;			/* RWCS */
>   *   2 - partition root without load balancing (isolated)
>   *  -1 - invalid partition root
>   *  -2 - invalid isolated partition root
> + *  -3 - invalid isolated partition root but with effective xcpus still
> + *	 in isolated_cpus (set from CPU hotplug side)
>   *
>   *  There are 2 types of partitions - local or remote. Local partitions are
>   *  those whose parents are partition root themselves. Setting of
> @@ -187,6 +189,7 @@ static bool force_sd_rebuild;			/* RWCS */
>  #define PRS_ISOLATED		2
>  #define PRS_INVALID_ROOT	-1
>  #define PRS_INVALID_ISOLATED	-2
> +#define PRS_INVALID_ISOLCPUS	-3 /* Effective xcpus still in isolated_cpus */
>  
>  /*
>   * Temporary cpumasks for working with partitions that are passed among
> @@ -382,6 +385,30 @@ static inline bool is_in_v2_mode(void)
>  	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>  }
>  
> +/*
> + * If the given cpuset has a partition state of PRS_INVALID_ISOLCPUS,
> + * remove its effective_xcpus from isolated_cpus and reset its state to
> + * PRS_INVALID_ISOLATED. Also clear effective_xcpus if exclusive_cpus is
> + * empty.
> + */
> +static void fix_invalid_isolcpus(struct cpuset *cs, struct cpuset *trialcs)
> +{
> +	if (likely(cs->partition_root_state != PRS_INVALID_ISOLCPUS))
> +		return;
> +	WARN_ON_ONCE(cpumask_empty(cs->effective_xcpus));
> +	spin_lock_irq(&callback_lock);
> +	cpumask_andnot(isolated_cpus, isolated_cpus, cs->effective_xcpus);
> +	if (cpumask_empty(cs->exclusive_cpus))
> +		cpumask_clear(cs->effective_xcpus);
> +	cs->partition_root_state = PRS_INVALID_ISOLATED;
> +	spin_unlock_irq(&callback_lock);
> +	isolated_cpus_updating = true;
> +	if (trialcs) {
> +		trialcs->partition_root_state = PRS_INVALID_ISOLATED;
> +		cpumask_copy(trialcs->effective_xcpus, cs->effective_xcpus);
> +	}
> +}

When fix_invalid_isolcpus is called from changing cpus/exclusive cpus, should we
copy cs->effective_xcpus to trialcs->effective_xcpus?

I tested as follow steps(using the whole series):

 # cd /sys/fs/cgroup/
 # mkdir test
 # echo 1 > cpuset.cpus.
 # cd test/
 # echo 1 > cpuset.cpus.exclusive
 # echo $$ > cgroup.procs
 # echo isolated > cpuset.cpus.partition
 # cat cpuset.cpus.partition
isolated
 # echo 0 > /sys/devices/system/cpu/cpu1/online
 # cat cpuset.cpus.partition
isolated invalid
 # echo 2 > cpuset.cpus.exclusive
 # cat cpuset.cpus.partition
isolated invalid (Parent unable to distribute cpu downstream)

After changing cpuset.cpus.exclusive to 2, the test cpuset should
become valid again, but it remains invalid.

>  /**
>   * partition_is_populated - check if partition has tasks
>   * @cs: partition root to be checked
> @@ -1160,7 +1187,8 @@ static void reset_partition_data(struct cpuset *cs)
>  
>  	lockdep_assert_held(&callback_lock);
>  
> -	if (cpumask_empty(cs->exclusive_cpus)) {
> +	if (cpumask_empty(cs->exclusive_cpus) &&
> +	    (cs->partition_root_state != PRS_INVALID_ISOLCPUS)) {
>  		cpumask_clear(cs->effective_xcpus);
>  		if (is_cpu_exclusive(cs))
>  			clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
> @@ -1189,6 +1217,10 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>  			return;
>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>  	}
> +	/*
> +	 * Shouldn't update isolated_cpus from CPU hotplug
> +	 */
> +	WARN_ON_ONCE(current->flags & PF_KTHREAD);
>  	isolated_cpus_updating = true;
>  }
>  
> @@ -1208,7 +1240,6 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
>  	if (!parent)
>  		parent = &top_cpuset;
>  
> -
>  	if (parent == &top_cpuset)
>  		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
>  
> @@ -1224,11 +1255,12 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
>   * @old_prs: old partition_root_state
>   * @parent: parent cpuset
>   * @xcpus: exclusive CPUs to be removed
> + * @no_isolcpus: don't update isolated_cpus
>   *
>   * Remote partition if parent == NULL
>   */
>  static void partition_xcpus_del(int old_prs, struct cpuset *parent,
> -				struct cpumask *xcpus)
> +				struct cpumask *xcpus, bool no_isolcpus)
>  {
>  	WARN_ON_ONCE(old_prs < 0);
>  	lockdep_assert_held(&callback_lock);
> @@ -1238,7 +1270,7 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	if (parent == &top_cpuset)
>  		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
>  
> -	if (old_prs != parent->partition_root_state)
> +	if ((old_prs != parent->partition_root_state) && !no_isolcpus)
>  		isolated_cpus_update(old_prs, parent->partition_root_state,
>  				     xcpus);
>  
> @@ -1496,6 +1528,8 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   */
>  static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  {
> +	int old_prs = cs->partition_root_state;
> +
>  	WARN_ON_ONCE(!is_remote_partition(cs));
>  	/*
>  	 * When a CPU is offlined, top_cpuset may end up with no available CPUs,
> @@ -1508,14 +1542,24 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  
>  	spin_lock_irq(&callback_lock);
>  	cs->remote_partition = false;
> -	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
>  	if (cs->prs_err)
>  		cs->partition_root_state = -cs->partition_root_state;
>  	else
>  		cs->partition_root_state = PRS_MEMBER;
> +	/*
> +	 * Don't update isolated_cpus if calling from CPU hotplug kthread
> +	 */
> +	if ((current->flags & PF_KTHREAD) &&
> +	    (cs->partition_root_state == PRS_INVALID_ISOLATED))
> +		cs->partition_root_state = PRS_INVALID_ISOLCPUS;
>  
> -	/* effective_xcpus may need to be changed */
> -	compute_excpus(cs, cs->effective_xcpus);
> +	partition_xcpus_del(old_prs, NULL, cs->effective_xcpus,
> +			    cs->partition_root_state == PRS_INVALID_ISOLCPUS);
> +	/*
> +	 * effective_xcpus may need to be changed
> +	 */
> +	if (cs->partition_root_state != PRS_INVALID_ISOLCPUS)
> +		compute_excpus(cs, cs->effective_xcpus);
>  	reset_partition_data(cs);
>  	spin_unlock_irq(&callback_lock);
>  	update_isolation_cpumasks();
> @@ -1580,7 +1624,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  	if (adding)
>  		partition_xcpus_add(prs, NULL, tmp->addmask);
>  	if (deleting)
> -		partition_xcpus_del(prs, NULL, tmp->delmask);
> +		partition_xcpus_del(prs, NULL, tmp->delmask, false);
>  	/*
>  	 * Need to update effective_xcpus and exclusive_cpus now as
>  	 * update_sibling_cpumasks() below may iterate back to the same cs.
> @@ -1893,6 +1937,10 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			if (!part_error)
>  				new_prs = -old_prs;
>  			break;
> +		case PRS_INVALID_ISOLCPUS:
> +			if (!part_error)
> +				new_prs = PRS_ISOLATED;
> +			break;
>  		}
>  	}
>  
> @@ -1923,12 +1971,19 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  	if (old_prs != new_prs)
>  		cs->partition_root_state = new_prs;
>  
> +	/*
> +	 * Don't update isolated_cpus if calling from CPU hotplug kthread
> +	 */
> +	if ((current->flags & PF_KTHREAD) &&
> +	    (cs->partition_root_state == PRS_INVALID_ISOLATED))
> +		cs->partition_root_state = PRS_INVALID_ISOLCPUS;
>  	/*
>  	 * Adding to parent's effective_cpus means deletion CPUs from cs
>  	 * and vice versa.
>  	 */
>  	if (adding)
> -		partition_xcpus_del(old_prs, parent, tmp->addmask);
> +		partition_xcpus_del(old_prs, parent, tmp->addmask,
> +				    cs->partition_root_state == PRS_INVALID_ISOLCPUS);
>  	if (deleting)
>  		partition_xcpus_add(new_prs, parent, tmp->delmask);
>  
> @@ -2317,6 +2372,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>  	if (cs_is_member(cs))
>  		return;
>  
> +	fix_invalid_isolcpus(cs, trialcs);
>  	prs_err = validate_partition(cs, trialcs);
>  	if (prs_err)
>  		trialcs->prs_err = cs->prs_err = prs_err;
> @@ -2818,6 +2874,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	if (alloc_tmpmasks(&tmpmask))
>  		return -ENOMEM;
>  
> +	fix_invalid_isolcpus(cs, NULL);
>  	err = update_partition_exclusive_flag(cs, new_prs);
>  	if (err)
>  		goto out;
> @@ -3268,6 +3325,7 @@ static int cpuset_partition_show(struct seq_file *seq, void *v)
>  		type = "root";
>  		fallthrough;
>  	case PRS_INVALID_ISOLATED:
> +	case PRS_INVALID_ISOLCPUS:
>  		if (!type)
>  			type = "isolated";
>  		err = perr_strings[READ_ONCE(cs->prs_err)];
> @@ -3463,9 +3521,9 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>  }
>  
>  /*
> - * If a dying cpuset has the 'cpus.partition' enabled, turn it off by
> - * changing it back to member to free its exclusive CPUs back to the pool to
> - * be used by other online cpusets.
> + * If a dying cpuset has the 'cpus.partition' enabled or is in the
> + * PRS_INVALID_ISOLCPUS state, turn it off by changing it back to member to
> + * free its exclusive CPUs back to the pool to be used by other online cpusets.
>   */
>  static void cpuset_css_killed(struct cgroup_subsys_state *css)
>  {
> @@ -3473,7 +3531,8 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
>  
>  	cpuset_full_lock();
>  	/* Reset valid partition back to member */
> -	if (is_partition_valid(cs))
> +	if (is_partition_valid(cs) ||
> +	    (cs->partition_root_state == PRS_INVALID_ISOLCPUS))
>  		update_prstate(cs, PRS_MEMBER);
>  	cpuset_full_unlock();
>  }
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 5dff3ad53867..380506157f70 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -234,6 +234,7 @@ TEST_MATRIX=(
>  	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
>  
>  	# CPU offlining cases:
> +	# cpuset.cpus.isolated should no longer be updated.
>  	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   0 A1:0-1|B1:3"
>  	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     0 A1:0-1|A2:3"
>  	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     0 A1:0-1|A2:2-3"
> @@ -245,8 +246,9 @@ TEST_MATRIX=(
>  	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
>  	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
>  	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
> -	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
> -	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
> +	"C2-3:P1:S+  C3:P2  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-2"
> +	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0   .      .     0 A1:1-2|A2:1-2|XA2:3 A1:P1|A2:P-2 3"
> +	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0  O3=1    .     0 A1:1-2|A2:3|XA2:3 A1:P1|A2:P2  3"
>  	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
>  	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
>  	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
> @@ -299,13 +301,14 @@ TEST_MATRIX=(
>  								       A1:P0|A2:P2|A3:P-1 2-4"
>  
>  	# Remote partition offline tests
> +	# CPU offline shouldn't change cpuset.cpus.{isolated,exclusive.effective}
>  	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
>  	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
> -	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3: A1:P0|A3:P2 3"
> -	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2 A1:P0|A3:P-2 3|"
> +	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3:|XA3:3 A1:P0|A3:P2 3"
> +	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2|XA3:3 A1:P0|A3:P-2 3"
>  
>  	# An invalidated remote partition cannot self-recover from hotplug
> -	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2 ."
> +	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2|XA3:2 A1:P0|A3:P-2 2"
>  
>  	# cpus.exclusive.effective clearing test
>  	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3|A2:1-3|A3:2|XA1:"
> @@ -764,7 +767,7 @@ check_cgroup_states()
>  # only CPUs in isolated partitions as well as those that are isolated at
>  # boot time.
>  #
> -# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
> +# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
>  # <isolcpus1> - expected sched/domains value
>  # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
>  #
> @@ -773,6 +776,7 @@ check_isolcpus()
>  	EXPECTED_ISOLCPUS=$1
>  	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
>  	ISOLCPUS=$(cat $ISCPUS)
> +	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
>  	LASTISOLCPU=
>  	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
>  	if [[ $EXPECTED_ISOLCPUS = . ]]
> @@ -810,6 +814,11 @@ check_isolcpus()
>  	ISOLCPUS=
>  	EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
>  
> +	#
> +	# The inverse of HK_TYPE_DOMAIN cpumask in $HKICPUS should match $ISOLCPUS
> +	#
> +	[[ "$ISOLCPUS" != "$HKICPUS" ]] && return 1
> +
>  	#
>  	# Use the sched domain in debugfs to check isolated CPUs, if available
>  	#

-- 
Best regards,
Ridong


