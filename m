Return-Path: <cgroups+bounces-10269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE1B86D6F
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 22:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4543456505E
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 20:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254031A814;
	Thu, 18 Sep 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8mBKWvi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC131A810
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226138; cv=none; b=TUqzX0TE2p9qIQvcLlgSnGm48LIbrOXnaZiU43drFsTjqVjR++DEtdY3HFv2hysEy0f1sgMddOzLJP5/BWVSvIGJIRg0DlNfxpDJCm3J6i7e7lBOXYxcY5qwAPXNPHijPeDsKaXEQ3Y7Hlcj9Q1TLdb1E5EWeIhnohNWCQyqSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226138; c=relaxed/simple;
	bh=gcQE+Cq48l9zsVQ/c0h6NFRG9zUXH/mhj3+fxYyWI/M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W7UI0UJiA8lvW3Ixl6y+QEwmewXwmx6Urn9b1tx6l6yiDmsmrmsNqzqkUZCrxOwkJb5n+2/0ZO42SlWb9URBv5XDX48Yge+9oEwKb+OyUhPLIuzDm67w0NV7PW32KIwmvhOepe2snClptBxiQ6d3BTj/8pzFybwmVtvQ+JANK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8mBKWvi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758226136; x=1789762136;
  h=date:from:to:cc:subject:message-id;
  bh=gcQE+Cq48l9zsVQ/c0h6NFRG9zUXH/mhj3+fxYyWI/M=;
  b=j8mBKWviiJ5Wirqyu4Q6gS7GXa7Z2zKK0dUPmZnItBgnWUbjIFKyOZwy
   51Pm7IYX2b2SRIdO/CP3ptuSAO2ii7ezfhE+aMLSzxWm4IqLqX7JFw3Nn
   0ut4G/qgcJCPww51rK2Lnq+FerW/Zgup7Jkvp7x3xfQVKvStDLTX8pMsU
   D7NDiYdO04LtraZowuF5UlfYLopgix29gkBo3gZIu/DhzQbt0Tau6pcwL
   OHX5Kmb1UlGvC8eGxzj0UXTvzZKhE8u3xCmv9OYYEU/p9wV8dwmbfaFnO
   tUOhbIQcaXB9G8kyCtC7kIYCm0PGqsAE1WOAloyAgqi7NpeniNHgpPloA
   A==;
X-CSE-ConnectionGUID: 5JDqg1PCR46j9NAlzZuc8g==
X-CSE-MsgGUID: MlTpB0GFR6a+Be1XDiT1sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71203582"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="71203582"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 13:08:55 -0700
X-CSE-ConnectionGUID: /lXsmp5RQ0KO42y6O2g1Gw==
X-CSE-MsgGUID: oDAlmH8mSoyGVrthegQPyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="176052000"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2025 13:08:53 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzKvz-0003gN-1I;
	Thu, 18 Sep 2025 20:08:51 +0000
Date: Fri, 19 Sep 2025 04:08:35 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 1f783f733450f72725c0040a2b3075614fa0fb5c
Message-ID: <202509190429.ynO8HeRO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 1f783f733450f72725c0040a2b3075614fa0fb5c  Merge branch 'for-6.18' into for-next

elapsed time: 1451m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-002-20250918    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                          ep93xx_defconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-002-20250918    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250918    clang-22
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-002-20250918    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-002-20250918    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-002-20250918    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-003-20250918    clang-19
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-003-20250918    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-002-20250918    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-002-20250918    clang-18
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

