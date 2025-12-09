Return-Path: <cgroups+bounces-12310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B20CB0F8A
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 118DC30C9227
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DD63043BA;
	Tue,  9 Dec 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nydo1Kz9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C31DDC37
	for <cgroups@vger.kernel.org>; Tue,  9 Dec 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309988; cv=none; b=cuEbVwbQPJu2gI/Z5YEuQvB027oMGmRt196ITE21HdEK8bWA7mHTzdhIroilNiYD5CwLocceYVc0gWS91S75e88RTsf4NTCeZBQgsK4/UEct8hrcPkM4/LjiBwG7dcGq4qe0GokHwxzCPFQmFlmj7cw74D2SoCgp7rxWDcf+XeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309988; c=relaxed/simple;
	bh=DnqLHSz/Q2C4raM1rR5nqg/EP+Ca2UgB8wooDipK1lY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ctF/WiMIS3tjfRvXuBQQgCOM9X/a1YtBck00/Fa//tyJAy0TV/KteKj4ZBVI8BSFtEUBFgBrvuhCUHh9Fvli921CYXcXEDW4xZGycqStVsoT6z5S8CE/Bqx01Znv6lSdn+MLUxCscl7p9xq0/Sp0A2EQNKixnS27SdjnnkjEPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nydo1Kz9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765309987; x=1796845987;
  h=date:from:to:cc:subject:message-id;
  bh=DnqLHSz/Q2C4raM1rR5nqg/EP+Ca2UgB8wooDipK1lY=;
  b=Nydo1Kz9G4iOYq10LBmaZkB9++3kKp3NB8TAB3Yj4GV3T3Jdr3WqhPpV
   ucqsBjIAX8XN0JcbsLDHBBrB6+BfxRNKDIJ0K5nCcoWORnfhz/oUEz8mR
   aZwRVqSCgms3ZtkLTHLFfKjM5Ht15e/ZEqVW0DgqXlu0yMrOhlsqNxH3+
   pqU23etdy5SrHq3MybCDV6kU/HQ0yAIONdSkwnnGK3APG7OhClOrbQEtV
   BhMmpG+FdGEQbaRdz0xyu9W2XHFMF4G1WnzjtJavy9VMjqpF7B55wEQsP
   tiibRCmXdFMC7puD3V4FleWQOuYZ87xeRyIvgjxPseIvnkB0k/le3Kylg
   A==;
X-CSE-ConnectionGUID: PfBtsS+4S3m/0ow8Pe8p/Q==
X-CSE-MsgGUID: m3LRDbyiRTqb3+PklTwYrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67162313"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67162313"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 11:53:07 -0800
X-CSE-ConnectionGUID: FqsTlOrwTn+DWoSg1K5dZA==
X-CSE-MsgGUID: IFHtGjtbRv23kqkt6MvOmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="195389375"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 11:53:06 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT3lf-000000002DU-1YJo;
	Tue, 09 Dec 2025 19:53:03 +0000
Date: Wed, 10 Dec 2025 03:52:52 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19-fixes] BUILD SUCCESS
 3309b63a2281efb72df7621d60cc1246b6286ad3
Message-ID: <202512100345.DJ8LsQ6z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19-fixes
branch HEAD: 3309b63a2281efb72df7621d60cc1246b6286ad3  cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated

elapsed time: 1460m

