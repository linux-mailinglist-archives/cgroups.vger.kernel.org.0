Return-Path: <cgroups+bounces-10968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8CBF8091
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 20:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC3425EF9
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA234E75D;
	Tue, 21 Oct 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVHWkwJb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81683451DF
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071000; cv=none; b=Ef6pJpuY4aFtnM3NwUBNrnGv6t2DKA13uRbOnewKYQImegkp0XXQNwNlmekOoO1cdgLfiIFjBQIp0hlsftHullODhFPVSESZ9/V5UwKpQNoLWx+B/A1qcw9bo24pjIKZz2nOATOtdzxcbiF7k8NRaV7sdKZBj+P12AdscQ5+2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071000; c=relaxed/simple;
	bh=rlAc9NYiFjJebTBfD7RQOmQI18e1xO06bt/rQCpOx8c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q43dmYxpCtRV4WlsvrSe2BFnZGFmJj3dlNf6FtbPz/4hy/JaMIBwcgUHdXFBz/Cti1lVwWadru47JBRHhdwnel+LxGBJOWnR0mLg+5cNpMOfcaqBcI7TgZRbDkfe4rO+Ec5zQLNJRZHSb0+azXdgCEbXtMsslFIb7SfQkATTiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVHWkwJb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761070999; x=1792606999;
  h=date:from:to:cc:subject:message-id;
  bh=rlAc9NYiFjJebTBfD7RQOmQI18e1xO06bt/rQCpOx8c=;
  b=QVHWkwJb+3aj2UmlRl0ZT+4xNijiFdJN9D+aASFIKZ1i4GWOuSbiyqDZ
   l91SSQ/aHpryjO8jsuW5c8lQNs2JfnZneZ3YzMgWCH16XjVC7TzwaPVZ9
   TE4hXGg3KoFMuRQVFYdWhYNWGP9wxm5dQine/HaKWh1snwVzqdrFHRwic
   wZU2kfCeVA5Ww0166AzYjI7eBYFBklWJaHl1EHA5krTfAGzgWfEhkuFLJ
   lzuBrk9nlMkHnv3QVKr9f8sa8of6b7fBFYDyW2R3Y7zwtfo3zufI1/Qdd
   S7rn3ZqwuhQUWWHFWg4PgPwlGYrqW2KRiEUTeSOOHlKFrZDy0IIY2nsXw
   Q==;
X-CSE-ConnectionGUID: 6y7DCK9xSzqSDlTay+7spA==
X-CSE-MsgGUID: JnFbveneTAadpu8ADSpY9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50782621"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="50782621"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:23:18 -0700
X-CSE-ConnectionGUID: R67TRni5T0OnJ901J72d6w==
X-CSE-MsgGUID: iml3kfkkRe63KP5u4Dq/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184065250"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Oct 2025 11:23:17 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBH0W-000BAR-2a;
	Tue, 21 Oct 2025 18:22:54 +0000
Date: Wed, 22 Oct 2025 02:20:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 d5cf4d34a3331aa1dba954949ea71b5eafcbf0a8
Message-ID: <202510220218.an8oLY7z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: d5cf4d34a3331aa1dba954949ea71b5eafcbf0a8  cgroup/cpuset: Don't track # of local child partitions

elapsed time: 1444m

