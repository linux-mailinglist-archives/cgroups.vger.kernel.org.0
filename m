Return-Path: <cgroups+bounces-8169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A192AB5BF9
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5967C7B43A3
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177A2BE0F0;
	Tue, 13 May 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5JkEgx8"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1511DF258
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159068; cv=none; b=XQPN1ui1QzEp/3t0A+HPqkFCdvtSW3INGx9dyWHLx0yc0YpfB3wJitsudpGBAOphntVyRuKHlzP5j0NDoaJVHEwu7HP7INoTrtSWW3P2Z5HEYM9enn1iqKR6saxgpPTg91tnVzhS0nb8r4+DVDEYUa1YewGMI7n3k9Ncp0+DW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159068; c=relaxed/simple;
	bh=ELFQEQEahceQbgAbHrSrNOxrb7R+AK84q9iLjx/Ud68=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dnMO4pwMpN1xtFVo/L9soUzfZSEDncZxvEAE5w0EV4it+mSTIJcW1sglI/Ngd9G+P/vAc3A2N9HNSzxAbV37gxOpwMPz884fiAo4BSSuAcG+MG7tiXnGsTm3q0a1AW3m24xLjMwWckvS4SIVbEgfab+Bs7YgRmzHQLpFusmnAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5JkEgx8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747159067; x=1778695067;
  h=date:from:to:cc:subject:message-id;
  bh=ELFQEQEahceQbgAbHrSrNOxrb7R+AK84q9iLjx/Ud68=;
  b=M5JkEgx8gF2yPfFJm21ERML0WriWfO6fHwLuiKbR72PyLvxCc2GAKjzI
   xNn+pXSzVEvlCP+Vl6I760xEkNeo6JjlnFSx3Z8oIKdYqn6Kpf2vUH9Xl
   Dll/zpAEbZZ5zhF94FD3qRcJ279l3jcQA09KsWlU1099vuGVcbAFTjbUP
   9c1eNxKsKhDCBqTuqgtf0Ke1RAMvS3Js0w8eOmGm99Emwipkqi5zV2y0l
   qZsKD6ks10QRHYpQB4t2ru8tXphJYiuZwiQkA2KfpLFlO9fIf/jvkKLMU
   AtGgBHhbxrACIHM7hdKPRAcsqh17fkSrq0IFNVpNVE37TCsP8NCWlFpDO
   w==;
X-CSE-ConnectionGUID: PX7ikbXHR2uYtXtDW9JYGw==
X-CSE-MsgGUID: vLLxw3c1QG6xjHe2Hx5aIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="71528528"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="71528528"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 10:57:46 -0700
X-CSE-ConnectionGUID: paQegqiLRX2Kf59rtpphXA==
X-CSE-MsgGUID: rNidMwprSuWgFbgw1WOY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142667251"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 May 2025 10:57:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEtss-000GIA-1z;
	Tue, 13 May 2025 17:57:42 +0000
Date: Wed, 14 May 2025 01:57:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.16] BUILD SUCCESS
 225c0360a8d92636835ca73e3144d78d876bb09c
Message-ID: <202505140154.8AjO9HVL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16
branch HEAD: 225c0360a8d92636835ca73e3144d78d876bb09c  cgroup/cpuset: drop useless cpumask_empty() in compute_effective_exclusive_cpumask()

elapsed time: 1452m

