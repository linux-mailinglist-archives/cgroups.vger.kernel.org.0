Return-Path: <cgroups+bounces-8787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719AB0B3A0
	for <lists+cgroups@lfdr.de>; Sun, 20 Jul 2025 07:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD01189CEC4
	for <lists+cgroups@lfdr.de>; Sun, 20 Jul 2025 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393712C499;
	Sun, 20 Jul 2025 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjpE4jyA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B120ED
	for <cgroups@vger.kernel.org>; Sun, 20 Jul 2025 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752990401; cv=none; b=lHIXeSU/W+GWvUF6zL5fM+LYvVUpLKgQj+cmt/SMCvkGMneUV68+eS5HpQeSORkcInGTMiq+tqbgiCD1QS/NhJQ5HruX74QtCA+tOy2BHmWDrz5DkTVzLdc37dO2V3BM6pHmeH9UoswAjK9QPW0afGlqIbpTTFxGWdtpMZgmaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752990401; c=relaxed/simple;
	bh=RhKgyGuVxdcjMSITggN0G62ihIKO2CPbrTCwqWvE+V8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nB4WRnWVAmKSzQ5J3V++Vkh7H0VqCT6m1gyAhQpHfp47ScsweQo2pvTNs4sMEPRuwYIdSousutO1iqRcXKwUU6oEIw1BBFY4cKXMMXA3vItyw0UOUnfMxO+clFiDg1adkM33AAzGAR6E7rO7TOEjx5tiQnq43QwJDptU4KLK6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjpE4jyA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752990400; x=1784526400;
  h=date:from:to:cc:subject:message-id;
  bh=RhKgyGuVxdcjMSITggN0G62ihIKO2CPbrTCwqWvE+V8=;
  b=VjpE4jyAst0GH2iY54U70fMVKrbSSd5FYUUM8/k4nBSHGDZBdbz5teS/
   /V9FOZUj2nvG2tFiyy9/lTzrsvHfXIFeaTN6Xz49l4WZI989PatYH/ZDg
   KXbcjBa1lMNMh4mdo2/P770I6rbGGxdgvmPCRZog3RgYaktO5hAHKId7L
   8Tk0yfodDCCUH+WZzTqdRebn2nGVX7+LzsBUzzfth+avMoIJp0LahlVhi
   FNzsSt9i5jXE7/5I9W8GTwUqoWoC8vCrH52yDl8n4WZy1YWljBBLB17/Q
   gTFdtmoocva05bQ/Ffk2ZQT1Y1SLe0oLQfm4CD8YUiC9cPOwtbmYMywR5
   A==;
X-CSE-ConnectionGUID: iEgMz99kQaCs1aF6M8/03w==
X-CSE-MsgGUID: w907dgpoQZCoHfjdhug0WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55192465"
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; 
   d="scan'208";a="55192465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 22:46:39 -0700
X-CSE-ConnectionGUID: 9nagK7AuQWK88TpCWvOb/Q==
X-CSE-MsgGUID: nsFfdUBqQ02oJ6Qczdj6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; 
   d="scan'208";a="158332122"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Jul 2025 22:46:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udMse-000Fx7-24;
	Sun, 20 Jul 2025 05:46:36 +0000
Date: Sun, 20 Jul 2025 13:45:54 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 d445d2ab8129b1da93f25a9a71e36f43223d5543
Message-ID: <202507201342.RIia36m2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: d445d2ab8129b1da93f25a9a71e36f43223d5543  Merge branch 'for-6.17' into for-next

elapsed time: 763m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250720    gcc-11.5.0
arc                   randconfig-002-20250720    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250720    gcc-15.1.0
arm                   randconfig-002-20250720    gcc-15.1.0
arm                   randconfig-003-20250720    gcc-10.5.0
arm                   randconfig-004-20250720    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250720    gcc-15.1.0
arm64                 randconfig-002-20250720    gcc-12.5.0
arm64                 randconfig-003-20250720    clang-21
arm64                 randconfig-004-20250720    clang-21
csky                             alldefconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250720    gcc-15.1.0
csky                  randconfig-002-20250720    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250720    clang-21
hexagon               randconfig-002-20250720    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250720    clang-20
i386        buildonly-randconfig-002-20250720    gcc-12
i386        buildonly-randconfig-003-20250720    gcc-12
i386        buildonly-randconfig-004-20250720    clang-20
i386        buildonly-randconfig-005-20250720    gcc-12
i386        buildonly-randconfig-006-20250720    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250720    clang-18
loongarch             randconfig-002-20250720    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250720    gcc-9.5.0
nios2                 randconfig-002-20250720    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250720    gcc-8.5.0
parisc                randconfig-002-20250720    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      katmai_defconfig    clang-21
powerpc               randconfig-001-20250720    gcc-10.5.0
powerpc               randconfig-002-20250720    gcc-8.5.0
powerpc               randconfig-003-20250720    gcc-11.5.0
powerpc64             randconfig-001-20250720    gcc-10.5.0
powerpc64             randconfig-002-20250720    gcc-8.5.0
powerpc64             randconfig-003-20250720    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250720    clang-21
riscv                 randconfig-002-20250720    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250720    clang-21
s390                  randconfig-002-20250720    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250720    gcc-15.1.0
sh                    randconfig-002-20250720    gcc-13.4.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250720    gcc-8.5.0
sparc                 randconfig-002-20250720    gcc-8.5.0
sparc64               randconfig-001-20250720    gcc-8.5.0
sparc64               randconfig-002-20250720    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250720    gcc-11
um                    randconfig-002-20250720    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250720    gcc-12
x86_64      buildonly-randconfig-002-20250720    gcc-12
x86_64      buildonly-randconfig-003-20250720    gcc-12
x86_64      buildonly-randconfig-004-20250720    clang-20
x86_64      buildonly-randconfig-005-20250720    gcc-11
x86_64      buildonly-randconfig-006-20250720    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250720    gcc-8.5.0
xtensa                randconfig-002-20250720    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

