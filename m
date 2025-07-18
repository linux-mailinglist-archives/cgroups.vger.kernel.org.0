Return-Path: <cgroups+bounces-8774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB257B0A87E
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB42E7A3969
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38F2E62B9;
	Fri, 18 Jul 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVPkN15p"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3062BD00C
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856476; cv=none; b=W994MkOP2mNiMDoJGhqVDmDew7V+GggXevQGE8U3k+FOb21KON2dpqevadLKlHuE2PYsotMyRkL4yMyFkS0qU3iDwhVomjUIKJcisZVMKlH3xGsBf6+LhH7gi/rnX4J9esx9rw76He3xMm4+oj7PY8XrgBrPugK92mEjVvHxkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856476; c=relaxed/simple;
	bh=9SlwRJjQ9hVuete40WeL7PKUViM7Fpkr96cD/5fCTmw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=czLnJtKfYgrYShHI6+mN4qJM5KzrCQ8xbuI6FDotwIWhBMyoyfqZ9OyG4SNlPLu6VTaHbz+ZgYZO+cOUHb0pRVV6KloIpdmyW3rz3dml44IgDFa3G+HAXkAdRwGCsC40iSsWr4zbKaK8YugRtWEomHGgUAzCZjt6a/BGuwtep3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVPkN15p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752856475; x=1784392475;
  h=date:from:to:cc:subject:message-id;
  bh=9SlwRJjQ9hVuete40WeL7PKUViM7Fpkr96cD/5fCTmw=;
  b=cVPkN15peG1Cl8+3lXYFyDfZqBgIum3131BOu9R+6wPF1wMy8N3IEy+F
   JPlkyJYARc7UbUm94nn9NRm/wHzxwnR1bxID+5JeYkAK7f7aTrK97nVlw
   wqxLcRUk5yVNn+j06JVrW452VlX4+esC5MsT92HKWSGItHmfpIc40z7TH
   psNVPKPQcjJYLp2WlrPiHP7HxQ+TfPl51kErjumyyJcCCgJn24kQffqzy
   iSOHNWnsVciRh4ccDLPrXWoEuishgH4nZSnWAS37TaOiycvnJxQb23gGz
   JhJkyLcSPolmUZuuvBcMtQNknIzK9TpovUeKf9//gW5sjJhX9LMSYLkaZ
   g==;
X-CSE-ConnectionGUID: 9rpM0oMsTBuCApjAhPptbg==
X-CSE-MsgGUID: asQKDEz5QVyKVb7v7/WZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="42779433"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="42779433"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 09:34:34 -0700
X-CSE-ConnectionGUID: IWfirmGWSlGJB9xmfGKkLw==
X-CSE-MsgGUID: kQEGpZ81S7SmDaSCVUP8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="163729655"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jul 2025 09:34:33 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uco2Y-000ErF-1s;
	Fri, 18 Jul 2025 16:34:30 +0000
Date: Sat, 19 Jul 2025 00:34:27 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.16-fixes] BUILD SUCCESS
 14a67b42cb6f3ab66f41603c062c5056d32ea7dd
Message-ID: <202507190015.dQ54Dt6B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16-fixes
branch HEAD: 14a67b42cb6f3ab66f41603c062c5056d32ea7dd  Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"

elapsed time: 1348m

configs tested: 232
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    clang-21
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-001-20250718    gcc-8.5.0
arc                   randconfig-002-20250718    gcc-15.1.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250718    gcc-7.5.0
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-6.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm                   randconfig-004-20250718    gcc-8.5.0
arm                          sp7021_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-001-20250718    gcc-8.5.0
arm64                 randconfig-002-20250718    gcc-5.5.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-003-20250718    gcc-8.5.0
arm64                 randconfig-004-20250718    gcc-7.5.0
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-001-20250718    gcc-15.1.0
hexagon               randconfig-002-20250718    clang-21
hexagon               randconfig-002-20250718    gcc-15.1.0
i386                             alldefconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-002-20250718    gcc-12
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-004-20250718    gcc-12
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
i386        buildonly-randconfig-006-20250718    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250718    gcc-12
i386                  randconfig-002-20250718    gcc-12
i386                  randconfig-003-20250718    gcc-12
i386                  randconfig-004-20250718    gcc-12
i386                  randconfig-005-20250718    gcc-12
i386                  randconfig-006-20250718    gcc-12
i386                  randconfig-007-20250718    gcc-12
i386                  randconfig-011-20250718    clang-20
i386                  randconfig-012-20250718    clang-20
i386                  randconfig-013-20250718    clang-20
i386                  randconfig-014-20250718    clang-20
i386                  randconfig-015-20250718    clang-20
i386                  randconfig-016-20250718    clang-20
i386                  randconfig-017-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             alldefconfig    clang-21
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
nios2                 randconfig-002-20250718    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    clang-21
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-001-20250718    gcc-15.1.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc                randconfig-002-20250718    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-21
powerpc                  mpc866_ads_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc               randconfig-001-20250718    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.3.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-002-20250718    gcc-15.1.0
powerpc               randconfig-003-20250718    clang-17
powerpc               randconfig-003-20250718    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-001-20250718    gcc-15.1.0
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-002-20250718    gcc-15.1.0
powerpc64             randconfig-003-20250718    gcc-6.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-001-20250718    gcc-15.1.0
riscv                 randconfig-002-20250718    clang-16
riscv                 randconfig-002-20250718    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-001-20250718    gcc-15.1.0
s390                  randconfig-002-20250718    clang-21
s390                  randconfig-002-20250718    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-001-20250718    gcc-6.5.0
sh                    randconfig-002-20250718    gcc-15.1.0
sh                    randconfig-002-20250718    gcc-7.5.0
sh                           se7722_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-10.3.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc                 randconfig-002-20250718    gcc-15.1.0
sparc                       sparc32_defconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-001-20250718    gcc-15.1.0
sparc64               randconfig-002-20250718    clang-20
sparc64               randconfig-002-20250718    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-001-20250718    gcc-15.1.0
um                    randconfig-002-20250718    gcc-12
um                    randconfig-002-20250718    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    clang-20
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250718    clang-20
x86_64                randconfig-002-20250718    clang-20
x86_64                randconfig-003-20250718    clang-20
x86_64                randconfig-004-20250718    clang-20
x86_64                randconfig-005-20250718    clang-20
x86_64                randconfig-006-20250718    clang-20
x86_64                randconfig-007-20250718    clang-20
x86_64                randconfig-008-20250718    clang-20
x86_64                randconfig-071-20250718    clang-20
x86_64                randconfig-072-20250718    clang-20
x86_64                randconfig-073-20250718    clang-20
x86_64                randconfig-074-20250718    clang-20
x86_64                randconfig-075-20250718    clang-20
x86_64                randconfig-076-20250718    clang-20
x86_64                randconfig-077-20250718    clang-20
x86_64                randconfig-078-20250718    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-7.5.0
xtensa                randconfig-002-20250718    gcc-12.4.0
xtensa                randconfig-002-20250718    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

