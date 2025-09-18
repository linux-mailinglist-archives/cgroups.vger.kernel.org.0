Return-Path: <cgroups+bounces-10270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3ADB87255
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C04A7A86DB
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E72F9C2A;
	Thu, 18 Sep 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARJTB/A2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52152FABE0
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231005; cv=none; b=DkSljaZ452KXlMbc3jA7tYAKUnsf/AhsemrP7LsPGvS7LBoxsi8sXYKz/W8HqXRxPm6LEjqHhDDaMOKcSwW/+/qr3haM8Cx9ur8jBnhKV/BHwG8dQJ8a+FGercrsp2TNGDIPmAqlP5ZUUXHgl22+ZAHG/UIU7Jq1lFDiAuU0shs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231005; c=relaxed/simple;
	bh=gZVVFYH+NoM/Nu1IN9mX8YcNxVqQWuRNJhoySyGIwiE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vGM0+tEMSptbI7r88xWJ1HPC1jf1fJydYBdx8d1sj4e/Onxl5CFPqdeVPY3h5p/9R+jrTUwzvJqRRHzHQb1KmztCbUayIFPuEVyodyhmqQuinlILyIRjAfjUNxoJejFWKmHE51CpxhOR3VtArlEQhS9/c/umgW4hN61YUttMAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARJTB/A2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758231004; x=1789767004;
  h=date:from:to:cc:subject:message-id;
  bh=gZVVFYH+NoM/Nu1IN9mX8YcNxVqQWuRNJhoySyGIwiE=;
  b=ARJTB/A2ollwq6Fx7COM4QwThhTufQ/rK4QkwnFhHv7UhulGEi6bu2QH
   yd0M1wUaKriXQOLCEZdmQRLliWZ6Q7Cm5E6AsgFMJbte4ymnvckWcThpy
   06TYQzDY9RaOIp90vnWXE/qGCLShUXu1UTkbXtl77NYRZl2ODe7uz6aFP
   62eyoZx0Ro7JvV4KxH0dMZ9K0EO1B3zhW+nQUTl8QbJqSuHYjFIgBto6u
   u3io0U6kBBznezjDQa9EYL9bUYLwh3A24cUSw/duw2Bu4AhUlpzV27fCd
   P8ZSQA1P9DGWxRmK81j3gH9GobRj456f7F4aH/SITatmqAG6Wfj1b9azv
   g==;
X-CSE-ConnectionGUID: w+UQZs8cRvS/TgNxUlznkA==
X-CSE-MsgGUID: AIPk9tLMTlqsclaEyH4TlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60497156"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60497156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:30:03 -0700
X-CSE-ConnectionGUID: QU48OFMhS5CYtD2KRGIwRg==
X-CSE-MsgGUID: PRhRNnBtTXyX1oZQKJHetA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="174919528"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Sep 2025 14:30:02 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzMCV-0003jX-1M;
	Thu, 18 Sep 2025 21:29:59 +0000
Date: Fri, 19 Sep 2025 05:29:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-6.17-rc6] BUILD SUCCESS
 fb50ba33888bfab960874fde884f5a9874524644
Message-ID: <202509190515.9zJWFhAg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-6.17-rc6
branch HEAD: fb50ba33888bfab960874fde884f5a9874524644  Merge branch 'for-6.17-fixes' into test-merge-6.17-rc6

elapsed time: 1461m

