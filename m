Return-Path: <cgroups+bounces-3557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796F92929E
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962531F22115
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423560B8A;
	Sat,  6 Jul 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8sOpErX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0473440
	for <cgroups@vger.kernel.org>; Sat,  6 Jul 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262564; cv=none; b=Ud60TnKJ5swxFCww3NeVy2WF1k8uwVg1XyAZcxVuWzY1FJ8Joj3ni8Iml2Zsw+q/jUvFPKvpE7QipE1Ey8tqST9PR8H8FMUo36U/2+zJLf5XniE4XDJ4XnxGmDjnwShqc+RvmUIGVq5n202iwBiNMGtJiSPLLF2VxGSLp2U2cKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262564; c=relaxed/simple;
	bh=R7E4lhVEe5Nko9jCMC0TS/1+NpVCxBJ0SL4+8zk9ZPc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MLAnap/Yl2EcJalR5fTrmkh6c+lHhKJeX9qTiWJ2Z49m4suNqNULqoY0VYL3sYIc0AQyYOBGIL4oDrq41OADEkPA99lg+qA6EadmzuaVD2dTP9Cl8Bdew2JipAeLhKQgUo6jm3gueiPN3enAuaZ0Nr1haMkxmxtDkGw0j6jZTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8sOpErX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720262562; x=1751798562;
  h=date:from:to:cc:subject:message-id;
  bh=R7E4lhVEe5Nko9jCMC0TS/1+NpVCxBJ0SL4+8zk9ZPc=;
  b=E8sOpErXGXmzbT8AfdlzRflF8jZjqMGC9XSufptoBWe0yIj0U0dCmqGD
   STGrNKOb0fuHI37L1PMAtxIzMnvSoHb87B27f2FfSC5MdUyWd5HfnB4FR
   E6nrcidrAIbXCHA3ThAst6M4HV98C1XJ967X94JPhhB1MF1yvBn521o+x
   /rMBJqV49DjPTV2z7tVwgccOZrMBkLYbg/3RSjc1jUZF3uLP5ZzKFz4li
   DY5hKIKuOy8WPmAKPYXMBAlyeYpuWfvQZvIa86DAJT7WW2VVNfSIj6kXu
   d35ZIXUfGNd3TnHWBE/rg9S8nQx0aa4xJjiMb9hHN7zXUmBjAj9MPy7qK
   Q==;
X-CSE-ConnectionGUID: n2ayH2DOSpiKUJuL60gmcw==
X-CSE-MsgGUID: kUmpCzsmQcO9kd398A+O3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="40038126"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="40038126"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 03:42:42 -0700
X-CSE-ConnectionGUID: UpXZyfURTTW3aAEzsFP47g==
X-CSE-MsgGUID: zViNcCqiTRyiTpFfnDcEow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="46835010"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jul 2024 03:42:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQ2sI-000TgA-1k;
	Sat, 06 Jul 2024 10:42:38 +0000
Date: Sat, 06 Jul 2024 18:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 ecd36a3ae7ffe3feaf0ff2e3983c96b9cff6db93
Message-ID: <202407061814.43Bt4Zpb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: ecd36a3ae7ffe3feaf0ff2e3983c96b9cff6db93  Merge branch 'for-6.11' into for-next

elapsed time: 952m

configs tested: 155
configs skipped: 4

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
arc                        nsim_700_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                         socfpga_defconfig   gcc-13.2.0
arm                          sp7021_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240706   clang-18
i386         buildonly-randconfig-002-20240706   clang-18
i386         buildonly-randconfig-002-20240706   gcc-13
i386         buildonly-randconfig-003-20240706   clang-18
i386         buildonly-randconfig-004-20240706   clang-18
i386         buildonly-randconfig-004-20240706   gcc-13
i386         buildonly-randconfig-005-20240706   clang-18
i386         buildonly-randconfig-005-20240706   gcc-10
i386         buildonly-randconfig-006-20240706   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240706   clang-18
i386                  randconfig-001-20240706   gcc-13
i386                  randconfig-002-20240706   clang-18
i386                  randconfig-003-20240706   clang-18
i386                  randconfig-003-20240706   gcc-13
i386                  randconfig-004-20240706   clang-18
i386                  randconfig-005-20240706   clang-18
i386                  randconfig-006-20240706   clang-18
i386                  randconfig-006-20240706   gcc-12
i386                  randconfig-011-20240706   clang-18
i386                  randconfig-011-20240706   gcc-11
i386                  randconfig-012-20240706   clang-18
i386                  randconfig-013-20240706   clang-18
i386                  randconfig-014-20240706   clang-18
i386                  randconfig-015-20240706   clang-18
i386                  randconfig-015-20240706   gcc-7
i386                  randconfig-016-20240706   clang-18
i386                  randconfig-016-20240706   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240706   clang-18
x86_64       buildonly-randconfig-002-20240706   clang-18
x86_64       buildonly-randconfig-003-20240706   clang-18
x86_64       buildonly-randconfig-004-20240706   clang-18
x86_64       buildonly-randconfig-005-20240706   clang-18
x86_64       buildonly-randconfig-006-20240706   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240706   clang-18
x86_64                randconfig-002-20240706   clang-18
x86_64                randconfig-003-20240706   clang-18
x86_64                randconfig-004-20240706   clang-18
x86_64                randconfig-005-20240706   clang-18
x86_64                randconfig-006-20240706   clang-18
x86_64                randconfig-011-20240706   clang-18
x86_64                randconfig-012-20240706   clang-18
x86_64                randconfig-013-20240706   clang-18
x86_64                randconfig-014-20240706   clang-18
x86_64                randconfig-015-20240706   clang-18
x86_64                randconfig-016-20240706   clang-18
x86_64                randconfig-071-20240706   clang-18
x86_64                randconfig-072-20240706   clang-18
x86_64                randconfig-073-20240706   clang-18
x86_64                randconfig-074-20240706   clang-18
x86_64                randconfig-075-20240706   clang-18
x86_64                randconfig-076-20240706   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

