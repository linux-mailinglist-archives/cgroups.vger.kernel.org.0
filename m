Return-Path: <cgroups+bounces-8332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9DAC2A71
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 21:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB987B8B2C
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884229DB7B;
	Fri, 23 May 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDtScT5g"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E029ACF7
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028749; cv=none; b=W5WIWwSynABZ7U/8RVWJVQJ7TKGXMmFbRLeQIGpt9OvbFtcPAxJAka5sFRbo2xcP3SDBQtzpS4DBWAeGuCENXOom2kH9WW25lGGPm+OiFQtG1MnQQPdBKNf+Ylv5z+DDbtmJ5blXdEsxkOfxg80Kh0IqQDJ7R/zmrv0jMpF7/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028749; c=relaxed/simple;
	bh=JB7Gu7vLirJCdq/R1BAcgw4wR2vg6zIuEu2GzUEsqqs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pBsKamm2nFz0m2dxK0BOpirtnTAUfRz/jY4nLlJba+bkrWg3w0btWy4pTIciUGSd0llMAJ68AG40U/ip6Ds/43GYYGVoyY6uxFAH+0YPT7T6zGNMyFu9iOMGET+7pcSyP/iIEgQPY8VnQWYEiMCkdPM5U8mk0s4ud9kI8FA9MCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDtScT5g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748028747; x=1779564747;
  h=date:from:to:cc:subject:message-id;
  bh=JB7Gu7vLirJCdq/R1BAcgw4wR2vg6zIuEu2GzUEsqqs=;
  b=WDtScT5gHTrDk3AwUQ2u3aKz1IKBdjGlga9Nf4JygNWh8+0VTqOb+r6L
   tayC1bcPd8hfhUM4qtrpJhMUn4MkSH885TXdOD8k/+vjUePuhUxr/54cO
   WyWqoXAOl/umigXtRSE7Eh6biHZ2BYrWNAstxKdR1tTNGMO5PJhihyLEQ
   E2YSonhU2QQrhtkL7Q3GboQT6O/lk22ukpHRfT52O3bh0ulppcnKVViGg
   VRdKO48M4bZi5KPzWuiD/miO5rajXEq9l+BqG6jN3PBLFJNJ1ds+ItJ8D
   0s386Tj/A7aE0/W0IZ9USO1j4z/Y2mfqKBRBZt+vl7hvI5ZiUu+2BHNOx
   A==;
X-CSE-ConnectionGUID: tF8eDkwJSaq7hilb/q/0Vw==
X-CSE-MsgGUID: /WDSy2FFSuqmCHhGSEEKHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49975968"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49975968"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 12:32:27 -0700
X-CSE-ConnectionGUID: 2/nIluI0TU6EAkreJkm1MQ==
X-CSE-MsgGUID: q4SuoI2lSr2tjjaNEms70w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141146318"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 23 May 2025 12:32:26 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIY7z-000Qge-26;
	Fri, 23 May 2025 19:32:23 +0000
Date: Sat, 24 May 2025 03:32:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 089844ffdb39bd670cc25c4fca10bdb44d1f3534
Message-ID: <202505240353.UoSlKatA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 089844ffdb39bd670cc25c4fca10bdb44d1f3534  Merge branch 'for-6.16' into for-next

elapsed time: 1444m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250523    gcc-15.1.0
arc                   randconfig-002-20250523    gcc-10.5.0
arm                               allnoconfig    clang-21
arm                       imx_v4_v5_defconfig    clang-21
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20250523    clang-16
arm                   randconfig-002-20250523    gcc-8.5.0
arm                   randconfig-003-20250523    gcc-7.5.0
arm                   randconfig-004-20250523    clang-21
arm                         s3c6400_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250523    gcc-8.5.0
arm64                 randconfig-002-20250523    clang-16
arm64                 randconfig-003-20250523    clang-21
arm64                 randconfig-004-20250523    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250523    gcc-10.5.0
csky                  randconfig-002-20250523    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250523    clang-21
hexagon               randconfig-002-20250523    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250523    clang-20
i386        buildonly-randconfig-002-20250523    clang-20
i386        buildonly-randconfig-003-20250523    clang-20
i386        buildonly-randconfig-004-20250523    clang-20
i386        buildonly-randconfig-005-20250523    clang-20
i386        buildonly-randconfig-006-20250523    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250523    gcc-15.1.0
loongarch             randconfig-002-20250523    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250523    gcc-10.5.0
nios2                 randconfig-002-20250523    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250523    gcc-9.3.0
parisc                randconfig-002-20250523    gcc-7.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250523    clang-21
powerpc               randconfig-002-20250523    clang-21
powerpc               randconfig-003-20250523    clang-20
powerpc64             randconfig-001-20250523    clang-21
powerpc64             randconfig-002-20250523    clang-19
powerpc64             randconfig-003-20250523    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250523    gcc-8.5.0
riscv                 randconfig-002-20250523    clang-17
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250523    gcc-6.5.0
s390                  randconfig-002-20250523    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250523    gcc-12.4.0
sh                    randconfig-002-20250523    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250523    gcc-10.3.0
sparc                 randconfig-002-20250523    gcc-10.3.0
sparc64               randconfig-001-20250523    gcc-9.3.0
sparc64               randconfig-002-20250523    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250523    gcc-12
um                    randconfig-002-20250523    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250523    gcc-12
x86_64      buildonly-randconfig-002-20250523    clang-20
x86_64      buildonly-randconfig-003-20250523    clang-20
x86_64      buildonly-randconfig-004-20250523    clang-20
x86_64      buildonly-randconfig-005-20250523    clang-20
x86_64      buildonly-randconfig-006-20250523    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250523    gcc-9.3.0
xtensa                randconfig-002-20250523    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

