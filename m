Return-Path: <cgroups+bounces-3525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A20192676A
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D70283DA1
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494717F511;
	Wed,  3 Jul 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff6mlhRQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA221836DA
	for <cgroups@vger.kernel.org>; Wed,  3 Jul 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028884; cv=none; b=egLB1IZXJDRuUqatR1aDW6TIJFDD6akf6UliKNGhBaS3WjH9lHHAgnjPvxXqwp1eM0pu4WF2lmTOTAYd6SJRFw3cweE8R6onKzpst0g9+pL7YV47mTZKESuJ6ykAy191k/eSJEiTprmhL4378kS0iqkXmEKJH9Uf69SSEdOwUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028884; c=relaxed/simple;
	bh=X0WeQHMx4gCjuyU3jg1lRng3rogbWXm24iRqvtyH7pA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YP6imQ1SGB5x5pZnAHS0TuGp6FfFuzPC7DsaRN5BsKSO24s0cRznIRCL4mNvJoIyUaBkMGWthsdnq19HUcdk+vHK/WWvG7wBMsqgu+zmsN91nkNjze1B17LqDHz9zmFjWf3D5BWxPWx1+2TFpe/JttgBdNV16uG19KnjHquYk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff6mlhRQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720028882; x=1751564882;
  h=date:from:to:cc:subject:message-id;
  bh=X0WeQHMx4gCjuyU3jg1lRng3rogbWXm24iRqvtyH7pA=;
  b=ff6mlhRQqRgEVor3/43VS6ES3vu9TAENnoB3g/hoomVCw5oZQKunb/ry
   G1ijWAkeTqxIRkfGHquZHLMgnfjGTZMQ1G6yAln+FZrgmdsJo7Gt6Dk5S
   N52smZI944MclV9Iwm4R8BgTw9HHMMpyqAXIbNSr8TaIrk5+0L/1hTKA4
   VDcXRIRD3o2jJZkF+QOxguzoy39KRTBtjsfecbg3z5dZUQSw1BWQz8TlO
   XKbWqNtGcwIgK+ZcU4grWZFLKTlQsE9Mw7cHSnWyhr8S0YmU/OnygsjOS
   5+ceP9fSDHdf1hmpgfvzTNYSwIfUYFQg6qO9s/WxVN5FCRgpIiBRo/6f3
   g==;
X-CSE-ConnectionGUID: 8hunn9iGQR+7n5dT2XHRgg==
X-CSE-MsgGUID: hK4Oiy4+RJONWaXMwTSgdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="16928713"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16928713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 10:48:02 -0700
X-CSE-ConnectionGUID: vnDopTftQBWyfuFLBmS3xg==
X-CSE-MsgGUID: r15MM+JGRZmQtTLXYx2KcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="77074037"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Jul 2024 10:48:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sP45F-000Q30-2i;
	Wed, 03 Jul 2024 17:47:57 +0000
Date: Thu, 04 Jul 2024 01:47:37 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.11] BUILD SUCCESS
 7a4479680d7fd05c7a3efa87b41f421af48fbbdf
Message-ID: <202407040136.SCfZFe3B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.11
branch HEAD: 7a4479680d7fd05c7a3efa87b41f421af48fbbdf  cgroup_misc: add kernel-doc comments for enum misc_res_type

elapsed time: 1445m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              alldefconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-13.2.0
arm                       versatile_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240703   clang-18
i386         buildonly-randconfig-002-20240703   gcc-13
i386         buildonly-randconfig-003-20240703   clang-18
i386         buildonly-randconfig-003-20240703   gcc-13
i386         buildonly-randconfig-004-20240703   clang-18
i386         buildonly-randconfig-004-20240703   gcc-13
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240703   clang-18
i386         buildonly-randconfig-006-20240703   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240703   clang-18
i386                  randconfig-001-20240703   gcc-13
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240703   clang-18
i386                  randconfig-003-20240703   gcc-13
i386                  randconfig-004-20240703   clang-18
i386                  randconfig-004-20240703   gcc-11
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240703   clang-18
i386                  randconfig-006-20240703   gcc-7
i386                  randconfig-011-20240703   clang-18
i386                  randconfig-011-20240703   gcc-13
i386                  randconfig-012-20240703   clang-18
i386                  randconfig-012-20240703   gcc-13
i386                  randconfig-013-20240703   clang-18
i386                  randconfig-013-20240703   gcc-13
i386                  randconfig-014-20240703   clang-18
i386                  randconfig-014-20240703   gcc-13
i386                  randconfig-015-20240703   clang-18
i386                  randconfig-015-20240703   gcc-13
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         amcore_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240703   clang-18
x86_64       buildonly-randconfig-002-20240703   clang-18
x86_64       buildonly-randconfig-003-20240703   clang-18
x86_64       buildonly-randconfig-004-20240703   clang-18
x86_64       buildonly-randconfig-005-20240703   clang-18
x86_64       buildonly-randconfig-006-20240703   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240703   clang-18
x86_64                randconfig-002-20240703   clang-18
x86_64                randconfig-003-20240703   clang-18
x86_64                randconfig-004-20240703   clang-18
x86_64                randconfig-005-20240703   clang-18
x86_64                randconfig-006-20240703   clang-18
x86_64                randconfig-011-20240703   clang-18
x86_64                randconfig-012-20240703   clang-18
x86_64                randconfig-013-20240703   clang-18
x86_64                randconfig-014-20240703   clang-18
x86_64                randconfig-015-20240703   clang-18
x86_64                randconfig-016-20240703   clang-18
x86_64                randconfig-071-20240703   clang-18
x86_64                randconfig-072-20240703   clang-18
x86_64                randconfig-073-20240703   clang-18
x86_64                randconfig-074-20240703   clang-18
x86_64                randconfig-075-20240703   clang-18
x86_64                randconfig-076-20240703   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

