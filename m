Return-Path: <cgroups+bounces-8403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4DAC9B17
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 14:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4B3B2480
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806323AE60;
	Sat, 31 May 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8E+i7+R"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6F42AA6
	for <cgroups@vger.kernel.org>; Sat, 31 May 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748696233; cv=none; b=SpnhwEf1waIzaiE9I20Hnk7dEqpsnd17RJ7HNyvEhwLAA/nKM9yGubhVl1Kzk6W1FDk8hamBSrHrcljw1LkuNvQOpSL1Vk6V0HkVZRkF2R/ulJ3cLvmzEODm1B4E4fNQnRALMbYLeC8KGQFoytk/CFJk2i1+vNCyhOJlhps11Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748696233; c=relaxed/simple;
	bh=bIKDBY5LgTxiRxS6h5Nq5FCleNizm/wexZmP79hVB1A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CzvI0Ijgh4uV//MrT5NCPpDPtFakV5yjKS/qITkyU3porFvZkqFkq1NacjF6vfm2epWtWcdZiAPrL+j5FWXRQOb40xB3Lre5vJ2/KsF9vytX5dvO0nzsPRyztZRGGtO6hEcfONTO7lGDd2JZzkNyUnj4z9NqWhhV2KMkf2d6h+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8E+i7+R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748696232; x=1780232232;
  h=date:from:to:cc:subject:message-id;
  bh=bIKDBY5LgTxiRxS6h5Nq5FCleNizm/wexZmP79hVB1A=;
  b=P8E+i7+RIWTAQ4rZhX59fKxwL15Jy2fsIGSCb3Qik0bngs+WEhtPxG9r
   SGOElMoh+lWqsuD0pdWXoJRcgRaqehRGyCnqDPa9SPo22ua2InuLd/h4P
   h/PfZfRo4TrwIMiQDbpPHJDIKTsArmxBj05JSoU7BFNVzalVgX8+gk5jV
   nZFTrPJhHBAJ+0a7YFDrMaKA5tinj10VfpHPoZm4uuRC1R/hWjOAgZot0
   kPCJK4n7thBRrjVh0XmvHoITymhFmRJ4GFw9xvMGrydWgBSGITyn4Jsw6
   AEDVoTxg7Viis+JnQwhqttLDZoufGaQk0V8T5LANbP6kNfZWvOb/tX7jg
   w==;
X-CSE-ConnectionGUID: RJKmXLiiSnKXqFQaNDZ+JA==
X-CSE-MsgGUID: kc4aVCdbTKq5jyPECFvQeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50923797"
X-IronPort-AV: E=Sophos;i="6.16,198,1744095600"; 
   d="scan'208";a="50923797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 05:57:11 -0700
X-CSE-ConnectionGUID: fg4waKq4T7W9xI5hYO4LmA==
X-CSE-MsgGUID: l2NL0u9iTqq9amlnLyrI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,198,1744095600"; 
   d="scan'208";a="144145697"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 31 May 2025 05:57:10 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uLLlr-000YPc-3C;
	Sat, 31 May 2025 12:57:07 +0000
Date: Sat, 31 May 2025 20:56:35 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge] BUILD SUCCESS
 32aedcff6b315913ba5fe5e8fea3d44bc7c33be1
Message-ID: <202505312025.3EXAg2Im-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge
branch HEAD: 32aedcff6b315913ba5fe5e8fea3d44bc7c33be1  Merge branch 'for-6.16' into test-merge

elapsed time: 737m

