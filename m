Return-Path: <cgroups+bounces-7204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EAA6AC4A
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0CB7A71BA
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B362253B2;
	Thu, 20 Mar 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8xEwayz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C361494BB
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492597; cv=none; b=rUdBpOZb9ZVoazjUcHxVssC/QAHQ/MX1v8WMNaU+ScS91h5UBjRnedmzu3nmoW27ombNk81o6YPDlSctDuidbKAdtoA/cQhWHFBXkODENA+s4w0zAct/J4h5dfC2qJh7EGZbQbhflYAC2D84XXt6xl6+dXpIZTOU6rNLmOkeBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492597; c=relaxed/simple;
	bh=NR9fW+GBppTKbWTPFpbnpjWH9n1N2BuQID0eZ22rHXA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QrgSjBljUh0+HGBoxdYMtV2qh+I2sCLnXGokq4pjTOeoG6St+bkocJxBaCBHfCJjWMcfG4rAs1OpcqR/9SW4tyVQyy9DwLQOTflPZyud5wz4yrHvToefQi5589qX+y4UdsM2sYp1WYEqqW5tRu1W4cnj1lazUiaaUjB0wwyKEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8xEwayz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742492595; x=1774028595;
  h=date:from:to:cc:subject:message-id;
  bh=NR9fW+GBppTKbWTPFpbnpjWH9n1N2BuQID0eZ22rHXA=;
  b=j8xEwayz/uytqSwhHoyNSysircw5X2ChZHg3aESgFHUNVAlhEOUpRVhy
   L6lEZaK6uh3AlpDSDOG7SJpin3KCUiE6P7bympsxpDxt4hfOIrLQjrxpB
   OtPaRLFFWHHCVPX0QI5UhTz+30OfzYBEWLYU9Y5xfF9TmNZxj6Q+NoUds
   nJgiseKnArxq+UABHxcWlquJ9c6qRJmayraaxYkHsW52wB0aCCO6pvWNe
   WwL+46pHxQygnkb1o0k/WuIDkj+JDqwxAgJUftWfzGWF8zpHvdLbRgaQV
   PRslKDJQAQPy0Kxy5e1QZr8QN0cEcO7oGd5u2/WF0Ilmiz2hQvZQ02o++
   Q==;
X-CSE-ConnectionGUID: /hQe1AwoT+2ABhemDFvywQ==
X-CSE-MsgGUID: 8oQxV7Z+QWCSoT8NwCN5ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61265356"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="61265356"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:43:10 -0700
X-CSE-ConnectionGUID: VJoprKTpSxOLuOa8YtDcuQ==
X-CSE-MsgGUID: vMuKi7u8S5yEP+6De92zEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="160390258"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 10:43:06 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvJv4-0000eA-0x;
	Thu, 20 Mar 2025 17:43:02 +0000
Date: Fri, 21 Mar 2025 01:42:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.15] BUILD SUCCESS
 0efc297a3c4974dbd609ee36fc6345720b6ca735
Message-ID: <202503210133.YZbWmObb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.15
branch HEAD: 0efc297a3c4974dbd609ee36fc6345720b6ca735  cgroup/rstat: avoid disabling irqs for O(num_cpu)

elapsed time: 1447m

configs tested: 221
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    clang-15
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-001-20250320    gcc-7.5.0
arc                   randconfig-002-20250320    gcc-7.5.0
arc                   randconfig-002-20250320    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-6.5.0
arm                       aspeed_g5_defconfig    clang-15
arm                                 defconfig    gcc-14.2.0
arm                             mxs_defconfig    clang-15
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-001-20250320    gcc-7.5.0
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-002-20250320    gcc-7.5.0
arm                   randconfig-003-20250320    gcc-7.5.0
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-004-20250320    gcc-6.5.0
arm                   randconfig-004-20250320    gcc-7.5.0
arm                           tegra_defconfig    clang-15
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-15
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-001-20250320    gcc-7.5.0
arm64                 randconfig-002-20250320    clang-21
arm64                 randconfig-002-20250320    gcc-7.5.0
arm64                 randconfig-003-20250320    clang-19
arm64                 randconfig-003-20250320    gcc-7.5.0
arm64                 randconfig-004-20250320    gcc-7.5.0
arm64                 randconfig-004-20250320    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-001-20250320    gcc-12.4.0
csky                  randconfig-002-20250320    gcc-12.4.0
csky                  randconfig-002-20250320    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-001-20250320    gcc-12.4.0
hexagon               randconfig-002-20250320    clang-21
hexagon               randconfig-002-20250320    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250320    clang-20
i386                  randconfig-002-20250320    clang-20
i386                  randconfig-003-20250320    clang-20
i386                  randconfig-004-20250320    clang-20
i386                  randconfig-005-20250320    clang-20
i386                  randconfig-006-20250320    clang-20
i386                  randconfig-007-20250320    clang-20
i386                  randconfig-011-20250320    gcc-12
i386                  randconfig-012-20250320    gcc-12
i386                  randconfig-013-20250320    gcc-12
i386                  randconfig-014-20250320    gcc-12
i386                  randconfig-015-20250320    gcc-12
i386                  randconfig-016-20250320    gcc-12
i386                  randconfig-017-20250320    gcc-12
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-15
loongarch             randconfig-001-20250320    gcc-12.4.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-002-20250320    gcc-12.4.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-15
mips                         rt305x_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-12.4.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-10.5.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250320    gcc-12.4.0
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-002-20250320    gcc-11.5.0
parisc                randconfig-002-20250320    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-15
powerpc                      bamboo_defconfig    clang-15
powerpc                 mpc8313_rdb_defconfig    clang-15
powerpc               randconfig-001-20250320    gcc-12.4.0
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-002-20250320    gcc-12.4.0
powerpc               randconfig-003-20250320    clang-21
powerpc               randconfig-003-20250320    gcc-12.4.0
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-001-20250320    gcc-12.4.0
powerpc64             randconfig-002-20250320    gcc-12.4.0
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-003-20250320    clang-21
powerpc64             randconfig-003-20250320    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-002-20250320    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-8.5.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-15
sh                            migor_defconfig    clang-15
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                          sdk7780_defconfig    clang-15
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-002-20250320    clang-16
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250320    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250320    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250320    clang-20
x86_64                randconfig-002-20250320    clang-20
x86_64                randconfig-003-20250320    clang-20
x86_64                randconfig-004-20250320    clang-20
x86_64                randconfig-005-20250320    clang-20
x86_64                randconfig-006-20250320    clang-20
x86_64                randconfig-007-20250320    clang-20
x86_64                randconfig-008-20250320    clang-20
x86_64                randconfig-071-20250320    gcc-12
x86_64                randconfig-072-20250320    gcc-12
x86_64                randconfig-073-20250320    gcc-12
x86_64                randconfig-074-20250320    gcc-12
x86_64                randconfig-075-20250320    gcc-12
x86_64                randconfig-076-20250320    gcc-12
x86_64                randconfig-077-20250320    gcc-12
x86_64                randconfig-078-20250320    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-15
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-002-20250320    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

