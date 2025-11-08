Return-Path: <cgroups+bounces-11680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550DC4266D
	for <lists+cgroups@lfdr.de>; Sat, 08 Nov 2025 05:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2E349BEE
	for <lists+cgroups@lfdr.de>; Sat,  8 Nov 2025 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444822405E1;
	Sat,  8 Nov 2025 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJE1Ha0S"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908A23D7CE
	for <cgroups@vger.kernel.org>; Sat,  8 Nov 2025 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574830; cv=none; b=hqw3uOoVabduzykawmoXuiTbOd2O/3TTepOeJ/C7HMqgwUEYi4xLxmg+g5/PZishvQdCp64jtByRzBpH8WMLohSnphbCB6GVJ5G2X+j1kjH6NzEqlClv76Ts4jUon8uY5/iFIB14N4mIAP5alAv7T88kdIJIUOYlMDNQmW281Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574830; c=relaxed/simple;
	bh=1WOSakQFTpyJpzqILnwMn2rs/FMEio8CVoWEkfPvo1A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p5uTw7hXU/G+vt6Q7pOC+ggpRn8EyMAYLZZ0JKVTmihryKi0Ct4RXwyLly9yGXpIHzP3+iMgLn3jMn4ctDUVpE0id0sGIYHUoEHd1A2/c6d4XG0pr56kSFPIqf25DAebxKsvMWKNW9lDJ3GpgQMp7R4CLa1eU3GnoW5dG3NwuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJE1Ha0S; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762574828; x=1794110828;
  h=date:from:to:cc:subject:message-id;
  bh=1WOSakQFTpyJpzqILnwMn2rs/FMEio8CVoWEkfPvo1A=;
  b=GJE1Ha0SBg2IelcybSxZL4hkv8mZ3e8zenEbqAdveq5sn0sDop3D4Iii
   wLgz2KyLv3CoxECllPjdWQ7l50Oomb7TaZG0D8TktfUhZRVeuWUDBhblg
   tSgFRMs6p3Kzf2maNbuHnCCJ/cDBeKDnjUEZ2gPs9UCktRlSB+v7jEEm3
   is8kwf5F/RSBA8NL5nf42UNYYwfpn2hX3Cpbv/OlolgtlS0VCIyKOxe/9
   /KxgfTBkF+BtyaCyEOq3aN3MRTmp4DpAdW8hr0snnQKUThWpR0ZFSQc4A
   Z7Rfy6pVeQUBVYZCZn56sI+h5UG4ThaF6uihjccCHrZ2bX+/G0WnPcjc1
   w==;
X-CSE-ConnectionGUID: lMcqEWKQTZGkUy5IXgHtBA==
X-CSE-MsgGUID: H39z3KGtRTiGTmvoxDCaHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68562410"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="68562410"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 20:07:08 -0800
X-CSE-ConnectionGUID: rvKU7xhMTvuaZe76FrkBag==
X-CSE-MsgGUID: a+KXh/FMSbGY4vZOknD4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="188640735"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Nov 2025 20:07:07 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHaEC-0000i7-1v;
	Sat, 08 Nov 2025 04:07:04 +0000
Date: Sat, 08 Nov 2025 12:06:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.19] BUILD SUCCESS
 9311e6c29b348b005e79228ef6facd38ebcc73f9
Message-ID: <202511081203.Z2grw3D4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.19
branch HEAD: 9311e6c29b348b005e79228ef6facd38ebcc73f9  cgroup: Fix sleeping from invalid context warning on PREEMPT_RT

elapsed time: 1702m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251108    gcc-8.5.0
arm64                 randconfig-002-20251108    clang-22
arm64                 randconfig-003-20251108    clang-22
arm64                 randconfig-004-20251108    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251108    gcc-15.1.0
csky                  randconfig-002-20251108    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251108    gcc-14
i386        buildonly-randconfig-002-20251108    gcc-14
i386        buildonly-randconfig-003-20251108    gcc-14
i386        buildonly-randconfig-004-20251108    gcc-14
i386        buildonly-randconfig-005-20251108    clang-20
i386        buildonly-randconfig-006-20251108    gcc-14
i386                  randconfig-001-20251108    clang-20
i386                  randconfig-002-20251108    clang-20
i386                  randconfig-003-20251108    gcc-12
i386                  randconfig-004-20251108    gcc-12
i386                  randconfig-005-20251108    clang-20
i386                  randconfig-006-20251108    gcc-14
i386                  randconfig-007-20251108    gcc-14
i386                  randconfig-011-20251108    gcc-14
i386                  randconfig-012-20251108    clang-20
i386                  randconfig-013-20251108    gcc-14
i386                  randconfig-014-20251108    clang-20
i386                  randconfig-015-20251108    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-22
mips                        omega2p_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251107    clang-22
riscv                 randconfig-002-20251107    gcc-13.4.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251107    gcc-8.5.0
s390                  randconfig-002-20251107    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251107    gcc-13.4.0
sh                    randconfig-002-20251107    gcc-11.5.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251108    gcc-14.3.0
sparc                 randconfig-002-20251108    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251108    clang-20
sparc64               randconfig-002-20251108    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251108    gcc-14
um                    randconfig-002-20251108    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251108    gcc-14
x86_64      buildonly-randconfig-002-20251108    gcc-12
x86_64      buildonly-randconfig-003-20251108    clang-20
x86_64      buildonly-randconfig-004-20251108    gcc-14
x86_64      buildonly-randconfig-005-20251108    gcc-14
x86_64      buildonly-randconfig-006-20251108    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251108    clang-20
x86_64                randconfig-012-20251108    gcc-14
x86_64                randconfig-013-20251108    clang-20
x86_64                randconfig-014-20251108    clang-20
x86_64                randconfig-015-20251108    clang-20
x86_64                randconfig-016-20251108    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251108    gcc-8.5.0
xtensa                randconfig-002-20251108    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

