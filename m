Return-Path: <cgroups+bounces-6994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE917A5D359
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 00:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8DB17C1EB
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D423370B;
	Tue, 11 Mar 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5oCfhGx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CA22FF21
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736842; cv=none; b=cw9kvw5EYnEcuqOsxFBKuixW3oB0etAqTyoCeZ3dJgJ78Bkby6jTrBr8veasALYGuaz/D1m2AVRlsXNgxfn/soLbAbAroQneKvkIvuM2zsIrRcJCeDtPyGqKGDSWydwIPmgGKkuCpaXu1NR6F1diG/Qi7DAqcgMPq8bfP2s50X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736842; c=relaxed/simple;
	bh=F7030FiyuiufK2NQwbtEKBSquV5WtvIMs6fO9sMR2YI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RoipPQavaBj6RHHG7bdhT/vs9s/KgWBkwNIvQGdbdc+gfkDGuXcSaQDHYMtGBkyGQ4g/Uxqis6+4VrdoSTudZUILzE7jFdv0hWKvv6L6qdNbD/A0SsnqYJ5GXczfXswBA5O7ptxGMPgKzbNrpLSuEcMcZ2woKaSRmyLnJw+VDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5oCfhGx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741736841; x=1773272841;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F7030FiyuiufK2NQwbtEKBSquV5WtvIMs6fO9sMR2YI=;
  b=R5oCfhGx8wCM1WTe7jliyksnQ5xP07ghn/eyBtPmCMStA7etVY216wCM
   F11rDqAevnkA5PFYbL/eAO+36316LUXJ/xFMm6hzuro8rP9xgQD/BZ6fh
   CNjWKT8lVezwQLlJSwbGMlrj8Cnm0Oz7drQd5fzUXyXGUXLesHnMppMXR
   hb+KXxy/RE8oXrX5R7rWl/iHdkOLVoXvlf7dRaid+vWf9IEauofW0kkKJ
   zIInetXmOKgSH8XOr1gqsufMi4DVlRbvDZP9f+Kv23/kgKLz00JS7TF7w
   6Lwp8sQ/kn/VM6kyvXdZnoZTLX1AcG5H2tnunmMEsXvCgwXj4OVCghuus
   A==;
X-CSE-ConnectionGUID: 9PI8WZ8+RJavgmhiPfJctQ==
X-CSE-MsgGUID: 17CJXuBuTe+LDcYmKbYUCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46711329"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="46711329"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 16:47:19 -0700
X-CSE-ConnectionGUID: vrd/bwQJRFKgAfJYKZ1AWA==
X-CSE-MsgGUID: Pu9xa6ZJSY2VEyvHhvUGwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120174078"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 11 Mar 2025 16:47:17 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts9JZ-0007xF-2Q;
	Tue, 11 Mar 2025 23:47:14 +0000
Date: Wed, 12 Mar 2025 07:46:24 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [tj-cgroup:tmp 13/16] mm/memcontrol-v1.c:1860:58: error: expected
 ';' after expression
Message-ID: <202503120710.guZkJx0h-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tmp
head:   153926208f7777e220dec1156a44a5fa06623ac1
commit: c359863bfd828fd03999c17d9bad87e767708fa0 [13/16] mm: Add transformation message for per-memcg swappiness
config: hexagon-randconfig-001-20250312 (https://download.01.org/0day-ci/archive/20250312/202503120710.guZkJx0h-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120710.guZkJx0h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120710.guZkJx0h-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/memcontrol-v1.c:5:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/memcontrol-v1.c:1860:58: error: expected ';' after expression
    1860 |                              "See memory.reclaim or memory.swap.max there\n ")
         |                                                                               ^
         |                                                                               ;
   2 warnings and 1 error generated.


vim +1860 mm/memcontrol-v1.c

  1849	
  1850	static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
  1851					       struct cftype *cft, u64 val)
  1852	{
  1853		struct mem_cgroup *memcg = mem_cgroup_from_css(css);
  1854	
  1855		if (val > MAX_SWAPPINESS)
  1856			return -EINVAL;
  1857	
  1858		if (!mem_cgroup_is_root(memcg)) {
  1859			pr_info_once("Per memcg swappiness does not exist in cgroup v2. "
> 1860				     "See memory.reclaim or memory.swap.max there\n ")
  1861			WRITE_ONCE(memcg->swappiness, val);
  1862		} else
  1863			WRITE_ONCE(vm_swappiness, val);
  1864	
  1865		return 0;
  1866	}
  1867	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

