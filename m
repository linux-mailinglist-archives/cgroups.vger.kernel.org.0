Return-Path: <cgroups+bounces-900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DB809325
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 22:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D3A1C20992
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38B524D8;
	Thu,  7 Dec 2023 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieXvoJm8"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD036E9
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 13:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701983455; x=1733519455;
  h=date:from:to:cc:subject:message-id;
  bh=dCAN9a+bo6Oz4nDtoBV2YkOiTpnfb/Ed/acJ5YMj/JI=;
  b=ieXvoJm8erZBZZtS+xPBzXzptubjPz3dzeY/eolhjiObbotBDNhxF2tS
   MTDXTcMkpgwK3Ugf3grCUkWM7wJqcEXfCxShI2NSXICvchd8oZiQzIyf4
   vJ9XurC5o4JgxR2T6LUXlxYCxYJ8pk4mjXnuzidKnEagzoOZxTRT7ORKU
   AQivoUPL2D8gdCrC6mYowKnFW0JCqxyyBExlCmBYldMUgnoQMl5bWhSyP
   7H1neNE7HszJN5iaqMySq0pN2FctTzIBHL/lt5drQ1JSWegCczuPQvYpK
   NhKgRfFObxJ7v0miTfNe07DJ/GoWwDtJ8EIszNPT6TbTnqV5G6emd0MuO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394048210"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="394048210"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 13:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862622993"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="862622993"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2023 13:10:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBLe0-000Cpm-30;
	Thu, 07 Dec 2023 21:10:52 +0000
Date: Fri, 08 Dec 2023 05:10:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 2c0726752750d50547bef426085784178366336e
Message-ID: <202312080520.KDmWO4uR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 2c0726752750d50547bef426085784178366336e  Merge branch 'for-6.8' into for-next

elapsed time: 1468m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arc                              allmodconfig   gcc  
arc                              allyesconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-002-20231207   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                           tegra_defconfig   gcc  
arm                       versatile_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-002-20231207   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
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
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-002-20231207   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                          malta_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-002-20231207   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-002-20231207   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231207   clang
s390                  randconfig-002-20231207   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-002-20231207   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-002-20231207   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
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
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-002-20231207   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

