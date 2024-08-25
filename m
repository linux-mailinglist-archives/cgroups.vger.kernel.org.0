Return-Path: <cgroups+bounces-4438-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D962195E0A8
	for <lists+cgroups@lfdr.de>; Sun, 25 Aug 2024 03:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C581C20CCF
	for <lists+cgroups@lfdr.de>; Sun, 25 Aug 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7049A1C3D;
	Sun, 25 Aug 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVScvQzy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913FEDE
	for <cgroups@vger.kernel.org>; Sun, 25 Aug 2024 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724549003; cv=none; b=lSBasvYXXLa1GZiJMt/PHwDaDEqJq8gnAsGtPPFfoN7V8cOxe98v4A2rb/gBozwwYfMcSCz98/xdFQtZabqJCRsNBRpdBtDmEv9UaV7y9JFINbC8v9UtF+k8jtZ9VfH2W6ljn8WuvIb5rAoqVjVZALlY54db6OIz18kTgiPpLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724549003; c=relaxed/simple;
	bh=CiSdfu22oVKcK0yhRnA1TI7A5QG00m4kgejvo9OOQnE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ea6pbE0dWUOBXBaMkemdwSacU/UIO+1P4Xe18gn2gytRqaybcT4q9CzoQ/HG4DnlWFL/baSHXB1/BIUTX4zzXEJlDKj6bI+GTLnZOeAK87UlI5BoXpKIFlMYVH4Yn70Mq7bBh0O3DceOKZAtH2T7ugdUb5JC8geREocObnALFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVScvQzy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724549001; x=1756085001;
  h=date:from:to:cc:subject:message-id;
  bh=CiSdfu22oVKcK0yhRnA1TI7A5QG00m4kgejvo9OOQnE=;
  b=cVScvQzyQFKMSbVtiYL5j0jiC8+YjkVpCzYXfxPPIHO0+Elr88QaMitQ
   u4iLUlUuXp6zN41zELRt1pjbCgD7IGrPmYDkL75LUL85g1o8Mq3nLnGrm
   i2hBlGrH6Ce/fSNcdiTmn7rsqWINvoQKXJ8sFo4bSuYzX/1Kg+mD++2qa
   e0CPv1GpckfMdy3MPosCN+uamJoWTQfJrB+2O1oprUr6hMtR2goqLH49I
   p+VgZ820zAv8ibz1pg3nNDF5yvxz7bm8Bx/CnQ2aHl+MaJpvmJDAnP9X4
   d2PrTHBfFpQIQGd7YPWpasBeK5dR2chHWlcx+nVjHdtqKS1pJjo1GD4yQ
   g==;
X-CSE-ConnectionGUID: 5ORkZV1nQsmPkWfL3YEeSA==
X-CSE-MsgGUID: 3Ue2QppsTbqXmLCIKwuqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23176425"
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="23176425"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 18:23:21 -0700
X-CSE-ConnectionGUID: 9x1raQd+TZynT/A89LQezg==
X-CSE-MsgGUID: bqdvghFVTBm4SkFmwwq4ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="61842957"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Aug 2024 18:23:19 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1si1yP-000EsD-28;
	Sun, 25 Aug 2024 01:23:17 +0000
Date: Sun, 25 Aug 2024 09:23:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.12] BUILD SUCCESS
 3c2acae88844e7423a50b5cbe0a2c9d430fcd20c
Message-ID: <202408250914.hFYCSx3F-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.12
branch HEAD: 3c2acae88844e7423a50b5cbe0a2c9d430fcd20c  cgroup/cpuset: remove use_parent_ecpus of cpuset

elapsed time: 1442m

