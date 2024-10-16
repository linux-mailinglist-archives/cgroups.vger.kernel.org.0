Return-Path: <cgroups+bounces-5138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9299A0036
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 06:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB881C20B85
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49380187350;
	Wed, 16 Oct 2024 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHvMao6H"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882C17CA1D
	for <cgroups@vger.kernel.org>; Wed, 16 Oct 2024 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052984; cv=none; b=F0ImQkoc6y3o+/ZTRFf2+9nzyKae9tKtcMZiLDhWwyyAoA1GnbhVghfYPkbPMB4N4z7tXWw2f4AbkCpJzzKBNGlG677oTfO40wvQHM6svqDmbfz0c2kLcnFI2JdWdbBy2k1PNtI5uMtwqhkHYmMIvcpi37/5ANVVuBQHIcStiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052984; c=relaxed/simple;
	bh=6UUG1xubusN9hHNTJjf+Fqusz48oDtbRvHHqG3zNxlM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sV5rpa6vf4k3skRKmTH9SlOaQ0UjOCJp5yAbtWxxnsda6gEzYxn12MhauWkw7uT2eWbNOsqI4IpSQv5SFdYGfb6iSNO9b0CvAMdubN0tnV4xeTuK5yzCYuiEGGjut3k5yvlOaUA5YlIZW0vimrY1LvyExXetbKkPpbRyaN1Dun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHvMao6H; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729052983; x=1760588983;
  h=date:from:to:cc:subject:message-id;
  bh=6UUG1xubusN9hHNTJjf+Fqusz48oDtbRvHHqG3zNxlM=;
  b=FHvMao6HQ/h9SRpjxZ4PfpJBY4rflNzbXmfcDpME7F2LQW4qDFozsJz7
   GdHfGoMsmsE4+ivHQniPoQ++Crlqh2WlMSekRbbTcqz+L+kQaEpwpxr95
   s60+JUjZ6uDg+lUel1xLTuvejF1fbdKrcgfGIFIQ1p0QyIcsZ0Tz/FmG3
   9d7QvwkBC5W9zAZMLdllSB7IgqwwtytdlLQRLT+5Pixs4kN+Lc7GOUPTn
   0bt0wXoS8EtfK0xJQlPAKn6jxPAD5REhIyco4uzRYyZOeqEre/A1ETr36
   BYaWxGy0rd/yZbxuaymAY9Aoz3xrx3XJ8HPh51jb3+Ow96RJR7AQhBvDb
   w==;
X-CSE-ConnectionGUID: 3uT/0DDLRlOCTOVjL8SVUw==
X-CSE-MsgGUID: aV3qNNbdTzGpfZpF3uzFeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32283500"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="32283500"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 21:29:42 -0700
X-CSE-ConnectionGUID: E0XCXFZGRGCMkB79jFbz1Q==
X-CSE-MsgGUID: J+OFBkrET4uitoWENlcq8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78118090"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2024 21:29:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0vfG-000KIp-1F;
	Wed, 16 Oct 2024 04:29:38 +0000
Date: Wed, 16 Oct 2024 12:29:37 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.12-fixes] BUILD SUCCESS
 3cc4e13bb1617f6a13e5e6882465984148743cf4
Message-ID: <202410161225.HnlQ1VjU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.12-fixes
branch HEAD: 3cc4e13bb1617f6a13e5e6882465984148743cf4  cgroup: Fix potential overflow issue when checking max_depth

elapsed time: 1673m

configs tested: 131
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    clang-15
arc                        vdk_hs38_defconfig    clang-15
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     am200epdkit_defconfig    clang-15
arm                         bcm2835_defconfig    clang-15
arm                                 defconfig    gcc-14.1.0
arm                            hisi_defconfig    clang-15
arm                          sp7021_defconfig    clang-15
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             alldefconfig    clang-15
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
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    clang-15
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     kmeter1_defconfig    clang-15
powerpc                      pcm030_defconfig    clang-15
powerpc                     ppa8548_defconfig    clang-15
powerpc                      ppc44x_defconfig    clang-15
powerpc                         ps3_defconfig    clang-15
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          urquell_defconfig    clang-15
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

