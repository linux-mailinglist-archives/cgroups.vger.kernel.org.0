Return-Path: <cgroups+bounces-9149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87AB2567E
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAC93A4E0F
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80731302753;
	Wed, 13 Aug 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XM6AYxr2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76F30274B
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123470; cv=none; b=Nbzt9q1FV+85B3YrXYSeV7JwBicUo7mbtAr8wiaQgHwQLlL2MoivJbtzTWmn3hAkgtkZUuD5OQRqUt7YwSZS29y6UtTtN7Fc7jwr7Qmwy7xECWCywS/iElurJap7zpRdDRBsSSl6D3LQDGP76QHHfb7+QHYYq3kfCFZF4MHMjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123470; c=relaxed/simple;
	bh=XmRYJJhBsZeu8ptB6fiIU4jhBpHMgD4Teg9cW1TnW+0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nOAFOn3exaloBrENZaQYprr8deLVEwgChtmnGwcLOiJQroftEyl8r+UKk+MVc6UXoe6xrNXDLe56Cb7x+CnRfcHTw9p6fA/ElvQR+P2bpBzCSH8GcEqGQxcC5O/hW7yLV0+NAUN9ehHuRP6kn1kBFqIcllJtWnFNpOX/Drj1y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XM6AYxr2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755123469; x=1786659469;
  h=date:from:to:cc:subject:message-id;
  bh=XmRYJJhBsZeu8ptB6fiIU4jhBpHMgD4Teg9cW1TnW+0=;
  b=XM6AYxr2X3ZzrtSaBEuGOoQJbN4L+Ys1I0LY+24fWF+zPH01lA3O4Hc0
   FNV0EdeLFRIk8iXWNfdaGxexyQIfzR4lCi6a3bOyqdLEitOyyrlXq3P35
   PPA7hAPksZh47E45Y+5wPcgh+NvD4hM1Yrjz/Ob3mYdN7gzq+Lr1NUpGD
   k2Al4z2qPf6lFhcdtkoSGPM+I/QxxwYwCiMlO6lYo2f1jC145gDBWP82E
   9K1jGXB951DpFYwyZCcM27iSbpKg5C0Bb3s/BkiL3SK8TRcJXqgI9aPd4
   o2qSkoZnXWI1mVBHjb7SmYWCkq3AbY7ZLYqJFYDkmFYpBbeOkoF39+WB3
   A==;
X-CSE-ConnectionGUID: lVytOWV/TIqHHkwuUdPusg==
X-CSE-MsgGUID: wKjYnC0lRL69jkanGpnEyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57549569"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57549569"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 15:17:48 -0700
X-CSE-ConnectionGUID: CzKq2ofcR8uZHYEaojKC+A==
X-CSE-MsgGUID: NErhuhXVRNGTnHGZT+Jqdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170729151"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 13 Aug 2025 15:17:47 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umJmz-000AMp-0X;
	Wed, 13 Aug 2025 22:17:45 +0000
Date: Thu, 14 Aug 2025 06:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.17-fixes] BUILD SUCCESS
 6563623e604e3e235b2cee71190a4972be8f986b
Message-ID: <202508140611.doX21W72-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.17-fixes
branch HEAD: 6563623e604e3e235b2cee71190a4972be8f986b  docs: cgroup: fixed spelling mistakes in documentation

elapsed time: 1456m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250813    gcc-11.5.0
arc                   randconfig-002-20250813    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                     davinci_all_defconfig    clang-19
arm                   randconfig-001-20250813    clang-22
arm                   randconfig-002-20250813    gcc-8.5.0
arm                   randconfig-003-20250813    clang-22
arm                   randconfig-004-20250813    gcc-8.5.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250813    clang-22
arm64                 randconfig-002-20250813    gcc-12.5.0
arm64                 randconfig-003-20250813    clang-22
arm64                 randconfig-004-20250813    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250813    gcc-14.3.0
csky                  randconfig-002-20250813    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250813    clang-22
hexagon               randconfig-002-20250813    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250813    gcc-11
i386        buildonly-randconfig-002-20250813    clang-20
i386        buildonly-randconfig-003-20250813    gcc-11
i386        buildonly-randconfig-004-20250813    clang-20
i386        buildonly-randconfig-005-20250813    gcc-12
i386        buildonly-randconfig-006-20250813    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250813    clang-19
loongarch             randconfig-002-20250813    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250813    gcc-11.5.0
nios2                 randconfig-002-20250813    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250813    gcc-14.3.0
parisc                randconfig-002-20250813    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250813    clang-18
powerpc               randconfig-002-20250813    clang-22
powerpc               randconfig-003-20250813    clang-20
powerpc64             randconfig-001-20250813    clang-22
powerpc64             randconfig-002-20250813    gcc-8.5.0
powerpc64             randconfig-003-20250813    clang-17
riscv                             allnoconfig    gcc-15.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250813    clang-22
riscv                 randconfig-002-20250813    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250813    clang-22
s390                  randconfig-002-20250813    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20250813    gcc-9.5.0
sh                    randconfig-002-20250813    gcc-9.5.0
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250813    gcc-8.5.0
sparc                 randconfig-002-20250813    gcc-15.1.0
sparc64               randconfig-001-20250813    gcc-8.5.0
sparc64               randconfig-002-20250813    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250813    gcc-12
um                    randconfig-002-20250813    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250813    gcc-12
x86_64      buildonly-randconfig-002-20250813    clang-20
x86_64      buildonly-randconfig-003-20250813    gcc-12
x86_64      buildonly-randconfig-004-20250813    clang-20
x86_64      buildonly-randconfig-005-20250813    clang-20
x86_64      buildonly-randconfig-006-20250813    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250813    gcc-10.5.0
xtensa                randconfig-002-20250813    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

