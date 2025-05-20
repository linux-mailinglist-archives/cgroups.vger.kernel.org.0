Return-Path: <cgroups+bounces-8275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03414ABE070
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3814C5978
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F327C84F;
	Tue, 20 May 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCxxsbex"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054627BF95
	for <cgroups@vger.kernel.org>; Tue, 20 May 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757530; cv=none; b=DNJjswX55SJoY60eDu5K+4lTJNywcrBZCO1NDzjXbjq8FGTmsxpi+w+0kt71usG95s+bXthJC7EMQdXy17tR82wW8LGD8depjXy1EevArR3lFI1bqcB4H4VsYEKnngzP6Oda7FIbPb/s37uR3RcXWeUgJBqtcvIegsALUusGPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757530; c=relaxed/simple;
	bh=lCb3v8Gzy3f0cqpG7RAqN1aGtMgVzxpKJXPaMmmAnqs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b7CwSBIotBD8GsVLIbKqWscOvX92R1UapBj+qQFnNmLTE69AYR1kABCER1HmG8ddE71VNRRQjms4A0gkZLmc1twa2qi1+4JnJydKzsEub6ynve2ZLJESHOPUg3SOkczTYfzK5Yz6X2wgIUiyhlQa0LfWXC+RsZjCZOES8hOc6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCxxsbex; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747757528; x=1779293528;
  h=date:from:to:cc:subject:message-id;
  bh=lCb3v8Gzy3f0cqpG7RAqN1aGtMgVzxpKJXPaMmmAnqs=;
  b=KCxxsbexJk9LLm4Jayf6d97Rvsox+HEFsKtkMOuT13A+c/R8Uh9+wbfz
   NuRsb1dTHCj01bv0CQmArm5vap4rAoh3ch+FUtJ0ig+IlfQvi6hpWzHnj
   uv+c4PqO7x/QtsVcg2kUW+o/TwtY30VAOiKH9FuRZ67Mi/wEDEbQ65baF
   HuQoGEcY4viPz+/CU+di2ncEw6dYJjnKB8Ywzp4g2ESPMVwbWCYu3/e3z
   JlaoO5vCWGyn6JLL1HGLOe1V+FMuP/VMtvAVEiRzj4vAVx6Yt7fjNokaJ
   67d4201K58xWMutE0GzG6e0bHX8OHJ/LX3McaUHGn9Xks3wcm+gU+KBIc
   w==;
X-CSE-ConnectionGUID: YTRePUi5QKmF5QIiy0/rPw==
X-CSE-MsgGUID: Emo0RsmIT061r1bZKzZ6aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52327293"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="52327293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:12:07 -0700
X-CSE-ConnectionGUID: tFHt2tbKRz6sRaQ/twvUAg==
X-CSE-MsgGUID: kNEbT/LVTsitUmrXpcu/1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140265248"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 May 2025 09:12:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHPZU-000NKf-1n;
	Tue, 20 May 2025 16:12:04 +0000
Date: Wed, 21 May 2025 00:11:47 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.16] BUILD SUCCESS
 f3921fb7fdc23dd946b0c082f5fedca9ce75d506
Message-ID: <202505210037.X37UgcXV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16
branch HEAD: f3921fb7fdc23dd946b0c082f5fedca9ce75d506  cgroup: document the rstat per-cpu initialization

elapsed time: 1168m

configs tested: 202
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-001-20250520    gcc-8.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arc                   randconfig-002-20250520    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                   milbeaut_m10v_defconfig    clang-19
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-001-20250520    gcc-8.5.0
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-002-20250520    gcc-8.5.0
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-003-20250520    gcc-8.5.0
arm                   randconfig-004-20250520    gcc-7.5.0
arm                   randconfig-004-20250520    gcc-8.5.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-001-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-003-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-002-20250520    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-003-20250520    gcc-12
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-005-20250520    gcc-12
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250520    gcc-12
i386                  randconfig-002-20250520    gcc-12
i386                  randconfig-003-20250520    gcc-12
i386                  randconfig-004-20250520    gcc-12
i386                  randconfig-005-20250520    gcc-12
i386                  randconfig-006-20250520    gcc-12
i386                  randconfig-007-20250520    gcc-12
i386                  randconfig-011-20250520    gcc-12
i386                  randconfig-012-20250520    gcc-12
i386                  randconfig-013-20250520    gcc-12
i386                  randconfig-014-20250520    gcc-12
i386                  randconfig-015-20250520    gcc-12
i386                  randconfig-016-20250520    gcc-12
i386                  randconfig-017-20250520    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250520    gcc-13.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-002-20250520    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                      katmai_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    clang-21
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-002-20250520    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-002-20250520    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-002-20250520    gcc-9.3.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-002-20250520    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250520    gcc-12
x86_64                randconfig-002-20250520    gcc-12
x86_64                randconfig-003-20250520    gcc-12
x86_64                randconfig-004-20250520    gcc-12
x86_64                randconfig-005-20250520    gcc-12
x86_64                randconfig-006-20250520    gcc-12
x86_64                randconfig-007-20250520    gcc-12
x86_64                randconfig-008-20250520    gcc-12
x86_64                randconfig-071-20250520    gcc-12
x86_64                randconfig-072-20250520    gcc-12
x86_64                randconfig-073-20250520    gcc-12
x86_64                randconfig-074-20250520    gcc-12
x86_64                randconfig-075-20250520    gcc-12
x86_64                randconfig-076-20250520    gcc-12
x86_64                randconfig-077-20250520    gcc-12
x86_64                randconfig-078-20250520    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

