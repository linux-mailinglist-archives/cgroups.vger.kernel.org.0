Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7775159A6
	for <lists+cgroups@lfdr.de>; Sat, 30 Apr 2022 03:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382005AbiD3Btx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Apr 2022 21:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbiD3Btv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Apr 2022 21:49:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDE14016
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 18:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651283191; x=1682819191;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=z1wYF2kjQXly2YOsiw5KfFNorNDFoeG0VdiKGBGhixw=;
  b=YuzcWQU8n0ikesp2F1jAJ4PCuuo+U1gt1+08huDDsTtKXpkcqUd7T/Bp
   eTmjWxApaVB94+krWqxwJTw3siNVvbuy6Tya+KDczcOOZb9L924DCmDa7
   mPBKRgpTV4Zk4GPXlpS0kzOEJC5ORktHDg5Yrf7K4dk5Y1MT7ZIuwEabA
   xlio4ZmLzfcx7sU7iqRK1oS7okdiVKpMYDK2TAImemASJHiTYyTlTgoNL
   joz6R+mE7pfLobGmJMCmOvdVcDcYWRzVDgGDALyWF0A/MxT8gqB9ffwmv
   mS44qiI82dXSdHJXbWLoAtmNN/yHx/tol25m6FukiWyUgQvz8FjqXsgcc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="248751198"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="248751198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 18:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="652011214"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2022 18:46:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkcBp-0006ln-0P;
        Sat, 30 Apr 2022 01:46:29 +0000
Date:   Sat, 30 Apr 2022 09:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5c26993c31f0f726aa1f90158f17ec95069b7cb2
Message-ID: <626c94d4.SOGEfn36ZhwK2Mvh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5c26993c31f0f726aa1f90158f17ec95069b7cb2  cgroup: Add config file to cgroup selftest suite

elapsed time: 6191m

configs tested: 330
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                 randconfig-c004-20220425
i386                 randconfig-c001-20220425
i386                          randconfig-c001
ia64                          tiger_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
nios2                               defconfig
mips                     decstation_defconfig
m68k                            q40_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
sh                           se7206_defconfig
mips                         cobalt_defconfig
powerpc                       ppc64_defconfig
powerpc                    amigaone_defconfig
sh                        sh7785lcr_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
sh                               j2_defconfig
arm                        cerfcube_defconfig
sh                           se7751_defconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
arm                      integrator_defconfig
arc                              alldefconfig
arm                           sunxi_defconfig
s390                             allmodconfig
sh                          rsk7264_defconfig
mips                  maltasmvp_eva_defconfig
mips                      maltasmvp_defconfig
arm                        clps711x_defconfig
arm                        spear6xx_defconfig
sh                         ecovec24_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
arm                           viper_defconfig
h8300                            alldefconfig
arm                            xcep_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        sh7763rdp_defconfig
openrisc                  or1klitex_defconfig
mips                       bmips_be_defconfig
arm                         lpc18xx_defconfig
arm                          pxa910_defconfig
powerpc                     ep8248e_defconfig
s390                                defconfig
mips                         tb0226_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
powerpc                    adder875_defconfig
sh                           se7619_defconfig
sh                   secureedge5410_defconfig
sh                          r7780mp_defconfig
sh                     magicpanelr2_defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
sh                             sh03_defconfig
arm                       imx_v6_v7_defconfig
ia64                      gensparse_defconfig
m68k                            mac_defconfig
i386                             alldefconfig
powerpc                     tqm8541_defconfig
powerpc                       holly_defconfig
mips                            gpr_defconfig
arc                           tb10x_defconfig
xtensa                          iss_defconfig
arm                            lart_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
alpha                               defconfig
arm                             pxa_defconfig
arm                        keystone_defconfig
arm                         vf610m4_defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
sh                          sdk7786_defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
m68k                       m5249evb_defconfig
xtensa                              defconfig
arm                          iop32x_defconfig
sparc                               defconfig
arm                        mini2440_defconfig
sh                ecovec24-romimage_defconfig
sh                         ap325rxa_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
arc                     nsimosci_hs_defconfig
xtensa                           alldefconfig
arm                          gemini_defconfig
sh                          kfr2r09_defconfig
m68k                       bvme6000_defconfig
sh                          landisk_defconfig
arc                         haps_hs_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc837x_mds_defconfig
arc                            hsdk_defconfig
arm                            qcom_defconfig
arm                          simpad_defconfig
m68k                          sun3x_defconfig
nios2                            allyesconfig
m68k                                defconfig
sh                          rsk7201_defconfig
arm                        oxnas_v6_defconfig
arm                        multi_v7_defconfig
microblaze                          defconfig
powerpc                     pq2fads_defconfig
m68k                       m5208evb_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                            pleb_defconfig
ia64                             alldefconfig
parisc                              defconfig
sh                          lboxre2_defconfig
arm                         nhk8815_defconfig
sh                           sh2007_defconfig
powerpc                     asp8347_defconfig
m68k                        mvme147_defconfig
h8300                       h8s-sim_defconfig
sparc64                          alldefconfig
sh                           se7750_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
riscv                            allmodconfig
arc                      axs103_smp_defconfig
m68k                             alldefconfig
arm                           h3600_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                   currituck_defconfig
powerpc                      cm5200_defconfig
arm                           tegra_defconfig
sh                            hp6xx_defconfig
openrisc                 simple_smp_defconfig
xtensa                  cadence_csp_defconfig
m68k                        mvme16x_defconfig
arm                        mvebu_v7_defconfig
parisc64                            defconfig
sh                          sdk7780_defconfig
arm                      footbridge_defconfig
mips                       capcella_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                   rts7751r2dplus_defconfig
arm                         lubbock_defconfig
arc                     haps_hs_smp_defconfig
xtensa                  nommu_kc705_defconfig
arc                                 defconfig
mips                          rb532_defconfig
x86_64                           alldefconfig
openrisc                    or1ksim_defconfig
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220429
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
i386                 randconfig-a014-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a011-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
arc                  randconfig-r043-20220428
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz

clang tested configs:
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
riscv                randconfig-c006-20220427
mips                 randconfig-c004-20220427
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220427
powerpc              randconfig-c003-20220427
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
mips                          ath79_defconfig
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
mips                     loongson2k_defconfig
arm                        vexpress_defconfig
powerpc                  mpc866_ads_defconfig
arm                          pxa168_defconfig
powerpc                    socrates_defconfig
arm                            dove_defconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       aspeed_g4_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
arm                        magician_defconfig
powerpc                       ebony_defconfig
powerpc                        icon_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
arm                       cns3420vb_defconfig
arm                     davinci_all_defconfig
arm                         bcm2835_defconfig
mips                malta_qemu_32r6_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
mips                           ip22_defconfig
powerpc                  mpc885_ads_defconfig
arm                       imx_v4_v5_defconfig
powerpc                          allyesconfig
powerpc                      katmai_defconfig
powerpc                     pseries_defconfig
mips                       lemote2f_defconfig
powerpc                     kmeter1_defconfig
x86_64                           allyesconfig
powerpc                        fsp2_defconfig
mips                      malta_kvm_defconfig
mips                           ip27_defconfig
mips                       rbtx49xx_defconfig
powerpc                          allmodconfig
powerpc                 mpc8560_ads_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
mips                         tb0287_defconfig
powerpc                 linkstation_defconfig
mips                        workpad_defconfig
mips                      bmips_stb_defconfig
arm                       versatile_defconfig
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a006-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a003-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220425
hexagon              randconfig-r045-20220425
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
