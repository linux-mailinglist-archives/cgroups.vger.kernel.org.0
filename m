Return-Path: <cgroups+bounces-5903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3859E9F2441
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CF18863C7
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA718EFED;
	Sun, 15 Dec 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8KY3Eo5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C71865FA;
	Sun, 15 Dec 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270711; cv=none; b=cxND3HB04k5v0TWmoRN4ZZRoFLPvuBdrpUuFHz1f5QyhyxO1YwVjSieBlivE19miKkMtnTGpdtENlarLQaKxeGEil3DSpYaU7YBQXRcxL6IDBndUiashB2mwOl7W4HQHePMbGHwjcXhmx4NEItMmcNhxvf31TuKIxYjhej/Oe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270711; c=relaxed/simple;
	bh=2LWjmtPJFDOKIXDan6DkpQm4ooohv4Sn4+uq85iaUG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQuOZ9eEEdkcfzGvVU86ZaRRyjY9hYklvQWcCog7tCCFTZJH3F2IWGEVbkl6D7mWMlEfgbT+A6CuLIlXhcKDC1syrZWe70nFrVS0jUFdsmRscSf9UTi9y5FnbV6+gpYPC3lSgT8uEw/sdriyUT+yXdyE4yFsYtto9CfMK/wWUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8KY3Eo5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734270709; x=1765806709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2LWjmtPJFDOKIXDan6DkpQm4ooohv4Sn4+uq85iaUG4=;
  b=g8KY3Eo5+NLSVGCZERuV5xTW+y4FlsutEfvEtwnbSxDfvbkckgJTjMSa
   /LDj8tnY9ph/uThalRMDVYQKuC/bBDdE+BKlz1Fk/DnhMHYHCafWA/DUt
   OqIMaJy1IhSlUZS3Go7HePkj85yuazZ1ZkhBHu2t5X5mYAItQuk7Nxkdt
   8PC9deJX8gf/TcR7tBnkolkisT2+tMx89K9fjIydFpj4F3z/dTnADHgv7
   6vXNzZrfPsVBGVN0F0lFwXS4rCYN2zET5P9PXR2qcZPOc3B2KxfeD5ocU
   bdoEHeXjIoL6VjbE5j+E7r+kG1wJv7DwKC+fsOee/cuHw+HYDGz8E5c2y
   Q==;
X-CSE-ConnectionGUID: FIxEZu9zTpysf8W0T+/PyA==
X-CSE-MsgGUID: AcqCQ6iRQ5eConOnOIQVNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46061200"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46061200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 05:51:49 -0800
X-CSE-ConnectionGUID: mVxlGRFjR76uOYep9V2vew==
X-CSE-MsgGUID: C2uK/3F0TXCdvEqBaL9gcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="101991422"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Dec 2024 05:51:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMp23-000Ddy-2A;
	Sun, 15 Dec 2024 13:51:39 +0000
Date: Sun, 15 Dec 2024 21:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
	peterz@infradead.org, mkoutny@suse.com, hannes@cmpxchg.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, surenb@google.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v7 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <202412152115.zQ6k9tVk-lkp@intel.com>
References: <20241215032315.43698-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215032315.43698-4-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.13-rc2 next-20241213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/sched-Define-sched_clock_irqtime-as-static-key/20241215-112638
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20241215032315.43698-4-laoar.shao%40gmail.com
patch subject: [PATCH v7 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
config: arm-randconfig-001-20241215 (https://download.01.org/0day-ci/archive/20241215/202412152115.zQ6k9tVk-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 2dc22615fd46ab2566d0f26d5ba234ab12dc4bf8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152115.zQ6k9tVk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412152115.zQ6k9tVk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:5:
   In file included from include/linux/cpuset.h:17:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/sched/build_utility.c:96:
>> kernel/sched/psi.c:1243:35: error: use of undeclared identifier 'PSI_IRQ'; did you mean 'PSI_IO'?
    1243 |         if (!irqtime_enabled() && res == PSI_IRQ)
         |                                          ^~~~~~~
         |                                          PSI_IO
   include/linux/psi_types.h:42:2: note: 'PSI_IO' declared here
      42 |         PSI_IO,
         |         ^
   1 warning and 1 error generated.


vim +1243 kernel/sched/psi.c

  1233	
  1234	int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
  1235	{
  1236		bool only_full = false;
  1237		int full;
  1238		u64 now;
  1239	
  1240		if (static_branch_likely(&psi_disabled))
  1241			return -EOPNOTSUPP;
  1242	
> 1243		if (!irqtime_enabled() && res == PSI_IRQ)
  1244			return -EOPNOTSUPP;
  1245	
  1246		/* Update averages before reporting them */
  1247		mutex_lock(&group->avgs_lock);
  1248		now = sched_clock();
  1249		collect_percpu_times(group, PSI_AVGS, NULL);
  1250		if (now >= group->avg_next_update)
  1251			group->avg_next_update = update_averages(group, now);
  1252		mutex_unlock(&group->avgs_lock);
  1253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

