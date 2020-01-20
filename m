Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7081B142159
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 02:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgATBKx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jan 2020 20:10:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:15620 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgATBKx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 19 Jan 2020 20:10:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 17:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="221267301"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2020 17:10:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itLad-000AqW-A6; Mon, 20 Jan 2020 09:10:51 +0800
Date:   Mon, 20 Jan 2020 09:10:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-next] BUILD INCOMPLETE
 c00ec3075b3aab38dd8fb674a8ccfbb08a3090ea
Message-ID: <5e24fdea.0EjUS2V02ntPB60Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-next
branch HEAD: c00ec3075b3aab38dd8fb674a8ccfbb08a3090ea  Merge branch 'for-5.6' into for-next

TIMEOUT after 2895m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 10

i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig

configs tested: 124
configs skipped: 0

arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
alpha                randconfig-a001-20200118
m68k                 randconfig-a001-20200118
mips                 randconfig-a001-20200118
nds32                randconfig-a001-20200118
parisc               randconfig-a001-20200118
riscv                randconfig-a001-20200118
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
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
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
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
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                              allmodconfig
arm                              allyesconfig
x86_64               randconfig-e001-20200118
i386                 randconfig-e001-20200118
i386                 randconfig-e002-20200118
x86_64               randconfig-e002-20200118
x86_64               randconfig-e003-20200118
i386                 randconfig-e003-20200118
arm64                randconfig-a001-20200120
powerpc              randconfig-a001-20200120
ia64                 randconfig-a001-20200120
arm                  randconfig-a001-20200120
arc                  randconfig-a001-20200120
sparc                randconfig-a001-20200120
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
