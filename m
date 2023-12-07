Return-Path: <cgroups+bounces-901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F9809326
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 22:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C331F21091
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38454BE0;
	Thu,  7 Dec 2023 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyVgTM6H"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFACE9
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 13:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701983516; x=1733519516;
  h=date:from:to:cc:subject:message-id;
  bh=LUhIzGYiHgb8LgIjwM5sDwzHmfyR1LbINj29z8RBZtM=;
  b=dyVgTM6HuX1MdROPc5FB4b0x3T1N9J1xRZXoM8M2DGXqG5/hMrVCM4x1
   cYaQci175zF9MKoz/WXZtqk6ZnRL+yralP94mISMIJTfvC3voFSBIyqXq
   Gity8Foan4mRPq8jGt3EHR4JfmIRPck8Gr1TAyJOMEtIt3ee9CtRsuFMA
   9IBqRX4W+xkxPanFxQlaDEC5J5SmZNcVw2YRSws0od/BSrBwYvAPp0YJs
   ilrZmjVg0WtwyLS43WVJTKUI1IfinR/SPn0gbgarsbG/Y1prn9aZ9DfHX
   /p3Ukid+986oIyo5h6WzSG4F1ZxGOIfGV1Edk6ePx8AGU4tqdQH2QrRag
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480506603"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="480506603"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 13:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915706808"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="915706808"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2023 13:11:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBLey-000Cpt-3B;
	Thu, 07 Dec 2023 21:11:52 +0000
Date: Fri, 08 Dec 2023 05:11:51 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.8] BUILD SUCCESS
 3232e7aad11e541da86bbb1fa5ea5737b30bd006
Message-ID: <202312080548.JfQC0hZd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.8
branch HEAD: 3232e7aad11e541da86bbb1fa5ea5737b30bd006  cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check

elapsed time: 1470m

configs tested: 179
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-002-20231207   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                         s3c6400_defconfig   gcc  
arm                         s5pv210_defconfig   clang
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-002-20231207   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231207   clang
hexagon               randconfig-002-20231207   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231207   gcc  
i386         buildonly-randconfig-002-20231207   gcc  
i386         buildonly-randconfig-003-20231207   gcc  
i386         buildonly-randconfig-004-20231207   gcc  
i386         buildonly-randconfig-005-20231207   gcc  
i386         buildonly-randconfig-006-20231207   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231207   gcc  
i386                  randconfig-002-20231207   gcc  
i386                  randconfig-003-20231207   gcc  
i386                  randconfig-004-20231207   gcc  
i386                  randconfig-005-20231207   gcc  
i386                  randconfig-006-20231207   gcc  
i386                  randconfig-011-20231207   clang
i386                  randconfig-012-20231207   clang
i386                  randconfig-013-20231207   clang
i386                  randconfig-014-20231207   clang
i386                  randconfig-015-20231207   clang
i386                  randconfig-016-20231207   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-002-20231207   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-002-20231207   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-002-20231207   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231207   clang
s390                  randconfig-002-20231207   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-002-20231207   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-002-20231207   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231207   gcc  
x86_64       buildonly-randconfig-002-20231207   gcc  
x86_64       buildonly-randconfig-003-20231207   gcc  
x86_64       buildonly-randconfig-004-20231207   gcc  
x86_64       buildonly-randconfig-005-20231207   gcc  
x86_64       buildonly-randconfig-006-20231207   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231207   clang
x86_64                randconfig-002-20231207   clang
x86_64                randconfig-003-20231207   clang
x86_64                randconfig-004-20231207   clang
x86_64                randconfig-005-20231207   clang
x86_64                randconfig-006-20231207   clang
x86_64                randconfig-011-20231207   gcc  
x86_64                randconfig-012-20231207   gcc  
x86_64                randconfig-013-20231207   gcc  
x86_64                randconfig-014-20231207   gcc  
x86_64                randconfig-015-20231207   gcc  
x86_64                randconfig-016-20231207   gcc  
x86_64                randconfig-071-20231207   gcc  
x86_64                randconfig-072-20231207   gcc  
x86_64                randconfig-073-20231207   gcc  
x86_64                randconfig-074-20231207   gcc  
x86_64                randconfig-075-20231207   gcc  
x86_64                randconfig-076-20231207   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-002-20231207   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

