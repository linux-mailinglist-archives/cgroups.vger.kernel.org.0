Return-Path: <cgroups+bounces-4714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D096D9F8
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4879F1C23C03
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEBB19AD93;
	Thu,  5 Sep 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHQP1ASL"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1419AD87
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542174; cv=none; b=UqnlPE22CQ4RJIobL3k1Hpk8Wcq1z+FsoZ/JtZtalnicaQT8fog1UuBqCrUaKqr+tGe/b73+FWfIGC2D6+MmZjV8cH0XGn/tBhbK+TmQpSD13NA7nM+aI7B5XyTvPKjNqlExrA34tofTJN2XTVKQU62rbpNeJW8UC+KTKsn39zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542174; c=relaxed/simple;
	bh=cWUKQC+Ajzd30Rn9wnOXCTH1CNtChtvivrkbBJLzpgk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CRrAYkFIlMdPe+u0eyL5jQebGrlJ4Qu3Tqn6q8gs3wxmU/p29VWdm87VqknIOCQNfXufwzEgJk/cKonztqOIYBQ3a18NlECRsq0YBL3RFlGV8CGi2kw9k1FDSYsEuQllyN+T+Cj+mSIDfxj4C7rOU9F+zs2538qbsE1gUcjGPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHQP1ASL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725542173; x=1757078173;
  h=date:from:to:cc:subject:message-id;
  bh=cWUKQC+Ajzd30Rn9wnOXCTH1CNtChtvivrkbBJLzpgk=;
  b=WHQP1ASLSidLwXuszj5kNsTqZDBS1miVK/4RaPTlZrE41+8ViJwKuYSl
   qFO+c9dQqBGvzZ8V74Z+mNgxlvCdPY0fwPxUVcQ6WJxGX50OvjXqMqbJH
   ja0xzfw0lyWTHePX73wscKfI/JCiuwZuDAdtNTxQtUcH45HSn/QJvFiIa
   gHTT16ndyjxYXJAu5rqr5cS4PiBZywes5FlLnHE2N/fQVQb8ohMuMJ/Rj
   1xU50X8GkVgySME54Ijg+tbAFpih5zrO+Y+SaBLwfsn/JxGTp/vGu3WoJ
   IUicaXa/Y7/5nwASip9gEk66/L0Itph5kKXIKxs7C8HwzpjX9pPQsAruH
   w==;
X-CSE-ConnectionGUID: lCABZpRDS2alGQzkSLQB+w==
X-CSE-MsgGUID: Acpqvcj4RV+gZMI3HTYq1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24132254"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24132254"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:16:00 -0700
X-CSE-ConnectionGUID: 9gqk+MTMTAyw7UJiA69t+g==
X-CSE-MsgGUID: VHbZlG5aQ2230PKUjHgp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70539495"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Sep 2024 06:15:59 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smCL6-0009uF-2r;
	Thu, 05 Sep 2024 13:15:56 +0000
Date: Thu, 05 Sep 2024 21:15:12 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.12] BUILD SUCCESS
 8c7e22fc917a0d76794ebf3fcd81f9d91cee4f5d
Message-ID: <202409052109.8H1sOOCg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.12
branch HEAD: 8c7e22fc917a0d76794ebf3fcd81f9d91cee4f5d  cgroup/cpuset: Move cpu.h include to cpuset-internal.h

elapsed time: 982m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                      axs103_smp_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                     haps_hs_smp_defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   gcc-14.1.0
arc                   randconfig-001-20240905   gcc-12
arc                   randconfig-002-20240905   gcc-12
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          ixp4xx_defconfig   gcc-14.1.0
arm                             mxs_defconfig   gcc-14.1.0
arm                   randconfig-001-20240905   gcc-12
arm                   randconfig-002-20240905   gcc-12
arm                   randconfig-003-20240905   gcc-12
arm                   randconfig-004-20240905   gcc-12
arm                           sama5_defconfig   gcc-14.1.0
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240905   gcc-12
arm64                 randconfig-002-20240905   gcc-12
arm64                 randconfig-003-20240905   gcc-12
arm64                 randconfig-004-20240905   gcc-12
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240905   gcc-12
csky                  randconfig-002-20240905   gcc-12
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240905   gcc-12
hexagon               randconfig-002-20240905   gcc-12
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240905   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   gcc-12
i386         buildonly-randconfig-005-20240905   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   gcc-12
i386                  randconfig-012-20240905   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   gcc-12
i386                  randconfig-015-20240905   gcc-12
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240905   gcc-12
loongarch             randconfig-002-20240905   gcc-12
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                            mac_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
microblaze                      mmu_defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           ip32_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240905   gcc-12
nios2                 randconfig-002-20240905   gcc-12
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                generic-64bit_defconfig   gcc-14.1.0
parisc                randconfig-001-20240905   gcc-12
parisc                randconfig-002-20240905   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      chrp32_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240905   gcc-12
powerpc               randconfig-002-20240905   gcc-12
powerpc               randconfig-003-20240905   gcc-12
powerpc64             randconfig-001-20240905   gcc-12
powerpc64             randconfig-002-20240905   gcc-12
powerpc64             randconfig-003-20240905   gcc-12
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240905   gcc-12
riscv                 randconfig-002-20240905   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240905   gcc-12
s390                  randconfig-002-20240905   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          lboxre2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240905   gcc-12
sh                    randconfig-002-20240905   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240905   gcc-12
sparc64               randconfig-002-20240905   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240905   gcc-12
um                    randconfig-002-20240905   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240905   gcc-12
xtensa                randconfig-002-20240905   gcc-12

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

