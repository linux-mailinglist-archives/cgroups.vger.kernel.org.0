Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8287215FC1F
	for <lists+cgroups@lfdr.de>; Sat, 15 Feb 2020 02:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBOBjx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 20:39:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:3292 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgBOBjx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 14 Feb 2020 20:39:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="252822703"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2020 17:39:50 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j2mQw-0000Uf-4M; Sat, 15 Feb 2020 09:39:50 +0800
Date:   Sat, 15 Feb 2020 09:38:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.6-fixes] BUILD SUCCESS
 9c974c77246460fa6a92c18554c3311c8c83c160
Message-ID: <5e474baa.LmQHknAUasMDFlki%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-5.6-fixes
branch HEAD: 9c974c77246460fa6a92c18554c3311c8c83c160  cgroup: Iterate tasks that did not finish do_exit()

elapsed time: 2886m

configs tested: 246
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sparc                            allyesconfig
c6x                              allyesconfig
xtensa                          iss_defconfig
riscv                               defconfig
sh                  sh7785lcr_32bit_defconfig
i386                                defconfig
riscv                            allmodconfig
sparc                               defconfig
nds32                               defconfig
riscv                            allyesconfig
s390                                defconfig
powerpc                           allnoconfig
sparc64                          allmodconfig
alpha                               defconfig
csky                                defconfig
riscv                    nommu_virt_defconfig
mips                             allyesconfig
arc                              allyesconfig
m68k                           sun3_defconfig
s390                             alldefconfig
powerpc                             defconfig
i386                             allyesconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
powerpc                       ppc64_defconfig
mips                      fuloong2e_defconfig
m68k                       m5475evb_defconfig
microblaze                      mmu_defconfig
ia64                                defconfig
um                             i386_defconfig
openrisc                 simple_smp_defconfig
ia64                              allnoconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
sparc64                          allyesconfig
sparc64                             defconfig
nds32                             allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
m68k                          multi_defconfig
microblaze                    nommu_defconfig
sh                            titan_defconfig
i386                             alldefconfig
sh                          rsk7269_defconfig
s390                             allmodconfig
s390                              allnoconfig
i386                              allnoconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
arc                                 defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-a001-20200215
x86_64               randconfig-a002-20200215
x86_64               randconfig-a003-20200215
i386                 randconfig-a001-20200215
i386                 randconfig-a002-20200215
i386                 randconfig-a003-20200215
x86_64               randconfig-a001-20200214
x86_64               randconfig-a002-20200214
x86_64               randconfig-a003-20200214
i386                 randconfig-a001-20200214
i386                 randconfig-a002-20200214
i386                 randconfig-a003-20200214
x86_64               randconfig-a001-20200213
x86_64               randconfig-a002-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
i386                 randconfig-a002-20200213
i386                 randconfig-a003-20200213
alpha                randconfig-a001-20200214
m68k                 randconfig-a001-20200214
mips                 randconfig-a001-20200214
nds32                randconfig-a001-20200214
parisc               randconfig-a001-20200214
riscv                randconfig-a001-20200214
c6x                  randconfig-a001-20200213
h8300                randconfig-a001-20200213
microblaze           randconfig-a001-20200213
nios2                randconfig-a001-20200213
sparc64              randconfig-a001-20200213
c6x                  randconfig-a001-20200214
h8300                randconfig-a001-20200214
microblaze           randconfig-a001-20200214
nios2                randconfig-a001-20200214
sparc64              randconfig-a001-20200214
c6x                  randconfig-a001-20200215
h8300                randconfig-a001-20200215
microblaze           randconfig-a001-20200215
nios2                randconfig-a001-20200215
sparc64              randconfig-a001-20200215
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
csky                 randconfig-a001-20200214
openrisc             randconfig-a001-20200214
s390                 randconfig-a001-20200214
xtensa               randconfig-a001-20200214
sh                   randconfig-a001-20200214
x86_64               randconfig-b001-20200213
x86_64               randconfig-b002-20200213
x86_64               randconfig-b003-20200213
i386                 randconfig-b001-20200213
i386                 randconfig-b002-20200213
i386                 randconfig-b003-20200213
x86_64               randconfig-b001-20200214
x86_64               randconfig-b002-20200214
x86_64               randconfig-b003-20200214
i386                 randconfig-b001-20200214
i386                 randconfig-b002-20200214
i386                 randconfig-b003-20200214
x86_64               randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
i386                 randconfig-c002-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-c001-20200214
x86_64               randconfig-c002-20200214
x86_64               randconfig-c003-20200214
i386                 randconfig-c001-20200214
i386                 randconfig-c002-20200214
i386                 randconfig-c003-20200214
x86_64               randconfig-d001-20200213
x86_64               randconfig-d002-20200213
x86_64               randconfig-d003-20200213
i386                 randconfig-d001-20200213
i386                 randconfig-d002-20200213
i386                 randconfig-d003-20200213
x86_64               randconfig-d001-20200214
x86_64               randconfig-d002-20200214
x86_64               randconfig-d003-20200214
i386                 randconfig-d001-20200214
i386                 randconfig-d002-20200214
i386                 randconfig-d003-20200214
x86_64               randconfig-e001-20200213
x86_64               randconfig-e002-20200213
x86_64               randconfig-e003-20200213
i386                 randconfig-e001-20200213
i386                 randconfig-e002-20200213
i386                 randconfig-e003-20200213
x86_64               randconfig-e001-20200214
x86_64               randconfig-e002-20200214
x86_64               randconfig-e003-20200214
i386                 randconfig-e001-20200214
i386                 randconfig-e002-20200214
i386                 randconfig-e003-20200214
x86_64               randconfig-f001-20200213
x86_64               randconfig-f002-20200213
x86_64               randconfig-f003-20200213
i386                 randconfig-f001-20200213
i386                 randconfig-f002-20200213
i386                 randconfig-f003-20200213
x86_64               randconfig-f001-20200214
x86_64               randconfig-f002-20200214
x86_64               randconfig-f003-20200214
i386                 randconfig-f001-20200214
i386                 randconfig-f002-20200214
i386                 randconfig-f003-20200214
x86_64               randconfig-g001-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-g003-20200213
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-g001-20200214
x86_64               randconfig-g002-20200214
x86_64               randconfig-g003-20200214
i386                 randconfig-g001-20200214
i386                 randconfig-g002-20200214
i386                 randconfig-g003-20200214
x86_64               randconfig-g001-20200215
x86_64               randconfig-g002-20200215
x86_64               randconfig-g003-20200215
i386                 randconfig-g001-20200215
i386                 randconfig-g002-20200215
i386                 randconfig-g003-20200215
x86_64               randconfig-h001-20200214
x86_64               randconfig-h002-20200214
x86_64               randconfig-h003-20200214
i386                 randconfig-h001-20200214
i386                 randconfig-h002-20200214
i386                 randconfig-h003-20200214
x86_64               randconfig-h001-20200213
x86_64               randconfig-h002-20200213
x86_64               randconfig-h003-20200213
i386                 randconfig-h001-20200213
i386                 randconfig-h002-20200213
i386                 randconfig-h003-20200213
arc                  randconfig-a001-20200213
arm                  randconfig-a001-20200213
arm64                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
powerpc              randconfig-a001-20200213
sparc                randconfig-a001-20200213
arc                  randconfig-a001-20200214
arm                  randconfig-a001-20200214
arm64                randconfig-a001-20200214
ia64                 randconfig-a001-20200214
powerpc              randconfig-a001-20200214
sparc                randconfig-a001-20200214
riscv                             allnoconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sparc64                           allnoconfig
um                                  defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
