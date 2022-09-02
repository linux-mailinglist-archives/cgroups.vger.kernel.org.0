Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E845AABF5
	for <lists+cgroups@lfdr.de>; Fri,  2 Sep 2022 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiIBKBR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Sep 2022 06:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiIBKBO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Sep 2022 06:01:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E005A148;
        Fri,  2 Sep 2022 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662112836; x=1693648836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z8Mgib2QatymcoG6hN4+y5eGn6bdmJ5yNpC/dUxkJo4=;
  b=AQjzhRnl2aG82uFSNNRo+e4d8zTE1fOq6vv1D2wIoB8E27qYLkN7P9p8
   YrGikrHC+nhAG04qTCbTdBksBySb8OtHRvi+NWURielimeArATjJ3UEic
   HkasJb5KHhP3Q9JUg6FDObOTeYIjn/klrbt3L0QV42Y+/rcK0RWCy41UA
   l0eRVngyktPC/asdy9E4w+YeK4gZHH136O8IN8OczwpU5u+K9oB+PbRF/
   NGuwfMJB7K1blb0KpvaydaPBifdyBPk9rOWT9twT0fzcgLklgYC6ZiPaU
   AfOKXSVvt6xRlEN8Sj4SaG1kmtT9RnZdyCh44YAXNido9rzYZFG970h1n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293525082"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="293525082"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="702090042"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2022 03:00:34 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oU3TV-0000UN-2s;
        Fri, 02 Sep 2022 10:00:33 +0000
Date:   Fri, 2 Sep 2022 18:00:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH] cgroup/cpuset: Add a new isolated mems.policy type.
Message-ID: <202209021748.qgRnQldF-lkp@intel.com>
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi hezhongkun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[cannot apply to tj-cgroup/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hezhongkun/cgroup-cpuset-Add-a-new-isolated-mems-policy-type/20220902-143512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 53aa930dc4bae6aa269951bd37103083145d6691
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220902/202209021748.qgRnQldF-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7b7fbf5ae59ebc703a8d545fabd305563c0f42f6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hezhongkun/cgroup-cpuset-Add-a-new-isolated-mems-policy-type/20220902-143512
        git checkout 7b7fbf5ae59ebc703a8d545fabd305563c0f42f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:22,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from kernel/cgroup/cpuset.c:25:
   kernel/cgroup/cpuset.c: In function 'update_nodemasks_hier':
>> kernel/cgroup/cpuset.c:1867:54: error: 'struct mempolicy' has no member named 'w'
    1867 |                                         cp->mempolicy->w.user_nodemask);
         |                                                      ^~
   include/linux/nodemask.h:163:56: note: in definition of macro 'nodes_and'
     163 |                         __nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
         |                                                        ^~~~
   kernel/cgroup/cpuset.c: In function 'cpuset_change_task_cs_mpol':
>> kernel/cgroup/cpuset.c:2477:12: error: 'struct task_struct' has no member named 'il_prev'
    2477 |         tsk->il_prev = 0;
         |            ^~
   kernel/cgroup/cpuset.c: In function 'cpuset_mpol_write':
   kernel/cgroup/cpuset.c:2525:63: error: 'struct mempolicy' has no member named 'w'
    2525 |                 nodes_and(cs_allowed, cs->effective_mems, mpol->w.user_nodemask);
         |                                                               ^~
   include/linux/nodemask.h:163:56: note: in definition of macro 'nodes_and'
     163 |                         __nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
         |                                                        ^~~~
   kernel/cgroup/cpuset.c: In function 'cpuset_mpol_show':
>> kernel/cgroup/cpuset.c:2558:26: error: 'struct mempolicy' has no member named 'mode'
    2558 |         if (!mpol || mpol->mode == MPOL_DEFAULT)
         |                          ^~
>> kernel/cgroup/cpuset.c:2561:9: error: implicit declaration of function 'mpol_to_str' [-Werror=implicit-function-declaration]
    2561 |         mpol_to_str(buffer, sizeof(buffer), mpol);
         |         ^~~~~~~~~~~
   kernel/cgroup/cpuset.c: In function 'cpuset_css_alloc':
>> kernel/cgroup/cpuset.c:2981:15: error: implicit declaration of function 'mpol_dup'; did you mean 'mpol_put'? [-Werror=implicit-function-declaration]
    2981 |         new = mpol_dup(pcs->mempolicy);
         |               ^~~~~~~~
         |               mpol_put
   kernel/cgroup/cpuset.c:2981:13: warning: assignment to 'struct mempolicy *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2981 |         new = mpol_dup(pcs->mempolicy);
         |             ^
   cc1: some warnings being treated as errors


vim +1867 kernel/cgroup/cpuset.c

  1821	
  1822	/*
  1823	 * update_nodemasks_hier - Update effective nodemasks and tasks in the subtree
  1824	 * @cs: the cpuset to consider
  1825	 * @new_mems: a temp variable for calculating new effective_mems
  1826	 *
  1827	 * When configured nodemask is changed, the effective nodemasks of this cpuset
  1828	 * and all its descendants need to be updated.
  1829	 *
  1830	 * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  1831	 *
  1832	 * Called with cpuset_rwsem held
  1833	 */
  1834	static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
  1835	{
  1836		struct cpuset *cp;
  1837		struct cgroup_subsys_state *pos_css;
  1838		nodemask_t cs_allowed;
  1839	
  1840		rcu_read_lock();
  1841		cpuset_for_each_descendant_pre(cp, pos_css, cs) {
  1842			struct cpuset *parent = parent_cs(cp);
  1843	
  1844			nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
  1845	
  1846			/*
  1847			 * If it becomes empty, inherit the effective mask of the
  1848			 * parent, which is guaranteed to have some MEMs.
  1849			 */
  1850			if (is_in_v2_mode() && nodes_empty(*new_mems))
  1851				*new_mems = parent->effective_mems;
  1852	
  1853			/* Skip the whole subtree if the nodemask remains the same. */
  1854			if (nodes_equal(*new_mems, cp->effective_mems)) {
  1855				pos_css = css_rightmost_descendant(pos_css);
  1856				continue;
  1857			}
  1858	
  1859			if (!css_tryget_online(&cp->css))
  1860				continue;
  1861			rcu_read_unlock();
  1862	
  1863			spin_lock_irq(&callback_lock);
  1864	
  1865			if (cp->mempolicy)
  1866				nodes_and(cs_allowed, *new_mems,
> 1867						cp->mempolicy->w.user_nodemask);
  1868			mpol_rebind_policy(cp->mempolicy, &cs_allowed);
  1869			cp->effective_mems = *new_mems;
  1870			spin_unlock_irq(&callback_lock);
  1871	
  1872			WARN_ON(!is_in_v2_mode() &&
  1873				!nodes_equal(cp->mems_allowed, cp->effective_mems));
  1874	
  1875			update_tasks_nodemask(cp);
  1876	
  1877			rcu_read_lock();
  1878			css_put(&cp->css);
  1879		}
  1880		rcu_read_unlock();
  1881	}
  1882	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
