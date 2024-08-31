Return-Path: <cgroups+bounces-4656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38676967134
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 13:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAAEB22548
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403617E007;
	Sat, 31 Aug 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mABfVi6H"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C714EC64
	for <cgroups@vger.kernel.org>; Sat, 31 Aug 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102843; cv=none; b=l9Df64LfbLTifDh+wBX6kN3srH5IMnsckqeWXfgKchQOD7KICGsZa2ylHiSu/yr4b4m8hzsBdMDhpamdRJQp66fzkkijRj0A82kM8p3bTOArMq4dh/F8CNyROBQ3Ws2isHgFF5mtVPTBF8n19V/+RGbqBi53IWLQp9EJoMMFDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102843; c=relaxed/simple;
	bh=bq0UDEwUTxoNHId/JLJVyE8pUNuuD8Qr5lw5aqje9+E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LaXtLEol4zJxIkF0A65kuA7DuCQRcVi00TVe/mV7NGuO+qKEneINxX4Qr3SczGp3PKGUECvJRuH4m+I70Fv8Vv469FXozI+POPlJ6fjkPplCaYAuTkJVmZT4IsT/PHq80/CioSNx9wAdMDyyIITkWCbjlAejp9Mzos2kVQXSJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mABfVi6H; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725102842; x=1756638842;
  h=date:from:to:cc:subject:message-id;
  bh=bq0UDEwUTxoNHId/JLJVyE8pUNuuD8Qr5lw5aqje9+E=;
  b=mABfVi6H80YIwdQQCIhpZpVoP30MVTaIIKhMyvgUbFoOAnKlLlEG4U8h
   wVyD6aEUI8BEjNoRUuQfmhSAZyRqZnUQq4mwPEw2iql1e0Oo1+S2ZdKy4
   xBkSW65EeLJpe3rxPGXEnDv24vfhLAR+tcNUQr+Svdi6TZdL374gV6lG4
   hkZEBDMEvsuMy1ITzk0HoXV2zvtvQmNzDgyvk97enNgubMoG9zssVyOho
   PP2wrYlPEjoNgbXbtOnwpnB7ouIEINz2w+EJ75EBnv6pYbjP7phQKh/3A
   hKeryq3dYE5GH2LgNlnLxokDiwHnfAjo+9r+TfxTGuxZESTCpdI/5UxHc
   A==;
X-CSE-ConnectionGUID: x3nZetxWRfCF62/9gUV8pw==
X-CSE-MsgGUID: ksObyTtyQiGCh8+anO6EUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23256193"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23256193"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 04:14:01 -0700
X-CSE-ConnectionGUID: De9L28aXRL+A1CdEt7Q1Gw==
X-CSE-MsgGUID: LS3murzmRSe7PTLgtcb9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="94865515"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Aug 2024 04:14:01 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skM3K-0002fK-06;
	Sat, 31 Aug 2024 11:13:58 +0000
Date: Sat, 31 Aug 2024 19:13:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:test] BUILD REGRESSION
 a5ab7b05a3c825f23d74106f3304de7d024cff8a
Message-ID: <202408311901.uiiWSU8M-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test
branch HEAD: a5ab7b05a3c825f23d74106f3304de7d024cff8a  cgroup/cpuset: add sefltest for cpuset v1

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202408311612.mQTuO946-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202408311651.vwwxEpKn-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/cgroup/cpuset-v1.c:163:2: error: call to undeclared function 'cpus_read_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/cgroup/cpuset-v1.c:163:9: error: implicit declaration of function 'cpus_read_lock'; did you mean 'rcu_read_lock'? [-Wimplicit-function-declaration]
kernel/cgroup/cpuset-v1.c:178:2: error: call to undeclared function 'cpus_read_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/cgroup/cpuset-v1.c:178:9: error: implicit declaration of function 'cpus_read_unlock'; did you mean 'rcu_read_unlock'? [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-allmodconfig
|   |-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_lock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_unlock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- loongarch-allmodconfig
|   |-- kernel-cgroup-cpuset-v1.c:error:implicit-declaration-of-function-cpus_read_lock
|   `-- kernel-cgroup-cpuset-v1.c:error:implicit-declaration-of-function-cpus_read_unlock
|-- powerpc-allyesconfig
|   |-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_lock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_unlock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allmodconfig
|   |-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_lock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_unlock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allyesconfig
|   |-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_lock-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_unlock-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- s390-allmodconfig
    |-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_lock-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- kernel-cgroup-cpuset-v1.c:error:call-to-undeclared-function-cpus_read_unlock-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 883m

configs tested: 110
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          gemini_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                         vf610m4_defconfig   clang-20
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240831   clang-18
i386         buildonly-randconfig-002-20240831   clang-18
i386         buildonly-randconfig-003-20240831   clang-18
i386         buildonly-randconfig-004-20240831   clang-18
i386         buildonly-randconfig-005-20240831   clang-18
i386         buildonly-randconfig-006-20240831   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240831   clang-18
i386                  randconfig-002-20240831   clang-18
i386                  randconfig-003-20240831   clang-18
i386                  randconfig-004-20240831   clang-18
i386                  randconfig-005-20240831   clang-18
i386                  randconfig-006-20240831   clang-18
i386                  randconfig-011-20240831   clang-18
i386                  randconfig-012-20240831   clang-18
i386                  randconfig-013-20240831   clang-18
i386                  randconfig-014-20240831   clang-18
i386                  randconfig-015-20240831   clang-18
i386                  randconfig-016-20240831   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          malta_defconfig   clang-20
mips                        omega2p_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                    mvme5100_defconfig   clang-20
powerpc                  storcenter_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                        sh7763rdp_defconfig   clang-20
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

