Return-Path: <cgroups+bounces-9131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902BB24A16
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352BD583AAC
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB572D12F4;
	Wed, 13 Aug 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjqbPner"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C02C1592
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090185; cv=none; b=nogXfqMVqUPQKxDVdLFnKtHbk+/FZXHEQYiyKS//FMr/DOOgUSYISJ3St4ejh6nmSZmt6oUliGCPwEB9MuWtrRV1Ce9QvoHUNchZDTHiokVkAfO41t7XIr2kjwVoyke6yEG0iI/MISF5RgIJVqkKbHD1iVISn4h2A/93ETNAoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090185; c=relaxed/simple;
	bh=bLyN4B4bCle7SAG9GyYNoFflRwcCoVy2F3CqDQLsLoE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fvRRJqjRvXLJxGNjEBeZaVMOuUiQO7MKuXdMgCDzJcXGFIi37lEKN52C35/jHGRbtDK6Y3uEh7HkTMdtM2QZKN7r53S2iIxVcfVMNx4WEnJ9OB3E0gDiHC1+QILFVpFqDDSUQSYeG+3d1U0ZQmrU6e0ovtlB3XyRHK1Q+DvxtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjqbPner; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755090184; x=1786626184;
  h=date:from:to:cc:subject:message-id;
  bh=bLyN4B4bCle7SAG9GyYNoFflRwcCoVy2F3CqDQLsLoE=;
  b=HjqbPnermw0st28aIpCquOdAGocXwKQ5S4Qz3J0nPyG0exZux/SlM+GC
   CwkVe8Ecc0K6LtWox0fxsjaqnwwzCYIpvjlkA6RwKCfP9uOgG9CqvD2T8
   VoSQY0cDeJgJ/AVeqDsF8E6g1rlmHj7tbWPUte7u481ITnsITC5MRhmAM
   ydj+RlidIURaPBRepIydDMwV0ad5quIPV8MXtlLQeqfi3q5JaI2aAuNZF
   G+2kuKB/dFFAVYmnNWmAiWiaE9qpDI3YNH6DdCVpokAznPCIZUdLu4RhS
   1Xf59+fVwieppYhdL6YZbj+bFm5rGWwkscQEjatDZ8/8fY164yX3Qg0kV
   g==;
X-CSE-ConnectionGUID: R0QtPH1uT86ljkLSN1G3Fg==
X-CSE-MsgGUID: 4VLiDlPyQe+PLzYnIpaUhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68084640"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68084640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:03:03 -0700
X-CSE-ConnectionGUID: aO3EpcILTt+rvvwrchHKIA==
X-CSE-MsgGUID: Gpdn0a++Q7u+Vo+j/1I0YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="167251765"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 06:03:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umB7v-0009ud-1r;
	Wed, 13 Aug 2025 13:02:51 +0000
Date: Wed, 13 Aug 2025 21:01:52 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD SUCCESS
 8a013ec9cb7af9921656c0e78c73510c9e4a0cc1
Message-ID: <202508132141.snmerAEk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: 8a013ec9cb7af9921656c0e78c73510c9e4a0cc1  cgroup: Replace deprecated strcpy() with strscpy()

elapsed time: 1057m

