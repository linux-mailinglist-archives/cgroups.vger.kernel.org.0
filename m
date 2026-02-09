Return-Path: <cgroups+bounces-13805-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJj0GP+IiWl1+gQAu9opvQ
	(envelope-from <cgroups+bounces-13805-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 08:13:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8ED10C59A
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C7EC3008536
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014792FD696;
	Mon,  9 Feb 2026 07:13:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A71A724C;
	Mon,  9 Feb 2026 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621179; cv=none; b=kg3Znu+4neVTZ8VcTyRj6vXXZcPWMYaJNRDEuP9YXFm481xGwmd80m1CBEzUVRH8sxJJVAqIcbKEaQi9gx8pY2+KjrCRqZ2e+fbsUP33Y4j14Cw1VyGsMQNagIls4/CQmNX3inXRXF7XXo0QCFvB82LK0bmoMPpFxHhYPlJpu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621179; c=relaxed/simple;
	bh=UmDxPZvziijOBAwyhYSLGq0yZQfltUvT+WezVvvVUYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCfZt738mS1BgYzjzSTb+A8Q5DSUwCIABToUJNNOnpz8jSePLbK5Qq8DXDGsXjhXPdhivFWDXjH+Bvihyfv415/tCE0+tkKDIniHTWP0cpJ/1tLPg5rXxInQqaJ3e9vriv+DQSTTx05fzsKO3Pu0CCNWI8X9m+cqmMUG/YkMeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f8bV625g2zYQv27;
	Mon,  9 Feb 2026 15:11:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 61F6D4056D;
	Mon,  9 Feb 2026 15:12:55 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXA_T1iIlp8mAwGw--.56432S2;
	Mon, 09 Feb 2026 15:12:55 +0800 (CST)
Message-ID: <e9c4aae2-44ed-42f5-9b4b-b63d59915143@huaweicloud.com>
Date: Mon, 9 Feb 2026 15:12:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 3/4] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
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
 <20260206203712.1989610-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260206203712.1989610-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXA_T1iIlp8mAwGw--.56432S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ur1fXFW8JFWDCFykJw1UWrg_yoW8XryrJo
	WSq3yrCr1rtw1UCa98Zr1qkr1UW3ykKr4xAwsF9r4DWF1avFy7Ka43J3y2vryfWayYkF45
	JFySqrWv9rZrtF1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.942];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-13805-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF8ED10C59A
X-Rspamd-Action: no action



