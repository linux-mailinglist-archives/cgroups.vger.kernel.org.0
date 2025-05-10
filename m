Return-Path: <cgroups+bounces-8125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF7AB23F0
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 15:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C758A4C408B
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FF1EB1AF;
	Sat, 10 May 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izXrnMwj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8F1CA84
	for <cgroups@vger.kernel.org>; Sat, 10 May 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746883881; cv=none; b=LzlAINFRCaUL7h7PNMYGYgfW/Rn2oOScbAtmiFT2v0NZ2Gw7J5IFclhHY5d6LVIabpY4qBIx02MsOTBtu0X5+HO4zjZjO1m2QNKLKeuKuZrmmOgRRMGxagcFQhSsnMyeOFW60pp2KuUHSqi+TwUWw+zCrMjvGhcoDVD0j9BunkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746883881; c=relaxed/simple;
	bh=CryOqonfCWbfIzNr+Cm4OZoyvYOFOuCi1EJzp+rz9f8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D7wajUBUW7VTJ7L8sXDt/Wil1YuSxeFRad9eOubvazgEd8Xf9SZ/RwLRZHTOM8loF7u5TxdrRf3kYukqTkvLoogcUTVOtDg1RXoM57PrBu1C92UKs+w164flZfDFXr1j1V5IPBdm4BbF2ptbHQYvf4q6nL88ylzFM/xPCbitIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izXrnMwj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746883880; x=1778419880;
  h=date:from:to:cc:subject:message-id;
  bh=CryOqonfCWbfIzNr+Cm4OZoyvYOFOuCi1EJzp+rz9f8=;
  b=izXrnMwjX+EbkugIVe4pHd1yi1+tjrLhRcwEkn1TYCAyJR59hXkzYmIl
   KDMUkpqqilMIhZY6dBfblFd7YZuHBVfrr1Y6MfscMZb/nF00Rs7GXN8MQ
   R8A4Q8kGaRsVE64FibXjnjNjv4zkPybLgGS19WHco5kbsgUYA7bAT9YT7
   hDNBLWfTvKTyVD9URhvj3i8vBMFoA1FTRdA/qRJJ1PDccPJa9TqQIitTM
   6l1GDVFKw/UfN+bR9QbB8JOujI1VwMfCM5lwmpV9zMculeCG7sInBgJC6
   DFuHMribaFtkN1DBxUGYZR8EoAd4xrshUi9mUYlv1E9xIuxS3h/6gR0EL
   w==;
X-CSE-ConnectionGUID: qETTjub8QCa1IesmlBmSVA==
X-CSE-MsgGUID: Bm6m1ojBRHGhulr4n5aYKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48405855"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48405855"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 06:31:19 -0700
X-CSE-ConnectionGUID: 9zby1qSQSLOCEWRShrs9pw==
X-CSE-MsgGUID: AkgrE0QzTQOTaeELpwQyQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="136757527"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 May 2025 06:31:18 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDkIN-000D6j-1g;
	Sat, 10 May 2025 13:31:15 +0000
Date: Sat, 10 May 2025 21:31:08 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5dff7c48efa2d917f0f89e4bcd0452a4df11b86b
Message-ID: <202505102155.SdtLw7QE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5dff7c48efa2d917f0f89e4bcd0452a4df11b86b  Merge branch 'for-6.15-fixes' into for-next

elapsed time: 1119m

