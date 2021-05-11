Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44E237A7F3
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEKNpo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 09:45:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:7375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhEKNpn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 09:45:43 -0400
IronPort-SDR: 34Kwl3g+ShEgO4iakil4z8M70sKBLcJnd2wnA70y5lfsTSgkf5QKcvPfA3Dsvt1mb0+rWT8P/h
 XNcUZ8EkLABw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199507347"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199507347"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 06:44:36 -0700
IronPort-SDR: 2K7KhiNeziRKnysmIEj9fs4SAKWyjYCoR3YZJcK3wuN+jSEjrRbP03uoRHsoOBDs5ZjITzbig+
 B7KcR61hLK2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="621818422"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2021 06:44:32 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgSga-0000iw-Bz; Tue, 11 May 2021 13:44:32 +0000
Date:   Tue, 11 May 2021 21:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-next] BUILD SUCCESS
 f4f809f66b7545b89bff4b132cdb37adc2d2c157
Message-ID: <609a8a20.UuuJrcaUNcUxbg1e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: f4f809f66b7545b89bff4b132cdb37adc2d2c157  cgroup: inline cgroup_task_freeze()

elapsed time: 723m

configs tested: 236
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
powerpc                    amigaone_defconfig
nios2                            allyesconfig
mips                      malta_kvm_defconfig
arm                           u8500_defconfig
sh                            hp6xx_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                                defconfig
ia64                      gensparse_defconfig
arm                        neponset_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     pseries_defconfig
powerpc                  storcenter_defconfig
arm                      footbridge_defconfig
mips                            gpr_defconfig
arm                            qcom_defconfig
sh                          urquell_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
riscv                             allnoconfig
powerpc64                           defconfig
powerpc                     ep8248e_defconfig
mips                      bmips_stb_defconfig
mips                         tb0226_defconfig
arm                          gemini_defconfig
arm                          pcm027_defconfig
powerpc                     tqm8540_defconfig
sh                              ul2_defconfig
riscv                          rv32_defconfig
arm                          pxa3xx_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
sh                   sh7770_generic_defconfig
arm                              alldefconfig
arm                         hackkit_defconfig
m68k                        m5407c3_defconfig
arm                        multi_v5_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
powerpc                      mgcoge_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8555_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
sh                        sh7757lcr_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
mips                          ath25_defconfig
sh                            migor_defconfig
sh                          polaris_defconfig
sparc                            allyesconfig
mips                       capcella_defconfig
arm                           sunxi_defconfig
sh                           se7705_defconfig
arm                       mainstone_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
parisc                generic-32bit_defconfig
arm                        mvebu_v7_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                            pleb_defconfig
sh                          sdk7780_defconfig
h8300                            alldefconfig
sh                               alldefconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       holly_defconfig
sh                        apsh4ad0a_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      chrp32_defconfig
arm                         s3c6400_defconfig
um                             i386_defconfig
arc                        nsim_700_defconfig
arm                             ezx_defconfig
powerpc                 mpc834x_itx_defconfig
mips                     decstation_defconfig
arm                        magician_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arm                             mxs_defconfig
arm                           tegra_defconfig
ia64                             alldefconfig
arm                        spear3xx_defconfig
sh                          lboxre2_defconfig
nios2                               defconfig
mips                        workpad_defconfig
arm                         axm55xx_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     skiroot_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         cm_x300_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arm                         nhk8815_defconfig
powerpc                    ge_imp3a_defconfig
arc                        vdk_hs38_defconfig
m68k                          amiga_defconfig
i386                             alldefconfig
x86_64                            allnoconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
nios2                         3c120_defconfig
arm                           stm32_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rb532_defconfig
mips                           ci20_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                        jmr3927_defconfig
s390                             allmodconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                  audio_kc705_defconfig
arm                         vf610m4_defconfig
powerpc                  mpc866_ads_defconfig
arm                           h3600_defconfig
powerpc                        fsp2_defconfig
um                               alldefconfig
powerpc                     ksi8560_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 canyonlands_defconfig
sh                           se7619_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7201_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
powerpc                   lite5200b_defconfig
mips                          rm200_defconfig
arm                          iop32x_defconfig
s390                          debug_defconfig
m68k                        m5307c3_defconfig
powerpc                 linkstation_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
sh                           sh2007_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8541_defconfig
sh                          r7785rp_defconfig
mips                        omega2p_defconfig
arm                          imote2_defconfig
riscv                    nommu_k210_defconfig
mips                           rs90_defconfig
powerpc                    gamecube_defconfig
arm                      pxa255-idp_defconfig
arm                         assabet_defconfig
powerpc                     kilauea_defconfig
mips                        bcm63xx_defconfig
xtensa                    xip_kc705_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
mips                           gcw0_defconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
arm                      jornada720_defconfig
arm                      tct_hammer_defconfig
arm                     am200epdkit_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
i386                 randconfig-a016-20210511
i386                 randconfig-a014-20210511
i386                 randconfig-a011-20210511
i386                 randconfig-a015-20210511
i386                 randconfig-a012-20210511
i386                 randconfig-a013-20210511
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                                  defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
