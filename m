Return-Path: <cgroups+bounces-8780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A724B0AAB6
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 21:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2193D3ACB8D
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EE20485B;
	Fri, 18 Jul 2025 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6LQMizq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418B1B0F23
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867110; cv=none; b=boDJT1pR695CyBNtELKWycebl6On5km9KqFrz+LWpP9mAPu+pPUFNaG6S2erzbOEwqSvAFXwVU/NjT7UrJj42fYonwqnsIBM9bjMRjqPGcoe/qta02cCRisRAryQStiP0qt/rorUwajr0v1Snksk2QmbzA98pSFjQqTGPsXoCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867110; c=relaxed/simple;
	bh=SsJS3utPHVHc9NdgCaKJ4Lf4p+uAjcZd5EcUMg4DRlU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BENEIsHig9PW0A858LM2dyV4QRCycxtZ4hNTArWrshXq0Y8VDe5Tbaboyg3rYI5BRLIMnXwgTsBzLo1rw0w86V+wfuZ9QOYdjTqG2eGIIzCKYDs4rHR05rhmpazT9S7qCZfwCZz91yUjEWH8R7i6F42K0iikvkeFQdN9LuAEZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6LQMizq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752867109; x=1784403109;
  h=date:from:to:cc:subject:message-id;
  bh=SsJS3utPHVHc9NdgCaKJ4Lf4p+uAjcZd5EcUMg4DRlU=;
  b=O6LQMizqydpAR9tJbZwfptHFOUTi8iCp8D49PVOL2ysl88UaoBmVJaFo
   CNk3+2utBxw5iwoBhP0WdUK/rqyc+CQQXLQFVFQApBjLlqcL+iPZbQzjC
   6Gxq0UwCu71Iw4BlYm3eb7IqKSIQYDDi3XuDySPNqjAbanfhrLFmAfv/L
   i9pd6j14JmOD22WnEmKyZPZr/bexuc+1SDfn78TkcoMEbXlVji6syJX0D
   Q3U4jLaHaLQD2FrHz3oEdODJah8WoZer5IoFDZQemu/TQFYVXhcZJ5Nue
   hZl6fwx3IgLqJcExOXUY+bXd1bz7IXuKw73dWc1sExywLodrSZ6Qichjc
   w==;
X-CSE-ConnectionGUID: dcUcgqi5RUKEstQGpGQIBw==
X-CSE-MsgGUID: NwyqyqvHQMCvdWx+uSaECw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="58980829"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="58980829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 12:31:49 -0700
X-CSE-ConnectionGUID: 0i9ODhfrQPOn4jxtZI/QoA==
X-CSE-MsgGUID: oTF5OPXETLG/Mv5rJCXrxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="189083680"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Jul 2025 12:31:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucqo5-000EyX-0p;
	Fri, 18 Jul 2025 19:31:45 +0000
Date: Sat, 19 Jul 2025 03:30:58 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 4c3ab6530dc7037641ed070d0ad56458d8d5ee4d
Message-ID: <202507190346.r7jcjfDK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 4c3ab6530dc7037641ed070d0ad56458d8d5ee4d  Merge branch 'for-6.17' into for-next

elapsed time: 1451m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-21
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-002-20250718    clang-21
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.3.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-003-20250718    clang-17
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-002-20250718    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-002-20250718    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-002-20250718    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250718    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-10.3.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-002-20250718    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-002-20250718    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-8.5.0
xtensa                randconfig-002-20250718    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

