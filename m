Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685952754D
	for <lists+cgroups@lfdr.de>; Sun, 15 May 2022 06:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiEOENE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 May 2022 00:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiEOEND (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 May 2022 00:13:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464D2459B
        for <cgroups@vger.kernel.org>; Sat, 14 May 2022 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652587982; x=1684123982;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p1CK3/uDKKmdeqR2z6fmSrkexw+0f4jmfp6tbvji5Ug=;
  b=SeZMDr5Q6pcqvU9MAH/1nI6bCo2IRtAq1KA7kFqubmZUbmHVmKBD38qm
   WrSBbYl2rQNdDUC3SJk09lnJWLqlCPv6fYilWVIyo4NwvFY5/nX9Z/adp
   c7YaIvpGms+6RI8rSoSo+kQFyx+uITacj9KzrIkBKAziwuxBUqe6mTY12
   dFZBBpgxanBagO8xD1vsJb07WmXgbij25H2Eyyr14A9sENCoGnpRnYE0c
   h/ww6kaLWg/DY4UN7qUgN5ki3mP5ZXEEF8o72DdV/fX/iP7DrWXnaB+R2
   fZthUXhhBdmzz4GhRZjQgg+WC1Yw5Nxpu/ibsdUFVr4DteOPiXiy1LY1c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="333638811"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="333638811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 21:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="625456803"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 May 2022 21:12:58 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq5cn-0001Hs-9m;
        Sun, 15 May 2022 04:12:57 +0000
Date:   Sun, 15 May 2022 12:12:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.18-fixes] BUILD SUCCESS
 2685027fca387b602ae565bff17895188b803988
Message-ID: <62807da3.5hqqvPWBZFFaEUso%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18-fixes
branch HEAD: 2685027fca387b602ae565bff17895188b803988  cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in cpuset_init_smp()

elapsed time: 13465m

configs tested: 352
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220505
m68k                       m5208evb_defconfig
powerpc                      ep88xc_defconfig
arm                         at91_dt_defconfig
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                         tb0226_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
sparc64                             defconfig
m68k                       m5475evb_defconfig
arm                        shmobile_defconfig
m68k                        mvme16x_defconfig
m68k                       m5249evb_defconfig
arm                            pleb_defconfig
mips                          rb532_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
powerpc                       ppc64_defconfig
csky                             alldefconfig
mips                           ip32_defconfig
sh                             sh03_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
powerpc                     redwood_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
sh                          kfr2r09_defconfig
sh                           se7712_defconfig
sparc                       sparc32_defconfig
powerpc                     pq2fads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         axm55xx_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
sh                          landisk_defconfig
csky                                defconfig
xtensa                  nommu_kc705_defconfig
s390                       zfcpdump_defconfig
m68k                           sun3_defconfig
powerpc                      ppc40x_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
sh                         ecovec24_defconfig
sh                               allmodconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
powerpc                        warp_defconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
sparc                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
powerpc                     tqm8555_defconfig
powerpc                           allnoconfig
sh                             espt_defconfig
arm                       multi_v4t_defconfig
arm                             ezx_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7203_defconfig
nios2                         3c120_defconfig
sparc                            allyesconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     stx_gp3_defconfig
mips                           jazz_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
arm                            xcep_defconfig
riscv                            allyesconfig
arm                           viper_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
mips                     decstation_defconfig
xtensa                  cadence_csp_defconfig
arm                         assabet_defconfig
h8300                            allyesconfig
powerpc                     rainier_defconfig
sparc                               defconfig
sh                           se7750_defconfig
sh                                  defconfig
m68k                         apollo_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                  audio_kc705_defconfig
mips                         mpc30x_defconfig
arm                            zeus_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
arm                         lubbock_defconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
mips                           ci20_defconfig
mips                         bigsur_defconfig
sh                   rts7751r2dplus_defconfig
i386                                defconfig
arm                         nhk8815_defconfig
mips                      fuloong2e_defconfig
sh                          rsk7269_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
xtensa                           alldefconfig
ia64                        generic_defconfig
powerpc                   motionpro_defconfig
arm                      integrator_defconfig
nios2                         10m50_defconfig
arm                          gemini_defconfig
powerpc                      pcm030_defconfig
powerpc                       holly_defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                          lpd270_defconfig
mips                        vocore2_defconfig
arm                             pxa_defconfig
arm                         vf610m4_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
sh                        apsh4ad0a_defconfig
sh                          lboxre2_defconfig
arm                        mvebu_v7_defconfig
powerpc                       maple_defconfig
powerpc                      ppc6xx_defconfig
sh                          sdk7786_defconfig
arm                         lpc18xx_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
powerpc                      makalu_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         cm_x300_defconfig
sh                   secureedge5410_defconfig
arm                             rpc_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
arm                        trizeps4_defconfig
arm                          pxa3xx_defconfig
mips                        bcm47xx_defconfig
arm                        cerfcube_defconfig
m68k                          multi_defconfig
arc                              alldefconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
parisc                generic-64bit_defconfig
sh                     magicpanelr2_defconfig
sh                          sdk7780_defconfig
arc                         haps_hs_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       omap2plus_defconfig
powerpc                      arches_defconfig
powerpc                      bamboo_defconfig
ia64                            zx1_defconfig
powerpc64                           defconfig
sh                               j2_defconfig
powerpc                     asp8347_defconfig
h8300                               defconfig
powerpc                    sam440ep_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220508
arm                  randconfig-c002-20220505
arm                  randconfig-c002-20220507
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
mips                        omega2p_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
arm                          collie_defconfig
mips                      pic32mzda_defconfig
i386                             allyesconfig
mips                           mtx1_defconfig
arm                         socfpga_defconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
powerpc                     pseries_defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
arm                        vexpress_defconfig
arm                     davinci_all_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      walnut_defconfig
arm                             mxs_defconfig
arm                        neponset_defconfig
mips                      malta_kvm_defconfig
hexagon                             defconfig
mips                       lemote2f_defconfig
mips                  cavium_octeon_defconfig
mips                        workpad_defconfig
mips                          ath79_defconfig
arm                            mmp2_defconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
powerpc                      katmai_defconfig
arm                         s3c2410_defconfig
mips                     cu1000-neo_defconfig
arm                       aspeed_g4_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
arm                         s5pv210_defconfig
arm                       versatile_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220505
hexagon              randconfig-r041-20220505
hexagon              randconfig-r045-20220509
hexagon              randconfig-r045-20220508
riscv                randconfig-r042-20220508
hexagon              randconfig-r041-20220509
hexagon              randconfig-r041-20220508

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
