Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9161A151708
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2020 09:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDI1m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Feb 2020 03:27:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:58657 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgBDI1m (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 Feb 2020 03:27:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 00:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="429721980"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2020 00:27:40 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iytYa-000GQn-0x; Tue, 04 Feb 2020 16:27:40 +0800
Date:   Tue, 04 Feb 2020 16:27:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.6-fixes] BUILD SUCCESS
 0cd9d33ace336bc424fc30944aa3defd6786e4fe
Message-ID: <5e392adf.+411Phrrm+UdY6U/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-5.6-fixes
branch HEAD: 0cd9d33ace336bc424fc30944aa3defd6786e4fe  cgroup: init_tasks shouldn't be linked to the root cgroup

elapsed time: 6390m

configs tested: 177
configs skipped: 1

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
arc                                 defconfig
um                           x86_64_defconfig
s390                                defconfig
sparc64                          allyesconfig
ia64                                defconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
alpha                               defconfig
mips                             allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
csky                                defconfig
nds32                             allnoconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-a001-20200129
i386                 randconfig-a001-20200129
x86_64               randconfig-a002-20200129
i386                 randconfig-a002-20200129
i386                 randconfig-a003-20200129
x86_64               randconfig-a003-20200129
nds32                randconfig-a001-20200130
parisc               randconfig-a001-20200130
alpha                randconfig-a001-20200130
mips                 randconfig-a001-20200130
m68k                 randconfig-a001-20200130
riscv                randconfig-a001-20200130
nds32                randconfig-a001-20200131
parisc               randconfig-a001-20200131
alpha                randconfig-a001-20200131
riscv                randconfig-a001-20200131
m68k                 randconfig-a001-20200131
h8300                randconfig-a001-20200204
nios2                randconfig-a001-20200204
sparc64              randconfig-a001-20200204
h8300                randconfig-a001-20200130
nios2                randconfig-a001-20200130
c6x                  randconfig-a001-20200130
sparc64              randconfig-a001-20200130
csky                 randconfig-a001-20200130
openrisc             randconfig-a001-20200130
s390                 randconfig-a001-20200130
sh                   randconfig-a001-20200130
xtensa               randconfig-a001-20200130
x86_64               randconfig-b003-20200131
x86_64               randconfig-b002-20200131
i386                 randconfig-b003-20200131
i386                 randconfig-b001-20200131
i386                 randconfig-b002-20200131
x86_64               randconfig-b001-20200131
x86_64               randconfig-b001-20200129
x86_64               randconfig-b002-20200129
x86_64               randconfig-b003-20200129
i386                 randconfig-b001-20200129
i386                 randconfig-b002-20200129
i386                 randconfig-b003-20200129
i386                 randconfig-c001-20200131
x86_64               randconfig-c003-20200131
i386                 randconfig-c003-20200131
x86_64               randconfig-c001-20200131
x86_64               randconfig-c002-20200131
i386                 randconfig-c002-20200131
i386                 randconfig-d003-20200130
x86_64               randconfig-d002-20200130
i386                 randconfig-d001-20200130
i386                 randconfig-d002-20200130
x86_64               randconfig-d003-20200130
x86_64               randconfig-d001-20200130
i386                 randconfig-e002-20200129
x86_64               randconfig-e002-20200129
i386                 randconfig-e001-20200129
i386                 randconfig-e003-20200129
x86_64               randconfig-e003-20200129
x86_64               randconfig-e001-20200129
x86_64               randconfig-f001-20200129
x86_64               randconfig-f002-20200129
x86_64               randconfig-f003-20200129
i386                 randconfig-f001-20200129
i386                 randconfig-f002-20200129
i386                 randconfig-f003-20200129
x86_64               randconfig-g001-20200130
x86_64               randconfig-g002-20200130
x86_64               randconfig-g003-20200130
i386                 randconfig-g001-20200130
i386                 randconfig-g002-20200130
i386                 randconfig-g003-20200130
x86_64               randconfig-h001-20200129
x86_64               randconfig-h002-20200129
x86_64               randconfig-h003-20200129
i386                 randconfig-h001-20200129
i386                 randconfig-h002-20200129
i386                 randconfig-h003-20200129
arm64                randconfig-a001-20200130
ia64                 randconfig-a001-20200130
sparc                randconfig-a001-20200130
arm                  randconfig-a001-20200130
arc                  randconfig-a001-20200130
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
