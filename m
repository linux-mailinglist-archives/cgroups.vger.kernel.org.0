Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22208465DEF
	for <lists+cgroups@lfdr.de>; Thu,  2 Dec 2021 06:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbhLBFdj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Dec 2021 00:33:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:62762 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355397AbhLBFdf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 2 Dec 2021 00:33:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="234136087"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="234136087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 21:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="609843730"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2021 21:30:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msefV-000Fue-Vk; Thu, 02 Dec 2021 05:30:05 +0000
Date:   Thu, 02 Dec 2021 13:29:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 e14da77113bb890d7bf9e5d17031bdd476a7ce5e
Message-ID: <61a859a6.piV819A1yQm89mws%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: e14da77113bb890d7bf9e5d17031bdd476a7ce5e  cgroup: Trace event cgroup id fields should be u64

elapsed time: 720m

configs tested: 229
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
i386                 randconfig-c001-20211201
arm                       cns3420vb_defconfig
arm                            hisi_defconfig
arm                        mvebu_v7_defconfig
arc                              alldefconfig
arm                  colibri_pxa270_defconfig
arm                      integrator_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
mips                          rm200_defconfig
ia64                          tiger_defconfig
mips                        qi_lb60_defconfig
mips                         mpc30x_defconfig
s390                             alldefconfig
mips                           ci20_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
powerpc                      makalu_defconfig
sh                           se7721_defconfig
sh                               alldefconfig
arc                         haps_hs_defconfig
arm                          exynos_defconfig
xtensa                              defconfig
arc                      axs103_smp_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
arm                         hackkit_defconfig
arm                         mv78xx0_defconfig
arm                          moxart_defconfig
sh                               j2_defconfig
powerpc                      arches_defconfig
sparc64                          alldefconfig
powerpc                     mpc83xx_defconfig
mips                        bcm63xx_defconfig
i386                             alldefconfig
powerpc                      mgcoge_defconfig
mips                           rs90_defconfig
arm                           sunxi_defconfig
arm                      jornada720_defconfig
arc                          axs101_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8272_ads_defconfig
nios2                         10m50_defconfig
powerpc                    mvme5100_defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
arm                       imx_v6_v7_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         db1xxx_defconfig
mips                        omega2p_defconfig
xtensa                       common_defconfig
sh                         ap325rxa_defconfig
openrisc                            defconfig
powerpc                     tqm8560_defconfig
arm                       spear13xx_defconfig
nds32                               defconfig
arm                            pleb_defconfig
arm                          pxa168_defconfig
sh                          rsk7203_defconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
sh                   secureedge5410_defconfig
riscv                    nommu_virt_defconfig
arm                        cerfcube_defconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
arm                        multi_v7_defconfig
mips                      maltaaprp_defconfig
sh                          sdk7780_defconfig
powerpc                     pseries_defconfig
arm                   milbeaut_m10v_defconfig
um                           x86_64_defconfig
csky                                defconfig
m68k                         amcore_defconfig
mips                       capcella_defconfig
arm                        multi_v5_defconfig
arm                           h5000_defconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
powerpc64                           defconfig
mips                      pic32mzda_defconfig
ia64                             alldefconfig
nios2                            alldefconfig
powerpc                 mpc832x_rdb_defconfig
sh                              ul2_defconfig
sh                         ecovec24_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20211128
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20211130
i386                 randconfig-a002-20211130
i386                 randconfig-a006-20211130
i386                 randconfig-a004-20211130
i386                 randconfig-a003-20211130
i386                 randconfig-a001-20211130
i386                 randconfig-a001-20211201
i386                 randconfig-a005-20211201
i386                 randconfig-a003-20211201
i386                 randconfig-a002-20211201
i386                 randconfig-a006-20211201
i386                 randconfig-a004-20211201
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
i386                 randconfig-a016-20211202
i386                 randconfig-a013-20211202
i386                 randconfig-a011-20211202
i386                 randconfig-a014-20211202
i386                 randconfig-a012-20211202
i386                 randconfig-a015-20211202
arc                  randconfig-r043-20211129
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
arm                  randconfig-c002-20211201
x86_64               randconfig-c007-20211201
riscv                randconfig-c006-20211201
mips                 randconfig-c004-20211201
i386                 randconfig-c001-20211201
powerpc              randconfig-c003-20211201
s390                 randconfig-c005-20211201
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
x86_64               randconfig-a014-20211130
x86_64               randconfig-a016-20211130
x86_64               randconfig-a013-20211130
x86_64               randconfig-a012-20211130
x86_64               randconfig-a015-20211130
x86_64               randconfig-a011-20211130
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
i386                 randconfig-a013-20211201
i386                 randconfig-a016-20211201
i386                 randconfig-a011-20211201
i386                 randconfig-a014-20211201
i386                 randconfig-a012-20211201
i386                 randconfig-a015-20211201
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
