Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E7475C95
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhLOQCI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 11:02:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:10028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242892AbhLOQCH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 15 Dec 2021 11:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639584127; x=1671120127;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Rs/ahYK/EkewyAcbSGRhUEZ0pnbrQeFrBhAYX5mv7so=;
  b=F2KG/yjLxho+NbXWizinaDFArudVpY5fI/hlN+Z/dgRxQnpMST1dGLbZ
   8H1MEJRmVHi1f1n/mS90NQsbEIUnVeAVbM9Z1GSXZVWdwjv8Z6ZyjUcPE
   ucZuA/UcWWo8QtbsZD/0tUdaVI7OKbCtSyAhoalw5ZRGdz9L/NbubbR6d
   ndWq6L2QoYK3o0eO1zZTKUG5wP/KIyjxhnKJ1TGkcGQe4HUUteGksRUkI
   xHXWJh+mMJlMWSQDN34aygxYiTSckr/JVEnYbRQkSt6Hsybdcvb6j+scO
   egVXZaOehiArcid/i0zFeJScBk2r+LPYJrcbCdEDQZpTAuoW6LT9nsykC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219273285"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219273285"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 08:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518817370"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2021 08:02:05 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxWjF-000202-A7; Wed, 15 Dec 2021 16:02:05 +0000
Date:   Thu, 16 Dec 2021 00:01:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:review-migration-perms-2] BUILD SUCCESS
 2916424cbe1681e5e60e31f4f05213eb9dfa5fa4
Message-ID: <61ba1170.Bq3x4+BTEB7y48Ge%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-migration-perms-2
branch HEAD: 2916424cbe1681e5e60e31f4f05213eb9dfa5fa4  selftests: cgroup: Test open-time cgroup namespace usage for migration checks

elapsed time: 970m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211214
sh                 kfr2r09-romimage_defconfig
xtensa                    xip_kc705_defconfig
powerpc                    klondike_defconfig
sh                          urquell_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
powerpc                      acadia_defconfig
arm                            mps2_defconfig
mips                           ip22_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
arm                             mxs_defconfig
powerpc                      pasemi_defconfig
powerpc                    gamecube_defconfig
powerpc64                        alldefconfig
sh                          polaris_defconfig
mips                     loongson2k_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc836x_mds_defconfig
sh                      rts7751r2d1_defconfig
sh                         microdev_defconfig
csky                             alldefconfig
powerpc                     stx_gp3_defconfig
parisc                           alldefconfig
m68k                        m5307c3_defconfig
xtensa                          iss_defconfig
sh                            shmin_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                        stmark2_defconfig
i386                             alldefconfig
mips                           rs90_defconfig
mips                    maltaup_xpa_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
arm                         socfpga_defconfig
powerpc                      bamboo_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
arm                        oxnas_v6_defconfig
arm                        shmobile_defconfig
sh                           se7724_defconfig
arm                        magician_defconfig
sh                          r7780mp_defconfig
powerpc                          g5_defconfig
arm                           sama7_defconfig
arm                  randconfig-c002-20211214
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211215
x86_64               randconfig-a014-20211215
x86_64               randconfig-a012-20211215
x86_64               randconfig-a013-20211215
x86_64               randconfig-a016-20211215
x86_64               randconfig-a015-20211215
i386                 randconfig-a013-20211215
i386                 randconfig-a011-20211215
i386                 randconfig-a016-20211215
i386                 randconfig-a014-20211215
i386                 randconfig-a015-20211215
i386                 randconfig-a012-20211215
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a015-20211214
i386                 randconfig-a012-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214
hexagon              randconfig-r045-20211215
hexagon              randconfig-r041-20211215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
