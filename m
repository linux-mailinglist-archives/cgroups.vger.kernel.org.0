Return-Path: <cgroups+bounces-3684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F93931AC0
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF23F2840E7
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84282D98;
	Mon, 15 Jul 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ2y1z47"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E797A13A
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071279; cv=none; b=Taq61HNizGPneOEykmT6HKu3Nvi1AtBxSfdlCYb8aNN368lf4poEEY/owTg2FYRttqPirZ1fISj9tDHAR68QNRyKYGZQj3I9k59GtCfTt5nH/DXso/e8lq4lcRJHyX3qybcJdQpm+SXupNwvCaD/3fLEPkbc0UV8Hq/lJjB0Sd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071279; c=relaxed/simple;
	bh=vfkF9yPtQjH9HnaD6TOBcrQP+LfVxviBrzbKyDTVWSE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VMvDlsSoISVy4qbyFt9DGLFoiT5DxNbCFkkSWpf+IEL5JEk9R+EiJJXXkCH8XCq3fmF5rQQgCcmKx2ng4BphDpe8k3tmEldsnqS2IHFREREw3Y0Wf+LdB8zxN/U8XzaIUiFeN2n2YY3usxUYdNiWE3Rs7v/seG4XQQn1+bJc1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ2y1z47; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721071277; x=1752607277;
  h=date:from:to:cc:subject:message-id;
  bh=vfkF9yPtQjH9HnaD6TOBcrQP+LfVxviBrzbKyDTVWSE=;
  b=MQ2y1z47f1AqSrXvURTw5ij8to8RovcZRn7bf/8uoVPFXY1DLj/Dl3ui
   ZVI4U3jBvJXCrH6xedq2Ax7Fd6CS4ojRRtpdWn2XmXn5Je5HOXhFTFvqn
   T5dZKfyx8jbgzt1dpghPnNb1LHvhlGsOhuZhMkRWXzuazmtygVJRSRVWS
   3ZVlrp0vi3Pcwh6S2Bxl14k8qMvraczyQaxs+3a1tOGzZvLHilYPl4/g0
   YCP0/YoJWSt5KTVT1M0I56nbYvjsQI7c9tSf9TRW/5dNRQlnvHETb1gw8
   cbm9GWTeMySWnqxwUMrVnzuAGxk+sY2QNHfA02hTNV/yDE7mALr7oPKlD
   Q==;
X-CSE-ConnectionGUID: iVlABopbRwukHSr1HZVn9A==
X-CSE-MsgGUID: VcBB5Oo1RKeH48ddSUJJVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="12560120"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="12560120"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 12:21:17 -0700
X-CSE-ConnectionGUID: 8tde3jF3RaWMGILcPQCfFg==
X-CSE-MsgGUID: 0bdyYf9ISJmmYPMo3P4g6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="53992018"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2024 12:21:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTRG5-000eWC-2q;
	Mon, 15 Jul 2024 19:21:13 +0000
Date: Tue, 16 Jul 2024 03:20:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.11] BUILD SUCCESS
 9283ff5be1510a35356656a6c1efe14f765c936a
Message-ID: <202407160315.CRscp9DE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.11
branch HEAD: 9283ff5be1510a35356656a6c1efe14f765c936a  Merge branch 'for-6.10-fixes' into for-6.11

elapsed time: 851m

