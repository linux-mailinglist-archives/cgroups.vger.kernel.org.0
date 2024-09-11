Return-Path: <cgroups+bounces-4849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FE975872
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB2B26D16
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312A1AE87C;
	Wed, 11 Sep 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7sQW9Jk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A61AE872
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072026; cv=none; b=at2305Ikl/RbbwoEu78IHVYqrOZMqfbGxVMNMg6fr+c46WRqkx4gNgVUT8VslM/v6tX5HZPv5pJNVabqU84VNchgmb62Q6Y0VA1Ufvfcqwx85Y0vjKrwQvI5zkWUqe96bpve3pTIqn7/pmYJv4tNEDLO/wPvBpPNbMoQj+KeSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072026; c=relaxed/simple;
	bh=ifrRdkyGljT7OJ4QaVbqwfxQ1qrnnt6mVbdFlSrH9FE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eFwmDAmOJrw+dhjoI+K6DKZiFL9ppzlZ5JqDnVWHvtLs7gwqEh9UbYN9yJyp7myKIdXBYGoA1c2DSTX/JQETkOqU7FKzttSdBHit+HBsEBTDfTyYd6oqG9mgiQTmGRng5zIjZJSOxM9VMA2T2yvRScO3/XlmGKeqo1gSxPTYUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7sQW9Jk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726072025; x=1757608025;
  h=date:from:to:cc:subject:message-id;
  bh=ifrRdkyGljT7OJ4QaVbqwfxQ1qrnnt6mVbdFlSrH9FE=;
  b=L7sQW9Jkt2md3xdFGpOIrpGBeZB/gQH70kO4j05dQnjg1I+Se082PGmo
   lBR9so2OAFsJQQp6iLaeG1Rox98FH4/LtKXGXvfnIBvjzgUh3Y4kekZZf
   0GR4y5zfS6SGCuNpRL2bTZlgc+O7NFzAUZmmxfaInSdqNheiwQR5cFpCF
   CSYUKEdH/sINvIK2fda4fMig7Plc+dTtptOWm94P6k0sJ01JX4KYkkLU0
   azIqIXofdGmoyaOGW+ZfS0XQYsK/LYkpeqC8ETti45rf2RDrFOEZ8+/oP
   2hFFM2nu17Am5x85PVgGX12PbudVwVEbIy9TNNKh/JEHoQsHtw6WofEh+
   A==;
X-CSE-ConnectionGUID: 0rX3aDTyRH+OFjg/0YotOQ==
X-CSE-MsgGUID: uSfLqQKSQvWoRGTZpUjXlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36238435"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="36238435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 09:27:04 -0700
X-CSE-ConnectionGUID: IlWQ4qOIRkKzLYwAj/N8uQ==
X-CSE-MsgGUID: bAxFmLCwSr6nxdCL1VzmeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="71554157"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Sep 2024 09:27:02 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soQBI-0003ps-2h;
	Wed, 11 Sep 2024 16:27:00 +0000
Date: Thu, 12 Sep 2024 00:26:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 df57390127a21e87ca2bf943244362921a382c10
Message-ID: <202409120037.VMjdGL6a-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: df57390127a21e87ca2bf943244362921a382c10  Merge branch 'for-6.12' into for-next

elapsed time: 1113m

configs tested: 193
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              alldefconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                          axs101_defconfig   clang-20
arc                          axs101_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240911   gcc-13.2.0
arc                   randconfig-002-20240911   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                            hisi_defconfig   gcc-14.1.0
arm                            mps2_defconfig   clang-20
arm                       netwinder_defconfig   gcc-14.1.0
arm                   randconfig-001-20240911   gcc-13.2.0
arm                   randconfig-002-20240911   gcc-13.2.0
arm                   randconfig-003-20240911   gcc-13.2.0
arm                   randconfig-004-20240911   gcc-13.2.0
arm                         socfpga_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240911   gcc-13.2.0
arm64                 randconfig-002-20240911   gcc-13.2.0
arm64                 randconfig-003-20240911   gcc-13.2.0
arm64                 randconfig-004-20240911   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240911   gcc-13.2.0
csky                  randconfig-002-20240911   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240911   gcc-13.2.0
hexagon               randconfig-002-20240911   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240911   gcc-12
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   gcc-12
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   gcc-12
i386                  randconfig-003-20240911   gcc-12
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   gcc-12
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   gcc-12
i386                  randconfig-014-20240911   gcc-12
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240911   gcc-13.2.0
loongarch             randconfig-002-20240911   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       alldefconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-20
mips                  decstation_64_defconfig   clang-20
mips                 decstation_r4k_defconfig   clang-20
mips                           ip32_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-14.1.0
mips                malta_qemu_32r6_defconfig   gcc-14.1.0
mips                          rb532_defconfig   clang-20
mips                          rb532_defconfig   gcc-14.1.0
mips                          rm200_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240911   gcc-13.2.0
nios2                 randconfig-002-20240911   gcc-13.2.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240911   gcc-13.2.0
parisc                randconfig-002-20240911   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   clang-20
powerpc                     mpc512x_defconfig   clang-20
powerpc                     mpc512x_defconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                      ppc64e_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-14.1.0
powerpc               randconfig-003-20240911   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   clang-20
powerpc64             randconfig-001-20240911   gcc-13.2.0
powerpc64             randconfig-002-20240911   gcc-13.2.0
powerpc64             randconfig-003-20240911   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   clang-20
riscv                 randconfig-001-20240911   gcc-13.2.0
riscv                 randconfig-002-20240911   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240911   gcc-13.2.0
s390                  randconfig-002-20240911   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                               j2_defconfig   clang-20
sh                    randconfig-001-20240911   gcc-13.2.0
sh                    randconfig-002-20240911   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240911   gcc-13.2.0
sparc64               randconfig-002-20240911   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240911   gcc-13.2.0
um                    randconfig-002-20240911   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240911   clang-18
x86_64       buildonly-randconfig-002-20240911   clang-18
x86_64       buildonly-randconfig-003-20240911   clang-18
x86_64       buildonly-randconfig-004-20240911   clang-18
x86_64       buildonly-randconfig-005-20240911   clang-18
x86_64       buildonly-randconfig-006-20240911   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240911   clang-18
x86_64                randconfig-002-20240911   clang-18
x86_64                randconfig-003-20240911   clang-18
x86_64                randconfig-004-20240911   clang-18
x86_64                randconfig-005-20240911   clang-18
x86_64                randconfig-006-20240911   clang-18
x86_64                randconfig-011-20240911   clang-18
x86_64                randconfig-012-20240911   clang-18
x86_64                randconfig-013-20240911   clang-18
x86_64                randconfig-014-20240911   clang-18
x86_64                randconfig-015-20240911   clang-18
x86_64                randconfig-016-20240911   clang-18
x86_64                randconfig-071-20240911   clang-18
x86_64                randconfig-072-20240911   clang-18
x86_64                randconfig-073-20240911   clang-18
x86_64                randconfig-074-20240911   clang-18
x86_64                randconfig-075-20240911   clang-18
x86_64                randconfig-076-20240911   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   clang-20
xtensa                randconfig-001-20240911   gcc-13.2.0
xtensa                randconfig-002-20240911   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

