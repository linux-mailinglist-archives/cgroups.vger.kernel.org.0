Return-Path: <cgroups+bounces-341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE82E7E93D4
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C2F1F20EC3
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 00:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A93D82;
	Mon, 13 Nov 2023 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwEno6n0"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A94409
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 00:59:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1A19A3
	for <cgroups@vger.kernel.org>; Sun, 12 Nov 2023 16:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699837174; x=1731373174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KilVdjgP2U+qwF5RSNjMC/7Ktu+O+2bwC5Ws5g7++EA=;
  b=CwEno6n0yF5TIgwECyTj5wLGBjUnsDa7g601DMlRvuNDEVn23H3R6jbK
   ydk8zftejFddXBI2q70Dt9+70p5LuNURCwEqJ0RUXY0c7Qa/y7/JhD2P3
   smCLGmLcjb7++A1XnQeA/pEGE+yYJ5oQtS586wcPbLZLK0YYYrJKxhroB
   lYs9K/bkHt+CYXolLogfO7Zgnd73VuIQpnniTn45/R2BEiLIMJgLw3w6y
   mBgwfUC5J4hxbVJVphMns3Oe9sATP2fm0zNZOSgguIKSrX9V7DR4OqwbB
   Yx4fpS2k6U6UhZ2hJvkN6w7//iuPP9cpvkOvhqH4FdaXrj9tT1QVzh0Gl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="454663749"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="454663749"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 16:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="830105364"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="830105364"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2023 16:59:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r2LIY-000Bf8-13;
	Mon, 13 Nov 2023 00:59:30 +0000
Date: Mon, 13 Nov 2023 08:58:46 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:for-next 7/11] kernel/workqueue.c:5848:12: warning:
 'workqueue_set_unbound_cpumask' defined but not used
Message-ID: <202311130831.uh0AoCd1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
head:   e76d28bdf9ba5388b8c4835a5199dc427b603188
commit: fe28f631fa941fba583d1c4f25895284b90af671 [7/11] workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20231113/202311130831.uh0AoCd1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231113/202311130831.uh0AoCd1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311130831.uh0AoCd1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/workqueue.c:5848:12: warning: 'workqueue_set_unbound_cpumask' defined but not used [-Wunused-function]
    5848 | static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/workqueue_set_unbound_cpumask +5848 kernel/workqueue.c

  5835	
  5836	/**
  5837	 *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
  5838	 *  @cpumask: the cpumask to set
  5839	 *
  5840	 *  The low-level workqueues cpumask is a global cpumask that limits
  5841	 *  the affinity of all unbound workqueues.  This function check the @cpumask
  5842	 *  and apply it to all unbound workqueues and updates all pwqs of them.
  5843	 *
  5844	 *  Return:	0	- Success
  5845	 *  		-EINVAL	- Invalid @cpumask
  5846	 *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
  5847	 */
> 5848	static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
  5849	{
  5850		int ret = -EINVAL;
  5851	
  5852		/*
  5853		 * Not excluding isolated cpus on purpose.
  5854		 * If the user wishes to include them, we allow that.
  5855		 */
  5856		cpumask_and(cpumask, cpumask, cpu_possible_mask);
  5857		if (!cpumask_empty(cpumask)) {
  5858			apply_wqattrs_lock();
  5859			cpumask_copy(wq_requested_unbound_cpumask, cpumask);
  5860			if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
  5861				ret = 0;
  5862				goto out_unlock;
  5863			}
  5864	
  5865			ret = workqueue_apply_unbound_cpumask(cpumask);
  5866	
  5867	out_unlock:
  5868			apply_wqattrs_unlock();
  5869		}
  5870	
  5871		return ret;
  5872	}
  5873	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

