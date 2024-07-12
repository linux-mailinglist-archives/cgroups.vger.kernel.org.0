Return-Path: <cgroups+bounces-3651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F292F9D6
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8D41F230CB
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159816CD04;
	Fri, 12 Jul 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXlikidg"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348115AADE
	for <cgroups@vger.kernel.org>; Fri, 12 Jul 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785685; cv=none; b=E1U0o1f42OBRrAsATYEgh3yNDy+jH+07g8stjqPLV1f/o0ycZBPOu/0dLXQg3Ts5zSrsaPJ7iljVPqPbXOtOOVZQ3gLEqmv5o94ErkVkyMH0aewlr+s0W0/SyfBZvsS1PjBUbvMOw/oU4JcGnTuFhgJ3/wh9409z04fpjIr+lpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785685; c=relaxed/simple;
	bh=764izfXaEl5205oUBMmRGQt0VZtRWIQmu2RbgXZqTyo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=swZlP+Uy6UFHduhZI3u+ikcSpUCO36I8LmN0nSL2LOyTr6ZI5Uv+iEffBJ5HizGpVm+nmjEEjTY0fSjUv3Uoo5VGQgU8casF+1Vv1nsIC2+5t96Difddp6HUuOBeWKhS4XEqD6j8DuZLSgGO1gKOdmC0ENefCEtyjVhnBK9T4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXlikidg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720785684; x=1752321684;
  h=date:from:to:cc:subject:message-id;
  bh=764izfXaEl5205oUBMmRGQt0VZtRWIQmu2RbgXZqTyo=;
  b=EXlikidg0eGly5Ka32FqRoKcihmsDkD20zZ4WbCj+MQJGTNZZNohgc0E
   0zijGqJS3sKVRd9xwiNqoKJvzC25khnEpEkJWrBXLNaRqUFhCXmv2SG+F
   NnM0xidc1ImrQlTAmKyZALRuCb1uBGDqllWZ3CngkGnOYQna+F8ALyNFq
   0e/I0jgMLAqOGfkgCb/0CXZDOBGJvyZaGht2IaHz3UYMHmG+W5OoXNIoA
   uKHxCmxIONxeloQalf9VNAkT1Vi856UwJUFEzRFv1++7FDg0afXpWDelW
   U5+8S2vtFmNdU77Yybre2jTKmgZXyjzTw7x7SE7NwWidrux5o8s7ujfzQ
   w==;
X-CSE-ConnectionGUID: n1GAJk4QS5uHrribXM15xQ==
X-CSE-MsgGUID: qHtoQ5XOQI6PXD76XogzMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29617031"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29617031"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 05:01:24 -0700
X-CSE-ConnectionGUID: BjcZmrUeSz6u7nXT/jA0zQ==
X-CSE-MsgGUID: +4GKl1HCRgOpEyqyuXzB/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="54076239"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Jul 2024 05:01:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSExk-000ajT-1D;
	Fri, 12 Jul 2024 12:01:20 +0000
Date: Fri, 12 Jul 2024 20:00:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 c29c4ba1e9858cd9431ffc1f51c2686b6b43a169
Message-ID: <202407122028.4INKaKRe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: c29c4ba1e9858cd9431ffc1f51c2686b6b43a169  Merge branch 'for-6.11' into for-next

elapsed time: 1056m

configs tested: 204
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   clang-17
arm                         lpc18xx_defconfig   clang-17
arm                   milbeaut_m10v_defconfig   gcc-13.2.0
arm                        multi_v7_defconfig   clang-17
arm                        multi_v7_defconfig   gcc-13.2.0
arm                   randconfig-001-20240712   gcc-13.2.0
arm                   randconfig-002-20240712   gcc-13.2.0
arm                   randconfig-003-20240712   gcc-13.2.0
arm                   randconfig-004-20240712   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-13.2.0
arm                           stm32_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240712   gcc-13.2.0
arm64                 randconfig-002-20240712   gcc-13.2.0
arm64                 randconfig-003-20240712   gcc-13.2.0
arm64                 randconfig-004-20240712   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240712   gcc-13.2.0
csky                  randconfig-002-20240712   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-002-20240712   gcc-9
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-003-20240712   gcc-9
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-004-20240712   gcc-9
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-005-20240712   gcc-9
i386         buildonly-randconfig-006-20240712   clang-18
i386         buildonly-randconfig-006-20240712   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-001-20240712   gcc-9
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-002-20240712   gcc-9
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-003-20240712   gcc-9
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-004-20240712   gcc-9
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-005-20240712   gcc-9
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-006-20240712   gcc-9
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-011-20240712   gcc-9
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-012-20240712   gcc-9
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-013-20240712   gcc-9
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-014-20240712   gcc-9
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-9
i386                  randconfig-016-20240712   gcc-12
i386                  randconfig-016-20240712   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240712   gcc-13.2.0
loongarch             randconfig-002-20240712   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath79_defconfig   clang-17
mips                           ci20_defconfig   clang-17
mips                           ip27_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   clang-17
nios2                            alldefconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240712   gcc-13.2.0
nios2                 randconfig-002-20240712   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-13.2.0
parisc                randconfig-002-20240712   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        fsp2_defconfig   clang-17
powerpc                 mpc8313_rdb_defconfig   clang-17
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240712   gcc-13.2.0
powerpc               randconfig-002-20240712   gcc-13.2.0
powerpc               randconfig-003-20240712   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64                        alldefconfig   clang-17
powerpc64             randconfig-001-20240712   gcc-13.2.0
powerpc64             randconfig-002-20240712   gcc-13.2.0
powerpc64             randconfig-003-20240712   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240712   gcc-13.2.0
riscv                 randconfig-002-20240712   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240712   gcc-13.2.0
s390                  randconfig-002-20240712   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-17
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240712   gcc-13.2.0
sh                    randconfig-002-20240712   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-13.2.0
sparc64               randconfig-002-20240712   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240712   gcc-13.2.0
um                    randconfig-002-20240712   gcc-13.2.0
um                           x86_64_defconfig   clang-17
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   clang-18
x86_64                randconfig-002-20240712   clang-18
x86_64                randconfig-003-20240712   clang-18
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   clang-18
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   clang-18
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   clang-18
x86_64                randconfig-072-20240712   clang-18
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   clang-18
x86_64                randconfig-075-20240712   clang-18
x86_64                randconfig-076-20240712   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240712   gcc-13.2.0
xtensa                randconfig-002-20240712   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

