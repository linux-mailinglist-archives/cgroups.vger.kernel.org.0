Return-Path: <cgroups+bounces-8280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8FAABE539
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD97AA539
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC92135CB;
	Tue, 20 May 2025 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfvysPQy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AC1AAA1E
	for <cgroups@vger.kernel.org>; Tue, 20 May 2025 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774475; cv=none; b=CfgxN8dVm8DYUXgUMgJlQUjlAC6eu4luY+jPkwOlQX3HvCpELmFOIwXQPN493GNCzzQguF7MGvQCb8qq/cht8gN36IgML4Yzh/TXPpHSbDX2JMwUXJiqqrtWZtmvAG8CVpKgOOdc78c18ihfIXvwEN1XLoWxeBJcjA5q/qP+fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774475; c=relaxed/simple;
	bh=JYGFZmSbZDJTW3m5sB+TpKGpMcvm24nWQ2z+/2xnjV8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J7c0qOaYYQJ54YmHqvUTv1+dJRaFizxlUtWViBjwxl+/o0Lml2MjG4vP+GWJC0zFqarG8CDBw7ByTTzmMgRTWuIQBJ/y0YB9XyCbhSeHHEcG4pB4s8X4AHRB8Aq4xG08dk2z3hEniYm35MSmIaGy7AZJDWKJiI51MkCXcBBqLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfvysPQy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747774474; x=1779310474;
  h=date:from:to:cc:subject:message-id;
  bh=JYGFZmSbZDJTW3m5sB+TpKGpMcvm24nWQ2z+/2xnjV8=;
  b=hfvysPQyktrZPoYRUkCx4M6DECCfgDezwFg7rlHuf9ra8R7NOApiaHf8
   L6/w5nGYPYQfqTQlQaRkYYnohiicz95amVSjTbsWwiOqcb2VrVQqgSHPG
   Ct2FSjKOdjoCqMjEiVOMUW+nOpQExQQXl6btI+K5luBsupicKwWqLd+yJ
   KSQFr/uYmd2VN5xLzmpDzyrBtgd5mU9gPLxfKwzwHUvkbspRddGq/QWVe
   rMTj+TkxSNcjizNCxAhFsjOvoToIIfluvRkwP4AkWHcOPgXFVAOdrqGXp
   DBYjIUse0zWi3FOfNyvBPK49KYKXYV9y2YH4aOemphxbqrtIgc3ulvj0H
   w==;
X-CSE-ConnectionGUID: GVXqi83XRbC3/2k6m6TbEw==
X-CSE-MsgGUID: ElgpKY2qQmCiMM5DHq31nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67142103"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67142103"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:54:34 -0700
X-CSE-ConnectionGUID: Pmo17V2tToGBecJAX7b44w==
X-CSE-MsgGUID: Ay/1L8EYTqSiQkbYEMOwYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139849512"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2025 13:54:31 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHTyn-000NYe-2e;
	Tue, 20 May 2025 20:54:29 +0000
Date: Wed, 21 May 2025 04:54:14 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 86aadd4d2347b11a239e755d5eb540488bbf5b8c
Message-ID: <202505210405.Vs6TO85L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 86aadd4d2347b11a239e755d5eb540488bbf5b8c  Merge branch 'for-6.16' into for-next

elapsed time: 1450m

configs tested: 230
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-001-20250520    gcc-8.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arc                   randconfig-002-20250520    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    clang-16
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-001-20250520    gcc-8.5.0
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-002-20250520    gcc-8.5.0
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-003-20250520    gcc-8.5.0
arm                   randconfig-004-20250520    gcc-7.5.0
arm                   randconfig-004-20250520    gcc-8.5.0
arm                        realview_defconfig    clang-16
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-001-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-003-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-9.3.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-001-20250520    gcc-9.3.0
hexagon               randconfig-002-20250520    clang-21
hexagon               randconfig-002-20250520    gcc-9.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-003-20250520    gcc-12
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-005-20250520    gcc-12
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250520    gcc-12
i386                  randconfig-002-20250520    gcc-12
i386                  randconfig-003-20250520    gcc-12
i386                  randconfig-004-20250520    gcc-12
i386                  randconfig-005-20250520    gcc-12
i386                  randconfig-006-20250520    gcc-12
i386                  randconfig-007-20250520    gcc-12
i386                  randconfig-011-20250520    gcc-12
i386                  randconfig-012-20250520    gcc-12
i386                  randconfig-013-20250520    gcc-12
i386                  randconfig-014-20250520    gcc-12
i386                  randconfig-015-20250520    gcc-12
i386                  randconfig-016-20250520    gcc-12
i386                  randconfig-017-20250520    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-9.3.0
loongarch             randconfig-002-20250520    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-9.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250520    gcc-13.3.0
nios2                 randconfig-002-20250520    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-001-20250520    gcc-9.3.0
parisc                randconfig-002-20250520    gcc-14.2.0
parisc                randconfig-002-20250520    gcc-9.3.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                       eiger_defconfig    clang-21
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-001-20250520    gcc-9.3.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-002-20250520    gcc-9.3.0
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc               randconfig-003-20250520    gcc-9.3.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-001-20250520    gcc-9.3.0
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-002-20250520    gcc-9.3.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-002-20250520    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-002-20250520    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-002-20250520    gcc-9.3.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-002-20250520    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250520    gcc-12
x86_64                randconfig-002-20250520    gcc-12
x86_64                randconfig-003-20250520    gcc-12
x86_64                randconfig-004-20250520    gcc-12
x86_64                randconfig-005-20250520    gcc-12
x86_64                randconfig-006-20250520    gcc-12
x86_64                randconfig-007-20250520    gcc-12
x86_64                randconfig-008-20250520    gcc-12
x86_64                randconfig-071-20250520    gcc-12
x86_64                randconfig-072-20250520    gcc-12
x86_64                randconfig-073-20250520    gcc-12
x86_64                randconfig-074-20250520    gcc-12
x86_64                randconfig-075-20250520    gcc-12
x86_64                randconfig-076-20250520    gcc-12
x86_64                randconfig-077-20250520    gcc-12
x86_64                randconfig-078-20250520    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

