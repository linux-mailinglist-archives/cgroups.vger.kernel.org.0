Return-Path: <cgroups+bounces-13940-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIj9HhDXjmmhFQEAu9opvQ
	(envelope-from <cgroups+bounces-13940-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:47:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DF133B1E
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87C48301DC8E
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE1D3128CC;
	Fri, 13 Feb 2026 07:47:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2305214813;
	Fri, 13 Feb 2026 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968846; cv=none; b=gyc2vHx+UJ+nQXGZH5RS3XY+oxr2QLPgp4QcLDCeoTPW8cHJtQlzx18m4npS3OYPq9YkN5g4jFd9uAbm0NV9lgkTiq+8wd0W+DsHZZGGByBKhImlDTPgRl4RnkyQTUp+0uW6XETAp7ByypX2Gwr8/dHQq6nH2xc6x68XTJeEBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968846; c=relaxed/simple;
	bh=wMS2E7l64XzN0LEw5lKXDC8iOm4gPIbB7ds69FWHIWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GImhqpdVvvvXp8OpcRfAJ/Qnr5DqS36L6nLglnmemlogMBHkkIYWbXP0S8MUK6eq4MidgysJwJwrqZwQTxHgsuTq4MRykhwdzqzwS+RPwOY6JRns79CPT+dc/kWEcuJ5yMI42B0jVsmQZw4ouENELceXdZbwcgOBDQ8l1z9Sm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fC4510FQZzYQty1;
	Fri, 13 Feb 2026 15:47:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E4E94056D;
	Fri, 13 Feb 2026 15:47:20 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAHs_MG145pgAwVHQ--.64735S2;
	Fri, 13 Feb 2026 15:47:19 +0800 (CST)
Message-ID: <a98d730d-7a18-4e37-8aab-0376e813e649@huaweicloud.com>
Date: Fri, 13 Feb 2026 15:47:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] cgroup/cpuset: Call housekeeping_update() without
 holding cpus_read_lock
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
 <20260212164640.2408295-6-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260212164640.2408295-6-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHs_MG145pgAwVHQ--.64735S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ur1fXFW8JFWDZFW3Ary8Grg_yoW8GrWUCo
	WSq3yrCr1rJw1UCa98Zr1vkr1UWws5Kr4xAw4q9r4DWF1avFy7Ka43J3y2vry3WFWYkF48
	Ja4SqrWv9rZrtF1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13940-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 219DF133B1E
X-Rspamd-Action: no action


Hi Longman:

