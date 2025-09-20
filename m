Return-Path: <cgroups+bounces-10311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D669CB8CD95
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B61C58013F
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E112248BD;
	Sat, 20 Sep 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWvko/H6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE81F152D
	for <cgroups@vger.kernel.org>; Sat, 20 Sep 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758388228; cv=none; b=BX0voRAfVKtJIJ18KNeKaAvnX0NShGAcCZySZk8SkoP0q8sk/rdv+mGKHO7FpWl5ofpW7HVO/oSQQJv8cN8MkVGUJO1xzLJYvr1DhQFEfen/rMMFAzeLrBbysmTYt0uOcQ2nv5nnDaYgjDT59i5f9XMYmDytBQnP1CusZ627EGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758388228; c=relaxed/simple;
	bh=X+okEEj1lIwIYiHPdRcE9bb90dzE1mBZRUa+MpA+juE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dj96d8GezWhXCXydvkXBIRyYPXy4XikoCDrieZTHst0E+uGlHc8QTQWtq+WSZSLSR7hDtgkYDHzz9lNjlGyVmjd4MVfzNEtquysLe+DjM5Zl+iK2UxxsHJxBpQ7ZKRiWBJBWr+6iLVnIQX8EHvNervP6V+qlw2PoPDQiHz801Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWvko/H6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758388227; x=1789924227;
  h=date:from:to:cc:subject:message-id;
  bh=X+okEEj1lIwIYiHPdRcE9bb90dzE1mBZRUa+MpA+juE=;
  b=bWvko/H6AB+ukWkEEZliytWyaQcZjg9vGULF5kZwxmcWuMxSL5IUGZMU
   0J+TYL0RKLngfT5PruRCJOLOOUPKESUpQoTKyQze5+bEvySWoT9e4FxSL
   30rxnfKUJcEOTzKy+R+cvnquLKe3MRbtThdrS8ryPojy+ki9Q8rdVFpbY
   TrnTtshFXlMpKvuotzfnuBFUEDpX6ucT6iGgGuQ+yuBhe5V9izWVHN1ug
   3CzaCsJvrY4Xxg9GnNiyIdEhCMapgnh8zyd8xL6YOulHDrCnjCVQ11ZOj
   XvuA4tEML1W2DqsPnxyKSX/ZoE6kAWE6XwxZKUhBBW1dazt2HxHJwGgSi
   w==;
X-CSE-ConnectionGUID: r4gpz3VEQDGnLNV+EHWr3g==
X-CSE-MsgGUID: seIs6t4UQi2ZioWR2Wbvxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="64529801"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="64529801"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 10:10:26 -0700
X-CSE-ConnectionGUID: fGk9QwzfQq+pzhyRQS7J7Q==
X-CSE-MsgGUID: xkNN1OOkR5uwtWNlZrFHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="213259480"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Sep 2025 10:10:25 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v016M-0005ZP-2n;
	Sat, 20 Sep 2025 17:10:22 +0000
Date: Sun, 21 Sep 2025 01:10:18 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 ba1682902333b357a3f146fb392a427ffe7518e5
Message-ID: <202509210112.DCvoVwx2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: ba1682902333b357a3f146fb392a427ffe7518e5  Merge branch 'for-6.18' into for-next

elapsed time: 1445m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                   randconfig-001-20250920    gcc-9.5.0
arc                   randconfig-002-20250920    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250920    gcc-12.5.0
arm                   randconfig-002-20250920    clang-22
arm                   randconfig-003-20250920    clang-22
arm                   randconfig-004-20250920    clang-22
arm                        realview_defconfig    clang-16
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250920    clang-20
arm64                 randconfig-002-20250920    clang-22
arm64                 randconfig-003-20250920    clang-18
arm64                 randconfig-004-20250920    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250920    gcc-10.5.0
csky                  randconfig-002-20250920    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20250920    clang-22
hexagon               randconfig-002-20250920    clang-22
i386        buildonly-randconfig-001-20250920    clang-20
i386        buildonly-randconfig-002-20250920    clang-20
i386        buildonly-randconfig-003-20250920    clang-20
i386        buildonly-randconfig-004-20250920    gcc-13
i386        buildonly-randconfig-005-20250920    clang-20
i386        buildonly-randconfig-006-20250920    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250920    clang-22
loongarch             randconfig-002-20250920    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250920    gcc-9.5.0
nios2                 randconfig-002-20250920    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250920    gcc-8.5.0
parisc                randconfig-002-20250920    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250920    clang-17
powerpc               randconfig-002-20250920    clang-22
powerpc               randconfig-003-20250920    clang-22
powerpc64             randconfig-001-20250920    clang-16
powerpc64             randconfig-002-20250920    gcc-10.5.0
powerpc64             randconfig-003-20250920    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250920    clang-22
riscv                 randconfig-002-20250920    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250920    clang-20
s390                  randconfig-002-20250920    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20250920    gcc-14.3.0
sh                    randconfig-002-20250920    gcc-12.5.0
sh                          rsk7264_defconfig    gcc-15.1.0
sh                          rsk7269_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250920    gcc-8.5.0
sparc                 randconfig-002-20250920    gcc-14.3.0
sparc64               randconfig-001-20250920    gcc-8.5.0
sparc64               randconfig-002-20250920    gcc-8.5.0
um                                allnoconfig    clang-22
um                    randconfig-001-20250920    clang-22
um                    randconfig-002-20250920    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250920    clang-20
x86_64      buildonly-randconfig-002-20250920    clang-20
x86_64      buildonly-randconfig-003-20250920    clang-20
x86_64      buildonly-randconfig-004-20250920    clang-20
x86_64      buildonly-randconfig-005-20250920    gcc-14
x86_64      buildonly-randconfig-006-20250920    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250920    gcc-8.5.0
xtensa                randconfig-002-20250920    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

