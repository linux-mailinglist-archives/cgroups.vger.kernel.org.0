Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8035DBF9
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbhDMJ5D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 05:57:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:38799 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238835AbhDMJ5C (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 13 Apr 2021 05:57:02 -0400
IronPort-SDR: mVWUzT6G9ivo4T+Os5N9yUPssr14potFTZFFc5r+w1pnRl4PC1Qvn1w5QhMmLJelOKrIIRTGXm
 od4p3udx0gQA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255702884"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="255702884"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 02:56:42 -0700
IronPort-SDR: uM13cb4uNXcUrMX7MF04IqHP1US+4oTkWuWSIE8fe0Jbwn5w2ltg7NKt6nVUHmC2Db8mJzEWWP
 IOiu1t9Bz3Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="417800044"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2021 02:56:40 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWFmi-0000zE-0f; Tue, 13 Apr 2021 09:56:40 +0000
Date:   Tue, 13 Apr 2021 17:56:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.13] BUILD SUCCESS WITH WARNING
 d95af61df072a7d70b311a11c0c24cf7d8ccebd9
Message-ID: <60756ab4.Mwqvoob2p+IL4PhM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13
branch HEAD: d95af61df072a7d70b311a11c0c24cf7d8ccebd9  cgroup/cpuset: fix typos in comments

Warning in current branch:

kernel/cgroup/misc.c:210 misc_cg_max_show() warn: we never enter this loop
kernel/cgroup/misc.c:257 misc_cg_max_write() warn: we never enter this loop
kernel/cgroup/misc.c:299 misc_cg_current_show() warn: we never enter this loop
kernel/cgroup/misc.c:323 misc_cg_capacity_show() warn: we never enter this loop
kernel/cgroup/misc.c:376 misc_cg_alloc() warn: we never enter this loop

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- parisc-randconfig-m031-20210413
    |-- kernel-cgroup-misc.c-misc_cg_alloc()-warn:unsigned-i-is-never-less-than-zero.
    |-- kernel-cgroup-misc.c-misc_cg_alloc()-warn:we-never-enter-this-loop
    |-- kernel-cgroup-misc.c-misc_cg_capacity_show()-warn:we-never-enter-this-loop
    |-- kernel-cgroup-misc.c-misc_cg_current_show()-warn:we-never-enter-this-loop
    |-- kernel-cgroup-misc.c-misc_cg_max_show()-warn:we-never-enter-this-loop
    |-- kernel-cgroup-misc.c-misc_cg_max_write()-warn:we-never-enter-this-loop
    `-- kernel-cgroup-misc.c-valid_type()-warn:unsigned-type-is-never-less-than-zero.

elapsed time: 724m

configs tested: 183
configs skipped: 3

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
nios2                            allyesconfig
sh                         microdev_defconfig
sh                             espt_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ip32_defconfig
arm                        oxnas_v6_defconfig
h8300                       h8s-sim_defconfig
arc                      axs103_smp_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
riscv                             allnoconfig
mips                         cobalt_defconfig
arm                       aspeed_g4_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
mips                          ath79_defconfig
microblaze                          defconfig
sh                          polaris_defconfig
powerpc                     pq2fads_defconfig
um                             i386_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
arm                         s3c6400_defconfig
arm                            mmp2_defconfig
m68k                       m5275evb_defconfig
powerpc                     mpc512x_defconfig
arm                            mps2_defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
powerpc                    klondike_defconfig
m68k                           sun3_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     sbc8548_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
mips                        workpad_defconfig
powerpc                     tqm5200_defconfig
openrisc                 simple_smp_defconfig
arm                           sama5_defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
powerpc                     tqm8548_defconfig
powerpc                        cell_defconfig
sh                          rsk7201_defconfig
arc                                 defconfig
arm                           corgi_defconfig
arc                              allyesconfig
mips                        omega2p_defconfig
arm                        magician_defconfig
um                                  defconfig
powerpc                 mpc8560_ads_defconfig
sh                   sh7770_generic_defconfig
arc                          axs103_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                        fsp2_defconfig
arc                        nsim_700_defconfig
powerpc                     powernv_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
powerpc                      makalu_defconfig
powerpc                 linkstation_defconfig
powerpc                     pseries_defconfig
arm                           spitz_defconfig
openrisc                    or1ksim_defconfig
powerpc                      ppc44x_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
arm                      pxa255-idp_defconfig
powerpc                      obs600_defconfig
mips                      bmips_stb_defconfig
sh                           sh2007_defconfig
sh                           se7619_defconfig
arm                          pxa910_defconfig
um                               allmodconfig
arm                            qcom_defconfig
arm                            xcep_defconfig
mips                         mpc30x_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                  colibri_pxa270_defconfig
mips                           ci20_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
parisc                generic-32bit_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a006-20210412
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
i386                 randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a011-20210412
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
