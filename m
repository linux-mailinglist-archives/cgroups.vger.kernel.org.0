Return-Path: <cgroups+bounces-5140-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4D9A031F
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 09:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA04B235CB
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6671C4A29;
	Wed, 16 Oct 2024 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYghsT3r"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2681B2193
	for <cgroups@vger.kernel.org>; Wed, 16 Oct 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065189; cv=none; b=aH8xvmqoarhm2IaAbis2MRQQm4UXVWgXz8ssXyfAodHVF19bjcCYVfayPucDYXWQLPll6Irqr9/UGYrbIMXriIQc2NO2iAYHNBqpyG7Y1d0fXw1AFSF4nZqe1j//6/ehmgAFSrkgZgJkjIWkXnd9Sf4XE+oDApkxMAN3JtHw4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065189; c=relaxed/simple;
	bh=YdUXLViOO6hJdP9k38mRK9O9nwbk1GAKPS9ffuHK2F0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LZ2t4pYCkVE1xNfKmgp4jgOCisiewvSUW0xdoIbXbcICBPsrCLWZmvWup6Yx4CzHkh9YSV50PLm1ALNaKrCphgtkGAUbiOuqb6qAehSvbfdsP6JX9gqOU6lufyith6kP+BYvXSiAjIwFl/HgFuz+CkTnccjEWYplFFDXhhe2xxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYghsT3r; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729065188; x=1760601188;
  h=date:from:to:cc:subject:message-id;
  bh=YdUXLViOO6hJdP9k38mRK9O9nwbk1GAKPS9ffuHK2F0=;
  b=XYghsT3r5PDhSq463sciGfRW+dXt7yVGtj5KDdmqIpUtGZIp/McUPzY5
   /86T6GcNwAISMvdfCtttU02cMH3mZAJFhSruSvH9ikGiFSt0h3bLrurRM
   +tgclHhaa49RsbsFfmhRZTNsYS6KwAfdQsMLZZVst77VMshrOn+P/6SYY
   Vg9UByI0eyop6HNxUy61KTlM8YZO/bXmzGzyE8kJXnOtww9ShNTmFbY0U
   YTJdUsvj84Go/aLteTLOcSBw2UWpu9vViJCpQGBnkBDFtCJkuQtbOxtnE
   zPj1lQKcrb9aAi95j7M7OkXaWXULQwZqidLvyq7tZ6pr19IQl3j1vUqXE
   A==;
X-CSE-ConnectionGUID: PbMNiVNmRk+RLmDlKo6JiQ==
X-CSE-MsgGUID: cAOu4/WER7K3Ps0+x/E9Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28285912"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28285912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 00:53:07 -0700
X-CSE-ConnectionGUID: WlnBJxBmTeixE9Cxky/LtA==
X-CSE-MsgGUID: oGK2nI7iSk+oVwxizeS9/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78214893"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2024 00:53:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0yq7-000KYN-2Y;
	Wed, 16 Oct 2024 07:53:03 +0000
Date: Wed, 16 Oct 2024 15:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.13] BUILD SUCCESS
 11312c86f9d7d1bffe0587185934a7070ce9ec33
Message-ID: <202410161500.IBihthwm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.13
branch HEAD: 11312c86f9d7d1bffe0587185934a7070ce9ec33  selftests/cgroup: Fix compile error in test_cpu.c

elapsed time: 1803m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.2.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                               allnoconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241016    clang-20
arc                   randconfig-002-20241016    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                         at91_dt_defconfig    gcc-13.2.0
arm                                 defconfig    gcc-14.1.0
arm                   milbeaut_m10v_defconfig    gcc-13.2.0
arm                          pxa910_defconfig    gcc-13.2.0
arm                   randconfig-001-20241016    clang-20
arm                   randconfig-002-20241016    clang-20
arm                   randconfig-003-20241016    clang-20
arm                   randconfig-004-20241016    clang-20
arm                         s3c6400_defconfig    gcc-13.2.0
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241016    clang-20
arm64                 randconfig-002-20241016    clang-20
arm64                 randconfig-003-20241016    clang-20
arm64                 randconfig-004-20241016    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241016    clang-20
csky                  randconfig-002-20241016    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241016    clang-20
hexagon               randconfig-002-20241016    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241016    gcc-11
i386        buildonly-randconfig-002-20241016    gcc-11
i386        buildonly-randconfig-003-20241016    gcc-11
i386        buildonly-randconfig-004-20241016    gcc-11
i386        buildonly-randconfig-005-20241016    gcc-11
i386        buildonly-randconfig-006-20241016    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241016    gcc-11
i386                  randconfig-002-20241016    gcc-11
i386                  randconfig-003-20241016    gcc-11
i386                  randconfig-004-20241016    gcc-11
i386                  randconfig-005-20241016    gcc-11
i386                  randconfig-006-20241016    gcc-11
i386                  randconfig-011-20241016    gcc-11
i386                  randconfig-012-20241016    gcc-11
i386                  randconfig-013-20241016    gcc-11
i386                  randconfig-014-20241016    gcc-11
i386                  randconfig-015-20241016    gcc-11
i386                  randconfig-016-20241016    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241016    clang-20
loongarch             randconfig-002-20241016    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241016    clang-20
nios2                 randconfig-002-20241016    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241016    clang-20
parisc                randconfig-002-20241016    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    gcc-13.2.0
powerpc                      chrp32_defconfig    gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-13.2.0
powerpc                      pcm030_defconfig    gcc-13.2.0
powerpc               randconfig-001-20241016    clang-20
powerpc               randconfig-002-20241016    clang-20
powerpc               randconfig-003-20241016    clang-20
powerpc                  storcenter_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20241016    clang-20
powerpc64             randconfig-002-20241016    clang-20
powerpc64             randconfig-003-20241016    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241016    clang-20
riscv                 randconfig-002-20241016    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241016    clang-20
s390                  randconfig-002-20241016    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-13.2.0
sh                        edosk7760_defconfig    gcc-13.2.0
sh                    randconfig-001-20241016    clang-20
sh                    randconfig-002-20241016    clang-20
sh                          sdk7780_defconfig    gcc-13.2.0
sh                   sh7770_generic_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-13.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241016    clang-20
sparc64               randconfig-002-20241016    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241016    clang-20
um                    randconfig-002-20241016    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241016    gcc-12
x86_64      buildonly-randconfig-002-20241016    gcc-12
x86_64      buildonly-randconfig-003-20241016    gcc-12
x86_64      buildonly-randconfig-004-20241016    gcc-12
x86_64      buildonly-randconfig-005-20241016    gcc-12
x86_64      buildonly-randconfig-006-20241016    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241016    gcc-12
x86_64                randconfig-002-20241016    gcc-12
x86_64                randconfig-003-20241016    gcc-12
x86_64                randconfig-004-20241016    gcc-12
x86_64                randconfig-005-20241016    gcc-12
x86_64                randconfig-006-20241016    gcc-12
x86_64                randconfig-011-20241016    gcc-12
x86_64                randconfig-012-20241016    gcc-12
x86_64                randconfig-013-20241016    gcc-12
x86_64                randconfig-014-20241016    gcc-12
x86_64                randconfig-015-20241016    gcc-12
x86_64                randconfig-016-20241016    gcc-12
x86_64                randconfig-071-20241016    gcc-12
x86_64                randconfig-072-20241016    gcc-12
x86_64                randconfig-073-20241016    gcc-12
x86_64                randconfig-074-20241016    gcc-12
x86_64                randconfig-075-20241016    gcc-12
x86_64                randconfig-076-20241016    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241016    clang-20
xtensa                randconfig-002-20241016    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

