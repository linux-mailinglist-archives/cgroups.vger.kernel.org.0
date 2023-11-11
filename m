Return-Path: <cgroups+bounces-331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83867E882F
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F982810DE
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 02:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C92FB6;
	Sat, 11 Nov 2023 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDVVdU7R"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C244405
	for <cgroups@vger.kernel.org>; Sat, 11 Nov 2023 02:23:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C1F3C0C
	for <cgroups@vger.kernel.org>; Fri, 10 Nov 2023 18:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699669411; x=1731205411;
  h=date:from:to:cc:subject:message-id;
  bh=rPUfXg8MbQlQlSzwLgDLhZg9Nz/OkNw13XtqOh6poDM=;
  b=WDVVdU7RMiNlNfWTDVcZsZCXTcbepZB0tbijzEPdxDmjQi5l+aJ5KDTR
   ymGWc/F1Cp2vDf3ZYqS0z7PLKrUPHhp5kyquLHl+DrDp74K7Wt2SqZf1q
   oISJxGxVzLslgAgjPNmvhq+22d4B1xXCz8LxFxVQ8G+sfDuIJ+ruYRq2y
   kALmMTJQuAsR2SJiAKyv2z5KGSHMqg7BMnGDl90iJWZRGrymS6pxtR/4C
   1qHCQhTHRf0j1j88Q9+4OOmr69mrLZAmlbHvyuhj8/XZcq+rfu9EApw8k
   wkTTAqMmiGPN497ZaH3lv8NDVM9GC2veZmPsByAlkQqAhb10ZTNno5F3j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="11802561"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="11802561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 18:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="798721584"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="798721584"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2023 18:23:29 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1deh-000A94-0l;
	Sat, 11 Nov 2023 02:23:27 +0000
Date: Sat, 11 Nov 2023 10:22:32 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 aecd408b7e50742868b3305c24325a89024e2a30
Message-ID: <202311111030.jrm468VO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: aecd408b7e50742868b3305c24325a89024e2a30  cgroup: Add a new helper for cgroup1 hierarchy

elapsed time: 1445m

