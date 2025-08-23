Return-Path: <cgroups+bounces-9356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0CB32B68
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 19:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D61AA05F2
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD59245014;
	Sat, 23 Aug 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLuKwWTY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598118F40
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971840; cv=none; b=JNyWReq3btmxyJPLeaw0bSqHxZFYwXmfVtrnLcdIy1P32p5ChNv3BsiSiRhkZCsbiMq8LMXRorU0pyl918dFufiQ93+GQHnB5qiZ/ybo/WqBEitkAvcVK1LLavu6cwjPFdkpksikcEiOVbWH8ZPeNofTnLFwsmS5aisumUNKU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971840; c=relaxed/simple;
	bh=SEVPt3cuTF32B/nZsJSlTeVycme/hLW6T43ctiZn4go=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MirDi6w57N1D8TNCC+scw80yxHYrZBu8X6pn14fwh1Bf9ym6x1sGNcwMr4nhqrImkuKqRUqJkdCXe1860HEmu4Bqbffzn+FqIo+3L4ZdANY9RF++CkqOFdws9n4Mb1SC+JGfRmACbde/aonp1QQ/S52CquZ2KYhGui8VjBqMPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLuKwWTY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755971839; x=1787507839;
  h=date:from:to:cc:subject:message-id;
  bh=SEVPt3cuTF32B/nZsJSlTeVycme/hLW6T43ctiZn4go=;
  b=aLuKwWTYA6RSH+x3CytP2YN4lv7bL0YvuVc8x5qp9dcLmnA+b2vE6RSO
   cwUjJCB9/N7M4WRvALZdSnU+hUVV9cRvYkpNgxzGb3TTqPuIILnlUsaEC
   8YjvVu9Ya9BLgDU2GKbLnD//hFTAXQiXYhHJ/M1P5aHCCI+cF4p0BUY3G
   Cq+3uUR7gwK8Nc5mML1QP+sTfYcKGi5sOUblEgIAMqFQFBUkGmQZAMpmG
   sJn0n4rY8bIKGUkkMcqhDZSfKjvSNog23ccmAa68bt+af3qwGOQ0uPetS
   aAF7Q3UVcOnFhn5WeRt4bduA7ajJzRO6HyS9haSUC9omxIw2d1G1hJQaB
   A==;
X-CSE-ConnectionGUID: JVT/ZzyZQ4CMefL5Yx8sdg==
X-CSE-MsgGUID: K3gkbgyiQz6yeIsVW3b0vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62075555"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62075555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 10:57:18 -0700
X-CSE-ConnectionGUID: ywlhsPFlSo2F6BGfmEKTYw==
X-CSE-MsgGUID: /wjxVcfJQvSdqQreoMkndg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="192613446"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 23 Aug 2025 10:57:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upsUM-000MUP-1f;
	Sat, 23 Aug 2025 17:57:14 +0000
Date: Sun, 24 Aug 2025 01:56:37 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD REGRESSION
 7b281a4582c4408add22cc99f221886b50dd0548
Message-ID: <202508240129.4sU0Ci3p-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: 7b281a4582c4408add22cc99f221886b50dd0548  cgroup: selftests: Add tests for freezer time

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202508230604.KyvqOy81-lkp@intel.com

    cgroup.c:(.text+0x22e4): undefined reference to `__udivdi3'
    cgroup.c:(.text+0x39e4): undefined reference to `__udivdi3'
    cgroup.c:(.text+0x4838): undefined reference to `__udivdi3'
    cgroup.c:(.text+0x8544): undefined reference to `__udivdi3'
    include/linux/list.h:219:(.text+0x2173): undefined reference to `__udivdi3'
    kernel/cgroup/cgroup.c:3781:(.text+0x28f4): dangerous relocation: unsupported relocation
    kernel/cgroup/cgroup.c:3781:(.text+0x28f4): undefined reference to `__aeabi_uldivmod'
    kernel/cgroup/cgroup.c:3781:(.text+0x38e4): undefined reference to `__aeabi_uldivmod'
    kernel/cgroup/cgroup.c:3869:(.text+0x2048): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-002-20250823
|   |-- kernel-cgroup-cgroup.c:(.text):dangerous-relocation:unsupported-relocation
|   `-- kernel-cgroup-cgroup.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- arm-socfpga_defconfig
|   `-- kernel-cgroup-cgroup.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- i386-allmodconfig
|   `-- cgroup.c:(.text):undefined-reference-to-__udivdi3
|-- i386-allyesconfig
|   `-- cgroup.c:(.text):undefined-reference-to-__udivdi3
|-- sh-defconfig
|   `-- cgroup.c:(.text):undefined-reference-to-__udivdi3
|-- sh-randconfig-002-20250823
|   `-- cgroup.c:(.text):undefined-reference-to-__udivdi3
|-- xtensa-randconfig-001-20250823
|   |-- include-linux-list.h:(.text):undefined-reference-to-__udivdi3
|   `-- kernel-cgroup-cgroup.c:(.text):undefined-reference-to-__udivdi3
`-- xtensa-randconfig-002-20250823
    `-- cgroup.c:(.text):undefined-reference-to-__udivdi3

elapsed time: 1436m

configs tested: 124
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250823    gcc-9.5.0
arc                   randconfig-002-20250823    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250823    clang-17
arm                   randconfig-002-20250823    gcc-15.1.0
arm                   randconfig-003-20250823    clang-20
arm                   randconfig-004-20250823    clang-22
arm                         socfpga_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250823    gcc-11.5.0
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-004-20250823    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250823    gcc-15.1.0
csky                  randconfig-002-20250823    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250823    clang-22
hexagon               randconfig-002-20250823    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-006-20250823    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250823    clang-22
loongarch             randconfig-002-20250823    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250823    gcc-11.5.0
nios2                 randconfig-002-20250823    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250823    gcc-8.5.0
parisc                randconfig-002-20250823    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250823    clang-22
powerpc               randconfig-002-20250823    clang-22
powerpc               randconfig-003-20250823    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250823    gcc-11.5.0
powerpc64             randconfig-002-20250823    clang-22
powerpc64             randconfig-003-20250823    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-002-20250823    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250823    gcc-9.5.0
s390                  randconfig-002-20250823    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250823    gcc-15.1.0
sh                    randconfig-002-20250823    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    gcc-8.5.0
sparc                 randconfig-002-20250823    gcc-8.5.0
sparc64               randconfig-001-20250823    gcc-8.5.0
sparc64               randconfig-002-20250823    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250823    clang-22
um                    randconfig-002-20250823    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-003-20250823    clang-20
x86_64      buildonly-randconfig-004-20250823    clang-20
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250823    gcc-15.1.0
xtensa                randconfig-002-20250823    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

