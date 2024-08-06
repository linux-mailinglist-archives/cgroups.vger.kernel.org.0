Return-Path: <cgroups+bounces-4105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33565949366
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E7228759D
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB41D47BC;
	Tue,  6 Aug 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwY/8sxV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FCB201273
	for <cgroups@vger.kernel.org>; Tue,  6 Aug 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955182; cv=none; b=HwI3GomWdS44gfZLbv8b9evoD3dWwl9ur1/GOkGl+URIzoie8R/zfVUCz3vk6U3ON1C4Wco4bVqdSEDwbPxWlLjeC7YeavUb3Uo0W383OubsVGR43WL5R4b84sU39TfjCfjtOgiWsPT4JgfFfqMTj3rys5HOAH3a00uPY86ZURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955182; c=relaxed/simple;
	bh=b6DhT85BiD9Uag3/8sVTygKG7cNAypROUFT7bpy4iBw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pQPUtW5cA2CHZUjZqv3Y/srfwwa5krwnZ6IvKBbvweUMq6M9WgnzuYrZ4yg4szW5tm1oxF5FLs/n3pA0kKLUFk0B5p+tL0fDn5TyAH0H3UDL1B5g2xYLBiJuJ1miRx3zEA0sf5gPaugk2Zz7+1ziQwVZXRfpjd4B6KMVXCabU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwY/8sxV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722955181; x=1754491181;
  h=date:from:to:cc:subject:message-id;
  bh=b6DhT85BiD9Uag3/8sVTygKG7cNAypROUFT7bpy4iBw=;
  b=LwY/8sxVfDmpzxRgCwcaewvW6N5BmRk3DdaQZlKGIlkNIy1gl+n7OEyu
   tti6bfGtMbyuEW0kMGU/ayU6gw2rsZEnhJNnHgq/CrKQ4vkObctg03CxC
   qwA6Kf8zMks+rvWNG39RNHa1+FDazhdlBeZS5novVO6Q9bm05TWc7knx6
   gdBpOmQA/Qx9w5et4P4T+L68UVsMjkjcP+Qdk2thcYbIVlOfucGmR1qLh
   DDPryS45Qawk2RddBrY5hj4NaARF2wgVOh+RU7XtjY3iDBxXkG9iAP1Oe
   60XghXSBKV178b7m1KbhafNbUvIZeylFucjO1EfZgNDGRFoBPXvP0W5qb
   A==;
X-CSE-ConnectionGUID: zJXpfXtxRJiWPQYUPIWAFQ==
X-CSE-MsgGUID: jwqfbv4fRNmJVX8t4miSZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32361822"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32361822"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:39:40 -0700
X-CSE-ConnectionGUID: Auco2ELoTSSKIOJ5Ka5mJg==
X-CSE-MsgGUID: fI7/OYSSTbmM7JD8VRTglA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57239867"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2024 07:39:38 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbLLb-0004aW-2h;
	Tue, 06 Aug 2024 14:39:35 +0000
Date: Tue, 06 Aug 2024 22:39:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.12] BUILD SUCCESS
 92841d6e23de09f180f948f99ddb40135775cedc
Message-ID: <202408062219.y2QPJmKy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.12
branch HEAD: 92841d6e23de09f180f948f99ddb40135775cedc  selftest/cgroup: Add new test cases to test_cpuset_prs.sh

elapsed time: 1035m

