Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED13D1D2A
	for <lists+cgroups@lfdr.de>; Thu, 22 Jul 2021 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhGVEOm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jul 2021 00:14:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:40612 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhGVEOi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Jul 2021 00:14:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="233375268"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="233375268"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 21:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="495594010"
Received: from lkp-server01.sh.intel.com (HELO b8b92b2878b0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2021 21:54:16 -0700
Received: from kbuild by b8b92b2878b0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6Qiu-0000rj-34; Thu, 22 Jul 2021 04:54:16 +0000
Date:   Thu, 22 Jul 2021 12:53:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.14-fixes] BUILD SUCCESS
 1e7107c5ef44431bc1ebbd4c353f1d7c22e5f2ec
Message-ID: <60f8f9ce.01G8Z73qSPaVf01V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14-fixes
branch HEAD: 1e7107c5ef44431bc1ebbd4c353f1d7c22e5f2ec  cgroup1: fix leaked context root causing sporadic NULL deref in LTP

elapsed time: 730m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      fuloong2e_defconfig
powerpc                       ebony_defconfig
arm                            mmp2_defconfig
powerpc                  storcenter_defconfig
mips                   sb1250_swarm_defconfig
nios2                               defconfig
csky                             alldefconfig
arm                             ezx_defconfig
sh                             shx3_defconfig
sh                          rsk7201_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
powerpc                 linkstation_defconfig
sh                   sh7770_generic_defconfig
powerpc                      bamboo_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                      pasemi_defconfig
m68k                        mvme16x_defconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arc                     nsimosci_hs_defconfig
mips                         tb0287_defconfig
mips                           jazz_defconfig
sh                            titan_defconfig
arc                        nsim_700_defconfig
mips                        vocore2_defconfig
riscv                          rv32_defconfig
m68k                        m5407c3_defconfig
arm                        realview_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
openrisc                 simple_smp_defconfig
mips                           ip28_defconfig
arm64                            alldefconfig
mips                     cu1000-neo_defconfig
riscv                    nommu_virt_defconfig
mips                 decstation_r4k_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                  mpc866_ads_defconfig
arm                            pleb_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
x86_64               randconfig-a011-20210721
x86_64               randconfig-a016-20210721
x86_64               randconfig-a013-20210721
x86_64               randconfig-a014-20210721
x86_64               randconfig-a012-20210721
x86_64               randconfig-a015-20210721
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-a011-20210720
x86_64               randconfig-a016-20210720
x86_64               randconfig-a013-20210720
x86_64               randconfig-a014-20210720
x86_64               randconfig-a012-20210720
x86_64               randconfig-a015-20210720

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
