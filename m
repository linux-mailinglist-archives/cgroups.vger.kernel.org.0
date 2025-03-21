Return-Path: <cgroups+bounces-7214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6533A6C1D7
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F3846648A
	for <lists+cgroups@lfdr.de>; Fri, 21 Mar 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83822DF84;
	Fri, 21 Mar 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imxjKsLS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909C78F52
	for <cgroups@vger.kernel.org>; Fri, 21 Mar 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579295; cv=none; b=skbpusnHJbhpNZdPf9gaDAisxUsEGNrJi2jWsvQnmlw5fgCOmCJ6WD/uHPT93aWIvHPz/mjdqPghoYdLlhWm5yePnbD8a5U0Q0M30pMFuDz0JgQD2pZxhD9y+0IfyqTtrXPUMwPQEVTjJvPmJr0QcsNAbxs5/gZHsT22JYsp35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579295; c=relaxed/simple;
	bh=dK2J5QkBYKdmPRxQ51FPNFOLTZN2DKtZGSVS7Q3oL88=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZDtBInMNbnNkKofEKyTZy9+hMjYPSen61jorPhKtYvWXexy7wzCBRyw2HTo1qsY5EsmgF7OW+9cqW+YJUNzyAbdeb6igQ9GgL53D0jPhPIt94E7PS6F3BxChpC2eal1qSR2csCU15zrHahVM/l5HolkurfqVywmtRAnZoF3PtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imxjKsLS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742579294; x=1774115294;
  h=date:from:to:cc:subject:message-id;
  bh=dK2J5QkBYKdmPRxQ51FPNFOLTZN2DKtZGSVS7Q3oL88=;
  b=imxjKsLSAmuj5KIQpxZSXC3EhYO7gaxVcIf1cHqgItMJT7eYt6T0jaDy
   Hz5XwM49RjRMLKKe8X+SCbksBkcugacV4jsIYYyGQwf8u5etGxs0mUPhe
   UBStlRY1qX+yy3EZCq/BrJstOYdvrkeoHn1Z4Elu4fwelXaKVPTNl1L0v
   Df3oI355frAV11dfy8mN8zNzDMA+AEVGfLI+SOSAnk60KY53cUfhXCOzQ
   mR2adfmYAXDOSpK7cy2VZKqlyJkQVQKEqu16DmQtIBqQtj3vHtzrN9sat
   AVqiD9PvjrGPtONsgCNEzpiAxwpU9RvUMr5UhN/uPi8vii+iHeyezWUrm
   g==;
X-CSE-ConnectionGUID: kYcOwpDaR86gn75vG1dBpA==
X-CSE-MsgGUID: 5dOw1h7KQxWbObvp5sBjww==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="31446098"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="31446098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:48:13 -0700
X-CSE-ConnectionGUID: N2GEJavGQ0m0FeeAPEzulw==
X-CSE-MsgGUID: F2QoST99T6S4Kraq7EhlHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123921167"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:48:12 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvgTa-0001Yl-0n;
	Fri, 21 Mar 2025 17:48:10 +0000
Date: Sat, 22 Mar 2025 01:47:55 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 1df3a1b56415d3965542bb537d030915f34add96
Message-ID: <202503220147.fV1qoqUB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 1df3a1b56415d3965542bb537d030915f34add96  Merge branch 'for-6.15' into for-next

elapsed time: 1443m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250321    gcc-13.3.0
arc                   randconfig-002-20250321    gcc-11.5.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250321    clang-19
arm                   randconfig-002-20250321    gcc-9.3.0
arm                   randconfig-003-20250321    gcc-5.5.0
arm                   randconfig-004-20250321    clang-21
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250321    gcc-5.5.0
arm64                 randconfig-002-20250321    gcc-5.5.0
arm64                 randconfig-003-20250321    clang-20
arm64                 randconfig-004-20250321    clang-21
csky                  randconfig-001-20250321    gcc-13.3.0
csky                  randconfig-002-20250321    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250321    clang-21
hexagon               randconfig-002-20250321    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250321    clang-20
i386        buildonly-randconfig-002-20250321    clang-20
i386        buildonly-randconfig-003-20250321    clang-20
i386        buildonly-randconfig-004-20250321    clang-20
i386        buildonly-randconfig-005-20250321    clang-20
i386        buildonly-randconfig-006-20250321    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250321    gcc-14.2.0
loongarch             randconfig-002-20250321    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250321    gcc-13.3.0
nios2                 randconfig-002-20250321    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250321    gcc-8.5.0
parisc                randconfig-002-20250321    gcc-6.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250321    clang-21
powerpc               randconfig-002-20250321    gcc-7.5.0
powerpc               randconfig-003-20250321    gcc-7.5.0
powerpc64             randconfig-001-20250321    gcc-5.5.0
powerpc64             randconfig-002-20250321    clang-16
powerpc64             randconfig-003-20250321    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250321    clang-21
riscv                 randconfig-002-20250321    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250321    clang-16
s390                  randconfig-002-20250321    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250321    gcc-7.5.0
sh                    randconfig-002-20250321    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250321    gcc-12.4.0
sparc                 randconfig-002-20250321    gcc-6.5.0
sparc64               randconfig-001-20250321    gcc-10.5.0
sparc64               randconfig-002-20250321    gcc-6.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250321    gcc-12
um                    randconfig-002-20250321    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250321    clang-20
x86_64      buildonly-randconfig-002-20250321    clang-20
x86_64      buildonly-randconfig-003-20250321    gcc-12
x86_64      buildonly-randconfig-004-20250321    clang-20
x86_64      buildonly-randconfig-005-20250321    clang-20
x86_64      buildonly-randconfig-006-20250321    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250321    gcc-6.5.0
xtensa                randconfig-002-20250321    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

