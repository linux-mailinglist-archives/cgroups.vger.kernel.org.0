Return-Path: <cgroups+bounces-8483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62621AD4819
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C220189EFDE
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75207145B25;
	Wed, 11 Jun 2025 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2Cs8hGl"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94620154BFE
	for <cgroups@vger.kernel.org>; Wed, 11 Jun 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749606114; cv=none; b=GA7iQ3JioyfnEjqy0VByRnggWs6mY46o7aO9iu1yJwF2iEjztR40giZ6dsFW3D/l4WH+zG7QG3GYdya2lR6GoDJ9lhJJl+riWZZCNpkurFDqSKaMUSpxtCLz7RqSQ36MJu/ksjQ2rSyYxtrRi4SLVLCpq3Xa997ljpsifms+8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749606114; c=relaxed/simple;
	bh=Go1d8pdGlQjiB0YezcQqesI+cwmDNaT7ZGpPEPhADKA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KYw4+FysFOQZdYki1JnX+PCmHsjr4gyKR+YHh0WHmso+aoc47MxPCEEKmDImcUvBTRSdkC6LTcucIHQhnSRXMmSW5TMstlgnz9LVwEMcf4F8Yl4SDHicQ8Fk275bYKEBdnLbc6Htaw1slLVbdVkka//yKDnx2DKyIYYrdzo66w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2Cs8hGl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749606113; x=1781142113;
  h=date:from:to:cc:subject:message-id;
  bh=Go1d8pdGlQjiB0YezcQqesI+cwmDNaT7ZGpPEPhADKA=;
  b=i2Cs8hGl1VTOp2nAC+LQoalmfBVVnqMHI3qk2lK6r5ukTw8UKpWHeFEv
   7VC/CVtIr0dpV3w6vK3JsMEOfEluUHrBdPA11PhV/NwZZoXrcypbWY7Pw
   wKofxKXpXgMaOqYxdL2qydN2utwfqBR8mHzr9/QReKOEfUEUZ8QAAHoHr
   ZO4dZsaSeJprTrs0025uWXVlnXuUtKz2dYx6MRDPSKwNxWqObZ/sefteV
   CgCi7wBBUsSTYRU6KY1dJhX8Pg5/LpeeECJQwjgTYV5dJxbNMcbYR6FV4
   lNMA6o/yN4FBWhFswQJhRkL5mbtxxhjQlHr+Lwn1HxtgruOpz3WJy25ew
   Q==;
X-CSE-ConnectionGUID: xDlZ08EBTfOJOUJ/tvEFqA==
X-CSE-MsgGUID: mUwY541MRH2n1uKvbjhYsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51613774"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="51613774"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 18:41:53 -0700
X-CSE-ConnectionGUID: a096xnBwQGmRY87YC5rMJA==
X-CSE-MsgGUID: AysiGc3sTD+IVSXfAgv1bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="147953360"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 18:41:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uP401-0008fh-19;
	Tue, 10 Jun 2025 18:47:05 +0000
Date: Wed, 11 Jun 2025 02:46:15 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.17] BUILD SUCCESS
 38b9342ee62e9a1a868654ba6619de9da251bd57
Message-ID: <202506110205.ex1sWseE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.17
branch HEAD: 38b9342ee62e9a1a868654ba6619de9da251bd57  Documentation: cgroup: add section explaining controller availability

elapsed time: 1447m