configs tested: 216
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250513    gcc-14.2.0
arc                   randconfig-002-20250513    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-21
arm                      integrator_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250513    gcc-7.5.0
arm                   randconfig-002-20250513    gcc-8.5.0
arm                   randconfig-003-20250513    gcc-8.5.0
arm                   randconfig-004-20250513    clang-16
arm                          sp7021_defconfig    gcc-14.2.0
arm                           tegra_defconfig    clang-21
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250513    clang-21
arm64                 randconfig-002-20250513    clang-21
arm64                 randconfig-003-20250513    gcc-6.5.0
arm64                 randconfig-004-20250513    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250513    clang-21
csky                  randconfig-001-20250513    gcc-14.2.0
csky                  randconfig-002-20250513    clang-21
csky                  randconfig-002-20250513    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250513    clang-21
hexagon               randconfig-002-20250513    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250513    clang-20
i386        buildonly-randconfig-002-20250513    clang-20
i386        buildonly-randconfig-003-20250513    clang-20
i386        buildonly-randconfig-004-20250513    clang-20
i386        buildonly-randconfig-005-20250513    clang-20
i386        buildonly-randconfig-005-20250513    gcc-12
i386        buildonly-randconfig-006-20250513    clang-20
i386        buildonly-randconfig-006-20250513    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250513    gcc-12
i386                  randconfig-002-20250513    gcc-12
i386                  randconfig-003-20250513    gcc-12
i386                  randconfig-004-20250513    gcc-12
i386                  randconfig-005-20250513    gcc-12
i386                  randconfig-006-20250513    gcc-12
i386                  randconfig-007-20250513    gcc-12
i386                  randconfig-011-20250513    gcc-12
i386                  randconfig-012-20250513    gcc-12
i386                  randconfig-013-20250513    gcc-12
i386                  randconfig-014-20250513    gcc-12
i386                  randconfig-015-20250513    gcc-12
i386                  randconfig-016-20250513    gcc-12
i386                  randconfig-017-20250513    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250513    clang-21
loongarch             randconfig-001-20250513    gcc-14.2.0
loongarch             randconfig-002-20250513    clang-21
loongarch             randconfig-002-20250513    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq5_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250513    clang-21
nios2                 randconfig-001-20250513    gcc-10.5.0
nios2                 randconfig-002-20250513    clang-21
nios2                 randconfig-002-20250513    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250513    clang-21
parisc                randconfig-001-20250513    gcc-11.5.0
parisc                randconfig-002-20250513    clang-21
parisc                randconfig-002-20250513    gcc-11.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250513    clang-21
powerpc               randconfig-002-20250513    clang-21
powerpc               randconfig-002-20250513    gcc-8.5.0
powerpc               randconfig-003-20250513    clang-21
powerpc64             randconfig-001-20250513    clang-21
powerpc64             randconfig-003-20250513    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250513    gcc-14.2.0
riscv                 randconfig-002-20250513    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250513    clang-21
s390                  randconfig-002-20250513    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-21
sh                    randconfig-001-20250513    gcc-12.4.0
sh                    randconfig-002-20250513    gcc-14.2.0
sh                          rsk7269_defconfig    clang-21
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                            shmin_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250513    gcc-11.5.0
sparc                 randconfig-002-20250513    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250513    gcc-11.5.0
sparc64               randconfig-002-20250513    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250513    clang-19
um                    randconfig-002-20250513    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250513    gcc-12
x86_64      buildonly-randconfig-002-20250513    gcc-12
x86_64      buildonly-randconfig-003-20250513    clang-20
x86_64      buildonly-randconfig-003-20250513    gcc-12
x86_64      buildonly-randconfig-004-20250513    gcc-12
x86_64      buildonly-randconfig-005-20250513    clang-20
x86_64      buildonly-randconfig-005-20250513    gcc-12
x86_64      buildonly-randconfig-006-20250513    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250513    clang-20
x86_64                randconfig-002-20250513    clang-20
x86_64                randconfig-003-20250513    clang-20
x86_64                randconfig-004-20250513    clang-20
x86_64                randconfig-005-20250513    clang-20
x86_64                randconfig-006-20250513    clang-20
x86_64                randconfig-007-20250513    clang-20
x86_64                randconfig-008-20250513    clang-20
x86_64                randconfig-071-20250513    clang-20
x86_64                randconfig-072-20250513    clang-20
x86_64                randconfig-073-20250513    clang-20
x86_64                randconfig-074-20250513    clang-20
x86_64                randconfig-075-20250513    clang-20
x86_64                randconfig-076-20250513    clang-20
x86_64                randconfig-077-20250513    clang-20
x86_64                randconfig-078-20250513    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250513    gcc-7.5.0
xtensa                randconfig-002-20250513    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

