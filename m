Return-Path: <cgroups+bounces-13137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76044D17373
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 09:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3792C301B826
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEF378D83;
	Tue, 13 Jan 2026 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yo5on3y9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0830FC03
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291719; cv=none; b=AN3f+pN8r+bjS58kDAcyWDuTQUPjyu5hx1t1Ewm67qEbpCZKzYSS3w8vnhnAxpZAvRbIYLmx+1dIbhIOfirSVsSpYEYIWzDAw/hf5KDCnLNuHmc5JnOG1PYc1dpXkSDtboD5igxD1RTPAMhLCB0P06Z1BLxWMYCl8AKwIgFrXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291719; c=relaxed/simple;
	bh=QXefM53yPRIyPEeoS/wUaKSXURu/KeFmqsk5/Euy25U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DTTpCNwb+cnQ1WOnFUs8s9Ic8Kni6uL3nQTR9NH3c/7ePA5IwijbWVfDKTrf74VhvbGkbU688cwf80vn49Y9Vcs95WPDOmsYCUdFMWbzbHPiEMigtom+N9/Xw9hro3fXVw1MG2+euOOuSewcsi1heEjwziTK3L9JQ//u9Gh8gRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yo5on3y9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768291717; x=1799827717;
  h=date:from:to:cc:subject:message-id;
  bh=QXefM53yPRIyPEeoS/wUaKSXURu/KeFmqsk5/Euy25U=;
  b=Yo5on3y9xUwnVMb6WXoo+PRd3lOjjcSfWZjcFuIMosowbOirq3GDs5dR
   V4pU0D02NNXcXUheoSt9g/SdHpR6jyrK9nGtDfSSI2SCy7iRYFWtnmwXZ
   l8tjUh5UB7EJ/EjtsFlqBlNgQqQXhdV+afsd9HPY25oSnkWwd0cQkULNF
   sKtqBzFVNj/riP9YtGdnIb4471oALRFz2PJ3ISh4NHGR7zaP9C8b7cZXV
   DkxUha7CXRAyRfn/eGwJuh32ynBkcvxiGUwYCBtVd6Qbt9KNEB5ETewyF
   t+cq94nezZXPthVEJkPmHbAqogzJ/BzEheUk0ct5hXoNm0EAjsUz7FF63
   g==;
X-CSE-ConnectionGUID: jw9oM/9IRvGOSWecetMgKQ==
X-CSE-MsgGUID: 9Y/l6MteQX20cAcjojWlAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73203488"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="73203488"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:08:37 -0800
X-CSE-ConnectionGUID: sIB9QY9QQPm6gu+aCyOKHg==
X-CSE-MsgGUID: muRpTB8+TUS8qH5mi7y7dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204604815"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jan 2026 00:08:35 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfZS5-00000000EQ6-18Kp;
	Tue, 13 Jan 2026 08:08:33 +0000
Date: Tue, 13 Jan 2026 16:07:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 53552add1a7c81e218770935b0d72fee978d83e7
Message-ID: <202601131628.5367nn2U-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 53552add1a7c81e218770935b0d72fee978d83e7  Merge branch 'for-6.20' into for-next

elapsed time: 734m

configs tested: 214
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260113    clang-22
arc                   randconfig-002-20260113    clang-22
arc                           tb10x_defconfig    gcc-15.2.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    clang-22
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    clang-22
arm                   randconfig-001-20260113    clang-22
arm                   randconfig-002-20260113    clang-22
arm                   randconfig-003-20260113    clang-22
arm                   randconfig-004-20260113    clang-22
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260113    clang-22
arm64                 randconfig-002-20260113    clang-22
arm64                 randconfig-003-20260113    clang-22
arm64                 randconfig-004-20260113    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260113    clang-22
csky                  randconfig-002-20260113    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260113    clang-22
hexagon               randconfig-002-20260113    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260113    clang-20
i386        buildonly-randconfig-002-20260113    clang-20
i386        buildonly-randconfig-003-20260113    clang-20
i386        buildonly-randconfig-004-20260113    clang-20
i386        buildonly-randconfig-005-20260113    clang-20
i386        buildonly-randconfig-006-20260113    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260113    clang-20
i386                  randconfig-002-20260113    clang-20
i386                  randconfig-003-20260113    clang-20
i386                  randconfig-004-20260113    clang-20
i386                  randconfig-005-20260113    clang-20
i386                  randconfig-006-20260113    clang-20
i386                  randconfig-007-20260113    clang-20
i386                  randconfig-011-20260113    gcc-14
i386                  randconfig-012-20260113    gcc-14
i386                  randconfig-013-20260113    gcc-14
i386                  randconfig-014-20260113    gcc-14
i386                  randconfig-015-20260113    gcc-14
i386                  randconfig-016-20260113    gcc-14
i386                  randconfig-017-20260113    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260113    clang-22
loongarch             randconfig-002-20260113    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    clang-22
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                           ip30_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-22
mips                           rs90_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260113    clang-22
nios2                 randconfig-002-20260113    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260113    clang-19
parisc                randconfig-002-20260113    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      arches_defconfig    clang-22
powerpc                  iss476-smp_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                     mpc512x_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc                       ppc64_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260113    clang-19
powerpc               randconfig-002-20260113    clang-19
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc                        warp_defconfig    clang-22
powerpc64             randconfig-001-20260113    clang-19
powerpc64             randconfig-002-20260113    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20260113    gcc-15.2.0
riscv                 randconfig-002-20260113    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260113    gcc-15.2.0
s390                  randconfig-002-20260113    gcc-15.2.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                               j2_defconfig    clang-22
sh                          landisk_defconfig    gcc-15.2.0
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260113    gcc-15.2.0
sh                    randconfig-002-20260113    gcc-15.2.0
sh                      rts7751r2d1_defconfig    clang-22
sh                           se7705_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    clang-22
sh                              ul2_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260113    gcc-14.3.0
sparc                 randconfig-002-20260113    gcc-14.3.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260113    gcc-14.3.0
sparc64               randconfig-002-20260113    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260113    gcc-14.3.0
um                    randconfig-002-20260113    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260113    clang-20
x86_64      buildonly-randconfig-002-20260113    clang-20
x86_64      buildonly-randconfig-003-20260113    clang-20
x86_64      buildonly-randconfig-004-20260113    clang-20
x86_64      buildonly-randconfig-005-20260113    clang-20
x86_64      buildonly-randconfig-006-20260113    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260113    gcc-14
x86_64                randconfig-002-20260113    gcc-14
x86_64                randconfig-003-20260113    gcc-14
x86_64                randconfig-004-20260113    gcc-14
x86_64                randconfig-005-20260113    gcc-14
x86_64                randconfig-006-20260113    gcc-14
x86_64                randconfig-011-20260113    clang-20
x86_64                randconfig-012-20260113    clang-20
x86_64                randconfig-013-20260113    clang-20
x86_64                randconfig-014-20260113    clang-20
x86_64                randconfig-015-20260113    clang-20
x86_64                randconfig-016-20260113    clang-20
x86_64                randconfig-071-20260113    clang-20
x86_64                randconfig-072-20260113    clang-20
x86_64                randconfig-073-20260113    clang-20
x86_64                randconfig-074-20260113    clang-20
x86_64                randconfig-075-20260113    clang-20
x86_64                randconfig-076-20260113    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260113    gcc-14.3.0
xtensa                randconfig-002-20260113    gcc-14.3.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

