Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE273F81EE
	for <lists+cgroups@lfdr.de>; Thu, 26 Aug 2021 07:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHZFHm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Aug 2021 01:07:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:62324 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235468AbhHZFHm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 26 Aug 2021 01:07:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="303247324"
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="303247324"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 22:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="686813399"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2021 22:06:54 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJ7bJ-0000mS-Jc; Thu, 26 Aug 2021 05:06:53 +0000
Date:   Thu, 26 Aug 2021 13:06:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.15] BUILD SUCCESS
 9f72daf7edfa8f7e86ce8940d52266b5e931dcb0
Message-ID: <61272151.le20PzJD/+scJcQD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15
branch HEAD: 9f72daf7edfa8f7e86ce8940d52266b5e931dcb0  cgroup/cpuset: Avoid memory migration when nodemasks match

elapsed time: 720m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210825
powerpc                       ebony_defconfig
arm                           sama5_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
xtensa                       common_defconfig
h8300                               defconfig
arm                       aspeed_g4_defconfig
mips                      bmips_stb_defconfig
arm                            xcep_defconfig
arm                            mps2_defconfig
powerpc                     ep8248e_defconfig
powerpc                      katmai_defconfig
xtensa                  audio_kc705_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
powerpc                   microwatt_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
powerpc                 canyonlands_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ep88xc_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
powerpc                     tqm5200_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            migor_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc8540_ads_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
sh                            shmin_defconfig
sh                               j2_defconfig
powerpc                      arches_defconfig
arc                            hsdk_defconfig
mips                         tb0226_defconfig
arm                        neponset_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     ksi8560_defconfig
riscv                          rv32_defconfig
sh                            titan_defconfig
arm                             rpc_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arc                        vdk_hs38_defconfig
sparc                       sparc32_defconfig
mips                        vocore2_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                            zeus_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
arm                             pxa_defconfig
powerpc                     tqm8540_defconfig
microblaze                      mmu_defconfig
arm                       netwinder_defconfig
arm                          imote2_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8541_defconfig
sh                   sh7770_generic_defconfig
arm                       imx_v4_v5_defconfig
sh                          sdk7786_defconfig
powerpc                        icon_defconfig
sh                          urquell_defconfig
mips                        qi_lb60_defconfig
arm                        magician_defconfig
arm                      jornada720_defconfig
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
x86_64               randconfig-a014-20210825
x86_64               randconfig-a015-20210825
x86_64               randconfig-a016-20210825
x86_64               randconfig-a013-20210825
x86_64               randconfig-a012-20210825
x86_64               randconfig-a011-20210825
i386                 randconfig-a011-20210825
i386                 randconfig-a016-20210825
i386                 randconfig-a012-20210825
i386                 randconfig-a014-20210825
i386                 randconfig-a013-20210825
i386                 randconfig-a015-20210825
arc                  randconfig-r043-20210825
riscv                randconfig-r042-20210825
s390                 randconfig-r044-20210825
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210825
x86_64               randconfig-a001-20210825
x86_64               randconfig-a006-20210825
x86_64               randconfig-a003-20210825
x86_64               randconfig-a004-20210825
x86_64               randconfig-a002-20210825
i386                 randconfig-a006-20210825
i386                 randconfig-a001-20210825
i386                 randconfig-a002-20210825
i386                 randconfig-a005-20210825
i386                 randconfig-a004-20210825
i386                 randconfig-a003-20210825

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
