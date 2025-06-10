Return-Path: <cgroups+bounces-8472-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62556AD3972
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8907A849E
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318228A3E0;
	Tue, 10 Jun 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/3lzZNz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C4265287
	for <cgroups@vger.kernel.org>; Tue, 10 Jun 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562653; cv=none; b=kVyJcZOWThZsjNfnECs7W5VvGEiKj8qVLgE6+bof63Gq6PoDlXtAMgVUK/zqv1snkPvq9B9FkJH3WSoIsthcI+Xx3SBNwhsT++6wqh6G9WFW0cxQUvVOgxuhWub1S6SdIFPCMjmGMCC/tHiglnm/VOkugey7IWkNvmW2Dq9LAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562653; c=relaxed/simple;
	bh=KiFZF+bkMrZ+TOT4+utg2O3apJlbQtvcVEugUnlMtzA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Yw3G7ZT1Bz/K9xGe+n7X0ric1Oc5cowu12wB1vH3o4n7465267VlswlGUJN5qJtGEZO8lkMb1MWpvUUeduLMasgGpgm9/+ikHK1uhHFZ0609SpSQK9SXIam3wkKAueOFxMU3hykuVqKUaJvrmYuIe48+bcYwgQVEnvtBgeI5xmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/3lzZNz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749562652; x=1781098652;
  h=date:from:to:cc:subject:message-id;
  bh=KiFZF+bkMrZ+TOT4+utg2O3apJlbQtvcVEugUnlMtzA=;
  b=e/3lzZNzeau/2q5Yc4r5ba72ke/No35P/1KSTWzkRED2dJ0M3tLx2w12
   zKDyTVFQ1o2GenOf08R0fhV0+ewp2nxCTxsQrELRxlPkdC1GdQdWMdXS3
   xS/P/9BdKk3jRtZqOmWg2rnMrdRRjl+Pc7cwdgV0UwO9vxMsdZPu0pmNr
   exaAFvapEDMK3b6j4Dl81Bo+XaqUbPFK1L0NvEmDXcO0m/kmg7oxm49on
   WjSIzX3IBul66XlFF8glsCujeTW6lbXWNRizPMsos8h8aEpDFS16ei5tX
   UCTXmHKjnEX90vIO1cElA6rvUfuhEz2z6LNTIKQEbIZEAS+d543DGkB9R
   g==;
X-CSE-ConnectionGUID: FXrgKJKqQgeEMhbaQdQgKQ==
X-CSE-MsgGUID: WmHQ8rAMSPO4X1F1e5/lJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51380480"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51380480"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:37:14 -0700
X-CSE-ConnectionGUID: JizW3P7iTbeI4i+3+enErA==
X-CSE-MsgGUID: lUNdET5NSNOir+C21PgWqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="177778480"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jun 2025 06:37:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOzA6-0008HO-1l;
	Tue, 10 Jun 2025 13:37:10 +0000
Date: Tue, 10 Jun 2025 21:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 1486a0d1733a4b5d003d99b695916c9859add36a
Message-ID: <202506102126.AcAh0LDs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 1486a0d1733a4b5d003d99b695916c9859add36a  Merge branch 'for-6.17' into for-next

elapsed time: 1138m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250610    gcc-12.4.0
arc                   randconfig-002-20250610    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250610    clang-19
arm                   randconfig-002-20250610    gcc-8.5.0
arm                   randconfig-003-20250610    clang-21
arm                   randconfig-004-20250610    clang-16
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250610    clang-21
arm64                 randconfig-002-20250610    gcc-11.5.0
arm64                 randconfig-003-20250610    clang-21
arm64                 randconfig-004-20250610    clang-18
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250610    gcc-12.4.0
csky                  randconfig-002-20250610    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250610    clang-21
hexagon               randconfig-002-20250610    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250610    clang-20
i386        buildonly-randconfig-002-20250610    clang-20
i386        buildonly-randconfig-003-20250610    clang-20
i386        buildonly-randconfig-004-20250610    gcc-12
i386        buildonly-randconfig-005-20250610    clang-20
i386        buildonly-randconfig-006-20250610    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250610    gcc-15.1.0
loongarch             randconfig-002-20250610    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-21
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250610    gcc-8.5.0
nios2                 randconfig-002-20250610    gcc-13.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250610    gcc-10.5.0
parisc                randconfig-002-20250610    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                     mpc512x_defconfig    clang-21
powerpc               randconfig-001-20250610    gcc-10.5.0
powerpc               randconfig-002-20250610    gcc-8.5.0
powerpc               randconfig-003-20250610    clang-21
powerpc64             randconfig-001-20250610    clang-21
powerpc64             randconfig-002-20250610    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250610    gcc-14.3.0
riscv                 randconfig-002-20250610    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250610    gcc-8.5.0
s390                  randconfig-002-20250610    gcc-14.3.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250610    gcc-9.3.0
sh                    randconfig-002-20250610    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250610    gcc-15.1.0
sparc                 randconfig-002-20250610    gcc-12.4.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250610    gcc-8.5.0
sparc64               randconfig-002-20250610    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250610    gcc-11
um                    randconfig-002-20250610    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250610    clang-20
x86_64      buildonly-randconfig-002-20250610    gcc-12
x86_64      buildonly-randconfig-003-20250610    clang-20
x86_64      buildonly-randconfig-004-20250610    clang-20
x86_64      buildonly-randconfig-005-20250610    gcc-12
x86_64      buildonly-randconfig-006-20250610    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250610    gcc-11.5.0
xtensa                randconfig-002-20250610    gcc-12.4.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

