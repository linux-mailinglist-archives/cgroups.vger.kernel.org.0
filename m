Return-Path: <cgroups+bounces-8164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2BAB5427
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298C97A894B
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A228C5AC;
	Tue, 13 May 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuasr7jv"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7323C504
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137242; cv=none; b=SKmEAE+Qy5YhFQ84RCG2B0GrUqQWfU8CkMh0awRc6APv/d+0sgNjb/p4lnVOWLMpABmO79PweVP3veEvbn2cDFTYi0qosMyBi7MlWCxg2Wuy0bfmii1xrPDPkmijj2SgaW5E+XyHEUIjrVG9rOcg5VHCij4jpplc6/0wkX156/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137242; c=relaxed/simple;
	bh=6vVW5LrUkv4n6/4BJFIdNEwMxhtwSVeTH1vKlQC8Ohg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D64N363IuUYNpRhsefiIGAsN0NFDkEKBjUlf9uqGQ751layTUIheN7vC7vyfJL8wNa9d8LXvNn7mxdqQCkuFCLCrhfmruPk0rpB3wFKe0lLawr3EMZWMHGwEU+Ch7kzI0u9uvvGklHVRyK4LgkbM5Fl6G81tMaYMEKc12h8JF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuasr7jv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747137240; x=1778673240;
  h=date:from:to:cc:subject:message-id;
  bh=6vVW5LrUkv4n6/4BJFIdNEwMxhtwSVeTH1vKlQC8Ohg=;
  b=cuasr7jvXYxSzGM43P2tPiVpNVw+UPf8m1qrt9HIUzdoGlv8ibFbGkIk
   TTZfncVClk8G/flQ9JV/Pf+mAGw7R4Sw8qXJOxubs3Y83KlOlqxAAD5u1
   yFCcFysaThQ7dQwqB81Zsl5IDzAdCaTQXDfZl7l6IOBb6J3DLhtfTc4pJ
   /ZcJ67n7V9RYrWzJa4XerhNmx848vwaTbcB14J5x9unfT5XwmfSkXNpEG
   OdfRFjk3qKYFEpxLCU0lB3bSD6p+8yStnDLYpbkU/A9chxGXGdW810nEO
   6Pu7fTyhjo42tkjNCoy2udUX+xog25DYtg1c1En7pTUYjuVEU91QC1GQk
   A==;
X-CSE-ConnectionGUID: mpmtojAuR9SPcMLspCCzRw==
X-CSE-MsgGUID: LcpQWqPrRuKs/lSadLtlHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59616931"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="59616931"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 04:54:00 -0700
X-CSE-ConnectionGUID: XriPXWMHRjGYXvFfYi7usA==
X-CSE-MsgGUID: urzPA3HwQLuc98E1lbNsdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142579811"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 May 2025 04:53:58 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEoCq-000G1b-2K;
	Tue, 13 May 2025 11:53:56 +0000
Date: Tue, 13 May 2025 19:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a7e10091f3adf197cc3ad8104016ec69c3bcd784
Message-ID: <202505131911.qgf6GLAK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a7e10091f3adf197cc3ad8104016ec69c3bcd784  Merge branch 'for-6.16' into for-next

elapsed time: 1088m

