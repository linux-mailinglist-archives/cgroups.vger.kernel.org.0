Return-Path: <cgroups+bounces-8402-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E9AC9B0C
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3397AF853
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507E2367A2;
	Sat, 31 May 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYUy6L3P"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074242AA6
	for <cgroups@vger.kernel.org>; Sat, 31 May 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748695634; cv=none; b=g35eIww8yQsv/oz8S1M53Hcfp8TaN7TJtoAgvwjjxVPMTBjuspceJ70WHvfxmOrtbo0hNmExClNofJN8sVGRn30zcrUf3FXpo/3eJiAgyTYYmSBt25Xd/lkDL3xi9DOLNmh8ZK0S0NSOdJ3XuDZDQ8kv6xYwyg8xSvDyd6UpmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748695634; c=relaxed/simple;
	bh=IpCvejskSGmFBsaksF+sGlDBoZqYeTz7P6SZywt6g6w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oIwNrzlYzDB5mUKxTl+MzowTBiRsaKd0EBHPYB+piO8cNnYVLscWhYbNdDR44bm4hv02vlK4viVXMQBBrcp4Gmntr29EKK/YdWmnG4wF8gsYBcnGWL1TRcBT2w82P68Ln18wzGF0Bn47fQDmxIqM7GO7bXeXm/qsml/i3frVLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYUy6L3P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748695632; x=1780231632;
  h=date:from:to:cc:subject:message-id;
  bh=IpCvejskSGmFBsaksF+sGlDBoZqYeTz7P6SZywt6g6w=;
  b=aYUy6L3Pgm3W617m2ag33Ql2WR18AEKzQf/yP/czEeF58eFOmTGOn1m9
   cea0nsFVKk8D9iOHWeWyoNJampmaIECocKcSaXJdMapKjDhkEcxcQmXfb
   817rEBQCZ/R2zoWJ7UY2SFFCBd+gsSRAANUKbNb6O1nHN3KfKCylimKKD
   7Ddp4Vq9L9C1z4oVhblY9/HrL1Z4wTZzfw23VldC3gOfDjR4sk0Vt6Jfq
   H919dvtHA64DZX5t3q0pKI7rHO03VGlXkfeJyiYX2NsDrYylRjqDhdI4P
   gYpORplfYYeerWRRVsv5CNO1PM5Pz8EM5WYD6RzTASj8MU2bImn6nq5Xj
   Q==;
X-CSE-ConnectionGUID: DpdAXcrCQ4+ZgnXR1s0NhA==
X-CSE-MsgGUID: kQnJ7Fp7RB6HJdCvWYY8tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="62119050"
X-IronPort-AV: E=Sophos;i="6.16,198,1744095600"; 
   d="scan'208";a="62119050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 05:47:10 -0700
X-CSE-ConnectionGUID: 0GrOka5mQnypIh0Zk2t+RQ==
X-CSE-MsgGUID: TGdSYZMwStOQmw9q+ifE8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,198,1744095600"; 
   d="scan'208";a="148002241"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 May 2025 05:47:10 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uLLcB-000YPO-0u;
	Sat, 31 May 2025 12:47:07 +0000
Date: Sat, 31 May 2025 20:46:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 c853d18706de8c9525126b362f747d2e480e93df
Message-ID: <202505312015.OmRaxQlv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: c853d18706de8c9525126b362f747d2e480e93df  cgroup: adjust criteria for rstat subsystem cpu lock access

elapsed time: 727m

configs tested: 185
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
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-21
arm                          ep93xx_defconfig    clang-21
arm                      footbridge_defconfig    gcc-15.1.0
arm                           h3600_defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                       multi_v4t_defconfig    clang-16
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
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250531    gcc-7.5.0
parisc                randconfig-002-20250531    gcc-10.5.0
parisc                randconfig-002-20250531    gcc-7.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                      ep88xc_defconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    clang-21
powerpc                      ppc44x_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250531    gcc-11.5.0
powerpc               randconfig-001-20250531    gcc-7.5.0
powerpc               randconfig-002-20250531    gcc-5.5.0
powerpc               randconfig-002-20250531    gcc-7.5.0
powerpc               randconfig-003-20250531    gcc-7.5.0
powerpc               randconfig-003-20250531    gcc-8.5.0
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250531    clang-21
powerpc64             randconfig-001-20250531    gcc-7.5.0
powerpc64             randconfig-002-20250531    gcc-14.3.0
powerpc64             randconfig-003-20250531    clang-17
powerpc64             randconfig-003-20250531    gcc-7.5.0
riscv                            allmodconfig    clang-21
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
sh                           se7712_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
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

