Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF144426CB
	for <lists+cgroups@lfdr.de>; Tue,  2 Nov 2021 06:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhKBFd5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Nov 2021 01:33:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:65415 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhKBFd5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 2 Nov 2021 01:33:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="292024601"
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="292024601"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 22:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="488943021"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2021 22:31:20 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhmOG-000420-68; Tue, 02 Nov 2021 05:31:20 +0000
Date:   Tue, 02 Nov 2021 13:30:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 588e5d8766486e52ee332a4bb097b016a355b465
Message-ID: <6180cceb.wbePYtd6CUEckGWg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 588e5d8766486e52ee332a4bb097b016a355b465  cgroup: bpf: Move wrapper for __cgroup_bpf_*() to kernel/bpf/cgroup.c

elapsed time: 720m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211101
xtensa                    xip_kc705_defconfig
sh                         microdev_defconfig
arm                          pcm027_defconfig
mips                            e55_defconfig
s390                                defconfig
i386                             allyesconfig
arm                       aspeed_g5_defconfig
sh                           se7712_defconfig
arm                       netwinder_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                          allyesconfig
powerpc                     powernv_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
powerpc                   currituck_defconfig
s390                       zfcpdump_defconfig
arc                        nsim_700_defconfig
powerpc                     sequoia_defconfig
s390                             alldefconfig
mips                           ip32_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        m5307c3_defconfig
mips                           mtx1_defconfig
mips                malta_qemu_32r6_defconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc8540_ads_defconfig
csky                                defconfig
arm                       spear13xx_defconfig
powerpc                    sam440ep_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
mips                        jmr3927_defconfig
arm                             ezx_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           xway_defconfig
sh                        apsh4ad0a_defconfig
xtensa                  audio_kc705_defconfig
m68k                             allmodconfig
mips                           gcw0_defconfig
arm                           corgi_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
powerpc                      tqm8xx_defconfig
m68k                          hp300_defconfig
parisc                generic-64bit_defconfig
arm                  colibri_pxa270_defconfig
xtensa                           alldefconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      acadia_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
sh                            hp6xx_defconfig
m68k                            q40_defconfig
sh                            titan_defconfig
mips                       capcella_defconfig
powerpc                     tqm8548_defconfig
mips                     cu1830-neo_defconfig
arm                            lart_defconfig
sh                        edosk7760_defconfig
arm                          pxa3xx_defconfig
nds32                             allnoconfig
mips                         bigsur_defconfig
arm                             rpc_defconfig
sh                           se7705_defconfig
m68k                       m5475evb_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
microblaze                      mmu_defconfig
openrisc                         alldefconfig
arm                         s3c6400_defconfig
powerpc                     ep8248e_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20211101
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211101
x86_64               randconfig-a015-20211101
x86_64               randconfig-a016-20211101
x86_64               randconfig-a013-20211101
x86_64               randconfig-a011-20211101
x86_64               randconfig-a014-20211101
i386                 randconfig-a016-20211101
i386                 randconfig-a014-20211101
i386                 randconfig-a015-20211101
i386                 randconfig-a013-20211101
i386                 randconfig-a011-20211101
i386                 randconfig-a012-20211101
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20211101
arm                  randconfig-c002-20211101
i386                 randconfig-c001-20211101
s390                 randconfig-c005-20211101
powerpc              randconfig-c003-20211101
riscv                randconfig-c006-20211101
x86_64               randconfig-c007-20211101
x86_64               randconfig-a004-20211101
x86_64               randconfig-a006-20211101
x86_64               randconfig-a001-20211101
x86_64               randconfig-a002-20211101
x86_64               randconfig-a003-20211101
x86_64               randconfig-a005-20211101
i386                 randconfig-a005-20211101
i386                 randconfig-a001-20211101
i386                 randconfig-a003-20211101
i386                 randconfig-a004-20211101
i386                 randconfig-a006-20211101
i386                 randconfig-a002-20211101
hexagon              randconfig-r041-20211101
hexagon              randconfig-r045-20211101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
