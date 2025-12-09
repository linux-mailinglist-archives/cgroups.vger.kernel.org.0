Return-Path: <cgroups+bounces-12309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B653CB0DDD
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 19:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 473D4301918A
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 18:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B99302CA2;
	Tue,  9 Dec 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjLW4vns"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A95302171
	for <cgroups@vger.kernel.org>; Tue,  9 Dec 2025 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765305847; cv=none; b=Bxh8ui3GpBzE402DoAMplPM9x7F0508GjNA2+wNgPIm9Xq1VKpfKIO5/YFTeXV+b8JMtFw8xm2QFPBRowWY6SHUiXuPEvkUvh1Zw/jTu4zdqVNNxZd73cWBSTxQlQgFwkpok9PMDnK0UEJQXLGMWo46/PXHAFQns9GrzA+G7/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765305847; c=relaxed/simple;
	bh=web+GN7L9FxmuuOrkEvA/4crxvtmj2AVl8md8N4DGWE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P7f8llvGHYgklGy8t5cCTbE3twpVW/bm9dCsxqTSJK+suRed6f7AW7vQPEk/0f1RBmnJg1OODDmI3CZBZFyCwzV2tEw58QWJ+18ljpom3TkReiPvXl/BWAix1kL3M6XKgmIFLxQB/3C724ESMGQkk5Sw4aZmhf1pDLoX0mnvTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjLW4vns; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765305846; x=1796841846;
  h=date:from:to:cc:subject:message-id;
  bh=web+GN7L9FxmuuOrkEvA/4crxvtmj2AVl8md8N4DGWE=;
  b=VjLW4vnsf83CCc+0culT9DKWLcVlop5f69ePah4ek9WiRqjUfocAhvUH
   LErmXj2OOzwxfcIT/dlf6Hp1PbeHLoXyNuy0Zt+vYT3zQFwk3rKTiilbm
   yHCibxXyUheZPNXqFRi22+V3k43+ST8rH+rT4YZsP0Cl7obZKuyQhY44x
   gZHT4yi8eoE0lvcFJpDwA+zzhBDdsAgL+HPuePMD6lltptMHxKRZu/C7e
   CqmiWPemR5f4ilY6lyVkRRq/AhFhPV4csYdAmvD0IGxSZ8QhYAb395htm
   +OnfpfFOXY6I9tgCZy9bAPZknLys/MNPK22xrROgR1dUIetDOnrTw+tx6
   Q==;
X-CSE-ConnectionGUID: fRy3CeQtTQqUV5xgDrkzzw==
X-CSE-MsgGUID: n3TyQqHTQciJlfceKNuzwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="84683448"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="84683448"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:44:05 -0800
X-CSE-ConnectionGUID: JmDHOPbzTGqO2R0OaclxpA==
X-CSE-MsgGUID: rkZ51MuORKqgkWCf7Vd9Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196340574"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Dec 2025 10:44:03 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT2gq-000000002Af-2bVi;
	Tue, 09 Dec 2025 18:44:00 +0000
Date: Wed, 10 Dec 2025 02:43:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 6ee43047e8ada63c4dfee01e2ea7e7eadfcda2ab
Message-ID: <202512100243.bWHYvgkM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 6ee43047e8ada63c4dfee01e2ea7e7eadfcda2ab  cpuset: Remove unnecessary checks in rebuild_sched_domains_locked

elapsed time: 1391m

