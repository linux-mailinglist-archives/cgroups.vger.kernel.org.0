Return-Path: <cgroups+bounces-13283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EFCD3876A
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 21:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EC55303668F
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F53A4AAE;
	Fri, 16 Jan 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS9PmGYX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F218E1F
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594822; cv=none; b=Z6csvvPBHc6kqbGZ1ekLMFXDvJenrKChzFFTHYD+VpxDA1aDQn2AQiqB41XJzkuoZBV2GvgJEqz/G4ZVqiRTB5vJhKcvERyCkbWIM9noSiRey1ZjwCFZmyy/RdLr/7065idkL4DKYSsRaQoVUY8ReJM4qEhM1KbjNS9IjSx2mJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594822; c=relaxed/simple;
	bh=oBehjtgXDSZFWqbKDrv+wKkYpNQiXtqEk1hVUzh2t1s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I4j01ZKEmMpK/Q+2V+WNMtnfl5L1mCeAIem5XOd+W1W/4HyMRoTr5G9zYbFyXt3UMvVkFZstg0pSQ5EvOhaHUtSp8Ry3zQVdhnJtJdGTkzrba40STKRKGqA6wpuyBH1Mg8hgvG/N+oizfgzXJtlK7skT1ObF/R0766Zx6NFV98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS9PmGYX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768594820; x=1800130820;
  h=date:from:to:cc:subject:message-id;
  bh=oBehjtgXDSZFWqbKDrv+wKkYpNQiXtqEk1hVUzh2t1s=;
  b=RS9PmGYXonYpB3Pqb2JHWg7pbRd/a/f7aRBY0g+Lj7YNB+HKmPO5308o
   d2ZtKQqzGt1WfUHwYljCh3SyV2n5oZohgZGcWsdYClygtJq2H6Mp7NRdp
   YqHbwBFaHBQowkv7Dna7MRBNm9rlyFmIVrGF+JAjXphGrlFvogHQ6uu63
   JZl/g5/qHC0HbXtEOcTplAr4vkdVpDYCYtTXLpILneYFhUkN6Zp6WUT+r
   eiugYA58qGqxF3aJbF2LmvDMkVoFBf8VMzKsewJ/v1ajEeVBN4U30wZZy
   eNrYarM0ewzhPGfJuiD+qzGSgM8VBYiL6c4t2EImjYY0m8wYZRbbKDClY
   A==;
X-CSE-ConnectionGUID: OcVzCcS6RwKXgoNkIRuuTw==
X-CSE-MsgGUID: e09uG9rQSiaVuJ6Gn3tJUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="92580264"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="92580264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:20:20 -0800
X-CSE-ConnectionGUID: s+PwjLM7TlCe5rVdETpjcg==
X-CSE-MsgGUID: wXN/iNnsRbO02aa2/pQdrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="205125730"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Jan 2026 12:20:19 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgqIp-00000000LDA-3YZF;
	Fri, 16 Jan 2026 20:20:15 +0000
Date: Sat, 17 Jan 2026 04:19:57 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 02cf958f1e0a85c09abb80380cfe25a7549e0f75
Message-ID: <202601170451.cvluM07x-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 02cf958f1e0a85c09abb80380cfe25a7549e0f75  Merge branch 'for-6.19-fixes' into for-next

elapsed time: 720m