configs tested: 223
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240715   gcc-13.2.0
arc                   randconfig-002-20240715   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-19
arm                            mps2_defconfig   clang-19
arm                   randconfig-001-20240715   gcc-13.2.0
arm                   randconfig-002-20240715   gcc-13.2.0
arm                   randconfig-003-20240715   gcc-13.2.0
arm                   randconfig-004-20240715   gcc-13.2.0
arm                           spitz_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240715   gcc-13.2.0
arm64                 randconfig-002-20240715   gcc-13.2.0
arm64                 randconfig-003-20240715   gcc-13.2.0
arm64                 randconfig-004-20240715   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240715   gcc-13.2.0
csky                  randconfig-002-20240715   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240715   clang-18
i386         buildonly-randconfig-002-20240715   clang-18
i386         buildonly-randconfig-003-20240715   gcc-13
i386         buildonly-randconfig-004-20240715   gcc-12
i386         buildonly-randconfig-005-20240715   clang-18
i386         buildonly-randconfig-006-20240715   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240715   gcc-13
i386                  randconfig-002-20240715   clang-18
i386                  randconfig-003-20240715   clang-18
i386                  randconfig-004-20240715   gcc-13
i386                  randconfig-005-20240715   gcc-13
i386                  randconfig-006-20240715   gcc-13
i386                  randconfig-011-20240715   gcc-9
i386                  randconfig-012-20240715   gcc-13
i386                  randconfig-013-20240715   gcc-7
i386                  randconfig-014-20240715   clang-18
i386                  randconfig-015-20240715   clang-18
i386                  randconfig-016-20240715   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240715   gcc-13.2.0
loongarch             randconfig-002-20240715   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   clang-19
mips                           ip27_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   clang-19
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240715   gcc-13.2.0
nios2                 randconfig-002-20240715   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240715   gcc-13.2.0
parisc                randconfig-002-20240715   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                       holly_defconfig   clang-19
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   clang-19
powerpc                       ppc64_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240715   gcc-13.2.0
powerpc               randconfig-002-20240715   gcc-13.2.0
powerpc               randconfig-003-20240715   gcc-13.2.0
powerpc                     redwood_defconfig   clang-19
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                     tqm8555_defconfig   clang-19
powerpc                        warp_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240715   gcc-13.2.0
powerpc64             randconfig-002-20240715   gcc-13.2.0
powerpc64             randconfig-003-20240715   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240715   gcc-13.2.0
riscv                 randconfig-002-20240715   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240715   gcc-13.2.0
s390                  randconfig-002-20240715   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                    randconfig-001-20240715   gcc-13.2.0
sh                    randconfig-002-20240715   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240715   gcc-13.2.0
sparc64               randconfig-002-20240715   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240715   gcc-13.2.0
um                    randconfig-002-20240715   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240715   clang-18
x86_64       buildonly-randconfig-002-20240715   clang-18
x86_64       buildonly-randconfig-002-20240715   gcc-13
x86_64       buildonly-randconfig-003-20240715   clang-18
x86_64       buildonly-randconfig-004-20240715   clang-18
x86_64       buildonly-randconfig-004-20240715   gcc-13
x86_64       buildonly-randconfig-005-20240715   clang-18
x86_64       buildonly-randconfig-005-20240715   gcc-13
x86_64       buildonly-randconfig-006-20240715   clang-18
x86_64       buildonly-randconfig-006-20240715   gcc-8
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240715   clang-18
x86_64                randconfig-001-20240715   gcc-9
x86_64                randconfig-002-20240715   clang-18
x86_64                randconfig-002-20240715   gcc-7
x86_64                randconfig-003-20240715   clang-18
x86_64                randconfig-004-20240715   clang-18
x86_64                randconfig-005-20240715   clang-18
x86_64                randconfig-005-20240715   gcc-11
x86_64                randconfig-006-20240715   clang-18
x86_64                randconfig-011-20240715   clang-18
x86_64                randconfig-011-20240715   gcc-12
x86_64                randconfig-012-20240715   clang-18
x86_64                randconfig-013-20240715   clang-18
x86_64                randconfig-014-20240715   clang-18
x86_64                randconfig-014-20240715   gcc-12
x86_64                randconfig-015-20240715   clang-18
x86_64                randconfig-015-20240715   gcc-10
x86_64                randconfig-016-20240715   clang-18
x86_64                randconfig-016-20240715   gcc-10
x86_64                randconfig-071-20240715   clang-18
x86_64                randconfig-071-20240715   gcc-13
x86_64                randconfig-072-20240715   clang-18
x86_64                randconfig-072-20240715   gcc-13
x86_64                randconfig-073-20240715   clang-18
x86_64                randconfig-073-20240715   gcc-13
x86_64                randconfig-074-20240715   clang-18
x86_64                randconfig-074-20240715   gcc-12
x86_64                randconfig-075-20240715   clang-18
x86_64                randconfig-076-20240715   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240715   gcc-13.2.0
xtensa                randconfig-002-20240715   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