configs tested: 296
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    clang-22
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-001-20250919    gcc-11.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arc                   randconfig-002-20250919    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   milbeaut_m10v_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-001-20250919    gcc-11.5.0
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-002-20250919    gcc-11.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-003-20250919    gcc-11.5.0
arm                   randconfig-004-20250918    gcc-11.5.0
arm                   randconfig-004-20250919    gcc-11.5.0
arm                         s5pv210_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-001-20250919    gcc-11.5.0
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-002-20250919    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-003-20250919    gcc-11.5.0
arm64                 randconfig-004-20250918    clang-22
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250918    clang-22
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-002-20250918    clang-22
csky                  randconfig-002-20250918    gcc-15.1.0
csky                  randconfig-002-20250919    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250918    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-001-20250918    gcc-14
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-004-20250918    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
i386        buildonly-randconfig-006-20250918    gcc-14
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250918    gcc-14
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250918    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250918    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250918    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250918    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250918    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250918    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250918    gcc-14
i386                  randconfig-011-20250919    clang-20
i386                  randconfig-012-20250918    gcc-14
i386                  randconfig-012-20250919    clang-20
i386                  randconfig-013-20250918    gcc-14
i386                  randconfig-013-20250919    clang-20
i386                  randconfig-014-20250918    gcc-14
i386                  randconfig-014-20250919    clang-20
i386                  randconfig-015-20250918    gcc-14
i386                  randconfig-015-20250919    clang-20
i386                  randconfig-016-20250918    gcc-14
i386                  randconfig-016-20250919    clang-20
i386                  randconfig-017-20250918    gcc-14
i386                  randconfig-017-20250919    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-001-20250918    clang-22
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-002-20250918    clang-18
loongarch             randconfig-002-20250918    clang-22
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                         rt305x_defconfig    clang-22
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250918    clang-22
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-002-20250918    clang-22
nios2                 randconfig-002-20250918    gcc-8.5.0
nios2                 randconfig-002-20250919    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    clang-22
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-002-20250918    clang-22
parisc                randconfig-002-20250918    gcc-8.5.0
parisc                randconfig-002-20250919    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    clang-22
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-002-20250918    clang-22
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-003-20250918    clang-19
powerpc               randconfig-003-20250918    clang-22
powerpc               randconfig-003-20250919    clang-22
powerpc64             randconfig-001-20250918    clang-22
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-002-20250918    clang-22
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-003-20250918    clang-22
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-001-20250918    gcc-10.5.0
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-9.5.0
riscv                 randconfig-002-20250919    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250918    gcc-10.5.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-001-20250919    gcc-10.5.0
s390                  randconfig-002-20250918    gcc-10.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250918    gcc-10.5.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-001-20250919    gcc-10.5.0
sh                    randconfig-002-20250918    gcc-10.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-10.5.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-001-20250919    gcc-10.5.0
sparc                 randconfig-002-20250918    gcc-10.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc                 randconfig-002-20250919    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-001-20250918    gcc-10.5.0
sparc64               randconfig-001-20250919    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-8.5.0
sparc64               randconfig-002-20250919    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-001-20250918    gcc-10.5.0
um                    randconfig-001-20250919    gcc-10.5.0
um                    randconfig-002-20250918    clang-18
um                    randconfig-002-20250918    gcc-10.5.0
um                    randconfig-002-20250919    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250918    gcc-12
x86_64                randconfig-001-20250919    clang-20
x86_64                randconfig-002-20250918    gcc-12
x86_64                randconfig-002-20250919    clang-20
x86_64                randconfig-003-20250918    gcc-12
x86_64                randconfig-003-20250919    clang-20
x86_64                randconfig-004-20250918    gcc-12
x86_64                randconfig-004-20250919    clang-20
x86_64                randconfig-005-20250918    gcc-12
x86_64                randconfig-005-20250919    clang-20
x86_64                randconfig-006-20250918    gcc-12
x86_64                randconfig-006-20250919    clang-20
x86_64                randconfig-007-20250918    gcc-12
x86_64                randconfig-007-20250919    clang-20
x86_64                randconfig-008-20250918    gcc-12
x86_64                randconfig-008-20250919    clang-20
x86_64                randconfig-071-20250918    clang-20
x86_64                randconfig-071-20250919    gcc-14
x86_64                randconfig-072-20250918    clang-20
x86_64                randconfig-072-20250919    gcc-14
x86_64                randconfig-073-20250918    clang-20
x86_64                randconfig-073-20250919    gcc-14
x86_64                randconfig-074-20250918    clang-20
x86_64                randconfig-074-20250919    gcc-14
x86_64                randconfig-075-20250918    clang-20
x86_64                randconfig-075-20250919    gcc-14
x86_64                randconfig-076-20250918    clang-20
x86_64                randconfig-076-20250919    gcc-14
x86_64                randconfig-077-20250918    clang-20
x86_64                randconfig-077-20250919    gcc-14
x86_64                randconfig-078-20250918    clang-20
x86_64                randconfig-078-20250919    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-10.5.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-001-20250919    gcc-10.5.0
xtensa                randconfig-002-20250918    gcc-10.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0
xtensa                randconfig-002-20250919    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

