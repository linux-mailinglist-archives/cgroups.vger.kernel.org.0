Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380B48DBB0
	for <lists+cgroups@lfdr.de>; Thu, 13 Jan 2022 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiAMQ0Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 11:26:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:51006 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236520AbiAMQ0Y (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 Jan 2022 11:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642091184; x=1673627184;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gBq4m4zhBGWa7wPSPlkC8swdh6SNgrYfbHPlXejXkIc=;
  b=No23wV4exdyTjXXYXGnlclJ2ou/EUzl2TRDFUaHJZwY2eK0h8+roT5UQ
   rO9I1M5fuvxMBtgxtYLRbv5f/++aPMO73PCwFAKR/tZC1kADOhk8yhO2z
   /q4AtVDqxrHFxbuoDlQwu8wTPX6J4f3zuHd82hWNX9OBORCPhBxASKDC+
   QVfer5fc6LYnFqMp63bVXMHRA/ZhxngdNjAzunWjynJ/TaIe6y8e34CLD
   AmlTMvheEf5I9FWQbdBdzTJuXX6jqD++eOgz5l2nkosbKdE48LS41spQ8
   6KVbh/FZ8GF2eDAq5BcVAqAhm8kRpSoCNQpJC0diLg/toZZMO0qZbVvli
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307388044"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307388044"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 08:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="491179430"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 08:25:57 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n82vE-0007RR-HN; Thu, 13 Jan 2022 16:25:56 +0000
Date:   Fri, 14 Jan 2022 00:25:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 27fe872b5169140b93c5eecd9ebd4fac7f5475ac
Message-ID: <61e05264.ZDaz+iGmEVXG4Hz2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 27fe872b5169140b93c5eecd9ebd4fac7f5475ac  Merge branch 'for-5.17-fixes' into for-next

elapsed time: 1132m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
m68k                             alldefconfig
sh                          sdk7780_defconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
mips                  maltasmvp_eva_defconfig
sh                               alldefconfig
powerpc                      mgcoge_defconfig
arm                            lart_defconfig
powerpc                    klondike_defconfig
arm                           stm32_defconfig
powerpc                      bamboo_defconfig
csky                             alldefconfig
sparc                       sparc32_defconfig
sh                          rsk7269_defconfig
um                           x86_64_defconfig
sh                               j2_defconfig
powerpc64                        alldefconfig
mips                     decstation_defconfig
powerpc                       holly_defconfig
csky                                defconfig
powerpc                        warp_defconfig
m68k                       m5475evb_defconfig
mips                             allyesconfig
arm                            pleb_defconfig
arm                        trizeps4_defconfig
sh                           se7705_defconfig
mips                         mpc30x_defconfig
nios2                            alldefconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
arm                           tegra_defconfig
arm                          badge4_defconfig
sh                   sh7770_generic_defconfig
arm                          exynos_defconfig
ia64                             allmodconfig
sh                         apsh4a3a_defconfig
mips                           xway_defconfig
powerpc                       ppc64_defconfig
arm                          simpad_defconfig
sh                             sh03_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                  nommu_kc705_defconfig
sh                          r7785rp_defconfig
arm                            hisi_defconfig
powerpc                       maple_defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
sh                           se7780_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
m68k                         amcore_defconfig
sh                          rsk7264_defconfig
sh                          kfr2r09_defconfig
um                             i386_defconfig
h8300                               defconfig
arm                  randconfig-c002-20220113
arm                  randconfig-c002-20220112
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
h8300                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
powerpc                     ppa8548_defconfig
mips                        bcm63xx_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pmac32_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113
hexagon              randconfig-r045-20220112
riscv                randconfig-r042-20220112
hexagon              randconfig-r041-20220112

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
