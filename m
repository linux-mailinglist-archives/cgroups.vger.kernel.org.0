Return-Path: <cgroups+bounces-12534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C1CD1A7E
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 20:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 407BD302E1FB
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BBA33B6F9;
	Fri, 19 Dec 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFWcM85F"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363732AAC4
	for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172976; cv=none; b=oj5FjFZyDO8T4/vGjdRr6NB+FDJN4XWCsTXe4UlYBOZhLA9YvWqk+d3rDP0DN7WbLUBLoVUtRtjZWEhrr4XdesUBWpijA9lE/diRPu3sePEfGCfBGqzdvDfscbW92FtZR4eggwWSJyPBjd0HLUWhASTwZS/uOWz1LfYTPKxZKIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172976; c=relaxed/simple;
	bh=kxeerlFxoPp1DaQNuOX0bv6UPRLcLrRyJVMn9Az0VQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hPQQ1MPE2J6P22D9BBtRoTJNrpAYCBCb/U6ECBY5k3bn9IaZfeM7E/QkMN9sdjJytlTVwhsNfnei6YBDxDeMKA/DI1JUywS3QflSGT4Oq5OTwAZHYF0/Np/oQ/vt2gosTOegJVVLlHZd7ScsDI6OIbj5yxhtl8N+1KhxkaTnNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFWcM85F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766172975; x=1797708975;
  h=date:from:to:cc:subject:message-id;
  bh=kxeerlFxoPp1DaQNuOX0bv6UPRLcLrRyJVMn9Az0VQA=;
  b=hFWcM85F+d0sviMvtCfu0zbB0BRw1utFASGB5YQu4o5fNBQCZHPpwVQB
   nlzDF+R0aCx/cbSMqbBdH5QomcpULaCkMcO5OJbhG+BaBzNG4HXpa6kGx
   hIXH6UKQsFZhaoBiqPmHno+OPZqwySXRJr38F+YP5JMAKbaMh2TTI9qAp
   4wwt+AE018PiN13ezQ1bqvv4fzT1eBecQhoy++6tagtDoPyE3cJSfie3U
   6UmQVGqU8rGokgn4LBkhmiTzqBvYHc0YFXX6Ou+3dOrfFnAoe1JqvCG3O
   4/9YSCY5hlHo1xNzQcbS7mHZ5s0/Rxk096W7cKPf2rIWI4HXKd2hWbLfH
   g==;
X-CSE-ConnectionGUID: SUWLArG+RlyylPwRxcg6IA==
X-CSE-MsgGUID: LwB/OBiIRyyGCvHfaZYr0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67133138"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="67133138"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 11:36:14 -0800
X-CSE-ConnectionGUID: hb1LZcSsTD+nDhH7G02OzA==
X-CSE-MsgGUID: YZESVQTyTE63iGrsNckmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198092679"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Dec 2025 11:36:13 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWgGn-000000003w1-3AwU;
	Fri, 19 Dec 2025 19:36:09 +0000
Date: Sat, 20 Dec 2025 03:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 e02fe7ba29a2fa599885c72cb977aaaaccbfe80d
Message-ID: <202512200337.G6MovO9l-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: e02fe7ba29a2fa599885c72cb977aaaaccbfe80d  Merge branch 'for-6.20' into for-next

elapsed time: 1477m

configs tested: 173
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251219    gcc-11.5.0
arc                   randconfig-002-20251219    gcc-11.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251219    gcc-11.5.0
arm                   randconfig-002-20251219    gcc-11.5.0
arm                   randconfig-003-20251219    gcc-11.5.0
arm                   randconfig-004-20251219    gcc-11.5.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251219    gcc-9.5.0
arm64                 randconfig-002-20251219    gcc-9.5.0
arm64                 randconfig-003-20251219    gcc-9.5.0
arm64                 randconfig-004-20251219    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251219    gcc-9.5.0
csky                  randconfig-002-20251219    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251219    gcc-11.5.0
hexagon               randconfig-002-20251219    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251219    clang-20
i386        buildonly-randconfig-002-20251219    clang-20
i386        buildonly-randconfig-003-20251219    clang-20
i386        buildonly-randconfig-004-20251219    clang-20
i386        buildonly-randconfig-005-20251219    clang-20
i386        buildonly-randconfig-006-20251219    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251219    clang-20
i386                  randconfig-002-20251219    clang-20
i386                  randconfig-003-20251219    clang-20
i386                  randconfig-004-20251219    clang-20
i386                  randconfig-005-20251219    clang-20
i386                  randconfig-006-20251219    clang-20
i386                  randconfig-007-20251219    clang-20
i386                  randconfig-011-20251219    gcc-14
i386                  randconfig-012-20251219    gcc-14
i386                  randconfig-013-20251219    gcc-14
i386                  randconfig-014-20251219    gcc-14
i386                  randconfig-015-20251219    gcc-14
i386                  randconfig-016-20251219    gcc-14
i386                  randconfig-017-20251219    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251219    gcc-11.5.0
loongarch             randconfig-002-20251219    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                          multi_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251219    gcc-11.5.0
nios2                 randconfig-002-20251219    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251219    clang-22
parisc                randconfig-002-20251219    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251219    clang-22
powerpc               randconfig-002-20251219    clang-22
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251219    clang-22
powerpc64             randconfig-002-20251219    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251219    clang-22
riscv                 randconfig-002-20251219    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251219    clang-22
s390                  randconfig-002-20251219    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251219    clang-22
sh                    randconfig-002-20251219    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251219    gcc-8.5.0
sparc                 randconfig-002-20251219    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251219    gcc-8.5.0
sparc64               randconfig-002-20251219    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251219    gcc-8.5.0
um                    randconfig-002-20251219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251219    clang-20
x86_64      buildonly-randconfig-002-20251219    clang-20
x86_64      buildonly-randconfig-003-20251219    clang-20
x86_64      buildonly-randconfig-004-20251219    clang-20
x86_64      buildonly-randconfig-005-20251219    clang-20
x86_64      buildonly-randconfig-006-20251219    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251219    gcc-14
x86_64                randconfig-002-20251219    gcc-14
x86_64                randconfig-003-20251219    gcc-14
x86_64                randconfig-004-20251219    gcc-14
x86_64                randconfig-005-20251219    gcc-14
x86_64                randconfig-006-20251219    gcc-14
x86_64                randconfig-011-20251219    clang-20
x86_64                randconfig-012-20251219    clang-20
x86_64                randconfig-013-20251219    clang-20
x86_64                randconfig-014-20251219    clang-20
x86_64                randconfig-015-20251219    clang-20
x86_64                randconfig-016-20251219    clang-20
x86_64                randconfig-071-20251219    gcc-14
x86_64                randconfig-072-20251219    gcc-14
x86_64                randconfig-073-20251219    gcc-14
x86_64                randconfig-074-20251219    gcc-14
x86_64                randconfig-075-20251219    gcc-14
x86_64                randconfig-076-20251219    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251219    gcc-8.5.0
xtensa                randconfig-002-20251219    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

