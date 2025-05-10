Return-Path: <cgroups+bounces-8126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B86AB24DA
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FDE7ACB6C
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7122F392;
	Sat, 10 May 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2L1iSwr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEE1428E7
	for <cgroups@vger.kernel.org>; Sat, 10 May 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746899147; cv=none; b=VpyVuaGH47Bs8sSRCQP8iP/ivbEBLAD0W8DHiKG3B5kq02yC4pVz3Gp8+MMRnBVzr2Zj0trypET2nL6k7xvwbMVI9L6pc5gXbUJEwxznNpDwZcObUK0VjRJQyEvUoLzlNRePPL8GH9r3RYvspyhS6MlIq47BxtiI8HER9ehoM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746899147; c=relaxed/simple;
	bh=txTf8J7PU3WeiTwyjVfyZozomNNRMQ/alcXvM3wGSGA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iLAbN85Q15o/FCY6q/5BHcWl4zo0D5ZxOIWvWunfcUJrYxBHk1y1LfpRn9g8G2n95JP+yhDNqi5kGsZxeTXesNKvQkKfxCxFhXHk6HWF3b12vybgEJgVmwHtT83fXwSZslIXXemMirpy3OflMIebaDdYx/+JOklh1C23Llbu4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2L1iSwr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746899145; x=1778435145;
  h=date:from:to:cc:subject:message-id;
  bh=txTf8J7PU3WeiTwyjVfyZozomNNRMQ/alcXvM3wGSGA=;
  b=Z2L1iSwroElQjA/5wOaVwScADGDjHYZqwXAs5Ff73Gpb5WsJtGsZP3UV
   GvPP1LohSgiDBCrSDM2xNinmZAXnQDPv2ShCXgwg1WI+AT8LGxC8YQULC
   6VHw9OkfNEyB+1XYi2zcbRfYCaewy0SIAsoDzwRTeiVLaObX+2kHcquBT
   Z6aoKyNWam7IiKnteOCICIvMI4Zed9VLDInfgr75J7/2p8rayYyV8lbwq
   1Je/+JNnWPmuphjpcUXv3r8Blojq5SYglTBsOnXYpWNHgU86fnFiQJS29
   8fupG/dtXid/3XlOB+uHB4xu0LZ+WndnbZqgYsft7J4kJ96zRpid5bZyI
   A==;
X-CSE-ConnectionGUID: Gemq6QcDSEOjd/Ur2C12Ew==
X-CSE-MsgGUID: O7u0S6g6SOaC6WbXXVvmGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="60128803"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="60128803"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 10:45:45 -0700
X-CSE-ConnectionGUID: DL/ee6I6T9u9TYsuBLgXag==
X-CSE-MsgGUID: AK3Ik2qrQmOydqGzzTp/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142025804"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 May 2025 10:45:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDoGb-000DFX-0P;
	Sat, 10 May 2025 17:45:41 +0000
Date: Sun, 11 May 2025 01:45:26 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.16] BUILD SUCCESS
 c8e7e056366a9d56fb1c3af2616aca2a63f9bacc
Message-ID: <202505110112.q4gbCrwK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16
branch HEAD: c8e7e056366a9d56fb1c3af2616aca2a63f9bacc  include/cgroup: separate {get,put}_cgroup_ns no-op case

elapsed time: 1373m

