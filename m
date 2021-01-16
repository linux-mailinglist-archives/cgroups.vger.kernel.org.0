Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF52F8CA9
	for <lists+cgroups@lfdr.de>; Sat, 16 Jan 2021 10:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbhAPJgx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Jan 2021 04:36:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:13041 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAPJgw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 16 Jan 2021 04:36:52 -0500
IronPort-SDR: 7KkGzDXky0TUgqyDN6YzCRrEKe3JQlfM+5HQihaRMahtZnspacPabdx3QhN30nHEbVpTyzlZ7i
 tuE7DBK4ynMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="158428613"
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="scan'208";a="158428613"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 01:36:11 -0800
IronPort-SDR: Aj91uYpNUi9K/x8o7ftjxgh9mwZN8Wi1wDPLqGCNESV2JwLn9yS4ouGrj27ltyHg4yjiNzvlZZ
 pUe4Svs7MWYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,352,1602572400"; 
   d="scan'208";a="465854956"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jan 2021 01:36:10 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0i09-0000pu-PB; Sat, 16 Jan 2021 09:36:09 +0000
Date:   Sat, 16 Jan 2021 17:35:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.11-fixes] BUILD SUCCESS
 b5e56576e16236de3c035ca86cd3ef16591722fb
Message-ID: <6002b379.uzGPYyUCOOl7yg/Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11-fixes
branch HEAD: b5e56576e16236de3c035ca86cd3ef16591722fb  MAINTAINERS: Update my email address

elapsed time: 725m

configs tested: 142
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
csky                                defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc834x_itx_defconfig
arc                              allyesconfig
powerpc                      katmai_defconfig
m68k                        m5272c3_defconfig
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
