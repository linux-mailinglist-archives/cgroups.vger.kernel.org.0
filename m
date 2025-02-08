Return-Path: <cgroups+bounces-6468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C91EA2D7F2
	for <lists+cgroups@lfdr.de>; Sat,  8 Feb 2025 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FA5164853
	for <lists+cgroups@lfdr.de>; Sat,  8 Feb 2025 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF81194141;
	Sat,  8 Feb 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNp7X9Dp"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C088241129
	for <cgroups@vger.kernel.org>; Sat,  8 Feb 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037762; cv=none; b=i8RfCI8U2jhC1jsUlg03jQDGOEt0o6CHt8SGJf3G1odj6/Ut4EpQSfhCyx1aqDySHIJqXjw8qd1GyNcIJkh0gMKwtVPJmQ+GMxxKZ9WNnS4D8sFeDDqBalyl0nf00RPpF0ElWQcyxrR7iGS5l04AOygjTpjNvbM73aV+Rq+26c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037762; c=relaxed/simple;
	bh=cHJ9P8HgDm8l3mOijmQruqvKAn7f9VO4Jl8g12PmbwA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cu8BK24/az4tGVM5Ytp17WccB7aPfmdDA2jcunvLZHXfjiGWUN7qETa+wrQYGv2bTJONx8fHg0E1f9hGIyAMWgiC/U2v37Jh68QZ532RFPFAQGiL1pEeKn0X4WbM/TkXhY3UmP7xFCVMaRacmjNtLJwC5VNEJ7KPCHzOSB5Zmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNp7X9Dp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739037761; x=1770573761;
  h=date:from:to:cc:subject:message-id;
  bh=cHJ9P8HgDm8l3mOijmQruqvKAn7f9VO4Jl8g12PmbwA=;
  b=MNp7X9Dpt1LG8ZFqffOwosYqspo8UEwslaqHxDeA9W+CGlt/y50Qqo1d
   Wk4AcqcWKwEthbscGt3uxlNUzU4zzgtrDVvQnzdfoEZTC8FM3RLqfsvuO
   yDkNUWt8I9GMLg/lDS7SQ2WnCFihv0MOgyXXBEJDxNo297dT4byC3QKAz
   9aBdbzPgHx7iRnXy80Uy0v53NonbxGRZ021+Hiq3RPYtgurdqaF08eUDE
   4bbFp24yyvmIUUytP1f+N/2mdfQHF0xt8sj00iN9+jZ5RnHXW2bBH/SoE
   Avu5pbN3al/q5UUq/OojbkM9sNzH+M9yFuriQgvn8rGJ+aNIL/3OW7WA6
   w==;
X-CSE-ConnectionGUID: CMWabfHySDSRrzChp86nMg==
X-CSE-MsgGUID: FTOuixDgQzumb1yaKkJ6YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="39817272"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="39817272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 10:02:39 -0800
X-CSE-ConnectionGUID: spMDWoiQTeCEDnMgBBIDnA==
X-CSE-MsgGUID: a7V2X8LjS1qxkDQgv91NPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116411441"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Feb 2025 10:02:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgpA3-0010Sb-2C;
	Sat, 08 Feb 2025 18:02:35 +0000
Date: Sun, 09 Feb 2025 02:02:18 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 d920908fe36c2b3a1c6fe444831e0c8c2a995fd1
Message-ID: <202502090210.A1wRVQRX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: d920908fe36c2b3a1c6fe444831e0c8c2a995fd1  Merge branch 'for-6.14-fixes' into for-next

elapsed time: 1219m