configs tested: 225
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250510    gcc-14.2.0
arc                   randconfig-001-20250510    gcc-8.5.0
arc                   randconfig-002-20250510    gcc-13.3.0
arc                   randconfig-002-20250510    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-21
arm                   randconfig-001-20250510    gcc-10.5.0
arm                   randconfig-001-20250510    gcc-8.5.0
arm                   randconfig-002-20250510    clang-21
arm                   randconfig-002-20250510    gcc-8.5.0
arm                   randconfig-003-20250510    gcc-10.5.0
arm                   randconfig-003-20250510    gcc-8.5.0
arm                   randconfig-004-20250510    gcc-7.5.0
arm                   randconfig-004-20250510    gcc-8.5.0
arm                           sunxi_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250510    gcc-7.5.0
arm64                 randconfig-001-20250510    gcc-8.5.0
arm64                 randconfig-002-20250510    gcc-5.5.0
arm64                 randconfig-002-20250510    gcc-8.5.0
arm64                 randconfig-003-20250510    clang-21
arm64                 randconfig-003-20250510    gcc-8.5.0
arm64                 randconfig-004-20250510    gcc-7.5.0
arm64                 randconfig-004-20250510    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250510    clang-18
csky                  randconfig-001-20250510    gcc-14.2.0
csky                  randconfig-002-20250510    clang-18
csky                  randconfig-002-20250510    gcc-13.3.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250510    clang-18
hexagon               randconfig-001-20250510    clang-21
hexagon               randconfig-002-20250510    clang-18
hexagon               randconfig-002-20250510    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250510    gcc-12
i386        buildonly-randconfig-002-20250510    gcc-12
i386        buildonly-randconfig-003-20250510    gcc-12
i386        buildonly-randconfig-004-20250510    gcc-12
i386        buildonly-randconfig-005-20250510    gcc-12
i386        buildonly-randconfig-006-20250510    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250510    gcc-12
i386                  randconfig-002-20250510    gcc-12
i386                  randconfig-003-20250510    gcc-12
i386                  randconfig-004-20250510    gcc-12
i386                  randconfig-005-20250510    gcc-12
i386                  randconfig-006-20250510    gcc-12
i386                  randconfig-007-20250510    gcc-12
i386                  randconfig-011-20250510    clang-20
i386                  randconfig-012-20250510    clang-20
i386                  randconfig-013-20250510    clang-20
i386                  randconfig-014-20250510    clang-20
i386                  randconfig-015-20250510    clang-20
i386                  randconfig-016-20250510    clang-20
i386                  randconfig-017-20250510    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250510    clang-18
loongarch             randconfig-001-20250510    gcc-13.3.0
loongarch             randconfig-002-20250510    clang-18
loongarch             randconfig-002-20250510    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250510    clang-18
nios2                 randconfig-001-20250510    gcc-11.5.0
nios2                 randconfig-002-20250510    clang-18
nios2                 randconfig-002-20250510    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250510    clang-18
parisc                randconfig-001-20250510    gcc-6.5.0
parisc                randconfig-002-20250510    clang-18
parisc                randconfig-002-20250510    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-21
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                      ppc64e_defconfig    clang-21
powerpc               randconfig-001-20250510    clang-18
powerpc               randconfig-001-20250510    gcc-7.5.0
powerpc               randconfig-002-20250510    clang-17
powerpc               randconfig-002-20250510    clang-18
powerpc               randconfig-003-20250510    clang-18
powerpc               randconfig-003-20250510    clang-21
powerpc64             randconfig-001-20250510    clang-18
powerpc64             randconfig-002-20250510    clang-18
powerpc64             randconfig-002-20250510    gcc-10.5.0
powerpc64             randconfig-003-20250510    clang-18
powerpc64             randconfig-003-20250510    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250510    clang-21
riscv                 randconfig-001-20250510    gcc-14.2.0
riscv                 randconfig-002-20250510    clang-21
riscv                 randconfig-002-20250510    gcc-7.5.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250510    clang-21
s390                  randconfig-001-20250510    gcc-7.5.0
s390                  randconfig-002-20250510    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-21
sh                            hp6xx_defconfig    gcc-14.2.0
sh                            migor_defconfig    clang-21
sh                    randconfig-001-20250510    clang-21
sh                    randconfig-001-20250510    gcc-9.3.0
sh                    randconfig-002-20250510    clang-21
sh                    randconfig-002-20250510    gcc-11.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250510    clang-21
sparc                 randconfig-001-20250510    gcc-12.4.0
sparc                 randconfig-002-20250510    clang-21
sparc                 randconfig-002-20250510    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250510    clang-21
sparc64               randconfig-001-20250510    gcc-10.5.0
sparc64               randconfig-002-20250510    clang-21
sparc64               randconfig-002-20250510    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250510    clang-21
um                    randconfig-001-20250510    gcc-12
um                    randconfig-002-20250510    clang-21
um                    randconfig-002-20250510    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250510    clang-20
x86_64      buildonly-randconfig-002-20250510    clang-20
x86_64      buildonly-randconfig-003-20250510    clang-20
x86_64      buildonly-randconfig-003-20250510    gcc-12
x86_64      buildonly-randconfig-004-20250510    clang-20
x86_64      buildonly-randconfig-004-20250510    gcc-11
x86_64      buildonly-randconfig-005-20250510    clang-20
x86_64      buildonly-randconfig-005-20250510    gcc-12
x86_64      buildonly-randconfig-006-20250510    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250510    clang-20
x86_64                randconfig-002-20250510    clang-20
x86_64                randconfig-003-20250510    clang-20
x86_64                randconfig-004-20250510    clang-20
x86_64                randconfig-005-20250510    clang-20
x86_64                randconfig-006-20250510    clang-20
x86_64                randconfig-007-20250510    clang-20
x86_64                randconfig-008-20250510    clang-20
x86_64                randconfig-071-20250510    gcc-11
x86_64                randconfig-072-20250510    gcc-11
x86_64                randconfig-073-20250510    gcc-11
x86_64                randconfig-074-20250510    gcc-11
x86_64                randconfig-075-20250510    gcc-11
x86_64                randconfig-076-20250510    gcc-11
x86_64                randconfig-077-20250510    gcc-11
x86_64                randconfig-078-20250510    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250510    clang-21
xtensa                randconfig-001-20250510    gcc-8.5.0
xtensa                randconfig-002-20250510    clang-21
xtensa                randconfig-002-20250510    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

