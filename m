Return-Path: <cgroups+bounces-12167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3BC7CECD
	for <lists+cgroups@lfdr.de>; Sat, 22 Nov 2025 12:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9B63A2507
	for <lists+cgroups@lfdr.de>; Sat, 22 Nov 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D22147E6;
	Sat, 22 Nov 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRHM2MD9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74334C97
	for <cgroups@vger.kernel.org>; Sat, 22 Nov 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812089; cv=none; b=YyjJLPCfvniuLImcT/8fpEc1pYajXQxC4PUEa/c0YmkzTUjhnmAzb0cAzXwdgMdMH07DhTXKPD6/etKBVJwobas7feVfRpboxGwQBWwgbXCCI90mLh5NaMRgrQDC7lB1V06TXUIOnbNcWCmaYsPp1aRRFofCmS1CmYs3sFU13kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812089; c=relaxed/simple;
	bh=8uge28Wc0+NgfTlViK256kEfZTIjLgMLVIkFVKPsoiM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dCpy1sYlRwwglTzx3tV6EnhwdX3DI18HqyN2l6cCB2dSNJ5SnV4UZ5JCmQX/xLRX+juD0V15a8MfUfEGPbh/yJUkwWfAt3WIQDPv1OZCFrUT6iZLAW3dkcWqo2dhN/Bl8lBzqFamzLv2gW3xE+kavB3CCfEaPmPyCngcP76zYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRHM2MD9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763812088; x=1795348088;
  h=date:from:to:cc:subject:message-id;
  bh=8uge28Wc0+NgfTlViK256kEfZTIjLgMLVIkFVKPsoiM=;
  b=VRHM2MD9Ma1Hgay7t0iuo210SzcH8oSqqpEWQshQ3k1/XYo4O5Q/NB5Z
   ud5XZWtylD+089xjq0tdVnTt8KGwocBylYdGyucc3RpyCg9sMVo8KuihN
   l0w5ntKOyDVm4Gb1VLFOvx33rSJp3zUm9KtzL7b06dABRoEsiTPEyPXNP
   vK6SXYarnNlJuB+51D2pJ7n4Y6o3TZOsMb79E1TD+7PAeEiIPKN+22KcF
   NQGzowe7lkWgCIMHxI1FTOsUPYvhXLnR0hHcyT0DR5B7YIkGZXuH4Lpss
   U0j8JDamqg6FWs1QUqAU/+n8sJF1IWOVkGpKxO6WBx3BFy9F/DVp0GWGt
   A==;
X-CSE-ConnectionGUID: b1zOxSSmQfSYi9DvU0eILA==
X-CSE-MsgGUID: jg2PjMP8QKae34Yj5t7wPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="88541264"
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="88541264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 03:48:07 -0800
X-CSE-ConnectionGUID: SWa3vEInTO6SpiJZIMplLA==
X-CSE-MsgGUID: 8XpBxc8OS5qPmSK10INLWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="196077502"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Nov 2025 03:48:07 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMm60-0007Se-03;
	Sat, 22 Nov 2025 11:48:04 +0000
Date: Sat, 22 Nov 2025 19:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 b1bcaed1e39a9e0dfbe324a15d2ca4253deda316
Message-ID: <202511221933.qCka4DZU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: b1bcaed1e39a9e0dfbe324a15d2ca4253deda316  cpuset: Treat cpusets in attaching as populated

elapsed time: 1998m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251122    gcc-14.3.0
arc                   randconfig-002-20251122    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20251122    clang-22
arm                   randconfig-002-20251122    clang-22
arm                   randconfig-003-20251122    clang-22
arm                   randconfig-004-20251122    gcc-12.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251122    gcc-8.5.0
arm64                 randconfig-002-20251122    gcc-9.5.0
arm64                 randconfig-003-20251122    gcc-10.5.0
arm64                 randconfig-004-20251122    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251122    gcc-15.1.0
csky                  randconfig-002-20251122    gcc-14.3.0
hexagon                          alldefconfig    clang-22
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251121    clang-22
hexagon               randconfig-002-20251121    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251122    clang-20
i386        buildonly-randconfig-002-20251122    clang-20
i386        buildonly-randconfig-003-20251122    gcc-14
i386        buildonly-randconfig-004-20251122    clang-20
i386        buildonly-randconfig-005-20251122    clang-20
i386        buildonly-randconfig-006-20251122    clang-20
i386                  randconfig-001-20251122    clang-20
i386                  randconfig-002-20251122    gcc-13
i386                  randconfig-003-20251122    clang-20
i386                  randconfig-004-20251122    clang-20
i386                  randconfig-005-20251122    clang-20
i386                  randconfig-006-20251122    clang-20
i386                  randconfig-007-20251122    clang-20
i386                  randconfig-011-20251122    gcc-14
i386                  randconfig-012-20251122    clang-20
i386                  randconfig-013-20251122    clang-20
i386                  randconfig-014-20251122    gcc-14
i386                  randconfig-015-20251122    clang-20
i386                  randconfig-016-20251122    gcc-12
i386                  randconfig-017-20251122    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251121    gcc-15.1.0
loongarch             randconfig-002-20251121    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           mtx1_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251121    gcc-11.5.0
nios2                 randconfig-002-20251121    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251122    gcc-14.3.0
parisc                randconfig-002-20251122    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251122    clang-16
powerpc64             randconfig-001-20251122    clang-17
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251122    clang-22
riscv                 randconfig-002-20251122    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251122    clang-16
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251122    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251122    gcc-13.4.0
sparc                 randconfig-002-20251122    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251122    gcc-13.4.0
sparc64               randconfig-002-20251122    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251122    clang-22
um                    randconfig-002-20251122    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251122    gcc-14
x86_64      buildonly-randconfig-002-20251122    gcc-14
x86_64      buildonly-randconfig-003-20251122    gcc-14
x86_64      buildonly-randconfig-004-20251122    clang-20
x86_64      buildonly-randconfig-005-20251122    gcc-14
x86_64      buildonly-randconfig-006-20251122    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251122    gcc-14
x86_64                randconfig-072-20251122    gcc-14
x86_64                randconfig-073-20251122    clang-20
x86_64                randconfig-074-20251122    gcc-14
x86_64                randconfig-075-20251122    clang-20
x86_64                randconfig-076-20251122    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251122    gcc-12.5.0
xtensa                randconfig-002-20251122    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

