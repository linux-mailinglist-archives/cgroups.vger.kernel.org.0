Return-Path: <cgroups+bounces-9998-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D4B53B14
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 20:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C26DAA5386
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CEF35FC1A;
	Thu, 11 Sep 2025 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq066K8q"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74B2AD0C
	for <cgroups@vger.kernel.org>; Thu, 11 Sep 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614331; cv=none; b=sGMt/bf1lH+1ve5Kr7+PU+fBkw0EaEHqwW0erdz6Sh/t4NbtA3tMT7HzkfQhYL6TWyQra5UlSgWfmWRMPIl8CmBs5BbPM7R6S40HyhWLfUx4MfUjV3DQtvLsev6T9DgOH+0I4RU+dz/lA8ubhAgDVk66p89S1xy4ifwLNhKnclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614331; c=relaxed/simple;
	bh=GyYV/SbAuhJIFA5bqHswt4PvYdmwir2LapWl3sqRRQw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LBzdFAG6e6Jxx9kcs7E/oWcwhDslkxLnRfDr3UX7y0t/FB4wQOKs/h5dE/Qy8LVMsswA/rsknpv2qYM9vIGkSx9BVWWPyKgRgJlYbGtqBf/ejw3p+pkJgsndc0/+/xOjyHSkvmE8l2mtryy15UFX3ZBK8VKOoOIyKsd5sHXfvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq066K8q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757614329; x=1789150329;
  h=date:from:to:cc:subject:message-id;
  bh=GyYV/SbAuhJIFA5bqHswt4PvYdmwir2LapWl3sqRRQw=;
  b=jq066K8q8K3ErGNgIA8J+H/SEmjwoNtXCv1LxU4SiAkdtl+5DODCy/18
   cIIB9/MaE3++fkHt/Pf1qlxuBiaejO76jcjpx0IH0u6fDhrBp0UHd12+q
   meafTgoQHc8Tf1GN/aRp4s8x8mGsj0YVLK2XqSaM3oDSRxRungtU0MF8j
   TC012GG0t/keNFRg68PqgRRFZq2hEPeacCeaqIvtgVpUuxhxS522rgfaW
   ek2mYOH1ddfZji7xiRVg44MtP+/FIIMAjF7tMMQcbOBC6ncxKOz/nUZoi
   MouUqJnPKUF6nnSx1z4RXw2I1QztfFYd34vFItrrzdsKzzLF+mXf1Ajca
   A==;
X-CSE-ConnectionGUID: HEFUveKuQE+p6z3vGt6png==
X-CSE-MsgGUID: 1+axWT8WQemfr9Fd0Ht9Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="47527636"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="47527636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:12:09 -0700
X-CSE-ConnectionGUID: LCCtpVAcTwqlVrYi+nxeBA==
X-CSE-MsgGUID: +k7hG8z4TT+x+w+rw+Zz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="178968627"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 11 Sep 2025 11:12:07 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwlm9-0000YI-1b;
	Thu, 11 Sep 2025 18:12:05 +0000
Date: Fri, 12 Sep 2025 02:11:22 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.18] BUILD SUCCESS
 0568f89d4fb82d98001baeb870e92f43cd1f7317
Message-ID: <202509120213.e35EnPvp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18
branch HEAD: 0568f89d4fb82d98001baeb870e92f43cd1f7317  cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs

elapsed time: 1453m

