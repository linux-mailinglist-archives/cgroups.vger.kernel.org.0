Return-Path: <cgroups+bounces-9429-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA7DB36D3D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 17:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A01E5652FF
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09DE2376F7;
	Tue, 26 Aug 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FD9o/INm"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4D2AD04
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220487; cv=none; b=nTBiQ3qBdJarnUYYrOd/IHXGGEYKWZHqvs4RmFdcSVenqdQNQgyOEtkIJakcHC7/DKNt33c+/G02SnoeotQ9HmBuEMLxF8sd3kn8t8+iwFRfHglJJhBcutCFLjJDnAz9cDab/MkzBbqw2yd0RSMd/iesbaggQMzIvfmutb/ubNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220487; c=relaxed/simple;
	bh=r7/83bFwSTlirApohYddINaWMQktFu0689Fs1yxQ3/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rDMvybbSMOfwM2ZJTYQvxUIH9qQeuTveXhkcI71fJZTryU25nBCohpW+VNQedQXZtN8TJNACgs0JdVlFft62IhpKkts+qTxH7k01/SLUwcPOFAufTckEMC7U7NXQwQd4p0XrSysi9Krx8EFm4QXfGxsKnvh0IDw6MeBR87hoDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FD9o/INm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756220486; x=1787756486;
  h=date:from:to:cc:subject:message-id;
  bh=r7/83bFwSTlirApohYddINaWMQktFu0689Fs1yxQ3/g=;
  b=FD9o/INmQYy4EQ9DSQVwJOopVCf7NQi4mvPckspGkl7MswRe3GXgMrpG
   KaWcUKKaz6ZzLEsuYDF+s1wVJxRLsqgwDvC6VJ3P7YxoNwTurun1Q3p6k
   LY4UQTrAco7adcLCSjMsMVDEe3t8yqRSr8GJxh7n1M8RKlh6X9M4LzzQ5
   Bkli47F3sAPypRM4s3/IPIf9S3eNfRDLcgNZ9PsIlfEHPArONEsBovhRX
   T6YbnwRIL2BngSPlMZTuLxLRLwBWFeBjBudF+4cWvjjAKe194KojLWVcM
   CsayTQm6DWnxcRuFNr0OUfuLPg0+HSSMmeymkEvns4/1lqhxZ2NgeCi+y
   w==;
X-CSE-ConnectionGUID: 6cbks8eUTlKmKdtiDIKnYQ==
X-CSE-MsgGUID: rDB2UqFPQfqpzzRr5qUZtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62101315"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62101315"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:01:25 -0700
X-CSE-ConnectionGUID: 0mbSiM3MTLSjdNGdOHNikA==
X-CSE-MsgGUID: eYAtDrgITv+o9E/2cdn98w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173910543"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2025 08:01:24 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqvAn-000RyH-2x;
	Tue, 26 Aug 2025 15:01:21 +0000
Date: Tue, 26 Aug 2025 23:00:49 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 04a4d6c24eef8a1fc89d8b6129ac00ca2f638aff
Message-ID: <202508262340.t0Sg095N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 04a4d6c24eef8a1fc89d8b6129ac00ca2f638aff  Merge branch 'for-6.18' into for-next

elapsed time: 1222m

configs tested: 122
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250826    gcc-11.5.0
arc                   randconfig-002-20250826    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250826    gcc-12.5.0
arm                   randconfig-002-20250826    gcc-13.4.0
arm                   randconfig-003-20250826    gcc-8.5.0
arm                   randconfig-004-20250826    gcc-10.5.0
arm                           tegra_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250826    clang-22
arm64                 randconfig-002-20250826    gcc-8.5.0
arm64                 randconfig-003-20250826    clang-22
arm64                 randconfig-004-20250826    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250826    gcc-15.1.0
csky                  randconfig-002-20250826    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250826    clang-19
hexagon               randconfig-002-20250826    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250826    gcc-12
i386        buildonly-randconfig-002-20250826    gcc-12
i386        buildonly-randconfig-003-20250826    clang-20
i386        buildonly-randconfig-004-20250826    gcc-12
i386        buildonly-randconfig-005-20250826    clang-20
i386        buildonly-randconfig-006-20250826    gcc-12
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250826    gcc-14.3.0
loongarch             randconfig-002-20250826    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250826    gcc-8.5.0
nios2                 randconfig-002-20250826    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250826    gcc-8.5.0
parisc                randconfig-002-20250826    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250826    gcc-8.5.0
powerpc               randconfig-002-20250826    clang-22
powerpc               randconfig-003-20250826    gcc-13.4.0
powerpc64             randconfig-001-20250826    gcc-10.5.0
powerpc64             randconfig-002-20250826    gcc-11.5.0
powerpc64             randconfig-003-20250826    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250826    gcc-8.5.0
riscv                 randconfig-002-20250826    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250826    clang-22
s390                  randconfig-002-20250826    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250826    gcc-11.5.0
sh                    randconfig-002-20250826    gcc-9.5.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250826    gcc-13.4.0
sparc                 randconfig-002-20250826    gcc-8.5.0
sparc64               randconfig-001-20250826    gcc-8.5.0
sparc64               randconfig-002-20250826    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250826    gcc-12
um                    randconfig-002-20250826    clang-17
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250826    clang-20
x86_64      buildonly-randconfig-002-20250826    clang-20
x86_64      buildonly-randconfig-003-20250826    gcc-12
x86_64      buildonly-randconfig-004-20250826    clang-20
x86_64      buildonly-randconfig-005-20250826    gcc-12
x86_64      buildonly-randconfig-006-20250826    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250826    gcc-11.5.0
xtensa                randconfig-002-20250826    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

