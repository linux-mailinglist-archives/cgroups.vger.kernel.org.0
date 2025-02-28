Return-Path: <cgroups+bounces-6746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E2A4A0B3
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC903BAD76
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7B27FE63;
	Fri, 28 Feb 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEmD4TAk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2227605D
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764574; cv=none; b=FZzGR3CBXpGjPN6QDcU6fGhXzzJ9eq7uwn2rQrs91GrjCC02hhS8K+H/EMSp+L0sVE4sHsRvIvDZSCmbwL3Ap7FmMGKySrnUmykwLipQlKBb+7PzhqwgYg8VZKtJuq/3HPUXK/xeDYShy5Pwn4kNgNuCq6OxqQpUOjusjjlqw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764574; c=relaxed/simple;
	bh=lQax6WSdGJQpBiU1a13VIDIscS73qVVjqNheJtDbYvM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SZYu6oGsJquM4aEPArjSq53epXFLtJOTv9peI88wSU9p95kYxldAujk6Hz1lxLXFRlA/R6kYdwcnLEwyop0t4HsCWBDxOGKw3rQGbJ9BkrS8RjryPlUF4ZOhXMXXdfUOo/I+xbY1miLIUkbaLOLeDvF3x7xJKmb5NkSBbMGxgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEmD4TAk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740764573; x=1772300573;
  h=date:from:to:cc:subject:message-id;
  bh=lQax6WSdGJQpBiU1a13VIDIscS73qVVjqNheJtDbYvM=;
  b=eEmD4TAkDgULLhvu3LJw6bcYPpBcy9DpwbCe/+htSkjLt8PtKiATT3DH
   aRqjOAk8jYcm5EX9BlGWTksyFjqF9T195AaJZb3fRz1uOqCaxBhTd+SzJ
   EyeAmsgPMDz/LkfGSb+jnO1aYRs9lNQzcme2vEZT4Yo6shFv9gDK5kmAQ
   zoTbFUMeAnD62poID4a5ow0FdFKoz3f2P2C6SAg1GN0RZCZ8X387KHu35
   TW1Y8SjxcTd92MfuqX/xoTtHdmDBnRyF5nKhl5ZoV0VXP/Ja1AG/KfsB9
   hkzcgimqTqT7ikrSCLYplIhRmFogVH4dpRkv+CjjyukeHSFjzANcwwyqR
   Q==;
X-CSE-ConnectionGUID: F+1Jgo8pR72F+3O2skiTmA==
X-CSE-MsgGUID: gx6TOBWRRpiyGlpumbGhfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="53088984"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="53088984"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:42:52 -0800
X-CSE-ConnectionGUID: BpYMp7PJSDSZeD6rDuD+Wg==
X-CSE-MsgGUID: 7Votj7nKRl+6gx1yOt86PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117416017"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 28 Feb 2025 09:42:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to4NZ-000FIW-2R;
	Fri, 28 Feb 2025 17:42:32 +0000
Date: Sat, 01 Mar 2025 01:39:00 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.15] BUILD SUCCESS
 c4af66a95aa3bc1d4f607ebd4eea524fb58946e3
Message-ID: <202503010154.9xgL61IN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.15
branch HEAD: c4af66a95aa3bc1d4f607ebd4eea524fb58946e3  cgroup/rstat: Fix forceidle time in cpu.stat

elapsed time: 1446m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

