Return-Path: <cgroups+bounces-8459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40FAD0CE5
	for <lists+cgroups@lfdr.de>; Sat,  7 Jun 2025 12:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C69216EEBF
	for <lists+cgroups@lfdr.de>; Sat,  7 Jun 2025 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC920D4E3;
	Sat,  7 Jun 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk3uaKUK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7201FCF41;
	Sat,  7 Jun 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749293444; cv=none; b=usWXPyLE7EV4fJ7f9EfyHHhHXjD7PWWSEFDhkXv7Vrue2L0SHByaElLrfYb68q0E8QpEH7hDFyyUCf9nyvgOS8r1rQoZFBzsTIm4XiAtFWQMY1JxdGx6evqmvPpThOypN8I6X+rldVrzxKr4RJyr3UXMtm/N1oapVWK3OL3gVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749293444; c=relaxed/simple;
	bh=o27XSHqJkIzSFdZHAZnYV8LCRI52XNOu42Y1+FEpZS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJBTlaANhbsTxmxo9L7eqolC8rwr8LTIdaSH8q93JogYxvtngtwnmURcLugm40O2oWbDH+Jn2eIwHxZYzq/W1gYF6nIKo84mcmMxGbr4Ygtazgf3SisJxv30JI+mH66XiSnCWnoR5b0/PaYqNtMsfKHLxMjsBHnntF32xT4YT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk3uaKUK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749293442; x=1780829442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o27XSHqJkIzSFdZHAZnYV8LCRI52XNOu42Y1+FEpZS4=;
  b=Xk3uaKUK1W/P8sNyt2SB0yFwF3LPDkAkbBP5fK3btRtsLL681pTHczlb
   ryXDQ8EhLdAITcjc/EhxpSmGKcxU1lLoWKuMadi2BQqn1FaZMG40Rs5mH
   Ft71OQbPRFJTela9LCstVVtQonSs92rMN/akJq3hpdLj7Phm11ZLTu4Sl
   vBbFzdOBFguGBS1+mMvVVLKat7+aSN2e3VTRE+Dxs+LlEQ6Op+rhlgVcO
   TjNQ500vFvkROZ2px73bt7nyeDOsyChAKPcoZpq8A6N7G87xxzsg0Ttv5
   KC5M/zekknmoyueLgLNIue3zyDIM6VTYpYhFzO+5PUPWWhEnaQfZUXfmw
   g==;
X-CSE-ConnectionGUID: HzsETOrtTwu0OPMTxuRCLA==
X-CSE-MsgGUID: oZiQy1FtRmq5xT3Oy7l8+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51431701"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51431701"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 03:50:42 -0700
X-CSE-ConnectionGUID: Y+tVodW+Rx6jX9aNnNeT7w==
X-CSE-MsgGUID: xibnwF5vSVGeQ+6KMw1QHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="145980515"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Jun 2025 03:50:40 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNr8H-0005jN-28;
	Sat, 07 Jun 2025 10:50:37 +0000
Date: Sat, 7 Jun 2025 18:50:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jemmy Wong <jemmywong512@gmail.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] cgroup: add lock guard support for others
Message-ID: <202506071822.ERv4i34r-lkp@intel.com>
References: <20250606161841.44354-4-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606161841.44354-4-jemmywong512@gmail.com>

