Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3C42631F
	for <lists+cgroups@lfdr.de>; Fri,  8 Oct 2021 05:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhJHDjV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 23:39:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:35862 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhJHDjV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 7 Oct 2021 23:39:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="312622982"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="312622982"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 20:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="484873573"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2021 20:37:24 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mYghI-0007tl-4Y; Fri, 08 Oct 2021 03:37:24 +0000
Date:   Fri, 08 Oct 2021 11:37:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 0061270307f2ad5fa01db1ac5f1da0e83410adaf
Message-ID: <615fbcdc.oJaHVNwD2GAKRLI/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 0061270307f2ad5fa01db1ac5f1da0e83410adaf  cgroup: cgroup-v1: do not exclude cgrp_dfl_root

elapsed time: 1216m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
m68k                       m5475evb_defconfig
powerpc                     tqm5200_defconfig
m68k                       m5249evb_defconfig
powerpc                     skiroot_defconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
powerpc                      ppc40x_defconfig
powerpc                     stx_gp3_defconfig
m68k                          multi_defconfig
sh                          landisk_defconfig
powerpc                      pcm030_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
mips                       bmips_be_defconfig
powerpc                     tqm8560_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
arm                          collie_defconfig
powerpc                      ppc6xx_defconfig
powerpc                   microwatt_defconfig
arm                        multi_v5_defconfig
xtensa                       common_defconfig
m68k                        m5272c3_defconfig
s390                       zfcpdump_defconfig
sparc                            alldefconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7264_defconfig
mips                       capcella_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
openrisc                    or1ksim_defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
mips                        maltaup_defconfig
mips                      loongson3_defconfig
sh                   sh7724_generic_defconfig
arm                           viper_defconfig
arm                          simpad_defconfig
powerpc                         ps3_defconfig
h8300                            allyesconfig
powerpc                      pasemi_defconfig
powerpc64                           defconfig
arm                          moxart_defconfig
arm                           sama5_defconfig
arc                     nsimosci_hs_defconfig
m68k                        stmark2_defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
mips                      malta_kvm_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
xtensa                          iss_defconfig
arm                       multi_v4t_defconfig
powerpc                     ksi8560_defconfig
mips                        bcm63xx_defconfig
x86_64               randconfig-c001-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
x86_64               randconfig-c001-20211004
i386                 randconfig-c001-20211004
arm                  randconfig-c002-20211004
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a015-20211004
x86_64               randconfig-a012-20211004
x86_64               randconfig-a016-20211004
x86_64               randconfig-a014-20211004
x86_64               randconfig-a013-20211004
x86_64               randconfig-a011-20211004
i386                 randconfig-a013-20211004
i386                 randconfig-a016-20211004
i386                 randconfig-a014-20211004
i386                 randconfig-a011-20211004
i386                 randconfig-a012-20211004
i386                 randconfig-a015-20211004
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
s390                 randconfig-c005-20211003
powerpc              randconfig-c003-20211003
riscv                randconfig-c006-20211003
mips                 randconfig-c004-20211003
x86_64               randconfig-a003-20211004
x86_64               randconfig-a005-20211004
x86_64               randconfig-a001-20211004
x86_64               randconfig-a002-20211004
x86_64               randconfig-a004-20211004
x86_64               randconfig-a006-20211004
i386                 randconfig-a001-20211004
i386                 randconfig-a003-20211004
i386                 randconfig-a005-20211004
i386                 randconfig-a002-20211004
i386                 randconfig-a004-20211004
i386                 randconfig-a006-20211004
hexagon              randconfig-r045-20211007
hexagon              randconfig-r041-20211007
s390                 randconfig-r044-20211007
riscv                randconfig-r042-20211007

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
