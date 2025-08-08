Return-Path: <cgroups+bounces-9053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58DB1F095
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 00:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5FE727AC7
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A9B217709;
	Fri,  8 Aug 2025 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N63Z1PWh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616292E370A;
	Fri,  8 Aug 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690584; cv=none; b=MmKmVly8Or+7NshLE/4rqoDX4QGUUWv2ElsOwq5Ed2EcIE/KfCdEUeHTtBkgb1Hw1oYt4MJEaDN37Dabdhg+m5NEcGMNDIvx7dJ0XvuldeKlemAaRNpBs+Nn5wnSV4an9x1BZ29zaCuFTVsx+1dGWFa/+o/sgTPGoI24JhqdmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690584; c=relaxed/simple;
	bh=cKvcSciDejdjd38nQ7qkzCxAQUA6XNIT6v6y55TKL2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFdzo51lc7XPTfEKEjfH8h25G81lyclbZd+z+CqCw/Fib24xkJsNAov+Fbj8o8MM/zcp3UB02jgSRfQED1kNJA3Vw0dChxhckgRoTvDuQubVlA6zwbkErMIv/PRXbVXBJfo4VYjj5pIp0/pI+X0sG8vcXZvoFLk6m8Shktq+piI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N63Z1PWh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754690582; x=1786226582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cKvcSciDejdjd38nQ7qkzCxAQUA6XNIT6v6y55TKL2s=;
  b=N63Z1PWhOVV54Ak92imXppT3Cadp8PGmJ1MNOwiZOsqFdWuGMT4MnApf
   If/3YEvejXl2atocjxc8/N0KviZS5UZ6KCCQaKTWP9ugXjcaS4xTnwNEk
   qSDE5CDlmuOwsF8VA4/Bw/NnjtwFFWDU2hR0jtlCjbliHlh6pnpqaMh2y
   lz0jfWsfdDNJrYqEkBIEGLf5FORURuYcgFxCrXVCpq/Fi+Ty9pw9JV0R8
   OYHY+kP1jYWZ+PE0nTB4GcBbPY/fTjI8z3KLy+w47Qwb2ZaqWqhUQHbD0
   i93rP1UjbfYRHIjUicd7ic7hoeuebn4icp5GbJWyWx/ZMDBo7ASGC7BN4
   A==;
X-CSE-ConnectionGUID: uJIUunPqTYmsv6KRu9RRAw==
X-CSE-MsgGUID: vqBVTMtrRwafgch7CalxuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="74625833"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74625833"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 15:03:01 -0700
X-CSE-ConnectionGUID: zWnt4Y9vT1qqmVEpWB2t1Q==
X-CSE-MsgGUID: 4LiKqUqCSBObBtAVWBzlPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196246375"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2025 15:02:57 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukVAt-0004MK-0h;
	Fri, 08 Aug 2025 22:02:55 +0000
Date: Sat, 9 Aug 2025 06:02:06 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huawei.com
Subject: Re: [PATCH -next 4/4] cpuset: replace cpuset_lock() with
 guard_cpuset()
Message-ID: <202508090557.XjdGVjX4-lkp@intel.com>
References: <20250808092515.764820-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808092515.764820-5-chenridong@huaweicloud.com>

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250808]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/cpuset-remove-redundant-CS_ONLINE-flag/20250808-174245
base:   next-20250808
patch link:    https://lore.kernel.org/r/20250808092515.764820-5-chenridong%40huaweicloud.com
patch subject: [PATCH -next 4/4] cpuset: replace cpuset_lock() with guard_cpuset()
config: x86_64-buildonly-randconfig-001-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090557.XjdGVjX4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090557.XjdGVjX4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090557.XjdGVjX4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:65:
   kernel/sched/syscalls.c: In function '__sched_setscheduler':
