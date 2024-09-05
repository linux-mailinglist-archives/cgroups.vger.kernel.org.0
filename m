Return-Path: <cgroups+bounces-4713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9B96D949
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 14:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA828ACDB
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C619D079;
	Thu,  5 Sep 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPlH8bsP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AF19C55C
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540534; cv=none; b=ixBhsb9dd6Kh0cvT1cYPNASyBmOTwI7IaXLpnu+KKJiJ7LXyViGW2yyl61TEMMQ8F7PqYTTNrALEBAhM8oD6lWpGJ6OSMJ4w9UncLEgkSaLLlwTjv8NCeyZMuUcMiT/5zDQrsjVaity0lkEqbGULP4xqhB1PY5jWrYfvx0qoUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540534; c=relaxed/simple;
	bh=r5PrNKUpu/yRdKT8NP7shJAFjcKsBPPbMIHSuJGeo8I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ro683Iuy6OgMKaPmrhqwCi8h/h95zicarzkUz8C4B6gi8gYIh6SRZljdmUlCAbuDEljQ22tdjsK6dLtG65p87LpBBhXb2hcWhUx4hP4eF7biAcvte05FFKroD0L0/CIXPaHRbmiawrJFLL2GUOwoQz2qZPXAyd+BIFjtTmeQj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPlH8bsP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540532; x=1757076532;
  h=date:from:to:cc:subject:message-id;
  bh=r5PrNKUpu/yRdKT8NP7shJAFjcKsBPPbMIHSuJGeo8I=;
  b=fPlH8bsPMCpk011r6FXj3PPH7KbML8a9KEmNvqtrPUXAyviGus/m9zc6
   gtQwF0kK3HH1SAQjkgruSzJGBGvkRZlHjRdXt61qNImvnDyw1uE0MsWEn
   jege82/CzSLKGJsQEh7yFQxQP6f5oA7ctTTsa0dXTNjtoDSDEjQSg3we/
   s2yInRtof6aE/LjY5pGBf0Jfjq9+w2kbPk8SY9ynUX4i2uxTSLydE23hf
   GvTeAdD8CFr6YVNRhBYS8Pv8ZG298cWmf1sXiV9b5oSOd9iwWQiqL7zLQ
   +KKw9E+pfF+4hTXgpA1cZe6dNFerl4lDCyaPt2D0tCwibI0M+xK4+wfKP
   g==;
X-CSE-ConnectionGUID: GDwAnkQeQma4uI1xAwq4fQ==
X-CSE-MsgGUID: X1HFRcuoTT6CgwYk3vlkHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23809326"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="23809326"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:48:52 -0700
X-CSE-ConnectionGUID: IR6QTdPtTKmWWcRNbRliBw==
X-CSE-MsgGUID: WgMzLGHWRgaVEkhOgDDW0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70030329"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2024 05:48:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smBuq-0009sY-32;
	Thu, 05 Sep 2024 12:48:48 +0000
Date: Thu, 05 Sep 2024 20:48:19 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 68d2fca079c893fd102d61a2d49d9433c81b4d8d
Message-ID: <202409052017.wWcNXpEP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 68d2fca079c893fd102d61a2d49d9433c81b4d8d  Merge branch 'for-6.12' into for-next

elapsed time: 955m

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

