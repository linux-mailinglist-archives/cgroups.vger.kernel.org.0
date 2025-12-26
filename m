Return-Path: <cgroups+bounces-12749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92893CDEB2E
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23949300C0E3
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7594280325;
	Fri, 26 Dec 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS5C7ofp"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77691CAA4;
	Fri, 26 Dec 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766752343; cv=none; b=LSfZZC2jEEcMnQw4fVSaCnrIwBK2nggI73jI8nf/7K3oVv0Z2XWlgqUZ7pzAYK/Kn3JbdtPAzybWiISVbSuzKJZD2LL+gSV1Zr036VNf/ztGVlBx4GOtqHPGU5F56anN6NbvEF4Rj366PTCb5pgHtzR6UuZpNzY42KpBOVzZ/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766752343; c=relaxed/simple;
	bh=FbaYoFfToe6pPkt1KOkYwSAmsyLcTdfKga88xlj7jTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjbVWOQ9LHHuLgoz5+h5ihMSexeGXBl1Y6WfFlsq+rBimmstE+y3OEKNv6nP0vSYIMK3a6QO3/YqpPVIs92PCu82ZVhpnw3TyuyIV1wQnCfWh8j6WkpV78qEjpcNDgzOhxd4cQ+ufeMIWJBOMmX5PQu/NMS4bRvKHhI4Wbdl3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS5C7ofp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766752342; x=1798288342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbaYoFfToe6pPkt1KOkYwSAmsyLcTdfKga88xlj7jTE=;
  b=kS5C7ofpHCEutWnmV9RfuyuHf6IR+6eo9KHsAPUxAihk3UJ99+MUMnpi
   ax19IKPF/f2l777cOZ3gBb5c4gCaWiNnLarPuKn+jTRLgFACzpbnTBBgn
   k9+icDIGC7JNQkYCduHPx2JRz09cwdr2PNUQ7s+GandKbhk5Uyfkt0KkB
   LOCxcTYxU6PLBds7kdghcYiFNfaRcX3A7v5hqUuWiCThyIqMCLWB0OJzh
   QGdm0Bkqf/Y/yq+wOTbOwxrEG3iTOxoAcxn+MyM62LC8nmTOKnG7iFkdM
   DFOdpQDdSSuKX1bxhiVpIde25Y6rtKqe78K4zZpcsho6YFwegY1COJUz2
   g==;
X-CSE-ConnectionGUID: aDxXFyfxRvmP974Leo9zcA==
X-CSE-MsgGUID: S8qPQd4FS9mXnyLdCBUJog==
X-IronPort-AV: E=McAfee;i="6800,10657,11653"; a="68264051"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="68264051"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 04:32:21 -0800
X-CSE-ConnectionGUID: BX3uOhXuRGCixMQLyS9NUA==
X-CSE-MsgGUID: dxhpSzVyTHanhs2eBN8uAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; 
   d="scan'208";a="205298179"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 26 Dec 2025 04:32:18 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZ6zP-00000000529-3gjE;
	Fri, 26 Dec 2025 12:32:15 +0000
Date: Fri, 26 Dec 2025 20:31:38 +0800
From: kernel test robot <lkp@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	damon@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Message-ID: <202512262045.CkWwCNp7-lkp@intel.com>
References: <20251225232116.294540-9-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225232116.294540-9-shakeel.butt@linux.dev>

Hi Shakeel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sj/damon/next]
[cannot apply to akpm-mm/mm-everything tj-cgroup/for-next linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shakeel-Butt/memcg-introduce-private-id-API-for-in-kernel-users/20251226-072954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
patch link:    https://lore.kernel.org/r/20251225232116.294540-9-shakeel.butt%40linux.dev
patch subject: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
config: arm64-randconfig-001-20251226 (https://download.01.org/0day-ci/archive/20251226/202512262045.CkWwCNp7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512262045.CkWwCNp7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512262045.CkWwCNp7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/damon/sysfs.c:2704:33: warning: format specifies type 'unsigned int' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
    2704 |                 pr_info("id: %u, path: %s\n", mem_cgroup_id(memcg), path);
         |                              ~~               ^~~~~~~~~~~~~~~~~~~~
         |                              %llu
   include/linux/printk.h:585:34: note: expanded from macro 'pr_info'
     585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +2704 mm/damon/sysfs.c

c951cd3b89010c SeongJae Park 2022-03-22  2690  
a25dadf8af8ddc SeongJae Park 2022-11-18  2691  static ssize_t debug_show(struct kobject *kobj,
a25dadf8af8ddc SeongJae Park 2022-11-18  2692  		struct kobj_attribute *attr, char *buf)
a25dadf8af8ddc SeongJae Park 2022-11-18  2693  {
a25dadf8af8ddc SeongJae Park 2022-11-18  2694  #ifdef CONFIG_MEMCG
a25dadf8af8ddc SeongJae Park 2022-11-18  2695  	struct mem_cgroup *memcg;
a25dadf8af8ddc SeongJae Park 2022-11-18  2696  	char *path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
a25dadf8af8ddc SeongJae Park 2022-11-18  2697  
a25dadf8af8ddc SeongJae Park 2022-11-18  2698  	if (!path)
a25dadf8af8ddc SeongJae Park 2022-11-18  2699  		return -ENOMEM;
a25dadf8af8ddc SeongJae Park 2022-11-18  2700  
a25dadf8af8ddc SeongJae Park 2022-11-18  2701  	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg; memcg =
a25dadf8af8ddc SeongJae Park 2022-11-18  2702  			mem_cgroup_iter(NULL, memcg, NULL)) {
a25dadf8af8ddc SeongJae Park 2022-11-18  2703  		cgroup_path(memcg->css.cgroup, path, PATH_MAX);
a25dadf8af8ddc SeongJae Park 2022-11-18 @2704  		pr_info("id: %u, path: %s\n", mem_cgroup_id(memcg), path);
a25dadf8af8ddc SeongJae Park 2022-11-18  2705  	}
a25dadf8af8ddc SeongJae Park 2022-11-18  2706  
a25dadf8af8ddc SeongJae Park 2022-11-18  2707  	kfree(path);
a25dadf8af8ddc SeongJae Park 2022-11-18  2708  #endif
a25dadf8af8ddc SeongJae Park 2022-11-18  2709  
a25dadf8af8ddc SeongJae Park 2022-11-18  2710  	return 0;
a25dadf8af8ddc SeongJae Park 2022-11-18  2711  }
a25dadf8af8ddc SeongJae Park 2022-11-18  2712  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