On 2026/2/13 0:46, Waiman Long wrote:
> The current cpuset partition code is able to dynamically update
> the sched domains of a running system and the corresponding
> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
> "isolcpus=domain,..." boot command line feature at run time.
> 
> The housekeeping cpumask update requires flushing a number of different
> workqueues which may not be safe with cpus_read_lock() held as the
> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
> which have locking dependency with cpus_read_lock() down the chain. Below
> is an example of such circular locking problem.
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   6.18.0-test+ #2 Tainted: G S
>   ------------------------------------------------------
>   test_cpuset_prs/10971 is trying to acquire lock:
>   ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180
> 
>   but task is already holding lock:
>   ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
>   -> #4 (cpuset_mutex){+.+.}-{4:4}:
>   -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>   -> #2 (rtnl_mutex){+.+.}-{4:4}:
>   -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>   -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
> 
>   Chain exists of:
>     (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
> 
>   5 locks held by test_cpuset_prs/10971:
>    #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
>    #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x260/0x5f0
>    #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b6/0x5f0
>    #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x77/0x130
>    #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
> 
>   Call Trace:
>    <TASK>
>      :
>    touch_wq_lockdep_map+0x93/0x180
>    __flush_workqueue+0x111/0x10b0
>    housekeeping_update+0x12d/0x2d0
>    update_parent_effective_cpumask+0x595/0x2440
>    update_prstate+0x89d/0xce0
>    cpuset_partition_write+0xc5/0x130
>    cgroup_file_write+0x1a5/0x680
>    kernfs_fop_write_iter+0x3df/0x5f0
>    vfs_write+0x525/0xfd0
>    ksys_write+0xf9/0x1d0
>    do_syscall_64+0x95/0x520
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> To avoid such a circular locking dependency problem, we have to
> call housekeeping_update() without holding the cpus_read_lock() and
> cpuset_mutex. The current set of wq's flushed by housekeeping_update()
> may not have work functions that call cpus_read_lock() directly,
> but we are likely to extend the list of wq's that are flushed in the
> future. Moreover, the current set of work functions may hold locks that
> may have cpu_hotplug_lock down the dependency chain.
> 
> One way to do that is to defer the housekeeping_update() call after
> the current cpuset critical section has finished without holding
> cpus_read_lock. For cpuset control file write, this can be done by
> deferring it using task_work right before returning to userspace.
> 
> To enable mutual exclusion between the housekeeping_update() call and
> other cpuset control file write actions, a new top level cpuset_top_mutex
> is introduced. This new mutex will be acquired first to allow sharing
> variables used by both code paths. However, cpuset update from CPU
> hotplug can still happen in parallel with the housekeeping_update()
> call, though that should be rare in production environment.
> 
> As cpus_read_lock() is now no longer held when
> tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
> directly.
> 
> The lockdep_is_cpuset_held() is also updated to return true if either
> cpuset_top_mutex or cpuset_mutex is held.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c        | 99 ++++++++++++++++++++++++++++++++---
>  kernel/sched/isolation.c      |  4 +-
>  kernel/time/timer_migration.c |  4 +-
>  3 files changed, 93 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 48b7f275085b..c6a97956a991 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -65,14 +65,28 @@ static const char * const perr_strings[] = {
>   * CPUSET Locking Convention
>   * -------------------------
>   *
> - * Below are the three global locks guarding cpuset structures in lock
> + * Below are the four global/local locks guarding cpuset structures in lock
>   * acquisition order:
> + *  - cpuset_top_mutex
>   *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
>   *  - cpuset_mutex
>   *  - callback_lock (raw spinlock)
>   *
> - * A task must hold all the three locks to modify externally visible or
> - * used fields of cpusets, though some of the internally used cpuset fields
> + * As cpuset will now indirectly flush a number of different workqueues in
> + * housekeeping_update() to update housekeeping cpumasks when the set of
> + * isolated CPUs is going to be changed, it may be vulnerable to deadlock
> + * if we hold cpus_read_lock while calling into housekeeping_update().
> + *
> + * The first cpuset_top_mutex will be held except when calling into
> + * cpuset_handle_hotplug() from the CPU hotplug code where cpus_write_lock
> + * and cpuset_mutex will be held instead. The main purpose of this mutex
> + * is to prevent regular cpuset control file write actions from interfering
> + * with the call to housekeeping_update(), though CPU hotplug operation can
> + * still happen in parallel. This mutex also provides protection for some
> + * internal variables.
> + *
> + * A task must hold all the remaining three locks to modify externally visible
> + * or used fields of cpusets, though some of the internally used cpuset fields
>   * and internal variables can be modified without holding callback_lock. If only
>   * reliable read access of the externally used fields are needed, a task can
>   * hold either cpuset_mutex or callback_lock which are exposed to other
> @@ -100,6 +114,7 @@ static const char * const perr_strings[] = {
>   * cpumasks and nodemasks.
>   */
>  
> +static DEFINE_MUTEX(cpuset_top_mutex);
>  static DEFINE_MUTEX(cpuset_mutex);
>  
>  /*
> @@ -111,6 +126,8 @@ static DEFINE_MUTEX(cpuset_mutex);
>   *
>   * CSCB: Readable by holding either cpuset_mutex or callback_lock. Writable
>   *	 by holding both cpuset_mutex and callback_lock.
> + *
> + * T:	 Read/write-able by holding the cpuset_top_mutex.
>   */
>  
>  /*
> @@ -135,6 +152,18 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
>   */
>  static bool		isolated_cpus_updating;	/* RWCS */
>  
> +/*
> + * Copy of isolated_cpus to be passed to housekeeping_update()
> + */
> +static cpumask_var_t	isolated_hk_cpus;	/* T */
> +
> +/*
> + * Flag to prevent queuing more than one task_work to the same cpuset_top_mutex
> + * critical section.
> + */
> +static bool		isolcpus_twork_queued;	/* T */
> +
> +
>  /*
>   * A flag to force sched domain rebuild at the end of an operation.
>   * It can be set in
> @@ -301,20 +330,24 @@ void lockdep_assert_cpuset_lock_held(void)
>   */
>  void cpuset_full_lock(void)
>  {
> +	mutex_lock(&cpuset_top_mutex);
>  	cpus_read_lock();
>  	mutex_lock(&cpuset_mutex);
>  }
>  
>  void cpuset_full_unlock(void)
>  {
> +	isolcpus_twork_queued = false;

This is odd.

>  	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
> +	mutex_unlock(&cpuset_top_mutex);
>  }
>  
>  #ifdef CONFIG_LOCKDEP
>  bool lockdep_is_cpuset_held(void)
>  {
> -	return lockdep_is_held(&cpuset_mutex);
> +	return lockdep_is_held(&cpuset_mutex) ||
> +	       lockdep_is_held(&cpuset_top_mutex);
>  }
>  #endif
>  
> @@ -1338,6 +1371,28 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  	return false;
>  }
>  
> +/*
> + * housekeeping_update() will only be called if isolated_cpus differs
> + * from isolated_hk_cpus. To be safe, rebuild_sched_domains() will always
> + * be called just in case there are still pending sched domains changes.
> + */
> +static void isolcpus_tworkfn(struct callback_head *cb)
> +{
> +	bool update_hk = true;
> +
> +	guard(mutex)(&cpuset_top_mutex);
> +	scoped_guard(spinlock_irq, &callback_lock) {
> +		if (cpumask_equal(isolated_hk_cpus, isolated_cpus))
> +			update_hk = false;
> +		else
> +			cpumask_copy(isolated_hk_cpus, isolated_cpus);
> +	}
> +	if (update_hk)
> +		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus) < 0);
> +	rebuild_sched_domains();
> +	kfree(cb);
> +}
> +
>  /*
>   * update_isolation_cpumasks - Update external isolation related CPU masks
>   *
> @@ -1346,15 +1401,42 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   */
>  static void update_isolation_cpumasks(void)
>  {
> -	int ret;
> +	struct callback_head *twork_cb;
>  
>  	if (!isolated_cpus_updating)
>  		return;
> +	else
> +		isolated_cpus_updating = false;
> +
> +	/*
> +	 * CPU hotplug shouldn't set isolated_cpus_updating.
> +	 *
> +	 * To have better flexibility and prevent the possibility of deadlock,
> +	 * we defer the housekeeping_update() call to after the current cpuset
> +	 * critical section has finished. This is done via the synchronous
> +	 * task_work which will be executed right before returning to userspace.
> +	 *
> +	 * update_isolation_cpumasks() may be called more than once in the
> +	 * same cpuset_mutex critical section.
> +	 */
> +	lockdep_assert_held(&cpuset_top_mutex);
> +	if (isolcpus_twork_queued)
> +		return;
>  
> -	ret = housekeeping_update(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
> +	twork_cb = kzalloc(sizeof(struct callback_head), GFP_KERNEL);
> +	if (!twork_cb)
> +		return;
>  
> -	isolated_cpus_updating = false;
> +	/*
> +	 * isolcpus_tworkfn() will be invoked before returning to userspace
> +	 */
> +	init_task_work(twork_cb, isolcpus_tworkfn);
> +	if (task_work_add(current, twork_cb, TWA_RESUME)) {
> +		kfree(twork_cb);
> +		WARN_ON_ONCE(1);	/* Current task shouldn't be exiting */
> +	} else {
> +		isolcpus_twork_queued = true;
> +	}
>  }
>  

Actually, I find this function quite complex, with numerous global
variables to maintain.

I'm considering whether we can simplify it. Could we just call
update_isolation_cpumasks() at the end of update_prstate(),
update_cpumask(), and update_exclusive_cpumask()?

i.e.

static void update_isolation_cpumasks(void)
{
	struct callback_head twork_cb

	if (!isolated_cpus_updating)
		return;
	task_work_add(...)
	isolated_cpus_updating = false;
}

static int update_prstate(struct cpuset *cs, int new_prs)
{
	...
	free_tmpmasks(&tmpmask);
	update_isolation_cpumasks();
	return 0;
}

For rebuilding scheduling domains, we could rebuild them during the
set operation only when force_sd_rebuild = true and
!isolated_cpus_updating. Otherwise, the rebuild would be deferred
and performed only once in isolcpus_tworkfn().

>  /**
> @@ -3689,6 +3771,7 @@ int __init cpuset_init(void)
>  	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
>  	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
>  	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
> +	BUG_ON(!zalloc_cpumask_var(&isolated_hk_cpus, GFP_KERNEL));
>  
>  	cpumask_setall(top_cpuset.cpus_allowed);
>  	nodes_setall(top_cpuset.mems_allowed);
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 3b725d39c06e..ef152d401fe2 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -123,8 +123,6 @@ int housekeeping_update(struct cpumask *isol_mask)
>  	struct cpumask *trial, *old = NULL;
>  	int err;
>  
> -	lockdep_assert_cpus_held();
> -
>  	trial = kmalloc(cpumask_size(), GFP_KERNEL);
>  	if (!trial)
>  		return -ENOMEM;
> @@ -136,7 +134,7 @@ int housekeeping_update(struct cpumask *isol_mask)
>  	}
>  
>  	if (!housekeeping.flags)
> -		static_branch_enable_cpuslocked(&housekeeping_overridden);
> +		static_branch_enable(&housekeeping_overridden);
>  
>  	if (housekeeping.flags & HK_FLAG_DOMAIN)
>  		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 6da9cd562b20..83428aa03aef 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1559,8 +1559,6 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
>  	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
>  	int cpu;
>  
> -	lockdep_assert_cpus_held();
> -
>  	if (!works)
>  		return -ENOMEM;
>  	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> @@ -1570,6 +1568,7 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
>  	 * First set previously isolated CPUs as available (unisolate).
>  	 * This cpumask contains only CPUs that switched to available now.
>  	 */
> +	guard(cpus_read_lock)();
>  	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
>  	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
>  
> @@ -1626,7 +1625,6 @@ static int __init tmigr_init_isolation(void)
>  	cpumask_andnot(cpumask, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
>  
>  	/* Protect against RCU torture hotplug testing */
> -	guard(cpus_read_lock)();
>  	return tmigr_isolated_exclude_cpumask(cpumask);
>  }
>  late_initcall(tmigr_init_isolation);

-- 
Best regards,
Ridong


