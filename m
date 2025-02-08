Return-Path: <cgroups+bounces-6469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F9A2D7F7
	for <lists+cgroups@lfdr.de>; Sat,  8 Feb 2025 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB626165BAB
	for <lists+cgroups@lfdr.de>; Sat,  8 Feb 2025 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0491F3BAD;
	Sat,  8 Feb 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqMXOBHq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035471F3B81
	for <cgroups@vger.kernel.org>; Sat,  8 Feb 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037821; cv=none; b=dNUwIm9IrARV5KGqywd1P3WE+fnLOPtNaCCK3PMvXDclT2DQeON6vHLVOTZXsiinddheWoqI+1HHLA1CI+mFjDkT9lovud3oOv4Ub/7qS082MqrzK5QMHvhvlqkzcC+L3X47o5csvyySUrgRXef1Zt9q6jltFrD1FNsVLZRKuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037821; c=relaxed/simple;
	bh=urzww2SxkYRtjBX0JZNYyGifnf63DHAZcAF8835B3tI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AY+77hD5gd99hyYV72Jc9T5yf8IYmbkKhPajBWr+JFfy66AeqgOajLZTKjZey34gKH11j2UzaapeHHjv6tqnpbWIDirpX+uIA3T8Le61jzeS7sAUp58M9SZ82tgqAZgqn2D6fhQZ59ZiSQ/GhZcf5feiLVq/NQkMgY3A+IcUH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqMXOBHq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739037820; x=1770573820;
  h=date:from:to:cc:subject:message-id;
  bh=urzww2SxkYRtjBX0JZNYyGifnf63DHAZcAF8835B3tI=;
  b=VqMXOBHqsxTFualNlvJZ07ZQctLmDWz+p7Gvke2JXFHoVhklS+IQUcW0
   5CfI4Ut1QwBNyk6zUL8u1L94iqjjYMNWNgicrR+8q6r3KgQ4De7GeJQsn
   AXAkCsR5WFpXm096dAgdzcIMMvMIiLZ9iArIwvUeRFwg+7kkP2BFDv7wW
   0HxCRB8GIE4tG3LrRYtZeFgjmnoqoxppky6tivJiZSnUBfwunUWioVE7P
   V1xexONXE/ORUEgVhbih6br4Vq8nfx82bAX0C1pcGORr/L305/sdKytDi
   Vjx756dmPYSyWcEkB2bLX6zu2YFTARmwNJ4HIUBAmYd+rD2Pc2pmopTCD
   g==;
X-CSE-ConnectionGUID: dF4Oxni/QgCwuJAJAD66Cw==
X-CSE-MsgGUID: r8EWQ5c9TESKopiuF/n/jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="39817299"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="39817299"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 10:03:39 -0800
X-CSE-ConnectionGUID: 4sGuFzovTzOAO1bXIxSq7w==
X-CSE-MsgGUID: tc8NAN6oTBWgUpDVy5H17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="116818222"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Feb 2025 10:03:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgpB1-0010Sl-2a;
	Sat, 08 Feb 2025 18:03:35 +0000
Date: Sun, 09 Feb 2025 02:03:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.14-fixes] BUILD SUCCESS
 db5fd3cf8bf41b84b577b8ad5234ea95f327c9be
Message-ID: <202502090218.3OOwkouI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.14-fixes
branch HEAD: db5fd3cf8bf41b84b577b8ad5234ea95f327c9be  cgroup: Remove steal time from usage_usec

elapsed time: 1220m

