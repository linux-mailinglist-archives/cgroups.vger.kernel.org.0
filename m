Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687746D6D8F
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 22:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjDDUF4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 16:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDDUFz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 16:05:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF3170A
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 13:05:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1351314wmo.0
        for <cgroups@vger.kernel.org>; Tue, 04 Apr 2023 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680638750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMEAdxbTJTfMOQrg27VeSxZWCaKWhnVnr29O+ebVj/E=;
        b=51R9Ao++ZjrwHKsnhW1UMKCFkHPp6ox+tfu9e/5ZfkvnMcVGF/jL9+rewXBabUxoPs
         seoVJD+9hakSxMl2RsheqLXnqLMeL2+S7tC864aDpdmklYAlOJPxFSQsbo1bM3VSIRey
         e7vR97XTJNFZftlLAuE34cSmSZaMFPLqW10dZ4lYSiBQcsjJSockhFViSIiKUeRAhn2O
         xYRCOjnLK5SESBpHDMuE87kQlJSjevxwdpl+XpYX7OcIDYpL531zq+yOGv48HCKtXKxw
         1HaN+ThtRAs5mMbBCFzydFQNajaV2MmG8gZgC/rwhywkmu1Xg1QBiIOdOEOSHbXNNeXe
         oNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMEAdxbTJTfMOQrg27VeSxZWCaKWhnVnr29O+ebVj/E=;
        b=1hotjv1EIifeNJgwj3RoibSxQO6kWhQRU0FuEQWOKpkLndbofUNqzXev0iHplOn/w8
         PrCRlFRhhZ/hWHx2jslQZEA2FhoTSnagHqj+u+mGCsJdD8pnVND+RiIyE4I4HgE3NqQb
         6t8Xjm+FmD+bRGWxf6ek0VtGnt7sRdwdLGfQu/Ccw41N/YKHuM8a/ZLCp/1knDFUqcx/
         b8mYnRX/v67veOitzB3yzTZVryv3u3nIOhKwsjiTzb/G+hHU0g01DY9cujDY2aXdqLnp
         pXgDaPM66SPrxlVNrQcWPHclJsVrFdjuYrz0o9rjejWfFL7D4XqfzdWrE7AefpIM44RX
         t07g==
X-Gm-Message-State: AAQBX9cdDAsuZnP41mGFzJeYLoDNdUgUQk4eaa6gCCuYUWStK/FFewy5
        ybwp3AD01L47AvyWPLpxiTv4Rw==
X-Google-Smtp-Source: AKy350a0+nk984If2scICP7HdMMsPvpZOwoX81ISGwFJvMN3cqiC//lcIEEFQhZDniXyujZK9TM5rg==
X-Received: by 2002:a05:600c:22c2:b0:3eb:3104:efec with SMTP id 2-20020a05600c22c200b003eb3104efecmr2962929wmg.16.1680638749949;
        Tue, 04 Apr 2023 13:05:49 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id z13-20020a1c4c0d000000b003e20cf0408esm16183106wmf.40.2023.04.04.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:05:49 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:05:48 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <20230404200548.c5vud25w53cyyhme@airbuntu>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329125558.255239-3-juri.lelli@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/29/23 14:55, Juri Lelli wrote:
> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
> as it has been reported to cause slowdowns in workloads that need to
> change cpuset configuration frequently and it is also not implementing
> priority inheritance (which causes troubles with realtime workloads).
> 
> Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
> only for SCHED_DEADLINE tasks (other policies don't care about stable
> cpusets anyway).
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Qais Yousef <qyousef@layalina.io>


Thanks!

--
Qais Yousef

