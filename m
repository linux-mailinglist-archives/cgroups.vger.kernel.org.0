Return-Path: <cgroups+bounces-9773-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8BB478D0
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 05:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5410920032C
	for <lists+cgroups@lfdr.de>; Sun,  7 Sep 2025 03:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D553A8F7;
	Sun,  7 Sep 2025 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiqBsnND"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87923FE7
	for <cgroups@vger.kernel.org>; Sun,  7 Sep 2025 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757216951; cv=none; b=Ad0hIZMlg8n1+wTz55C07HJC+R0elooxlH/nPlM0fpSO0TD2sQq2Etr3M6msfg/7Tc5o7OrTFLDbGaJt5OBw36r4d/YSAidfLlHNo5TWoeL/jBe7AB0CaxbPXfRJJAYybtTJ4jye6ZT7Mb5NYFitQZ7A9tyhGR6b9ebPg8ZaJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757216951; c=relaxed/simple;
	bh=/IJqiBoYJpp5cKVeGM4aSssvZbeTm03MMYHWfnCK++0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qlLuDrB7xXZ00+praCefpuQUYu8vPllALziUzo2TzwqE/3vleWPPfYhKy4e6duu55u3t2jnDn7zsVAlZ5YZjxNf1vXGd/2LVoILPcd4wG0VKJS/qPfRU3XO91v+Hg0stoE6PTbrvM9FPcN8MpaJCMNQr06J8PTCYd2ieUREnuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiqBsnND; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757216950; x=1788752950;
  h=date:from:to:cc:subject:message-id;
  bh=/IJqiBoYJpp5cKVeGM4aSssvZbeTm03MMYHWfnCK++0=;
  b=KiqBsnNDIqgGWFncNlQ0nRNpjd2GUf3BTK2ADDln11APLk9RDFCnT0Ja
   eL5auSUwvJm7324HbxPHvnyhOPVFXh/NKIrlyfcN09H9v33Tel8Uzu2Cy
   pQYcxcUzPs+xadqmG+sdbvcWb7TxJrwiZtNMMzLLM/5JPWKsEbV/WXHMv
   /UMeJxDCKFyLF5YceJYbz2UpLHFgDXHmaTgzdqz2iFz4eoZcXbyOGqCF1
   ekAQGpbSsvM8X69juAtT+2Tp0unf6nlB96cYcMONeh9Tng4zy4KERw9JG
   st1boq/euhVq2DrlCEXSMTKp8agleJcVbs48FrQQ+S9CXMVC0UIHI7XXl
   g==;
X-CSE-ConnectionGUID: csXaOtauTzKLlxoTlwJBQA==
X-CSE-MsgGUID: ECsEjRT6RemnF8DpIVxxNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="62142952"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="62142952"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 20:49:09 -0700
X-CSE-ConnectionGUID: kWJ62lMdThiNkdHjRgHImg==
X-CSE-MsgGUID: j9AkR6U/RIi0TxudkxAVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="171760026"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Sep 2025 20:49:08 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv6On-000209-27;
	Sun, 07 Sep 2025 03:49:05 +0000
Date: Sun, 07 Sep 2025 11:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 8bfb4580b4be057b99256029ce4010dc63544777
Message-ID: <202509071158.mkJBzBYv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 8bfb4580b4be057b99256029ce4010dc63544777  Merge branch 'for-6.18' into for-next

elapsed time: 2064m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250906    gcc-14.3.0
arc                   randconfig-002-20250906    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250906    clang-22
arm                   randconfig-002-20250906    clang-22
arm                   randconfig-003-20250906    gcc-13.4.0
arm                   randconfig-004-20250906    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250906    gcc-8.5.0
arm64                 randconfig-002-20250906    gcc-12.5.0
arm64                 randconfig-003-20250906    clang-22
arm64                 randconfig-004-20250906    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250906    gcc-15.1.0
csky                  randconfig-002-20250906    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250906    clang-20
hexagon               randconfig-002-20250906    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250906    clang-20
i386        buildonly-randconfig-002-20250906    gcc-11
i386        buildonly-randconfig-003-20250906    gcc-13
i386        buildonly-randconfig-004-20250906    gcc-13
i386        buildonly-randconfig-005-20250906    clang-20
i386        buildonly-randconfig-006-20250906    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250906    clang-22
loongarch             randconfig-002-20250906    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250906    gcc-11.5.0
nios2                 randconfig-002-20250906    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250906    gcc-11.5.0
parisc                randconfig-002-20250906    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250906    gcc-14.3.0
powerpc               randconfig-002-20250906    clang-20
powerpc               randconfig-003-20250906    clang-22
powerpc64             randconfig-001-20250906    gcc-13.4.0
powerpc64             randconfig-002-20250906    gcc-10.5.0
powerpc64             randconfig-003-20250906    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250906    gcc-13.4.0
riscv                 randconfig-002-20250906    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250906    gcc-10.5.0
s390                  randconfig-002-20250906    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250906    gcc-15.1.0
sh                    randconfig-002-20250906    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250906    gcc-8.5.0
sparc                 randconfig-002-20250906    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250906    clang-22
sparc64               randconfig-002-20250906    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250906    gcc-12
um                    randconfig-002-20250906    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250906    clang-20
x86_64      buildonly-randconfig-002-20250906    gcc-13
x86_64      buildonly-randconfig-003-20250906    gcc-13
x86_64      buildonly-randconfig-004-20250906    clang-20
x86_64      buildonly-randconfig-005-20250906    gcc-13
x86_64      buildonly-randconfig-006-20250906    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250906    gcc-12.5.0
xtensa                randconfig-002-20250906    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