configs tested: 260
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231110   gcc  
arc                   randconfig-002-20231110   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                           omap1_defconfig   clang
arm                   randconfig-001-20231110   gcc  
arm                   randconfig-001-20231111   gcc  
arm                   randconfig-002-20231110   gcc  
arm                   randconfig-002-20231111   gcc  
arm                   randconfig-003-20231110   gcc  
arm                   randconfig-003-20231111   gcc  
arm                   randconfig-004-20231110   gcc  
arm                   randconfig-004-20231111   gcc  
arm                          sp7021_defconfig   clang
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231110   gcc  
arm64                 randconfig-001-20231111   gcc  
arm64                 randconfig-002-20231110   gcc  
arm64                 randconfig-002-20231111   gcc  
arm64                 randconfig-003-20231110   gcc  
arm64                 randconfig-003-20231111   gcc  
arm64                 randconfig-004-20231110   gcc  
arm64                 randconfig-004-20231111   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231110   gcc  
csky                  randconfig-002-20231110   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231110   gcc  
i386         buildonly-randconfig-001-20231111   gcc  
i386         buildonly-randconfig-002-20231110   gcc  
i386         buildonly-randconfig-002-20231111   gcc  
i386         buildonly-randconfig-003-20231110   gcc  
i386         buildonly-randconfig-003-20231111   gcc  
i386         buildonly-randconfig-004-20231110   gcc  
i386         buildonly-randconfig-004-20231111   gcc  
i386         buildonly-randconfig-005-20231110   gcc  
i386         buildonly-randconfig-005-20231111   gcc  
i386         buildonly-randconfig-006-20231110   gcc  
i386         buildonly-randconfig-006-20231111   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231110   gcc  
i386                  randconfig-001-20231111   gcc  
i386                  randconfig-002-20231110   gcc  
i386                  randconfig-002-20231111   gcc  
i386                  randconfig-003-20231110   gcc  
i386                  randconfig-003-20231111   gcc  
i386                  randconfig-004-20231110   gcc  
i386                  randconfig-004-20231111   gcc  
i386                  randconfig-005-20231110   gcc  
i386                  randconfig-005-20231111   gcc  
i386                  randconfig-006-20231110   gcc  
i386                  randconfig-006-20231111   gcc  
i386                  randconfig-011-20231110   gcc  
i386                  randconfig-012-20231110   gcc  
i386                  randconfig-013-20231110   gcc  
i386                  randconfig-014-20231110   gcc  
i386                  randconfig-015-20231110   gcc  
i386                  randconfig-016-20231110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231110   gcc  
loongarch             randconfig-002-20231110   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                           gcw0_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231110   gcc  
nios2                 randconfig-002-20231110   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231110   gcc  
parisc                randconfig-002-20231110   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20231110   gcc  
powerpc               randconfig-001-20231111   gcc  
powerpc               randconfig-002-20231110   gcc  
powerpc               randconfig-002-20231111   gcc  
powerpc               randconfig-003-20231110   gcc  
powerpc               randconfig-003-20231111   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm5200_defconfig   clang
powerpc64             randconfig-001-20231110   gcc  
powerpc64             randconfig-001-20231111   gcc  
powerpc64             randconfig-002-20231110   gcc  
powerpc64             randconfig-002-20231111   gcc  
powerpc64             randconfig-003-20231110   gcc  
powerpc64             randconfig-003-20231111   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231110   gcc  
riscv                 randconfig-002-20231110   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231110   gcc  
s390                  randconfig-002-20231110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231110   gcc  
sh                    randconfig-001-20231111   gcc  
sh                    randconfig-002-20231110   gcc  
sh                    randconfig-002-20231111   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231110   gcc  
sparc                 randconfig-001-20231111   gcc  
sparc                 randconfig-002-20231110   gcc  
sparc                 randconfig-002-20231111   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231110   gcc  
sparc64               randconfig-001-20231111   gcc  
sparc64               randconfig-002-20231110   gcc  
sparc64               randconfig-002-20231111   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231110   gcc  
um                    randconfig-001-20231111   gcc  
um                    randconfig-002-20231110   gcc  
um                    randconfig-002-20231111   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231110   gcc  
x86_64       buildonly-randconfig-001-20231111   gcc  
x86_64       buildonly-randconfig-002-20231110   gcc  
x86_64       buildonly-randconfig-002-20231111   gcc  
x86_64       buildonly-randconfig-003-20231110   gcc  
x86_64       buildonly-randconfig-003-20231111   gcc  
x86_64       buildonly-randconfig-004-20231110   gcc  
x86_64       buildonly-randconfig-004-20231111   gcc  
x86_64       buildonly-randconfig-005-20231110   gcc  
x86_64       buildonly-randconfig-005-20231111   gcc  
x86_64       buildonly-randconfig-006-20231110   gcc  
x86_64       buildonly-randconfig-006-20231111   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231110   gcc  
x86_64                randconfig-001-20231111   gcc  
x86_64                randconfig-002-20231110   gcc  
x86_64                randconfig-002-20231111   gcc  
x86_64                randconfig-003-20231110   gcc  
x86_64                randconfig-003-20231111   gcc  
x86_64                randconfig-004-20231110   gcc  
x86_64                randconfig-004-20231111   gcc  
x86_64                randconfig-005-20231110   gcc  
x86_64                randconfig-005-20231111   gcc  
x86_64                randconfig-006-20231110   gcc  
x86_64                randconfig-006-20231111   gcc  
x86_64                randconfig-011-20231110   gcc  
x86_64                randconfig-011-20231111   gcc  
x86_64                randconfig-012-20231110   gcc  
x86_64                randconfig-012-20231111   gcc  
x86_64                randconfig-013-20231110   gcc  
x86_64                randconfig-013-20231111   gcc  
x86_64                randconfig-014-20231110   gcc  
x86_64                randconfig-014-20231111   gcc  
x86_64                randconfig-015-20231110   gcc  
x86_64                randconfig-015-20231111   gcc  
x86_64                randconfig-016-20231110   gcc  
x86_64                randconfig-016-20231111   gcc  
x86_64                randconfig-071-20231110   gcc  
x86_64                randconfig-071-20231111   gcc  
x86_64                randconfig-072-20231110   gcc  
x86_64                randconfig-072-20231111   gcc  
x86_64                randconfig-073-20231110   gcc  
x86_64                randconfig-073-20231111   gcc  
x86_64                randconfig-074-20231110   gcc  
x86_64                randconfig-074-20231111   gcc  
x86_64                randconfig-075-20231110   gcc  
x86_64                randconfig-075-20231111   gcc  
x86_64                randconfig-076-20231110   gcc  
x86_64                randconfig-076-20231111   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                randconfig-001-20231110   gcc  
xtensa                randconfig-001-20231111   gcc  
xtensa                randconfig-002-20231110   gcc  
xtensa                randconfig-002-20231111   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