>  include/linux/cpuset.h |   8 +--
>  kernel/cgroup/cpuset.c | 145 ++++++++++++++++++++---------------------
>  kernel/sched/core.c    |  22 +++++--
>  3 files changed, 91 insertions(+), 84 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..355f796c5f07 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -71,8 +71,8 @@ extern void cpuset_init_smp(void);
>  extern void cpuset_force_rebuild(void);
>  extern void cpuset_update_active_cpus(void);
>  extern void cpuset_wait_for_hotplug(void);
> -extern void cpuset_read_lock(void);
> -extern void cpuset_read_unlock(void);
> +extern void cpuset_lock(void);
> +extern void cpuset_unlock(void);
>  extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>  extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>  extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
> @@ -196,8 +196,8 @@ static inline void cpuset_update_active_cpus(void)
>  
>  static inline void cpuset_wait_for_hotplug(void) { }
>  
> -static inline void cpuset_read_lock(void) { }
> -static inline void cpuset_read_unlock(void) { }
> +static inline void cpuset_lock(void) { }
> +static inline void cpuset_unlock(void) { }
>  
>  static inline void cpuset_cpus_allowed(struct task_struct *p,
>  				       struct cpumask *mask)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 501913bc2805..fbc10b494292 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -366,22 +366,21 @@ static struct cpuset top_cpuset = {
>  		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
>  
>  /*
> - * There are two global locks guarding cpuset structures - cpuset_rwsem and
> + * There are two global locks guarding cpuset structures - cpuset_mutex and
>   * callback_lock. We also require taking task_lock() when dereferencing a
>   * task's cpuset pointer. See "The task_lock() exception", at the end of this
> - * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
> - * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
> - * prevent change to cpuset structures.
> + * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
> + * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> + * structures.
>   *
>   * A task must hold both locks to modify cpusets.  If a task holds
> - * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
> - * is the only task able to also acquire callback_lock and be able to
> - * modify cpusets.  It can perform various checks on the cpuset structure
> - * first, knowing nothing will change.  It can also allocate memory while
> - * just holding cpuset_rwsem.  While it is performing these checks, various
> - * callback routines can briefly acquire callback_lock to query cpusets.
> - * Once it is ready to make the changes, it takes callback_lock, blocking
> - * everyone else.
> + * cpuset_mutex, it blocks others, ensuring that it is the only task able to
> + * also acquire callback_lock and be able to modify cpusets.  It can perform
> + * various checks on the cpuset structure first, knowing nothing will change.
> + * It can also allocate memory while just holding cpuset_mutex.  While it is
> + * performing these checks, various callback routines can briefly acquire
> + * callback_lock to query cpusets.  Once it is ready to make the changes, it
> + * takes callback_lock, blocking everyone else.
>   *
>   * Calls to the kernel memory allocator can not be made while holding
>   * callback_lock, as that would risk double tripping on callback_lock
> @@ -403,16 +402,16 @@ static struct cpuset top_cpuset = {
>   * guidelines for accessing subsystem state in kernel/cgroup.c
>   */
>  
> -DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
> +static DEFINE_MUTEX(cpuset_mutex);
>  
> -void cpuset_read_lock(void)
> +void cpuset_lock(void)
>  {
> -	percpu_down_read(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  }
>  
> -void cpuset_read_unlock(void)
> +void cpuset_unlock(void)
>  {
> -	percpu_up_read(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  }
>  
>  static DEFINE_SPINLOCK(callback_lock);
> @@ -496,7 +495,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
>   * One way or another, we guarantee to return some non-empty subset
>   * of cpu_online_mask.
>   *
> - * Call with callback_lock or cpuset_rwsem held.
> + * Call with callback_lock or cpuset_mutex held.
>   */
>  static void guarantee_online_cpus(struct task_struct *tsk,
>  				  struct cpumask *pmask)
> @@ -538,7 +537,7 @@ static void guarantee_online_cpus(struct task_struct *tsk,
>   * One way or another, we guarantee to return some non-empty subset
>   * of node_states[N_MEMORY].
>   *
> - * Call with callback_lock or cpuset_rwsem held.
> + * Call with callback_lock or cpuset_mutex held.
>   */
>  static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>  {
> @@ -550,7 +549,7 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>  /*
>   * update task's spread flag if cpuset's page/slab spread flag is set
>   *
> - * Call with callback_lock or cpuset_rwsem held. The check can be skipped
> + * Call with callback_lock or cpuset_mutex held. The check can be skipped
>   * if on default hierarchy.
>   */
>  static void cpuset_update_task_spread_flags(struct cpuset *cs,
> @@ -575,7 +574,7 @@ static void cpuset_update_task_spread_flags(struct cpuset *cs,
>   *
>   * One cpuset is a subset of another if all its allowed CPUs and
>   * Memory Nodes are a subset of the other, and its exclusive flags
> - * are only set if the other's are set.  Call holding cpuset_rwsem.
> + * are only set if the other's are set.  Call holding cpuset_mutex.
>   */
>  
>  static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
> @@ -713,7 +712,7 @@ static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
>   * If we replaced the flag and mask values of the current cpuset
>   * (cur) with those values in the trial cpuset (trial), would
>   * our various subset and exclusive rules still be valid?  Presumes
> - * cpuset_rwsem held.
> + * cpuset_mutex held.
>   *
>   * 'cur' is the address of an actual, in-use cpuset.  Operations
>   * such as list traversal that depend on the actual address of the
> @@ -829,7 +828,7 @@ static void update_domain_attr_tree(struct sched_domain_attr *dattr,
>  	rcu_read_unlock();
>  }
>  
> -/* Must be called with cpuset_rwsem held.  */
> +/* Must be called with cpuset_mutex held.  */
>  static inline int nr_cpusets(void)
>  {
>  	/* jump label reference count + the top-level cpuset */
> @@ -855,7 +854,7 @@ static inline int nr_cpusets(void)
>   * domains when operating in the severe memory shortage situations
>   * that could cause allocation failures below.
>   *
> - * Must be called with cpuset_rwsem held.
> + * Must be called with cpuset_mutex held.
>   *
>   * The three key local variables below are:
>   *    cp - cpuset pointer, used (together with pos_css) to perform a
> @@ -1084,7 +1083,7 @@ static void dl_rebuild_rd_accounting(void)
>  	struct cpuset *cs = NULL;
>  	struct cgroup_subsys_state *pos_css;
>  
> -	percpu_rwsem_assert_held(&cpuset_rwsem);
> +	lockdep_assert_held(&cpuset_mutex);
>  	lockdep_assert_cpus_held();
>  	lockdep_assert_held(&sched_domains_mutex);
>  
> @@ -1134,7 +1133,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   * 'cpus' is removed, then call this routine to rebuild the
>   * scheduler's dynamic sched domains.
>   *
> - * Call with cpuset_rwsem held.  Takes cpus_read_lock().
> + * Call with cpuset_mutex held.  Takes cpus_read_lock().
>   */
>  static void rebuild_sched_domains_locked(void)
>  {
> @@ -1145,7 +1144,7 @@ static void rebuild_sched_domains_locked(void)
>  	int ndoms;
>  
>  	lockdep_assert_cpus_held();
> -	percpu_rwsem_assert_held(&cpuset_rwsem);
> +	lockdep_assert_held(&cpuset_mutex);
>  
>  	/*
>  	 * If we have raced with CPU hotplug, return early to avoid
> @@ -1196,9 +1195,9 @@ static void rebuild_sched_domains_locked(void)
>  void rebuild_sched_domains(void)
>  {
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	rebuild_sched_domains_locked();
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  }
>  
> @@ -1208,7 +1207,7 @@ void rebuild_sched_domains(void)
>   * @new_cpus: the temp variable for the new effective_cpus mask
>   *
>   * Iterate through each task of @cs updating its cpus_allowed to the
> - * effective cpuset's.  As this function is called with cpuset_rwsem held,
> + * effective cpuset's.  As this function is called with cpuset_mutex held,
>   * cpuset membership stays stable.
>   */
>  static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
> @@ -1317,7 +1316,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
>  	int old_prs, new_prs;
>  	int part_error = PERR_NONE;	/* Partition error? */
>  
> -	percpu_rwsem_assert_held(&cpuset_rwsem);
> +	lockdep_assert_held(&cpuset_mutex);
>  
>  	/*
>  	 * The parent must be a partition root.
> @@ -1540,7 +1539,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
>   *
>   * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
>   *
> - * Called with cpuset_rwsem held
> + * Called with cpuset_mutex held
>   */
>  static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>  				 bool force)
> @@ -1700,7 +1699,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>  	struct cpuset *sibling;
>  	struct cgroup_subsys_state *pos_css;
>  
> -	percpu_rwsem_assert_held(&cpuset_rwsem);
> +	lockdep_assert_held(&cpuset_mutex);
>  
>  	/*
>  	 * Check all its siblings and call update_cpumasks_hier()
> @@ -1942,12 +1941,12 @@ static void *cpuset_being_rebound;
>   * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
>   *
>   * Iterate through each task of @cs updating its mems_allowed to the
> - * effective cpuset's.  As this function is called with cpuset_rwsem held,
> + * effective cpuset's.  As this function is called with cpuset_mutex held,
>   * cpuset membership stays stable.
>   */
>  static void update_tasks_nodemask(struct cpuset *cs)
>  {
> -	static nodemask_t newmems;	/* protected by cpuset_rwsem */
> +	static nodemask_t newmems;	/* protected by cpuset_mutex */
>  	struct css_task_iter it;
>  	struct task_struct *task;
>  
> @@ -1960,7 +1959,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
>  	 * take while holding tasklist_lock.  Forks can happen - the
>  	 * mpol_dup() cpuset_being_rebound check will catch such forks,
>  	 * and rebind their vma mempolicies too.  Because we still hold
> -	 * the global cpuset_rwsem, we know that no other rebind effort
> +	 * the global cpuset_mutex, we know that no other rebind effort
>  	 * will be contending for the global variable cpuset_being_rebound.
>  	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
>  	 * is idempotent.  Also migrate pages in each mm to new nodes.
> @@ -2006,7 +2005,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
>   *
>   * On legacy hierarchy, effective_mems will be the same with mems_allowed.
>   *
> - * Called with cpuset_rwsem held
> + * Called with cpuset_mutex held
>   */
>  static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>  {
> @@ -2059,7 +2058,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>   * mempolicies and if the cpuset is marked 'memory_migrate',
>   * migrate the tasks pages to the new memory.
>   *
> - * Call with cpuset_rwsem held. May take callback_lock during call.
> + * Call with cpuset_mutex held. May take callback_lock during call.
>   * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
>   * lock each such tasks mm->mmap_lock, scan its vma's and rebind
>   * their mempolicies to the cpusets new mems_allowed.
> @@ -2151,7 +2150,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
>   * @cs: the cpuset in which each task's spread flags needs to be changed
>   *
>   * Iterate through each task of @cs updating its spread flags.  As this
> - * function is called with cpuset_rwsem held, cpuset membership stays
> + * function is called with cpuset_mutex held, cpuset membership stays
>   * stable.
>   */
>  static void update_tasks_flags(struct cpuset *cs)
> @@ -2171,7 +2170,7 @@ static void update_tasks_flags(struct cpuset *cs)
>   * cs:		the cpuset to update
>   * turning_on: 	whether the flag is being set or cleared
>   *
> - * Call with cpuset_rwsem held.
> + * Call with cpuset_mutex held.
>   */
>  
>  static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
> @@ -2221,7 +2220,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>   * @new_prs: new partition root state
>   * Return: 0 if successful, != 0 if error
>   *
> - * Call with cpuset_rwsem held.
> + * Call with cpuset_mutex held.
>   */
>  static int update_prstate(struct cpuset *cs, int new_prs)
>  {
> @@ -2445,7 +2444,7 @@ static int fmeter_getrate(struct fmeter *fmp)
>  
>  static struct cpuset *cpuset_attach_old_cs;
>  
> -/* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
> +/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>  static int cpuset_can_attach(struct cgroup_taskset *tset)
>  {
>  	struct cgroup_subsys_state *css;
> @@ -2457,7 +2456,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>  	cs = css_cs(css);
>  
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  
>  	/* allow moving tasks into an empty cpuset if on default hierarchy */
>  	ret = -ENOSPC;
> @@ -2487,7 +2486,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	cs->attach_in_progress++;
>  	ret = 0;
>  out_unlock:
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }
>  
> @@ -2497,13 +2496,13 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>  
>  	cgroup_taskset_first(tset, &css);
>  
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	css_cs(css)->attach_in_progress--;
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  }
>  
>  /*
> - * Protected by cpuset_rwsem.  cpus_attach is used only by cpuset_attach()
> + * Protected by cpuset_mutex.  cpus_attach is used only by cpuset_attach()
>   * but we can't allocate it dynamically there.  Define it global and
>   * allocate from cpuset_init().
>   */
> @@ -2511,7 +2510,7 @@ static cpumask_var_t cpus_attach;
>  
>  static void cpuset_attach(struct cgroup_taskset *tset)
>  {
> -	/* static buf protected by cpuset_rwsem */
> +	/* static buf protected by cpuset_mutex */
>  	static nodemask_t cpuset_attach_nodemask_to;
>  	struct task_struct *task;
>  	struct task_struct *leader;
> @@ -2524,7 +2523,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	cs = css_cs(css);
>  
>  	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	cpus_updated = !cpumask_equal(cs->effective_cpus,
>  				      oldcs->effective_cpus);
>  	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> @@ -2597,7 +2596,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	if (!cs->attach_in_progress)
>  		wake_up(&cpuset_attach_wq);
>  
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  }
>  
>  /* The various types of files and directories in a cpuset file system */
> @@ -2629,7 +2628,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>  	int retval = 0;
>  
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	if (!is_cpuset_online(cs)) {
>  		retval = -ENODEV;
>  		goto out_unlock;
> @@ -2665,7 +2664,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>  		break;
>  	}
>  out_unlock:
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  	return retval;
>  }
> @@ -2678,7 +2677,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>  	int retval = -ENODEV;
>  
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
>  
> @@ -2691,7 +2690,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>  		break;
>  	}
>  out_unlock:
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  	return retval;
>  }
> @@ -2724,7 +2723,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  	 * operation like this one can lead to a deadlock through kernfs
>  	 * active_ref protection.  Let's break the protection.  Losing the
>  	 * protection is okay as we check whether @cs is online after
> -	 * grabbing cpuset_rwsem anyway.  This only happens on the legacy
> +	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
>  	 * hierarchies.
>  	 */
>  	css_get(&cs->css);
> @@ -2732,7 +2731,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  	flush_work(&cpuset_hotplug_work);
>  
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
>  
> @@ -2756,7 +2755,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  
>  	free_cpuset(trialcs);
>  out_unlock:
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  	kernfs_unbreak_active_protection(of->kn);
>  	css_put(&cs->css);
> @@ -2904,13 +2903,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>  
>  	css_get(&cs->css);
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
>  
>  	retval = update_prstate(cs, val);
>  out_unlock:
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  	css_put(&cs->css);
>  	return retval ?: nbytes;
> @@ -3127,7 +3126,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  		return 0;
>  
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  
>  	set_bit(CS_ONLINE, &cs->flags);
>  	if (is_spread_page(parent))
> @@ -3178,7 +3177,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
>  	spin_unlock_irq(&callback_lock);
>  out_unlock:
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  	return 0;
>  }
> @@ -3199,7 +3198,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>  	struct cpuset *cs = css_cs(css);
>  
>  	cpus_read_lock();
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  
>  	if (is_partition_valid(cs))
>  		update_prstate(cs, 0);
> @@ -3218,7 +3217,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>  	cpuset_dec();
>  	clear_bit(CS_ONLINE, &cs->flags);
>  
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  }
>  
> @@ -3231,7 +3230,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
>  
>  static void cpuset_bind(struct cgroup_subsys_state *root_css)
>  {
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  	spin_lock_irq(&callback_lock);
>  
>  	if (is_in_v2_mode()) {
> @@ -3244,7 +3243,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
>  	}
>  
>  	spin_unlock_irq(&callback_lock);
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  }
>  
>  /*
> @@ -3357,7 +3356,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>  	is_empty = cpumask_empty(cs->cpus_allowed) ||
>  		   nodes_empty(cs->mems_allowed);
>  
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  
>  	/*
>  	 * Move tasks to the nearest ancestor with execution resources,
> @@ -3367,7 +3366,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>  	if (is_empty)
>  		remove_tasks_in_empty_cpuset(cs);
>  
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  }
>  
>  static void
> @@ -3418,14 +3417,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>  retry:
>  	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
>  
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  
>  	/*
>  	 * We have raced with task attaching. We wait until attaching
>  	 * is finished, so we won't attach a task to an empty cpuset.
>  	 */
>  	if (cs->attach_in_progress) {
> -		percpu_up_write(&cpuset_rwsem);
> +		mutex_unlock(&cpuset_mutex);
>  		goto retry;
>  	}
>  
> @@ -3519,7 +3518,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>  		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
>  					    cpus_updated, mems_updated);
>  
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  }
>  
>  /**
> @@ -3549,7 +3548,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
>  	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
>  		ptmp = &tmp;
>  
> -	percpu_down_write(&cpuset_rwsem);
> +	mutex_lock(&cpuset_mutex);
>  
>  	/* fetch the available cpus/mems and find out which changed how */
>  	cpumask_copy(&new_cpus, cpu_active_mask);
> @@ -3606,7 +3605,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
>  		update_tasks_nodemask(&top_cpuset);
>  	}
>  
> -	percpu_up_write(&cpuset_rwsem);
> +	mutex_unlock(&cpuset_mutex);
>  
>  	/* if cpus or mems changed, we need to propagate to descendants */
>  	if (cpus_updated || mems_updated) {
> @@ -4037,7 +4036,7 @@ void __cpuset_memory_pressure_bump(void)
>   *  - Used for /proc/<pid>/cpuset.
>   *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
>   *    doesn't really matter if tsk->cpuset changes after we read it,
> - *    and we take cpuset_rwsem, keeping cpuset_attach() from changing it
> + *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
>   *    anyway.
>   */
>  int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b9616f153946..179266ff653f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7565,6 +7565,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	int reset_on_fork;
>  	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
>  	struct rq *rq;
> +	bool cpuset_locked = false;
>  
>  	/* The pi code expects interrupts enabled */
>  	BUG_ON(pi && in_interrupt());
> @@ -7614,8 +7615,14 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> -	if (pi)
> -		cpuset_read_lock();
> +	/*
> +	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
> +	 * information.
> +	 */
> +	if (dl_policy(policy) || dl_policy(p->policy)) {
> +		cpuset_locked = true;
> +		cpuset_lock();
> +	}
>  
>  	/*
>  	 * Make sure no PI-waiters arrive (or leave) while we are
> @@ -7691,8 +7698,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
>  		policy = oldpolicy = -1;
>  		task_rq_unlock(rq, p, &rf);
> -		if (pi)
> -			cpuset_read_unlock();
> +		if (cpuset_locked)
> +			cpuset_unlock();
>  		goto recheck;
>  	}
>  
> @@ -7759,7 +7766,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  	task_rq_unlock(rq, p, &rf);
>  
>  	if (pi) {
> -		cpuset_read_unlock();
> +		if (cpuset_locked)
> +			cpuset_unlock();
>  		rt_mutex_adjust_pi(p);
>  	}
>  
> @@ -7771,8 +7779,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  
>  unlock:
>  	task_rq_unlock(rq, p, &rf);
> -	if (pi)
> -		cpuset_read_unlock();
> +	if (cpuset_locked)
> +		cpuset_unlock();
>  	return retval;
>  }
>  
> -- 
> 2.39.2
> 
