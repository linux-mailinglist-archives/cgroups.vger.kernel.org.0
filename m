Return-Path: <cgroups+bounces-2594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835398AA404
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 22:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E171C20B5F
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F44503A;
	Thu, 18 Apr 2024 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5vD4gRJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C22F30
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472039; cv=none; b=Ghgu46WhTK4JKM0tLYydWmUsirgN5J8CTpKskmWBU63/QlJAPgUfrtV6+VHSQpm6gb9iuIF2KJUejS3ya1+sRGXhffL7maImRiNrfTewMSy4ysuUF7aSJS15SdSvAeYns6xvVTVztKGfQlDy3pMLpiTR3KN3Ww8f07pu9veOiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472039; c=relaxed/simple;
	bh=/ccYGQu6roGFoTcwCQd+zaoxRIH5SbT0wxRViq0ZNa0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bXmsHZjuIoAMVcroJzGQNeIbma3wg2xpp6q5yvplvFBJ8EJutxL8j8Lf3vjriHjN1jGHbj8xCbyH7Lqv9Ti1mxo1eYP3ge3cEXVjVwWo/qkGT7jytiG6i0LSz6Rh4OCQ2My7qp161z95kmtTf4sIeYg/nqMj2UUPZdTAuwVtcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5vD4gRJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713472037; x=1745008037;
  h=date:from:to:cc:subject:message-id;
  bh=/ccYGQu6roGFoTcwCQd+zaoxRIH5SbT0wxRViq0ZNa0=;
  b=Z5vD4gRJ2f7cIUQFtRUolk/6N0piVGo4TESoyNdoY0sAqMOh12MqXT7G
   rYMBCwM7xGnQL4Wo/m7S24Xg+MwVTIavN01LBUay4brRHAGkWD9exv3r8
   ArG6H1rE7HQOpQpMfV/mDi6f74VI3XMeugv2r1vuLe2yH+n8VDWCyCpqT
   xgiMawDVPUcsVMjwBcD/hEMnSeuIvUMDSmKKrwrycit2PHj1jgMV7T5VR
   2JV2ND+JMpL415HH5qFhYmhqD4L/zq3/kXQq7eqQn8kQqh11hDoBhlBHE
   uA7OyI++THKrk1JicVF8tYLzQTRR+mNCpnHC9yyQD24aq85Tuby/FD7/Q
   Q==;
X-CSE-ConnectionGUID: MzNvpA/4TnGn6R/Tyu3upw==
X-CSE-MsgGUID: Zaij0sr1RGyHEQJQAp1/+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9271721"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9271721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 13:27:16 -0700
X-CSE-ConnectionGUID: UuVJjJoZTUi2JfSuNAdCwQ==
X-CSE-MsgGUID: ibLGrtNSS6muSboauTSmYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27764463"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 18 Apr 2024 13:27:16 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxYLg-0009Bs-1m;
	Thu, 18 Apr 2024 20:27:12 +0000
Date: Fri, 19 Apr 2024 04:27:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a6b8daba00e6703b728933d2ec24e6d1ee5d5ec0
Message-ID: <202404190401.XjQRHMwR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a6b8daba00e6703b728933d2ec24e6d1ee5d5ec0  cgroup_freezer: update comment for freezer_css_online()

elapsed time: 1090m

configs tested: 163
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
arc                   randconfig-001-20240418   gcc  
arc                   randconfig-002-20240418   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240418   gcc  
arm                   randconfig-002-20240418   gcc  
arm                   randconfig-003-20240418   gcc  
arm                   randconfig-004-20240418   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240418   clang
arm64                 randconfig-002-20240418   gcc  
arm64                 randconfig-003-20240418   gcc  
arm64                 randconfig-004-20240418   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240418   gcc  
csky                  randconfig-002-20240418   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240418   clang
hexagon               randconfig-002-20240418   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-003-20240418   clang
i386         buildonly-randconfig-004-20240418   gcc  
i386         buildonly-randconfig-005-20240418   clang
i386         buildonly-randconfig-006-20240418   clang
i386                                defconfig   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-003-20240418   clang
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-011-20240418   clang
i386                  randconfig-012-20240418   clang
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-015-20240418   gcc  
i386                  randconfig-016-20240418   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240418   gcc  
loongarch             randconfig-002-20240418   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240418   gcc  
nios2                 randconfig-002-20240418   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240418   gcc  
parisc                randconfig-002-20240418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240418   gcc  
powerpc               randconfig-002-20240418   clang
powerpc               randconfig-003-20240418   gcc  
powerpc64             randconfig-001-20240418   gcc  
powerpc64             randconfig-002-20240418   gcc  
powerpc64             randconfig-003-20240418   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240418   gcc  
riscv                 randconfig-002-20240418   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240418   clang
s390                  randconfig-002-20240418   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240418   gcc  
sh                    randconfig-002-20240418   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240418   gcc  
sparc64               randconfig-002-20240418   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240418   gcc  
um                    randconfig-002-20240418   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240418   clang
x86_64       buildonly-randconfig-002-20240418   clang
x86_64       buildonly-randconfig-003-20240418   clang
x86_64       buildonly-randconfig-004-20240418   clang
x86_64       buildonly-randconfig-005-20240418   gcc  
x86_64       buildonly-randconfig-006-20240418   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240418   gcc  
x86_64                randconfig-002-20240418   clang
x86_64                randconfig-003-20240418   gcc  
x86_64                randconfig-004-20240418   clang
x86_64                randconfig-005-20240418   gcc  
x86_64                randconfig-006-20240418   gcc  
x86_64                randconfig-011-20240418   clang
x86_64                randconfig-012-20240418   gcc  
x86_64                randconfig-013-20240418   clang
x86_64                randconfig-014-20240418   gcc  
x86_64                randconfig-015-20240418   gcc  
x86_64                randconfig-016-20240418   gcc  
x86_64                randconfig-071-20240418   gcc  
x86_64                randconfig-072-20240418   clang
x86_64                randconfig-073-20240418   clang
x86_64                randconfig-074-20240418   gcc  
x86_64                randconfig-075-20240418   gcc  
x86_64                randconfig-076-20240418   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240418   gcc  
xtensa                randconfig-002-20240418   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

