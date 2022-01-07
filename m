Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD54875CA
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiAGKjO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 05:39:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:24013 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346855AbiAGKjJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 Jan 2022 05:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641551949; x=1673087949;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9GdO4wqC0kLGDcNcqwdRME4ErHXsLenJpPHBNN/bD64=;
  b=b+4ka/WTY/kMkWUtaCufaAzOmcXUrg1u1QCIFS3rWyV0sD8r+pDl7l72
   S/BguFEMITkirtndJHgPkCTobj8ZlIscB/+3Er4/iGUYaGwq67Iq00Wra
   FdyV1PAiPnor91WhjEUihBPeFtXIpA5sX5mmNUEqNq/DXGfhtlXnklBjR
   qMYGKiRUH2dAqYbuqsaRCKoH6J9wsmb4XNFWAq/Xrev4JJtspTASxNcWn
   0/FAFdmeasTmUT2WIJ8qtsVCJx2Wr3cJg/mG3PleixmlXe8/gCdps8pcU
   h3GcGLvRIxa4/FctmqfxFokzntq7tsu+R1qZULKSApK//UWATpFCO11b2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="267146450"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="267146450"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 02:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="668734586"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2022 02:37:51 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5md4-000IYO-Uv; Fri, 07 Jan 2022 10:37:50 +0000
Date:   Fri, 07 Jan 2022 18:37:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.16-fixes] BUILD SUCCESS
 bf35a7879f1dfb0d050fe779168bcf25c7de66f5
Message-ID: <61d817df.2CZY+54MP7fZUzJm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.16-fixes
branch HEAD: bf35a7879f1dfb0d050fe779168bcf25c7de66f5  selftests: cgroup: Test open-time cgroup namespace usage for migration checks

elapsed time: 720m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220107
parisc                           alldefconfig
arm                           stm32_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc40x_defconfig
arm                       omap2plus_defconfig
arm                            lart_defconfig
sh                        sh7763rdp_defconfig
sh                           se7343_defconfig
sh                           se7721_defconfig
sh                     sh7710voipgw_defconfig
sh                            shmin_defconfig
arc                          axs101_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
sh                          r7780mp_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
m68k                        mvme147_defconfig
sh                          lboxre2_defconfig
powerpc                      chrp32_defconfig
powerpc                      mgcoge_defconfig
mips                           jazz_defconfig
arm                           viper_defconfig
m68k                       m5275evb_defconfig
arc                        nsimosci_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
m68k                       m5475evb_defconfig
openrisc                            defconfig
arm                        realview_defconfig
powerpc                       ppc64_defconfig
arm                        trizeps4_defconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220106
ia64                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                                defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
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
x86_64               randconfig-a012-20220106
x86_64               randconfig-a015-20220106
x86_64               randconfig-a014-20220106
x86_64               randconfig-a013-20220106
x86_64               randconfig-a011-20220106
x86_64               randconfig-a016-20220106
s390                 randconfig-r044-20220106
riscv                randconfig-r042-20220106
arc                  randconfig-r043-20220106
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
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
x86_64               randconfig-c007-20220107
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
mips                        qi_lb60_defconfig
arm                          collie_defconfig
powerpc                          allyesconfig
arm                         s5pv210_defconfig
arm                         palmz72_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                         tb0219_defconfig
s390                             alldefconfig
mips                      bmips_stb_defconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
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
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
