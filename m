Return-Path: <cgroups+bounces-13649-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN6lDJmygmn/YAMAu9opvQ
	(envelope-from <cgroups+bounces-13649-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 03:44:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC53E0F6F
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 03:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD1130B206B
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 02:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B32D739C;
	Wed,  4 Feb 2026 02:44:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FE2D6E73;
	Wed,  4 Feb 2026 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173057; cv=none; b=KghozoZ6+axVOhwCJ5PAnE5xj6VE7NL4QBcViW1jJGDpBU6C9BTdw3xfByhbAISfe+jdXPU8/6WNSFAp2audO1EwjU72IVMkppc2c1ruJTK14U0g+5Lr+Fz7HQxDMam42ya5MbX9YWclkFo15hEZ2ZqyN9q+49hijBvIBSo+QE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173057; c=relaxed/simple;
	bh=RuPp03/nA9K6B59FYx4GL8YBbVYuNfUZ4cVnIck+Tn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFMrURPRitVK7JQv55pq6YPmCO3DiAx45W6JDDVVw8cDaHvOG1/+bcYZzpRYG+vFWF7310dIdLCpbB1jTIh3lETqKw14KSQ44rNoK0O8TpPSbnp85D8yOX8idEusVsDF8q/8UydVpNQUzLudvnfYaTsu/qww0eChDnUNdDyL/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f5PmW0jyDzYQtwQ;
	Wed,  4 Feb 2026 10:43:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 715D140539;
	Wed,  4 Feb 2026 10:44:11 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgD3V_h5soJpK2HAGA--.17022S2;
	Wed, 04 Feb 2026 10:44:11 +0800 (CST)
Message-ID: <da771006-c1ca-435a-bdec-793e866a2b49@huaweicloud.com>
Date: Wed, 4 Feb 2026 10:44:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v3 3/3] cgroup/cpuset: Call housekeeping_update()
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
References: <20260202201144.1669260-1-longman@redhat.com>
 <20260202201144.1669260-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260202201144.1669260-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3V_h5soJpK2HAGA--.17022S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1xGrWrCF1DXr48ur4fGrg_yoWfGr1DpF
	ZIgrWxJryDtr1093y7tw17Xr1rKw4DGF47GFn3Gw1rAFy3ZFs2vF1jgFnxuFy5Wr97Cr4a
	vFZ8W398W3WDArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.978];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-13649-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 8CC53E0F6F
X-Rspamd-Action: no action



On 2026/2/3 4:11, Waiman Long wrote:
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
> The lockdep_is_cpuset_held() is also updated to check the new
> cpuset_top_mutex.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c        | 103 +++++++++++++++++++++++++++-------
>  kernel/sched/isolation.c      |   4 +-
>  kernel/time/timer_migration.c |   3 +-
>  3 files changed, 86 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e98a2e953392..d2f51f40f87e 100644
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
> @@ -306,12 +331,13 @@ void cpuset_full_unlock(void)
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
> +	return lockdep_is_held(&cpuset_top_mutex);
>  }
>  #endif
>  

void cpuset_lock(void)
{
	mutex_lock(&cpuset_mutex);
}

void cpuset_unlock(void)
{
	mutex_unlock(&cpuset_mutex);
}

void lockdep_assert_cpuset_lock_held(void)
{
	lockdep_assert_held(&cpuset_mutex);
}

A potential issue is that lockdep_is_cpuset_held() only checks cpuset_top_mutex.
In the call chain below, only cpuset_mutex is acquired:

rebuild_sched_domains_cpuslocked ---only cpuset_mutex is acquired
rebuild_sched_domains_locked
partition_sched_domains
dl_rebuild_rd_accounting
dl_rebuild_rd_accounting
dl_update_tasks_root_domain
dl_add_task_root_domain
dl_get_task_effective_cpus
housekeeping_cpumask
housekeeping_dereference_check
if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())

Since lockdep_is_cpuset_held() validates cpuset_top_mutex rather than
cpuset_mutex, could this lead to false lockdep warnings?

-- 
Best regards,
Ridong


