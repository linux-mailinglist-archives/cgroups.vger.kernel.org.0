Return-Path: <cgroups+bounces-3011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904868CFB20
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6B91C20ADE
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2024 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EBB3D548;
	Mon, 27 May 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKqrbMdI"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA02030B
	for <cgroups@vger.kernel.org>; Mon, 27 May 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797839; cv=none; b=jYTm2ycczNrxm93m8spuTI3y3JNaMld5xgIi0pWqXeq7dzjUB8+5HD0Pu17YbHpiEfmtjtNDoP9HDOQwn6wAYQJ+EkiBNqfc3+aoiHsNscOcfy2cY3hIn+iZ18wFmarK3Ou59LDcNprg4D5K8TP5+4JX1ljvimj0MHc/i7EPMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797839; c=relaxed/simple;
	bh=TMw+w0lC6LpNX7MRDllOWr3IRBr1ICHOtkTeg+ru2KM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qE1hIlFcHKEw8lMdfJAe2BhH/RLCr9kqnPpc9Ym1NIthNiQcSLtknMefSvz+HpoOGtTwbghIlKlfB8LxLIIKzv41m2aFar4EhoNW3DCwATTMqFUfynj5LAyiqPcAiMkXyWbvjrypT/bdrlFUPc9l8CiOjEiB3Nk603ULBR7YTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKqrbMdI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716797838; x=1748333838;
  h=date:from:to:cc:subject:message-id;
  bh=TMw+w0lC6LpNX7MRDllOWr3IRBr1ICHOtkTeg+ru2KM=;
  b=lKqrbMdIKI7WYC+Ec8B/iM26UiV4WQzdGUTSm0HIftWgLFkWdxGGHNK8
   Z7kQiQSptOPdFGWfcjyZVXnayg2EAy2+3mjmyTLfQZTlWMnoB8VOLf7Lv
   p5czb2e8rpmDetmB+m437cPVvcKZiFfryF6IkIzQ3gRCrCJLcDHLkHbZU
   qPNI0bpo1UYBxWI38ZTChzcmlnBrf6Zr9kkpWlLKs6gVvGyplxVg1kOfc
   ebz47jRuAIZ2kQyEdbXy9+4PjXCDKbkEee7+1dVD9bn6hsDkb9K5C7Sd8
   5NpVMWFX3ndkeyJYQXfWkms5Em9OeDcHXNXLN56WgtopeDKkGWclFOV6g
   g==;
X-CSE-ConnectionGUID: d8Lx8BMaTsS5Bls4XWbv7A==
X-CSE-MsgGUID: +Mlzc+1nSF6se20v3MyegQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="30628873"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="30628873"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 01:17:17 -0700
X-CSE-ConnectionGUID: sAx6l0+MQb2cbFx1hawZAg==
X-CSE-MsgGUID: jtMIkzuYSiCJItBjHGsV1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35159773"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 May 2024 01:17:15 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBVWz-0009lr-2O;
	Mon, 27 May 2024 08:16:43 +0000
Date: Mon, 27 May 2024 16:14:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD REGRESSION
 a8d55ff5f3acf52e6380976fb5d0a9172032dcb0
Message-ID: <202405271606.DYMCKs25-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a8d55ff5f3acf52e6380976fb5d0a9172032dcb0  kernel/cgroup: cleanup cgroup_base_files when fail to add cgroup_psi_files

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405270728.d1SabzhU-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/cgroup/pids.o: warning: objtool: __jump_table+0x0: special: can't find orig instruction

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- loongarch-defconfig
    `-- kernel-cgroup-pids.o:warning:objtool:__jump_table:special:can-t-find-orig-instruction

elapsed time: 724m

configs tested: 207
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240527   gcc  
arc                   randconfig-002-20240527   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   clang
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240527   clang
arm                   randconfig-002-20240527   gcc  
arm                   randconfig-003-20240527   gcc  
arm                   randconfig-004-20240527   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240527   gcc  
arm64                 randconfig-002-20240527   gcc  
arm64                 randconfig-003-20240527   clang
arm64                 randconfig-004-20240527   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240527   gcc  
csky                  randconfig-002-20240527   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240527   clang
hexagon               randconfig-002-20240527   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240527   gcc  
i386         buildonly-randconfig-002-20240527   gcc  
i386         buildonly-randconfig-003-20240527   gcc  
i386         buildonly-randconfig-004-20240527   clang
i386         buildonly-randconfig-005-20240527   gcc  
i386         buildonly-randconfig-006-20240527   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240527   gcc  
i386                  randconfig-002-20240527   clang
i386                  randconfig-003-20240527   gcc  
i386                  randconfig-004-20240527   gcc  
i386                  randconfig-005-20240527   gcc  
i386                  randconfig-006-20240527   gcc  
i386                  randconfig-011-20240527   gcc  
i386                  randconfig-012-20240527   clang
i386                  randconfig-013-20240527   gcc  
i386                  randconfig-014-20240527   clang
i386                  randconfig-015-20240527   gcc  
i386                  randconfig-016-20240527   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240527   gcc  
loongarch             randconfig-002-20240527   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                     cu1000-neo_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                     loongson1b_defconfig   clang
mips                      maltaaprp_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240527   gcc  
nios2                 randconfig-002-20240527   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240527   gcc  
parisc                randconfig-002-20240527   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      chrp32_defconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      pasemi_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240527   gcc  
powerpc               randconfig-002-20240527   gcc  
powerpc               randconfig-003-20240527   clang
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                     tqm8548_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240527   clang
powerpc64             randconfig-002-20240527   gcc  
powerpc64             randconfig-003-20240527   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240527   clang
riscv                 randconfig-002-20240527   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240527   clang
s390                  randconfig-002-20240527   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240527   gcc  
sh                    randconfig-002-20240527   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240527   gcc  
sparc64               randconfig-002-20240527   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240527   gcc  
um                    randconfig-002-20240527   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240527   clang
x86_64       buildonly-randconfig-002-20240527   gcc  
x86_64       buildonly-randconfig-003-20240527   gcc  
x86_64       buildonly-randconfig-004-20240527   gcc  
x86_64       buildonly-randconfig-005-20240527   gcc  
x86_64       buildonly-randconfig-006-20240527   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-001-20240527   clang
x86_64                randconfig-002-20240527   gcc  
x86_64                randconfig-003-20240527   clang
x86_64                randconfig-004-20240527   clang
x86_64                randconfig-005-20240527   clang
x86_64                randconfig-006-20240527   clang
x86_64                randconfig-011-20240527   gcc  
x86_64                randconfig-012-20240527   gcc  
x86_64                randconfig-013-20240527   clang
x86_64                randconfig-014-20240527   gcc  
x86_64                randconfig-015-20240527   gcc  
x86_64                randconfig-016-20240527   gcc  
x86_64                randconfig-071-20240527   gcc  
x86_64                randconfig-072-20240527   clang
x86_64                randconfig-073-20240527   clang
x86_64                randconfig-074-20240527   clang
x86_64                randconfig-075-20240527   clang
x86_64                randconfig-076-20240527   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240527   gcc  
xtensa                randconfig-002-20240527   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

