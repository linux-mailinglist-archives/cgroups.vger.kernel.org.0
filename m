Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A393D7413
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhG0LOX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 07:14:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:42467 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236284AbhG0LOX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 07:14:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="297996097"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="297996097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 04:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="580177267"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2021 04:14:21 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8L2T-0006jm-5K; Tue, 27 Jul 2021 11:14:21 +0000
Date:   Tue, 27 Jul 2021 19:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:test-merge-for-5.14-fixes] BUILD SUCCESS
 4cdbdc40f6399de911db4fd3b8e699f5ece560b7
Message-ID: <60ffea3c.I4Iu5zyqhqEfRmvy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-5.14-fixes
branch HEAD: 4cdbdc40f6399de911db4fd3b8e699f5ece560b7  Merge branch 'for-5.14-fixes' into test-merge-for-5.14-fixes

elapsed time: 721m

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
i386                 randconfig-c001-20210726
i386                 randconfig-c001-20210727
arm                            zeus_defconfig
arm                             mxs_defconfig
mips                          ath25_defconfig
arm                       spear13xx_defconfig
um                                  defconfig
arm                         lpc18xx_defconfig
powerpc                    socrates_defconfig
powerpc                       holly_defconfig
xtensa                          iss_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
powerpc                     mpc5200_defconfig
sh                      rts7751r2d1_defconfig
h8300                     edosk2674_defconfig
powerpc                      cm5200_defconfig
mips                         mpc30x_defconfig
powerpc                         wii_defconfig
arm64                            alldefconfig
parisc                generic-64bit_defconfig
arm                           omap1_defconfig
arm                             ezx_defconfig
arc                          axs103_defconfig
nds32                             allnoconfig
arc                        vdk_hs38_defconfig
m68k                       m5249evb_defconfig
sh                          sdk7786_defconfig
arm                         mv78xx0_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
riscv                    nommu_virt_defconfig
m68k                        mvme147_defconfig
sh                     magicpanelr2_defconfig
powerpc                 linkstation_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
ia64                             alldefconfig
sparc                               defconfig
parisc                              defconfig
mips                      pic32mzda_defconfig
xtensa                  audio_kc705_defconfig
mips                           ci20_defconfig
arm                      jornada720_defconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
powerpc                     stx_gp3_defconfig
arm                  colibri_pxa300_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     ep8248e_defconfig
mips                           ip27_defconfig
mips                         bigsur_defconfig
sh                        sh7763rdp_defconfig
x86_64                              defconfig
openrisc                  or1klitex_defconfig
sh                             espt_defconfig
s390                             allmodconfig
sh                              ul2_defconfig
mips                        nlm_xlp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210726
x86_64               randconfig-a006-20210726
x86_64               randconfig-a001-20210726
x86_64               randconfig-a005-20210726
x86_64               randconfig-a004-20210726
x86_64               randconfig-a002-20210726
i386                 randconfig-a005-20210726
i386                 randconfig-a003-20210726
i386                 randconfig-a004-20210726
i386                 randconfig-a002-20210726
i386                 randconfig-a001-20210726
i386                 randconfig-a006-20210726
i386                 randconfig-a005-20210727
i386                 randconfig-a003-20210727
i386                 randconfig-a004-20210727
i386                 randconfig-a002-20210727
i386                 randconfig-a001-20210727
i386                 randconfig-a006-20210727
x86_64               randconfig-a011-20210727
x86_64               randconfig-a016-20210727
x86_64               randconfig-a013-20210727
x86_64               randconfig-a014-20210727
x86_64               randconfig-a012-20210727
x86_64               randconfig-a015-20210727
i386                 randconfig-a016-20210727
i386                 randconfig-a013-20210727
i386                 randconfig-a012-20210727
i386                 randconfig-a011-20210727
i386                 randconfig-a014-20210727
i386                 randconfig-a015-20210727
i386                 randconfig-a016-20210726
i386                 randconfig-a013-20210726
i386                 randconfig-a012-20210726
i386                 randconfig-a011-20210726
i386                 randconfig-a014-20210726
i386                 randconfig-a015-20210726
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210726
x86_64               randconfig-a011-20210726
x86_64               randconfig-a016-20210726
x86_64               randconfig-a013-20210726
x86_64               randconfig-a014-20210726
x86_64               randconfig-a012-20210726
x86_64               randconfig-a015-20210726

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
