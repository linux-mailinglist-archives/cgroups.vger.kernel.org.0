Return-Path: <cgroups+bounces-11650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7154EC3D1E3
	for <lists+cgroups@lfdr.de>; Thu, 06 Nov 2025 19:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434BF4E13BB
	for <lists+cgroups@lfdr.de>; Thu,  6 Nov 2025 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5A934DB7C;
	Thu,  6 Nov 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f94yPXa9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66E2C0F95
	for <cgroups@vger.kernel.org>; Thu,  6 Nov 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455277; cv=none; b=gSdU6SZvFXqeSJluznRq3/FowsXlXB/lYbTyTYHxfkYqsxZ3souYL3ALDEQ3em7cfKAz2GI2Vkywg/lSxR5jdQO8k9uV4m9HxOsVS4SsA9XxdRHsrpurB3TLGoJVSPEdgWfKgbhJtzr/8OTVe5+6/CkDxiPTTztI9PLdtrja0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455277; c=relaxed/simple;
	bh=K/Z26rvIxQ+iqdMWQ90LuQhU4WEXamsEQnW6Fw7tXSM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HsCvWll60rAM4xR+BrY4VA5q+eE7oRB2I6Hh1Q4ui6bnJW8pYk8qmnNnE3N/ju0EXTDEzacfRds+3MQkSDJ2pUKPeXLggPTRj724yQHNzd+wUWgrNwx/ib2Ju1HL3Klh9ph11vnTbAZPM1nUKcXC28fSbs7ZpJuLVjiaWz5uwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f94yPXa9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762455276; x=1793991276;
  h=date:from:to:cc:subject:message-id;
  bh=K/Z26rvIxQ+iqdMWQ90LuQhU4WEXamsEQnW6Fw7tXSM=;
  b=f94yPXa9QG5kvX0zvynZItfikeO8B5HIkJaWA981I+om42kM30l57v0r
   YpqXgAR/GVeKRJI7NgFWpvPVvEkrHf/iFbWpRUsAz04q4Wo80fxrbjIY1
   2LxGynDv9agKLb5TipXBa14KYOnLsonn7EWNPMgkRJEFfkN4Pe/Kn/n3B
   RONPwbRPbPY+YjdTvM+sA0/rzDkojdrKJFGq8LPg8PIpIGwp3VF8BVfrj
   f/C1X2N9m126m5rDawyvT3FvG+ljAkK+9a4cYIRR0sRDD8RdIwJoseax4
   yRHSWAftCQyc8o9z59252A49D6zUeeAzANG4FJLItkPC59Wu1amx4ZkYK
   g==;
X-CSE-ConnectionGUID: NbKTuOuyRFCRcnhuSL/cPw==
X-CSE-MsgGUID: z6JQZ14FQhqz6U/dqbL1wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68254541"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="68254541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:54:36 -0800
X-CSE-ConnectionGUID: BKsGZdejSAa0HNEVfS0ZKw==
X-CSE-MsgGUID: AJImSVBKTFOXdkXCcbw+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187554049"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 06 Nov 2025 10:54:34 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH57v-000UGn-2f;
	Thu, 06 Nov 2025 18:54:31 +0000
Date: Fri, 07 Nov 2025 02:53:53 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 be04e96ba911fac1dc4c7f89ebb42018d167043f
Message-ID: <202511070247.0dvAywMJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: be04e96ba911fac1dc4c7f89ebb42018d167043f  cgroup/cpuset: Globally track isolated_cpus update

elapsed time: 1488m

configs tested: 99
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251106    gcc-12.5.0
arc                   randconfig-002-20251106    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251106    gcc-11.5.0
arm                   randconfig-002-20251106    clang-22
arm                   randconfig-003-20251106    gcc-10.5.0
arm                   randconfig-004-20251106    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251106    gcc-11.5.0
arm64                 randconfig-002-20251106    clang-19
arm64                 randconfig-003-20251106    gcc-14.3.0
arm64                 randconfig-004-20251106    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251106    gcc-12.5.0
csky                  randconfig-002-20251106    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251106    clang-19
hexagon               randconfig-002-20251106    clang-20
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251106    clang-20
i386        buildonly-randconfig-002-20251106    clang-20
i386        buildonly-randconfig-003-20251106    gcc-14
i386        buildonly-randconfig-004-20251106    clang-20
i386        buildonly-randconfig-005-20251106    gcc-14
i386        buildonly-randconfig-006-20251106    gcc-14
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251106    gcc-15.1.0
loongarch             randconfig-002-20251106    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251106    gcc-9.5.0
nios2                 randconfig-002-20251106    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251106    gcc-10.5.0
parisc                randconfig-002-20251106    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251106    gcc-14.3.0
powerpc               randconfig-002-20251106    clang-22
powerpc64             randconfig-002-20251106    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251106    gcc-15.1.0
sparc                 randconfig-002-20251106    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251106    gcc-13.4.0
sparc64               randconfig-002-20251106    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251106    gcc-14
um                    randconfig-002-20251106    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251106    gcc-12
x86_64      buildonly-randconfig-002-20251106    gcc-14
x86_64      buildonly-randconfig-003-20251106    gcc-14
x86_64      buildonly-randconfig-004-20251106    gcc-14
x86_64      buildonly-randconfig-005-20251106    clang-20
x86_64      buildonly-randconfig-006-20251106    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251106    clang-20
x86_64                randconfig-012-20251106    clang-20
x86_64                randconfig-013-20251106    clang-20
x86_64                randconfig-014-20251106    gcc-14
x86_64                randconfig-015-20251106    gcc-14
x86_64                randconfig-016-20251106    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251106    gcc-9.5.0
xtensa                randconfig-002-20251106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

