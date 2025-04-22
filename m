Return-Path: <cgroups+bounces-7735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51080A9763E
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 21:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663C916CF2C
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D01298980;
	Tue, 22 Apr 2025 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTYoZx1o"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46D2980A1
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351832; cv=none; b=lqFJHzWM2kT/yluExqPrMn2VBM+/H/eW/rXj617t9HbNCFC0sjBtNqLcfN1Mbq3FeGhtq/QhdbQiv2gh2dUvH6z33QnWEG61iggWP38NadHlHOuKqC7ncGmzoXx6kLRfywZHD1++XAmxLj1NVFuQb9pGQwGhtbPBVpeAFg8NahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351832; c=relaxed/simple;
	bh=SKCS84iN2i0mf9jg/gCL53HKdIBKelUyoExMjzIQ2S4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bKqy3ojx/Isr/2imXt66cn07YixmeYjJaLSva69WNi8I7HGZdUPGj5jgiHO0CwqeRylY3PzzK4AcMqpSeTHIqvC7fR2kk6ZfUL8IY/cEciNzfeddbaCKHel211nWDzYHFsWidsK6n5apY3STS5klFJ+0JSI2p/0Laoq3zpgCqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTYoZx1o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745351831; x=1776887831;
  h=date:from:to:cc:subject:message-id;
  bh=SKCS84iN2i0mf9jg/gCL53HKdIBKelUyoExMjzIQ2S4=;
  b=UTYoZx1oTcF02D43FD2W0S3UbOjRzD2Eh/ZrbspxYrN51OuGBu2lNhnY
   LIu2R9yAlb6pSq4g5levErS8mtDBPj4a/5OrlDHMnV/hX+R3hh1xhpy3F
   6DnljOkVNzoO1AOuCVrwh+YTvf0OSQC91tOokahAvwhe5nnfp/QYuDT/G
   aypRErlhUGSYq3nfiD+s3WK+FFlxZSUUGb1cCGsNAHzq1NCyBzwzZrU6G
   fWKeWK4cPbTNPcM0cFmF2e5ECWqua8SOkGAbmEhgqtT1chZHSJorpzQsP
   gUcSdNTPNWSIMLEah2lcqSg08xgaoky+bwAPjs9/Y3CIddaAigw5miTv5
   Q==;
X-CSE-ConnectionGUID: zmETa9siQ+aOCleXJXnGIw==
X-CSE-MsgGUID: i31Jp4aUSTmA1rTN4AIvJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47106105"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="47106105"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 12:57:05 -0700
X-CSE-ConnectionGUID: RD9maqVSRFWTAsbD4Q8CzA==
X-CSE-MsgGUID: rRki1gRSTCeXwTtu7WuxGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132643707"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Apr 2025 12:57:04 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7Jjp-0001IB-1O;
	Tue, 22 Apr 2025 19:57:01 +0000
Date: Wed, 23 Apr 2025 03:56:30 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.16] BUILD SUCCESS
 7efbc8f2f9b3eed3ffc6560abf8305859f2153d3
Message-ID: <202504230320.SEOlKV2Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16
branch HEAD: 7efbc8f2f9b3eed3ffc6560abf8305859f2153d3  cgroup: fix pointer check in css_rstat_init()

elapsed time: 1456m

