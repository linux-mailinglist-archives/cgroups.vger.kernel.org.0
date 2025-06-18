Return-Path: <cgroups+bounces-8595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA4ADF803
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 22:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E139318862D3
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B749221FAE;
	Wed, 18 Jun 2025 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2BcubpL"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6421CC57
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279357; cv=none; b=HDyadzJnBWLxfzoSmV3f8LUBzmNw0Yo8x86/aTHiwPTtDEU6Hqa2BuAA9k3s99U4xoJhlJEq8Eq7QXODB26w2E5n9TICZJURiM/Zi4tWrFbLC2fllYY13B8nwQA0qb1WGwVzdul9zSnqHiUkcc7s0tUqoNL3JFRn3Z1c+8MHgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279357; c=relaxed/simple;
	bh=htC+ECnVajfIWO3IaFZlaggPhmAt+gEy5RSF0uFPHGU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hK4cvQBc2Ijh5E6quxd+7qoKl1g7RSO9lQUTPhAKKnJWHZWjaP1Od+PckiRs763l6z+z21fDJpiOe2UFDcu3E/wViBnIMR4380yTn19RDtP25ukZjR3dNy3T6Xs5yh6c14DV5I7fk6WCOjYezfIu8PGk2RDbWagSe/CubQ5XkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2BcubpL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750279356; x=1781815356;
  h=date:from:to:cc:subject:message-id;
  bh=htC+ECnVajfIWO3IaFZlaggPhmAt+gEy5RSF0uFPHGU=;
  b=R2BcubpLlKRoGlEsuwtV9mbR74o2Z5i3ufCoabsj+2jgqIUDD1gvM5Uo
   aume6GMKlX+GZf3ac/JVlghgAs3Q1cQQsbcwjH0hRP+xkPLuNudtkPLMh
   VsimIWt8mvjbATtfosiZlbGgMp4R84qRaS93BnumXkwVWjuVfeYH2weKn
   m2anj/px8mPx6KIl1QVf1E3AYWlDC4JpLPm843dvi32cgHEqJdlmyX1VG
   fzQTKu2wonNPCcCrI1nYTytKRF8L6FWrqjsZtNE4mSJSKJ9VxTIMkqRNJ
   KLopDcTgCXyAwSu2LWxW8oVkpg3MChtaq1ax53U/t/GTcfoz9da4/fUBY
   g==;
X-CSE-ConnectionGUID: 9OLTEE/KSO66ehv+GvfjvA==
X-CSE-MsgGUID: AVvYsCMAS3m1zp/rpcFG6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63197367"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63197367"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 13:42:35 -0700
X-CSE-ConnectionGUID: X0aDZYX4Sw2UUWWeUFzxMw==
X-CSE-MsgGUID: w8GwKKX0SWqlE/WFzzskBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150484418"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 13:42:34 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRzc7-000KA4-2B;
	Wed, 18 Jun 2025 20:42:31 +0000
Date: Thu, 19 Jun 2025 04:41:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 45c506ba008c5d320edefc04652ed16a5485d550
Message-ID: <202506190428.RcMClMi3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 45c506ba008c5d320edefc04652ed16a5485d550  Merge branch 'for-6.17' into for-next

elapsed time: 1451m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250618    gcc-11.5.0
arc                   randconfig-002-20250618    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                       aspeed_g4_defconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                   randconfig-001-20250618    gcc-15.1.0
arm                   randconfig-002-20250618    gcc-10.5.0
arm                   randconfig-003-20250618    clang-21
arm                   randconfig-004-20250618    gcc-11.5.0
arm                        spear3xx_defconfig    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250618    clang-21
arm64                 randconfig-002-20250618    clang-21
arm64                 randconfig-003-20250618    gcc-14.3.0
arm64                 randconfig-004-20250618    clang-16
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250618    gcc-13.3.0
csky                  randconfig-002-20250618    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250618    clang-19
hexagon               randconfig-002-20250618    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250618    clang-20
i386        buildonly-randconfig-002-20250618    gcc-12
i386        buildonly-randconfig-003-20250618    clang-20
i386        buildonly-randconfig-004-20250618    clang-20
i386        buildonly-randconfig-005-20250618    clang-20
i386        buildonly-randconfig-006-20250618    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-15.1.0
loongarch             randconfig-002-20250618    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-21
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250618    gcc-11.5.0
nios2                 randconfig-002-20250618    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250618    gcc-10.5.0
parisc                randconfig-002-20250618    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc                 linkstation_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250618    gcc-8.5.0
powerpc               randconfig-002-20250618    clang-19
powerpc               randconfig-003-20250618    clang-21
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250618    gcc-8.5.0
powerpc64             randconfig-002-20250618    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250618    clang-20
riscv                 randconfig-002-20250618    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250618    gcc-8.5.0
s390                  randconfig-002-20250618    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250618    gcc-15.1.0
sh                    randconfig-002-20250618    gcc-15.1.0
sh                           se7705_defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-8.5.0
sparc                 randconfig-002-20250618    gcc-13.3.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250618    gcc-13.3.0
sparc64               randconfig-002-20250618    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250618    clang-21
um                    randconfig-002-20250618    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250618    clang-20
x86_64      buildonly-randconfig-002-20250618    clang-20
x86_64      buildonly-randconfig-003-20250618    gcc-12
x86_64      buildonly-randconfig-004-20250618    clang-20
x86_64      buildonly-randconfig-005-20250618    clang-20
x86_64      buildonly-randconfig-006-20250618    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250618    gcc-13.3.0
xtensa                randconfig-002-20250618    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