configs tested: 184
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20250531    gcc-15.1.0
arc                   randconfig-002-20250531    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-21
arm                          ep93xx_defconfig    clang-21
arm                      footbridge_defconfig    gcc-15.1.0
arm                           h3600_defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250531    gcc-13.3.0
arm                   randconfig-002-20250531    gcc-13.3.0
arm                   randconfig-003-20250531    gcc-7.5.0
arm                   randconfig-004-20250531    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250531    gcc-10.5.0
arm64                 randconfig-002-20250531    clang-20
arm64                 randconfig-003-20250531    clang-21
arm64                 randconfig-004-20250531    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250531    gcc-12.4.0
csky                  randconfig-001-20250531    gcc-7.5.0
csky                  randconfig-002-20250531    gcc-15.1.0
csky                  randconfig-002-20250531    gcc-7.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250531    clang-21
hexagon               randconfig-001-20250531    gcc-7.5.0
hexagon               randconfig-002-20250531    clang-21
hexagon               randconfig-002-20250531    gcc-7.5.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250531    gcc-12
i386        buildonly-randconfig-002-20250531    gcc-12
i386        buildonly-randconfig-003-20250531    gcc-12
i386        buildonly-randconfig-004-20250531    clang-20
i386        buildonly-randconfig-005-20250531    clang-20
i386        buildonly-randconfig-006-20250531    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250531    clang-20
i386                  randconfig-002-20250531    clang-20
i386                  randconfig-003-20250531    clang-20
i386                  randconfig-004-20250531    clang-20
i386                  randconfig-005-20250531    clang-20
i386                  randconfig-006-20250531    clang-20
i386                  randconfig-007-20250531    clang-20
i386                  randconfig-011-20250531    clang-20
i386                  randconfig-012-20250531    clang-20
i386                  randconfig-013-20250531    clang-20
i386                  randconfig-014-20250531    clang-20
i386                  randconfig-015-20250531    clang-20
i386                  randconfig-016-20250531    clang-20
i386                  randconfig-017-20250531    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250531    gcc-15.1.0
loongarch             randconfig-001-20250531    gcc-7.5.0
loongarch             randconfig-002-20250531    gcc-15.1.0
loongarch             randconfig-002-20250531    gcc-7.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        omega2p_defconfig    gcc-15.1.0
mips                           xway_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250531    gcc-10.5.0
nios2                 randconfig-001-20250531    gcc-7.5.0
nios2                 randconfig-002-20250531    gcc-5.5.0
nios2                 randconfig-002-20250531    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250531    gcc-7.5.0
parisc                randconfig-002-20250531    gcc-10.5.0
parisc                randconfig-002-20250531    gcc-7.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    clang-21
powerpc                      ppc44x_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250531    gcc-11.5.0
powerpc               randconfig-001-20250531    gcc-7.5.0
powerpc               randconfig-002-20250531    gcc-5.5.0
powerpc               randconfig-002-20250531    gcc-7.5.0
powerpc               randconfig-003-20250531    gcc-7.5.0
powerpc               randconfig-003-20250531    gcc-8.5.0
powerpc64             randconfig-001-20250531    clang-21
powerpc64             randconfig-001-20250531    gcc-7.5.0
powerpc64             randconfig-003-20250531    clang-17
powerpc64             randconfig-003-20250531    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250531    gcc-15.1.0
riscv                 randconfig-002-20250531    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250531    gcc-9.3.0
s390                  randconfig-002-20250531    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250531    gcc-15.1.0
sh                    randconfig-002-20250531    gcc-10.5.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250531    gcc-8.5.0
sparc                 randconfig-002-20250531    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250531    gcc-12.4.0
sparc64               randconfig-002-20250531    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250531    gcc-12
um                    randconfig-002-20250531    gcc-11
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250531    clang-20
x86_64      buildonly-randconfig-002-20250531    gcc-12
x86_64      buildonly-randconfig-003-20250531    gcc-12
x86_64      buildonly-randconfig-004-20250531    gcc-12
x86_64      buildonly-randconfig-005-20250531    clang-20
x86_64      buildonly-randconfig-006-20250531    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-071-20250531    clang-20
x86_64                randconfig-072-20250531    clang-20
x86_64                randconfig-073-20250531    clang-20
x86_64                randconfig-074-20250531    clang-20
x86_64                randconfig-075-20250531    clang-20
x86_64                randconfig-076-20250531    clang-20
x86_64                randconfig-077-20250531    clang-20
x86_64                randconfig-078-20250531    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250531    gcc-9.3.0
xtensa                randconfig-002-20250531    gcc-13.3.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

