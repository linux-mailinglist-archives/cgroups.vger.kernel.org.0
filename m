Return-Path: <cgroups+bounces-10884-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94580BED3C3
	for <lists+cgroups@lfdr.de>; Sat, 18 Oct 2025 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 930524E9210
	for <lists+cgroups@lfdr.de>; Sat, 18 Oct 2025 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5F1DE8B5;
	Sat, 18 Oct 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRHanJT0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A061D9A54
	for <cgroups@vger.kernel.org>; Sat, 18 Oct 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804281; cv=none; b=LUdXLiT/zQA7vkda++BzdyORVEVQhjIGhqA+I+dKzJL4v/brxhwULLEkODBwDx/trAKzURPzC+0dbsUCUecL29kO3Y4v1XZu8g9NHGbWRpXiQaYDNd9qUQ2vc8p1nKZ3tkOYYfTjN1hDOzGIj/PAvXctVbzd5Tw04PwPvv0NInE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804281; c=relaxed/simple;
	bh=SRp74u0g07eM6KVePbDNDN3ohROzTo/LA+N8cOzmLM0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VyRZ/IZ+jzsxf5Zx9OU6TgycBq3lseyGbu9MbQQ3UuNT0h+JaO87F+Rej9AKIL+YGb7r3Qn2qlaVcfFDoydQffzFkLMi0mgWAeZ6tJ6QvpZknI99ahYydqV9s3AgOfOuT3ZZG98DYoCfZ44uXeOjrUjHMvfv474nwISm903Ax0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRHanJT0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760804279; x=1792340279;
  h=date:from:to:cc:subject:message-id;
  bh=SRp74u0g07eM6KVePbDNDN3ohROzTo/LA+N8cOzmLM0=;
  b=fRHanJT0MIZEqN6/eUgJ8Cws36LLp7KhOtH5dsWyyF7xJVShGhoItzSt
   zIv8smuB0t2T/1TttAiQnpPVH49cawfroDtyhnlQrDtJr6BZLkuNJ8Evo
   JBYAlpPmCSDmFZ1/ufDJBGlg3wEmcakt69IU79iOA8JFt3HAnGF9ynaYU
   UInasri/txQjYQeHpAAM8PFgxv1pJik2DrlwlCtlvMrdQyjX9I5gadUoK
   yZ7abrGJWejt4WpCvE8YeYG0PP0jfzaUlF3mfSGmgFD8vlJXitVdoKJzT
   UAtsCJCdMOl0EYREW7vfA3/FD+ltQoF4lIMLI9VeAzGKtmhv+RBJnHt0t
   Q==;
X-CSE-ConnectionGUID: PuRTlHm2S967gHS8U8P6HA==
X-CSE-MsgGUID: 4Jnu47xFTziWSR0aRhuU7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85614367"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="85614367"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 09:17:59 -0700
X-CSE-ConnectionGUID: /hHWuc+GRyGJOnB3YDHt+Q==
X-CSE-MsgGUID: uwWCwAvURAyu4RXW8T4E8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183465708"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Oct 2025 09:17:57 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA9cx-0008Od-2W;
	Sat, 18 Oct 2025 16:17:55 +0000
Date: Sun, 19 Oct 2025 00:17:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 0fbbcab7f9082cdc233da5e5e353f69830f11956
Message-ID: <202510190033.lpC23gID-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 0fbbcab7f9082cdc233da5e5e353f69830f11956  cgroup/misc: fix misc_res_type kernel-doc warning

elapsed time: 1446m

