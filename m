Return-Path: <cgroups+bounces-4195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD5194DD7A
	for <lists+cgroups@lfdr.de>; Sat, 10 Aug 2024 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53A91C20C67
	for <lists+cgroups@lfdr.de>; Sat, 10 Aug 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5B161306;
	Sat, 10 Aug 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJ6BbtvU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7016089A
	for <cgroups@vger.kernel.org>; Sat, 10 Aug 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723303757; cv=none; b=fB2IPeMVKOKYTq1q/qcHhGvOUGth0Ggn55OHTUf78rjkdnCj26Yaau+m6ZZBTv+FNv6qdW4rAiDp3iujHY7xl2DEbKTCsUEnEpf9hO0adTrF6TxwpLVQjt4HSN7YhUqCIwyp/gux1RXPWcrHyh6SeJaMYpmzCqrDc/rXw6VS8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723303757; c=relaxed/simple;
	bh=VvOJM8LffJSOcPHfmx55iW0GOhsQx8b2bcx4f/SDiSc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dDJyU8cXkox7fzmMBmp+JnCS291n76DPybhpS75/rkr9Abyn2ogrdCa66+0kBCZqyw1JxtHazQgevFQ2N3tXYJOuvXTdg2c8wyGsPeKEQyGENXY+a2ULRn4LSgKfHK4/XS+KDOY+PvySqGjdaDFjgO6POUAsTDv9S7KRzP5Rbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJ6BbtvU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723303746; x=1754839746;
  h=date:from:to:cc:subject:message-id;
  bh=VvOJM8LffJSOcPHfmx55iW0GOhsQx8b2bcx4f/SDiSc=;
  b=hJ6BbtvUEiS5BVPe6BK7+aLiSmrhlPa1ieOdBwfiaaXNSfK/wqo0MCQ8
   /f6I3nCSGiXibRl6iS9gLmer388UFO7VaQlL+J8SNE56bBz0jA60/dgGE
   oTBJYi5lslEsdm3rXrHF1Ddr9dX1jWk5c5LMVAkzG1exY1I4zsSqGyom6
   RFmuFzGzOzXZsqIOq0bbDqZh7nEG1EFf/eRhuuyUx7DE1B+5/rZ0lmhTQ
   +xR2DdvKh+qFXgvulPurL1pLQG6Qq+QmrudJhV2CU4g3MaqzyityFeN5A
   EipXnOnHd54ITGHCQhiNaxG5Hk1d6Ta1679KN9HEHpeWccdPVy2vizC+s
   g==;
X-CSE-ConnectionGUID: cc4oww5BSyWArgrgCmvc4A==
X-CSE-MsgGUID: snts9y32Ql2rBaTceBwSsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21275300"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="21275300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 08:29:06 -0700
X-CSE-ConnectionGUID: UtvykdaBRM+ktU+X9eeA2g==
X-CSE-MsgGUID: Jn6LGFocR9u+rq2KIuCNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57808646"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Aug 2024 08:29:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sco1e-000A3P-27;
	Sat, 10 Aug 2024 15:29:02 +0000
Date: Sat, 10 Aug 2024 23:28:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 d8454758e6e40489085b012e23654648362c18d3
Message-ID: <202408102337.Iy2igSPW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: d8454758e6e40489085b012e23654648362c18d3  Merge branch 'for-6.12' into for-next

elapsed time: 1356m

configs tested: 221
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240810   gcc-13.2.0
arc                   randconfig-002-20240810   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                            mps2_defconfig   clang-20
arm                            mps2_defconfig   gcc-13.2.0
arm                             mxs_defconfig   clang-20
arm                             mxs_defconfig   gcc-14.1.0
arm                          pxa168_defconfig   gcc-14.1.0
arm                   randconfig-001-20240810   gcc-13.2.0
arm                   randconfig-002-20240810   gcc-13.2.0
arm                   randconfig-003-20240810   gcc-13.2.0
arm                   randconfig-004-20240810   gcc-13.2.0
arm                         socfpga_defconfig   clang-20
arm                    vt8500_v6_v7_defconfig   gcc-14.1.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240810   gcc-13.2.0
arm64                 randconfig-002-20240810   gcc-13.2.0
arm64                 randconfig-003-20240810   gcc-13.2.0
arm64                 randconfig-004-20240810   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240810   gcc-13.2.0
csky                  randconfig-002-20240810   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-005-20240810   clang-18
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-006-20240810   clang-18
i386         buildonly-randconfig-006-20240810   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-002-20240810   clang-18
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-004-20240810   clang-18
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-005-20240810   clang-18
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-011-20240810   clang-18
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-012-20240810   clang-18
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-014-20240810   clang-18
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-015-20240810   clang-18
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-016-20240810   clang-18
i386                  randconfig-016-20240810   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240810   gcc-13.2.0
loongarch             randconfig-002-20240810   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                           ci20_defconfig   clang-20
mips                     cu1830-neo_defconfig   gcc-14.1.0
mips                            gpr_defconfig   clang-20
mips                           ip27_defconfig   gcc-14.1.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240810   gcc-13.2.0
nios2                 randconfig-002-20240810   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240810   gcc-13.2.0
parisc                randconfig-002-20240810   gcc-13.2.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   clang-20
powerpc                     ksi8560_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   clang-20
powerpc                     stx_gp3_defconfig   gcc-14.1.0
powerpc                        warp_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240810   gcc-13.2.0
powerpc64             randconfig-002-20240810   gcc-13.2.0
powerpc64             randconfig-003-20240810   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240810   gcc-13.2.0
riscv                 randconfig-002-20240810   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240810   gcc-13.2.0
s390                  randconfig-002-20240810   gcc-13.2.0
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240810   gcc-13.2.0
sh                    randconfig-002-20240810   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240810   gcc-13.2.0
sparc64               randconfig-002-20240810   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240810   gcc-13.2.0
um                    randconfig-002-20240810   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                           alldefconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240810   gcc-12
x86_64       buildonly-randconfig-002-20240810   gcc-12
x86_64       buildonly-randconfig-003-20240810   gcc-12
x86_64       buildonly-randconfig-004-20240810   gcc-12
x86_64       buildonly-randconfig-005-20240810   gcc-12
x86_64       buildonly-randconfig-006-20240810   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240810   gcc-12
x86_64                randconfig-002-20240810   gcc-12
x86_64                randconfig-003-20240810   gcc-12
x86_64                randconfig-004-20240810   gcc-12
x86_64                randconfig-005-20240810   gcc-12
x86_64                randconfig-006-20240810   gcc-12
x86_64                randconfig-011-20240810   gcc-12
x86_64                randconfig-012-20240810   gcc-12
x86_64                randconfig-013-20240810   gcc-12
x86_64                randconfig-014-20240810   gcc-12
x86_64                randconfig-015-20240810   gcc-12
x86_64                randconfig-016-20240810   gcc-12
x86_64                randconfig-071-20240810   gcc-12
x86_64                randconfig-072-20240810   gcc-12
x86_64                randconfig-073-20240810   gcc-12
x86_64                randconfig-074-20240810   gcc-12
x86_64                randconfig-075-20240810   gcc-12
x86_64                randconfig-076-20240810   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240810   gcc-13.2.0
xtensa                randconfig-002-20240810   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

