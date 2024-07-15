Return-Path: <cgroups+bounces-3679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22193190B
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED641F21E94
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A5A3B7A8;
	Mon, 15 Jul 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfBIj1pz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A893D982
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063655; cv=none; b=Ph2x2IRmnGrczGIXxbPK5k4VY9MnbmkQZ8bXARXiOM/OH7ey4ZSuh3g4DiB28R4o4eAuIGcMj8zUZA1n19T9XvQLgF/wUNAbigM0+9Pyzl845LgmE8vFhDncU6V3Cu6lclJrsMvifgDaghQu+3UJBFRlSZYuYSu/XXm7eiTu8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063655; c=relaxed/simple;
	bh=Z6/jcRflYorvkzPSJbby2clUiLFSEJGhDuY8G6cDM9U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q3l6YLUKmwREyzqgNjThBUcwyYy3iAN7m9ReDlvH2SXB+M3zKxhqlvC/2s3Cx4eIT0qdQzg5gO13rfgiBdRd6hMiG99tkGncg/fwGaR7HM6VwYTNOvy19IO7W3nAYDxpQRnA2iByct04hWLiWpRvuOyR8inRSRALmBPGbSvRn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfBIj1pz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721063652; x=1752599652;
  h=date:from:to:cc:subject:message-id;
  bh=Z6/jcRflYorvkzPSJbby2clUiLFSEJGhDuY8G6cDM9U=;
  b=ZfBIj1pzKFck1UpYeMoJiUnzQtOfk9NpZObywM0bgf3hOGQCP5rcnWpc
   GZzieeMoJVhgGicIa28cFnaDqReqKDGeXG6uFLPgihgUlw4awsnf9fRMd
   uRrF6aN8HJ54dYH4fHwtsSBqnEZvWNgfXeIqQFTPZXm/ma4/rC8CyO0u2
   9OVc74cWHox0Kgin+qn8L3rRB45fgnr7H9iMvkuZIOokewhQaUfLAbuqa
   jN3KUxY25YxxCmqIgy9vf5W+ih7uRD+AViJlGUAwBkkhwtIG0af5wctMl
   /X7+J8mGhZ476MBVdoxXcATtGzUtSBmYKpyWd0H57VkoR1XAGNRMIK3xZ
   w==;
X-CSE-ConnectionGUID: gO+SlKy5Quuuqtnoip6f9A==
X-CSE-MsgGUID: EQrWuhGNQ+uXx2GQC5SmZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18593860"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18593860"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 10:14:12 -0700
X-CSE-ConnectionGUID: 06wt3khFQmad4AcPMzQVLA==
X-CSE-MsgGUID: rSciHj1DTgixHmXc+aVOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="50328841"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Jul 2024 10:14:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTPH7-000eQR-0C;
	Mon, 15 Jul 2024 17:14:09 +0000
Date: Tue, 16 Jul 2024 01:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 acd2e2b1190753bec7f561be41780057a2fd1472
Message-ID: <202407160116.jiyPll9T-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: acd2e2b1190753bec7f561be41780057a2fd1472  Merge branch 'for-6.11' into for-next

elapsed time: 724m

configs tested: 207
configs skipped: 4

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
arc                   randconfig-001-20240715   gcc-13.2.0
arc                   randconfig-002-20240715   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-19
arm                            mps2_defconfig   clang-19
arm                   randconfig-001-20240715   gcc-13.2.0
arm                   randconfig-002-20240715   gcc-13.2.0
arm                   randconfig-003-20240715   gcc-13.2.0
arm                   randconfig-004-20240715   gcc-13.2.0
arm                           spitz_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240715   gcc-13.2.0
arm64                 randconfig-002-20240715   gcc-13.2.0
arm64                 randconfig-003-20240715   gcc-13.2.0
arm64                 randconfig-004-20240715   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240715   gcc-13.2.0
csky                  randconfig-002-20240715   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240715   clang-18
i386         buildonly-randconfig-002-20240715   clang-18
i386         buildonly-randconfig-003-20240715   gcc-13
i386         buildonly-randconfig-004-20240715   gcc-12
i386         buildonly-randconfig-005-20240715   clang-18
i386         buildonly-randconfig-006-20240715   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240715   gcc-13
i386                  randconfig-002-20240715   clang-18
i386                  randconfig-003-20240715   clang-18
i386                  randconfig-004-20240715   gcc-13
i386                  randconfig-005-20240715   gcc-13
i386                  randconfig-006-20240715   gcc-13
i386                  randconfig-011-20240715   gcc-9
i386                  randconfig-012-20240715   gcc-13
i386                  randconfig-013-20240715   gcc-7
i386                  randconfig-014-20240715   clang-18
i386                  randconfig-015-20240715   clang-18
i386                  randconfig-016-20240715   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240715   gcc-13.2.0
loongarch             randconfig-002-20240715   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   clang-19
mips                           ip27_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   clang-19
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240715   gcc-13.2.0
nios2                 randconfig-002-20240715   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240715   gcc-13.2.0
parisc                randconfig-002-20240715   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                       holly_defconfig   clang-19
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   clang-19
powerpc                       ppc64_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240715   gcc-13.2.0
powerpc               randconfig-002-20240715   gcc-13.2.0
powerpc               randconfig-003-20240715   gcc-13.2.0
powerpc                     redwood_defconfig   clang-19
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                     tqm8555_defconfig   clang-19
powerpc                        warp_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240715   gcc-13.2.0
powerpc64             randconfig-002-20240715   gcc-13.2.0
powerpc64             randconfig-003-20240715   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240715   gcc-13.2.0
riscv                 randconfig-002-20240715   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240715   gcc-13.2.0
s390                  randconfig-002-20240715   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                    randconfig-001-20240715   gcc-13.2.0
sh                    randconfig-002-20240715   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240715   gcc-13.2.0
sparc64               randconfig-002-20240715   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240715   gcc-13.2.0
um                    randconfig-002-20240715   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240715   clang-18
x86_64       buildonly-randconfig-002-20240715   clang-18
x86_64       buildonly-randconfig-003-20240715   clang-18
x86_64       buildonly-randconfig-004-20240715   clang-18
x86_64       buildonly-randconfig-005-20240715   clang-18
x86_64       buildonly-randconfig-006-20240715   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240715   clang-18
x86_64                randconfig-002-20240715   clang-18
x86_64                randconfig-003-20240715   clang-18
x86_64                randconfig-004-20240715   clang-18
x86_64                randconfig-005-20240715   clang-18
x86_64                randconfig-006-20240715   clang-18
x86_64                randconfig-011-20240715   clang-18
x86_64                randconfig-012-20240715   clang-18
x86_64                randconfig-013-20240715   clang-18
x86_64                randconfig-014-20240715   clang-18
x86_64                randconfig-015-20240715   clang-18
x86_64                randconfig-016-20240715   clang-18
x86_64                randconfig-071-20240715   clang-18
x86_64                randconfig-072-20240715   clang-18
x86_64                randconfig-073-20240715   clang-18
x86_64                randconfig-074-20240715   clang-18
x86_64                randconfig-075-20240715   clang-18
x86_64                randconfig-076-20240715   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240715   gcc-13.2.0
xtensa                randconfig-002-20240715   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

