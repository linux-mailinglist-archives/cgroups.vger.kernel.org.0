Return-Path: <cgroups+bounces-2636-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F948ABA2B
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 09:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BA1F2133C
	for <lists+cgroups@lfdr.de>; Sat, 20 Apr 2024 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BDEF9DF;
	Sat, 20 Apr 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8OXi8oG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA27F
	for <cgroups@vger.kernel.org>; Sat, 20 Apr 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599810; cv=none; b=sa/rURseFBbzSGs2qHQVYGy2St2bT5pZGTOx2K0JIAAJn5j4hk7UFE7CB0R83miyJ1Ld4619BhDXJsA3x0nMEf6j0K+nG0q96GkRUIsGdJXJsxkRwUoZZJ6CnQmXgC1GpxuxmibqHAaTJJIVVspfldUR19HJoNm5DdWiEvE3fT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599810; c=relaxed/simple;
	bh=2OlaGbVmrdKc2Jb2eYwMAJoP/SmBsYIMjJCd8wYkj2c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BLlXJ3dB8EWETB3QAle1L5tAuSXhlHOVJ0uFx4QCwkTxC9ld6KK1iSdSpGGuyL/+sWDMclPR8wX/UIVxfk7CKYy3Waqedp+iPmIXLtdRkmMSgthX2AQS4/k4bYAeUOVEsRRG5VuuLC9sEy5XtZh2FpgMJD2HMejOiOLWsO+p7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8OXi8oG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713599809; x=1745135809;
  h=date:from:to:cc:subject:message-id;
  bh=2OlaGbVmrdKc2Jb2eYwMAJoP/SmBsYIMjJCd8wYkj2c=;
  b=d8OXi8oG+q9k5Ai1LUGng6cF26hDBoG5zBr+/phYrZOMNtTbDXZ+Ef7o
   YAHxWLmqHsCrGtsyg8inQmezMer9BTnAojoO48Xk2WCogJmSIf4B++IzS
   DqpDr7uhl3UcBquyd67mHyJ9qQQFuXA0upnDthyyJzwtSjUs/RcxFgcGn
   ezlb00F4mTb8Yx4IfqeRixPnARS6gn2kl7Ni53IEQvs8dic2pHPrDR0RU
   3UKwjkUMT2XVrzZFjbh+sKKHzivhzLQWVFNCpJ70rd/JpDVXks9jpMoxo
   hJiIepqLWP0xS+MHnmpuVLLnicTl075B7XwVQBXfAyt98KbS5RS5ueNbM
   A==;
X-CSE-ConnectionGUID: hXr5J87RRi6d01VcODwhSA==
X-CSE-MsgGUID: Z88a1J8xTy6P3CgnfTrNZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9077141"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9077141"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 00:56:48 -0700
X-CSE-ConnectionGUID: nzIssLAySy+QIqvj/oyUPw==
X-CSE-MsgGUID: s9CHCCByTXqo/eRY3JjTsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23616261"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 20 Apr 2024 00:56:47 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ry5aW-000Aqm-20;
	Sat, 20 Apr 2024 07:56:44 +0000
Date: Sat, 20 Apr 2024 15:56:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 19fc8a896565ecebb3951664fd0eeab0a80314a1
Message-ID: <202404201522.Muo7uJlQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 19fc8a896565ecebb3951664fd0eeab0a80314a1  cgroup: Avoid unnecessary looping in cgroup_no_v1()

elapsed time: 971m

configs tested: 139
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
arc                   randconfig-001-20240420   gcc  
arc                   randconfig-002-20240420   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240420   gcc  
arm                   randconfig-002-20240420   gcc  
arm                   randconfig-003-20240420   clang
arm                   randconfig-004-20240420   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240420   clang
arm64                 randconfig-002-20240420   clang
arm64                 randconfig-003-20240420   gcc  
arm64                 randconfig-004-20240420   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240420   gcc  
csky                  randconfig-002-20240420   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240420   clang
hexagon               randconfig-002-20240420   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240420   gcc  
i386         buildonly-randconfig-002-20240420   clang
i386         buildonly-randconfig-003-20240420   gcc  
i386         buildonly-randconfig-004-20240420   gcc  
i386         buildonly-randconfig-005-20240420   gcc  
i386         buildonly-randconfig-006-20240420   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240420   clang
i386                  randconfig-002-20240420   gcc  
i386                  randconfig-003-20240420   gcc  
i386                  randconfig-004-20240420   gcc  
i386                  randconfig-005-20240420   clang
i386                  randconfig-006-20240420   gcc  
i386                  randconfig-011-20240420   clang
i386                  randconfig-012-20240420   clang
i386                  randconfig-013-20240420   clang
i386                  randconfig-014-20240420   clang
i386                  randconfig-015-20240420   clang
i386                  randconfig-016-20240420   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240420   gcc  
loongarch             randconfig-002-20240420   gcc  
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
nios2                 randconfig-001-20240420   gcc  
nios2                 randconfig-002-20240420   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240420   gcc  
parisc                randconfig-002-20240420   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240420   gcc  
powerpc               randconfig-002-20240420   clang
powerpc               randconfig-003-20240420   clang
powerpc64             randconfig-001-20240420   clang
powerpc64             randconfig-002-20240420   gcc  
powerpc64             randconfig-003-20240420   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240420   clang
riscv                 randconfig-002-20240420   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240420   clang
s390                  randconfig-002-20240420   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240420   gcc  
sh                    randconfig-002-20240420   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240420   gcc  
sparc64               randconfig-002-20240420   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240420   clang
um                    randconfig-002-20240420   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240420   gcc  
xtensa                randconfig-002-20240420   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

