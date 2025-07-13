Return-Path: <cgroups+bounces-8717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CFB0311A
	for <lists+cgroups@lfdr.de>; Sun, 13 Jul 2025 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCC43BE95A
	for <lists+cgroups@lfdr.de>; Sun, 13 Jul 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D2223DDE;
	Sun, 13 Jul 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SERGpSny"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155654654
	for <cgroups@vger.kernel.org>; Sun, 13 Jul 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752412967; cv=none; b=lV5aQgfryMxpvTAD6b2Og5hPvrCzFb7RR3IaGN3U3kq4aF6RshfCQx5D97CkMdFFqeGIuXZ+qQXMzht9rThY+fUhdSHEMf3j8l5YNU/z6rWuyfySRYQ0h41p3rwkagx13X4oQfTlH6sX0WIIjmpYAT1hkJd9WeVcp5FBkLoWkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752412967; c=relaxed/simple;
	bh=SvduCFc0DVkJHgxnQSPTafGMdqwKTU1sFYwZxi6Fj+g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KkGDQj5s7KArRSVQOAQl78NNaDz2cgyHhHn4CxCC8A0LsiJ+YsF1pzU+m5f17Y6FZX0o+a4Wuuyql/RdNssyxjUWyIf+xzDlHr/A2R/ANia1o6wpuQ3XiSNH7eYXf88nJmj7Uve04uqpAxGCTDjW272f7/JUTr4MT7O74O1UCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SERGpSny; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752412965; x=1783948965;
  h=date:from:to:cc:subject:message-id;
  bh=SvduCFc0DVkJHgxnQSPTafGMdqwKTU1sFYwZxi6Fj+g=;
  b=SERGpSnyGYSGkcZRaMj8ZV2dGceONN9EgKMoVzhnf/jx3xrDNzs8CCoR
   kd+lh5dPF8NtotdnAo2NmCSzkipcF8cbzFT8d9Wat+LRNF6TrfXppD1eJ
   GM/wUPRvyLwT18Tojxw/CsIXu8F7qOjXeSyrBgoiAmA55noRdHze+mS7R
   ytig7mXGIYwsnGAz9snPUt3HR2h6wjQn+OFCJ47QWAOsx2j+HEjsNzTPs
   KAZttXYYjcOMKe7awPkgQoHSidX8ZAPBS2FQF36r/EUIqdJGS0LWpaM/7
   9GJUEaNzmG3qSalwFXzbJekVhYufxCFchQiGFe63RyiZjAa4DtQl3XaRK
   A==;
X-CSE-ConnectionGUID: +xbUVEHJQq65m5Nd6XDFFA==
X-CSE-MsgGUID: Ms+MB5bKTHOE4HqQUretPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58289631"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="58289631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 06:22:45 -0700
X-CSE-ConnectionGUID: 7C5GkJsWR2aRN6Aq4fWmLg==
X-CSE-MsgGUID: 5oZepeJJT5W6N6s3nhvwYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="180412220"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Jul 2025 06:22:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uawfA-00086d-36;
	Sun, 13 Jul 2025 13:22:40 +0000
Date: Sun, 13 Jul 2025 21:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5ca8e48d88a012a9cafa4c0c09f32bc158a21249
Message-ID: <202507132146.dfCbR9Fm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5ca8e48d88a012a9cafa4c0c09f32bc158a21249  Merge branch 'for-6.17' into for-next

elapsed time: 1171m

configs tested: 197
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250713    gcc-11.5.0
arc                   randconfig-002-20250713    gcc-10.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                          ep93xx_defconfig    clang-21
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250713    clang-21
arm                   randconfig-002-20250713    gcc-10.5.0
arm                   randconfig-003-20250713    clang-21
arm                   randconfig-004-20250713    gcc-11.5.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250713    gcc-8.5.0
arm64                 randconfig-002-20250713    gcc-13.4.0
arm64                 randconfig-003-20250713    clang-21
arm64                 randconfig-004-20250713    clang-21
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250713    gcc-15.1.0
csky                  randconfig-002-20250713    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250713    clang-21
hexagon               randconfig-002-20250713    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250713    clang-20
i386        buildonly-randconfig-002-20250713    clang-20
i386        buildonly-randconfig-003-20250713    gcc-12
i386        buildonly-randconfig-004-20250713    gcc-12
i386        buildonly-randconfig-005-20250713    clang-20
i386        buildonly-randconfig-006-20250713    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250713    clang-20
i386                  randconfig-002-20250713    clang-20
i386                  randconfig-003-20250713    clang-20
i386                  randconfig-004-20250713    clang-20
i386                  randconfig-005-20250713    clang-20
i386                  randconfig-006-20250713    clang-20
i386                  randconfig-007-20250713    clang-20
i386                  randconfig-011-20250713    gcc-12
i386                  randconfig-012-20250713    gcc-12
i386                  randconfig-013-20250713    gcc-12
i386                  randconfig-014-20250713    gcc-12
i386                  randconfig-015-20250713    gcc-12
i386                  randconfig-016-20250713    gcc-12
i386                  randconfig-017-20250713    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250713    clang-21
loongarch             randconfig-002-20250713    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      malta_kvm_defconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250713    gcc-11.5.0
nios2                 randconfig-002-20250713    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250713    gcc-8.5.0
parisc                randconfig-002-20250713    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-21
powerpc               randconfig-001-20250713    clang-21
powerpc               randconfig-002-20250713    clang-19
powerpc               randconfig-003-20250713    gcc-8.5.0
powerpc64             randconfig-002-20250713    clang-21
powerpc64             randconfig-003-20250713    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250713    clang-20
riscv                 randconfig-002-20250713    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250713    clang-21
s390                  randconfig-002-20250713    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250713    gcc-15.1.0
sh                    randconfig-002-20250713    gcc-11.5.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250713    gcc-8.5.0
sparc                 randconfig-002-20250713    gcc-10.3.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250713    gcc-8.5.0
sparc64               randconfig-002-20250713    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250713    clang-21
um                    randconfig-002-20250713    gcc-12
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250713    clang-20
x86_64      buildonly-randconfig-002-20250713    clang-20
x86_64      buildonly-randconfig-003-20250713    clang-20
x86_64      buildonly-randconfig-004-20250713    clang-20
x86_64      buildonly-randconfig-005-20250713    clang-20
x86_64      buildonly-randconfig-006-20250713    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250713    gcc-12
x86_64                randconfig-002-20250713    gcc-12
x86_64                randconfig-003-20250713    gcc-12
x86_64                randconfig-004-20250713    gcc-12
x86_64                randconfig-005-20250713    gcc-12
x86_64                randconfig-006-20250713    gcc-12
x86_64                randconfig-007-20250713    gcc-12
x86_64                randconfig-008-20250713    gcc-12
x86_64                randconfig-071-20250713    clang-20
x86_64                randconfig-072-20250713    clang-20
x86_64                randconfig-073-20250713    clang-20
x86_64                randconfig-074-20250713    clang-20
x86_64                randconfig-075-20250713    clang-20
x86_64                randconfig-076-20250713    clang-20
x86_64                randconfig-077-20250713    clang-20
x86_64                randconfig-078-20250713    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250713    gcc-11.5.0
xtensa                randconfig-002-20250713    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

