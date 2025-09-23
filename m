Return-Path: <cgroups+bounces-10405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F1B97C39
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 01:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4D91892EFE
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31930FF13;
	Tue, 23 Sep 2025 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3tnIrFz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70B30FC31
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668383; cv=none; b=N5rjvVTeMN7ipI6wuhnnK29nImuw2kiY6wfmS9YBAxovRcpx+eBm6ZVBZtwrYIJccUqECKIH3gdfg1XoDS/2lq3UdpBS2vVm/Obr4GpDvAOqrcMr/MXPs3dwUBwBOwD2YKsfZbJiylGtcfYUMmiP21QtuIQMjVryKTLTb/pdC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668383; c=relaxed/simple;
	bh=NydiqdJZxSn6QvD7PWHBN/HkLiCWqiOh8j5KTfY7kNg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rnnrpLI9BswK+Be0mwYLwlL5qtU7k+sLDRjMr6Xj+2eXJBRO2u2w1Fn3+Jgra54tmSuiUUbfaSA+neOtc3LarKOZEIoqfbT8HBCHxFAPONq7+zaxN5q6GKE4pl/xZBrwnIOtI8p49/fQZAiGEm9jRPsMvq+6TCtW2T/uK7olgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3tnIrFz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758668382; x=1790204382;
  h=date:from:to:cc:subject:message-id;
  bh=NydiqdJZxSn6QvD7PWHBN/HkLiCWqiOh8j5KTfY7kNg=;
  b=k3tnIrFzWqxn6/N1kLdPSlqEJI1TN5SIJGAL9oWGBQCpt3J/1vpF20/w
   tko8Wf3qU3AMa9JEpYht9Oza7dsUHDNK1Gr8Vc41c9qmJ/V2Sosj4Bi+f
   V1XGr+0xustgTl/1KT+LNjWylH0UFSviOM4gTh6cfXMmCTMlVT0U8mRAs
   tFK3692oiy9dEKJ8AXwVdKwZSANm6yUzDZVx/T70ybFky+XKP1RfW+HWM
   d8y2L5rny3fZ2VL28LMCdsdKcXXeVeIprBd6/+p1Z6OsdljLl3KgeBPbo
   0I13Xktb+9KWVBbjYMmtOcA8nYKvpVYH4u5q+vBWs3msu2t6W4hkoXHyr
   g==;
X-CSE-ConnectionGUID: f14EZj0ERi2QNT5scdwA9g==
X-CSE-MsgGUID: XOFUvPhiTbaalL56Zd4OYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60174335"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="60174335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 15:59:41 -0700
X-CSE-ConnectionGUID: UcmvlMowRiiQJFASdEnQhQ==
X-CSE-MsgGUID: OnWIcLbDQVSz3aHyyXMduA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="177322653"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 Sep 2025 15:59:40 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1Byz-0003cN-27;
	Tue, 23 Sep 2025 22:59:37 +0000
Date: Wed, 24 Sep 2025 06:58:41 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD SUCCESS
 8f0fdbd4a06bf795c68bc9839d9c349ab592654f
Message-ID: <202509240631.Pr3vFNFn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: 8f0fdbd4a06bf795c68bc9839d9c349ab592654f  cpuset: remove is_prs_invalid helper

elapsed time: 1380m

