Return-Path: <cgroups+bounces-9772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD86B478B9
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 04:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F30189D01D
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 02:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F618859B;
	Sun,  7 Sep 2025 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAptn8bS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868361CF96
	for <cgroups@vger.kernel.org>; Sun,  7 Sep 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757213166; cv=none; b=XUwoulP1nH7X+mlFEz0ad9KHU60gAgljN7eAC9uzv/mcCjE3lkRNLMlsDrNs/WwshHWSzooAuxT0fMu4IvZC8gnq90Akns5TGHmi0IypVbprgPR2zkuUh6IOxBa/iT+Tl/5Wfo2/2hf3aM6DxVtZKFmdTu0vMbbMZReJfP6w7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757213166; c=relaxed/simple;
	bh=4Mi8Srxrj4rRcV7bZ7tpVNbka2+gjM9dIfpGWCWp17M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n+saYXREjZx2Hh0EcxJ7NLb4bkv2U+bZ9sYSKHRFSbgusGBFcitjvyS23KzGuhPAd/XNknfuYAF/BVgQ4xvZuif/yPZPuEc2hTQ+2pW4lipWHZ1SSiUtf7EsE5Gz4moUKWlqgzw3+Q+/C/ZASPEm6OHkLqcgfUfpHpnxNNJwa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAptn8bS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757213164; x=1788749164;
  h=date:from:to:cc:subject:message-id;
  bh=4Mi8Srxrj4rRcV7bZ7tpVNbka2+gjM9dIfpGWCWp17M=;
  b=AAptn8bSoVXHiqTA287+tJed21H0kGtrVXoWIVNa94AdOio9DtzRAlSi
   BkMlTPgK1vBKcES4H9RzResWFT78EjQXIWD4hSN0DQB+Y1sOb4PPqpwOw
   JcWWftB/XeQK5G3G/Y1vcUsnT4v+9FyiEOrRTzyeyYBpZvSXlo6yskuGz
   BgSnq1giX2YqXto4OMSlUphn1tJuCgkUvl0EQimMVL0YIyn2FgRFdlXEO
   M1hJs2ILmR/ariNha35oinUXka0mDDzFEiYIfBHQsnifEwtYIc8rye6m3
   X2LzNFpETY8cbD+ADRWk0xuOxPG9URgDGTRfADbDC2yPlhnAapvQQJMi/
   Q==;
X-CSE-ConnectionGUID: Kg38sC/OST+rKhh3th8TjQ==
X-CSE-MsgGUID: 0qAhbSC+QI6OfL+sJW0GXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70886864"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="70886864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 19:46:03 -0700
X-CSE-ConnectionGUID: lCvNAywPR46YE4ZoQqblMQ==
X-CSE-MsgGUID: abTWRhfER7GUCDh8t+7TTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="176825194"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2025 19:46:02 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv5Pj-0001yG-2q;
	Sun, 07 Sep 2025 02:45:59 +0000
Date: Sun, 07 Sep 2025 10:45:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD SUCCESS
 4a3e62dfa7b79dc8f759219fe64318ff08e98013
Message-ID: <202509071017.sxkUMm9g-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: 4a3e62dfa7b79dc8f759219fe64318ff08e98013  cgroup: Merge branch 'for-6.17-fixes' into for-6.18

elapsed time: 2000m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250906    gcc-14.3.0
arc                   randconfig-002-20250906    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250906    clang-22
arm                   randconfig-002-20250906    clang-22
arm                   randconfig-003-20250906    gcc-13.4.0
arm                   randconfig-004-20250906    gcc-10.5.0
arm                        shmobile_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250906    gcc-8.5.0
arm64                 randconfig-002-20250906    gcc-12.5.0
arm64                 randconfig-003-20250906    clang-22
arm64                 randconfig-004-20250906    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250906    gcc-15.1.0
csky                  randconfig-002-20250906    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250906    clang-20
hexagon               randconfig-002-20250906    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250906    clang-20
i386        buildonly-randconfig-002-20250906    gcc-11
i386        buildonly-randconfig-003-20250906    gcc-13
i386        buildonly-randconfig-004-20250906    gcc-13
i386        buildonly-randconfig-005-20250906    clang-20
i386        buildonly-randconfig-006-20250906    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250906    clang-22
loongarch             randconfig-002-20250906    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250906    gcc-11.5.0
nios2                 randconfig-002-20250906    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250906    gcc-11.5.0
parisc                randconfig-002-20250906    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250906    gcc-14.3.0
powerpc               randconfig-002-20250906    clang-20
powerpc               randconfig-003-20250906    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250906    gcc-13.4.0
powerpc64             randconfig-002-20250906    gcc-10.5.0
powerpc64             randconfig-003-20250906    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250906    gcc-13.4.0
riscv                 randconfig-002-20250906    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250906    gcc-10.5.0
s390                  randconfig-002-20250906    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20250906    gcc-15.1.0
sh                    randconfig-002-20250906    gcc-12.5.0
sh                           se7751_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250906    gcc-8.5.0
sparc                 randconfig-002-20250906    gcc-13.4.0
sparc64               randconfig-001-20250906    clang-22
sparc64               randconfig-002-20250906    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250906    gcc-12
um                    randconfig-002-20250906    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250906    clang-20
x86_64      buildonly-randconfig-002-20250906    gcc-13
x86_64      buildonly-randconfig-003-20250906    gcc-13
x86_64      buildonly-randconfig-004-20250906    clang-20
x86_64      buildonly-randconfig-005-20250906    gcc-13
x86_64      buildonly-randconfig-006-20250906    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250906    gcc-12.5.0
xtensa                randconfig-002-20250906    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

