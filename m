Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0849B362EAB
	for <lists+cgroups@lfdr.de>; Sat, 17 Apr 2021 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhDQJAC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Apr 2021 05:00:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:45296 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhDQJAC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 17 Apr 2021 05:00:02 -0400
IronPort-SDR: nZwzPEkc/j4qrqzcr4I2nMteL2WBlxViGe+qn5dna03DMVUPFIMyX7qs0BGf/q8Uwv/SwJJY7d
 zDO1aTYmIC9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="280474087"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="280474087"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 01:59:35 -0700
IronPort-SDR: HNWoNO4FRT2uB31EKLF5y4eIKd/3fegMr0QkXCA4twpSY2SO8s5xknmfLYf+Yr8aSJGrRgEKGJ
 Nypc3cQawclg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="453634561"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Apr 2021 01:59:34 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXgnd-0000n1-Qu; Sat, 17 Apr 2021 08:59:33 +0000
Date:   Sat, 17 Apr 2021 16:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.13] BUILD SUCCESS
 ffeee417d97f9171bce9f43c22c9f477e4c84f54
Message-ID: <607aa339.U5ANJssVtoA0rAPz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13
branch HEAD: ffeee417d97f9171bce9f43c22c9f477e4c84f54  cgroup: use tsk->in_iowait instead of delayacct_is_task_waiting_on_io()

elapsed time: 724m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                         tb0219_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        clps711x_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                      pcm030_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
powerpc                        icon_defconfig
mips                       capcella_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ip28_defconfig
ia64                             allmodconfig
powerpc                    adder875_defconfig
mips                      pistachio_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
sh                     magicpanelr2_defconfig
powerpc                         ps3_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      arches_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
arm                       aspeed_g5_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          sdk7780_defconfig
m68k                        mvme147_defconfig
sh                           se7751_defconfig
arm                            pleb_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
powerpc                   motionpro_defconfig
powerpc                     powernv_defconfig
sh                             espt_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
csky                                defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
powerpc                     mpc512x_defconfig
powerpc                       holly_defconfig
um                               alldefconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          allmodconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
arm                       omap2plus_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
riscv                          rv32_defconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8315_rdb_defconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
arm                              alldefconfig
h8300                            allyesconfig
arm                        cerfcube_defconfig
mips                        vocore2_defconfig
powerpc                     kilauea_defconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
powerpc                     sequoia_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
openrisc                  or1klitex_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
powerpc                          g5_defconfig
mips                        maltaup_defconfig
i386                             alldefconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
arm                             rpc_defconfig
arm                      footbridge_defconfig
arm                        neponset_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
x86_64               randconfig-a003-20210417
x86_64               randconfig-a002-20210417
x86_64               randconfig-a005-20210417
x86_64               randconfig-a001-20210417
x86_64               randconfig-a006-20210417
x86_64               randconfig-a004-20210417
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
