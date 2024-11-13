Return-Path: <cgroups+bounces-5522-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7C9C69F4
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52545B214F7
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6E18562F;
	Wed, 13 Nov 2024 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTvf1JnX"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7335885
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482918; cv=none; b=uhLCLEYf/I663iBQKHLzmVisqkRxtOx8reVymGIrCsfHmbx8ntD56JSUB+jM6Djs23mYb31FYCBG6UCofWEJd3iD2LtGK/W52g+2AYSzle+275u3WRyyRf60pP1mi450cjh95igX6orRGAz39tb/niDwb/JJb2PWwJSlrfv6+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482918; c=relaxed/simple;
	bh=lteK7bhEc5dlQ1NTvAckMsRetcfb1UcB1KAEasPI1NM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lCxkNMscBjJkMvanRC7tyJ83HYqNZcCkEw47OsZ4mQLl2dUAuxhamApe9MKh5vDrjb9fc1V6wLXMCkQgxn9gb4Dqjl7zEek2IbWbefMecGsI4/ifrGgg5VnxEVmGDNcebflk0+jRPKERUs+kpPwPG9EkvQ+mO2TfAcv+1c3Sxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTvf1JnX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731482917; x=1763018917;
  h=date:from:to:cc:subject:message-id;
  bh=lteK7bhEc5dlQ1NTvAckMsRetcfb1UcB1KAEasPI1NM=;
  b=GTvf1JnX9n6RqFwy+HwgY4fQKkWvVSC0XyuIoZnPkh23k8ZmAXSAm/OB
   JFWMiP/drpwlO/EPD7wcdtdANCIpRmlIVQ9r0235m+7Yu0s97NGyqdm9Z
   ZX/9+MlIvR4NSZ0NJbj+dvs3FJMoEDlihx8fr9cYL8ORMjYbC9hiPke/F
   f9WikigpsMFuVOaNojbJ5Q/0LvYfFDPYBtcaO77NzqjEAdDGSh8iF1/TN
   yw583KYCLR5fXElKwjh/A+zDEgK3fra/7P92MVUnrlm2dfLRVn3LNtx7w
   H+GwCcP6Xc0NWqYTCAZp7g8Mh9UFjvYZcRMY+A1wp86MJ/vgXTvMG7fju
   w==;
X-CSE-ConnectionGUID: Y0kbJ3pCQCiJTHAGazlF0g==
X-CSE-MsgGUID: fu6+50YHShyEgLg0oEzCzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41974089"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="41974089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 23:28:36 -0800
X-CSE-ConnectionGUID: va3eojuiSGmNWjsrbnwA1A==
X-CSE-MsgGUID: aY4gAmdURwiqdBHRVqCeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="88182941"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2024 23:28:35 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB7nk-00005f-15;
	Wed, 13 Nov 2024 07:28:32 +0000
Date: Wed, 13 Nov 2024 15:28:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 95ab67727b8fcd200cca45e5bf8fd1c0e2f2f12d
Message-ID: <202411131526.B7qeTi9h-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 95ab67727b8fcd200cca45e5bf8fd1c0e2f2f12d  Merge branch 'for-6.13' into for-next

elapsed time: 729m

configs tested: 91
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                         haps_hs_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    clang-19
i386        buildonly-randconfig-005-20241113    clang-19
i386        buildonly-randconfig-006-20241113    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    clang-19
i386                  randconfig-002-20241113    clang-19
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    clang-19
i386                  randconfig-006-20241113    clang-19
i386                  randconfig-011-20241113    clang-19
i386                  randconfig-012-20241113    clang-19
i386                  randconfig-013-20241113    clang-19
i386                  randconfig-014-20241113    clang-19
i386                  randconfig-015-20241113    clang-19
i386                  randconfig-016-20241113    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