configs tested: 229
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250422    gcc-8.5.0
arc                   randconfig-002-20250422    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250422    gcc-8.5.0
arm                   randconfig-002-20250422    gcc-8.5.0
arm                   randconfig-003-20250422    gcc-7.5.0
arm                   randconfig-004-20250422    gcc-7.5.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250422    gcc-6.5.0
arm64                 randconfig-002-20250422    clang-21
arm64                 randconfig-003-20250422    clang-18
arm64                 randconfig-004-20250422    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250422    gcc-10.5.0
csky                  randconfig-002-20250422    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250422    clang-21
hexagon               randconfig-002-20250422    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250422    clang-20
i386        buildonly-randconfig-002-20250422    clang-20
i386        buildonly-randconfig-003-20250422    gcc-12
i386        buildonly-randconfig-004-20250422    gcc-12
i386        buildonly-randconfig-005-20250422    clang-20
i386        buildonly-randconfig-006-20250422    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250422    gcc-12
i386                  randconfig-002-20250422    gcc-12
i386                  randconfig-003-20250422    gcc-12
i386                  randconfig-004-20250422    gcc-12
i386                  randconfig-005-20250422    gcc-12
i386                  randconfig-006-20250422    gcc-12
i386                  randconfig-007-20250422    gcc-12
i386                  randconfig-011-20250423    clang-20
i386                  randconfig-012-20250423    clang-20
i386                  randconfig-013-20250423    clang-20
i386                  randconfig-014-20250423    clang-20
i386                  randconfig-015-20250423    clang-20
i386                  randconfig-016-20250423    clang-20
i386                  randconfig-017-20250423    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250422    gcc-14.2.0
loongarch             randconfig-002-20250422    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    clang-21
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250422    gcc-10.5.0
nios2                 randconfig-002-20250422    gcc-14.2.0
openrisc                         alldefconfig    clang-21
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250422    gcc-7.5.0
parisc                randconfig-002-20250422    gcc-11.5.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc               randconfig-001-20250422    clang-21
powerpc               randconfig-002-20250422    gcc-6.5.0
powerpc               randconfig-003-20250422    clang-16
powerpc                     sequoia_defconfig    clang-21
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250422    clang-21
powerpc64             randconfig-002-20250422    gcc-6.5.0
powerpc64             randconfig-003-20250422    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250422    clang-21
riscv                 randconfig-001-20250423    gcc-12
riscv                 randconfig-002-20250422    gcc-14.2.0
riscv                 randconfig-002-20250423    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250422    gcc-7.5.0
s390                  randconfig-001-20250423    gcc-12
s390                  randconfig-002-20250422    clang-21
s390                  randconfig-002-20250423    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.1.0
sh                    randconfig-001-20250422    gcc-14.2.0
sh                    randconfig-001-20250423    gcc-12
sh                    randconfig-002-20250422    gcc-6.5.0
sh                    randconfig-002-20250423    gcc-12
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250422    gcc-10.3.0
sparc                 randconfig-001-20250423    gcc-12
sparc                 randconfig-002-20250422    gcc-6.5.0
sparc                 randconfig-002-20250423    gcc-12
sparc                       sparc64_defconfig    clang-21
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250422    gcc-7.5.0
sparc64               randconfig-001-20250423    gcc-12
sparc64               randconfig-002-20250422    gcc-13.3.0
sparc64               randconfig-002-20250423    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250422    gcc-12
um                    randconfig-001-20250423    gcc-12
um                    randconfig-002-20250422    gcc-12
um                    randconfig-002-20250423    gcc-12
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250422    gcc-12
x86_64      buildonly-randconfig-002-20250422    clang-20
x86_64      buildonly-randconfig-003-20250422    gcc-12
x86_64      buildonly-randconfig-004-20250422    gcc-12
x86_64      buildonly-randconfig-005-20250422    clang-20
x86_64      buildonly-randconfig-006-20250422    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250423    clang-20
x86_64                randconfig-002-20250423    clang-20
x86_64                randconfig-003-20250423    clang-20
x86_64                randconfig-004-20250423    clang-20
x86_64                randconfig-005-20250423    clang-20
x86_64                randconfig-006-20250423    clang-20
x86_64                randconfig-007-20250423    clang-20
x86_64                randconfig-008-20250423    clang-20
x86_64                randconfig-071-20250422    gcc-12
x86_64                randconfig-072-20250422    gcc-12
x86_64                randconfig-073-20250422    gcc-12
x86_64                randconfig-074-20250422    gcc-12
x86_64                randconfig-075-20250422    gcc-12
x86_64                randconfig-076-20250422    gcc-12
x86_64                randconfig-077-20250422    gcc-12
x86_64                randconfig-078-20250422    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250422    gcc-14.2.0
xtensa                randconfig-001-20250423    gcc-12
xtensa                randconfig-002-20250422    gcc-9.3.0
xtensa                randconfig-002-20250423    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