configs tested: 252
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250510    gcc-14.2.0
arc                   randconfig-001-20250510    gcc-7.5.0
arc                   randconfig-001-20250510    gcc-8.5.0
arc                   randconfig-002-20250510    gcc-13.3.0
arc                   randconfig-002-20250510    gcc-7.5.0
arc                   randconfig-002-20250510    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250510    gcc-10.5.0
arm                   randconfig-001-20250510    gcc-7.5.0
arm                   randconfig-001-20250510    gcc-8.5.0
arm                   randconfig-002-20250510    clang-21
arm                   randconfig-002-20250510    gcc-7.5.0
arm                   randconfig-002-20250510    gcc-8.5.0
arm                   randconfig-003-20250510    gcc-10.5.0
arm                   randconfig-003-20250510    gcc-7.5.0
arm                   randconfig-003-20250510    gcc-8.5.0
arm                   randconfig-004-20250510    gcc-7.5.0
arm                   randconfig-004-20250510    gcc-8.5.0
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250510    gcc-7.5.0
arm64                 randconfig-001-20250510    gcc-8.5.0
arm64                 randconfig-002-20250510    gcc-5.5.0
arm64                 randconfig-002-20250510    gcc-7.5.0
arm64                 randconfig-002-20250510    gcc-8.5.0
arm64                 randconfig-003-20250510    clang-21
arm64                 randconfig-003-20250510    gcc-7.5.0
arm64                 randconfig-003-20250510    gcc-8.5.0
arm64                 randconfig-004-20250510    gcc-7.5.0
arm64                 randconfig-004-20250510    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250510    clang-18
csky                  randconfig-001-20250510    gcc-14.2.0
csky                  randconfig-002-20250510    clang-18
csky                  randconfig-002-20250510    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250510    clang-18
hexagon               randconfig-001-20250510    clang-21
hexagon               randconfig-002-20250510    clang-18
hexagon               randconfig-002-20250510    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250510    gcc-12
i386        buildonly-randconfig-002-20250510    gcc-12
i386        buildonly-randconfig-003-20250510    gcc-12
i386        buildonly-randconfig-004-20250510    gcc-12
i386        buildonly-randconfig-005-20250510    gcc-12
i386        buildonly-randconfig-006-20250510    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250510    gcc-12
i386                  randconfig-002-20250510    gcc-12
i386                  randconfig-003-20250510    gcc-12
i386                  randconfig-004-20250510    gcc-12
i386                  randconfig-005-20250510    gcc-12
i386                  randconfig-006-20250510    gcc-12
i386                  randconfig-007-20250510    gcc-12
i386                  randconfig-011-20250510    clang-20
i386                  randconfig-012-20250510    clang-20
i386                  randconfig-013-20250510    clang-20
i386                  randconfig-014-20250510    clang-20
i386                  randconfig-015-20250510    clang-20
i386                  randconfig-016-20250510    clang-20
i386                  randconfig-017-20250510    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250510    clang-18
loongarch             randconfig-001-20250510    gcc-13.3.0
loongarch             randconfig-002-20250510    clang-18
loongarch             randconfig-002-20250510    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    gcc-14.2.0
mips                           ip22_defconfig    clang-21
mips                           mtx1_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-21
mips                        omega2p_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250510    clang-18
nios2                 randconfig-001-20250510    gcc-11.5.0
nios2                 randconfig-002-20250510    clang-18
nios2                 randconfig-002-20250510    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250510    clang-18
parisc                randconfig-001-20250510    gcc-6.5.0
parisc                randconfig-002-20250510    clang-18
parisc                randconfig-002-20250510    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-21
powerpc                       eiger_defconfig    clang-21
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                      ppc64e_defconfig    clang-21
powerpc               randconfig-001-20250510    clang-18
powerpc               randconfig-001-20250510    gcc-7.5.0
powerpc               randconfig-002-20250510    clang-17
powerpc               randconfig-002-20250510    clang-18
powerpc               randconfig-003-20250510    clang-18
powerpc               randconfig-003-20250510    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250510    clang-18
powerpc64             randconfig-002-20250510    clang-18
powerpc64             randconfig-002-20250510    gcc-10.5.0
powerpc64             randconfig-003-20250510    clang-18
powerpc64             randconfig-003-20250510    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250510    clang-21
riscv                 randconfig-001-20250510    gcc-14.2.0
riscv                 randconfig-002-20250510    clang-21
riscv                 randconfig-002-20250510    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250510    clang-21
s390                  randconfig-001-20250510    gcc-7.5.0
s390                  randconfig-002-20250510    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-21
sh                            hp6xx_defconfig    gcc-14.2.0
sh                            migor_defconfig    clang-21
sh                    randconfig-001-20250510    clang-21
sh                    randconfig-001-20250510    gcc-9.3.0
sh                    randconfig-002-20250510    clang-21
sh                    randconfig-002-20250510    gcc-11.5.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250510    clang-21
sparc                 randconfig-001-20250510    gcc-12.4.0
sparc                 randconfig-002-20250510    clang-21
sparc                 randconfig-002-20250510    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250510    clang-21
sparc64               randconfig-001-20250510    gcc-10.5.0
sparc64               randconfig-002-20250510    clang-21
sparc64               randconfig-002-20250510    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250510    clang-21
um                    randconfig-001-20250510    gcc-12
um                    randconfig-002-20250510    clang-21
um                    randconfig-002-20250510    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250510    clang-20
x86_64      buildonly-randconfig-002-20250510    clang-20
x86_64      buildonly-randconfig-003-20250510    clang-20
x86_64      buildonly-randconfig-003-20250510    gcc-12
x86_64      buildonly-randconfig-004-20250510    clang-20
x86_64      buildonly-randconfig-004-20250510    gcc-11
x86_64      buildonly-randconfig-005-20250510    clang-20
x86_64      buildonly-randconfig-005-20250510    gcc-12
x86_64      buildonly-randconfig-006-20250510    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250510    clang-20
x86_64                randconfig-002-20250510    clang-20
x86_64                randconfig-003-20250510    clang-20
x86_64                randconfig-004-20250510    clang-20
x86_64                randconfig-005-20250510    clang-20
x86_64                randconfig-006-20250510    clang-20
x86_64                randconfig-007-20250510    clang-20
x86_64                randconfig-008-20250510    clang-20
x86_64                randconfig-071-20250510    gcc-11
x86_64                randconfig-072-20250510    gcc-11
x86_64                randconfig-073-20250510    gcc-11
x86_64                randconfig-074-20250510    gcc-11
x86_64                randconfig-075-20250510    gcc-11
x86_64                randconfig-076-20250510    gcc-11
x86_64                randconfig-077-20250510    gcc-11
x86_64                randconfig-078-20250510    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250510    clang-21
xtensa                randconfig-001-20250510    gcc-8.5.0
xtensa                randconfig-002-20250510    clang-21
xtensa                randconfig-002-20250510    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

