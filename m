Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2192F8CAA
	for <lists+cgroups@lfdr.de>; Sat, 16 Jan 2021 10:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbhAPJgy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Jan 2021 04:36:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:31624 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbhAPJgx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 16 Jan 2021 04:36:53 -0500
IronPort-SDR: xWum5sV2EEVS0quQAcloY8OVE8/9sNRuQztBTwq7sSTjNe5tD+vnweTX65S841nUCOIirSjluG
 gT+zxQzd8vQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="165742492"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="scan'208";a="165742492"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 01:36:12 -0800
IronPort-SDR: hElq8B9l668AupGfAtmPa8nIxU7EIM6NsnjvzHJnUUAIrolgTdHsXocEzQhwM8Z5eGa2Hnf+0n
 z6xP9GAi2xNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="scan'208";a="354620331"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2021 01:36:10 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0i09-0000ps-OK; Sat, 16 Jan 2021 09:36:09 +0000
Date:   Sat, 16 Jan 2021 17:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.12] BUILD SUCCESS
 415de5fdeb5ac28c2960df85b749700560dcd63c
Message-ID: <6002b368.T6v6eXc/GwgKR2DC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.12
branch HEAD: 415de5fdeb5ac28c2960df85b749700560dcd63c  cpuset: fix typos in comments

elapsed time: 725m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
powerpc                      ppc6xx_defconfig
c6x                              alldefconfig
arm                           viper_defconfig
arc                        nsimosci_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           h3600_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       mainstone_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8548_defconfig
arm                  colibri_pxa300_defconfig
xtensa                    xip_kc705_defconfig
arm                             rpc_defconfig
sparc64                             defconfig
powerpc                      ppc44x_defconfig
arm                          gemini_defconfig
mips                     decstation_defconfig
csky                             alldefconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         cobalt_defconfig
sh                          r7785rp_defconfig
arm                          pcm027_defconfig
sparc64                          alldefconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
mips                     cu1830-neo_defconfig
sh                   sh7724_generic_defconfig
mips                         mpc30x_defconfig
arm                          exynos_defconfig
mips                            gpr_defconfig
arm                         bcm2835_defconfig
sh                             sh03_defconfig
powerpc                     tqm8555_defconfig
mips                           ip32_defconfig
sh                          kfr2r09_defconfig
powerpc                  storcenter_defconfig
arm                          pxa910_defconfig
powerpc                       maple_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
mips                         db1xxx_defconfig
powerpc                       holly_defconfig
mips                       rbtx49xx_defconfig
csky                                defconfig
sh                           se7206_defconfig
powerpc                 mpc8560_ads_defconfig
mips                     loongson1c_defconfig
c6x                         dsk6455_defconfig
m68k                             allmodconfig
mips                           jazz_defconfig
sh                            titan_defconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
arc                        nsim_700_defconfig
arm                        mini2440_defconfig
sh                           se7780_defconfig
powerpc                          g5_defconfig
mips                        nlm_xlr_defconfig
ia64                            zx1_defconfig
sh                           se7619_defconfig
mips                           ip28_defconfig
arc                              allyesconfig
mips                           ip27_defconfig
powerpc                     kmeter1_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
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
x86_64               randconfig-a004-20210115
x86_64               randconfig-a006-20210115
x86_64               randconfig-a001-20210115
x86_64               randconfig-a003-20210115
x86_64               randconfig-a005-20210115
x86_64               randconfig-a002-20210115
i386                 randconfig-a002-20210115
i386                 randconfig-a005-20210115
i386                 randconfig-a006-20210115
i386                 randconfig-a001-20210115
i386                 randconfig-a003-20210115
i386                 randconfig-a004-20210115
i386                 randconfig-a012-20210115
i386                 randconfig-a011-20210115
i386                 randconfig-a016-20210115
i386                 randconfig-a015-20210115
i386                 randconfig-a013-20210115
i386                 randconfig-a014-20210115
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
x86_64               randconfig-a015-20210115
x86_64               randconfig-a012-20210115
x86_64               randconfig-a013-20210115
x86_64               randconfig-a016-20210115
x86_64               randconfig-a014-20210115
x86_64               randconfig-a011-20210115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
