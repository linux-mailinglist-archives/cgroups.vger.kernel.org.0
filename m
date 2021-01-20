Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11A2FCACD
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 06:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbhATFlY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jan 2021 00:41:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:13718 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbhATFlW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Jan 2021 00:41:22 -0500
IronPort-SDR: z17Wvn3qXvtzUcjXil6ZsPrb5cnzc8dd7uU4UMVfTKtzjeKVhXwuA82ArsArbdeqhI9DqkbWJB
 IJOf5c6U/bjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179198506"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="179198506"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 21:40:41 -0800
IronPort-SDR: LeQ2pVOlXnaZzgc5Q3Au1tclADVvW77AROeFOyHdSGnN+vKrupWlmLsj5fLdvp/YP6+HzY6/5y
 wgD3QmXLbMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="350928018"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2021 21:40:40 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l26ER-0005c0-N3; Wed, 20 Jan 2021 05:40:39 +0000
Date:   Wed, 20 Jan 2021 13:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.11-fixes] BUILD SUCCESS
 74bdd45c85d02f695a1cd1c3dccf8b3960a86d8f
Message-ID: <6007c235.LS2ZV4U7mRvJ0SHA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11-fixes
branch HEAD: 74bdd45c85d02f695a1cd1c3dccf8b3960a86d8f  cgroup: update PSI file description in docs

elapsed time: 720m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           gcw0_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
powerpc                      bamboo_defconfig
sh                           sh2007_defconfig
powerpc                      pmac32_defconfig
mips                           ci20_defconfig
arm                           sunxi_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
powerpc                       maple_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
powerpc                    adder875_defconfig
arm                            hisi_defconfig
arm                         palmz72_defconfig
powerpc                     sbc8548_defconfig
c6x                        evmc6472_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         cobalt_defconfig
arm                           corgi_defconfig
m68k                        m5407c3_defconfig
m68k                          amiga_defconfig
powerpc                      cm5200_defconfig
arm                       omap2plus_defconfig
sh                          polaris_defconfig
powerpc                     pq2fads_defconfig
powerpc                       eiger_defconfig
arc                              alldefconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
parisc                generic-64bit_defconfig
arm                           stm32_defconfig
sh                           se7780_defconfig
arm                        spear6xx_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120
x86_64               randconfig-a015-20210119
x86_64               randconfig-a013-20210119
x86_64               randconfig-a012-20210119
x86_64               randconfig-a016-20210119
x86_64               randconfig-a011-20210119
x86_64               randconfig-a014-20210119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
