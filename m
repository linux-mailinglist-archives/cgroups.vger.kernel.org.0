Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952223DA103
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhG2KZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 06:25:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:28634 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235510AbhG2KZD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Jul 2021 06:25:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="212575857"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="212575857"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 03:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="438187660"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2021 03:24:59 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m93Dm-00094e-HU; Thu, 29 Jul 2021 10:24:58 +0000
Date:   Thu, 29 Jul 2021 18:24:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.14-fixes] BUILD SUCCESS
 c3df5fb57fe8756d67fd56ed29da65cdfde839f9
Message-ID: <610281d9.f1sdnYVaDqfQiUof%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14-fixes
branch HEAD: c3df5fb57fe8756d67fd56ed29da65cdfde839f9  cgroup: rstat: fix A-A deadlock on 32bit around u64_stats_sync

elapsed time: 2063m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210727
i386                 randconfig-c001-20210728
powerpc                    mvme5100_defconfig
powerpc                      ppc6xx_defconfig
arm                         palmz72_defconfig
mips                       rbtx49xx_defconfig
arc                        nsimosci_defconfig
s390                          debug_defconfig
arm                         lpc18xx_defconfig
m68k                        mvme16x_defconfig
sh                        sh7763rdp_defconfig
riscv                          rv32_defconfig
arm                      jornada720_defconfig
powerpc                     akebono_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
sh                   sh7770_generic_defconfig
arm                           tegra_defconfig
mips                         rt305x_defconfig
powerpc                       holly_defconfig
arm                      pxa255-idp_defconfig
sh                         ecovec24_defconfig
xtensa                    xip_kc705_defconfig
arm                        mini2440_defconfig
arc                           tb10x_defconfig
h8300                            alldefconfig
x86_64                           allyesconfig
powerpc                      arches_defconfig
mips                       capcella_defconfig
alpha                               defconfig
sh                              ul2_defconfig
nios2                            alldefconfig
powerpc                      ppc40x_defconfig
mips                            gpr_defconfig
mips                      maltasmvp_defconfig
sh                           se7721_defconfig
arm                       aspeed_g5_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
x86_64                              defconfig
powerpc                       eiger_defconfig
mips                      pistachio_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
i386                 randconfig-a005-20210727
i386                 randconfig-a003-20210727
i386                 randconfig-a004-20210727
i386                 randconfig-a002-20210727
i386                 randconfig-a001-20210727
i386                 randconfig-a006-20210727
x86_64               randconfig-a011-20210727
x86_64               randconfig-a016-20210727
x86_64               randconfig-a013-20210727
x86_64               randconfig-a014-20210727
x86_64               randconfig-a012-20210727
x86_64               randconfig-a015-20210727
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
i386                 randconfig-a016-20210727
i386                 randconfig-a013-20210727
i386                 randconfig-a012-20210727
i386                 randconfig-a011-20210727
i386                 randconfig-a014-20210727
i386                 randconfig-a015-20210727
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210727
x86_64               randconfig-c001-20210728
x86_64               randconfig-a003-20210727
x86_64               randconfig-a006-20210727
x86_64               randconfig-a001-20210727
x86_64               randconfig-a005-20210727
x86_64               randconfig-a004-20210727
x86_64               randconfig-a002-20210727
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
