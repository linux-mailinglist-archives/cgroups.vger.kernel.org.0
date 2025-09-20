Return-Path: <cgroups+bounces-10309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5CB8CA71
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68004564A00
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A82C0298;
	Sat, 20 Sep 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh82+ZjE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567080C02
	for <cgroups@vger.kernel.org>; Sat, 20 Sep 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379271; cv=none; b=njd5rkW08gjO1VgWzLhOYbSezT4BPet8qaBX5goxSdZiv3bMock94PFdlR8YIgVJr+NKWzLa3PS5ubShmS1Z4T7VSd8k0Y4MJqt55J09GU8N0PxEAWbFSXnruUWUt89QMCLJ8Ny2B+6+oy050M6382v6ueiNdbNwjMbO2SKvrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379271; c=relaxed/simple;
	bh=4PVHnVpcenZDHWSzRzYpEDPWjsoHtP6sbRtqyI+8LE8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a6etYpqezUR7Ko2vZgoIEPH1lVg0JIkNRdETij2dRVuGgKYwU4hHeJf3nrdLctYQEs3GrAZYWM9JhsbYKAXpp2c5O9D9/nKZhfORhWItf08wFo2s1t4d4x6x3ZgbhxIGs2rTRi3+eVvB1GlApexz4BQYEYk3+IDsYGvfULletWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh82+ZjE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758379269; x=1789915269;
  h=date:from:to:cc:subject:message-id;
  bh=4PVHnVpcenZDHWSzRzYpEDPWjsoHtP6sbRtqyI+8LE8=;
  b=Mh82+ZjEE6KwdQtgHUxs8qrkbPBLqGJraOa7Brk8L401sJ5C0r2xzyzg
   ZdWRlyzTcCGZarmnsHwzIJPreHXAVlMvUKtEqvi9M4m7IEgn9z5qrJW09
   +eWGOs8wFhXxIzw42iuupP3JavL5GUcjqGGSDANitKH/HOO83vBPjmF6g
   5f5CaQOwI86DvRmjmPVa1NE+HYROsXBUntcY9XProOtDdZBE2xytCMwmE
   lzei6Kto9+3bLDnmN4G7x5RkqBKjjUiWPi/r3Bk5wv9BLLtOFpls5bjNm
   Ufx4yTlqC01fdJaQ6A6TVSzu1frmyTTY08CplGmg+Hi5BK+2YcA42NR3R
   A==;
X-CSE-ConnectionGUID: hq4pyGB4RUizkVvPK+NS0A==
X-CSE-MsgGUID: yKJX/Ad1RqK6vAwipnguEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60645883"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60645883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 07:41:08 -0700
X-CSE-ConnectionGUID: L62AzktOSAeU4HvBQhrQuQ==
X-CSE-MsgGUID: kWz2/Du3T1uCbWuSbLjMfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="206832840"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Sep 2025 07:41:07 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzyls-0005Nz-0c;
	Sat, 20 Sep 2025 14:41:04 +0000
Date: Sat, 20 Sep 2025 22:40:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD SUCCESS
 51840f7ba393dce7624a759cc4cee8c2bedf9068
Message-ID: <202509202217.jY1VvgnQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: 51840f7ba393dce7624a759cc4cee8c2bedf9068  cpuset: fix missing error return in update_cpumask

elapsed time: 1295m

