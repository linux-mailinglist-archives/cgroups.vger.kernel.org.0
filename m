Return-Path: <cgroups+bounces-4077-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F097946B1A
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2024 21:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5CFB20F6A
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2024 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EAF2376A;
	Sat,  3 Aug 2024 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzUqVuAx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE834204E
	for <cgroups@vger.kernel.org>; Sat,  3 Aug 2024 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722714447; cv=none; b=gsJBNZHV9Lr0nkIhmcyQAnAd3jIfSmS0eruHJN9EHaHWs9IGygLTE9U/TwhPypBpSKtXS0PlS4qgJ1KDbp4U+8cvDOiC3MMpCnW0RiS5+CWQ3gWcoiGQ6riVGPnW+THnlkIUM5vXxz7RP8Yg3/zXLV5/g6VfUAl/9eLqXf3Mods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722714447; c=relaxed/simple;
	bh=7159HV/yekkugNdCaA08sNhJVDmxK2JDY2SMN/jiQHI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c8FcLAKqzoNPSKgmQUnm9Z99hD/RArmvyuaX7rBvp6jYvDcsH8u7UIEkwjYIzEE6G0lau50Bnn4GvUfYDl2TMBZs1X/jNN9PK546uZBfHuaOLemHweEc5ulOQZwIr+nhpn0ZGXJyP8Y1PXOtTlyT/jSsjCy11TndhoQpcFkIRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzUqVuAx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722714444; x=1754250444;
  h=date:from:to:cc:subject:message-id;
  bh=7159HV/yekkugNdCaA08sNhJVDmxK2JDY2SMN/jiQHI=;
  b=AzUqVuAxf02nxRgNQzLmh8eZoIUJ6bpoahfFFZbgjRzzMeTW51VapZzV
   KQS4RHl3PUnXy06izPGPlN5t+8y8QylIwcm0R/1tVeLpZdmnHy25KGv1j
   fqqQkSaREkCZCwoMN4yRWDUQOzr86X/oHX5nGhp3Xeqz8dmAkatZHgFkS
   YOQGsFZVUxSEBN3O+48ml/W0Bh870eJOBQ954DfTLUF9v08IAhMwksoTs
   tUmtS8N8cGTgu7y2RKxZ6KS+ZsTenL0wP5nKcwH80w4U28thCmSUbp2uC
   hzZGO0FItiu6Vue1H5GtAQsyP8c44UD1YSJ2Cj3mYCbxhnEvkcUa2SYsm
   Q==;
X-CSE-ConnectionGUID: xIxrxn37RZqKJxBVvJ8T1A==
X-CSE-MsgGUID: h4a4rJXyS5iUNrYhA/7GVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="32087451"
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="32087451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 12:47:23 -0700
X-CSE-ConnectionGUID: fAmN2uB5TeqF+R5TUMyT0A==
X-CSE-MsgGUID: Ey2OA3lDSjS3LOhhAPBX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="60767572"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Aug 2024 12:47:22 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saKim-0000sR-1V;
	Sat, 03 Aug 2024 19:47:20 +0000
Date: Sun, 04 Aug 2024 03:46:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 563ea1f5f85171b68f9075f5c3c22c4b521f1b5e
Message-ID: <202408040323.JhrOxzdv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 563ea1f5f85171b68f9075f5c3c22c4b521f1b5e  Documentation: Fix the compilation errors in union_find.rst

elapsed time: 1445m

