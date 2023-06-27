Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA073F025
	for <lists+cgroups@lfdr.de>; Tue, 27 Jun 2023 03:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjF0BKi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jun 2023 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjF0BKh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jun 2023 21:10:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB207134
        for <cgroups@vger.kernel.org>; Mon, 26 Jun 2023 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828235; x=1719364235;
  h=date:from:to:cc:subject:message-id;
  bh=ebMBGXQTGSaAjugh/rasbClsVr4wElXAG24G1DwSySE=;
  b=V2t/zvtaq1lKth/N2WLnsleY5HjCXATfezXyCRen73wFMMYwKvkaap9z
   Z1DzKbuCQfjedvR4vyQcnaZckUNxlMNqcXRZroba/t04ry5/fVhGt1yeu
   Cz4g6mR1AtkHoE9quvTDKo38fEG0cu/mbQiZwsuZIv4FXcrYgQF0xkV/F
   T8fNB3uPZoY3hGQ4nyr39bl6Y0HfdbWNlth1Lfs4bXlILbAjD6FZaEyJh
   o716/rVL0FsOeYmy0HlQ3/rYe0KwOcasDTFq3CpXnvLN3u/q2WGL2bpkU
   Pgs7DuB5rHtZLUhXLAs+a6mIQvTP55xkNxkXEsaaxD3Nqu7kKISTe2fz9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447820873"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="447820873"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840490398"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="840490398"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 18:10:33 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxE0-000B9v-2L;
        Tue, 27 Jun 2023 01:10:32 +0000
Date:   Tue, 27 Jun 2023 09:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 fd99fa7cff4d1676998196298f1aa08700433522
Message-ID: <202306270941.om0qEO2q-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: fd99fa7cff4d1676998196298f1aa08700433522  Merge branch 'for-6.5' into for-next

elapsed time: 6078m

configs tested: 177
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r003-20230622   gcc  
arc                  randconfig-r043-20230622   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                      integrator_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                       netwinder_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r046-20230622   clang
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230622   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230622   clang
hexagon              randconfig-r045-20230622   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230622   clang
i386         buildonly-randconfig-r005-20230622   clang
i386         buildonly-randconfig-r006-20230622   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230622   clang
i386                 randconfig-i002-20230622   clang
i386                 randconfig-i003-20230622   clang
i386                 randconfig-i004-20230622   clang
i386                 randconfig-i005-20230622   clang
i386                 randconfig-i006-20230622   clang
i386                 randconfig-i011-20230622   gcc  
i386                 randconfig-i012-20230622   gcc  
i386                 randconfig-i013-20230622   gcc  
i386                 randconfig-i014-20230622   gcc  
i386                 randconfig-i015-20230622   gcc  
i386                 randconfig-i016-20230622   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230622   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze           randconfig-r012-20230622   gcc  
microblaze           randconfig-r014-20230622   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r035-20230622   gcc  
mips                           xway_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230622   gcc  
nios2                randconfig-r025-20230621   gcc  
nios2                randconfig-r033-20230622   gcc  
openrisc             randconfig-r004-20230622   gcc  
openrisc             randconfig-r015-20230622   gcc  
openrisc             randconfig-r016-20230622   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r021-20230621   gcc  
parisc               randconfig-r026-20230621   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r022-20230621   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230622   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230622   clang
s390                 randconfig-r023-20230621   clang
s390                 randconfig-r044-20230622   gcc  
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r031-20230622   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r036-20230622   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230622   clang
x86_64       buildonly-randconfig-r002-20230622   clang
x86_64       buildonly-randconfig-r003-20230622   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230622   clang
x86_64               randconfig-r034-20230622   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