>> kernel/sched/syscalls.c:581:25: error: implicit declaration of function 'guard_cpuset' [-Werror=implicit-function-declaration]
     581 |                         guard_cpuset();
         |                         ^~~~~~~~~~~~
   In file included from kernel/sched/build_policy.c:52:
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:12:18: warning: 'max_rt_runtime' defined but not used [-Wunused-const-variable=]
      12 | static const u64 max_rt_runtime = MAX_BW;
         |                  ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/guard_cpuset +581 kernel/sched/syscalls.c

   512	
   513	int __sched_setscheduler(struct task_struct *p,
   514				 const struct sched_attr *attr,
   515				 bool user, bool pi)
   516	{
   517		int oldpolicy = -1, policy = attr->sched_policy;
   518		int retval, oldprio, newprio, queued, running;
   519		const struct sched_class *prev_class, *next_class;
   520		struct balance_callback *head;
   521		struct rq_flags rf;
   522		int reset_on_fork;
   523		int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
   524		struct rq *rq;
   525		bool cpuset_locked = false;
   526	
   527		/* The pi code expects interrupts enabled */
   528		BUG_ON(pi && in_interrupt());
   529	recheck:
   530		/* Double check policy once rq lock held: */
   531		if (policy < 0) {
   532			reset_on_fork = p->sched_reset_on_fork;
   533			policy = oldpolicy = p->policy;
   534		} else {
   535			reset_on_fork = !!(attr->sched_flags & SCHED_FLAG_RESET_ON_FORK);
   536	
   537			if (!valid_policy(policy))
   538				return -EINVAL;
   539		}
   540	
   541		if (attr->sched_flags & ~(SCHED_FLAG_ALL | SCHED_FLAG_SUGOV))
   542			return -EINVAL;
   543	
   544		/*
   545		 * Valid priorities for SCHED_FIFO and SCHED_RR are
   546		 * 1..MAX_RT_PRIO-1, valid priority for SCHED_NORMAL,
   547		 * SCHED_BATCH and SCHED_IDLE is 0.
   548		 */
   549		if (attr->sched_priority > MAX_RT_PRIO-1)
   550			return -EINVAL;
   551		if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
   552		    (rt_policy(policy) != (attr->sched_priority != 0)))
   553			return -EINVAL;
   554	
   555		if (user) {
   556			retval = user_check_sched_setscheduler(p, attr, policy, reset_on_fork);
   557			if (retval)
   558				return retval;
   559	
   560			if (attr->sched_flags & SCHED_FLAG_SUGOV)
   561				return -EINVAL;
   562	
   563			retval = security_task_setscheduler(p);
   564			if (retval)
   565				return retval;
   566		}
   567	
   568		/* Update task specific "requested" clamps */
   569		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
   570			retval = uclamp_validate(p, attr);
   571			if (retval)
   572				return retval;
   573		}
   574	
   575		/*
   576		 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
   577		 * information.
   578		 */
   579		if (dl_policy(policy) || dl_policy(p->policy)) {
   580			if (!cpuset_locked) {
 > 581				guard_cpuset();
   582				cpuset_locked = true;
   583			}
   584		}
   585	
   586		/*
   587		 * Make sure no PI-waiters arrive (or leave) while we are
   588		 * changing the priority of the task:
   589		 *
   590		 * To be able to change p->policy safely, the appropriate
   591		 * runqueue lock must be held.
   592		 */
   593		rq = task_rq_lock(p, &rf);
   594		update_rq_clock(rq);
   595	
   596		/*
   597		 * Changing the policy of the stop threads its a very bad idea:
   598		 */
   599		if (p == rq->stop) {
   600			retval = -EINVAL;
   601			goto unlock;
   602		}
   603	
   604		retval = scx_check_setscheduler(p, policy);
   605		if (retval)
   606			goto unlock;
   607	
   608		/*
   609		 * If not changing anything there's no need to proceed further,
   610		 * but store a possible modification of reset_on_fork.
   611		 */
   612		if (unlikely(policy == p->policy)) {
   613			if (fair_policy(policy) &&
   614			    (attr->sched_nice != task_nice(p) ||
   615			     (attr->sched_runtime != p->se.slice)))
   616				goto change;
   617			if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
   618				goto change;
   619			if (dl_policy(policy) && dl_param_changed(p, attr))
   620				goto change;
   621			if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
   622				goto change;
   623	
   624			p->sched_reset_on_fork = reset_on_fork;
   625			retval = 0;
   626			goto unlock;
   627		}
   628	change:
   629	
   630		if (user) {
   631	#ifdef CONFIG_RT_GROUP_SCHED
   632			/*
   633			 * Do not allow real-time tasks into groups that have no runtime
   634			 * assigned.
   635			 */
   636			if (rt_group_sched_enabled() &&
   637					rt_bandwidth_enabled() && rt_policy(policy) &&
   638					task_group(p)->rt_bandwidth.rt_runtime == 0 &&
   639					!task_group_is_autogroup(task_group(p))) {
   640				retval = -EPERM;
   641				goto unlock;
   642			}
   643	#endif /* CONFIG_RT_GROUP_SCHED */
   644			if (dl_bandwidth_enabled() && dl_policy(policy) &&
   645					!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
   646				cpumask_t *span = rq->rd->span;
   647	
   648				/*
   649				 * Don't allow tasks with an affinity mask smaller than
   650				 * the entire root_domain to become SCHED_DEADLINE. We
   651				 * will also fail if there's no bandwidth available.
   652				 */
   653				if (!cpumask_subset(span, p->cpus_ptr) ||
   654				    rq->rd->dl_bw.bw == 0) {
   655					retval = -EPERM;
   656					goto unlock;
   657				}
   658			}
   659		}
   660	
   661		/* Re-check policy now with rq lock held: */
   662		if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
   663			policy = oldpolicy = -1;
   664			task_rq_unlock(rq, p, &rf);
   665			goto recheck;
   666		}
   667	
   668		/*
   669		 * If setscheduling to SCHED_DEADLINE (or changing the parameters
   670		 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
   671		 * is available.
   672		 */
   673		if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
   674			retval = -EBUSY;
   675			goto unlock;
   676		}
   677	
   678		p->sched_reset_on_fork = reset_on_fork;
   679		oldprio = p->prio;
   680	
   681		newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
   682		if (pi) {
   683			/*
   684			 * Take priority boosted tasks into account. If the new
   685			 * effective priority is unchanged, we just store the new
   686			 * normal parameters and do not touch the scheduler class and
   687			 * the runqueue. This will be done when the task deboost
   688			 * itself.
   689			 */
   690			newprio = rt_effective_prio(p, newprio);
   691			if (newprio == oldprio)
   692				queue_flags &= ~DEQUEUE_MOVE;
   693		}
   694	
   695		prev_class = p->sched_class;
   696		next_class = __setscheduler_class(policy, newprio);
   697	
   698		if (prev_class != next_class && p->se.sched_delayed)
   699			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
   700	
   701		queued = task_on_rq_queued(p);
   702		running = task_current_donor(rq, p);
   703		if (queued)
   704			dequeue_task(rq, p, queue_flags);
   705		if (running)
   706			put_prev_task(rq, p);
   707	
   708		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
   709			__setscheduler_params(p, attr);
   710			p->sched_class = next_class;
   711			p->prio = newprio;
   712		}
   713		__setscheduler_uclamp(p, attr);
   714		check_class_changing(rq, p, prev_class);
   715	
   716		if (queued) {
   717			/*
   718			 * We enqueue to tail when the priority of a task is
   719			 * increased (user space view).
   720			 */
   721			if (oldprio < p->prio)
   722				queue_flags |= ENQUEUE_HEAD;
   723	
   724			enqueue_task(rq, p, queue_flags);
   725		}
   726		if (running)
   727			set_next_task(rq, p);
   728	
   729		check_class_changed(rq, p, prev_class, oldprio);
   730	
   731		/* Avoid rq from going away on us: */
   732		preempt_disable();
   733		head = splice_balance_callbacks(rq);
   734		task_rq_unlock(rq, p, &rf);
   735	
   736		if (pi)
   737			rt_mutex_adjust_pi(p);
   738	
   739		/* Run balance callbacks after we've adjusted the PI chain: */
   740		balance_callbacks(rq, head);
   741		preempt_enable();
   742	
   743		return 0;
   744	
   745	unlock:
   746		task_rq_unlock(rq, p, &rf);
   747		return retval;
   748	}
   749	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