configs tested: 238
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250610    gcc-12.4.0
arc                   randconfig-002-20250610    gcc-12.4.0
arc                   randconfig-002-20250610    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250610    clang-19
arm                   randconfig-001-20250610    gcc-12.4.0
arm                   randconfig-002-20250610    gcc-12.4.0
arm                   randconfig-002-20250610    gcc-8.5.0
arm                   randconfig-003-20250610    clang-21
arm                   randconfig-003-20250610    gcc-12.4.0
arm                   randconfig-004-20250610    clang-16
arm                   randconfig-004-20250610    gcc-12.4.0
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250610    clang-21
arm64                 randconfig-001-20250610    gcc-12.4.0
arm64                 randconfig-002-20250610    gcc-11.5.0
arm64                 randconfig-002-20250610    gcc-12.4.0
arm64                 randconfig-003-20250610    clang-21
arm64                 randconfig-003-20250610    gcc-12.4.0
arm64                 randconfig-004-20250610    clang-18
arm64                 randconfig-004-20250610    gcc-12.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250610    gcc-12.4.0
csky                  randconfig-001-20250610    gcc-15.1.0
csky                  randconfig-002-20250610    gcc-14.3.0
csky                  randconfig-002-20250610    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250610    clang-21
hexagon               randconfig-001-20250610    gcc-15.1.0
hexagon               randconfig-002-20250610    clang-21
hexagon               randconfig-002-20250610    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250610    clang-20
i386        buildonly-randconfig-002-20250610    clang-20
i386        buildonly-randconfig-003-20250610    clang-20
i386        buildonly-randconfig-004-20250610    clang-20
i386        buildonly-randconfig-004-20250610    gcc-12
i386        buildonly-randconfig-005-20250610    clang-20
i386        buildonly-randconfig-006-20250610    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250610    clang-20
i386                  randconfig-002-20250610    clang-20
i386                  randconfig-003-20250610    clang-20
i386                  randconfig-004-20250610    clang-20
i386                  randconfig-005-20250610    clang-20
i386                  randconfig-006-20250610    clang-20
i386                  randconfig-007-20250610    clang-20
i386                  randconfig-011-20250610    clang-20
i386                  randconfig-012-20250610    clang-20
i386                  randconfig-013-20250610    clang-20
i386                  randconfig-014-20250610    clang-20
i386                  randconfig-015-20250610    clang-20
i386                  randconfig-016-20250610    clang-20
i386                  randconfig-017-20250610    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch                 loongson3_defconfig    gcc-15.1.0
loongarch             randconfig-001-20250610    gcc-15.1.0
loongarch             randconfig-002-20250610    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250610    gcc-15.1.0
nios2                 randconfig-001-20250610    gcc-8.5.0
nios2                 randconfig-002-20250610    gcc-13.3.0
nios2                 randconfig-002-20250610    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250610    gcc-10.5.0
parisc                randconfig-001-20250610    gcc-15.1.0
parisc                randconfig-002-20250610    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    gcc-15.1.0
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250610    gcc-10.5.0
powerpc               randconfig-001-20250610    gcc-15.1.0
powerpc               randconfig-002-20250610    gcc-15.1.0
powerpc               randconfig-002-20250610    gcc-8.5.0
powerpc               randconfig-003-20250610    clang-21
powerpc               randconfig-003-20250610    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250610    clang-21
powerpc64             randconfig-001-20250610    gcc-15.1.0
powerpc64             randconfig-002-20250610    clang-21
powerpc64             randconfig-002-20250610    gcc-15.1.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20250610    gcc-14.3.0
riscv                 randconfig-001-20250610    gcc-9.3.0
riscv                 randconfig-002-20250610    clang-16
riscv                 randconfig-002-20250610    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250610    gcc-8.5.0
s390                  randconfig-001-20250610    gcc-9.3.0
s390                  randconfig-002-20250610    gcc-14.3.0
s390                  randconfig-002-20250610    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20250610    gcc-9.3.0
sh                    randconfig-002-20250610    gcc-15.1.0
sh                    randconfig-002-20250610    gcc-9.3.0
sh                          rsk7264_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250610    gcc-15.1.0
sparc                 randconfig-001-20250610    gcc-9.3.0
sparc                 randconfig-002-20250610    gcc-12.4.0
sparc                 randconfig-002-20250610    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250610    gcc-8.5.0
sparc64               randconfig-001-20250610    gcc-9.3.0
sparc64               randconfig-002-20250610    gcc-8.5.0
sparc64               randconfig-002-20250610    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250610    gcc-11
um                    randconfig-001-20250610    gcc-9.3.0
um                    randconfig-002-20250610    gcc-12
um                    randconfig-002-20250610    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250610    clang-20
x86_64      buildonly-randconfig-001-20250610    gcc-12
x86_64      buildonly-randconfig-002-20250610    gcc-12
x86_64      buildonly-randconfig-003-20250610    clang-20
x86_64      buildonly-randconfig-003-20250610    gcc-12
x86_64      buildonly-randconfig-004-20250610    clang-20
x86_64      buildonly-randconfig-004-20250610    gcc-12
x86_64      buildonly-randconfig-005-20250610    gcc-12
x86_64      buildonly-randconfig-006-20250610    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250610    clang-20
x86_64                randconfig-002-20250610    clang-20
x86_64                randconfig-003-20250610    clang-20
x86_64                randconfig-004-20250610    clang-20
x86_64                randconfig-005-20250610    clang-20
x86_64                randconfig-006-20250610    clang-20
x86_64                randconfig-007-20250610    clang-20
x86_64                randconfig-008-20250610    clang-20
x86_64                randconfig-071-20250610    clang-20
x86_64                randconfig-072-20250610    clang-20
x86_64                randconfig-073-20250610    clang-20
x86_64                randconfig-074-20250610    clang-20
x86_64                randconfig-075-20250610    clang-20
x86_64                randconfig-076-20250610    clang-20
x86_64                randconfig-077-20250610    clang-20
x86_64                randconfig-078-20250610    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250610    gcc-11.5.0
xtensa                randconfig-001-20250610    gcc-9.3.0
xtensa                randconfig-002-20250610    gcc-12.4.0
xtensa                randconfig-002-20250610    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