configs tested: 293
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251209    clang-22
arc                   randconfig-001-20251209    gcc-13.4.0
arc                   randconfig-002-20251209    clang-22
arc                   randconfig-002-20251209    gcc-9.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20251209    clang-19
arm                   randconfig-001-20251209    clang-22
arm                   randconfig-002-20251209    clang-20
arm                   randconfig-002-20251209    clang-22
arm                   randconfig-003-20251209    clang-22
arm                   randconfig-004-20251209    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251209    gcc-8.5.0
arm64                 randconfig-001-20251209    gcc-9.5.0
arm64                 randconfig-002-20251209    gcc-9.5.0
arm64                 randconfig-003-20251209    clang-22
arm64                 randconfig-003-20251209    gcc-9.5.0
arm64                 randconfig-004-20251209    gcc-11.5.0
arm64                 randconfig-004-20251209    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251209    gcc-15.1.0
csky                  randconfig-001-20251209    gcc-9.5.0
csky                  randconfig-002-20251209    gcc-15.1.0
csky                  randconfig-002-20251209    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251209    clang-22
hexagon               randconfig-001-20251210    gcc-10.5.0
hexagon               randconfig-002-20251209    clang-22
hexagon               randconfig-002-20251210    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251209    clang-20
i386        buildonly-randconfig-001-20251209    gcc-14
i386        buildonly-randconfig-002-20251209    clang-20
i386        buildonly-randconfig-002-20251209    gcc-14
i386        buildonly-randconfig-003-20251209    gcc-14
i386        buildonly-randconfig-004-20251209    gcc-14
i386        buildonly-randconfig-005-20251209    gcc-14
i386        buildonly-randconfig-006-20251209    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251209    clang-20
i386                  randconfig-001-20251209    gcc-14
i386                  randconfig-002-20251209    clang-20
i386                  randconfig-003-20251209    clang-20
i386                  randconfig-004-20251209    clang-20
i386                  randconfig-004-20251209    gcc-14
i386                  randconfig-005-20251209    clang-20
i386                  randconfig-005-20251209    gcc-14
i386                  randconfig-006-20251209    clang-20
i386                  randconfig-007-20251209    clang-20
i386                  randconfig-007-20251209    gcc-14
i386                  randconfig-011-20251209    clang-20
i386                  randconfig-011-20251209    gcc-14
i386                  randconfig-012-20251209    clang-20
i386                  randconfig-012-20251209    gcc-14
i386                  randconfig-013-20251209    clang-20
i386                  randconfig-013-20251209    gcc-14
i386                  randconfig-014-20251209    clang-20
i386                  randconfig-014-20251209    gcc-14
i386                  randconfig-015-20251209    clang-20
i386                  randconfig-015-20251209    gcc-14
i386                  randconfig-016-20251209    clang-20
i386                  randconfig-016-20251209    gcc-14
i386                  randconfig-017-20251209    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251209    clang-22
loongarch             randconfig-001-20251210    gcc-10.5.0
loongarch             randconfig-002-20251209    clang-22
loongarch             randconfig-002-20251210    gcc-10.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-22
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251209    gcc-8.5.0
nios2                 randconfig-001-20251210    gcc-10.5.0
nios2                 randconfig-002-20251209    gcc-11.5.0
nios2                 randconfig-002-20251210    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251209    gcc-15.1.0
parisc                randconfig-001-20251209    gcc-8.5.0
parisc                randconfig-002-20251209    gcc-13.4.0
parisc                randconfig-002-20251209    gcc-15.1.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251209    gcc-14.3.0
powerpc               randconfig-001-20251209    gcc-15.1.0
powerpc               randconfig-002-20251209    clang-22
powerpc               randconfig-002-20251209    gcc-15.1.0
powerpc64             randconfig-001-20251209    gcc-14.3.0
powerpc64             randconfig-001-20251209    gcc-15.1.0
powerpc64             randconfig-002-20251209    gcc-15.1.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20251209    clang-22
riscv                 randconfig-001-20251210    clang-22
riscv                 randconfig-002-20251209    clang-18
riscv                 randconfig-002-20251209    clang-22
riscv                 randconfig-002-20251210    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251209    clang-22
s390                  randconfig-001-20251209    gcc-12.5.0
s390                  randconfig-001-20251210    clang-22
s390                  randconfig-002-20251209    clang-22
s390                  randconfig-002-20251209    gcc-12.5.0
s390                  randconfig-002-20251210    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251209    clang-22
sh                    randconfig-001-20251209    gcc-14.3.0
sh                    randconfig-001-20251210    clang-22
sh                    randconfig-002-20251209    clang-22
sh                    randconfig-002-20251209    gcc-13.4.0
sh                    randconfig-002-20251210    clang-22
sh                           sh2007_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251209    gcc-10.5.0
sparc                 randconfig-001-20251209    gcc-11.5.0
sparc                 randconfig-001-20251210    gcc-15.1.0
sparc                 randconfig-002-20251209    gcc-10.5.0
sparc                 randconfig-002-20251209    gcc-15.1.0
sparc                 randconfig-002-20251210    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251209    clang-22
sparc64               randconfig-001-20251209    gcc-10.5.0
sparc64               randconfig-001-20251210    gcc-15.1.0
sparc64               randconfig-002-20251209    clang-20
sparc64               randconfig-002-20251209    gcc-10.5.0
sparc64               randconfig-002-20251210    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251209    gcc-10.5.0
um                    randconfig-001-20251209    gcc-14
um                    randconfig-001-20251210    gcc-15.1.0
um                    randconfig-002-20251209    gcc-10.5.0
um                    randconfig-002-20251209    gcc-14
um                    randconfig-002-20251210    gcc-15.1.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251209    clang-20
x86_64      buildonly-randconfig-001-20251209    gcc-14
x86_64      buildonly-randconfig-002-20251209    gcc-14
x86_64      buildonly-randconfig-003-20251209    gcc-14
x86_64      buildonly-randconfig-004-20251209    clang-20
x86_64      buildonly-randconfig-004-20251209    gcc-14
x86_64      buildonly-randconfig-005-20251209    clang-20
x86_64      buildonly-randconfig-005-20251209    gcc-14
x86_64      buildonly-randconfig-006-20251209    clang-20
x86_64      buildonly-randconfig-006-20251209    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251209    clang-20
x86_64                randconfig-001-20251209    gcc-14
x86_64                randconfig-002-20251209    clang-20
x86_64                randconfig-002-20251209    gcc-14
x86_64                randconfig-003-20251209    clang-20
x86_64                randconfig-003-20251209    gcc-14
x86_64                randconfig-004-20251209    gcc-14
x86_64                randconfig-005-20251209    gcc-14
x86_64                randconfig-006-20251209    gcc-14
x86_64                randconfig-011-20251209    clang-20
x86_64                randconfig-011-20251209    gcc-14
x86_64                randconfig-011-20251210    clang-20
x86_64                randconfig-012-20251209    clang-20
x86_64                randconfig-012-20251210    clang-20
x86_64                randconfig-013-20251209    clang-20
x86_64                randconfig-013-20251209    gcc-14
x86_64                randconfig-013-20251210    clang-20
x86_64                randconfig-014-20251209    clang-20
x86_64                randconfig-014-20251210    clang-20
x86_64                randconfig-015-20251209    clang-20
x86_64                randconfig-015-20251210    clang-20
x86_64                randconfig-016-20251209    clang-20
x86_64                randconfig-016-20251210    clang-20
x86_64                randconfig-071-20251209    clang-20
x86_64                randconfig-072-20251209    gcc-14
x86_64                randconfig-073-20251209    gcc-14
x86_64                randconfig-074-20251209    gcc-14
x86_64                randconfig-075-20251209    gcc-14
x86_64                randconfig-076-20251209    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251209    gcc-10.5.0
xtensa                randconfig-001-20251209    gcc-13.4.0
xtensa                randconfig-001-20251210    gcc-15.1.0
xtensa                randconfig-002-20251209    gcc-10.5.0
xtensa                randconfig-002-20251210    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

