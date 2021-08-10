Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D693E58F9
	for <lists+cgroups@lfdr.de>; Tue, 10 Aug 2021 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhHJLWK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Aug 2021 07:22:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:64284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238079AbhHJLWJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 10 Aug 2021 07:22:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="278628421"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="278628421"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 04:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="589271916"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2021 04:21:45 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDPpJ-000KUt-8P; Tue, 10 Aug 2021 11:21:45 +0000
Date:   Tue, 10 Aug 2021 19:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.15] BUILD SUCCESS
 c5c63b9a6a2e53757b598485b8adbafa56d6d9ee
Message-ID: <61126138.9EmkhBUatFMZVwQ4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15
branch HEAD: c5c63b9a6a2e53757b598485b8adbafa56d6d9ee  cgroup: Replace deprecated CPU-hotplug functions.

elapsed time: 723m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210810
arc                            hsdk_defconfig
arm                        realview_defconfig
arm                           spitz_defconfig
powerpc                   currituck_defconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7264_defconfig
sh                        sh7785lcr_defconfig
ia64                        generic_defconfig
xtensa                  nommu_kc705_defconfig
sh                          landisk_defconfig
openrisc                         alldefconfig
arm                           stm32_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8540_defconfig
riscv                          rv32_defconfig
powerpc                      tqm8xx_defconfig
arm                       omap2plus_defconfig
powerpc                      mgcoge_defconfig
mips                         cobalt_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         s3c6400_defconfig
sh                             sh03_defconfig
riscv                    nommu_virt_defconfig
i386                                defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
x86_64                            allnoconfig
arm                          pxa910_defconfig
powerpc                 mpc8540_ads_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
i386                 randconfig-a004-20210809
i386                 randconfig-a006-20210809
i386                 randconfig-a002-20210809
i386                 randconfig-a001-20210809
i386                 randconfig-a003-20210809
i386                 randconfig-a004-20210808
i386                 randconfig-a005-20210808
i386                 randconfig-a006-20210808
i386                 randconfig-a002-20210808
i386                 randconfig-a001-20210808
i386                 randconfig-a003-20210808
i386                 randconfig-a005-20210809
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
i386                 randconfig-a012-20210809
i386                 randconfig-a015-20210809
i386                 randconfig-a011-20210809
i386                 randconfig-a013-20210809
i386                 randconfig-a014-20210809
i386                 randconfig-a016-20210809
x86_64               randconfig-a003-20210809
x86_64               randconfig-a002-20210809
x86_64               randconfig-a004-20210809
x86_64               randconfig-a006-20210809
x86_64               randconfig-a001-20210809
x86_64               randconfig-a005-20210809
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210810
x86_64               randconfig-c001-20210809
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
