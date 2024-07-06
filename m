Return-Path: <cgroups+bounces-3556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70A929261
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2111F21FCF
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756D482FF;
	Sat,  6 Jul 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HulDKIIM"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833877101
	for <cgroups@vger.kernel.org>; Sat,  6 Jul 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720260161; cv=none; b=c2PTX50EEu4j+bDiM04ypsf+1nOrzTNirWDAKDkwIdQHfXXnLRgbnbmpOzURELMNwPkQT73jLSM78HBmlEFbE02Pd7eCWoh6BrLUt2TMgr4fw3/OuOsHRKgXlApvPEjH0uADIP7R8VQp5n0GUGAunXajbto6L0iSt09T9/ZgOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720260161; c=relaxed/simple;
	bh=isJhpg0utbXYGitVHgH91Fso6v4dyfD2TAD8sLk/1j4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HcRpQXyv3olL5NCWZ+me5wbtV6pMeDCEH9I6Veo9THOXKuSRMtv/q8/gm/I8eiqmWvrSiNE5CRdkFH8ht83C8lczYQ/Fuy/uInmA5Qkg6LAfYv/pA7OjAJcEvUNNI+/2KLc3zfTS3EG3JCkUgtYdAKzmb5Gq78WcTZeSrf61f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HulDKIIM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720260159; x=1751796159;
  h=date:from:to:cc:subject:message-id;
  bh=isJhpg0utbXYGitVHgH91Fso6v4dyfD2TAD8sLk/1j4=;
  b=HulDKIIMEMuKD4jQmQiJyV2Cm78alIQCP6QV/TzV/cZ4w/qCmtGNkM3h
   2jxDJ03Df15Gkqm2aZey7JbRMHTZXvPy5W4gvrz42aflHJTJPGUYYM4JZ
   u24pLdLuHkvHUy3JV4fzcnY0zqYAuFCHVK+0PCLFDQ8vB6xd/KctoQJGD
   hYVXYiBhYeGAqVSm48aN1TTOQPOrZoJildyYy9gI+YBSLAPxJoFmdJ/VS
   FMCIoMr9LN6mnEpPxwM+vVR2TShLk1fMJDM5gbAU4xhLESfDGg5PI9PDT
   zErCoGdrH0SV9jjPj2r4DIak8iCtsvkfn6fnFy9F2UyKlI4vFNRuXJmyU
   w==;
X-CSE-ConnectionGUID: ixqPPgOZSo2MNFC0AQmJug==
X-CSE-MsgGUID: t79mtCRRRTimTxmdeNuHXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34968538"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="34968538"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 03:02:39 -0700
X-CSE-ConnectionGUID: e2EFwQJzRWeseAc8a1UzyQ==
X-CSE-MsgGUID: 1q+92oEXRXmwbMve8KUtKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47021447"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Jul 2024 03:02:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQ2FX-000Tb2-2E;
	Sat, 06 Jul 2024 10:02:35 +0000
Date: Sat, 06 Jul 2024 18:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.11] BUILD SUCCESS
 b824766504e49f3fdcbb8c722e70996a78c3636e
Message-ID: <202407061821.8cdPYPLH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.11
branch HEAD: b824766504e49f3fdcbb8c722e70996a78c3636e  cgroup/rstat: add force idle show helper

elapsed time: 912m

configs tested: 155
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                         socfpga_defconfig   gcc-13.2.0
arm                          sp7021_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240706   clang-18
i386         buildonly-randconfig-002-20240706   clang-18
i386         buildonly-randconfig-002-20240706   gcc-13
i386         buildonly-randconfig-003-20240706   clang-18
i386         buildonly-randconfig-004-20240706   clang-18
i386         buildonly-randconfig-004-20240706   gcc-13
i386         buildonly-randconfig-005-20240706   clang-18
i386         buildonly-randconfig-005-20240706   gcc-10
i386         buildonly-randconfig-006-20240706   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240706   clang-18
i386                  randconfig-001-20240706   gcc-13
i386                  randconfig-002-20240706   clang-18
i386                  randconfig-003-20240706   clang-18
i386                  randconfig-003-20240706   gcc-13
i386                  randconfig-004-20240706   clang-18
i386                  randconfig-005-20240706   clang-18
i386                  randconfig-006-20240706   clang-18
i386                  randconfig-006-20240706   gcc-12
i386                  randconfig-011-20240706   clang-18
i386                  randconfig-011-20240706   gcc-11
i386                  randconfig-012-20240706   clang-18
i386                  randconfig-013-20240706   clang-18
i386                  randconfig-014-20240706   clang-18
i386                  randconfig-015-20240706   clang-18
i386                  randconfig-015-20240706   gcc-7
i386                  randconfig-016-20240706   clang-18
i386                  randconfig-016-20240706   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240706   clang-18
x86_64       buildonly-randconfig-002-20240706   clang-18
x86_64       buildonly-randconfig-003-20240706   clang-18
x86_64       buildonly-randconfig-004-20240706   clang-18
x86_64       buildonly-randconfig-005-20240706   clang-18
x86_64       buildonly-randconfig-006-20240706   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240706   clang-18
x86_64                randconfig-002-20240706   clang-18
x86_64                randconfig-003-20240706   clang-18
x86_64                randconfig-004-20240706   clang-18
x86_64                randconfig-005-20240706   clang-18
x86_64                randconfig-006-20240706   clang-18
x86_64                randconfig-011-20240706   clang-18
x86_64                randconfig-012-20240706   clang-18
x86_64                randconfig-013-20240706   clang-18
x86_64                randconfig-014-20240706   clang-18
x86_64                randconfig-015-20240706   clang-18
x86_64                randconfig-016-20240706   clang-18
x86_64                randconfig-071-20240706   clang-18
x86_64                randconfig-072-20240706   clang-18
x86_64                randconfig-073-20240706   clang-18
x86_64                randconfig-074-20240706   clang-18
x86_64                randconfig-075-20240706   clang-18
x86_64                randconfig-076-20240706   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  nommu_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

