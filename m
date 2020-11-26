Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48B2C51E8
	for <lists+cgroups@lfdr.de>; Thu, 26 Nov 2020 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgKZKRv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Nov 2020 05:17:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:16277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgKZKRv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 26 Nov 2020 05:17:51 -0500
IronPort-SDR: QCES0BIIwkeXYYdJDi62D2nwH0wDV+aDXia+//x4oi/GI4xPxdxrJJPCK/QGp7UA4+ZGxt1Nkq
 cQx/KHAqRBiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190419054"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="190419054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 02:17:50 -0800
IronPort-SDR: FIsTXG+kWNLl5MJeKBj523xM1ESFlGLunfL+bHXlqKe9S/UFy5NGhHWfoDg4jfxsrqkLBiX6gG
 C3YEQ4qG8oGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="365767221"
Received: from lkp-server02.sh.intel.com (HELO 334d66ce2fbf) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2020 02:17:49 -0800
Received: from kbuild by 334d66ce2fbf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiELV-00003i-3O; Thu, 26 Nov 2020 10:17:49 +0000
Date:   Thu, 26 Nov 2020 18:17:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.10-fixes] BUILD SUCCESS
 5a7b5f32c5aa628841502d19a813c633ff6ecbe4
Message-ID: <5fbf809d.iVUDTiSL3856mzDl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-5.10-fixes
branch HEAD: 5a7b5f32c5aa628841502d19a813c633ff6ecbe4  cgroup/cgroup.c: replace 'of->kn->priv' with of_cft()

elapsed time: 721m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
m68k                       m5208evb_defconfig
powerpc                      obs600_defconfig
arm                            pleb_defconfig
powerpc                        warp_defconfig
arm                            mps2_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                            mmp2_defconfig
sh                        apsh4ad0a_defconfig
sh                     magicpanelr2_defconfig
powerpc                   bluestone_defconfig
mips                        qi_lb60_defconfig
arm                         lubbock_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                     eseries_pxa_defconfig
arm                         s3c6400_defconfig
parisc                generic-64bit_defconfig
alpha                               defconfig
riscv                               defconfig
h8300                               defconfig
sh                         apsh4a3a_defconfig
mips                        jmr3927_defconfig
arm                           omap1_defconfig
arm                            hisi_defconfig
sh                           se7705_defconfig
m68k                       m5249evb_defconfig
mips                       capcella_defconfig
arm                   milbeaut_m10v_defconfig
sh                         ecovec24_defconfig
i386                             alldefconfig
arm                            qcom_defconfig
powerpc                    socrates_defconfig
arm                       spear13xx_defconfig
powerpc                     tqm5200_defconfig
powerpc                       holly_defconfig
um                            kunit_defconfig
arm                             pxa_defconfig
s390                          debug_defconfig
sh                          r7785rp_defconfig
mips                           xway_defconfig
xtensa                           alldefconfig
sh                          lboxre2_defconfig
nds32                             allnoconfig
mips                     decstation_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7619_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
csky                                defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201125
i386                 randconfig-a013-20201125
i386                 randconfig-a011-20201125
i386                 randconfig-a016-20201125
i386                 randconfig-a014-20201125
i386                 randconfig-a015-20201125
x86_64               randconfig-a006-20201126
x86_64               randconfig-a003-20201126
x86_64               randconfig-a004-20201126
x86_64               randconfig-a005-20201126
x86_64               randconfig-a001-20201126
x86_64               randconfig-a002-20201126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201126
x86_64               randconfig-a011-20201126
x86_64               randconfig-a014-20201126
x86_64               randconfig-a016-20201126
x86_64               randconfig-a012-20201126
x86_64               randconfig-a013-20201126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
