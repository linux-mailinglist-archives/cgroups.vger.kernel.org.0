Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A358F1A2D8A
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 04:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDICK7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 22:10:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:56918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDICK7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 8 Apr 2020 22:10:59 -0400
IronPort-SDR: D/Iu3ySblNyxJZVHcllMnhgwq55z7WK8dD7KcYl0yQcnxd50oY6WOlH3S1cS29EjGr8jf+Yiy1
 gSAuwWkuA47g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 19:10:57 -0700
IronPort-SDR: RH2TS+A3FPY15hKb3sFL2EXpQBw0VRsqKEFZFCjyweIbpcny88UgvSJjDJ957417+tlu5hkInh
 xzXv/TuwvkqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="330712863"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2020 19:10:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMMed-00075S-Bb; Thu, 09 Apr 2020 10:10:55 +0800
Date:   Thu, 09 Apr 2020 10:09:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:iocost-delay-latency] BUILD SUCCESS
 ed360825ee46572d1aa02d7d5dff71654fe66bf6
Message-ID: <5e8e83e4.XeBuJEFUMk/Px6HN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  iocost-delay-latency
branch HEAD: ed360825ee46572d1aa02d7d5dff71654fe66bf6  iocost_monitor: drop string wrap around numbers when outputting json

elapsed time: 483m

configs tested: 165
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
nds32                             allnoconfig
parisc                generic-64bit_defconfig
xtensa                          iss_defconfig
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
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
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
parisc                           allyesconfig
parisc                generic-32bit_defconfig
x86_64               randconfig-a001-20200409
x86_64               randconfig-a002-20200409
x86_64               randconfig-a003-20200409
i386                 randconfig-a001-20200409
i386                 randconfig-a002-20200409
i386                 randconfig-a003-20200409
x86_64               randconfig-a001-20200408
x86_64               randconfig-a002-20200408
x86_64               randconfig-a003-20200408
i386                 randconfig-a001-20200408
i386                 randconfig-a002-20200408
i386                 randconfig-a003-20200408
alpha                randconfig-a001-20200408
m68k                 randconfig-a001-20200408
mips                 randconfig-a001-20200408
nds32                randconfig-a001-20200408
parisc               randconfig-a001-20200408
riscv                randconfig-a001-20200408
c6x                  randconfig-a001-20200408
h8300                randconfig-a001-20200408
microblaze           randconfig-a001-20200408
nios2                randconfig-a001-20200408
sparc64              randconfig-a001-20200408
csky                 randconfig-a001-20200408
openrisc             randconfig-a001-20200408
s390                 randconfig-a001-20200408
sh                   randconfig-a001-20200408
xtensa               randconfig-a001-20200408
x86_64               randconfig-b001-20200408
x86_64               randconfig-b002-20200408
x86_64               randconfig-b003-20200408
i386                 randconfig-b001-20200408
i386                 randconfig-b002-20200408
i386                 randconfig-b003-20200408
x86_64               randconfig-c001-20200408
x86_64               randconfig-c002-20200408
x86_64               randconfig-c003-20200408
i386                 randconfig-c001-20200408
i386                 randconfig-c002-20200408
i386                 randconfig-c003-20200408
x86_64               randconfig-d001-20200408
x86_64               randconfig-d002-20200408
x86_64               randconfig-d003-20200408
i386                 randconfig-d001-20200408
i386                 randconfig-d002-20200408
i386                 randconfig-d003-20200408
x86_64               randconfig-e001-20200408
x86_64               randconfig-e002-20200408
x86_64               randconfig-e003-20200408
i386                 randconfig-e001-20200408
i386                 randconfig-e002-20200408
i386                 randconfig-e003-20200408
x86_64               randconfig-g001-20200409
x86_64               randconfig-g002-20200409
x86_64               randconfig-g003-20200409
i386                 randconfig-g001-20200409
i386                 randconfig-g002-20200409
i386                 randconfig-g003-20200409
x86_64               randconfig-h001-20200408
x86_64               randconfig-h002-20200408
x86_64               randconfig-h003-20200408
i386                 randconfig-h001-20200408
i386                 randconfig-h002-20200408
i386                 randconfig-h003-20200408
arc                  randconfig-a001-20200408
arm                  randconfig-a001-20200408
arm64                randconfig-a001-20200408
ia64                 randconfig-a001-20200408
powerpc              randconfig-a001-20200408
sparc                randconfig-a001-20200408
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
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
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
