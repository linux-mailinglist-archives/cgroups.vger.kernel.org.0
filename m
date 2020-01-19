Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D92141F32
	for <lists+cgroups@lfdr.de>; Sun, 19 Jan 2020 18:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgASRb7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jan 2020 12:31:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:12889 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgASRb7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 19 Jan 2020 12:31:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 09:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,338,1574150400"; 
   d="scan'208";a="424984097"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2020 09:31:57 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itEQW-000IbT-Rz; Mon, 20 Jan 2020 01:31:56 +0800
Date:   Mon, 20 Jan 2020 01:31:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.6] BUILD SUCCESS
 9ea37e24d4a95dd934a0600d65caa25e409705bb
Message-ID: <5e249254.NBZ2jtXZ0hKyu27B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-5.6
branch HEAD: 9ea37e24d4a95dd934a0600d65caa25e409705bb  iocost: Fix iocost_monitor.py due to helper type mismatch

elapsed time: 2436m

configs tested: 197
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64               randconfig-g001-20200119
x86_64               randconfig-g002-20200119
x86_64               randconfig-g003-20200119
i386                 randconfig-g001-20200119
i386                 randconfig-g002-20200119
i386                 randconfig-g003-20200119
x86_64               randconfig-c001-20200119
x86_64               randconfig-c002-20200119
x86_64               randconfig-c003-20200119
i386                 randconfig-c001-20200119
i386                 randconfig-c002-20200119
i386                 randconfig-c003-20200119
i386                             allyesconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64               randconfig-f001-20200119
x86_64               randconfig-f002-20200119
x86_64               randconfig-f003-20200119
i386                 randconfig-f001-20200119
i386                 randconfig-f002-20200119
i386                 randconfig-f003-20200119
microblaze                      mmu_defconfig
um                             i386_defconfig
x86_64               randconfig-e001-20200119
x86_64               randconfig-e002-20200119
x86_64               randconfig-e003-20200119
i386                 randconfig-e001-20200119
i386                 randconfig-e002-20200119
i386                 randconfig-e003-20200119
arm                              allmodconfig
arm64                            allmodconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
alpha                randconfig-a001-20200119
m68k                 randconfig-a001-20200119
mips                 randconfig-a001-20200119
nds32                randconfig-a001-20200119
parisc               randconfig-a001-20200119
riscv                randconfig-a001-20200119
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64               randconfig-h001-20200119
x86_64               randconfig-h002-20200119
x86_64               randconfig-h003-20200119
i386                 randconfig-h001-20200119
i386                 randconfig-h002-20200119
i386                 randconfig-h003-20200119
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
arc                  randconfig-a001-20200119
arm                  randconfig-a001-20200119
arm64                randconfig-a001-20200119
ia64                 randconfig-a001-20200119
powerpc              randconfig-a001-20200119
sparc                randconfig-a001-20200119
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sparc                            allyesconfig
x86_64               randconfig-b001-20200119
x86_64               randconfig-b002-20200119
x86_64               randconfig-b003-20200119
i386                 randconfig-b001-20200119
i386                 randconfig-b002-20200119
i386                 randconfig-b003-20200119
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
csky                 randconfig-a001-20200119
openrisc             randconfig-a001-20200119
s390                 randconfig-a001-20200119
sh                   randconfig-a001-20200119
xtensa               randconfig-a001-20200119
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                  randconfig-a001-20200119
h8300                randconfig-a001-20200119
microblaze           randconfig-a001-20200119
nios2                randconfig-a001-20200119
sparc64              randconfig-a001-20200119
x86_64               randconfig-d001-20200119
x86_64               randconfig-d002-20200119
x86_64               randconfig-d003-20200119
i386                 randconfig-d001-20200119
i386                 randconfig-d002-20200119
i386                 randconfig-d003-20200119
x86_64               randconfig-a001-20200119
x86_64               randconfig-a002-20200119
x86_64               randconfig-a003-20200119
i386                 randconfig-a001-20200119
i386                 randconfig-a002-20200119
i386                 randconfig-a003-20200119
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
um                                  defconfig
um                           x86_64_defconfig
alpha                randconfig-a001-20200118
m68k                 randconfig-a001-20200118
mips                 randconfig-a001-20200118
nds32                randconfig-a001-20200118
parisc               randconfig-a001-20200118
riscv                randconfig-a001-20200118
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64               randconfig-b001-20200118
x86_64               randconfig-b002-20200118
x86_64               randconfig-b003-20200118
i386                 randconfig-b001-20200118
i386                 randconfig-b002-20200118
i386                 randconfig-b003-20200118
x86_64               randconfig-d001-20200118
x86_64               randconfig-d002-20200118
x86_64               randconfig-d003-20200118
i386                 randconfig-d001-20200118
i386                 randconfig-d002-20200118
i386                 randconfig-d003-20200118
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
csky                 randconfig-a001-20200118
openrisc             randconfig-a001-20200118
s390                 randconfig-a001-20200118
sh                   randconfig-a001-20200118
xtensa               randconfig-a001-20200118
c6x                  randconfig-a001-20200118
h8300                randconfig-a001-20200118
microblaze           randconfig-a001-20200118
nios2                randconfig-a001-20200118
sparc64              randconfig-a001-20200118
c6x                  randconfig-a001-20200120
h8300                randconfig-a001-20200120
microblaze           randconfig-a001-20200120
nios2                randconfig-a001-20200120
sparc64              randconfig-a001-20200120

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
