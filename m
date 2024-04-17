Return-Path: <cgroups+bounces-2564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DE8A8356
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 14:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BDA1C2182C
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904841A89;
	Wed, 17 Apr 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVy6qM5F"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3942747F
	for <cgroups@vger.kernel.org>; Wed, 17 Apr 2024 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357979; cv=none; b=ummT2/XlNSLfRPBFIYY5oug9ijE2HqU877eEhNym/1bUcBWikhdXLUjjfGU3Fg6v+K0dLAIWxYR7aw/ah6gjL0u8IYt/swoIdGdXsCLpPH0GGxnKp7J6mz5KtddCWWf7Dy8WHSdF0/vYBBM/SFUL5MoZk2vx3/qWXWWK61hjNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357979; c=relaxed/simple;
	bh=QKzc8VdE4hx4yRUvgyMIY3829wYF/6tM3fe4k22nAyI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gVYeRobUrwdLZ1gw76ORFi4Xzynn+nEOvJs9uPMs4CkdVHX+8sHn8IzaMuhE3g6Q1HNRjTqYeKbhzBKoh8gallUjWf4WtWQWyt5eqBTQ7WbxgYIvCCsV7uuCpAggt/K2zngKTIW7xgkVVDzDV7NNqg5UC789pPZ1ZAqwLgHV90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVy6qM5F; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713357977; x=1744893977;
  h=date:from:to:cc:subject:message-id;
  bh=QKzc8VdE4hx4yRUvgyMIY3829wYF/6tM3fe4k22nAyI=;
  b=gVy6qM5FU5f6mHq2KhPmu7zZVJQkobbRtxfCPH98NzanI7Nx3DWTI6wO
   gXz+YFaPQGBd5uVtaVXj9HXZRU/yxSxSdcGf9aXPdTwahskT79q+Mm1M9
   MIhQI8aDTkbAthvWsIEwTIiaTijvzkbFNwZVSSPOJv3rlZuhGdoCodnVB
   eGC0EUFbVV7zwEryLBgXO8RmrROQ9mlNTQRD3xC+F+70rSKLnvJTLVYQb
   o5AhDS4Q1Mh5lRUSn5a83yp8GhmQ+WQbgQXuER7kzDhPLwmsUDL4h9rQn
   7EknuAksbG2slpdH9yqoSA4wPFRgLniZ/yaN5km+bhoQdYVBjkWG+9GS6
   g==;
X-CSE-ConnectionGUID: 5EfIzSaAQrm9GhSgrcA69A==
X-CSE-MsgGUID: gV6My2huQFSnmweOE4sjyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8706230"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8706230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 05:46:17 -0700
X-CSE-ConnectionGUID: DvEi2cHuRDanXD9fD+6enw==
X-CSE-MsgGUID: WAINst+fRyGjgwtn9rhr8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27048725"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 17 Apr 2024 05:46:16 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx4g1-0006aR-2j;
	Wed, 17 Apr 2024 12:46:13 +0000
Date: Wed, 17 Apr 2024 20:46:12 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS WITH WARNING
 fc29e04ae1ad4c99422c0b8ae4b43cfe99c70429
Message-ID: <202404172009.ht7VFFhH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: fc29e04ae1ad4c99422c0b8ae4b43cfe99c70429  cgroup/rstat: add cgroup_rstat_lock helpers and tracepoints

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404170821.HwZGISTY-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/cgroup/rstat.c:334: warning: Function parameter or struct member 'cgrp' not described in 'cgroup_rstat_flush_release'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- csky-allmodconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- csky-allyesconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- i386-buildonly-randconfig-006-20240417
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- i386-randconfig-002-20240417
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- i386-randconfig-003-20240417
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- i386-randconfig-012-20240417
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- microblaze-allyesconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- mips-allyesconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- nios2-allmodconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- nios2-allyesconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- parisc-defconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- sparc-allmodconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- sparc64-allmodconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
`-- sparc64-allyesconfig
    `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
clang_recent_errors
|-- i386-randconfig-001-20240417
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- i386-randconfig-013-20240417
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
|-- riscv-allmodconfig
|   `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release
`-- riscv-allyesconfig
    `-- kernel-cgroup-rstat.c:warning:Function-parameter-or-struct-member-cgrp-not-described-in-cgroup_rstat_flush_release

elapsed time: 866m

configs tested: 101
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

