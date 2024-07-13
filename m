Return-Path: <cgroups+bounces-3664-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9739305FD
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6121C20F53
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3313959B;
	Sat, 13 Jul 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTRoe1Ng"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22411132114
	for <cgroups@vger.kernel.org>; Sat, 13 Jul 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720881931; cv=none; b=W4qUwsidqlvi/rEMp0cfy0gkwpDqpN/BA2mKOpguEO+T4wI8BstZYcsIaWWXyjRLCWj7Lkzy6XQbpC39FkG395clKT8RUpeqv+t4epSZ/HQsZdTHxBc6ooxO0xDkU2Kg2+2QrUpVqWcqC9QqDuDFEt9e2D1f3bXRVQEHDJZH5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720881931; c=relaxed/simple;
	bh=yaXgbeC6fPlcTzP+Gg3XP2gCeLxWUzGkzc6Ow3UHLJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SPt5NFMRRc3yWrUQwakOMKCrN0m9472eSEvA3LEROvUa2tz9ZmQ71anYRmwSo6A5kI44J5vCfczh67jeMjd0E9YgpZpQSzp5ahA/SQsQYyYay0fubbiVOdyrODbu+c9HnYotMeBLdVVpPIKm1QLFKaei9BkrvdzCb6tzWhXm+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTRoe1Ng; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720881929; x=1752417929;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yaXgbeC6fPlcTzP+Gg3XP2gCeLxWUzGkzc6Ow3UHLJg=;
  b=GTRoe1NgkYhZyOXMc+4ECbZXpAC+SZKT1cUb9vHYtd7diTySpb7DfEwm
   OBtq5hiexZ17D1Z8WWS0dSZSKtqEZ1cTdgdRQIALSjf5LEAJBXZWg4gCx
   7tp/b175F4stXREEH1Lebl9D5hdE7SCbMjlZhbW0QYqaDKMjnbT98Gqnn
   l7DDmNi8azD5+iK2Ynckuvjx9bf7gKMoa5hf8BGGczwYFtAEPQPiye3cx
   4bHURtF0tcQ8ZUA8wAVlKMNiuA/fcdZrqqCwp8Qyq1AoiWIItNs3gGZt2
   kT1wJZ70wZBiDbv+BsHTCpQK6w80E0aIkXbqrNRdUHMBSlsQdttYHTsFy
   A==;
X-CSE-ConnectionGUID: RI644c1cSA+UwbD7zP3BbQ==
X-CSE-MsgGUID: 3bWtGafdRhOZr865T+7XOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29707613"
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="29707613"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 07:45:28 -0700
X-CSE-ConnectionGUID: uWXfR121QNOhdN8WOBOKNA==
X-CSE-MsgGUID: aYvr0kG5RW6iIkUpdNSteA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="49949377"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 Jul 2024 07:45:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSe05-000cH2-0R;
	Sat, 13 Jul 2024 14:45:25 +0000
Date: Sat, 13 Jul 2024 22:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.11] BUILD SUCCESS
 226c49446bccee1c2315bc88bbbca7e6542e98fc
Message-ID: <202407132259.GiaeS2Tz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git =
for-6.11
branch HEAD: 226c49446bccee1c2315bc88bbbca7e6542e98fc  cgroup: Add Michal K=
outn=C3=BD as a maintainer

elapsed time: 1282m

