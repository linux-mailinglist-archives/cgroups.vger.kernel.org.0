Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245D57D692
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiGUWKr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUWKr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 18:10:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA519C2E;
        Thu, 21 Jul 2022 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658441445; x=1689977445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gdOUqJSSgIMl0WgQ461EcXHmGxrrwE/9bBqaaRbiOEU=;
  b=QW0V2pZrHxgurIFsXwhMw4xi7o0/4U2l/bbm4217zK15hAwFqMsw2oJa
   UZTUAmXLdU/lDKarRpcQa8FiZPYsdus0XlknY2X9Udl4ji6fN5GoLU5qO
   71R0DjNpkajuYZTtA3RCzjit2xzTf+MguRZfS1xp8BEtZZWZVUV7sUOWV
   ZRyboJfOPAvg2Njtnovk1a+ubH89lk0LK/e3d7/x3YOBgPsLsItVZTyRb
   OlN+UYJ/B7A2eIvpDTaZ7vgJweukgL4IV5reubF/djBxe38G7wn8KsLtW
   ASgQf3GFqalSxCHFqGGyxDi+cayte4hIDAuIWDcF0tEgdhmib5FJlTaLj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="285944942"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="285944942"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="602469269"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2022 15:10:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEeNV-0000dG-1H;
        Thu, 21 Jul 2022 22:10:41 +0000
Date:   Fri, 22 Jul 2022 06:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>, hannes@cmpxchg.org,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Message-ID: <202207220642.sbCB4Bcf-lkp@intel.com>
References: <20220721040439.2651-10-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-10-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Chengming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on akpm-mm/mm-everything linus/master v5.19-rc7]
[cannot apply to tj-cgroup/for-next next-20220721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/sched-psi-some-optimization-and-extension/20220721-120833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 401e4963bf45c800e3e9ea0d3a0289d738005fd4
config: x86_64-randconfig-s022-20220718 (https://download.01.org/0day-ci/archive/20220722/202207220642.sbCB4Bcf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d14f2a9ff31fefc5b28a16addaa832dc80d84189
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chengming-Zhou/sched-psi-some-optimization-and-extension/20220721-120833
        git checkout d14f2a9ff31fefc5b28a16addaa832dc80d84189
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/core.c:711:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:711:31: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:711:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:781:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:781:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:781:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1028:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1028:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1028:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2192:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2192:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2192:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2192:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2192:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2192:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5376:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5376:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5376:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6322:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6322:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6322:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6848:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6848:17: sparse:    struct task_struct *
   kernel/sched/core.c:6848:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7064:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7064:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7064:22: sparse:    struct task_struct *
   kernel/sched/core.c:11121:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11121:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11121:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:537:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:570:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:586:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:624:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:665:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c:781:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2183:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2184:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2185:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1592:9: sparse: sparse: context imbalance in 'ttwu_runnable' - wrong count at exit
   kernel/sched/core.c:4262:9: sparse: sparse: context imbalance in 'task_call_func' - wrong count at exit
   kernel/sched/sched.h:1592:9: sparse: sparse: context imbalance in 'wake_up_new_task' - wrong count at exit
   kernel/sched/core.c:5035:9: sparse: sparse: context imbalance in 'finish_task_switch' - wrong count at exit
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2210:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2210:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2210:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2210:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2210:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *

vim +711 kernel/sched/core.c

   675	
   676	/*
   677	 * RQ-clock updating methods:
   678	 */
   679	
   680	static void update_rq_clock_task(struct rq *rq, s64 delta)
   681	{
   682	/*
   683	 * In theory, the compile should just see 0 here, and optimize out the call
   684	 * to sched_rt_avg_update. But I don't trust it...
   685	 */
   686		s64 __maybe_unused steal = 0, irq_delta = 0;
   687	
   688	#ifdef CONFIG_IRQ_TIME_ACCOUNTING
   689		irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
   690	
   691		/*
   692		 * Since irq_time is only updated on {soft,}irq_exit, we might run into
   693		 * this case when a previous update_rq_clock() happened inside a
   694		 * {soft,}irq region.
   695		 *
   696		 * When this happens, we stop ->clock_task and only update the
   697		 * prev_irq_time stamp to account for the part that fit, so that a next
   698		 * update will consume the rest. This ensures ->clock_task is
   699		 * monotonic.
   700		 *
   701		 * It does however cause some slight miss-attribution of {soft,}irq
   702		 * time, a more accurate solution would be to update the irq_time using
   703		 * the current rq->clock timestamp, except that would require using
   704		 * atomic ops.
   705		 */
   706		if (irq_delta > delta)
   707			irq_delta = delta;
   708	
   709		rq->prev_irq_time += irq_delta;
   710		delta -= irq_delta;
 > 711		psi_account_irqtime(rq->curr, irq_delta);
   712	#endif
   713	#ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
   714		if (static_key_false((&paravirt_steal_rq_enabled))) {
   715			steal = paravirt_steal_clock(cpu_of(rq));
   716			steal -= rq->prev_steal_time_rq;
   717	
   718			if (unlikely(steal > delta))
   719				steal = delta;
   720	
   721			rq->prev_steal_time_rq += steal;
   722			delta -= steal;
   723		}
   724	#endif
   725	
   726		rq->clock_task += delta;
   727	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
