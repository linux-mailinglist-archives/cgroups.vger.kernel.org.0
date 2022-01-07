Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF75487652
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 12:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347022AbiAGLQy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 06:16:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:43716 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232906AbiAGLQy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 Jan 2022 06:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641554214; x=1673090214;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9EslOF7mLae/oC9PAgQ0+tIaLX6bWQUnKoqqOUiOy58=;
  b=lP2kUQdjqa9aWNWYqfUHz/useK/Llp352wDLLCvqRpF+H6n7HqWS6N5/
   AaaMUv+pjff7uEvnqhwBKJYHfHSqEVfOjOFPecL9hphTFHXdyG7uOjQAy
   JiBwzH8b/3KCW/EXAShZpDyn9BQ1rdJsUD3xFY8wDcgFMlOYeCyv5KjQy
   zz3N+3ixzDLAC7wxyoDd4GnYFScX/hdHZzMfDuCV9pJnq0JhkLeAfbflC
   w3s7AvwJPCqAeEwcorbz4EHYtRl0qVFGeMnHGco986Dntvp0MCw3BQ5nk
   h4/Qr+9efa49idaQUZu6CaG6KNbvHP1dDIheVc6zA2Jw8zv2pq7i74jby
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="229660934"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="229660934"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 03:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="473289245"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2022 03:16:52 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5nEp-000Iap-UT; Fri, 07 Jan 2022 11:16:51 +0000
Date:   Fri, 07 Jan 2022 19:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a091b198ba1ab51c1d3ec1564b2263941f297d65
Message-ID: <61d820e4.J5jQIFRuMs5lW1GP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a091b198ba1ab51c1d3ec1564b2263941f297d65  Merge branch 'for-5.17' into for-next

elapsed time: 757m

configs tested: 111
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
arm                       omap2plus_defconfig
arm                            lart_defconfig
sh                        sh7763rdp_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          lboxre2_defconfig
powerpc                      chrp32_defconfig
powerpc                      mgcoge_defconfig
mips                           jazz_defconfig
arm                           viper_defconfig
arc                         haps_hs_defconfig
mips                         mpc30x_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
arm                  randconfig-c002-20220107
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
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
i386                 randconfig-a003-20220107
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
mips                        qi_lb60_defconfig
arm                          collie_defconfig
powerpc                          allyesconfig
arm                         s5pv210_defconfig
arm                         palmz72_defconfig
powerpc                 xes_mpc85xx_defconfig
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
