Return-Path: <cgroups+bounces-2702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA288B1A2F
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 07:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319C7B21F65
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 05:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA63A1AC;
	Thu, 25 Apr 2024 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Io+bVIkT"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E537152
	for <cgroups@vger.kernel.org>; Thu, 25 Apr 2024 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021967; cv=none; b=Zmc4r3+S71B2e4E2Xt6iUkp48CuVUSMv1IGBOyO8uMILlslmYoWQ1eJQyomI4hyMPcX7/7DQEIzQDTFxf2dOMlDceTqbIYYsGy2wH28vYaJ6nX8WqLwaVTnpOyQZBAseytBS5avQ6xiwt37tkQcSqxoJ7rj5rSIw2VLndLSE9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021967; c=relaxed/simple;
	bh=sOCzfOGGMxMd3BLmhuU/UbIhYsZ9DWcqCNaLSBTnP2o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Acg0T3cfBn22l65xccMy1b64nnM6rJzJ7dAsjomgh+Nnd6hwRMGAk0DpH37FmUKsjBQi92wGlgq2gJCOadftkSmb2AB9wwrkWvM9/UUEsY6CQTweM7mh+uM90bBeIFaFyEQCgPmJjRjnf4Q1Q6dw7RNKj6iZoo2IFUfKBN5fvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Io+bVIkT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714021965; x=1745557965;
  h=date:from:to:cc:subject:message-id;
  bh=sOCzfOGGMxMd3BLmhuU/UbIhYsZ9DWcqCNaLSBTnP2o=;
  b=Io+bVIkTkwLkR3ehvlhKWzPeN9C8xgxYq5CliRGFbDkYPpjGVpVeDfUd
   LmG+0YPFu6Fx88cVJlcPOCNHc2v8wYvBabPZcwXVPWWJB7B+J9sXq5Mdi
   yXeiF23s5QwGmxLq2jcQW4jSv6ws9IwN1P/Z8BEbkVv8Vvr3MVdvSQas/
   Xbww+uxhAzKurb4RH837bo42ibkxQlNhysqmmCWeEPqeHv+sLc2mJ7Z5Z
   qpelL+bTqnb0/MpCzIbzVBv0GfNIsMiQPICBpPu10qB7dW1qDDr0BXLAI
   m4xocF1TSEFsIyYkonZPt73202tRBVJ3MIPqhXOHQH0GsQ+ZMBT43HLvm
   Q==;
X-CSE-ConnectionGUID: pVMv4vxFS9OOnmgCKrKVMg==
X-CSE-MsgGUID: it2CznZZS8STziBGz2kcxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="32175741"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="32175741"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 22:12:45 -0700
X-CSE-ConnectionGUID: lkN4zFtpRSO4CJP/riMmmg==
X-CSE-MsgGUID: /9rnDOTBTXWGaQPiizJVpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="24946925"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 22:12:43 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzrPU-0001yv-2y;
	Thu, 25 Apr 2024 05:12:40 +0000
Date: Thu, 25 Apr 2024 13:11:47 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 04d63da4da53e6064683f4970d34ce997f9daee3
Message-ID: <202404251344.2gS0MLMI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 04d63da4da53e6064683f4970d34ce997f9daee3  cgroup/cpuset: Fix incorrect top_cpuset flags

elapsed time: 1473m

configs tested: 133
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
arc                   randconfig-001-20240424   gcc  
arc                   randconfig-002-20240424   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240424   gcc  
arm                   randconfig-002-20240424   gcc  
arm                   randconfig-003-20240424   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240424   gcc  
arm64                 randconfig-003-20240424   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240424   gcc  
csky                  randconfig-002-20240424   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
i386                  randconfig-004-20240424   clang
i386                  randconfig-011-20240424   clang
i386                  randconfig-013-20240424   clang
i386                  randconfig-014-20240424   clang
i386                  randconfig-015-20240424   clang
i386                  randconfig-016-20240424   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240424   gcc  
loongarch             randconfig-002-20240424   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240424   gcc  
nios2                 randconfig-002-20240424   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240424   gcc  
parisc                randconfig-002-20240424   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-002-20240424   gcc  
powerpc               randconfig-003-20240424   gcc  
powerpc64             randconfig-001-20240424   gcc  
powerpc64             randconfig-002-20240424   gcc  
powerpc64             randconfig-003-20240424   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240424   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240424   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240424   gcc  
sh                    randconfig-002-20240424   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240424   gcc  
sparc64               randconfig-002-20240424   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240424   gcc  
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240424   gcc  
xtensa                randconfig-002-20240424   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

