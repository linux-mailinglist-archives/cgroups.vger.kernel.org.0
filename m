Return-Path: <cgroups+bounces-2027-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C44878AD4
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561AAB21610
	for <lists+cgroups@lfdr.de>; Mon, 11 Mar 2024 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21D5810E;
	Mon, 11 Mar 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAIDkVjF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A382E40E
	for <cgroups@vger.kernel.org>; Mon, 11 Mar 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196865; cv=none; b=mg4zqPmielEUCnyNyMhoVC/fNTQ3wHMuAgB5U6lqc2eBXiKHbYsv8cSiq/uOTp2ww1opuN7HOkgDRgWtAAWcpgQY1LWUL/a2TnM8FTSjKnTaFR2xzBamhlDbavIYX+K9Juvca4muA4m94cqSFOnH3XtgJs9itW/0BO/atdPAAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196865; c=relaxed/simple;
	bh=kB1+qx4Bs54/kqVcGbqa/Yq0yLkO8i9EW+k8fl0Rf6w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FKJbGwxW9TluFkwQ3a2/SeITHGX7ePci0CcRVZTKLPohXKXQJAtrVoSsHH2pkerT3n3uGyFa9tiP2YIWBfKqsC4/Yy2gSnMvKZgT5Jx5SLvtXmRWBHw1hbdiELyxHtoq0TSpB26tE3avZ+w+HEw+KY7y70Q/kV+/D3XJ7PMMvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAIDkVjF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710196863; x=1741732863;
  h=date:from:to:cc:subject:message-id;
  bh=kB1+qx4Bs54/kqVcGbqa/Yq0yLkO8i9EW+k8fl0Rf6w=;
  b=BAIDkVjF9hKJnTshEIUyr8y2XOFOuPLHxfY5Y0WmzOl9VUffearbotWm
   4Brb4pav9q9Ru1jcIs469OncSSslI4NFHCcBWPnCDm+piaDh4CUvYs2/M
   LoOf0mpf3cCppO8OEA7c61z9c8yb273XOxfgd5FzQe3rOX9BhqABi5Wej
   irCBr7oPpLh6wZEyqyi9DWoe4w3z0Wkx7t+MRMd3Z6kcJESdWCMVgt9g8
   C9lS9Z74RYEAorFxQI0MG2SxDtgGHmYfZueDSJMEBhC0KG7OJwRm80Arc
   sa5HYHJ7Eytf+42hOQZGmh/REO/EiUNY6mNeFG6xuHXqxCaiJ85dT1ZUb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27359804"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="27359804"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 15:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11384236"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Mar 2024 15:41:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjoKJ-0009Vx-0q;
	Mon, 11 Mar 2024 22:40:59 +0000
Date: Tue, 12 Mar 2024 06:40:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-6.9] BUILD SUCCESS
 4553704652b93ad7f9aba880c412b482da6581f9
Message-ID: <202403120607.u4H08lRv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-6.9
branch HEAD: 4553704652b93ad7f9aba880c412b482da6581f9  Merge branch 'for-6.9' into test-merge-for-6.9

elapsed time: 722m

configs tested: 195
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240311   gcc  
arc                   randconfig-002-20240311   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                   randconfig-001-20240311   clang
arm                   randconfig-002-20240311   gcc  
arm                   randconfig-003-20240311   clang
arm                   randconfig-004-20240311   clang
arm                        shmobile_defconfig   gcc  
arm                       versatile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240311   clang
arm64                 randconfig-002-20240311   clang
arm64                 randconfig-003-20240311   clang
arm64                 randconfig-004-20240311   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240311   gcc  
csky                  randconfig-002-20240311   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240311   clang
hexagon               randconfig-002-20240311   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240311   clang
i386         buildonly-randconfig-002-20240311   clang
i386         buildonly-randconfig-003-20240311   clang
i386         buildonly-randconfig-004-20240311   gcc  
i386         buildonly-randconfig-005-20240311   clang
i386         buildonly-randconfig-005-20240312   clang
i386         buildonly-randconfig-006-20240311   clang
i386                                defconfig   clang
i386                  randconfig-001-20240311   gcc  
i386                  randconfig-002-20240311   gcc  
i386                  randconfig-002-20240312   clang
i386                  randconfig-003-20240311   clang
i386                  randconfig-004-20240311   clang
i386                  randconfig-005-20240311   gcc  
i386                  randconfig-006-20240311   clang
i386                  randconfig-011-20240311   gcc  
i386                  randconfig-012-20240311   gcc  
i386                  randconfig-013-20240311   clang
i386                  randconfig-013-20240312   clang
i386                  randconfig-014-20240311   gcc  
i386                  randconfig-014-20240312   clang
i386                  randconfig-015-20240311   clang
i386                  randconfig-016-20240311   clang
i386                  randconfig-016-20240312   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240311   gcc  
loongarch             randconfig-002-20240311   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240311   gcc  
nios2                 randconfig-002-20240311   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240311   gcc  
parisc                randconfig-002-20240311   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                        fsp2_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240311   gcc  
powerpc               randconfig-002-20240311   clang
powerpc               randconfig-003-20240311   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-001-20240311   clang
powerpc64             randconfig-002-20240311   clang
powerpc64             randconfig-003-20240311   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240311   clang
riscv                 randconfig-002-20240311   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240311   clang
s390                  randconfig-002-20240311   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240311   gcc  
sh                    randconfig-002-20240311   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240311   gcc  
sparc64               randconfig-002-20240311   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240311   gcc  
um                    randconfig-002-20240311   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240311   clang
x86_64       buildonly-randconfig-002-20240311   clang
x86_64       buildonly-randconfig-003-20240311   clang
x86_64       buildonly-randconfig-004-20240311   gcc  
x86_64       buildonly-randconfig-005-20240311   clang
x86_64       buildonly-randconfig-006-20240311   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240311   clang
x86_64                randconfig-002-20240311   clang
x86_64                randconfig-003-20240311   gcc  
x86_64                randconfig-004-20240311   gcc  
x86_64                randconfig-005-20240311   gcc  
x86_64                randconfig-006-20240311   clang
x86_64                randconfig-011-20240311   clang
x86_64                randconfig-012-20240311   clang
x86_64                randconfig-013-20240311   clang
x86_64                randconfig-014-20240311   gcc  
x86_64                randconfig-015-20240311   clang
x86_64                randconfig-016-20240311   gcc  
x86_64                randconfig-071-20240311   gcc  
x86_64                randconfig-072-20240311   clang
x86_64                randconfig-073-20240311   clang
x86_64                randconfig-074-20240311   gcc  
x86_64                randconfig-075-20240311   clang
x86_64                randconfig-076-20240311   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240311   gcc  
xtensa                randconfig-002-20240311   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

