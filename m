Return-Path: <cgroups+bounces-13803-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOBhA5FbiWkZ7gQAu9opvQ
	(envelope-from <cgroups+bounces-13803-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 04:59:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A423010B7A6
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 04:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78ED030063AA
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 03:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BB2D3733;
	Mon,  9 Feb 2026 03:59:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1828506C;
	Mon,  9 Feb 2026 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609547; cv=none; b=HdgykdWzX2iL3nYEe2XxS7nEskoo4NKdqFR65S74y3ZO1O4gvRh2Uucrbp9eYthnh3wKnpqZJ/z/LBWMnyZ6zWHoOQXgKaUgh2Oc4bXDCjRrg1xD4yiOVt7KPM8BqrnX0DBrl+HrY6aIKYtPqpNsIDZ7EqK5ocftcTUFe9/BHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609547; c=relaxed/simple;
	bh=MMDC5v30sfDKQwJvansX0qAZP2/wX5DCuhUAB+PCBFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfRsuE2iSe4GMuSkbwChDiQ/ou2KcqSom0bjKMvdyW1cMWS2GAyCWvIQTpBgu5XpBG/b3mKdiX81e/mqTbDEMnhXpB6gvtGhfnP3JozV4TbGq2SmUzclbUuB9JXrmfdfeutKZ8sLHxbNKPLPcJ+SZaNrOc45/ufKh+GS7S6/4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f8VpV63nWzYQtyY;
	Mon,  9 Feb 2026 11:40:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AFFCA4056D;
	Mon,  9 Feb 2026 11:41:47 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCHM_R6V4lpDvceGw--.17508S2;
	Mon, 09 Feb 2026 11:41:47 +0800 (CST)
Message-ID: <c2d8e4ec-e255-43a3-b864-d82cd1201487@huaweicloud.com>
Date: Mon, 9 Feb 2026 11:41:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 1/4] cgroup/cpuset: Clarify exclusion rules
 for cpuset internal variables
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
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-2-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260206203712.1989610-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHM_R6V4lpDvceGw--.17508S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw48Jw1xJr43Ary5uFyUKFg_yoWxZF4rpF
	4jg347AryUJr17uw17tF17Crn5Kws5GFW7C3WrK3WfuF9FyF1q9a4jy3ZIgFy8K3s3WFWD
	XFWDWwsruF1qk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.941];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13803-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A423010B7A6
X-Rspamd-Action: no action



