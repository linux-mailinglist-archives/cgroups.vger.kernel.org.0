Return-Path: <cgroups+bounces-3545-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347DD927DF5
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 21:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580201C22D86
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F76EB5C;
	Thu,  4 Jul 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U49GnfLC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033313CA99
	for <cgroups@vger.kernel.org>; Thu,  4 Jul 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122326; cv=none; b=d1iPq+pipFBQdLNSp893Wxb/h9zXQjTzmWet07U0OfCAMylPFiVeKqCsJhN28t0M2ux56rB978jiQhkdclo2YFwmZl7V2NM9EP4VAlWdMEDSXeeWwUaGIrf0ofaq0wLSSbcphuhO9cEgBnow7IioGDaqY+O3VYKBGTT7x3yfhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122326; c=relaxed/simple;
	bh=pp+xYXbalQhSePo1cBuV140T+1BNHL/VmEMFLygQArs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LIPGmRrW0DeUSxyYOS9Lh4kVoOx2QtgmA3NoqzeBp2wLzRqS/xr03Vd7e6eU12NqWubG1uwjyK+tXhuFl7JUCp+FB5Y0bMdUoAz464l4GdSB5j2Cyt8ZwhJGvzhiKeJTcGPcTalzJFrG7fVrP7sUpn0rVmIw64TO7sjMM9dcq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U49GnfLC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720122324; x=1751658324;
  h=date:from:to:cc:subject:message-id;
  bh=pp+xYXbalQhSePo1cBuV140T+1BNHL/VmEMFLygQArs=;
  b=U49GnfLCkpcnjGfFN5nDfFZNQm/XyGW9PQ1Qxvd64ogwDEwABwTt7Afy
   4cH9ndAEud73ON7Fz88knefAvS17vqyYEZgDU+JeagejnmY6tmFdKDznD
   hIlJwgrZW1Mf1WyJuQz+sFEclvpGncXeyV5o5rEDynxtIiofgorI6MAwG
   a4L3rWsGdd9kdUYDyoda+wYSSRDL0HLqZCflDgj86Ngzk3Cl1ju2d5++f
   6CJ429aQZKuSV9IUCXqER0k5TF+a82tAtuIJVDFuRjFbG9vW+UfPc0nOp
   E53Y/G3q0Mxrw5UtuupaW+txwd4pBLgMnR4R9x8wrx39OBaDjv7DXypcp
   Q==;
X-CSE-ConnectionGUID: /Fs9lonHRnmtJSu9+41t6A==
X-CSE-MsgGUID: VUehvBX3QrWGdvGvG0rLSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="20319194"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="20319194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 12:45:23 -0700
X-CSE-ConnectionGUID: j7jfocAIRSC25LqsTMtAfA==
X-CSE-MsgGUID: Q9P3TXHTTsydNe2x/zWwig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51012645"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Jul 2024 12:45:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPSON-000RNs-1p;
	Thu, 04 Jul 2024 19:45:19 +0000
Date: Fri, 05 Jul 2024 03:44:59 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.10-fixes] BUILD SUCCESS
 57b56d16800e8961278ecff0dc755d46c4575092
Message-ID: <202407050357.ZinGyPD9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.10-fixes
branch HEAD: 57b56d16800e8961278ecff0dc755d46c4575092  cgroup: Protect css->cgroup write under css_set_lock

elapsed time: 1450m

configs tested: 194
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240704   gcc-13.2.0
arc                   randconfig-002-20240704   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                         lpc18xx_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                   randconfig-001-20240704   gcc-13.2.0
arm                   randconfig-002-20240704   gcc-13.2.0
arm                   randconfig-003-20240704   gcc-13.2.0
arm                   randconfig-004-20240704   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240704   gcc-13.2.0
arm64                 randconfig-002-20240704   gcc-13.2.0
arm64                 randconfig-003-20240704   gcc-13.2.0
arm64                 randconfig-004-20240704   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240704   gcc-13.2.0
csky                  randconfig-002-20240704   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240704   clang-18
i386         buildonly-randconfig-002-20240704   clang-18
i386         buildonly-randconfig-002-20240704   gcc-13
i386         buildonly-randconfig-003-20240704   clang-18
i386         buildonly-randconfig-003-20240704   gcc-13
i386         buildonly-randconfig-004-20240704   clang-18
i386         buildonly-randconfig-004-20240704   gcc-12
i386         buildonly-randconfig-005-20240704   clang-18
i386         buildonly-randconfig-005-20240704   gcc-12
i386         buildonly-randconfig-006-20240704   clang-18
i386         buildonly-randconfig-006-20240704   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240704   clang-18
i386                  randconfig-002-20240704   clang-18
i386                  randconfig-002-20240704   gcc-13
i386                  randconfig-003-20240704   clang-18
i386                  randconfig-004-20240704   clang-18
i386                  randconfig-004-20240704   gcc-13
i386                  randconfig-005-20240704   clang-18
i386                  randconfig-006-20240704   clang-18
i386                  randconfig-006-20240704   gcc-12
i386                  randconfig-011-20240704   clang-18
i386                  randconfig-011-20240704   gcc-13
i386                  randconfig-012-20240704   clang-18
i386                  randconfig-013-20240704   clang-18
i386                  randconfig-014-20240704   clang-18
i386                  randconfig-015-20240704   clang-18
i386                  randconfig-016-20240704   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240704   gcc-13.2.0
loongarch             randconfig-002-20240704   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                       bvme6000_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5307c3_defconfig   gcc-13.2.0
microblaze                       alldefconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           ip22_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240704   gcc-13.2.0
nios2                 randconfig-002-20240704   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240704   gcc-13.2.0
parisc                randconfig-002-20240704   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240704   gcc-13.2.0
powerpc64             randconfig-001-20240704   gcc-13.2.0
powerpc64             randconfig-002-20240704   gcc-13.2.0
powerpc64             randconfig-003-20240704   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240704   gcc-13.2.0
riscv                 randconfig-002-20240704   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                          debug_defconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240704   gcc-13.2.0
s390                  randconfig-002-20240704   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                             espt_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240704   gcc-13.2.0
sh                    randconfig-002-20240704   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7750_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240704   gcc-13.2.0
sparc64               randconfig-002-20240704   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240704   gcc-13.2.0
um                    randconfig-002-20240704   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240704   clang-18
x86_64       buildonly-randconfig-002-20240704   clang-18
x86_64       buildonly-randconfig-003-20240704   clang-18
x86_64       buildonly-randconfig-004-20240704   clang-18
x86_64       buildonly-randconfig-005-20240704   clang-18
x86_64       buildonly-randconfig-006-20240704   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240704   clang-18
x86_64                randconfig-002-20240704   clang-18
x86_64                randconfig-003-20240704   clang-18
x86_64                randconfig-004-20240704   clang-18
x86_64                randconfig-005-20240704   clang-18
x86_64                randconfig-006-20240704   clang-18
x86_64                randconfig-011-20240704   clang-18
x86_64                randconfig-012-20240704   clang-18
x86_64                randconfig-013-20240704   clang-18
x86_64                randconfig-014-20240704   clang-18
x86_64                randconfig-015-20240704   clang-18
x86_64                randconfig-016-20240704   clang-18
x86_64                randconfig-071-20240704   clang-18
x86_64                randconfig-072-20240704   clang-18
x86_64                randconfig-073-20240704   clang-18
x86_64                randconfig-074-20240704   clang-18
x86_64                randconfig-075-20240704   clang-18
x86_64                randconfig-076-20240704   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240704   gcc-13.2.0
xtensa                randconfig-002-20240704   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

