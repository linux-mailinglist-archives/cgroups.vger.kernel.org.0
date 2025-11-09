Return-Path: <cgroups+bounces-11685-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD26C436AF
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 01:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B800D4E21C1
	for <lists+cgroups@lfdr.de>; Sun,  9 Nov 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA3A944;
	Sun,  9 Nov 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kkkf/Y9x"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83A34D39D
	for <cgroups@vger.kernel.org>; Sun,  9 Nov 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647191; cv=none; b=RB190G1JkvNy25lSwuhKNnXVjtONerP313MaGW6K3zDFImYwBfe2k2chlJtJYWjYMBVLbNnO9scUUtjglqo+hH3Q7KebXcIAH1rIxIcQbu406AGnb2uRwqHjHnJT6sdryerBqcT3S5FZymgNHlyWLZi4YNzQkSyoG/cC7W2/Drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647191; c=relaxed/simple;
	bh=AjrUpiM0cxC0nC6tIFYakZhVW7ERdmmO56vhVTtepk8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JWPjKy84RrbKabDUGXdJTrpOU5l3mXOR5TKk0Di81sgHZLZM56wMUHbtzLxP7Nj/LNhLIezGpn0Ok0sW79c4xBWdsLvdfa/5SLdUUmV0AmTyWo0Qs2E6v/UVEF7A3bt3/JpKTczzG38qaHZGdRjq9gk2Rpj6XsDlruFXaIW8XjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kkkf/Y9x; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762647189; x=1794183189;
  h=date:from:to:cc:subject:message-id;
  bh=AjrUpiM0cxC0nC6tIFYakZhVW7ERdmmO56vhVTtepk8=;
  b=Kkkf/Y9xC1peCa1b0vasZW3i5fjsG7IE4B3KWVYg2SAJpOZhIu3Z3+wK
   1db8UJQRGxROLEqEklfEVvbC37freToK6RIL6Fk61iZ3TqVJBaD+JjKys
   Pzc7DbPGF0xJpI3Gm02bXkGOBOFR4RC5YayXd683ybaluZURFhP5tpoPi
   4sOjOF4CXyDJ/CY6Xp9yeuabh1u4Mtl6oImnLkkd1v9BbUCPs2MBVIUfZ
   vkmTeCj8G4/PUn15wnIMQW/Nq0GLvoFi8T8O3/+2bXOOgXbVsvRoIoF4e
   b3k0w9IlOX/o4tm51l2UcH6FLrAbRjUFrbSDKOM84PouQiVZy+h8tXYO2
   Q==;
X-CSE-ConnectionGUID: JKzLBnfURYaIpFUh3eiRXA==
X-CSE-MsgGUID: kscOGHpcTk6XjUoul/xWrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64842002"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="64842002"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 16:13:07 -0800
X-CSE-ConnectionGUID: cjDiF9wIQXmEJUVqZtzwuw==
X-CSE-MsgGUID: MpMuAFyqRmq/Ww4HXBVXJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="188090158"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2025 16:13:06 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHt3H-0001bT-05;
	Sun, 09 Nov 2025 00:13:03 +0000
Date: Sun, 09 Nov 2025 08:12:42 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 0177641333d8fff16903771a4d0055711a48b9a6
Message-ID: <202511090837.TWvIA2sj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 0177641333d8fff16903771a4d0055711a48b9a6  Merge branch 'for-6.19' into for-next

elapsed time: 2908m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                    allmodconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    gcc-15.1.0
arm                    allmodconfig    gcc-15.1.0
arm                     allnoconfig    clang-22
arm                    allyesconfig    gcc-15.1.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc               allyesconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
parisc      randconfig-001-20251107    gcc-8.5.0
parisc      randconfig-002-20251107    gcc-12.5.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc                allyesconfig    clang-22
powerpc     randconfig-001-20251107    clang-22
powerpc     randconfig-002-20251107    clang-22
powerpc64   randconfig-001-20251107    gcc-14.3.0
powerpc64   randconfig-002-20251107    clang-22
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20251107    clang-22
riscv       randconfig-002-20251107    gcc-13.4.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251107    gcc-8.5.0
s390        randconfig-002-20251107    gcc-15.1.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251107    gcc-13.4.0
sh          randconfig-002-20251107    gcc-11.5.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                  allnoconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