configs tested: 200
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20250208    gcc-13.2.0
arc                   randconfig-001-20250209    gcc-13.2.0
arc                   randconfig-002-20250208    gcc-13.2.0
arc                   randconfig-002-20250209    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                         axm55xx_defconfig    clang-21
arm                   randconfig-001-20250208    gcc-13.2.0
arm                   randconfig-001-20250208    gcc-14.2.0
arm                   randconfig-001-20250209    gcc-13.2.0
arm                   randconfig-002-20250208    clang-17
arm                   randconfig-002-20250208    gcc-13.2.0
arm                   randconfig-002-20250209    gcc-13.2.0
arm                   randconfig-003-20250208    clang-21
arm                   randconfig-003-20250208    gcc-13.2.0
arm                   randconfig-003-20250209    gcc-13.2.0
arm                   randconfig-004-20250208    gcc-13.2.0
arm                   randconfig-004-20250208    gcc-14.2.0
arm                   randconfig-004-20250209    gcc-13.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250208    clang-21
arm64                 randconfig-001-20250208    gcc-13.2.0
arm64                 randconfig-001-20250209    gcc-13.2.0
arm64                 randconfig-002-20250208    clang-21
arm64                 randconfig-002-20250208    gcc-13.2.0
arm64                 randconfig-002-20250209    gcc-13.2.0
arm64                 randconfig-003-20250208    clang-21
arm64                 randconfig-003-20250208    gcc-13.2.0
arm64                 randconfig-003-20250209    gcc-13.2.0
arm64                 randconfig-004-20250208    clang-15
arm64                 randconfig-004-20250208    gcc-13.2.0
arm64                 randconfig-004-20250209    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250208    gcc-14.2.0
csky                  randconfig-002-20250208    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250208    clang-21
hexagon               randconfig-002-20250208    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250208    gcc-11
i386        buildonly-randconfig-002-20250208    clang-19
i386        buildonly-randconfig-002-20250208    gcc-11
i386        buildonly-randconfig-003-20250208    gcc-11
i386        buildonly-randconfig-003-20250208    gcc-12
i386        buildonly-randconfig-004-20250208    clang-19
i386        buildonly-randconfig-004-20250208    gcc-11
i386        buildonly-randconfig-005-20250208    clang-19
i386        buildonly-randconfig-005-20250208    gcc-11
i386        buildonly-randconfig-006-20250208    gcc-11
i386        buildonly-randconfig-006-20250208    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250208    clang-19
i386                  randconfig-002-20250208    clang-19
i386                  randconfig-003-20250208    clang-19
i386                  randconfig-004-20250208    clang-19
i386                  randconfig-005-20250208    clang-19
i386                  randconfig-006-20250208    clang-19
i386                  randconfig-007-20250208    clang-19
i386                  randconfig-011-20250208    gcc-12
i386                  randconfig-012-20250208    gcc-12
i386                  randconfig-013-20250208    gcc-12
i386                  randconfig-014-20250208    gcc-12
i386                  randconfig-015-20250208    gcc-12
i386                  randconfig-016-20250208    gcc-12
i386                  randconfig-017-20250208    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250208    gcc-14.2.0
loongarch             randconfig-002-20250208    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250208    gcc-14.2.0
nios2                 randconfig-002-20250208    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250208    gcc-14.2.0
parisc                randconfig-002-20250208    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-21
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250208    clang-19
powerpc               randconfig-002-20250208    clang-17
powerpc               randconfig-003-20250208    gcc-14.2.0
powerpc                     tqm5200_defconfig    clang-21
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-21
powerpc64             randconfig-001-20250208    clang-21
powerpc64             randconfig-002-20250208    gcc-14.2.0
powerpc64             randconfig-003-20250208    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250208    gcc-14.2.0
riscv                 randconfig-002-20250208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250208    gcc-14.2.0
s390                  randconfig-002-20250208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250208    gcc-14.2.0
sh                    randconfig-002-20250208    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                          urquell_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250208    gcc-14.2.0
sparc                 randconfig-002-20250208    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250208    gcc-14.2.0
sparc64               randconfig-002-20250208    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250208    gcc-14.2.0
um                    randconfig-002-20250208    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250208    clang-19
x86_64      buildonly-randconfig-002-20250208    clang-19
x86_64      buildonly-randconfig-002-20250208    gcc-12
x86_64      buildonly-randconfig-003-20250208    clang-19
x86_64      buildonly-randconfig-003-20250208    gcc-12
x86_64      buildonly-randconfig-004-20250208    clang-19
x86_64      buildonly-randconfig-005-20250208    clang-19
x86_64      buildonly-randconfig-006-20250208    clang-19
x86_64      buildonly-randconfig-006-20250208    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250208    clang-19
x86_64                randconfig-002-20250208    clang-19
x86_64                randconfig-003-20250208    clang-19
x86_64                randconfig-004-20250208    clang-19
x86_64                randconfig-005-20250208    clang-19
x86_64                randconfig-006-20250208    clang-19
x86_64                randconfig-007-20250208    clang-19
x86_64                randconfig-008-20250208    clang-19
x86_64                randconfig-071-20250208    gcc-12
x86_64                randconfig-072-20250208    gcc-12
x86_64                randconfig-073-20250208    gcc-12
x86_64                randconfig-074-20250208    gcc-12
x86_64                randconfig-075-20250208    gcc-12
x86_64                randconfig-076-20250208    gcc-12
x86_64                randconfig-077-20250208    gcc-12
x86_64                randconfig-078-20250208    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250208    gcc-14.2.0
xtensa                randconfig-002-20250208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

