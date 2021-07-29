Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58C93D9FC1
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhG2Ik3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 04:40:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:5385 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhG2Ik2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Jul 2021 04:40:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="210948173"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="210948173"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 01:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="438159508"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2021 01:40:24 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m91aZ-00091V-QB; Thu, 29 Jul 2021 08:40:23 +0000
Date:   Thu, 29 Jul 2021 16:40:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.15] BUILD SUCCESS
 f944e005aa9b3d4c6dc75f5c9535acec20926f86
Message-ID: <61026960./8b+sX1bkZyfKxsQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15
branch HEAD: f944e005aa9b3d4c6dc75f5c9535acec20926f86  cgroup/cpuset: Fix violation of cpuset locking rule

elapsed time: 1959m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
powerpc                     akebono_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
sh                   sh7770_generic_defconfig
arm                           tegra_defconfig
xtensa                    xip_kc705_defconfig
arm                        mini2440_defconfig
arc                           tb10x_defconfig
h8300                            alldefconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
arm                           u8500_defconfig
powerpc                   currituck_defconfig
mips                           ip32_defconfig
nios2                            alldefconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc40x_defconfig
mips                            gpr_defconfig
mips                      maltasmvp_defconfig
sh                           se7721_defconfig
arm                       aspeed_g5_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
x86_64                              defconfig
mips                       capcella_defconfig
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
alpha                               defconfig
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210728
x86_64               randconfig-c001-20210727
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728
x86_64               randconfig-a003-20210727
x86_64               randconfig-a006-20210727
x86_64               randconfig-a001-20210727
x86_64               randconfig-a005-20210727
x86_64               randconfig-a004-20210727
x86_64               randconfig-a002-20210727

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
