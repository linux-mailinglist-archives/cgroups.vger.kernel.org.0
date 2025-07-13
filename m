Return-Path: <cgroups+bounces-8716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A4B02EE7
	for <lists+cgroups@lfdr.de>; Sun, 13 Jul 2025 08:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF34A2402
	for <lists+cgroups@lfdr.de>; Sun, 13 Jul 2025 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297519342F;
	Sun, 13 Jul 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tu+T2WKj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342D17A2F7
	for <cgroups@vger.kernel.org>; Sun, 13 Jul 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388392; cv=none; b=gbqD2fKdPGYnq8oziw8wzWgF17WXuqUT9CAPZU9UKk9Dqkb5reKkp5//4yEsl0gb8lOaQb3KAeRzRBnoy3uHHNnLlZeQWLuy4OnFcb0pL1V/QsZ7v55AVOFhPwGhB9Qat2nKwTru7xRmy74B4+HZ2FLG/KYV9vDdNOC13GeSS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388392; c=relaxed/simple;
	bh=97V3pfnK/HYYjueH7RWLkfDlVP/RXPl5hqP9pm1AN6g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FbUx7KSqv9TMruyy8DUr//XKAyF9FXZz3nw5CbxDu9uvOLsbhocioBIwwCTKh2YpKz8DmOzW4LoIKOH84Kbwu2EpB18s9G45LPUUCxEo63Zgwx64XJVIcKyCEvWlBdQ+u+SFqTlcoFxNMtTaBdAllb5CAUa/uEuMj1MDi8FvaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tu+T2WKj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752388391; x=1783924391;
  h=date:from:to:cc:subject:message-id;
  bh=97V3pfnK/HYYjueH7RWLkfDlVP/RXPl5hqP9pm1AN6g=;
  b=Tu+T2WKjd+GJXKpbWJGpAZHk9H2F6pCDNkLLVMgq+HcFytDrNZ+0KdNU
   HPnvJUBda1GObgL1jKrLAKvuCgiXe0VjMAgvY1JqN6Ef94+PwVq+D7orG
   E2NyGCpDYK85HIpzyl0lqZFbxIlO4U6EClSoY+Etux7gunAhhvOJnftph
   lITV7IUXqeRRtDq+ljmWlmm+bsjjaT+wOqred5S41b4Pgx3gUoYu8/1+u
   Mg392HYbDmPAqlUeu2j+/sPtrVKqtzZSOUzRNy3BgzZMfSy/AmacnYWau
   ZS1ZHbVQbBH9FE5GWuS+IrmF3KlkubV4pJIUISMYbWkj0w6Pf8wOXlwjP
   Q==;
X-CSE-ConnectionGUID: HAvqqKlRSl2o36BfYcMwHw==
X-CSE-MsgGUID: zljgETQNRAuJMKkFCQvNVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42252957"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="42252957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 23:33:10 -0700
X-CSE-ConnectionGUID: pkb7CgQoSoGKzWwsk6jyCg==
X-CSE-MsgGUID: xcApsLMqRoGe9l+Ue+t3aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="180364161"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jul 2025 23:33:09 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaqGo-0007wV-34;
	Sun, 13 Jul 2025 06:33:06 +0000
Date: Sun, 13 Jul 2025 14:32:48 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.17] BUILD SUCCESS
 e07caae73557d144a9237fb977dfee08befa015f
Message-ID: <202507131436.0Mf21CxS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.17
branch HEAD: e07caae73557d144a9237fb977dfee08befa015f  selftests: cgroup: Fix missing newline in test_zswap_writeback_one

elapsed time: 762m

configs tested: 126
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250713    gcc-11.5.0
arc                   randconfig-002-20250713    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-21
arm                   randconfig-001-20250713    clang-21
arm                   randconfig-002-20250713    gcc-10.5.0
arm                   randconfig-003-20250713    clang-21
arm                   randconfig-004-20250713    gcc-11.5.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250713    gcc-8.5.0
arm64                 randconfig-002-20250713    gcc-13.4.0
arm64                 randconfig-003-20250713    clang-21
arm64                 randconfig-004-20250713    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250713    gcc-15.1.0
csky                  randconfig-002-20250713    gcc-15.1.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250713    clang-21
hexagon               randconfig-002-20250713    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250713    clang-20
i386        buildonly-randconfig-002-20250713    clang-20
i386        buildonly-randconfig-003-20250713    gcc-12
i386        buildonly-randconfig-004-20250713    gcc-12
i386        buildonly-randconfig-005-20250713    clang-20
i386        buildonly-randconfig-006-20250713    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250713    clang-21
loongarch             randconfig-002-20250713    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250713    gcc-11.5.0
nios2                 randconfig-002-20250713    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250713    gcc-8.5.0
parisc                randconfig-002-20250713    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250713    clang-21
powerpc               randconfig-002-20250713    clang-19
powerpc               randconfig-003-20250713    gcc-8.5.0
powerpc64             randconfig-002-20250713    clang-21
powerpc64             randconfig-003-20250713    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250713    clang-20
riscv                 randconfig-002-20250713    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250713    clang-21
s390                  randconfig-002-20250713    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250713    gcc-15.1.0
sh                    randconfig-002-20250713    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250713    gcc-8.5.0
sparc                 randconfig-002-20250713    gcc-10.3.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250713    gcc-8.5.0
sparc64               randconfig-002-20250713    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250713    clang-21
um                    randconfig-002-20250713    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250713    clang-20
x86_64      buildonly-randconfig-002-20250713    clang-20
x86_64      buildonly-randconfig-003-20250713    clang-20
x86_64      buildonly-randconfig-004-20250713    clang-20
x86_64      buildonly-randconfig-005-20250713    clang-20
x86_64      buildonly-randconfig-006-20250713    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250713    gcc-11.5.0
xtensa                randconfig-002-20250713    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

