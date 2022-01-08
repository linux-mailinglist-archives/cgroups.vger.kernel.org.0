Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B848830E
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiAHKfx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 Jan 2022 05:35:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:41065 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbiAHKfx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 Jan 2022 05:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641638153; x=1673174153;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7qsJpxkbFWhSanLCb25u5fZc1kxTj+hIOlKL5i7SRkM=;
  b=dqCpmtd6nG4CiK40JaGcJcqcswv6RpX6I4z7/jfHoOxapBT7vpu/qVg/
   1mA5m8PbJeNWMK+uZuRCs+31RsROrZHNTMDbJyfsZeZoDEA8sxIz2M3da
   pm5eJwXpl/ANPAQ+/mH3aYdZwmgK9EVDi4aI3llQhWvqbKvzVAjUAZdQ/
   qTSmbkEWiZqZgG8muRcz5zzjcKXX10QHqRLKLyRpn09cTVqGYE6CI2JSP
   6OKB9PjFZ6Rd77wM3e648iWOwcFMM27gSEEgmI40s3dLskwMbEuozemsv
   WY/LJK0PnjuL8WQafcS5hJ2hevy/C0Ad+QyJRqzn5GB6bRZueMzIzhGSj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="222992000"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="222992000"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 02:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="514117998"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2022 02:35:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n694g-0000Wm-SQ; Sat, 08 Jan 2022 10:35:50 +0000
Date:   Sat, 08 Jan 2022 18:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.17] BUILD SUCCESS
 d4296faebd337e5f76c0fddb815de33d2b0ad118
Message-ID: <61d968c8.6C6FQwjY23gCV6x0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17
branch HEAD: d4296faebd337e5f76c0fddb815de33d2b0ad118  cpuset: convert 'allowed' in __cpuset_node_allowed() to be boolean

elapsed time: 728m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20220107
m68k                            q40_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                         cm_x300_defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
sparc                               defconfig
sh                            shmin_defconfig
powerpc                      ppc6xx_defconfig
sh                            hp6xx_defconfig
m68k                       m5475evb_defconfig
powerpc                 linkstation_defconfig
sparc                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
arm                         assabet_defconfig
h8300                            allyesconfig
powerpc                    sam440ep_defconfig
um                             i386_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
xtensa                              defconfig
sh                              ul2_defconfig
um                                  defconfig
sh                          r7780mp_defconfig
powerpc                      bamboo_defconfig
alpha                            allyesconfig
sparc                       sparc32_defconfig
nios2                            allyesconfig
powerpc                      cm5200_defconfig
microblaze                      mmu_defconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220108
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
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
s390                 randconfig-r044-20220108
arc                  randconfig-r043-20220108
riscv                randconfig-r042-20220108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
s390                 randconfig-c005-20220107
x86_64               randconfig-c007-20220107
mips                           ip28_defconfig
powerpc                      katmai_defconfig
powerpc                     skiroot_defconfig
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
x86_64               randconfig-a005-20220108
x86_64               randconfig-a001-20220108
x86_64               randconfig-a004-20220108
x86_64               randconfig-a006-20220108
x86_64               randconfig-a003-20220108
x86_64               randconfig-a002-20220108
s390                 randconfig-r044-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