configs tested: 223
configs skipped: 8

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
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240806   gcc-13.2.0
arc                   randconfig-002-20240806   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   clang-20
arm                          ixp4xx_defconfig   clang-20
arm                         orion5x_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   clang-20
arm                            qcom_defconfig   gcc-13.2.0
arm                   randconfig-001-20240806   clang-20
arm                   randconfig-001-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-14.1.0
arm                   randconfig-003-20240806   gcc-13.2.0
arm                   randconfig-003-20240806   gcc-14.1.0
arm                   randconfig-004-20240806   gcc-13.2.0
arm                   randconfig-004-20240806   gcc-14.1.0
arm                           spitz_defconfig   clang-20
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240806   clang-20
arm64                 randconfig-001-20240806   gcc-13.2.0
arm64                 randconfig-002-20240806   clang-20
arm64                 randconfig-002-20240806   gcc-13.2.0
arm64                 randconfig-003-20240806   clang-14
arm64                 randconfig-003-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-14.1.0
csky                  randconfig-002-20240806   gcc-13.2.0
csky                  randconfig-002-20240806   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240806   clang-20
hexagon               randconfig-002-20240806   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240806   gcc-11
i386         buildonly-randconfig-002-20240806   gcc-11
i386         buildonly-randconfig-003-20240806   gcc-11
i386         buildonly-randconfig-004-20240806   gcc-11
i386         buildonly-randconfig-005-20240806   gcc-11
i386         buildonly-randconfig-006-20240806   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240806   gcc-11
i386                  randconfig-002-20240806   gcc-11
i386                  randconfig-003-20240806   gcc-11
i386                  randconfig-004-20240806   gcc-11
i386                  randconfig-005-20240806   gcc-11
i386                  randconfig-006-20240806   gcc-11
i386                  randconfig-011-20240806   gcc-11
i386                  randconfig-012-20240806   gcc-11
i386                  randconfig-013-20240806   gcc-11
i386                  randconfig-014-20240806   gcc-11
i386                  randconfig-015-20240806   gcc-11
i386                  randconfig-016-20240806   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-14.1.0
loongarch             randconfig-002-20240806   gcc-13.2.0
loongarch             randconfig-002-20240806   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath25_defconfig   clang-20
mips                 decstation_r4k_defconfig   clang-20
mips                          eyeq5_defconfig   clang-20
mips                           ip28_defconfig   gcc-13.2.0
nios2                         10m50_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-14.1.0
nios2                 randconfig-002-20240806   gcc-13.2.0
nios2                 randconfig-002-20240806   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240806   gcc-13.2.0
parisc                randconfig-001-20240806   gcc-14.1.0
parisc                randconfig-002-20240806   gcc-13.2.0
parisc                randconfig-002-20240806   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   clang-20
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   clang-20
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-14.1.0
powerpc               randconfig-003-20240806   clang-20
powerpc               randconfig-003-20240806   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                        warp_defconfig   clang-20
powerpc64             randconfig-001-20240806   gcc-13.2.0
powerpc64             randconfig-001-20240806   gcc-14.1.0
powerpc64             randconfig-002-20240806   clang-16
powerpc64             randconfig-002-20240806   gcc-13.2.0
powerpc64             randconfig-003-20240806   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240806   gcc-13.2.0
riscv                 randconfig-001-20240806   gcc-14.1.0
riscv                 randconfig-002-20240806   clang-20
riscv                 randconfig-002-20240806   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240806   clang-20
s390                  randconfig-001-20240806   gcc-13.2.0
s390                  randconfig-002-20240806   clang-20
s390                  randconfig-002-20240806   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240806   gcc-13.2.0
sh                    randconfig-001-20240806   gcc-14.1.0
sh                    randconfig-002-20240806   gcc-13.2.0
sh                    randconfig-002-20240806   gcc-14.1.0
sh                           se7343_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240806   gcc-13.2.0
sparc64               randconfig-001-20240806   gcc-14.1.0
sparc64               randconfig-002-20240806   gcc-13.2.0
sparc64               randconfig-002-20240806   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240806   clang-20
um                    randconfig-001-20240806   gcc-13.2.0
um                    randconfig-002-20240806   gcc-12
um                    randconfig-002-20240806   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240806   clang-18
x86_64       buildonly-randconfig-002-20240806   clang-18
x86_64       buildonly-randconfig-003-20240806   clang-18
x86_64       buildonly-randconfig-004-20240806   clang-18
x86_64       buildonly-randconfig-005-20240806   clang-18
x86_64       buildonly-randconfig-006-20240806   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240806   clang-18
x86_64                randconfig-002-20240806   clang-18
x86_64                randconfig-003-20240806   clang-18
x86_64                randconfig-004-20240806   clang-18
x86_64                randconfig-005-20240806   clang-18
x86_64                randconfig-006-20240806   clang-18
x86_64                randconfig-011-20240806   clang-18
x86_64                randconfig-012-20240806   clang-18
x86_64                randconfig-013-20240806   clang-18
x86_64                randconfig-014-20240806   clang-18
x86_64                randconfig-015-20240806   clang-18
x86_64                randconfig-016-20240806   clang-18
x86_64                randconfig-071-20240806   clang-18
x86_64                randconfig-072-20240806   clang-18
x86_64                randconfig-073-20240806   clang-18
x86_64                randconfig-074-20240806   clang-18
x86_64                randconfig-075-20240806   clang-18
x86_64                randconfig-076-20240806   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                           alldefconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240806   gcc-13.2.0
xtensa                randconfig-001-20240806   gcc-14.1.0
xtensa                randconfig-002-20240806   gcc-13.2.0
xtensa                randconfig-002-20240806   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