On 2026/2/7 4:37, Waiman Long wrote:
> Clarify the locking rules associated with file level internal variables
> inside the cpuset code. There is no functional change.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 105 ++++++++++++++++++++++++-----------------
>  1 file changed, 61 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c43efef7df71..a4c6386a594d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -61,6 +61,58 @@ static const char * const perr_strings[] = {
>  	[PERR_REMOTE]    = "Have remote partition underneath",
>  };
>  
> +/*
> + * CPUSET Locking Convention
> + * -------------------------
> + *
> + * Below are the three global locks guarding cpuset structures in lock
> + * acquisition order:
> + *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
> + *  - cpuset_mutex
> + *  - callback_lock (raw spinlock)
> + *
> + * A task must hold all the three locks to modify externally visible or
> + * used fields of cpusets, though some of the internally used cpuset fields
> + * and internal variables can be modified without holding callback_lock. If only
> + * reliable read access of the externally used fields are needed, a task can
> + * hold either cpuset_mutex or callback_lock which are exposed to other
> + * external subsystems.
> + *
> + * If a task holds cpu_hotplug_lock and cpuset_mutex, it blocks others,
> + * ensuring that it is the only task able to also acquire callback_lock and
> + * be able to modify cpusets.  It can perform various checks on the cpuset
> + * structure first, knowing nothing will change. It can also allocate memory
> + * without holding callback_lock. While it is performing these checks, various
> + * callback routines can briefly acquire callback_lock to query cpusets.  Once
> + * it is ready to make the changes, it takes callback_lock, blocking everyone
> + * else.
> + *
> + * Calls to the kernel memory allocator cannot be made while holding
> + * callback_lock which is a spinlock, as the memory allocator may sleep or
> + * call back into cpuset code and acquire callback_lock.
> + *
> + * Now, the task_struct fields mems_allowed and mempolicy may be changed
> + * by other task, we use alloc_lock in the task_struct fields to protect
> + * them.
> + *
> + * The cpuset_common_seq_show() handlers only hold callback_lock across
> + * small pieces of code, such as when reading out possibly multi-word
> + * cpumasks and nodemasks.
> + */
> +
> +static DEFINE_MUTEX(cpuset_mutex);
> +
> +/*
> + * File level internal variables below follow one of the following exclusion
> + * rules.
> + *
> + * RWCS: Read/write-able by holding either cpus_write_lock or both
> + *       cpus_read_lock and cpuset_mutex.
> + *

Does this mean that variables can be read or written only by holding
cpus_write_lock?

I believe that to write cpuset variables, we must hold either (cpus_write_lock
and cpuset_mutex) or (cpus_read_lock and cpuset_mutex).

> + * CSCB: Readable by holding either cpuset_mutex or callback_lock. Writable
> + *	 by holding both cpuset_mutex and callback_lock.
> + */
> +
>  /*
>   * For local partitions, update to subpartitions_cpus & isolated_cpus is done
>   * in update_parent_effective_cpumask(). For remote partitions, it is done in
> @@ -70,19 +122,18 @@ static const char * const perr_strings[] = {
>   * Exclusive CPUs distributed out to local or remote sub-partitions of
>   * top_cpuset
>   */
> -static cpumask_var_t	subpartitions_cpus;
> +static cpumask_var_t	subpartitions_cpus;	/* RWCS */
>  
>  /*
> - * Exclusive CPUs in isolated partitions
> + * Exclusive CPUs in isolated partitions (shown in cpuset.cpus.isolated)
>   */
> -static cpumask_var_t	isolated_cpus;
> +static cpumask_var_t	isolated_cpus;		/* CSCB */
>  
>  /*
> - * isolated_cpus updating flag (protected by cpuset_mutex)
> - * Set if isolated_cpus is going to be updated in the current
> - * cpuset_mutex crtical section.
> + * Set if isolated_cpus is being updated in the current cpuset_mutex
> + * critical section.
>   */
> -static bool isolated_cpus_updating;
> +static bool		isolated_cpus_updating;	/* RWCS */
>  
>  /*
>   * A flag to force sched domain rebuild at the end of an operation.
> @@ -98,7 +149,7 @@ static bool isolated_cpus_updating;
>   * Note that update_relax_domain_level() in cpuset-v1.c can still call
>   * rebuild_sched_domains_locked() directly without using this flag.
>   */
> -static bool force_sd_rebuild;
> +static bool force_sd_rebuild;			/* RWCS */
>  
>  /*
>   * Partition root states:
> @@ -218,42 +269,6 @@ struct cpuset top_cpuset = {
>  	.partition_root_state = PRS_ROOT,
>  };
>  
> -/*
> - * There are two global locks guarding cpuset structures - cpuset_mutex and
> - * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
> - * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> - * structures. Note that cpuset_mutex needs to be a mutex as it is used in
> - * paths that rely on priority inheritance (e.g. scheduler - on RT) for
> - * correctness.
> - *
> - * A task must hold both locks to modify cpusets.  If a task holds
> - * cpuset_mutex, it blocks others, ensuring that it is the only task able to
> - * also acquire callback_lock and be able to modify cpusets.  It can perform
> - * various checks on the cpuset structure first, knowing nothing will change.
> - * It can also allocate memory while just holding cpuset_mutex.  While it is
> - * performing these checks, various callback routines can briefly acquire
> - * callback_lock to query cpusets.  Once it is ready to make the changes, it
> - * takes callback_lock, blocking everyone else.
> - *
> - * Calls to the kernel memory allocator can not be made while holding
> - * callback_lock, as that would risk double tripping on callback_lock
> - * from one of the callbacks into the cpuset code from within
> - * __alloc_pages().
> - *
> - * If a task is only holding callback_lock, then it has read-only
> - * access to cpusets.
> - *
> - * Now, the task_struct fields mems_allowed and mempolicy may be changed
> - * by other task, we use alloc_lock in the task_struct fields to protect
> - * them.
> - *
> - * The cpuset_common_seq_show() handlers only hold callback_lock across
> - * small pieces of code, such as when reading out possibly multi-word
> - * cpumasks and nodemasks.
> - */
> -
> -static DEFINE_MUTEX(cpuset_mutex);
> -
>  /**
>   * cpuset_lock - Acquire the global cpuset mutex
>   *
> @@ -1163,6 +1178,8 @@ static void reset_partition_data(struct cpuset *cs)
>  static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus)
>  {
>  	WARN_ON_ONCE(old_prs == new_prs);
> +	lockdep_assert_held(&callback_lock);
> +	lockdep_assert_held(&cpuset_mutex);
>  	if (new_prs == PRS_ISOLATED)
>  		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
>  	else

-- 
Best regards,
Ridong


