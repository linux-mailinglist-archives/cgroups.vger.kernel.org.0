Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66713EF79
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2020 19:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436468AbgAPSPR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jan 2020 13:15:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:7766 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436466AbgAPSPQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 Jan 2020 13:15:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 10:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="259470344"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jan 2020 10:15:14 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1is9fm-0003x3-8Z; Fri, 17 Jan 2020 02:15:14 +0800
Date:   Fri, 17 Jan 2020 02:13:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.6] BUILD SUCCESS
 3bc0bb36fa30e95ca829e9cf480e1ef7f7638333
Message-ID: <5e20a7e7.fGZcorw6FCRN/xvP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-5.6
branch HEAD: 3bc0bb36fa30e95ca829e9cf480e1ef7f7638333  cgroup: Prevent double killing of css when enabling threaded cgroup

elapsed time: 788m

configs tested: 148
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-b001-20200116
x86_64               randconfig-b002-20200116
x86_64               randconfig-b003-20200116
i386                 randconfig-b001-20200116
i386                 randconfig-b002-20200116
i386                 randconfig-b003-20200116
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
alpha                randconfig-a001-20200116
m68k                 randconfig-a001-20200116
mips                 randconfig-a001-20200116
nds32                randconfig-a001-20200116
parisc               randconfig-a001-20200116
riscv                randconfig-a001-20200116
arc                  randconfig-a001-20200116
arm                  randconfig-a001-20200116
arm64                randconfig-a001-20200116
ia64                 randconfig-a001-20200116
powerpc              randconfig-a001-20200116
sparc                randconfig-a001-20200116
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
ia64                                defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-d001-20200116
x86_64               randconfig-d002-20200116
x86_64               randconfig-d003-20200116
i386                 randconfig-d001-20200116
i386                 randconfig-d002-20200116
i386                 randconfig-d003-20200116
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
x86_64               randconfig-a001-20200116
x86_64               randconfig-a002-20200116
x86_64               randconfig-a003-20200116
i386                 randconfig-a001-20200116
i386                 randconfig-a002-20200116
i386                 randconfig-a003-20200116
arc                  randconfig-a001-20200117
arm                  randconfig-a001-20200117
arm64                randconfig-a001-20200117
ia64                 randconfig-a001-20200117
powerpc              randconfig-a001-20200117
sparc                randconfig-a001-20200117
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64               randconfig-d001-20200117
x86_64               randconfig-d002-20200117
x86_64               randconfig-d003-20200117
i386                 randconfig-d001-20200117
i386                 randconfig-d002-20200117
i386                 randconfig-d003-20200117
alpha                randconfig-a001-20200117
m68k                 randconfig-a001-20200117
mips                 randconfig-a001-20200117
nds32                randconfig-a001-20200117
parisc               randconfig-a001-20200117
riscv                randconfig-a001-20200117
x86_64               randconfig-e001-20200117
x86_64               randconfig-e002-20200117
x86_64               randconfig-e003-20200117
i386                 randconfig-e001-20200117
i386                 randconfig-e002-20200117
i386                 randconfig-e003-20200117

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