configs tested: 197
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240713   gcc-13.2.0
arc                   randconfig-002-20240713   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   gcc-13.2.0
arm                         at91_dt_defconfig   clang-19
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-14.1.0
arm                   randconfig-001-20240713   gcc-13.2.0
arm                   randconfig-002-20240713   gcc-13.2.0
arm                   randconfig-003-20240713   gcc-13.2.0
arm                   randconfig-004-20240713   gcc-13.2.0
arm                        realview_defconfig   clang-19
arm                           sama5_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240713   gcc-13.2.0
arm64                 randconfig-002-20240713   gcc-13.2.0
arm64                 randconfig-003-20240713   gcc-13.2.0
arm64                 randconfig-004-20240713   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240713   gcc-13.2.0
csky                  randconfig-002-20240713   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-003-20240713   clang-18
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-005-20240713   clang-18
i386         buildonly-randconfig-006-20240713   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   clang-18
i386                  randconfig-002-20240713   clang-18
i386                  randconfig-003-20240713   clang-18
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-005-20240713   clang-18
i386                  randconfig-006-20240713   clang-18
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-012-20240713   clang-18
i386                  randconfig-013-20240713   clang-18
i386                  randconfig-014-20240713   clang-18
i386                  randconfig-015-20240713   clang-18
i386                  randconfig-016-20240713   clang-18
loongarch                        alldefconfig   gcc-14.1.0
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240713   gcc-13.2.0
loongarch             randconfig-002-20240713   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       bvme6000_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                      mmu_defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                     loongson1b_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   clang-19
mips                      malta_kvm_defconfig   gcc-14.1.0
mips                malta_qemu_32r6_defconfig   clang-19
mips                      maltasmvp_defconfig   gcc-14.1.0
mips                        maltaup_defconfig   clang-19
mips                           mtx1_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
mips                           rs90_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240713   gcc-13.2.0
nios2                 randconfig-002-20240713   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240713   gcc-13.2.0
parisc                randconfig-002-20240713   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     asp8347_defconfig   clang-19
powerpc                 canyonlands_defconfig   clang-19
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                       eiger_defconfig   clang-19
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-14.1.0
powerpc                     mpc512x_defconfig   clang-19
powerpc                     mpc5200_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                      ppc44x_defconfig   clang-19
powerpc               randconfig-001-20240713   gcc-13.2.0
powerpc               randconfig-002-20240713   gcc-13.2.0
powerpc               randconfig-003-20240713   gcc-13.2.0
powerpc                     tqm8555_defconfig   clang-19
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240713   gcc-13.2.0
powerpc64             randconfig-002-20240713   gcc-13.2.0
powerpc64             randconfig-003-20240713   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240713   gcc-13.2.0
riscv                 randconfig-002-20240713   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240713   gcc-13.2.0
s390                  randconfig-002-20240713   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                ecovec24-romimage_defconfig   gcc-14.1.0
sh                    randconfig-001-20240713   gcc-13.2.0
sh                    randconfig-002-20240713   gcc-13.2.0
sh                             shx3_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240713   gcc-13.2.0
sparc64               randconfig-002-20240713   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240713   gcc-13.2.0
um                    randconfig-002-20240713   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240713   clang-18
x86_64       buildonly-randconfig-002-20240713   clang-18
x86_64       buildonly-randconfig-003-20240713   clang-18
x86_64       buildonly-randconfig-004-20240713   clang-18
x86_64       buildonly-randconfig-005-20240713   clang-18
x86_64       buildonly-randconfig-006-20240713   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240713   clang-18
x86_64                randconfig-002-20240713   clang-18
x86_64                randconfig-003-20240713   clang-18
x86_64                randconfig-004-20240713   clang-18
x86_64                randconfig-005-20240713   clang-18
x86_64                randconfig-006-20240713   clang-18
x86_64                randconfig-011-20240713   clang-18
x86_64                randconfig-012-20240713   clang-18
x86_64                randconfig-013-20240713   clang-18
x86_64                randconfig-014-20240713   clang-18
x86_64                randconfig-015-20240713   clang-18
x86_64                randconfig-016-20240713   clang-18
x86_64                randconfig-071-20240713   clang-18
x86_64                randconfig-072-20240713   clang-18
x86_64                randconfig-073-20240713   clang-18
x86_64                randconfig-074-20240713   clang-18
x86_64                randconfig-075-20240713   clang-18
x86_64                randconfig-076-20240713   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240713   gcc-13.2.0
xtensa                randconfig-002-20240713   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-14.1.0

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