configs tested: 229
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251021    clang-22
arc                   randconfig-001-20251021    gcc-8.5.0
arc                   randconfig-002-20251021    clang-22
arc                   randconfig-002-20251021    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20251021    clang-22
arm                   randconfig-002-20251021    clang-22
arm                   randconfig-003-20251021    clang-22
arm                   randconfig-004-20251021    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251021    clang-22
arm64                 randconfig-001-20251021    gcc-15.1.0
arm64                 randconfig-002-20251021    clang-22
arm64                 randconfig-003-20251021    clang-22
arm64                 randconfig-003-20251021    gcc-12.5.0
arm64                 randconfig-004-20251021    clang-18
arm64                 randconfig-004-20251021    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251021    gcc-15.1.0
csky                  randconfig-001-20251021    gcc-8.5.0
csky                  randconfig-002-20251021    gcc-11.5.0
csky                  randconfig-002-20251021    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251021    clang-22
hexagon               randconfig-001-20251021    gcc-8.5.0
hexagon               randconfig-002-20251021    clang-17
hexagon               randconfig-002-20251021    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251021    clang-20
i386        buildonly-randconfig-002-20251021    clang-20
i386        buildonly-randconfig-003-20251021    clang-20
i386        buildonly-randconfig-004-20251021    clang-20
i386        buildonly-randconfig-004-20251021    gcc-14
i386        buildonly-randconfig-005-20251021    clang-20
i386        buildonly-randconfig-005-20251021    gcc-14
i386        buildonly-randconfig-006-20251021    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251021    gcc-14
i386                  randconfig-002-20251021    gcc-14
i386                  randconfig-003-20251021    gcc-14
i386                  randconfig-004-20251021    gcc-14
i386                  randconfig-005-20251021    gcc-14
i386                  randconfig-006-20251021    gcc-14
i386                  randconfig-007-20251021    gcc-14
i386                  randconfig-011-20251021    clang-20
i386                  randconfig-012-20251021    clang-20
i386                  randconfig-013-20251021    clang-20
i386                  randconfig-014-20251021    clang-20
i386                  randconfig-015-20251021    clang-20
i386                  randconfig-016-20251021    clang-20
i386                  randconfig-017-20251021    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251021    clang-22
loongarch             randconfig-001-20251021    gcc-8.5.0
loongarch             randconfig-002-20251021    clang-22
loongarch             randconfig-002-20251021    gcc-8.5.0
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
nios2                 randconfig-001-20251021    gcc-10.5.0
nios2                 randconfig-001-20251021    gcc-8.5.0
nios2                 randconfig-002-20251021    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251021    gcc-8.5.0
parisc                randconfig-002-20251021    gcc-15.1.0
parisc                randconfig-002-20251021    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    clang-22
powerpc                      ep88xc_defconfig    clang-22
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc                      ppc44x_defconfig    clang-22
powerpc                       ppc64_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251021    clang-22
powerpc               randconfig-001-20251021    gcc-8.5.0
powerpc               randconfig-002-20251021    clang-19
powerpc               randconfig-002-20251021    gcc-8.5.0
powerpc               randconfig-003-20251021    clang-22
powerpc               randconfig-003-20251021    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc                     tqm8560_defconfig    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20251021    clang-22
powerpc64             randconfig-001-20251021    gcc-8.5.0
powerpc64             randconfig-002-20251021    gcc-12.5.0
powerpc64             randconfig-002-20251021    gcc-8.5.0
powerpc64             randconfig-003-20251021    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251021    gcc-8.5.0
riscv                 randconfig-002-20251021    clang-22
riscv                 randconfig-002-20251021    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251021    clang-22
s390                  randconfig-001-20251021    gcc-8.5.0
s390                  randconfig-002-20251021    gcc-11.5.0
s390                  randconfig-002-20251021    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251021    gcc-8.5.0
sh                    randconfig-001-20251021    gcc-9.5.0
sh                    randconfig-002-20251021    gcc-10.5.0
sh                    randconfig-002-20251021    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251021    gcc-8.5.0
sparc                 randconfig-002-20251021    gcc-14.3.0
sparc                 randconfig-002-20251021    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251021    gcc-8.5.0
sparc64               randconfig-002-20251021    gcc-10.5.0
sparc64               randconfig-002-20251021    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251021    gcc-14
um                    randconfig-001-20251021    gcc-8.5.0
um                    randconfig-002-20251021    gcc-14
um                    randconfig-002-20251021    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251021    clang-20
x86_64      buildonly-randconfig-001-20251021    gcc-13
x86_64      buildonly-randconfig-002-20251021    clang-20
x86_64      buildonly-randconfig-003-20251021    clang-20
x86_64      buildonly-randconfig-004-20251021    clang-20
x86_64      buildonly-randconfig-005-20251021    clang-20
x86_64      buildonly-randconfig-005-20251021    gcc-14
x86_64      buildonly-randconfig-006-20251021    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251021    gcc-14
x86_64                randconfig-002-20251021    gcc-14
x86_64                randconfig-003-20251021    gcc-14
x86_64                randconfig-004-20251021    gcc-14
x86_64                randconfig-005-20251021    gcc-14
x86_64                randconfig-006-20251021    gcc-14
x86_64                randconfig-007-20251021    gcc-14
x86_64                randconfig-008-20251021    gcc-14
x86_64                randconfig-071-20251021    gcc-14
x86_64                randconfig-072-20251021    gcc-14
x86_64                randconfig-073-20251021    gcc-14
x86_64                randconfig-074-20251021    gcc-14
x86_64                randconfig-075-20251021    gcc-14
x86_64                randconfig-076-20251021    gcc-14
x86_64                randconfig-077-20251021    gcc-14
x86_64                randconfig-078-20251021    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251021    gcc-8.5.0
xtensa                randconfig-002-20251021    gcc-13.4.0
xtensa                randconfig-002-20251021    gcc-8.5.0
xtensa                    smp_lx200_defconfig    clang-22
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

