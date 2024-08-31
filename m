Return-Path: <cgroups+bounces-4658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548399671F0
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7492B1C21784
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333912E48;
	Sat, 31 Aug 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEcfRQq7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49512E75
	for <cgroups@vger.kernel.org>; Sat, 31 Aug 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725111611; cv=none; b=uGwZ+JKmPo6nzNvDVAskD5srxBUkm8XK6SvvxJvdO313dhqAm1+kQ09IaluxvUuhuOUfITVu1TL4vNRDqQ5CNM09SsxY/JvBNgsjhFNpVD2WN3sPYgps8mK6I2guNzFPZateK7tvUrjv1NlyOC6vdeXzvmG1qcuO2M6b1W4t9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725111611; c=relaxed/simple;
	bh=svu9qAyTCh62X6lm1zbf0DGlvy01CaMOkUWZFiY/cOI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s4lPFsAwOz7xeoljaGZIXFlowVOsEgQ+gZRGrs7+qpZ17PdZytEIXG86oaQccxLjf7lUsCi4mYCsMawBKnuRhFPqvFYgwJx3WSz+KlgDbJjNuFtolwLHfP7JRwfmyIyaUSPGoPPF8gygeOwqsLLSGr0lX9G0Pme3e5UV4OoBFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEcfRQq7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725111609; x=1756647609;
  h=date:from:to:cc:subject:message-id;
  bh=svu9qAyTCh62X6lm1zbf0DGlvy01CaMOkUWZFiY/cOI=;
  b=gEcfRQq75iBrilxsyVjWMT93wQpX7vpSYMvnY6uyZTH55Dz5WfcpTrTT
   EQwoUvdQbSM6wnS5ZYspm8UT/MIb5lzp7m6/PCFDbt0hgMWe57hg78nqo
   Q6vFXto/sFUAKmqJFBZp5j5xiYj3jVH3K//GMaCJAWtPsZFGjPhQ6vJ3a
   k/Xr7D3PcujUM1llk3XmoMXx9fYJEywWd8GWDFlBOIvfc3MQwExlWNFIM
   URu91hLVkzr24icmoZ1coSA5/yen8U60BPahYy5sGgQd2MTQ8JZibNcXS
   IRxPddBYRZtgP1LAqgZZHxfg2lJgd7UJECqxz7GcLmMu7OOCG0O2Vm7u/
   w==;
X-CSE-ConnectionGUID: cvT14gYPRvu8nctNVvVUJw==
X-CSE-MsgGUID: BFXDHT28SxCSBY1RHj+oDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23704772"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="23704772"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 06:40:08 -0700
X-CSE-ConnectionGUID: LFiM8LFURgi748uz1AJw6A==
X-CSE-MsgGUID: AHM7CW1cQYirNcY+3AYZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="68961363"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Aug 2024 06:40:07 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skOKj-0002nG-1I;
	Sat, 31 Aug 2024 13:40:05 +0000
Date: Sat, 31 Aug 2024 21:39:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.12] BUILD SUCCESS
 3f9319c6914c45a2d406faf3aa8cd0dee8bc4c2f
Message-ID: <202408312115.SP1E6UAP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.12
branch HEAD: 3f9319c6914c45a2d406faf3aa8cd0dee8bc4c2f  cgroup/cpuset: add sefltest for cpuset v1

elapsed time: 1030m

configs tested: 110
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
arc                                 defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          gemini_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                         vf610m4_defconfig   clang-20
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240831   clang-18
i386         buildonly-randconfig-002-20240831   clang-18
i386         buildonly-randconfig-003-20240831   clang-18
i386         buildonly-randconfig-004-20240831   clang-18
i386         buildonly-randconfig-005-20240831   clang-18
i386         buildonly-randconfig-006-20240831   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240831   clang-18
i386                  randconfig-002-20240831   clang-18
i386                  randconfig-003-20240831   clang-18
i386                  randconfig-004-20240831   clang-18
i386                  randconfig-005-20240831   clang-18
i386                  randconfig-006-20240831   clang-18
i386                  randconfig-011-20240831   clang-18
i386                  randconfig-012-20240831   clang-18
i386                  randconfig-013-20240831   clang-18
i386                  randconfig-014-20240831   clang-18
i386                  randconfig-015-20240831   clang-18
i386                  randconfig-016-20240831   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          malta_defconfig   clang-20
mips                        omega2p_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                    mvme5100_defconfig   clang-20
powerpc                  storcenter_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                        sh7763rdp_defconfig   clang-20
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

