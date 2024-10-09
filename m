Return-Path: <cgroups+bounces-5080-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDB996CD5
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C581C21D7C
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A4199EB0;
	Wed,  9 Oct 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJmijjFU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4D17C220
	for <cgroups@vger.kernel.org>; Wed,  9 Oct 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482098; cv=none; b=DoXt0Naf3qrsEGWn5dDDBF7hEdo6jUPunF0U3tjTUhHapbh6xO1JSLq6HBslY8ymLB0aSk2+MktNhjdmunrxR2FraG6HcPm2PMTKFJ0aJ/oDCLunW5UqWLDH3WJefJmO6sndLA4qpKYrgtTSacTzSdPF0qS4ZCnQJh8DongBSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482098; c=relaxed/simple;
	bh=uhaXZ432YIG+tg5tGMNJlEisYEd01ny0o7+TxkAFb1U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SiqLtU0ocKBHKprC6ljspDwa9FBIIMcaV86kspywwjkWOuLvygrblIE6EKhyJY6OankClzBce4+qWAcm42DSa8mDK2MXXN9qc1WmaAxCj56DmCwXXiM/A4eTRQ+CVieDHABFEctRRKcKBw6Cv21GtqUbBiJrjbnOYKXtmCZ2aoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJmijjFU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728482097; x=1760018097;
  h=date:from:to:cc:subject:message-id;
  bh=uhaXZ432YIG+tg5tGMNJlEisYEd01ny0o7+TxkAFb1U=;
  b=hJmijjFU1mNAKhWZy+2mjlMVd67ve6lmw18vJQ1czqeGgAnzjBUa7cUa
   u0Hj4RxNcv9AGyeWFiXCfTe0Y7rK4FlVC3Gpu5HOphtNBVjSO3GFCcVX/
   u2xT3iE3G+JriPvsmYP+wW7YdOOFaDUJKLqkpbAqlkyr1RvRWHVt7IrNd
   qMYmpR8bD8WeNBCsGae3zX9IbyrGGiNQBnp3rgppTQoolKlzDmsF8ssRC
   iCkSsLid7F+H+SqnPUwfNx0YHjQHCbv/pNsEufJ6w75AvJUliGts2JeXu
   4Seu4Y987EC01guoY75ndplkggwq8ZjykpLFIll0q7Wfb3GJYIpUv/Sm0
   w==;
X-CSE-ConnectionGUID: 0eUWeuB3TaqFTQXVZoP8+A==
X-CSE-MsgGUID: 3oTvggXHTZmwiongVwIbPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27913900"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27913900"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:54:57 -0700
X-CSE-ConnectionGUID: w3TIV1TJTPqTTYKlv/0Uxw==
X-CSE-MsgGUID: IbVozuX5RlWbrHk8C/P8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76480778"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Oct 2024 06:54:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syX9R-0009IC-1F;
	Wed, 09 Oct 2024 13:54:53 +0000
Date: Wed, 09 Oct 2024 21:53:55 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 e53dd32b55e43b963461688c8c87af3251412f18
Message-ID: <202410092142.SiW6jfYW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: e53dd32b55e43b963461688c8c87af3251412f18  Merge branch 'for-6.13' into for-next

elapsed time: 1077m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                           sama5_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241009    clang-18
i386        buildonly-randconfig-002-20241009    clang-18
i386        buildonly-randconfig-003-20241009    clang-18
i386        buildonly-randconfig-004-20241009    clang-18
i386        buildonly-randconfig-005-20241009    clang-18
i386        buildonly-randconfig-006-20241009    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241009    clang-18
i386                  randconfig-002-20241009    clang-18
i386                  randconfig-003-20241009    clang-18
i386                  randconfig-004-20241009    clang-18
i386                  randconfig-005-20241009    clang-18
i386                  randconfig-006-20241009    clang-18
i386                  randconfig-011-20241009    clang-18
i386                  randconfig-012-20241009    clang-18
i386                  randconfig-013-20241009    clang-18
i386                  randconfig-014-20241009    clang-18
i386                  randconfig-015-20241009    clang-18
i386                  randconfig-016-20241009    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                           ci20_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                      malta_kvm_defconfig    gcc-14.1.0
mips                           rs90_defconfig    gcc-14.1.0
mips                           xway_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241009    clang-18
x86_64      buildonly-randconfig-002-20241009    clang-18
x86_64      buildonly-randconfig-003-20241009    clang-18
x86_64      buildonly-randconfig-004-20241009    clang-18
x86_64      buildonly-randconfig-005-20241009    clang-18
x86_64      buildonly-randconfig-006-20241009    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241009    clang-18
x86_64                randconfig-002-20241009    clang-18
x86_64                randconfig-003-20241009    clang-18
x86_64                randconfig-004-20241009    clang-18
x86_64                randconfig-005-20241009    clang-18
x86_64                randconfig-006-20241009    clang-18
x86_64                randconfig-011-20241009    clang-18
x86_64                randconfig-012-20241009    clang-18
x86_64                randconfig-013-20241009    clang-18
x86_64                randconfig-014-20241009    clang-18
x86_64                randconfig-015-20241009    clang-18
x86_64                randconfig-016-20241009    clang-18
x86_64                randconfig-071-20241009    clang-18
x86_64                randconfig-072-20241009    clang-18
x86_64                randconfig-073-20241009    clang-18
x86_64                randconfig-074-20241009    clang-18
x86_64                randconfig-075-20241009    clang-18
x86_64                randconfig-076-20241009    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