configs tested: 307
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251209    clang-22
arc                   randconfig-001-20251209    gcc-13.4.0
arc                   randconfig-002-20251209    clang-22
arc                   randconfig-002-20251209    gcc-9.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20251209    clang-19
arm                   randconfig-001-20251209    clang-22
arm                   randconfig-002-20251209    clang-20
arm                   randconfig-002-20251209    clang-22
arm                   randconfig-003-20251209    clang-22
arm                   randconfig-004-20251209    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251209    gcc-8.5.0
arm64                 randconfig-001-20251209    gcc-9.5.0
arm64                 randconfig-002-20251209    gcc-9.5.0
arm64                 randconfig-003-20251209    clang-22
arm64                 randconfig-003-20251209    gcc-9.5.0
arm64                 randconfig-004-20251209    gcc-11.5.0
arm64                 randconfig-004-20251209    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251209    gcc-15.1.0
csky                  randconfig-001-20251209    gcc-9.5.0
csky                  randconfig-002-20251209    gcc-15.1.0
csky                  randconfig-002-20251209    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251209    clang-22
hexagon               randconfig-001-20251210    gcc-10.5.0
hexagon               randconfig-002-20251209    clang-22
hexagon               randconfig-002-20251210    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251209    clang-20
i386        buildonly-randconfig-001-20251209    gcc-14
i386        buildonly-randconfig-002-20251209    clang-20
i386        buildonly-randconfig-002-20251209    gcc-14
i386        buildonly-randconfig-003-20251209    gcc-14
i386        buildonly-randconfig-004-20251209    gcc-14
i386        buildonly-randconfig-005-20251209    gcc-14
i386        buildonly-randconfig-006-20251209    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251209    clang-20
i386                  randconfig-001-20251209    gcc-14
i386                  randconfig-002-20251209    clang-20
i386                  randconfig-003-20251209    clang-20
i386                  randconfig-004-20251209    clang-20
i386                  randconfig-004-20251209    gcc-14
i386                  randconfig-005-20251209    clang-20
i386                  randconfig-005-20251209    gcc-14
i386                  randconfig-006-20251209    clang-20
i386                  randconfig-007-20251209    clang-20
i386                  randconfig-007-20251209    gcc-14
i386                  randconfig-011-20251209    clang-20
i386                  randconfig-011-20251209    gcc-14
i386                  randconfig-012-20251209    clang-20
i386                  randconfig-012-20251209    gcc-14
i386                  randconfig-013-20251209    clang-20
i386                  randconfig-013-20251209    gcc-14
i386                  randconfig-014-20251209    clang-20
i386                  randconfig-014-20251209    gcc-14
i386                  randconfig-015-20251209    clang-20
i386                  randconfig-015-20251209    gcc-14
i386                  randconfig-016-20251209    clang-20
i386                  randconfig-016-20251209    gcc-14
i386                  randconfig-017-20251209    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251209    clang-22
loongarch             randconfig-001-20251210    gcc-10.5.0
loongarch             randconfig-002-20251209    clang-22
loongarch             randconfig-002-20251210    gcc-10.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-22
mips                            gpr_defconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-22
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251209    gcc-8.5.0
nios2                 randconfig-001-20251210    gcc-10.5.0
nios2                 randconfig-002-20251209    gcc-11.5.0
nios2                 randconfig-002-20251210    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251209    gcc-15.1.0
parisc                randconfig-001-20251209    gcc-8.5.0
parisc                randconfig-002-20251209    gcc-13.4.0
parisc                randconfig-002-20251209    gcc-15.1.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                   currituck_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251209    gcc-14.3.0
powerpc               randconfig-001-20251209    gcc-15.1.0
powerpc               randconfig-002-20251209    clang-22
powerpc               randconfig-002-20251209    gcc-15.1.0
powerpc                     tqm5200_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251209    gcc-14.3.0
powerpc64             randconfig-001-20251209    gcc-15.1.0
powerpc64             randconfig-002-20251209    gcc-15.1.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20251209    clang-22
riscv                 randconfig-001-20251210    clang-22
riscv                 randconfig-002-20251209    clang-18
riscv                 randconfig-002-20251209    clang-22
riscv                 randconfig-002-20251210    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251209    clang-22
s390                  randconfig-001-20251209    gcc-12.5.0
s390                  randconfig-001-20251210    clang-22
s390                  randconfig-002-20251209    clang-22
s390                  randconfig-002-20251209    gcc-12.5.0
s390                  randconfig-002-20251210    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251209    clang-22
sh                    randconfig-001-20251209    gcc-14.3.0
sh                    randconfig-001-20251210    clang-22
sh                    randconfig-002-20251209    clang-22
sh                    randconfig-002-20251209    gcc-13.4.0
sh                    randconfig-002-20251210    clang-22
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251209    gcc-10.5.0
sparc                 randconfig-001-20251209    gcc-11.5.0
sparc                 randconfig-001-20251210    gcc-15.1.0
sparc                 randconfig-002-20251209    gcc-10.5.0
sparc                 randconfig-002-20251209    gcc-15.1.0
sparc                 randconfig-002-20251210    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251209    clang-22
sparc64               randconfig-001-20251209    gcc-10.5.0
sparc64               randconfig-001-20251210    gcc-15.1.0
sparc64               randconfig-002-20251209    clang-20
sparc64               randconfig-002-20251209    gcc-10.5.0
sparc64               randconfig-002-20251210    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251209    gcc-10.5.0
um                    randconfig-001-20251209    gcc-14
um                    randconfig-001-20251210    gcc-15.1.0
um                    randconfig-002-20251209    gcc-10.5.0
um                    randconfig-002-20251209    gcc-14
um                    randconfig-002-20251210    gcc-15.1.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251209    clang-20
x86_64      buildonly-randconfig-001-20251209    gcc-14
x86_64      buildonly-randconfig-002-20251209    gcc-14
x86_64      buildonly-randconfig-003-20251209    gcc-14
x86_64      buildonly-randconfig-004-20251209    clang-20
x86_64      buildonly-randconfig-004-20251209    gcc-14
x86_64      buildonly-randconfig-005-20251209    clang-20
x86_64      buildonly-randconfig-005-20251209    gcc-14
x86_64      buildonly-randconfig-006-20251209    clang-20
x86_64      buildonly-randconfig-006-20251209    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251209    clang-20
x86_64                randconfig-001-20251209    gcc-14
x86_64                randconfig-002-20251209    clang-20
x86_64                randconfig-002-20251209    gcc-14
x86_64                randconfig-003-20251209    clang-20
x86_64                randconfig-003-20251209    gcc-14
x86_64                randconfig-004-20251209    gcc-14
x86_64                randconfig-005-20251209    gcc-14
x86_64                randconfig-006-20251209    gcc-14
x86_64                randconfig-011-20251209    clang-20
x86_64                randconfig-011-20251209    gcc-14
x86_64                randconfig-011-20251210    clang-20
x86_64                randconfig-012-20251209    clang-20
x86_64                randconfig-012-20251210    clang-20
x86_64                randconfig-013-20251209    clang-20
x86_64                randconfig-013-20251209    gcc-14
x86_64                randconfig-013-20251210    clang-20
x86_64                randconfig-014-20251209    clang-20
x86_64                randconfig-014-20251210    clang-20
x86_64                randconfig-015-20251209    clang-20
x86_64                randconfig-015-20251210    clang-20
x86_64                randconfig-016-20251209    clang-20
x86_64                randconfig-016-20251210    clang-20
x86_64                randconfig-071-20251209    clang-20
x86_64                randconfig-071-20251209    gcc-14
x86_64                randconfig-072-20251209    gcc-14
x86_64                randconfig-073-20251209    gcc-14
x86_64                randconfig-074-20251209    gcc-14
x86_64                randconfig-075-20251209    gcc-14
x86_64                randconfig-076-20251209    clang-20
x86_64                randconfig-076-20251209    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251209    gcc-10.5.0
xtensa                randconfig-001-20251209    gcc-13.4.0
xtensa                randconfig-001-20251210    gcc-15.1.0
xtensa                randconfig-002-20251209    gcc-10.5.0
xtensa                randconfig-002-20251210    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

