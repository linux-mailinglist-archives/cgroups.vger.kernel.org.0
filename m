Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6C1A712F
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgDNCt4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 22:49:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:35678 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbgDNCtz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Apr 2020 22:49:55 -0400
IronPort-SDR: 8XtmjphgisCO8tQq2JwR0PNXhze5NYMasficFmMdDbdhiXNoY9tryfWfGSwIFAU702gvOGf6Dd
 kNgl057yLAXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 19:49:55 -0700
IronPort-SDR: 2f4NsrRdlj1HDy0e4xL6ZLR3wwc9cS/mIgOyBBkGKBX12HOB7pzrHHOskxBXLyq5/cmLdpihL4
 zsXZjwXcYS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="426906613"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2020 19:49:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jOBe4-00072Q-Ok; Tue, 14 Apr 2020 10:49:52 +0800
Date:   Tue, 14 Apr 2020 10:48:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-next] BUILD SUCCESS
 eec8fd0277e37cf447b88c6be181e81df867bcf1
Message-ID: <5e95247e.Pj5I28kgP4YPaXjy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-next
branch HEAD: eec8fd0277e37cf447b88c6be181e81df867bcf1  device_cgroup: Cleanup cgroup eBPF device filter code

elapsed time: 480m

configs tested: 195
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
sparc64                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200414
x86_64               randconfig-a002-20200414
x86_64               randconfig-a003-20200414
i386                 randconfig-a001-20200414
i386                 randconfig-a002-20200414
i386                 randconfig-a003-20200414
alpha                randconfig-a001-20200413
m68k                 randconfig-a001-20200413
mips                 randconfig-a001-20200413
nds32                randconfig-a001-20200413
parisc               randconfig-a001-20200413
riscv                randconfig-a001-20200413
c6x                  randconfig-a001-20200413
h8300                randconfig-a001-20200413
microblaze           randconfig-a001-20200413
nios2                randconfig-a001-20200413
sparc64              randconfig-a001-20200413
s390                 randconfig-a001-20200414
xtensa               randconfig-a001-20200414
sh                   randconfig-a001-20200414
openrisc             randconfig-a001-20200414
csky                 randconfig-a001-20200414
csky                 randconfig-a001-20200413
openrisc             randconfig-a001-20200413
s390                 randconfig-a001-20200413
sh                   randconfig-a001-20200413
xtensa               randconfig-a001-20200413
x86_64               randconfig-b001-20200413
x86_64               randconfig-b002-20200413
x86_64               randconfig-b003-20200413
i386                 randconfig-b001-20200413
i386                 randconfig-b002-20200413
i386                 randconfig-b003-20200413
x86_64               randconfig-c001-20200413
x86_64               randconfig-c002-20200413
x86_64               randconfig-c003-20200413
i386                 randconfig-c001-20200413
i386                 randconfig-c002-20200413
i386                 randconfig-c003-20200413
x86_64               randconfig-c001-20200414
x86_64               randconfig-c002-20200414
x86_64               randconfig-c003-20200414
i386                 randconfig-c001-20200414
i386                 randconfig-c002-20200414
i386                 randconfig-c003-20200414
x86_64               randconfig-d001-20200413
x86_64               randconfig-d002-20200413
x86_64               randconfig-d003-20200413
i386                 randconfig-d001-20200413
i386                 randconfig-d002-20200413
i386                 randconfig-d003-20200413
x86_64               randconfig-e001-20200413
x86_64               randconfig-e002-20200413
x86_64               randconfig-e003-20200413
i386                 randconfig-e001-20200413
i386                 randconfig-e002-20200413
i386                 randconfig-e003-20200413
x86_64               randconfig-f001-20200413
x86_64               randconfig-f002-20200413
x86_64               randconfig-f003-20200413
i386                 randconfig-f001-20200413
i386                 randconfig-f002-20200413
i386                 randconfig-f003-20200413
x86_64               randconfig-g001-20200413
x86_64               randconfig-g002-20200413
x86_64               randconfig-g003-20200413
i386                 randconfig-g001-20200413
i386                 randconfig-g002-20200413
i386                 randconfig-g003-20200413
x86_64               randconfig-g001-20200414
x86_64               randconfig-g002-20200414
x86_64               randconfig-g003-20200414
i386                 randconfig-g001-20200414
i386                 randconfig-g002-20200414
i386                 randconfig-g003-20200414
x86_64               randconfig-h001-20200413
x86_64               randconfig-h002-20200413
x86_64               randconfig-h003-20200413
i386                 randconfig-h001-20200413
i386                 randconfig-h002-20200413
i386                 randconfig-h003-20200413
x86_64               randconfig-h001-20200414
x86_64               randconfig-h002-20200414
x86_64               randconfig-h003-20200414
i386                 randconfig-h001-20200414
i386                 randconfig-h002-20200414
i386                 randconfig-h003-20200414
arc                  randconfig-a001-20200413
arm                  randconfig-a001-20200413
arm64                randconfig-a001-20200413
ia64                 randconfig-a001-20200413
powerpc              randconfig-a001-20200413
sparc                randconfig-a001-20200413
arc                  randconfig-a001-20200414
arm                  randconfig-a001-20200414
arm64                randconfig-a001-20200414
ia64                 randconfig-a001-20200414
powerpc              randconfig-a001-20200414
sparc                randconfig-a001-20200414
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
