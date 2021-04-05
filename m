Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A78354142
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhDEKtg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 06:49:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:24358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhDEKtg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:36 -0400
IronPort-SDR: VQV/wYokO64i8oP/kz+TzmAvCO/684ImdEOMYvSttLR2ysOqbw0DrwnFavRDoypyx4LiMYN3j6
 VIVulb6TeDKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9944"; a="172288956"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="172288956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 03:49:29 -0700
IronPort-SDR: 5U3n5+WG7KH7pZbNzazDsK85Y4wBHFANDKspgaDDyg69rzdcOtbJTjqaBiKIzxhje9j+c/e5UB
 iZfgVJS8/4FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="395770665"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2021 03:49:28 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTMnP-0009y1-KX; Mon, 05 Apr 2021 10:49:27 +0000
Date:   Mon, 05 Apr 2021 18:49:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.13] BUILD SUCCESS
 dd3f4e4972f146a685930ccfed95e4e1d13d952a
Message-ID: <606aeb2d.J7jCUZ1mr8Sb/h/Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13
branch HEAD: dd3f4e4972f146a685930ccfed95e4e1d13d952a  cgroup: misc: mark dummy misc_cg_res_total_usage() static inline

elapsed time: 723m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         cm_x300_defconfig
powerpc                      chrp32_defconfig
arm                           sama5_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
powerpc                      pasemi_defconfig
sh                        edosk7760_defconfig
arm                          badge4_defconfig
arc                        nsimosci_defconfig
mips                     cu1000-neo_defconfig
ia64                        generic_defconfig
mips                          rb532_defconfig
m68k                           sun3_defconfig
arm                           viper_defconfig
mips                        bcm63xx_defconfig
mips                           gcw0_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      obs600_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
arm                        spear6xx_defconfig
sh                         apsh4a3a_defconfig
openrisc                            defconfig
arm                            mmp2_defconfig
sh                             shx3_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip28_defconfig
m68k                       m5249evb_defconfig
h8300                               defconfig
arm                      jornada720_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm8555_defconfig
arm                        mini2440_defconfig
powerpc                      acadia_defconfig
arm                            dove_defconfig
arm                         lpc18xx_defconfig
powerpc                      mgcoge_defconfig
sh                         microdev_defconfig
mips                      bmips_stb_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
sh                           se7712_defconfig
powerpc                        fsp2_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
s390                       zfcpdump_defconfig
mips                           ip27_defconfig
powerpc                     mpc83xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210405
i386                 randconfig-a003-20210405
i386                 randconfig-a001-20210405
i386                 randconfig-a004-20210405
i386                 randconfig-a002-20210405
i386                 randconfig-a005-20210405
x86_64               randconfig-a014-20210405
x86_64               randconfig-a015-20210405
x86_64               randconfig-a013-20210405
x86_64               randconfig-a011-20210405
x86_64               randconfig-a012-20210405
x86_64               randconfig-a016-20210405
i386                 randconfig-a016-20210405
i386                 randconfig-a015-20210405
i386                 randconfig-a014-20210405
i386                 randconfig-a011-20210405
i386                 randconfig-a012-20210405
i386                 randconfig-a013-20210405
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-a004-20210405
x86_64               randconfig-a003-20210405
x86_64               randconfig-a005-20210405
x86_64               randconfig-a001-20210405
x86_64               randconfig-a002-20210405
x86_64               randconfig-a006-20210405

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