configs tested: 193
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
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240824   gcc-13.2.0
arc                   randconfig-002-20240824   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                          gemini_defconfig   clang-20
arm                       multi_v4t_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240824   gcc-13.2.0
arm                   randconfig-002-20240824   gcc-13.2.0
arm                   randconfig-003-20240824   gcc-13.2.0
arm                   randconfig-004-20240824   gcc-13.2.0
arm                             rpc_defconfig   clang-20
arm                        spear3xx_defconfig   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240824   gcc-13.2.0
arm64                 randconfig-002-20240824   gcc-13.2.0
arm64                 randconfig-003-20240824   gcc-13.2.0
arm64                 randconfig-004-20240824   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240824   gcc-13.2.0
csky                  randconfig-002-20240824   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240824   clang-18
i386         buildonly-randconfig-001-20240825   clang-18
i386         buildonly-randconfig-002-20240824   clang-18
i386         buildonly-randconfig-002-20240825   clang-18
i386         buildonly-randconfig-003-20240824   clang-18
i386         buildonly-randconfig-003-20240825   clang-18
i386         buildonly-randconfig-004-20240824   clang-18
i386         buildonly-randconfig-004-20240825   clang-18
i386         buildonly-randconfig-005-20240824   clang-18
i386         buildonly-randconfig-005-20240825   clang-18
i386         buildonly-randconfig-006-20240824   clang-18
i386         buildonly-randconfig-006-20240825   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240824   clang-18
i386                  randconfig-001-20240825   clang-18
i386                  randconfig-002-20240824   clang-18
i386                  randconfig-002-20240825   clang-18
i386                  randconfig-003-20240824   clang-18
i386                  randconfig-003-20240825   clang-18
i386                  randconfig-004-20240824   clang-18
i386                  randconfig-004-20240825   clang-18
i386                  randconfig-005-20240824   clang-18
i386                  randconfig-005-20240825   clang-18
i386                  randconfig-006-20240824   clang-18
i386                  randconfig-006-20240825   clang-18
i386                  randconfig-011-20240824   clang-18
i386                  randconfig-011-20240825   clang-18
i386                  randconfig-012-20240824   clang-18
i386                  randconfig-012-20240825   clang-18
i386                  randconfig-013-20240824   clang-18
i386                  randconfig-013-20240825   clang-18
i386                  randconfig-014-20240824   clang-18
i386                  randconfig-014-20240825   clang-18
i386                  randconfig-015-20240824   clang-18
i386                  randconfig-015-20240825   clang-18
i386                  randconfig-016-20240824   clang-18
i386                  randconfig-016-20240825   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240824   gcc-13.2.0
loongarch             randconfig-002-20240824   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240824   gcc-13.2.0
nios2                 randconfig-002-20240824   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240824   gcc-13.2.0
parisc                randconfig-002-20240824   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                    amigaone_defconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      pasemi_defconfig   clang-20
powerpc                     powernv_defconfig   clang-20
powerpc                      ppc44x_defconfig   clang-20
powerpc                      ppc64e_defconfig   clang-20
powerpc               randconfig-001-20240824   gcc-13.2.0
powerpc                     tqm8548_defconfig   clang-20
powerpc64             randconfig-001-20240824   gcc-13.2.0
powerpc64             randconfig-002-20240824   gcc-13.2.0
powerpc64             randconfig-003-20240824   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240824   gcc-13.2.0
riscv                 randconfig-002-20240824   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                          debug_defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240824   gcc-13.2.0
s390                  randconfig-002-20240824   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                    randconfig-001-20240824   gcc-13.2.0
sh                    randconfig-002-20240824   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240824   gcc-13.2.0
sparc64               randconfig-002-20240824   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240824   gcc-13.2.0
um                    randconfig-002-20240824   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240824   clang-18
x86_64       buildonly-randconfig-002-20240824   clang-18
x86_64       buildonly-randconfig-003-20240824   clang-18
x86_64       buildonly-randconfig-004-20240824   clang-18
x86_64       buildonly-randconfig-005-20240824   clang-18
x86_64       buildonly-randconfig-006-20240824   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240824   clang-18
x86_64                randconfig-002-20240824   clang-18
x86_64                randconfig-003-20240824   clang-18
x86_64                randconfig-004-20240824   clang-18
x86_64                randconfig-005-20240824   clang-18
x86_64                randconfig-006-20240824   clang-18
x86_64                randconfig-011-20240824   clang-18
x86_64                randconfig-012-20240824   clang-18
x86_64                randconfig-013-20240824   clang-18
x86_64                randconfig-014-20240824   clang-18
x86_64                randconfig-015-20240824   clang-18
x86_64                randconfig-016-20240824   clang-18
x86_64                randconfig-071-20240824   clang-18
x86_64                randconfig-072-20240824   clang-18
x86_64                randconfig-073-20240824   clang-18
x86_64                randconfig-074-20240824   clang-18
x86_64                randconfig-075-20240824   clang-18
x86_64                randconfig-076-20240824   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240824   gcc-13.2.0
xtensa                randconfig-002-20240824   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