Hi Jemmy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on linus/master next-20250606]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jemmy-Wong/cgroup-add-lock-guard-support-for-cgroup_muetx/20250607-002109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250606161841.44354-4-jemmywong512%40gmail.com
patch subject: [PATCH v1 3/3] cgroup: add lock guard support for others
config: sparc-randconfig-r121-20250607 (https://download.01.org/0day-ci/archive/20250607/202506071822.ERv4i34r-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250607/202506071822.ERv4i34r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506071822.ERv4i34r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/cgroup/cgroup.c:6721:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *l @@     got struct spinlock [noderef] __rcu * @@
   kernel/cgroup/cgroup.c:6721:33: sparse:     expected struct spinlock [usertype] *l
   kernel/cgroup/cgroup.c:6721:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/cgroup/cgroup.c:345:13: sparse: sparse: context imbalance in 'cgroup_idr_replace' - wrong count at exit
   kernel/cgroup/cgroup.c:351:13: sparse: sparse: context imbalance in 'cgroup_idr_remove' - wrong count at exit
   kernel/cgroup/cgroup.c:626:5: sparse: sparse: context imbalance in 'cgroup_task_count' - wrong count at exit
   kernel/cgroup/cgroup.c:2225:9: sparse: sparse: context imbalance in 'cgroup_do_get_tree' - different lock contexts for basic block
   kernel/cgroup/cgroup.c:2418:5: sparse: sparse: context imbalance in 'cgroup_path_ns' - wrong count at exit
   kernel/cgroup/cgroup.c:2734:9: sparse: sparse: context imbalance in 'cgroup_migrate_finish' - wrong count at exit
   kernel/cgroup/cgroup.c:3131:9: sparse: sparse: context imbalance in 'cgroup_lock_and_drain_offline' - wrong count at exit
   kernel/cgroup/cgroup.c:4532:9: sparse: sparse: context imbalance in 'cgroup_file_notify' - wrong count at exit
   kernel/cgroup/cgroup.c:4994:9: sparse: sparse: context imbalance in 'css_task_iter_start' - wrong count at exit
   kernel/cgroup/cgroup.c:5027:9: sparse: sparse: context imbalance in 'css_task_iter_next' - wrong count at exit
   kernel/cgroup/cgroup.c:5047:9: sparse: sparse: context imbalance in 'css_task_iter_end' - wrong count at exit
   kernel/cgroup/cgroup.c:6485:12: sparse: sparse: context imbalance in 'cgroup_css_set_fork' - wrong count at exit
   kernel/cgroup/cgroup.c:6601:9: sparse: sparse: context imbalance in 'cgroup_css_set_put_fork' - wrong count at exit
   kernel/cgroup/cgroup.c:6621:5: sparse: sparse: context imbalance in 'cgroup_can_fork' - wrong count at exit
   kernel/cgroup/cgroup.c:6670:9: sparse: sparse: context imbalance in 'cgroup_cancel_fork' - unexpected unlock
   kernel/cgroup/cgroup.c:6813:9: sparse: sparse: context imbalance in 'cgroup_release' - different lock contexts for basic block

vim +6721 kernel/cgroup/cgroup.c

  6672	
  6673	/**
  6674	 * cgroup_post_fork - finalize cgroup setup for the child process
  6675	 * @child: the child process
  6676	 * @kargs: the arguments passed to create the child process
  6677	 *
  6678	 * Attach the child process to its css_set calling the subsystem fork()
  6679	 * callbacks.
  6680	 */
  6681	void cgroup_post_fork(struct task_struct *child,
  6682			      struct kernel_clone_args *kargs)
  6683		__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
  6684	{
  6685		unsigned int cgrp_kill_seq = 0;
  6686		unsigned long cgrp_flags = 0;
  6687		bool kill = false;
  6688		struct cgroup_subsys *ss;
  6689		struct css_set *cset;
  6690		int i;
  6691	
  6692		cset = kargs->cset;
  6693		kargs->cset = NULL;
  6694	
  6695		scoped_guard(spinlock_irq, &css_set_lock) {
  6696			/* init tasks are special, only link regular threads */
  6697			if (likely(child->pid)) {
  6698				if (kargs->cgrp) {
  6699					cgrp_flags = kargs->cgrp->flags;
  6700					cgrp_kill_seq = kargs->cgrp->kill_seq;
  6701				} else {
  6702					cgrp_flags = cset->dfl_cgrp->flags;
  6703					cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
  6704				}
  6705	
  6706				WARN_ON_ONCE(!list_empty(&child->cg_list));
  6707				cset->nr_tasks++;
  6708				css_set_move_task(child, NULL, cset, false);
  6709			} else {
  6710				put_css_set(cset);
  6711				cset = NULL;
  6712			}
  6713	
  6714			if (!(child->flags & PF_KTHREAD)) {
  6715				if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
  6716					/*
  6717					 * If the cgroup has to be frozen, the new task has
  6718					 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
  6719					 * get the task into the frozen state.
  6720					 */
> 6721					scoped_guard(spinlock, &child->sighand->siglock) {
  6722						WARN_ON_ONCE(child->frozen);
  6723						child->jobctl |= JOBCTL_TRAP_FREEZE;
  6724					}
  6725	
  6726					/*
  6727					 * Calling cgroup_update_frozen() isn't required here,
  6728					 * because it will be called anyway a bit later from
  6729					 * do_freezer_trap(). So we avoid cgroup's transient
  6730					 * switch from the frozen state and back.
  6731					 */
  6732				}
  6733	
  6734				/*
  6735				 * If the cgroup is to be killed notice it now and take the
  6736				 * child down right after we finished preparing it for
  6737				 * userspace.
  6738				 */
  6739				kill = kargs->kill_seq != cgrp_kill_seq;
  6740			}
  6741		}
  6742		/*
  6743		 * Call ss->fork().  This must happen after @child is linked on
  6744		 * css_set; otherwise, @child might change state between ->fork()
  6745		 * and addition to css_set.
  6746		 */
  6747		do_each_subsys_mask(ss, i, have_fork_callback) {
  6748			ss->fork(child);
  6749		} while_each_subsys_mask();
  6750	
  6751		/* Make the new cset the root_cset of the new cgroup namespace. */
  6752		if (kargs->flags & CLONE_NEWCGROUP) {
  6753			struct css_set *rcset = child->nsproxy->cgroup_ns->root_cset;
  6754	
  6755			get_css_set(cset);
  6756			child->nsproxy->cgroup_ns->root_cset = cset;
  6757			put_css_set(rcset);
  6758		}
  6759	
  6760		/* Cgroup has to be killed so take down child immediately. */
  6761		if (unlikely(kill))
  6762			do_send_sig_info(SIGKILL, SEND_SIG_NOINFO, child, PIDTYPE_TGID);
  6763	
  6764		cgroup_css_set_put_fork(kargs);
  6765	}
  6766	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

