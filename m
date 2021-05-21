Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5324A38BDED
	for <lists+cgroups@lfdr.de>; Fri, 21 May 2021 07:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEUFiF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 May 2021 01:38:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:57342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhEUFiF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 21 May 2021 01:38:05 -0400
IronPort-SDR: EgulwtGeuGQOmomzSILNDYrWK+bS5O0KBJucPDpnSa7I9435OOoQShzy6c2Mua8KIQgLB4ri/6
 9XoV4h9aRobg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188808043"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188808043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 22:36:42 -0700
IronPort-SDR: w0y2AtLcn3K/9GJLICqv36rwx9PNHcifZVMFIgBRknVXaO1UrqgWbFurCoV4myEMznWtgqU7zg
 ULp/FyBZiveA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395195385"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2021 22:36:41 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljxpw-0000xY-Vr; Fri, 21 May 2021 05:36:40 +0000
Date:   Fri, 21 May 2021 13:36:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-next] BUILD SUCCESS
 b0565a089634e364bfe83e0ea06e3b1094f1b55c
Message-ID: <60a746c4.fwH9Qr+2n6IHEOOV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: b0565a089634e364bfe83e0ea06e3b1094f1b55c  Merge branch 'for-5.13-fixes' into for-next

elapsed time: 722m

configs tested: 176
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           sunxi_defconfig
openrisc                  or1klitex_defconfig
arc                     haps_hs_smp_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm5200_defconfig
m68k                       m5275evb_defconfig
sh                          lboxre2_defconfig
arm                            qcom_defconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
mips                        qi_lb60_defconfig
mips                           rs90_defconfig
sh                           se7721_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     skiroot_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
arm                        spear6xx_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
arm                         shannon_defconfig
powerpc                       maple_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
powerpc                     tqm8560_defconfig
powerpc                     tqm8541_defconfig
powerpc                      pcm030_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    mvme5100_defconfig
ia64                             allmodconfig
powerpc                     pq2fads_defconfig
xtensa                    xip_kc705_defconfig
sparc                       sparc64_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7722_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                         apsh4a3a_defconfig
arm                       omap2plus_defconfig
arc                         haps_hs_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8555_defconfig
arc                        nsimosci_defconfig
arm                         cm_x300_defconfig
mips                           ip28_defconfig
powerpc                     asp8347_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
powerpc                     rainier_defconfig
arm                         lubbock_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
arm                       netwinder_defconfig
arm                         palmz72_defconfig
arm                        vexpress_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      chrp32_defconfig
nios2                         3c120_defconfig
nds32                             allnoconfig
sh                               j2_defconfig
sh                             espt_defconfig
s390                       zfcpdump_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8548_defconfig
mips                            gpr_defconfig
powerpc                      walnut_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
arm                     davinci_all_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
x86_64               randconfig-a001-20210520
x86_64               randconfig-a006-20210520
x86_64               randconfig-a005-20210520
x86_64               randconfig-a003-20210520
x86_64               randconfig-a004-20210520
x86_64               randconfig-a002-20210520
i386                 randconfig-a001-20210520
i386                 randconfig-a005-20210520
i386                 randconfig-a002-20210520
i386                 randconfig-a006-20210520
i386                 randconfig-a004-20210520
i386                 randconfig-a003-20210520
i386                 randconfig-a001-20210521
i386                 randconfig-a005-20210521
i386                 randconfig-a002-20210521
i386                 randconfig-a006-20210521
i386                 randconfig-a003-20210521
i386                 randconfig-a004-20210521
i386                 randconfig-a016-20210520
i386                 randconfig-a011-20210520
i386                 randconfig-a015-20210520
i386                 randconfig-a012-20210520
i386                 randconfig-a014-20210520
i386                 randconfig-a013-20210520
i386                 randconfig-a016-20210521
i386                 randconfig-a011-20210521
i386                 randconfig-a015-20210521
i386                 randconfig-a012-20210521
i386                 randconfig-a014-20210521
i386                 randconfig-a013-20210521
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210521
x86_64               randconfig-b001-20210520
x86_64               randconfig-a013-20210520
x86_64               randconfig-a014-20210520
x86_64               randconfig-a012-20210520
x86_64               randconfig-a016-20210520
x86_64               randconfig-a015-20210520
x86_64               randconfig-a011-20210520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
