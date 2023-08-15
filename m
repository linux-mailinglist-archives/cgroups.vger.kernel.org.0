Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4994F77D695
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 01:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbjHOXT3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 19:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjHOXTS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 19:19:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F010C3;
        Tue, 15 Aug 2023 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692141557; x=1723677557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jDk2PL7s6hbeKzM5yWZ5eP5NxRPS1Vb13QdP3E5ftMg=;
  b=lXRFBNWltaKxRZMTXdUrzi/rYQpkDNWpVnn/FA1YTNgCp9sbklwuPtGm
   TQdigrzowCGZgCy4aMryPaJnqLASzWerZoKcCoV2U9+hDFVngllDzv/LQ
   ee8umAQZ1eWOnVSAmyFbDyCxqmNskNHYmku1GZltT8dMWmF0X8OPyhlpj
   okz9z/vYxQDEEsb0OsKyMlq97ut0ogAy60TzFtQe7wYutMk96SvgzchLV
   XANOYvC4lAIMvONhc346TtfIfx9T9xvS2RkZ9JDZnP+4OYPzTEGHKPJMD
   yJksGHkfQLC4/fhd3KsfhNcEjsyGKnJzg3Fy0/+N9fjK+TUJcWr7/zxoT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375169822"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="375169822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 16:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727537783"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="727537783"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 16:19:13 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW3Jd-0001JX-1O;
        Tue, 15 Aug 2023 23:19:10 +0000
Date:   Wed, 16 Aug 2023 07:18:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-cgroup v6 1/6] cgroup/cpuset: Add
 cpuset.cpus.exclusive.effective for v2
Message-ID: <202308160752.IWyhJoln-lkp@intel.com>
References: <20230815153027.633355-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815153027.633355-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Waiman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230815]
[cannot apply to tj-cgroup/for-next v6.5-rc6 v6.5-rc5 v6.5-rc4 linus/master v6.5-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/cgroup-cpuset-Add-cpuset-cpus-exclusive-effective-for-v2/20230815-233522
base:   next-20230815
patch link:    https://lore.kernel.org/r/20230815153027.633355-2-longman%40redhat.com
patch subject: [PATCH-cgroup v6 1/6] cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20230816/202308160752.IWyhJoln-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308160752.IWyhJoln-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308160752.IWyhJoln-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/cpuset.c: In function 'update_prstate':
>> kernel/cgroup/cpuset.c:2468:30: warning: the comparison will always evaluate as 'true' for the address of 'effective_xcpus' will never be NULL [-Waddress]
    2468 |         if ((new_prs > 0) && !cs->effective_xcpus) {
         |                              ^
   kernel/cgroup/cpuset.c:135:23: note: 'effective_xcpus' declared here
     135 |         cpumask_var_t effective_xcpus;
         |                       ^~~~~~~~~~~~~~~


vim +2468 kernel/cgroup/cpuset.c

  2435	
  2436	/**
  2437	 * update_prstate - update partition_root_state
  2438	 * @cs: the cpuset to update
  2439	 * @new_prs: new partition root state
  2440	 * Return: 0 if successful, != 0 if error
  2441	 *
  2442	 * Call with cpuset_mutex held.
  2443	 */
  2444	static int update_prstate(struct cpuset *cs, int new_prs)
  2445	{
  2446		int err = PERR_NONE, old_prs = cs->partition_root_state;
  2447		struct tmpmasks tmpmask;
  2448	
  2449		if (old_prs == new_prs)
  2450			return 0;
  2451	
  2452		/*
  2453		 * For a previously invalid partition root, leave it at being
  2454		 * invalid if new_prs is not "member".
  2455		 */
  2456		if (new_prs && is_prs_invalid(old_prs)) {
  2457			cs->partition_root_state = -new_prs;
  2458			return 0;
  2459		}
  2460	
  2461		if (alloc_cpumasks(NULL, &tmpmask))
  2462			return -ENOMEM;
  2463	
  2464		/*
  2465		 * Setup effective_xcpus if not set yet, it will be cleared later
  2466		 * if partition becomes invalid.
  2467		 */
> 2468		if ((new_prs > 0) && !cs->effective_xcpus) {
  2469			struct cpuset *parent = parent_cs(cs);
  2470	
  2471			spin_lock_irq(&callback_lock);
  2472			cpumask_and(cs->effective_xcpus,
  2473				    cs->cpus_allowed, parent->effective_xcpus);
  2474			spin_unlock_irq(&callback_lock);
  2475		}
  2476	
  2477		err = update_partition_exclusive(cs, new_prs);
  2478		if (err)
  2479			goto out;
  2480	
  2481		if (!old_prs) {
  2482			/*
  2483			 * cpus_allowed cannot be empty.
  2484			 */
  2485			if (cpumask_empty(cs->cpus_allowed)) {
  2486				err = PERR_CPUSEMPTY;
  2487				goto out;
  2488			}
  2489	
  2490			err = update_parent_effective_cpumask(cs, partcmd_enable,
  2491							      NULL, &tmpmask);
  2492		} else if (old_prs && new_prs) {
  2493			/*
  2494			 * A change in load balance state only, no change in cpumasks.
  2495			 */
  2496			;
  2497		} else {
  2498			/*
  2499			 * Switching back to member is always allowed even if it
  2500			 * disables child partitions.
  2501			 */
  2502			update_parent_effective_cpumask(cs, partcmd_disable, NULL,
  2503							&tmpmask);
  2504	
  2505			/*
  2506			 * Invalidation of child partitions will be done in
  2507			 * update_cpumasks_hier().
  2508			 */
  2509		}
  2510	out:
  2511		/*
  2512		 * Make partition invalid & disable CS_CPU_EXCLUSIVE if an error
  2513		 * happens.
  2514		 */
  2515		if (err) {
  2516			new_prs = -new_prs;
  2517			update_partition_exclusive(cs, new_prs);
  2518		}
  2519	
  2520		spin_lock_irq(&callback_lock);
  2521		cs->partition_root_state = new_prs;
  2522		WRITE_ONCE(cs->prs_err, err);
  2523		if (!is_partition_valid(cs))
  2524			cpumask_clear(cs->effective_xcpus);
  2525		spin_unlock_irq(&callback_lock);
  2526	
  2527		/* Force update if switching back to member */
  2528		update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
  2529	
  2530		/* Update sched domains and load balance flag */
  2531		update_partition_sd_lb(cs, old_prs);
  2532	
  2533		notify_partition_change(cs, old_prs);
  2534		free_cpumasks(NULL, &tmpmask);
  2535		return 0;
  2536	}
  2537	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