configs tested: 203
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250208    gcc-13.2.0
arc                   randconfig-001-20250209    gcc-13.2.0
arc                   randconfig-002-20250208    gcc-13.2.0
arc                   randconfig-002-20250209    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-21
arm                   randconfig-001-20250208    gcc-13.2.0
arm                   randconfig-001-20250208    gcc-14.2.0
arm                   randconfig-001-20250209    gcc-13.2.0
arm                   randconfig-002-20250208    clang-17
arm                   randconfig-002-20250208    gcc-13.2.0
arm                   randconfig-002-20250209    gcc-13.2.0
arm                   randconfig-003-20250208    clang-21
arm                   randconfig-003-20250208    gcc-13.2.0
arm                   randconfig-003-20250209    gcc-13.2.0
arm                   randconfig-004-20250208    gcc-13.2.0
arm                   randconfig-004-20250208    gcc-14.2.0
arm                   randconfig-004-20250209    gcc-13.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250208    clang-21
arm64                 randconfig-001-20250208    gcc-13.2.0
arm64                 randconfig-001-20250209    gcc-13.2.0
arm64                 randconfig-002-20250208    clang-21
arm64                 randconfig-002-20250208    gcc-13.2.0
arm64                 randconfig-002-20250209    gcc-13.2.0
arm64                 randconfig-003-20250208    clang-21
arm64                 randconfig-003-20250208    gcc-13.2.0
arm64                 randconfig-003-20250209    gcc-13.2.0
arm64                 randconfig-004-20250208    clang-15
arm64                 randconfig-004-20250208    gcc-13.2.0
arm64                 randconfig-004-20250209    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250208    gcc-14.2.0
csky                  randconfig-002-20250208    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250208    clang-21
hexagon               randconfig-002-20250208    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250208    gcc-11
i386        buildonly-randconfig-002-20250208    clang-19
i386        buildonly-randconfig-002-20250208    gcc-11
i386        buildonly-randconfig-003-20250208    gcc-11
i386        buildonly-randconfig-003-20250208    gcc-12
i386        buildonly-randconfig-004-20250208    clang-19
i386        buildonly-randconfig-004-20250208    gcc-11
i386        buildonly-randconfig-005-20250208    clang-19
i386        buildonly-randconfig-005-20250208    gcc-11
i386        buildonly-randconfig-006-20250208    gcc-11
i386        buildonly-randconfig-006-20250208    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250208    clang-19
i386                  randconfig-002-20250208    clang-19
i386                  randconfig-003-20250208    clang-19
i386                  randconfig-004-20250208    clang-19
i386                  randconfig-005-20250208    clang-19
i386                  randconfig-006-20250208    clang-19
i386                  randconfig-007-20250208    clang-19
i386                  randconfig-011-20250208    gcc-12
i386                  randconfig-012-20250208    gcc-12
i386                  randconfig-013-20250208    gcc-12
i386                  randconfig-014-20250208    gcc-12
i386                  randconfig-015-20250208    gcc-12
i386                  randconfig-016-20250208    gcc-12
i386                  randconfig-017-20250208    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250208    gcc-14.2.0
loongarch             randconfig-002-20250208    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250208    gcc-14.2.0
nios2                 randconfig-002-20250208    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250208    gcc-14.2.0
parisc                randconfig-002-20250208    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-21
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250208    clang-19
powerpc               randconfig-002-20250208    clang-17
powerpc               randconfig-003-20250208    gcc-14.2.0
powerpc                     tqm5200_defconfig    clang-21
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-21
powerpc64             randconfig-001-20250208    clang-21
powerpc64             randconfig-002-20250208    gcc-14.2.0
powerpc64             randconfig-003-20250208    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250208    gcc-14.2.0
riscv                 randconfig-002-20250208    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250208    gcc-14.2.0
s390                  randconfig-002-20250208    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250208    gcc-14.2.0
sh                    randconfig-002-20250208    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                          urquell_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250208    gcc-14.2.0
sparc                 randconfig-002-20250208    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250208    gcc-14.2.0
sparc64               randconfig-002-20250208    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250208    gcc-14.2.0
um                    randconfig-002-20250208    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250208    clang-19
x86_64      buildonly-randconfig-002-20250208    clang-19
x86_64      buildonly-randconfig-002-20250208    gcc-12
x86_64      buildonly-randconfig-003-20250208    clang-19
x86_64      buildonly-randconfig-003-20250208    gcc-12
x86_64      buildonly-randconfig-004-20250208    clang-19
x86_64      buildonly-randconfig-005-20250208    clang-19
x86_64      buildonly-randconfig-006-20250208    clang-19
x86_64      buildonly-randconfig-006-20250208    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250208    clang-19
x86_64                randconfig-002-20250208    clang-19
x86_64                randconfig-003-20250208    clang-19
x86_64                randconfig-004-20250208    clang-19
x86_64                randconfig-005-20250208    clang-19
x86_64                randconfig-006-20250208    clang-19
x86_64                randconfig-007-20250208    clang-19
x86_64                randconfig-008-20250208    clang-19
x86_64                randconfig-071-20250208    gcc-12
x86_64                randconfig-072-20250208    gcc-12
x86_64                randconfig-073-20250208    gcc-12
x86_64                randconfig-074-20250208    gcc-12
x86_64                randconfig-075-20250208    gcc-12
x86_64                randconfig-076-20250208    gcc-12
x86_64                randconfig-077-20250208    gcc-12
x86_64                randconfig-078-20250208    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250208    gcc-14.2.0
xtensa                randconfig-002-20250208    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