configs tested: 257
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240803   gcc-13.2.0
arc                   randconfig-002-20240803   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   gcc-13.2.0
arm                      jornada720_defconfig   clang-20
arm                        keystone_defconfig   clang-20
arm                         lpc32xx_defconfig   gcc-14.1.0
arm                          moxart_defconfig   clang-20
arm                            mps2_defconfig   clang-20
arm                             mxs_defconfig   clang-20
arm                       omap2plus_defconfig   gcc-14.1.0
arm                   randconfig-001-20240803   gcc-13.2.0
arm                   randconfig-002-20240803   gcc-13.2.0
arm                   randconfig-003-20240803   gcc-13.2.0
arm                   randconfig-004-20240803   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-14.1.0
arm                           sama5_defconfig   clang-20
arm                        spear3xx_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240803   gcc-13.2.0
arm64                 randconfig-002-20240803   gcc-13.2.0
arm64                 randconfig-003-20240803   gcc-13.2.0
arm64                 randconfig-004-20240803   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240803   gcc-13.2.0
csky                  randconfig-002-20240803   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240803   clang-18
i386         buildonly-randconfig-001-20240804   gcc-12
i386         buildonly-randconfig-002-20240803   clang-18
i386         buildonly-randconfig-002-20240803   gcc-12
i386         buildonly-randconfig-002-20240804   gcc-12
i386         buildonly-randconfig-003-20240803   clang-18
i386         buildonly-randconfig-003-20240803   gcc-12
i386         buildonly-randconfig-003-20240804   gcc-12
i386         buildonly-randconfig-004-20240803   clang-18
i386         buildonly-randconfig-004-20240803   gcc-12
i386         buildonly-randconfig-004-20240804   gcc-12
i386         buildonly-randconfig-005-20240803   clang-18
i386         buildonly-randconfig-005-20240804   gcc-12
i386         buildonly-randconfig-006-20240803   clang-18
i386         buildonly-randconfig-006-20240804   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240803   clang-18
i386                  randconfig-001-20240803   gcc-12
i386                  randconfig-001-20240804   gcc-12
i386                  randconfig-002-20240803   clang-18
i386                  randconfig-002-20240803   gcc-12
i386                  randconfig-002-20240804   gcc-12
i386                  randconfig-003-20240803   clang-18
i386                  randconfig-003-20240804   gcc-12
i386                  randconfig-004-20240803   clang-18
i386                  randconfig-004-20240803   gcc-12
i386                  randconfig-004-20240804   gcc-12
i386                  randconfig-005-20240803   clang-18
i386                  randconfig-005-20240804   gcc-12
i386                  randconfig-006-20240803   clang-18
i386                  randconfig-006-20240804   gcc-12
i386                  randconfig-011-20240803   clang-18
i386                  randconfig-011-20240803   gcc-12
i386                  randconfig-011-20240804   gcc-12
i386                  randconfig-012-20240803   clang-18
i386                  randconfig-012-20240803   gcc-11
i386                  randconfig-012-20240804   gcc-12
i386                  randconfig-013-20240803   clang-18
i386                  randconfig-013-20240804   gcc-12
i386                  randconfig-014-20240803   clang-18
i386                  randconfig-014-20240804   gcc-12
i386                  randconfig-015-20240803   clang-18
i386                  randconfig-015-20240803   gcc-12
i386                  randconfig-015-20240804   gcc-12
i386                  randconfig-016-20240803   clang-18
i386                  randconfig-016-20240803   gcc-12
i386                  randconfig-016-20240804   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240803   gcc-13.2.0
loongarch             randconfig-002-20240803   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         cobalt_defconfig   clang-20
mips                     cu1000-neo_defconfig   gcc-14.1.0
mips                     cu1830-neo_defconfig   clang-20
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           gcw0_defconfig   clang-20
mips                      maltasmvp_defconfig   clang-20
mips                        maltaup_defconfig   clang-20
mips                    maltaup_xpa_defconfig   clang-20
mips                      pic32mzda_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240803   gcc-13.2.0
nios2                 randconfig-002-20240803   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240803   gcc-13.2.0
parisc                randconfig-002-20240803   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   clang-20
powerpc                        fsp2_defconfig   clang-20
powerpc                       holly_defconfig   gcc-14.1.0
powerpc                   microwatt_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc                       ppc64_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240803   gcc-13.2.0
powerpc               randconfig-003-20240803   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240803   gcc-13.2.0
powerpc64             randconfig-002-20240803   gcc-13.2.0
powerpc64             randconfig-003-20240803   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240803   gcc-13.2.0
riscv                 randconfig-002-20240803   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240803   gcc-13.2.0
s390                  randconfig-002-20240803   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-14.1.0
sh                          r7780mp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240803   gcc-13.2.0
sh                    randconfig-002-20240803   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240803   gcc-13.2.0
sparc64               randconfig-002-20240803   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240803   gcc-13.2.0
um                    randconfig-002-20240803   gcc-13.2.0
um                           x86_64_defconfig   clang-20
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240803   gcc-12
x86_64       buildonly-randconfig-002-20240803   clang-18
x86_64       buildonly-randconfig-002-20240803   gcc-12
x86_64       buildonly-randconfig-003-20240803   gcc-12
x86_64       buildonly-randconfig-004-20240803   clang-18
x86_64       buildonly-randconfig-004-20240803   gcc-12
x86_64       buildonly-randconfig-005-20240803   clang-18
x86_64       buildonly-randconfig-005-20240803   gcc-12
x86_64       buildonly-randconfig-006-20240803   clang-18
x86_64       buildonly-randconfig-006-20240803   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240803   gcc-12
x86_64                randconfig-002-20240803   gcc-12
x86_64                randconfig-003-20240803   gcc-12
x86_64                randconfig-004-20240803   clang-18
x86_64                randconfig-004-20240803   gcc-12
x86_64                randconfig-005-20240803   gcc-12
x86_64                randconfig-006-20240803   gcc-12
x86_64                randconfig-011-20240803   clang-18
x86_64                randconfig-011-20240803   gcc-12
x86_64                randconfig-012-20240803   gcc-12
x86_64                randconfig-013-20240803   clang-18
x86_64                randconfig-013-20240803   gcc-12
x86_64                randconfig-014-20240803   clang-18
x86_64                randconfig-014-20240803   gcc-12
x86_64                randconfig-015-20240803   clang-18
x86_64                randconfig-015-20240803   gcc-12
x86_64                randconfig-016-20240803   clang-18
x86_64                randconfig-016-20240803   gcc-12
x86_64                randconfig-071-20240803   gcc-12
x86_64                randconfig-072-20240803   gcc-12
x86_64                randconfig-073-20240803   clang-18
x86_64                randconfig-073-20240803   gcc-12
x86_64                randconfig-074-20240803   clang-18
x86_64                randconfig-074-20240803   gcc-12
x86_64                randconfig-075-20240803   gcc-12
x86_64                randconfig-076-20240803   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240803   gcc-13.2.0
xtensa                randconfig-002-20240803   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