configs tested: 221
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250813    clang-22
arc                   randconfig-001-20250813    gcc-11.5.0
arc                   randconfig-002-20250813    clang-22
arc                   randconfig-002-20250813    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250813    clang-22
arm                   randconfig-002-20250813    clang-22
arm                   randconfig-002-20250813    gcc-8.5.0
arm                   randconfig-003-20250813    clang-22
arm                   randconfig-004-20250813    clang-22
arm                   randconfig-004-20250813    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250813    clang-22
arm64                 randconfig-002-20250813    clang-22
arm64                 randconfig-002-20250813    gcc-12.5.0
arm64                 randconfig-003-20250813    clang-22
arm64                 randconfig-004-20250813    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250813    clang-20
csky                  randconfig-001-20250813    gcc-14.3.0
csky                  randconfig-002-20250813    clang-20
csky                  randconfig-002-20250813    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250813    clang-20
hexagon               randconfig-001-20250813    clang-22
hexagon               randconfig-002-20250813    clang-20
hexagon               randconfig-002-20250813    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250813    gcc-11
i386        buildonly-randconfig-002-20250813    clang-20
i386        buildonly-randconfig-002-20250813    gcc-11
i386        buildonly-randconfig-003-20250813    gcc-11
i386        buildonly-randconfig-004-20250813    clang-20
i386        buildonly-randconfig-004-20250813    gcc-11
i386        buildonly-randconfig-005-20250813    gcc-11
i386        buildonly-randconfig-005-20250813    gcc-12
i386        buildonly-randconfig-006-20250813    gcc-11
i386        buildonly-randconfig-006-20250813    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250813    clang-20
i386                  randconfig-002-20250813    clang-20
i386                  randconfig-003-20250813    clang-20
i386                  randconfig-004-20250813    clang-20
i386                  randconfig-005-20250813    clang-20
i386                  randconfig-006-20250813    clang-20
i386                  randconfig-007-20250813    clang-20
i386                  randconfig-011-20250813    gcc-11
i386                  randconfig-012-20250813    gcc-11
i386                  randconfig-013-20250813    gcc-11
i386                  randconfig-014-20250813    gcc-11
i386                  randconfig-015-20250813    gcc-11
i386                  randconfig-016-20250813    gcc-11
i386                  randconfig-017-20250813    gcc-11
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250813    clang-19
loongarch             randconfig-001-20250813    clang-20
loongarch             randconfig-002-20250813    clang-20
loongarch             randconfig-002-20250813    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
mips                           ci20_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250813    clang-20
nios2                 randconfig-001-20250813    gcc-11.5.0
nios2                 randconfig-002-20250813    clang-20
nios2                 randconfig-002-20250813    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250813    clang-20
parisc                randconfig-001-20250813    gcc-14.3.0
parisc                randconfig-002-20250813    clang-20
parisc                randconfig-002-20250813    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250813    clang-18
powerpc               randconfig-001-20250813    clang-20
powerpc               randconfig-002-20250813    clang-20
powerpc               randconfig-002-20250813    clang-22
powerpc               randconfig-003-20250813    clang-20
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250813    clang-20
powerpc64             randconfig-001-20250813    clang-22
powerpc64             randconfig-002-20250813    clang-20
powerpc64             randconfig-002-20250813    gcc-8.5.0
powerpc64             randconfig-003-20250813    clang-17
powerpc64             randconfig-003-20250813    clang-20
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250813    clang-22
riscv                 randconfig-002-20250813    clang-22
riscv                 randconfig-002-20250813    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250813    clang-22
s390                  randconfig-002-20250813    clang-18
s390                  randconfig-002-20250813    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250813    clang-22
sh                    randconfig-001-20250813    gcc-9.5.0
sh                    randconfig-002-20250813    clang-22
sh                    randconfig-002-20250813    gcc-9.5.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250813    clang-22
sparc                 randconfig-001-20250813    gcc-8.5.0
sparc                 randconfig-002-20250813    clang-22
sparc                 randconfig-002-20250813    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250813    clang-22
sparc64               randconfig-001-20250813    gcc-8.5.0
sparc64               randconfig-002-20250813    clang-20
sparc64               randconfig-002-20250813    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250813    clang-22
um                    randconfig-001-20250813    gcc-12
um                    randconfig-002-20250813    clang-22
um                    randconfig-002-20250813    gcc-11
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250813    gcc-12
x86_64      buildonly-randconfig-002-20250813    clang-20
x86_64      buildonly-randconfig-003-20250813    gcc-12
x86_64      buildonly-randconfig-004-20250813    clang-20
x86_64      buildonly-randconfig-005-20250813    clang-20
x86_64      buildonly-randconfig-006-20250813    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250813    gcc-12
x86_64                randconfig-002-20250813    gcc-12
x86_64                randconfig-003-20250813    gcc-12
x86_64                randconfig-004-20250813    gcc-12
x86_64                randconfig-005-20250813    gcc-12
x86_64                randconfig-006-20250813    gcc-12
x86_64                randconfig-007-20250813    gcc-12
x86_64                randconfig-008-20250813    gcc-12
x86_64                randconfig-071-20250813    clang-20
x86_64                randconfig-072-20250813    clang-20
x86_64                randconfig-073-20250813    clang-20
x86_64                randconfig-074-20250813    clang-20
x86_64                randconfig-075-20250813    clang-20
x86_64                randconfig-076-20250813    clang-20
x86_64                randconfig-077-20250813    clang-20
x86_64                randconfig-078-20250813    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250813    clang-22
xtensa                randconfig-001-20250813    gcc-10.5.0
xtensa                randconfig-002-20250813    clang-22
xtensa                randconfig-002-20250813    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