configs tested: 201
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250513    gcc-14.2.0
arc                   randconfig-002-20250513    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-21
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250513    gcc-7.5.0
arm                   randconfig-002-20250513    gcc-8.5.0
arm                   randconfig-003-20250513    gcc-8.5.0
arm                   randconfig-004-20250513    clang-16
arm                           tegra_defconfig    clang-21
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250513    clang-21
arm64                 randconfig-002-20250513    clang-21
arm64                 randconfig-003-20250513    gcc-6.5.0
arm64                 randconfig-004-20250513    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250513    clang-21
csky                  randconfig-001-20250513    gcc-14.2.0
csky                  randconfig-002-20250513    clang-21
csky                  randconfig-002-20250513    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250513    clang-21
hexagon               randconfig-002-20250513    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250513    clang-20
i386        buildonly-randconfig-002-20250513    clang-20
i386        buildonly-randconfig-003-20250513    clang-20
i386        buildonly-randconfig-004-20250513    clang-20
i386        buildonly-randconfig-005-20250513    clang-20
i386        buildonly-randconfig-005-20250513    gcc-12
i386        buildonly-randconfig-006-20250513    clang-20
i386        buildonly-randconfig-006-20250513    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250513    gcc-12
i386                  randconfig-002-20250513    gcc-12
i386                  randconfig-003-20250513    gcc-12
i386                  randconfig-004-20250513    gcc-12
i386                  randconfig-005-20250513    gcc-12
i386                  randconfig-006-20250513    gcc-12
i386                  randconfig-007-20250513    gcc-12
i386                  randconfig-011-20250513    gcc-12
i386                  randconfig-012-20250513    gcc-12
i386                  randconfig-013-20250513    gcc-12
i386                  randconfig-014-20250513    gcc-12
i386                  randconfig-015-20250513    gcc-12
i386                  randconfig-016-20250513    gcc-12
i386                  randconfig-017-20250513    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250513    clang-21
loongarch             randconfig-001-20250513    gcc-14.2.0
loongarch             randconfig-002-20250513    clang-21
loongarch             randconfig-002-20250513    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq5_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250513    clang-21
nios2                 randconfig-001-20250513    gcc-10.5.0
nios2                 randconfig-002-20250513    clang-21
nios2                 randconfig-002-20250513    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250513    clang-21
parisc                randconfig-001-20250513    gcc-11.5.0
parisc                randconfig-002-20250513    clang-21
parisc                randconfig-002-20250513    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250513    clang-21
powerpc               randconfig-002-20250513    clang-21
powerpc               randconfig-002-20250513    gcc-8.5.0
powerpc               randconfig-003-20250513    clang-21
powerpc64             randconfig-001-20250513    clang-21
powerpc64             randconfig-003-20250513    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250513    gcc-14.2.0
riscv                 randconfig-002-20250513    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250513    clang-21
s390                  randconfig-002-20250513    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-21
sh                    randconfig-001-20250513    gcc-12.4.0
sh                    randconfig-002-20250513    gcc-14.2.0
sh                          rsk7269_defconfig    clang-21
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                            shmin_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250513    gcc-11.5.0
sparc                 randconfig-002-20250513    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250513    gcc-11.5.0
sparc64               randconfig-002-20250513    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250513    clang-19
um                    randconfig-002-20250513    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250513    gcc-12
x86_64      buildonly-randconfig-002-20250513    gcc-12
x86_64      buildonly-randconfig-003-20250513    clang-20
x86_64      buildonly-randconfig-003-20250513    gcc-12
x86_64      buildonly-randconfig-004-20250513    gcc-12
x86_64      buildonly-randconfig-005-20250513    clang-20
x86_64      buildonly-randconfig-005-20250513    gcc-12
x86_64      buildonly-randconfig-006-20250513    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250513    clang-20
x86_64                randconfig-002-20250513    clang-20
x86_64                randconfig-003-20250513    clang-20
x86_64                randconfig-004-20250513    clang-20
x86_64                randconfig-005-20250513    clang-20
x86_64                randconfig-006-20250513    clang-20
x86_64                randconfig-007-20250513    clang-20
x86_64                randconfig-008-20250513    clang-20
x86_64                randconfig-071-20250513    clang-20
x86_64                randconfig-072-20250513    clang-20
x86_64                randconfig-073-20250513    clang-20
x86_64                randconfig-074-20250513    clang-20
x86_64                randconfig-075-20250513    clang-20
x86_64                randconfig-076-20250513    clang-20
x86_64                randconfig-077-20250513    clang-20
x86_64                randconfig-078-20250513    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250513    gcc-7.5.0
xtensa                randconfig-002-20250513    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

