Return-Path: <cgroups+bounces-13006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E6D06FA0
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 04:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E11300D158
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBEA1E5702;
	Fri,  9 Jan 2026 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4GK3cKI"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B919500979
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928919; cv=none; b=pikFgGfST8cozdPbIr12FqSDXgG7LBxQR+/qrkYkEBWppSfJRSL5BrQmSAcKoRg+RRPK0kucegY24dZf9eVIfYKLFMQ/fYBsdQ2V90C/Hqg6mpk+Ru/N8Ym6xTDyUc6k8IFeLiaobPF4dZ+oYqePoezrnk6oW7+jLRE6LfAU0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928919; c=relaxed/simple;
	bh=L59E3YqbNEStgAY7LBBropG0ICfCYgo61gvkpKiD8ws=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HhWdynDaadmDRSK9BxIB1jUMWl1oPIJy2FDltzTKzToyY1l+5PcZPBjKXeS6ojCTbkVKLv/qgq/IYtUoNcwCq+kvUY42naiINPQXzaypQMMC6VZdOD/BWyDSnO8b+ySjX/beX9i2ovJMBomOfapTs1V5QOwpcBEREySaquGWJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4GK3cKI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767928918; x=1799464918;
  h=date:from:to:cc:subject:message-id;
  bh=L59E3YqbNEStgAY7LBBropG0ICfCYgo61gvkpKiD8ws=;
  b=T4GK3cKII5LLUnBcfs/1ImOip0C9izDZOWaPl+DfZyeJkcpengXdjT7U
   p+6fo+9cXilVgTjZlenSwsrDhyvAuaaxdcncpx5m6lxP6Gk6RDMj9CsB3
   bjg+jK7hHHCzTJZbY9rL/Z0/D+Hsm6RM5ZloBrOO/006f0IbKCdxS9n45
   q02gg4KdHkcqZENnkkyfUth6h5auLyKPROQhkBQRe3TppRWkuGe+n5Jyi
   /EhZWomELPy1uDA+RpcfmqTNZkSj4yoHc1gmjd/kV4/sCX6OBWBe5yGPY
   6wX+3Q0xBxVHFjlGHo6QFoPUIkdjdmi8m5D23q3l3K2WgrO/1CNtv+J+V
   w==;
X-CSE-ConnectionGUID: bNe7EoBCQFGL4HFtqSyBXw==
X-CSE-MsgGUID: nPV9NzijQm+fuZ/KC0a54A==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69295928"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69295928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 19:21:57 -0800
X-CSE-ConnectionGUID: /dfMCDq9Q3GDT3lbsXLszg==
X-CSE-MsgGUID: 0/KL2aFPT5OMn2TtlebPmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="234074946"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Jan 2026 19:21:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ve34T-000000005Mi-2MxZ;
	Fri, 09 Jan 2026 03:21:53 +0000
Date: Fri, 09 Jan 2026 11:21:35 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 59ed36f2bd3338caf7afccaa10e72085f16b9dd6
Message-ID: <202601091125.SwnX701T-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 59ed36f2bd3338caf7afccaa10e72085f16b9dd6  Merge branch 'for-6.19-fixes' into for-next

elapsed time: 1548m

