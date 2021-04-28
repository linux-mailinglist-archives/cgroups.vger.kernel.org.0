Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74D36D0F5
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 05:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhD1Drd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 23:47:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:51640 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhD1Drd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 23:47:33 -0400
IronPort-SDR: zyWwUxzkDBR/v0hgZP1IUXfEFp7y3PvVVdX3ABdFUd888xwfwBv0L2FGDnJ3U6EyG1kDOza5fV
 yFB6Rsd6OAoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196203089"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="196203089"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 20:46:49 -0700
IronPort-SDR: BBWpW+r39o2lzOu7mgTYCjskvs51DeAWynUPhQsMSNPBFPxgUQaB9qj0SCbJ4ubKeDoiADxyQ1
 k/jOnsnIXskQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="604744876"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2021 20:46:47 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbb9z-0006v8-1G; Wed, 28 Apr 2021 03:46:47 +0000
Date:   Wed, 28 Apr 2021 11:45:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:test-merge-for-5.13] BUILD SUCCESS
 0def337b7d52bca20d0556fb8dc8797c540f5fc8
Message-ID: <6088da6b.MtHdBq+KhtOFSJX4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-5.13
branch HEAD: 0def337b7d52bca20d0556fb8dc8797c540f5fc8  Merge branch 'for-5.13' into tes-merge-for-5.13

elapsed time: 723m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                             sh03_defconfig
powerpc                 mpc837x_mds_defconfig
microblaze                          defconfig
parisc                           allyesconfig
arm                      pxa255-idp_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                        m5407c3_defconfig
mips                           mtx1_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlr_defconfig
mips                        bcm47xx_defconfig
h8300                            alldefconfig
sh                 kfr2r09-romimage_defconfig
arm                        spear6xx_defconfig
powerpc                          g5_defconfig
m68k                          sun3x_defconfig
m68k                        m5272c3_defconfig
arm                         socfpga_defconfig
openrisc                  or1klitex_defconfig
parisc                generic-64bit_defconfig
arm                         nhk8815_defconfig
arm                  colibri_pxa300_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
arm                           stm32_defconfig
s390                             alldefconfig
mips                      maltaaprp_defconfig
arc                                 defconfig
arc                              allyesconfig
mips                            ar7_defconfig
mips                       capcella_defconfig
arm                          moxart_defconfig
arm                          pcm027_defconfig
arm                           tegra_defconfig
xtensa                       common_defconfig
sh                           se7721_defconfig
powerpc                    amigaone_defconfig
m68k                        m5307c3_defconfig
powerpc                      arches_defconfig
mips                             allmodconfig
powerpc                   bluestone_defconfig
arm                       mainstone_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8548_defconfig
arm                         cm_x300_defconfig
arm                        clps711x_defconfig
sh                           se7712_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
sh                          urquell_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                           sun3_defconfig
riscv                            alldefconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
openrisc                 simple_smp_defconfig
arc                          axs103_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210426
i386                 randconfig-a002-20210426
i386                 randconfig-a001-20210426
i386                 randconfig-a006-20210426
i386                 randconfig-a004-20210426
i386                 randconfig-a003-20210426
x86_64               randconfig-a015-20210426
x86_64               randconfig-a016-20210426
x86_64               randconfig-a011-20210426
x86_64               randconfig-a014-20210426
x86_64               randconfig-a012-20210426
x86_64               randconfig-a013-20210426
i386                 randconfig-a014-20210426
i386                 randconfig-a012-20210426
i386                 randconfig-a011-20210426
i386                 randconfig-a013-20210426
i386                 randconfig-a015-20210426
i386                 randconfig-a016-20210426
x86_64               randconfig-a002-20210427
x86_64               randconfig-a004-20210427
x86_64               randconfig-a001-20210427
x86_64               randconfig-a006-20210427
x86_64               randconfig-a005-20210427
x86_64               randconfig-a003-20210427
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210426
x86_64               randconfig-a004-20210426
x86_64               randconfig-a001-20210426
x86_64               randconfig-a006-20210426
x86_64               randconfig-a005-20210426
x86_64               randconfig-a003-20210426

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
