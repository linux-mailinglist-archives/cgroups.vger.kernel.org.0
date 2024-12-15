Return-Path: <cgroups+bounces-5901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E59F2409
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 14:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2C01886465
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE451714CF;
	Sun, 15 Dec 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHmVQI4q"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58B17B502;
	Sun, 15 Dec 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268128; cv=none; b=hpacCnWFrBP/Ic951dap2R9bKPdoO9UW4LkJMeBSclIztYR13Mu2l4Ppg/W0kXorrBgfP5RGmS+5fVL4DZYritWkzZJu9RdJe5v609qTFK92PNduEkG4PJ13KCjT6v46iDPDTPfMxpYTagthEF+hGcOl8K+LXiyPNBJs5webRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268128; c=relaxed/simple;
	bh=fAo4P4rpHKuqyo0NonSsYZLQIJm0RKrQIz332EcYaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yir3HGtEmQFEuhyEoql4eJ5WMygvJqHBLgeBPh3nBHOEUFyV3WLbjdxdeJjJcQJfs3FWo1qnfe3z5i539341QLkpAR6QEno2u0WIOCl72tbmNf7+v+7+3G4ZxTfKys08EzUMR9px1kvpB9CFhSxMwA7IJcw6nWIeY5FV5o0S6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHmVQI4q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734268127; x=1765804127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fAo4P4rpHKuqyo0NonSsYZLQIJm0RKrQIz332EcYaHw=;
  b=PHmVQI4qzozA5BxYj+OLVvrMXhS3rtgqLXS+yT6QXuxZCgR7fctUcJ5K
   AY+VinlP4MDsdjEguL6vj8aPVdNBRTC8awvjkJFeGMZ1WOXJGwCKQx8v2
   dVFAl1BcORnheJbjRgES4KBn1R6QhfxHfRyA8E1a6CPNMwuchHHP5uHuS
   Lg4TzfFAZP0FipFe8aRQkqK8Oa0OVMdOQCnSCS2pnsjaEPRpzKhXjKo0W
   nU4DcPoLdu9+xBmqmPNPZmpatDVswHwYGtw9YNuTua2xPTvHc10wgqrxM
   DarpBDeU7K/lfl6ta+bFTv2auqfb1w742JYDNjbcd2Ol8Vgx5v2mTNzMK
   Q==;
X-CSE-ConnectionGUID: YEeC5LyXTUCK++QQ37WIag==
X-CSE-MsgGUID: iDGiX+jzQ3eBzjcRbGn9eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="22248631"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="22248631"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 05:08:45 -0800
X-CSE-ConnectionGUID: cG0dHzWlTxKJp3nb+wgDsA==
X-CSE-MsgGUID: F1CLcAReTDScfSbi4nYyZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97512305"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Dec 2024 05:08:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMoMO-000Dcw-1j;
	Sun, 15 Dec 2024 13:08:36 +0000
Date: Sun, 15 Dec 2024 21:08:36 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
	peterz@infradead.org, mkoutny@suse.com, hannes@cmpxchg.org
Cc: oe-kbuild-all@lists.linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, surenb@google.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v7 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <202412152009.HZ862kna-lkp@intel.com>
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
config: arc-randconfig-001-20241215 (https://download.01.org/0day-ci/archive/20241215/202412152009.HZ862kna-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152009.HZ862kna-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412152009.HZ862kna-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:96:
   kernel/sched/psi.c: In function 'psi_show':
>> kernel/sched/psi.c:1243:42: error: 'PSI_IRQ' undeclared (first use in this function); did you mean 'PSI_IO'?
    1243 |         if (!irqtime_enabled() && res == PSI_IRQ)
         |                                          ^~~~~~~
         |                                          PSI_IO
   kernel/sched/psi.c:1243:42: note: each undeclared identifier is reported only once for each function it appears in


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