On 2026/2/7 4:37, Waiman Long wrote:
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
>  kernel/cgroup/cpuset.c        | 107 +++++++++++++++++++++++++++-------
>  kernel/sched/isolation.c      |   4 +-
>  kernel/time/timer_migration.c |   4 +-
>  3 files changed, 89 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index eb0eabd85e8c..d26c77a726b2 100644
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
> @@ -135,6 +152,13 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
>   */
>  static bool		isolated_cpus_updating;	/* RWCS */
>  
> +/*
> + * Copy of isolated_cpus to be processed by housekeeping_update()
> + */
> +static cpumask_var_t	isolated_hk_cpus;	/* T */
> +static bool		isolcpus_twork_queued;	/* T */
> +
> +
>  /*
>   * A flag to force sched domain rebuild at the end of an operation.
>   * It can be set in
> @@ -298,6 +322,7 @@ void lockdep_assert_cpuset_lock_held(void)
>   */
>  void cpuset_full_lock(void)
>  {
> +	mutex_lock(&cpuset_top_mutex);
>  	cpus_read_lock();
>  	mutex_lock(&cpuset_mutex);
>  }
> @@ -306,12 +331,14 @@ void cpuset_full_unlock(void)
>  {
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
> @@ -1302,30 +1329,53 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  	return false;
>  }
>  
> -static void isolcpus_workfn(struct work_struct *work)
> +/*
> + * housekeeping_update() will only be called if isolated_cpus differs
> + * from isolated_hk_cpus. To be safe, rebuild_sched_domains() will always
> + * be called just in case there are still pending sched domains changes.
> + */
> +static void do_housekeeping_update(bool *flag)
>  {
> -	cpuset_full_lock();
> -	if (isolated_cpus_updating) {
> -		isolated_cpus_updating = false;
> -		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
> -		rebuild_sched_domains_locked();
> +	bool update_hk = true;
> +
> +	guard(mutex)(&cpuset_top_mutex);
> +	if (flag)
> +		*flag = false;
> +	scoped_guard(spinlock_irq, &callback_lock) {
> +		if (cpumask_equal(isolated_hk_cpus, isolated_cpus))
> +			update_hk = false;
> +		else
> +			cpumask_copy(isolated_hk_cpus, isolated_cpus);
>  	}
> -	cpuset_full_unlock();
> +	if (update_hk)
> +		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus) < 0);
> +	rebuild_sched_domains();
> +}
> +
> +static void isolcpus_workfn(struct work_struct *work)
> +{
> +	do_housekeeping_update(NULL);
> +}
> +
> +static void isolcpus_tworkfn(struct callback_head *cb)
> +{
> +	/* Clear isolcpus_twork_queued */
> +	do_housekeeping_update(&isolcpus_twork_queued);
>  }
>  
>  /*
>   * update_isolation_cpumasks - Update external isolation related CPU masks
> - *
> - * The following external CPU masks will be updated if necessary:
> - * - workqueue unbound cpumask
>   */
>  static void update_isolation_cpumasks(void)
>  {
>  	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
> +	static struct callback_head twork_cb;
>  
>  	lockdep_assert_cpuset_lock_held();
>  	if (!isolated_cpus_updating)
>  		return;
> +	else
> +		isolated_cpus_updating = false;
>  
>  	/*
>  	 * This function can be reached either directly from regular cpuset
> @@ -1333,10 +1383,15 @@ static void update_isolation_cpumasks(void)
>  	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
>  	 * of the task that initiates CPU shutdown or bringup.
>  	 *
> -	 * To have better flexibility and prevent the possibility of deadlock
> -	 * when calling from CPU hotplug, we defer the housekeeping_update()
> -	 * call to after the current cpuset critical section has finished.
> -	 * This is done via workqueue.
> +	 * To have better flexibility and prevent the possibility of deadlock,
> +	 * we defer the housekeeping_update() call to after the current
> +	 * cpuset critical section has finished. This is done via task_work
> +	 * for cpuset control file write and workqueue for CPU hotplug.
> +	 *
> +	 * When calling from CPU hotplug, cpuset_top_mutex is not held. So the
> +	 * cpuset operation can run asynchronously with do_housekeeping_update().
> +	 * This should not be a problem as another isolcpus_workfn() call will
> +	 * be scheduled to make sure that housekeeping cpumasks will be updated.
>  	 */
>  	if (current->flags & PF_KTHREAD) {
>  		/*
> @@ -1352,8 +1407,19 @@ static void update_isolation_cpumasks(void)
>  		return;
>  	}
>  
> -	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
> -	isolated_cpus_updating = false;
> +	/*
> +	 * update_isolation_cpumasks() may be called more than once in the
> +	 * same cpuset_mutex critical section.
> +	 */
> +	lockdep_assert_held(&cpuset_top_mutex);
> +	if (isolcpus_twork_queued)
> +		return;
> +
> +	init_task_work(&twork_cb, isolcpus_tworkfn);
> +	if (!task_work_add(current, &twork_cb, TWA_RESUME))
> +		isolcpus_twork_queued = true;
> +	else
> +		WARN_ON_ONCE(1);	/* Current task shouldn't be exiting */
>  }
>  

Timeline:

user A			user B
write isolated cpus	write isolated cpus
isolated_cpus_update
update_isolation_cpumasks
task_work_add
isolcpus_twork_queued =true

// before returning userspace
// waiting for worker
			isolated_cpus_update
			if (isolcpus_twork_queued)
				return // Early exit
			// return to userspace

// workqueue finishes
// return to userspace

For User B, the isolated_cpus value appears to be set and the syscall returns
successfully to userspace. However, because isolcpus_twork_queued was already
true (set by User A), User B's call skipped the actual mask update
(update_isolation_cpumasks).
Thus, the new isolated_cpus value is not yet effective in the kernel, even
though User B's write operation returned without error.

Is this a valid issue? Should User B's write be blocked?

>  /**
> @@ -3661,6 +3727,7 @@ int __init cpuset_init(void)
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