configs tested: 284
configs skipped: 7

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
arc                   randconfig-001-20260108    gcc-9.5.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260108    gcc-8.5.0
arc                   randconfig-002-20260109    gcc-13.4.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-22
arm                        mvebu_v5_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20260108    gcc-8.5.0
arm                   randconfig-001-20260109    gcc-13.4.0
arm                   randconfig-002-20260108    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-13.4.0
arm                   randconfig-003-20260108    clang-17
arm                   randconfig-003-20260109    gcc-13.4.0
arm                   randconfig-004-20260108    clang-22
arm                   randconfig-004-20260109    gcc-13.4.0
arm                             rpc_defconfig    clang-18
arm                           sama7_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260108    gcc-15.1.0
arm64                 randconfig-001-20260109    gcc-8.5.0
arm64                 randconfig-002-20260108    clang-22
arm64                 randconfig-002-20260109    gcc-8.5.0
arm64                 randconfig-003-20260108    clang-22
arm64                 randconfig-003-20260109    gcc-8.5.0
arm64                 randconfig-004-20260108    gcc-10.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260108    gcc-9.5.0
csky                  randconfig-001-20260109    gcc-8.5.0
csky                  randconfig-002-20260108    gcc-11.5.0
csky                  randconfig-002-20260109    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20260108    clang-22
hexagon               randconfig-001-20260109    gcc-8.5.0
hexagon               randconfig-002-20260108    clang-22
hexagon               randconfig-002-20260109    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260108    clang-20
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260108    clang-20
i386        buildonly-randconfig-002-20260109    clang-20
i386        buildonly-randconfig-003-20260108    gcc-13
i386        buildonly-randconfig-003-20260109    clang-20
i386        buildonly-randconfig-004-20260108    clang-20
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260108    clang-20
i386        buildonly-randconfig-005-20260109    clang-20
i386        buildonly-randconfig-006-20260108    gcc-14
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20260108    gcc-13
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260108    gcc-13
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260108    clang-20
i386                  randconfig-003-20260109    gcc-14
i386                  randconfig-004-20260108    clang-20
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260108    clang-20
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260108    gcc-14
i386                  randconfig-006-20260109    gcc-14
i386                  randconfig-007-20260108    gcc-14
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260108    gcc-12
i386                  randconfig-011-20260109    clang-20
i386                  randconfig-012-20260108    gcc-14
i386                  randconfig-012-20260109    clang-20
i386                  randconfig-013-20260108    gcc-14
i386                  randconfig-013-20260109    clang-20
i386                  randconfig-014-20260108    gcc-12
i386                  randconfig-014-20260109    clang-20
i386                  randconfig-015-20260108    gcc-14
i386                  randconfig-015-20260109    clang-20
i386                  randconfig-016-20260108    gcc-14
i386                  randconfig-016-20260109    clang-20
i386                  randconfig-017-20260108    gcc-14
i386                  randconfig-017-20260109    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260108    clang-22
loongarch             randconfig-001-20260109    gcc-8.5.0
loongarch             randconfig-002-20260108    clang-22
loongarch             randconfig-002-20260109    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          malta_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260108    gcc-8.5.0
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260108    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260108    gcc-13.4.0
parisc                randconfig-001-20260109    gcc-8.5.0
parisc                randconfig-002-20260108    gcc-12.5.0
parisc                randconfig-002-20260109    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      chrp32_defconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc                      ppc6xx_defconfig    clang-22
powerpc               randconfig-001-20260108    gcc-13.4.0
powerpc               randconfig-001-20260109    gcc-8.5.0
powerpc               randconfig-002-20260108    clang-22
powerpc               randconfig-002-20260109    gcc-8.5.0
powerpc64             randconfig-001-20260108    clang-22
powerpc64             randconfig-001-20260109    gcc-8.5.0
powerpc64             randconfig-002-20260108    clang-22
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260108    gcc-15.1.0
riscv                 randconfig-001-20260109    clang-22
riscv                 randconfig-002-20260108    clang-22
riscv                 randconfig-002-20260109    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260108    gcc-13.4.0
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20260108    gcc-9.5.0
sh                    randconfig-001-20260109    clang-22
sh                    randconfig-002-20260108    gcc-13.4.0
sh                    randconfig-002-20260109    clang-22
sh                          rsk7203_defconfig    gcc-15.1.0
sh                           se7722_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260108    gcc-8.5.0
sparc                 randconfig-001-20260109    gcc-14.3.0
sparc                 randconfig-002-20260108    gcc-15.1.0
sparc                 randconfig-002-20260109    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260108    gcc-8.5.0
sparc64               randconfig-001-20260109    gcc-14.3.0
sparc64               randconfig-002-20260108    clang-20
sparc64               randconfig-002-20260109    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260108    clang-18
um                    randconfig-001-20260109    gcc-14.3.0
um                    randconfig-002-20260108    clang-22
um                    randconfig-002-20260109    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260108    clang-20
x86_64      buildonly-randconfig-001-20260109    gcc-14
x86_64      buildonly-randconfig-002-20260108    clang-20
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260108    clang-20
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260108    clang-20
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260108    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260108    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260108    clang-20
x86_64                randconfig-001-20260109    gcc-14
x86_64                randconfig-002-20260108    clang-20
x86_64                randconfig-002-20260109    gcc-14
x86_64                randconfig-003-20260108    gcc-12
x86_64                randconfig-003-20260109    gcc-14
x86_64                randconfig-004-20260108    gcc-14
x86_64                randconfig-004-20260109    gcc-14
x86_64                randconfig-005-20260108    gcc-14
x86_64                randconfig-005-20260109    gcc-14
x86_64                randconfig-006-20260108    gcc-14
x86_64                randconfig-006-20260109    gcc-14
x86_64                randconfig-011-20260108    clang-20
x86_64                randconfig-011-20260109    gcc-14
x86_64                randconfig-012-20260108    clang-20
x86_64                randconfig-012-20260109    gcc-14
x86_64                randconfig-013-20260108    clang-20
x86_64                randconfig-013-20260109    gcc-14
x86_64                randconfig-014-20260108    gcc-14
x86_64                randconfig-014-20260109    gcc-14
x86_64                randconfig-015-20260108    gcc-14
x86_64                randconfig-015-20260109    gcc-14
x86_64                randconfig-016-20260108    gcc-14
x86_64                randconfig-016-20260109    gcc-14
x86_64                randconfig-071-20260108    gcc-14
x86_64                randconfig-071-20260109    clang-20
x86_64                randconfig-072-20260108    gcc-14
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260108    gcc-14
x86_64                randconfig-073-20260109    clang-20
x86_64                randconfig-074-20260108    gcc-14
x86_64                randconfig-074-20260109    clang-20
x86_64                randconfig-075-20260108    clang-20
x86_64                randconfig-075-20260109    clang-20
x86_64                randconfig-076-20260108    clang-20
x86_64                randconfig-076-20260109    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260108    gcc-11.5.0
xtensa                randconfig-001-20260109    gcc-14.3.0
xtensa                randconfig-002-20260108    gcc-8.5.0
xtensa                randconfig-002-20260109    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

