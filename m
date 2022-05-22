Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E253006A
	for <lists+cgroups@lfdr.de>; Sun, 22 May 2022 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiEVDjE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 23:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiEVDjD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 23:39:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3419003
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653190741; x=1684726741;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dRZu2bgfr4jOw23MukwAF8tRG9FZp6QMgKTPDwMIAp4=;
  b=ElfNH+OfTP4z40jR7cfcWPEqEpXFGXZR4CDNU6YArs484UHNimw9zzvL
   uwCFurWXwQ97VqmCX781yCsJB6Bryu0CwJy3iuXoOb806nbXTLasVNBG5
   9U5d8CGvl6FzSXlTLrIxjqot80eZ47R/oZ0ODCvmhbv5IRkeVHiNACczI
   5svRA4lQMrrtgBE1uijGYwIlkD3QROn8PmmBHl4ibMY7gw/7aLWlpxKh8
   4YK+LvknXv1hycKy/pW2HliiQU1vpgk8WzkpY74oybwy9mW27JCWsLWlF
   JHHTy/KQhKwHxeqydGtVDl5dPPsZaSXgr+dXY8TuVZfwjNu8xh63OTvYu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="254993687"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="254993687"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 20:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="558093280"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2022 20:38:59 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nscQl-0006tM-1X;
        Sun, 22 May 2022 03:38:59 +0000
Date:   Sun, 22 May 2022 11:37:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.19] BUILD SUCCESS
 b154a017c92011d8f71ce804583e5f9c3d90bb9a
Message-ID: <6289b017.0wpYGXsFcoY57SCk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19
branch HEAD: b154a017c92011d8f71ce804583e5f9c3d90bb9a  cgroup: remove the superfluous judgment

elapsed time: 2599m

configs tested: 248
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc64                           defconfig
arc                                 defconfig
powerpc                     asp8347_defconfig
m68k                            mac_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
arm                            pleb_defconfig
sh                            titan_defconfig
sh                            migor_defconfig
sh                               j2_defconfig
um                                  defconfig
um                               alldefconfig
arm                        shmobile_defconfig
mips                      maltasmvp_defconfig
powerpc                    sam440ep_defconfig
powerpc                      cm5200_defconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
sh                          rsk7269_defconfig
powerpc                     pq2fads_defconfig
parisc                           allyesconfig
mips                           ci20_defconfig
xtensa                          iss_defconfig
s390                             allyesconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
mips                  maltasmvp_eva_defconfig
riscv                            allyesconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
arm                        mini2440_defconfig
xtensa                           allyesconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
arm                           tegra_defconfig
ia64                          tiger_defconfig
sh                           se7750_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
h8300                            allyesconfig
arm                          badge4_defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sequoia_defconfig
sh                         microdev_defconfig
arm                      jornada720_defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
sh                           se7206_defconfig
powerpc                         wii_defconfig
mips                        bcm47xx_defconfig
powerpc                     taishan_defconfig
um                           x86_64_defconfig
powerpc                        warp_defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
alpha                               defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
arm                        realview_defconfig
arm                            qcom_defconfig
sh                           se7343_defconfig
nios2                            alldefconfig
arc                        nsimosci_defconfig
powerpc                     stx_gp3_defconfig
sparc64                          alldefconfig
i386                                defconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          urquell_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
mips                             allyesconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
powerpc                       eiger_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   motionpro_defconfig
arc                          axs103_defconfig
s390                       zfcpdump_defconfig
arm                           sama5_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                     edosk2674_defconfig
arc                           tb10x_defconfig
m68k                          multi_defconfig
arm                             pxa_defconfig
m68k                        mvme147_defconfig
arm                        keystone_defconfig
openrisc                 simple_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                       holly_defconfig
arc                          axs101_defconfig
powerpc                     rainier_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
m68k                           sun3_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                         3c120_defconfig
m68k                          sun3x_defconfig
sh                        sh7757lcr_defconfig
powerpc                      ppc6xx_defconfig
m68k                          amiga_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
arm                  randconfig-c002-20220522
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220519
arc                  randconfig-r043-20220522
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
s390                 randconfig-c005-20220519
arm                  randconfig-c002-20220522
s390                 randconfig-c005-20220522
powerpc              randconfig-c003-20220522
riscv                randconfig-c006-20220522
mips                 randconfig-c004-20220522
powerpc                          g5_defconfig
hexagon                             defconfig
mips                      pic32mzda_defconfig
arm                          ep93xx_defconfig
mips                     loongson2k_defconfig
mips                      malta_kvm_defconfig
arm                              alldefconfig
arm                          ixp4xx_defconfig
powerpc                     tqm5200_defconfig
i386                             allyesconfig
powerpc                    socrates_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
arm                         mv78xx0_defconfig
powerpc                    ge_imp3a_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   bluestone_defconfig
powerpc                      katmai_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
arm                       spear13xx_defconfig
mips                           rs90_defconfig
powerpc                          allmodconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220519
hexagon              randconfig-r041-20220519
hexagon              randconfig-r045-20220522
hexagon              randconfig-r041-20220522
riscv                randconfig-r042-20220519
s390                 randconfig-r044-20220519
hexagon              randconfig-r045-20220521
hexagon              randconfig-r041-20220521
s390                 randconfig-r044-20220521
riscv                randconfig-r042-20220521

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
