Return-Path: <cgroups+bounces-1930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051D86DDF5
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 10:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1051C20B4B
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118C6A341;
	Fri,  1 Mar 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+c2jl/6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE169D2C
	for <cgroups@vger.kernel.org>; Fri,  1 Mar 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284501; cv=none; b=cXVZ8SFC/z1DJk8InorzFGlxeWfjlSf5TFRj2lVRbgppsk9xkDQj8cmPCN2fSd/n4VgDbsKCuRI/159v37b38I40pnu2tqXzY6JYKLN5NIPckBd8lnp/zAuvXQ2LL5fE9ACsVsIbNUs4m4vEx0u3rcqEidZDl4EyWVNamczC3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284501; c=relaxed/simple;
	bh=yzWycd90ai4ZIvZY9XCO53vIMP+22xutPcItWC1QLs8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LHA9MY7irob86qudXwXBdfJkRSH2idL/8spxVyaWQlSlAYKVbOEaaSr9qEekNi63n3JnX5x3n6hZI5pcDoO74sS7iB1zRMBhVTCCnswRH0cZTKPsyjbhs3d37Wm7uSDapgteWkEss9MAZkCHuC2q36DjgZCF16o0A0dGjKthuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+c2jl/6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709284500; x=1740820500;
  h=date:from:to:cc:subject:message-id;
  bh=yzWycd90ai4ZIvZY9XCO53vIMP+22xutPcItWC1QLs8=;
  b=C+c2jl/6kqv4YCyf6Xk0GqD3eyIk/SsNOzB2Vr9sr3sAVoTmdebypxbx
   lZUZG3Qop72CQn9gXuNWRgGnVMzS49vJtqkxjg9/t7WKWOuMCTRb6Tc41
   c3+Hz1QqbUChsJgI57LFJsl6iBArqlOBlFMg3YmKcNE86qWD7THBoB1mR
   gmFeTADsnf6OVYb1u3TIPc2j54OuM8TqnX//Chp8xMmszDbhOgGEKLUKS
   XqzPjaMfGjOeJ6eA8dv65R5XhkTY4uExG9FAQIxJo9t6RwcS+TeOJfqTR
   /aIjGr1Be46Ri7n+MLD+CZ9jbnW/FKwzXmyy+xlS6S5WqOf1UwtBhKhmH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26274520"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="26274520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 01:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="45671653"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Mar 2024 01:14:57 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfyyk-000Dhx-2W;
	Fri, 01 Mar 2024 09:14:54 +0000
Date: Fri, 01 Mar 2024 17:14:37 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 13eb1d6e1cfcfc277d2cba521c6082ab3e16b43f
Message-ID: <202403011734.njaNNJYC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 13eb1d6e1cfcfc277d2cba521c6082ab3e16b43f  Merge branch 'for-6.8-fixes' into for-next

elapsed time: 740m

configs tested: 175
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240301   gcc  
arc                   randconfig-002-20240301   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240301   gcc  
arm                   randconfig-002-20240301   clang
arm                   randconfig-003-20240301   gcc  
arm                   randconfig-004-20240301   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240301   gcc  
arm64                 randconfig-002-20240301   clang
arm64                 randconfig-003-20240301   gcc  
arm64                 randconfig-004-20240301   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240301   gcc  
csky                  randconfig-002-20240301   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240301   clang
hexagon               randconfig-002-20240301   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240301   clang
i386         buildonly-randconfig-002-20240301   clang
i386         buildonly-randconfig-003-20240301   gcc  
i386         buildonly-randconfig-004-20240301   clang
i386         buildonly-randconfig-005-20240301   clang
i386         buildonly-randconfig-006-20240301   clang
i386                                defconfig   clang
i386                  randconfig-001-20240301   clang
i386                  randconfig-002-20240301   clang
i386                  randconfig-003-20240301   clang
i386                  randconfig-004-20240301   clang
i386                  randconfig-005-20240301   gcc  
i386                  randconfig-006-20240301   gcc  
i386                  randconfig-011-20240301   gcc  
i386                  randconfig-012-20240301   clang
i386                  randconfig-013-20240301   clang
i386                  randconfig-014-20240301   gcc  
i386                  randconfig-015-20240301   gcc  
i386                  randconfig-016-20240301   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240301   gcc  
loongarch             randconfig-002-20240301   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240301   gcc  
nios2                 randconfig-002-20240301   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240301   gcc  
parisc                randconfig-002-20240301   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc               randconfig-001-20240301   gcc  
powerpc               randconfig-002-20240301   gcc  
powerpc               randconfig-003-20240301   clang
powerpc64             randconfig-001-20240301   clang
powerpc64             randconfig-002-20240301   gcc  
powerpc64             randconfig-003-20240301   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240301   gcc  
riscv                 randconfig-002-20240301   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240301   clang
s390                  randconfig-002-20240301   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240301   gcc  
sh                    randconfig-002-20240301   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240301   gcc  
sparc64               randconfig-002-20240301   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240301   gcc  
um                    randconfig-002-20240301   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240301   clang
x86_64       buildonly-randconfig-002-20240301   gcc  
x86_64       buildonly-randconfig-003-20240301   clang
x86_64       buildonly-randconfig-004-20240301   gcc  
x86_64       buildonly-randconfig-005-20240301   clang
x86_64       buildonly-randconfig-006-20240301   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240301   gcc  
x86_64                randconfig-002-20240301   clang
x86_64                randconfig-003-20240301   clang
x86_64                randconfig-004-20240301   clang
x86_64                randconfig-005-20240301   gcc  
x86_64                randconfig-006-20240301   gcc  
x86_64                randconfig-011-20240301   clang
x86_64                randconfig-012-20240301   clang
x86_64                randconfig-013-20240301   clang
x86_64                randconfig-014-20240301   gcc  
x86_64                randconfig-015-20240301   clang
x86_64                randconfig-016-20240301   gcc  
x86_64                randconfig-071-20240301   gcc  
x86_64                randconfig-072-20240301   clang
x86_64                randconfig-073-20240301   gcc  
x86_64                randconfig-074-20240301   gcc  
x86_64                randconfig-075-20240301   gcc  
x86_64                randconfig-076-20240301   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240301   gcc  
xtensa                randconfig-002-20240301   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

