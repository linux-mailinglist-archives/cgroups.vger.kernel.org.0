Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FFD2DD1A4
	for <lists+cgroups@lfdr.de>; Thu, 17 Dec 2020 13:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLQMn5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Dec 2020 07:43:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:16681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQMn4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 17 Dec 2020 07:43:56 -0500
IronPort-SDR: 7QX5EACp9AwoK5VkdNOg6wReLW/dVdDsPkZkt/KB/2tkYBPLxCov5+y7wOYApQv3N5qHrFBKfK
 XbDCgG5Qdm/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="154468733"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="154468733"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 04:43:16 -0800
IronPort-SDR: onqzpMd1omJ3C0U8SJpGzgSEzlRkpSYQwL0SX3QH7RFj77J6voVWJUZVOaXX2o9Ulwxipa1T+g
 b7KpP3BLk5QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="413362134"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2020 04:43:14 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpsck-0001C7-2m; Thu, 17 Dec 2020 12:43:14 +0000
Date:   Thu, 17 Dec 2020 20:42:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [cgroup:for-5.11] BUILD SUCCESS
 2d18e54dd8662442ef5898c6bdadeaf90b3cebbc
Message-ID: <5fdb5223.Tog57psUxhNhq2cM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git  for-5.11
branch HEAD: 2d18e54dd8662442ef5898c6bdadeaf90b3cebbc  cgroup: Fix memory leak when parsing multiple source parameters

elapsed time: 726m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
powerpc                      walnut_defconfig
m68k                          amiga_defconfig
powerpc                      arches_defconfig
m68k                          sun3x_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      chrp32_defconfig
sh                          landisk_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     taishan_defconfig
arm                       multi_v4t_defconfig
h8300                               defconfig
arm                         hackkit_defconfig
arm                         socfpga_defconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
sh                          rsk7264_defconfig
alpha                            alldefconfig
arm                         assabet_defconfig
sh                            hp6xx_defconfig
sh                     magicpanelr2_defconfig
xtensa                generic_kc705_defconfig
arm                        spear6xx_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5249evb_defconfig
powerpc                      ppc64e_defconfig
mips                 decstation_r4k_defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
arc                        vdk_hs38_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                     edosk2674_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
c6x                        evmc6474_defconfig
arm                         axm55xx_defconfig
arm                             mxs_defconfig
sh                         microdev_defconfig
powerpc                  storcenter_defconfig
ia64                            zx1_defconfig
arc                         haps_hs_defconfig
powerpc                     tqm8548_defconfig
ia64                      gensparse_defconfig
powerpc                        icon_defconfig
nds32                               defconfig
mips                      pic32mzda_defconfig
sh                          sdk7786_defconfig
arm                         mv78xx0_defconfig
arm                          simpad_defconfig
powerpc                   bluestone_defconfig
arc                      axs103_smp_defconfig
c6x                                 defconfig
powerpc                   currituck_defconfig
arm                       aspeed_g4_defconfig
sh                         ap325rxa_defconfig
mips                     decstation_defconfig
arm                          badge4_defconfig
h8300                    h8300h-sim_defconfig
mips                   sb1250_swarm_defconfig
powerpc                       maple_defconfig
arm                         s3c6400_defconfig
powerpc                     ppa8548_defconfig
powerpc                      ppc44x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                      rhel-8.3-kbuiltin
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