configs tested: 224
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250920    gcc-9.5.0
arc                   randconfig-002-20250920    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250920    gcc-12.5.0
arm                   randconfig-001-20250920    gcc-9.5.0
arm                   randconfig-002-20250920    clang-22
arm                   randconfig-002-20250920    gcc-9.5.0
arm                   randconfig-003-20250920    clang-22
arm                   randconfig-003-20250920    gcc-9.5.0
arm                   randconfig-004-20250920    clang-22
arm                   randconfig-004-20250920    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250920    clang-20
arm64                 randconfig-001-20250920    gcc-9.5.0
arm64                 randconfig-002-20250920    clang-22
arm64                 randconfig-002-20250920    gcc-9.5.0
arm64                 randconfig-003-20250920    clang-18
arm64                 randconfig-003-20250920    gcc-9.5.0
arm64                 randconfig-004-20250920    clang-22
arm64                 randconfig-004-20250920    gcc-9.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250920    clang-16
csky                  randconfig-001-20250920    gcc-10.5.0
csky                  randconfig-002-20250920    clang-16
csky                  randconfig-002-20250920    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250920    clang-16
hexagon               randconfig-001-20250920    clang-22
hexagon               randconfig-002-20250920    clang-16
hexagon               randconfig-002-20250920    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250920    clang-20
i386        buildonly-randconfig-001-20250920    gcc-13
i386        buildonly-randconfig-002-20250920    clang-20
i386        buildonly-randconfig-002-20250920    gcc-13
i386        buildonly-randconfig-003-20250920    clang-20
i386        buildonly-randconfig-003-20250920    gcc-13
i386        buildonly-randconfig-004-20250920    gcc-13
i386        buildonly-randconfig-005-20250920    clang-20
i386        buildonly-randconfig-005-20250920    gcc-13
i386        buildonly-randconfig-006-20250920    clang-20
i386        buildonly-randconfig-006-20250920    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20250920    clang-20
i386                  randconfig-002-20250920    clang-20
i386                  randconfig-003-20250920    clang-20
i386                  randconfig-004-20250920    clang-20
i386                  randconfig-005-20250920    clang-20
i386                  randconfig-006-20250920    clang-20
i386                  randconfig-007-20250920    clang-20
i386                  randconfig-011-20250920    gcc-14
i386                  randconfig-012-20250920    gcc-14
i386                  randconfig-013-20250920    gcc-14
i386                  randconfig-014-20250920    gcc-14
i386                  randconfig-015-20250920    gcc-14
i386                  randconfig-016-20250920    gcc-14
i386                  randconfig-017-20250920    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250920    clang-16
loongarch             randconfig-001-20250920    clang-22
loongarch             randconfig-002-20250920    clang-16
loongarch             randconfig-002-20250920    gcc-12.5.0
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
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250920    clang-16
nios2                 randconfig-001-20250920    gcc-9.5.0
nios2                 randconfig-002-20250920    clang-16
nios2                 randconfig-002-20250920    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250920    clang-16
parisc                randconfig-001-20250920    gcc-8.5.0
parisc                randconfig-002-20250920    clang-16
parisc                randconfig-002-20250920    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250920    clang-16
powerpc               randconfig-001-20250920    clang-17
powerpc               randconfig-002-20250920    clang-16
powerpc               randconfig-002-20250920    clang-22
powerpc               randconfig-003-20250920    clang-16
powerpc               randconfig-003-20250920    clang-22
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250920    clang-16
powerpc64             randconfig-002-20250920    clang-16
powerpc64             randconfig-002-20250920    gcc-10.5.0
powerpc64             randconfig-003-20250920    clang-16
powerpc64             randconfig-003-20250920    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250920    clang-22
riscv                 randconfig-001-20250920    gcc-14.3.0
riscv                 randconfig-002-20250920    clang-22
riscv                 randconfig-002-20250920    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250920    clang-20
s390                  randconfig-001-20250920    gcc-14.3.0
s390                  randconfig-002-20250920    gcc-14.3.0
s390                  randconfig-002-20250920    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250920    gcc-14.3.0
sh                    randconfig-002-20250920    gcc-12.5.0
sh                    randconfig-002-20250920    gcc-14.3.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250920    gcc-14.3.0
sparc                 randconfig-001-20250920    gcc-8.5.0
sparc                 randconfig-002-20250920    gcc-14.3.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250920    gcc-14.3.0
sparc64               randconfig-001-20250920    gcc-8.5.0
sparc64               randconfig-002-20250920    gcc-14.3.0
sparc64               randconfig-002-20250920    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250920    clang-22
um                    randconfig-001-20250920    gcc-14.3.0
um                    randconfig-002-20250920    clang-22
um                    randconfig-002-20250920    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250920    clang-20
x86_64      buildonly-randconfig-001-20250920    gcc-14
x86_64      buildonly-randconfig-002-20250920    clang-20
x86_64      buildonly-randconfig-002-20250920    gcc-14
x86_64      buildonly-randconfig-003-20250920    clang-20
x86_64      buildonly-randconfig-003-20250920    gcc-14
x86_64      buildonly-randconfig-004-20250920    clang-20
x86_64      buildonly-randconfig-004-20250920    gcc-14
x86_64      buildonly-randconfig-005-20250920    gcc-14
x86_64      buildonly-randconfig-006-20250920    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250920    clang-20
x86_64                randconfig-002-20250920    clang-20
x86_64                randconfig-003-20250920    clang-20
x86_64                randconfig-004-20250920    clang-20
x86_64                randconfig-005-20250920    clang-20
x86_64                randconfig-006-20250920    clang-20
x86_64                randconfig-007-20250920    clang-20
x86_64                randconfig-008-20250920    clang-20
x86_64                randconfig-071-20250920    clang-20
x86_64                randconfig-072-20250920    clang-20
x86_64                randconfig-073-20250920    clang-20
x86_64                randconfig-074-20250920    clang-20
x86_64                randconfig-075-20250920    clang-20
x86_64                randconfig-076-20250920    clang-20
x86_64                randconfig-077-20250920    clang-20
x86_64                randconfig-078-20250920    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250920    gcc-14.3.0
xtensa                randconfig-001-20250920    gcc-8.5.0
xtensa                randconfig-002-20250920    gcc-14.3.0
xtensa                randconfig-002-20250920    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