configs tested: 198
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    clang-22
arc                         haps_hs_defconfig    gcc-15.2.0
arc                            hsdk_defconfig    gcc-15.2.0
arc                   randconfig-001-20260116    gcc-13.4.0
arc                   randconfig-001-20260116    gcc-8.5.0
arc                   randconfig-002-20260116    gcc-8.5.0
arc                   randconfig-002-20260116    gcc-9.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                             mxs_defconfig    clang-22
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260116    gcc-15.2.0
arm                   randconfig-001-20260116    gcc-8.5.0
arm                   randconfig-002-20260116    gcc-8.5.0
arm                   randconfig-003-20260116    clang-22
arm                   randconfig-003-20260116    gcc-8.5.0
arm                   randconfig-004-20260116    gcc-8.5.0
arm                        realview_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260116    clang-20
hexagon               randconfig-002-20260116    clang-20
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260116    gcc-12
i386        buildonly-randconfig-002-20260116    gcc-12
i386        buildonly-randconfig-003-20260116    gcc-12
i386        buildonly-randconfig-004-20260116    gcc-12
i386        buildonly-randconfig-005-20260116    gcc-12
i386        buildonly-randconfig-006-20260116    gcc-12
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260116    clang-20
i386                  randconfig-001-20260116    gcc-14
i386                  randconfig-002-20260116    clang-20
i386                  randconfig-003-20260116    clang-20
i386                  randconfig-004-20260116    clang-20
i386                  randconfig-004-20260116    gcc-14
i386                  randconfig-005-20260116    clang-20
i386                  randconfig-005-20260116    gcc-14
i386                  randconfig-006-20260116    clang-20
i386                  randconfig-007-20260116    clang-20
i386                  randconfig-007-20260116    gcc-14
i386                  randconfig-011-20260116    clang-20
i386                  randconfig-012-20260116    clang-20
i386                  randconfig-013-20260116    clang-20
i386                  randconfig-014-20260116    clang-20
i386                  randconfig-015-20260116    clang-20
i386                  randconfig-016-20260116    clang-20
i386                  randconfig-017-20260116    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260116    clang-20
loongarch             randconfig-002-20260116    clang-20
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    clang-22
mips                         bigsur_defconfig    gcc-15.2.0
mips                           ip30_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260116    clang-20
nios2                 randconfig-002-20260116    clang-20
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260116    clang-22
parisc                randconfig-001-20260117    clang-22
parisc                randconfig-002-20260116    clang-22
parisc                randconfig-002-20260117    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-22
powerpc                         ps3_defconfig    clang-22
powerpc               randconfig-001-20260116    clang-22
powerpc               randconfig-001-20260117    clang-22
powerpc               randconfig-002-20260116    clang-22
powerpc               randconfig-002-20260117    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20260116    clang-22
powerpc64             randconfig-001-20260117    clang-22
powerpc64             randconfig-002-20260116    clang-22
powerpc64             randconfig-002-20260117    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260116    gcc-15.2.0
riscv                 randconfig-002-20260116    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260116    gcc-15.2.0
s390                  randconfig-002-20260116    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260116    gcc-15.2.0
sh                    randconfig-002-20260116    gcc-15.2.0
sh                          rsk7269_defconfig    clang-22
sh                           se7750_defconfig    clang-22
sh                           se7750_defconfig    gcc-15.2.0
sh                           se7751_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260116    gcc-10.5.0
sparc                 randconfig-002-20260116    gcc-10.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260116    gcc-10.5.0
sparc64               randconfig-002-20260116    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260116    gcc-10.5.0
um                    randconfig-002-20260116    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260116    gcc-14
x86_64      buildonly-randconfig-002-20260116    gcc-14
x86_64      buildonly-randconfig-003-20260116    gcc-14
x86_64      buildonly-randconfig-004-20260116    gcc-14
x86_64      buildonly-randconfig-005-20260116    gcc-14
x86_64      buildonly-randconfig-006-20260116    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260116    clang-20
x86_64                randconfig-002-20260116    clang-20
x86_64                randconfig-003-20260116    clang-20
x86_64                randconfig-004-20260116    clang-20
x86_64                randconfig-005-20260116    clang-20
x86_64                randconfig-006-20260116    clang-20
x86_64                randconfig-011-20260116    clang-20
x86_64                randconfig-012-20260116    clang-20
x86_64                randconfig-013-20260116    clang-20
x86_64                randconfig-014-20260116    clang-20
x86_64                randconfig-015-20260116    clang-20
x86_64                randconfig-015-20260116    gcc-12
x86_64                randconfig-016-20260116    clang-20
x86_64                randconfig-071-20260116    clang-20
x86_64                randconfig-072-20260116    clang-20
x86_64                randconfig-073-20260116    clang-20
x86_64                randconfig-074-20260116    clang-20
x86_64                randconfig-075-20260116    clang-20
x86_64                randconfig-076-20260116    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260116    gcc-10.5.0
xtensa                randconfig-002-20260116    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

