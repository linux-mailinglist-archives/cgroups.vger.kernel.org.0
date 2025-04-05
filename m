Return-Path: <cgroups+bounces-7372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C8FA7CBDE
	for <lists+cgroups@lfdr.de>; Sat,  5 Apr 2025 23:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95B03AB1EF
	for <lists+cgroups@lfdr.de>; Sat,  5 Apr 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB351C861A;
	Sat,  5 Apr 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwZCx9NV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA61A9B4D
	for <cgroups@vger.kernel.org>; Sat,  5 Apr 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743888605; cv=none; b=Vp/zq/aGKDq8uvVLYI6Sv/4DZWriGWVMrNPPD+snJknM1YuPsKqQkjK+ltN5U2qjAPJgjKvWy+7D+cisXhfY+34sR4M5E7IRJIjlgX9Nd+QHUNIoDei3v6V3E3/oUZowU000aWkSgtETEU/4snh4WFP0CGy2GMsgc6vtg+yCJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743888605; c=relaxed/simple;
	bh=L+4rMnQbvTfSgD+zh+QBo43P/IQBtscCEIU5suv0uok=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QVsOt/ngPfBw0ASJn14muT9UFmCTt6A0COjrQu8lgRx0Q4HO5UPxrs7zkxAivOdBIu9Dm5xHZM6W3vyHE8ERp17LHZSxQPgEv2kW6lxj2H6v8RpbXH3jD/QhkHHo9Z/uVgbxs33gicIctkRJLztRiy4DnwdZCjtyq4eoWwU8uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwZCx9NV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743888603; x=1775424603;
  h=date:from:to:cc:subject:message-id;
  bh=L+4rMnQbvTfSgD+zh+QBo43P/IQBtscCEIU5suv0uok=;
  b=VwZCx9NVyS8eYwdRvNPL6BLnNEMh5gkjMN+nUtcQN60MfHuwWC1N8phX
   a6gS+bp7M7F9OFh6Pa5pPOtmsYLbXYkDg3Aip5WGzJTSw/ZkDakOMBkck
   cqwhBz5RXSynN+FiLQBw21fE4eYvV7cJB51/6jzB/KFzCfzMBBucTvN6Z
   D8FXxQ8dod6eZQgF7sChm1HzcBePa4o3mreQr7DA4mX/w3kEeilFNqlj8
   AOR1uNjhgnlw6ZXp8hs1tVSJ9/NQx1an67mjPATqudZn8SIk0NnABxC34
   Nkfk68Y9DlXT9jL05sha8OUPlornZ9L2e5KhzxsW7a1sIyg6AvEjkdu/N
   A==;
X-CSE-ConnectionGUID: 9uG/xoNWRvyJTPFB+Ll+3g==
X-CSE-MsgGUID: ZDIfaEZJR++zb0MqmWrD5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45211261"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="45211261"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 14:30:02 -0700
X-CSE-ConnectionGUID: jPkbJqONR1aiYdXOYANdvw==
X-CSE-MsgGUID: DfuGwSd2TdmU/UBpI2U6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="127440163"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Apr 2025 14:30:00 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1B5S-0002Id-0t;
	Sat, 05 Apr 2025 21:29:58 +0000
Date: Sun, 06 Apr 2025 05:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 09fec7c341ff8d57732bde45e46e1b7a951bba45
Message-ID: <202504060534.oJNNSdx3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 09fec7c341ff8d57732bde45e46e1b7a951bba45  Merge branch 'for-6.16' into for-next

elapsed time: 1448m

configs tested: 122
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250405    gcc-14.2.0
arc                   randconfig-002-20250405    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    clang-16
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250405    clang-18
arm                   randconfig-002-20250405    gcc-7.5.0
arm                   randconfig-003-20250405    gcc-8.5.0
arm                   randconfig-004-20250405    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250405    clang-19
arm64                 randconfig-002-20250405    gcc-8.5.0
arm64                 randconfig-003-20250405    gcc-8.5.0
arm64                 randconfig-004-20250405    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250405    gcc-14.2.0
csky                  randconfig-002-20250405    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250405    clang-21
hexagon               randconfig-002-20250405    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250405    gcc-12
i386        buildonly-randconfig-002-20250405    clang-20
i386        buildonly-randconfig-003-20250405    clang-20
i386        buildonly-randconfig-004-20250405    clang-20
i386        buildonly-randconfig-005-20250405    clang-20
i386        buildonly-randconfig-006-20250405    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250405    gcc-14.2.0
loongarch             randconfig-002-20250405    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250405    gcc-12.4.0
nios2                 randconfig-002-20250405    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250405    gcc-11.5.0
parisc                randconfig-002-20250405    gcc-9.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20250405    gcc-8.5.0
powerpc               randconfig-002-20250405    gcc-8.5.0
powerpc               randconfig-003-20250405    gcc-8.5.0
powerpc64             randconfig-001-20250405    clang-21
powerpc64             randconfig-002-20250405    clang-21
powerpc64             randconfig-003-20250405    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250405    clang-21
riscv                 randconfig-002-20250405    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250405    clang-15
s390                  randconfig-002-20250405    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250405    gcc-14.2.0
sh                    randconfig-002-20250405    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250405    gcc-11.5.0
sparc                 randconfig-002-20250405    gcc-10.3.0
sparc64               randconfig-001-20250405    gcc-9.3.0
sparc64               randconfig-002-20250405    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250405    clang-17
um                    randconfig-002-20250405    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250405    gcc-12
x86_64      buildonly-randconfig-002-20250405    clang-20
x86_64      buildonly-randconfig-003-20250405    clang-20
x86_64      buildonly-randconfig-004-20250405    clang-20
x86_64      buildonly-randconfig-005-20250405    gcc-12
x86_64      buildonly-randconfig-006-20250405    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250405    gcc-11.5.0
xtensa                randconfig-002-20250405    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