configs tested: 284
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250923    gcc-12.5.0
arc                   randconfig-002-20250923    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                             pxa_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.1.0
arm                   randconfig-001-20250923    gcc-12.5.0
arm                   randconfig-002-20250923    clang-17
arm                   randconfig-002-20250923    gcc-12.5.0
arm                   randconfig-003-20250923    gcc-12.5.0
arm                   randconfig-003-20250923    gcc-8.5.0
arm                   randconfig-004-20250923    clang-22
arm                   randconfig-004-20250923    gcc-12.5.0
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            alldefconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250923    gcc-12.5.0
arm64                 randconfig-001-20250923    gcc-8.5.0
arm64                 randconfig-002-20250923    clang-18
arm64                 randconfig-002-20250923    gcc-12.5.0
arm64                 randconfig-003-20250923    gcc-12.5.0
arm64                 randconfig-003-20250923    gcc-8.5.0
arm64                 randconfig-004-20250923    gcc-11.5.0
arm64                 randconfig-004-20250923    gcc-12.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250923    gcc-10.5.0
csky                  randconfig-001-20250923    gcc-9.5.0
csky                  randconfig-001-20250924    clang-22
csky                  randconfig-002-20250923    gcc-10.5.0
csky                  randconfig-002-20250923    gcc-15.1.0
csky                  randconfig-002-20250924    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250923    clang-22
hexagon               randconfig-001-20250923    gcc-10.5.0
hexagon               randconfig-001-20250924    clang-22
hexagon               randconfig-002-20250923    clang-22
hexagon               randconfig-002-20250923    gcc-10.5.0
hexagon               randconfig-002-20250924    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250923    gcc-14
i386        buildonly-randconfig-002-20250923    clang-20
i386        buildonly-randconfig-002-20250923    gcc-14
i386        buildonly-randconfig-003-20250923    clang-20
i386        buildonly-randconfig-003-20250923    gcc-14
i386        buildonly-randconfig-004-20250923    gcc-14
i386        buildonly-randconfig-005-20250923    clang-20
i386        buildonly-randconfig-005-20250923    gcc-14
i386        buildonly-randconfig-006-20250923    clang-20
i386        buildonly-randconfig-006-20250923    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250923    gcc-14
i386                  randconfig-001-20250924    clang-20
i386                  randconfig-002-20250923    gcc-14
i386                  randconfig-002-20250924    clang-20
i386                  randconfig-003-20250923    gcc-14
i386                  randconfig-003-20250924    clang-20
i386                  randconfig-004-20250923    gcc-14
i386                  randconfig-004-20250924    clang-20
i386                  randconfig-005-20250923    gcc-14
i386                  randconfig-005-20250924    clang-20
i386                  randconfig-006-20250923    gcc-14
i386                  randconfig-006-20250924    clang-20
i386                  randconfig-007-20250923    gcc-14
i386                  randconfig-007-20250924    clang-20
i386                  randconfig-011-20250923    gcc-14
i386                  randconfig-012-20250923    gcc-14
i386                  randconfig-013-20250923    gcc-14
i386                  randconfig-014-20250923    gcc-14
i386                  randconfig-015-20250923    gcc-14
i386                  randconfig-016-20250923    gcc-14
i386                  randconfig-017-20250923    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250923    gcc-10.5.0
loongarch             randconfig-001-20250923    gcc-15.1.0
loongarch             randconfig-001-20250924    clang-22
loongarch             randconfig-002-20250923    gcc-10.5.0
loongarch             randconfig-002-20250923    gcc-15.1.0
loongarch             randconfig-002-20250924    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-22
nios2                         3c120_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250923    gcc-10.5.0
nios2                 randconfig-001-20250923    gcc-11.5.0
nios2                 randconfig-001-20250924    clang-22
nios2                 randconfig-002-20250923    gcc-10.5.0
nios2                 randconfig-002-20250923    gcc-11.5.0
nios2                 randconfig-002-20250924    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250923    gcc-10.5.0
parisc                randconfig-001-20250923    gcc-15.1.0
parisc                randconfig-001-20250924    clang-22
parisc                randconfig-002-20250923    gcc-10.5.0
parisc                randconfig-002-20250923    gcc-9.5.0
parisc                randconfig-002-20250924    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        icon_defconfig    clang-22
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20250923    gcc-10.5.0
powerpc               randconfig-001-20250923    gcc-8.5.0
powerpc               randconfig-001-20250924    clang-22
powerpc               randconfig-002-20250923    clang-16
powerpc               randconfig-002-20250923    gcc-10.5.0
powerpc               randconfig-002-20250924    clang-22
powerpc               randconfig-003-20250923    gcc-10.5.0
powerpc               randconfig-003-20250923    gcc-12.5.0
powerpc               randconfig-003-20250924    clang-22
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250923    gcc-10.5.0
powerpc64             randconfig-001-20250924    clang-22
powerpc64             randconfig-002-20250923    clang-22
powerpc64             randconfig-002-20250923    gcc-10.5.0
powerpc64             randconfig-002-20250924    clang-22
powerpc64             randconfig-003-20250924    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250923    gcc-12.5.0
riscv                 randconfig-002-20250923    clang-22
riscv                 randconfig-002-20250923    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-14
s390                  randconfig-001-20250923    gcc-12.5.0
s390                  randconfig-001-20250923    gcc-8.5.0
s390                  randconfig-002-20250923    clang-22
s390                  randconfig-002-20250923    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250923    gcc-12.5.0
sh                    randconfig-001-20250923    gcc-15.1.0
sh                    randconfig-002-20250923    gcc-10.5.0
sh                    randconfig-002-20250923    gcc-12.5.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250923    gcc-12.5.0
sparc                 randconfig-001-20250923    gcc-8.5.0
sparc                 randconfig-002-20250923    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250923    clang-22
sparc64               randconfig-001-20250923    gcc-12.5.0
sparc64               randconfig-002-20250923    gcc-12.5.0
sparc64               randconfig-002-20250923    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250923    clang-22
um                    randconfig-001-20250923    gcc-12.5.0
um                    randconfig-002-20250923    clang-22
um                    randconfig-002-20250923    gcc-12.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250923    clang-20
x86_64      buildonly-randconfig-001-20250923    gcc-14
x86_64      buildonly-randconfig-002-20250923    clang-20
x86_64      buildonly-randconfig-002-20250923    gcc-14
x86_64      buildonly-randconfig-003-20250923    clang-20
x86_64      buildonly-randconfig-003-20250923    gcc-14
x86_64      buildonly-randconfig-004-20250923    clang-20
x86_64      buildonly-randconfig-005-20250923    clang-20
x86_64      buildonly-randconfig-006-20250923    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250923    gcc-14
x86_64                randconfig-002-20250923    gcc-14
x86_64                randconfig-003-20250923    gcc-14
x86_64                randconfig-004-20250923    gcc-14
x86_64                randconfig-005-20250923    gcc-14
x86_64                randconfig-006-20250923    gcc-14
x86_64                randconfig-007-20250923    gcc-14
x86_64                randconfig-008-20250923    gcc-14
x86_64                randconfig-071-20250923    clang-20
x86_64                randconfig-072-20250923    clang-20
x86_64                randconfig-073-20250923    clang-20
x86_64                randconfig-074-20250923    clang-20
x86_64                randconfig-075-20250923    clang-20
x86_64                randconfig-076-20250923    clang-20
x86_64                randconfig-077-20250923    clang-20
x86_64                randconfig-078-20250923    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250923    gcc-12.5.0
xtensa                randconfig-001-20250923    gcc-8.5.0
xtensa                randconfig-002-20250923    gcc-12.5.0
xtensa                randconfig-002-20250923    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

