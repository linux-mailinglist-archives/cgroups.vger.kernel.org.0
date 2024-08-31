Return-Path: <cgroups+bounces-4661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31899673D8
	for <lists+cgroups@lfdr.de>; Sun,  1 Sep 2024 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99343282BEE
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D8183092;
	Sat, 31 Aug 2024 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HF+v29gS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317310A3D
	for <cgroups@vger.kernel.org>; Sat, 31 Aug 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725144505; cv=none; b=ltD72GzHBh+UQ84vQXroECb+Qfb+AuFHvXMu3ibWnIUNa6dMq4dP9mw8YtGa64hJY2OQynzhJ+OfoP9GB50Greb/TdnU8QUTsDovYzqLAOWrXSQm/TfHsgwijMzHMXbIMeKP6AsGpXd/BBViKmPXJXEsLYiWIVbUr5rbygTltGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725144505; c=relaxed/simple;
	bh=DzMEYXXdIOX/KHsYs50Kst417SPtHwwqIljZGrnosZM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BY3RQJJ35/2rPgK6bh4fgnbQ52nYPTIbp73Jd7vGVzl/0AHJ8jGJlivY7l8HVdOX+cm4O5m96H3Tqde15vNFnge9dCTUmiIa3Fx/65GHAlnCe04iSO1NDn4E4LbQqDksJmaDi/v6ZyL2d5JRc5t29MrSgswDus7ezq5pgGMpyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HF+v29gS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725144504; x=1756680504;
  h=date:from:to:cc:subject:message-id;
  bh=DzMEYXXdIOX/KHsYs50Kst417SPtHwwqIljZGrnosZM=;
  b=HF+v29gS0IdAliImo9Xpl/qtlMKlDaiXNkw1uvn06p2S3py3UB1E8oH4
   BccbpxvRcMQ4f1k+wQRq+A6Bc+hGX6jijnPjyznaIoHNmaumNj3LL1kHE
   zlGCuvoHqyniKodcJqNM1pMDjUnumLjuwEjW/7tHL2PJioxQ/71KPSuWK
   kM7I2RCP9jwVkWOl+84850VYInhik0XUkIL94aqfgp3vcub6AxF9L4O2x
   /SG3mDyJxucHwd2h/76hixPo2pepV8WYx7ipui8306weAeYa/jfGVmeBA
   miwn5XxoSYXAVQDWjstFdhOPRmlKUiJe6MvG2jT/QQdWR4TIFD/vc5dkY
   w==;
X-CSE-ConnectionGUID: 7Q6RI2fGRJi04qBlwCKAKQ==
X-CSE-MsgGUID: lOnVsaRASUCaMfeKGDnWCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27634953"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="27634953"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 15:48:23 -0700
X-CSE-ConnectionGUID: X2rS4BebRmKHpAxFfaMl/Q==
X-CSE-MsgGUID: YDuSM7Q6S+en7UiV9UwUHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="95030563"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Aug 2024 15:48:22 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skWtI-0003B6-0e;
	Sat, 31 Aug 2024 22:48:20 +0000
Date: Sun, 01 Sep 2024 06:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-6.11-rc4-fixes] BUILD SUCCESS
 2455754eb3b659604807aa8416218af7d0fbacd9
Message-ID: <202409010636.sfIGv9X3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-6.11-rc4-fixes
branch HEAD: 2455754eb3b659604807aa8416218af7d0fbacd9  Merge branch 'master' into test-merge-for-6.11-rc4-fixes

elapsed time: 1578m

configs tested: 102
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
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                             mxs_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                          pxa3xx_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240901   clang-18
i386         buildonly-randconfig-002-20240901   clang-18
i386         buildonly-randconfig-003-20240901   clang-18
i386         buildonly-randconfig-004-20240901   clang-18
i386         buildonly-randconfig-005-20240901   clang-18
i386         buildonly-randconfig-006-20240901   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240901   clang-18
i386                  randconfig-002-20240901   clang-18
i386                  randconfig-003-20240901   clang-18
i386                  randconfig-004-20240901   clang-18
i386                  randconfig-005-20240901   clang-18
i386                  randconfig-006-20240901   clang-18
i386                  randconfig-011-20240901   clang-18
i386                  randconfig-012-20240901   clang-18
i386                  randconfig-013-20240901   clang-18
i386                  randconfig-014-20240901   clang-18
i386                  randconfig-015-20240901   clang-18
i386                  randconfig-016-20240901   clang-18
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
mips                      bmips_stb_defconfig   clang-20
mips                          eyeq5_defconfig   clang-20
mips                           gcw0_defconfig   clang-20
mips                           ip28_defconfig   clang-20
nios2                         10m50_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                       eiger_defconfig   clang-20
powerpc                     mpc512x_defconfig   clang-20
powerpc                     sequoia_defconfig   clang-20
powerpc                     skiroot_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
riscv                             allnoconfig   clang-20
riscv                               defconfig   gcc-12
s390                             alldefconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          kfr2r09_defconfig   clang-20
sh                             shx3_defconfig   clang-20
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
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                          iss_defconfig   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

