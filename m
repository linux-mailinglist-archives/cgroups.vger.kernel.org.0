Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBD462CB9
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 07:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhK3GZy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 01:25:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:50090 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238511AbhK3GZy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Nov 2021 01:25:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234877583"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="234877583"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="609018041"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2021 22:22:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrwXA-000Cr7-GA; Tue, 30 Nov 2021 06:22:32 +0000
Date:   Tue, 30 Nov 2021 14:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 8291471ea5f1b2e6782cbb9c6ed785f12435245f
Message-ID: <61a5c314.hSuaRqwO40V7ab0q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 8291471ea5f1b2e6782cbb9c6ed785f12435245f  cgroup: get the wrong css for css_alloc() during cgroup_init_subsys()

elapsed time: 729m

configs tested: 212
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
powerpc                      pasemi_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                    smp_lx200_defconfig
arm                          iop32x_defconfig
mips                        vocore2_defconfig
mips                       capcella_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
i386                                defconfig
arm                        multi_v5_defconfig
m68k                           sun3_defconfig
powerpc                     tqm8540_defconfig
um                                  defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      cm5200_defconfig
mips                        qi_lb60_defconfig
mips                         cobalt_defconfig
powerpc                     akebono_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                          rm200_defconfig
sh                   sh7770_generic_defconfig
arm                          lpd270_defconfig
arm                            xcep_defconfig
mips                      loongson3_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
mips                         tb0219_defconfig
arm                            qcom_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
powerpc                      makalu_defconfig
s390                       zfcpdump_defconfig
mips                      pic32mzda_defconfig
sparc64                          alldefconfig
arm                           viper_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
powerpc                         wii_defconfig
mips                       rbtx49xx_defconfig
sh                          rsk7201_defconfig
arm                        mvebu_v7_defconfig
x86_64                              defconfig
arm                       versatile_defconfig
microblaze                      mmu_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
powerpc                    socrates_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
mips                           ip28_defconfig
mips                  maltasmvp_eva_defconfig
m68k                        m5407c3_defconfig
arc                        nsim_700_defconfig
arm                         lubbock_defconfig
sh                     magicpanelr2_defconfig
arm                         bcm2835_defconfig
sh                               j2_defconfig
powerpc                     tqm8548_defconfig
mips                           gcw0_defconfig
arm                       imx_v6_v7_defconfig
mips                        omega2p_defconfig
mips                           rs90_defconfig
arm                           h5000_defconfig
m68k                             allyesconfig
openrisc                            defconfig
arm                          pcm027_defconfig
powerpc                        warp_defconfig
mips                 decstation_r4k_defconfig
nds32                               defconfig
arm                       imx_v4_v5_defconfig
arm                          simpad_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        spear6xx_defconfig
m68k                          amiga_defconfig
m68k                        m5272c3_defconfig
m68k                       m5249evb_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                          ixp4xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                     redwood_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
arm                           u8500_defconfig
arm                        cerfcube_defconfig
arm                  randconfig-c002-20211128
arm                  randconfig-c002-20211129
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211130
x86_64               randconfig-a006-20211130
x86_64               randconfig-a003-20211130
x86_64               randconfig-a004-20211130
x86_64               randconfig-a005-20211130
x86_64               randconfig-a002-20211130
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a011-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a016-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
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
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a003-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a006-20211128
x86_64               randconfig-a011-20211129
x86_64               randconfig-a014-20211129
x86_64               randconfig-a012-20211129
x86_64               randconfig-a016-20211129
x86_64               randconfig-a013-20211129
x86_64               randconfig-a015-20211129
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129
hexagon              randconfig-r045-20211128
hexagon              randconfig-r041-20211128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
