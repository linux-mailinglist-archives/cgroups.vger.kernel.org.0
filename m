Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2038F9E5
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 07:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhEYF0U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 01:26:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:48680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhEYF0U (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 25 May 2021 01:26:20 -0400
IronPort-SDR: 1xsEcnXvNZAEaNjVTx5f3/qUesFrNNj13Y3pXkI79QyFlD7y1MIktDbuY4l3b8oIFE3F8VZ20+
 MswZZPkR7i4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189484969"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="189484969"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 22:24:42 -0700
IronPort-SDR: 0Pk6BSgCjrHfje8pj58ZqzhfXp1jc4/FWGihNqnx6pgU0QTE1uXgX2mcwa3aNB98I3Ooi7y/k+
 1PAvZVvwL9xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="464017957"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2021 22:24:41 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llPYW-0001VC-L7; Tue, 25 May 2021 05:24:40 +0000
Date:   Tue, 25 May 2021 13:23:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-next] BUILD SUCCESS
 6962681ee8c6efdc6288568f35245803c165f713
Message-ID: <60ac89df.2G4gM+AsEyJ2DkJU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 6962681ee8c6efdc6288568f35245803c165f713  Merge branch 'for-5.13-fixes' into for-next

elapsed time: 726m

configs tested: 204
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
powerpc                      ppc64e_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
microblaze                      mmu_defconfig
powerpc                     skiroot_defconfig
h8300                       h8s-sim_defconfig
mips                     loongson2k_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          collie_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           spitz_defconfig
powerpc                      makalu_defconfig
arm                            zeus_defconfig
arm                       mainstone_defconfig
arm                            mps2_defconfig
alpha                            allyesconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
powerpc                          allmodconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
riscv                    nommu_virt_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
m68k                          amiga_defconfig
powerpc                       holly_defconfig
mips                        nlm_xlr_defconfig
sh                          lboxre2_defconfig
mips                        omega2p_defconfig
mips                          malta_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
openrisc                 simple_smp_defconfig
sh                          rsk7201_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
powerpc                      katmai_defconfig
arm                       spear13xx_defconfig
arm                        spear3xx_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8555_defconfig
mips                       bmips_be_defconfig
parisc                              defconfig
mips                         bigsur_defconfig
arm                        mvebu_v7_defconfig
mips                        bcm47xx_defconfig
sh                           se7705_defconfig
arm                        vexpress_defconfig
mips                  cavium_octeon_defconfig
sparc                               defconfig
csky                             alldefconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                         db1xxx_defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
sh                           se7750_defconfig
s390                          debug_defconfig
mips                      malta_kvm_defconfig
powerpc                      cm5200_defconfig
powerpc                 canyonlands_defconfig
m68k                           sun3_defconfig
um                                allnoconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
arm                             mxs_defconfig
sh                          sdk7786_defconfig
arm                     eseries_pxa_defconfig
m68k                         apollo_defconfig
mips                      pic32mzda_defconfig
powerpc                  mpc885_ads_defconfig
m68k                             alldefconfig
powerpc                    adder875_defconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
arm                            qcom_defconfig
mips                        qi_lb60_defconfig
xtensa                       common_defconfig
mips                        workpad_defconfig
arm                           sama5_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
xtensa                         virt_defconfig
alpha                            alldefconfig
arc                 nsimosci_hs_smp_defconfig
arm                          badge4_defconfig
powerpc                        warp_defconfig
arm                        multi_v5_defconfig
arm                          simpad_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
i386                 randconfig-a001-20210525
i386                 randconfig-a002-20210525
i386                 randconfig-a005-20210525
i386                 randconfig-a006-20210525
i386                 randconfig-a003-20210525
i386                 randconfig-a004-20210525
x86_64               randconfig-a013-20210525
x86_64               randconfig-a012-20210525
x86_64               randconfig-a014-20210525
x86_64               randconfig-a016-20210525
x86_64               randconfig-a015-20210525
x86_64               randconfig-a011-20210525
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
i386                 randconfig-a011-20210525
i386                 randconfig-a016-20210525
i386                 randconfig-a015-20210525
i386                 randconfig-a012-20210525
i386                 randconfig-a014-20210525
i386                 randconfig-a013-20210525
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210524
x86_64               randconfig-b001-20210525
x86_64               randconfig-a005-20210525
x86_64               randconfig-a006-20210525
x86_64               randconfig-a001-20210525
x86_64               randconfig-a003-20210525
x86_64               randconfig-a004-20210525
x86_64               randconfig-a002-20210525
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
