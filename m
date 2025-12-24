Return-Path: <cgroups+bounces-12632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86BCDB56B
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 05:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ED783020222
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6AB283159;
	Wed, 24 Dec 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCTrpWVK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E21AA1D2
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550838; cv=none; b=lRdMlRmATY0QgA0AmSDkMEiq46JVyjPGZs7TfqiAKXbCw3RQqYUFHraDVjGfTbAlmoC9GszOH8Qo205eAgP7Uqo6n0hulIXyiSNgoiW9X3eCGSNB4wfIcMYnLzngXeuXpo553Okcndr8y6zU6eoFfqSl/9VggDogJm+i8yYyJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550838; c=relaxed/simple;
	bh=I/WutQA3J/rMorzoJVYwntEDEBNlIsH4z2qeZfwH7IU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lXZ+A3JiAt04sGmeLvQYUG5V0QspgVDf+4Ub8fLFpVwt3AoyANWXbYtM3VtmKnL2M/vsm+tcYhISqV0G+gwTtWtVd061uTaRc4qtdeUyXjGhi9z+4kPQKkYyWXrxmM8kmxLELzqcsSR3B4cDVb7fD7AnpUxd7lJuyzFh3tpkeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCTrpWVK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766550837; x=1798086837;
  h=date:from:to:cc:subject:message-id;
  bh=I/WutQA3J/rMorzoJVYwntEDEBNlIsH4z2qeZfwH7IU=;
  b=BCTrpWVKxMcopna/tnClf/jhw7fsTKgK4F+kgB6wI/zEqPPNL1cVPmog
   b5bcoTaRAhzdl6IOlJPktPYWYgipyLioC1ghw7WinhaKV0vrCJd9+VZkw
   3b2n+7LcbelSDKSKSOr45T4wUiooM7ga3QqRdcjzJDntNkhT9UMDDmdBZ
   dUX2g7SSNPKzaiw+FSiXVw+g9NxmRc7LzC7TJJu9GQ812hDFlU6CfVojT
   GWaSxOaveYUYKtWA3rzmgUGVsuUhyBzjGWzU2fl+O0vjy4SCMlJOill0m
   Rm/t4UA1BRargci0tCuKC3dndq5BiC69mfbVNmV/RQn0dhshaSHX/XVmP
   Q==;
X-CSE-ConnectionGUID: yzRdFokqScmqT3rMmmyUBA==
X-CSE-MsgGUID: d29C805TRSOxGXWcqF5OPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68436099"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="68436099"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 20:33:56 -0800
X-CSE-ConnectionGUID: OsqCZmubQLuF9g2zq1EZ/A==
X-CSE-MsgGUID: GaMjpUyDTvqE1BgnJSXXXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="199914389"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Dec 2025 20:33:53 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYGZM-000000002fV-30z1;
	Wed, 24 Dec 2025 04:33:52 +0000
Date: Wed, 24 Dec 2025 12:32:53 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.20] BUILD SUCCESS
 269679bdd17cdd4dc3f1f2448f76554932d7de3f
Message-ID: <202512241248.Hc3OSTTm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.20
branch HEAD: 269679bdd17cdd4dc3f1f2448f76554932d7de3f  cpuset: remove dead code in cpuset-v1.c

elapsed time: 1249m

configs tested: 194
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251224    gcc-12.5.0
arc                   randconfig-002-20251224    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                   randconfig-001-20251224    gcc-8.5.0
arm                   randconfig-002-20251224    gcc-8.5.0
arm                   randconfig-003-20251224    gcc-12.5.0
arm                   randconfig-004-20251224    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251224    gcc-15.1.0
arm64                 randconfig-001-20251224    gcc-8.5.0
arm64                 randconfig-002-20251224    gcc-14.3.0
arm64                 randconfig-002-20251224    gcc-15.1.0
arm64                 randconfig-003-20251224    clang-17
arm64                 randconfig-003-20251224    gcc-15.1.0
arm64                 randconfig-004-20251224    gcc-10.5.0
arm64                 randconfig-004-20251224    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251224    gcc-15.1.0
csky                  randconfig-002-20251224    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251223    clang-22
hexagon               randconfig-002-20251223    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251224    clang-20
i386        buildonly-randconfig-002-20251224    gcc-14
i386        buildonly-randconfig-003-20251224    clang-20
i386        buildonly-randconfig-004-20251224    gcc-12
i386        buildonly-randconfig-005-20251224    gcc-14
i386        buildonly-randconfig-006-20251224    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251224    gcc-14
i386                  randconfig-002-20251224    gcc-14
i386                  randconfig-003-20251224    gcc-14
i386                  randconfig-004-20251224    gcc-12
i386                  randconfig-005-20251224    clang-20
i386                  randconfig-006-20251224    clang-20
i386                  randconfig-007-20251224    gcc-14
i386                  randconfig-014-20251224    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251223    gcc-15.1.0
loongarch             randconfig-002-20251223    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251223    gcc-11.5.0
nios2                 randconfig-002-20251223    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251224    clang-22
parisc                randconfig-001-20251224    gcc-8.5.0
parisc                randconfig-002-20251224    clang-22
parisc                randconfig-002-20251224    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc               randconfig-001-20251224    clang-22
powerpc               randconfig-002-20251224    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251224    clang-22
powerpc64             randconfig-001-20251224    gcc-8.5.0
powerpc64             randconfig-002-20251224    clang-22
powerpc64             randconfig-002-20251224    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251224    gcc-8.5.0
riscv                 randconfig-002-20251224    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251224    gcc-10.5.0
s390                  randconfig-002-20251224    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20251224    gcc-14.3.0
sh                    randconfig-002-20251224    gcc-10.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251224    gcc-8.5.0
sparc                 randconfig-002-20251224    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251224    gcc-8.5.0
sparc64               randconfig-002-20251224    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251224    gcc-14
um                    randconfig-002-20251224    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251224    clang-20
x86_64      buildonly-randconfig-002-20251224    gcc-14
x86_64      buildonly-randconfig-003-20251224    gcc-14
x86_64      buildonly-randconfig-004-20251224    clang-20
x86_64      buildonly-randconfig-005-20251224    gcc-14
x86_64      buildonly-randconfig-006-20251224    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251224    gcc-14
x86_64                randconfig-002-20251224    gcc-14
x86_64                randconfig-003-20251224    gcc-14
x86_64                randconfig-004-20251224    gcc-14
x86_64                randconfig-005-20251224    gcc-14
x86_64                randconfig-006-20251224    gcc-14
x86_64                randconfig-011-20251224    gcc-14
x86_64                randconfig-012-20251224    gcc-14
x86_64                randconfig-013-20251224    clang-20
x86_64                randconfig-013-20251224    gcc-14
x86_64                randconfig-014-20251224    gcc-14
x86_64                randconfig-015-20251224    gcc-14
x86_64                randconfig-016-20251224    gcc-14
x86_64                randconfig-071-20251224    clang-20
x86_64                randconfig-072-20251224    gcc-14
x86_64                randconfig-073-20251224    clang-20
x86_64                randconfig-074-20251224    gcc-14
x86_64                randconfig-075-20251224    clang-20
x86_64                randconfig-076-20251224    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251224    gcc-15.1.0
xtensa                randconfig-002-20251224    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