configs tested: 159
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                        nsimosci_defconfig    clang-22
arc                   randconfig-001-20251018    clang-22
arc                   randconfig-001-20251018    gcc-12.5.0
arc                   randconfig-002-20251018    clang-22
arc                   randconfig-002-20251018    gcc-8.5.0
arm                              alldefconfig    clang-22
arm                               allnoconfig    clang-22
arm                       aspeed_g4_defconfig    clang-22
arm                   randconfig-001-20251018    clang-19
arm                   randconfig-001-20251018    clang-22
arm                   randconfig-002-20251018    clang-20
arm                   randconfig-002-20251018    clang-22
arm                   randconfig-003-20251018    clang-22
arm                   randconfig-004-20251018    clang-22
arm                   randconfig-004-20251018    gcc-15.1.0
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251018    clang-22
arm64                 randconfig-001-20251018    gcc-8.5.0
arm64                 randconfig-002-20251018    clang-22
arm64                 randconfig-003-20251018    clang-22
arm64                 randconfig-003-20251018    gcc-13.4.0
arm64                 randconfig-004-20251018    clang-22
arm64                 randconfig-004-20251018    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251018    gcc-12.5.0
csky                  randconfig-001-20251018    gcc-9.5.0
csky                  randconfig-002-20251018    gcc-12.5.0
csky                  randconfig-002-20251018    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251018    clang-22
hexagon               randconfig-001-20251018    gcc-12.5.0
hexagon               randconfig-002-20251018    clang-22
hexagon               randconfig-002-20251018    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251018    clang-20
i386        buildonly-randconfig-001-20251018    gcc-14
i386        buildonly-randconfig-002-20251018    clang-20
i386        buildonly-randconfig-002-20251018    gcc-14
i386        buildonly-randconfig-003-20251018    clang-20
i386        buildonly-randconfig-004-20251018    clang-20
i386        buildonly-randconfig-004-20251018    gcc-14
i386        buildonly-randconfig-005-20251018    clang-20
i386        buildonly-randconfig-006-20251018    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251018    gcc-14
i386                  randconfig-002-20251018    gcc-14
i386                  randconfig-003-20251018    gcc-14
i386                  randconfig-004-20251018    gcc-14
i386                  randconfig-005-20251018    gcc-14
i386                  randconfig-006-20251018    gcc-14
i386                  randconfig-007-20251018    gcc-14
i386                  randconfig-011-20251018    clang-20
i386                  randconfig-012-20251018    clang-20
i386                  randconfig-013-20251018    clang-20
i386                  randconfig-014-20251018    clang-20
i386                  randconfig-015-20251018    clang-20
i386                  randconfig-016-20251018    clang-20
i386                  randconfig-017-20251018    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251018    clang-22
loongarch             randconfig-001-20251018    gcc-12.5.0
loongarch             randconfig-002-20251018    gcc-12.5.0
loongarch             randconfig-002-20251018    gcc-13.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251018    gcc-11.5.0
nios2                 randconfig-001-20251018    gcc-12.5.0
nios2                 randconfig-002-20251018    gcc-12.5.0
nios2                 randconfig-002-20251018    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251018    gcc-10.5.0
parisc                randconfig-001-20251018    gcc-12.5.0
parisc                randconfig-002-20251018    gcc-12.5.0
parisc                randconfig-002-20251018    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       holly_defconfig    clang-22
powerpc               randconfig-001-20251018    clang-22
powerpc               randconfig-001-20251018    gcc-12.5.0
powerpc               randconfig-002-20251018    clang-22
powerpc               randconfig-002-20251018    gcc-12.5.0
powerpc               randconfig-003-20251018    gcc-12.5.0
powerpc               randconfig-003-20251018    gcc-14.3.0
powerpc                     tqm8555_defconfig    clang-22
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20251018    gcc-10.5.0
powerpc64             randconfig-001-20251018    gcc-12.5.0
powerpc64             randconfig-002-20251018    gcc-12.5.0
powerpc64             randconfig-003-20251018    clang-22
powerpc64             randconfig-003-20251018    gcc-12.5.0
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251018    clang-20
x86_64      buildonly-randconfig-001-20251018    gcc-14
x86_64      buildonly-randconfig-002-20251018    clang-20
x86_64      buildonly-randconfig-002-20251018    gcc-14
x86_64      buildonly-randconfig-003-20251018    clang-20
x86_64      buildonly-randconfig-003-20251018    gcc-14
x86_64      buildonly-randconfig-004-20251018    clang-20
x86_64      buildonly-randconfig-004-20251018    gcc-14
x86_64      buildonly-randconfig-005-20251018    clang-20
x86_64      buildonly-randconfig-005-20251018    gcc-14
x86_64      buildonly-randconfig-006-20251018    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251018    clang-20
x86_64                randconfig-072-20251018    clang-20
x86_64                randconfig-073-20251018    clang-20
x86_64                randconfig-074-20251018    clang-20
x86_64                randconfig-075-20251018    clang-20
x86_64                randconfig-076-20251018    clang-20
x86_64                randconfig-077-20251018    clang-20
x86_64                randconfig-078-20251018    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