configs tested: 193
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              alldefconfig    clang-22
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250911    clang-22
arc                   randconfig-001-20250911    gcc-8.5.0
arc                   randconfig-002-20250911    clang-22
arc                   randconfig-002-20250911    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-22
arm                   randconfig-001-20250911    clang-22
arm                   randconfig-002-20250911    clang-22
arm                   randconfig-002-20250911    gcc-14.3.0
arm                   randconfig-003-20250911    clang-22
arm                   randconfig-004-20250911    clang-16
arm                   randconfig-004-20250911    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250911    clang-22
arm64                 randconfig-001-20250911    gcc-13.4.0
arm64                 randconfig-002-20250911    clang-22
arm64                 randconfig-002-20250911    gcc-8.5.0
arm64                 randconfig-003-20250911    clang-22
arm64                 randconfig-003-20250911    gcc-8.5.0
arm64                 randconfig-004-20250911    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250911    clang-20
csky                  randconfig-001-20250911    gcc-15.1.0
csky                  randconfig-002-20250911    clang-20
csky                  randconfig-002-20250911    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250911    clang-20
hexagon               randconfig-002-20250911    clang-20
hexagon               randconfig-002-20250911    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250911    clang-20
i386        buildonly-randconfig-002-20250911    clang-20
i386        buildonly-randconfig-003-20250911    clang-20
i386        buildonly-randconfig-004-20250911    clang-20
i386        buildonly-randconfig-005-20250911    clang-20
i386        buildonly-randconfig-006-20250911    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250911    clang-20
i386                  randconfig-002-20250911    clang-20
i386                  randconfig-003-20250911    clang-20
i386                  randconfig-004-20250911    clang-20
i386                  randconfig-005-20250911    clang-20
i386                  randconfig-006-20250911    clang-20
i386                  randconfig-007-20250911    clang-20
i386                  randconfig-011-20250911    clang-20
i386                  randconfig-012-20250911    clang-20
i386                  randconfig-013-20250911    clang-20
i386                  randconfig-014-20250911    clang-20
i386                  randconfig-015-20250911    clang-20
i386                  randconfig-016-20250911    clang-20
i386                  randconfig-017-20250911    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250911    clang-20
loongarch             randconfig-001-20250911    gcc-15.1.0
loongarch             randconfig-002-20250911    clang-20
loongarch             randconfig-002-20250911    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250911    clang-20
nios2                 randconfig-001-20250911    gcc-11.5.0
nios2                 randconfig-002-20250911    clang-20
nios2                 randconfig-002-20250911    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250911    clang-20
parisc                randconfig-001-20250911    gcc-8.5.0
parisc                randconfig-002-20250911    clang-20
parisc                randconfig-002-20250911    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       eiger_defconfig    clang-22
powerpc                      ppc6xx_defconfig    clang-22
powerpc               randconfig-001-20250911    clang-20
powerpc               randconfig-001-20250911    gcc-8.5.0
powerpc               randconfig-002-20250911    clang-20
powerpc               randconfig-002-20250911    gcc-15.1.0
powerpc               randconfig-003-20250911    clang-20
powerpc               randconfig-003-20250911    gcc-8.5.0
powerpc64             randconfig-001-20250911    clang-20
powerpc64             randconfig-001-20250911    clang-22
powerpc64             randconfig-002-20250911    clang-20
powerpc64             randconfig-002-20250911    gcc-11.5.0
powerpc64             randconfig-003-20250911    clang-20
powerpc64             randconfig-003-20250911    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250911    clang-20
riscv                 randconfig-001-20250911    gcc-15.1.0
riscv                 randconfig-002-20250911    clang-22
riscv                 randconfig-002-20250911    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250911    gcc-11.5.0
s390                  randconfig-001-20250911    gcc-15.1.0
s390                  randconfig-002-20250911    clang-16
s390                  randconfig-002-20250911    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250911    gcc-15.1.0
sh                    randconfig-001-20250911    gcc-9.5.0
sh                    randconfig-002-20250911    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250911    gcc-15.1.0
sparc                 randconfig-002-20250911    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250911    gcc-15.1.0
sparc64               randconfig-001-20250911    gcc-8.5.0
sparc64               randconfig-002-20250911    clang-20
sparc64               randconfig-002-20250911    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250911    clang-22
um                    randconfig-001-20250911    gcc-15.1.0
um                    randconfig-002-20250911    gcc-14
um                    randconfig-002-20250911    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250911    clang-20
x86_64      buildonly-randconfig-001-20250911    gcc-14
x86_64      buildonly-randconfig-002-20250911    clang-20
x86_64      buildonly-randconfig-002-20250911    gcc-14
x86_64      buildonly-randconfig-003-20250911    clang-20
x86_64      buildonly-randconfig-004-20250911    clang-20
x86_64      buildonly-randconfig-005-20250911    clang-20
x86_64      buildonly-randconfig-006-20250911    clang-20
x86_64      buildonly-randconfig-006-20250911    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20250911    gcc-12.5.0
xtensa                randconfig-001-20250911    gcc-15.1.0
xtensa                randconfig-002-20250911    gcc-15.1.0
xtensa                randconfig-002-20250911    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

