Return-Path: <cgroups+bounces-5002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24D98BA1D
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 12:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925182840A8
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51E1A0BDE;
	Tue,  1 Oct 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFh9dHDT"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAB19D8BF
	for <cgroups@vger.kernel.org>; Tue,  1 Oct 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779871; cv=none; b=cWjiQWGDuouT3IlXsfJNmZcismmw4TF2pEUxh+p11B4ENEEvQrT5XCieYCGgjyeAV4oYbDoG3M7OULZZ6ClNMT2UL34RwtCzPpZBVIHjum8kfIzagEPfx7ffBEBLha1dSYAmJcrdFWvrJ401puG0qEkR9bWDSlXo8uF+BWL41iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779871; c=relaxed/simple;
	bh=OIl+Xcob9OS8FOFkJjMwwyqFTkYTQolmritreAw54hA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aA+wnQXCJCE+4J2/Mks4HHDRPuf6Wo0OKjZGMpqHNLFdqWodAV/23BhxDs47YgSyZQAbpfI2pIxnujxNiwQbhYYss7w2368FRnH1wDKP/2TeXbSu2zf33m4titLVaGNKooJo369SxwpNcdtoD1VcUzkGLec4AwBVQnOsC21jqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFh9dHDT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727779871; x=1759315871;
  h=date:from:to:cc:subject:message-id;
  bh=OIl+Xcob9OS8FOFkJjMwwyqFTkYTQolmritreAw54hA=;
  b=MFh9dHDTE7bVed6ObK/vqKFFP2ehz/pmHCkk0oOa9Y/RDoTVcyC7V09k
   jr/Wz/ang+6iLq8tUaVCFrGL4nFNebT0RRN7lNwI089AMcSPk+mFdH8ui
   D/rjm+mLEOdkdXJHv7i4sRyztr+cB2vVDs4k0HKWeuqmjH63jT5p6ktp3
   Au1hGmy608Ouq0BqioI19+cE165X2VCVBJ3BtXOF2Pm0s+yvjaUw8r13b
   HKFYVJQ0J4iXgSxGPpYuwethwv4qb+UyhRtwDTb1yraopbV8KB74YmSb8
   Jz6AmzjnN2MTRvbBHbrYXL5MuRNPABALKSzXiU/7zaj5Mx6Y5RN46di/O
   A==;
X-CSE-ConnectionGUID: 4d7q0jnxTcmZY9EpWI00PQ==
X-CSE-MsgGUID: gqzNJHgUTRm8O00cmwAkaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="27037167"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="27037167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:51:10 -0700
X-CSE-ConnectionGUID: NcqbRo0RQ+CzjR6sIXRFdQ==
X-CSE-MsgGUID: oVXmQe0/QcitreF1z4mb3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78035175"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Oct 2024 03:51:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svaTC-000QZY-1Q;
	Tue, 01 Oct 2024 10:51:06 +0000
Date: Tue, 01 Oct 2024 18:50:41 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 95a616d89ccd2d2af0bd26c13c50143b301d82e8
Message-ID: <202410011835.3WgbYdlt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 95a616d89ccd2d2af0bd26c13c50143b301d82e8  cgroup/cpuset: Fix spelling errors in file kernel/cgroup/cpuset.c

elapsed time: 872m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.1.0
alpha                      allyesconfig    clang-20
alpha                         defconfig    gcc-14.1.0
arc                        allmodconfig    clang-20
arc                         allnoconfig    gcc-14.1.0
arc                        allyesconfig    clang-20
arc                    axs103_defconfig    gcc-14.1.0
arc                           defconfig    gcc-14.1.0
arm                        allmodconfig    clang-20
arm                         allnoconfig    gcc-14.1.0
arm                        allyesconfig    clang-20
arm                    collie_defconfig    gcc-14.1.0
arm               davinci_all_defconfig    gcc-14.1.0
arm                           defconfig    gcc-14.1.0
arm                   lpc18xx_defconfig    gcc-14.1.0
arm                 versatile_defconfig    gcc-14.1.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.1.0
arm64                         defconfig    gcc-14.1.0
csky                        allnoconfig    gcc-14.1.0
csky                          defconfig    gcc-14.1.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.1.0
hexagon                    allyesconfig    clang-20
hexagon                       defconfig    gcc-14.1.0
i386                       allmodconfig    clang-18
i386                        allnoconfig    clang-18
i386                       allyesconfig    clang-18
i386                          defconfig    clang-18
loongarch                  allmodconfig    gcc-14.1.0
loongarch                   allnoconfig    gcc-14.1.0
loongarch                     defconfig    gcc-14.1.0
m68k                       allmodconfig    gcc-14.1.0
m68k                        allnoconfig    gcc-14.1.0
m68k                       allyesconfig    gcc-14.1.0
m68k                          defconfig    gcc-14.1.0
microblaze                 allmodconfig    gcc-14.1.0
microblaze                  allnoconfig    gcc-14.1.0
microblaze                 allyesconfig    gcc-14.1.0
microblaze                    defconfig    gcc-14.1.0
mips                        allnoconfig    gcc-14.1.0
mips                   db1xxx_defconfig    gcc-14.1.0
mips                     rs90_defconfig    gcc-14.1.0
nios2                       allnoconfig    gcc-14.1.0
nios2                         defconfig    gcc-14.1.0
openrisc                    allnoconfig    clang-20
openrisc                    allnoconfig    gcc-14.1.0
openrisc                   allyesconfig    gcc-14.1.0
openrisc                      defconfig    gcc-12
openrisc            or1klitex_defconfig    gcc-14.1.0
parisc                     allmodconfig    gcc-14.1.0
parisc                      allnoconfig    clang-20
parisc                      allnoconfig    gcc-14.1.0
parisc                     allyesconfig    gcc-14.1.0
parisc                        defconfig    gcc-12
parisc64                      defconfig    gcc-14.1.0
powerpc                    allmodconfig    gcc-14.1.0
powerpc                     allnoconfig    clang-20
powerpc                     allnoconfig    gcc-14.1.0
powerpc                    allyesconfig    gcc-14.1.0
powerpc           canyonlands_defconfig    gcc-14.1.0
powerpc                  cell_defconfig    gcc-14.1.0
powerpc                  fsp2_defconfig    gcc-14.1.0
powerpc         mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                   wii_defconfig    gcc-14.1.0
riscv                      allmodconfig    gcc-14.1.0
riscv                       allnoconfig    clang-20
riscv                       allnoconfig    gcc-14.1.0
riscv                      allyesconfig    gcc-14.1.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    clang-20
s390                       allmodconfig    gcc-14.1.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.1.0
s390                          defconfig    gcc-12
sh                         alldefconfig    gcc-14.1.0
sh                         allmodconfig    gcc-14.1.0
sh                          allnoconfig    gcc-14.1.0
sh                         allyesconfig    gcc-14.1.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    gcc-14.1.0
sh                      titan_defconfig    gcc-14.1.0
sh                        ul2_defconfig    gcc-14.1.0
sparc                      allmodconfig    gcc-14.1.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-17
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-18
x86_64                     allyesconfig    clang-18
x86_64                        defconfig    clang-18
x86_64                    rhel-8.3-rust    clang-18
xtensa                      allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

