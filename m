Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84B757522
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGRHQV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 03:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGRHQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 03:16:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6610E0
        for <cgroups@vger.kernel.org>; Tue, 18 Jul 2023 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689664573; x=1721200573;
  h=date:from:to:cc:subject:message-id;
  bh=y3Us/eqi8ier+iWQC7ofcSI3V8tNvBmJoLTF/NJVXb4=;
  b=fvYySy5MOwJvGW/uPoq5OsOzevBw/e8Mo40hYvB4Ab/OHJTBeZN6rGyT
   Ttkjnw9bWvE2EHl1qobNq/bgHgMJEnVfHlbHtBYGllTx1Z+NRU2oLonCg
   uMNNbIoO0/JHWcTiEY2bDOsPrGL+fP3EKGnh+OIDj03Kw/CKVzQcKHBAp
   5LKT7OTJ0c1SbhrRAW7h56/rUGt1nzpJ89qtkpyrxCQyCJCf+p7YJ0ycm
   Ozb4UNReohlU/174wWmoBbSQ2XYZSdNDFMPBYfWbtz8Io9sO/jFHoxEO1
   RA/Cy3qc4D7JoTYMBoY8zIN5cT/jkth3HT/GbvllZNFhT/fiuiJIs0QSg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429894521"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="429894521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 00:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="837168185"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="837168185"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2023 00:15:51 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLew2-0000Jx-39;
        Tue, 18 Jul 2023 07:15:50 +0000
Date:   Tue, 18 Jul 2023 15:15:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 c25ff4b911a11908c7f05bc07cc6762f9cece2b5
Message-ID: <202307181539.JKIP4dXC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: c25ff4b911a11908c7f05bc07cc6762f9cece2b5  cgroup: remove cgrp->kn check in css_populate_dir()

elapsed time: 723m

configs tested: 154
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230717   gcc  
alpha                randconfig-r012-20230717   gcc  
alpha                randconfig-r025-20230717   gcc  
alpha                randconfig-r026-20230717   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r013-20230717   gcc  
arc                  randconfig-r043-20230717   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                  randconfig-r046-20230717   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230717   gcc  
arm64                randconfig-r015-20230717   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r023-20230717   gcc  
hexagon              randconfig-r024-20230717   clang
hexagon              randconfig-r033-20230717   clang
hexagon              randconfig-r035-20230717   clang
hexagon              randconfig-r041-20230717   clang
hexagon              randconfig-r045-20230717   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230717   clang
i386         buildonly-randconfig-r005-20230717   clang
i386         buildonly-randconfig-r006-20230717   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230717   clang
i386                 randconfig-i002-20230717   clang
i386                 randconfig-i003-20230717   clang
i386                 randconfig-i004-20230717   clang
i386                 randconfig-i005-20230717   clang
i386                 randconfig-i006-20230717   clang
i386                 randconfig-i011-20230717   gcc  
i386                 randconfig-i012-20230717   gcc  
i386                 randconfig-i013-20230717   gcc  
i386                 randconfig-i014-20230717   gcc  
i386                 randconfig-i015-20230717   gcc  
i386                 randconfig-i016-20230717   gcc  
i386                 randconfig-r005-20230717   clang
i386                 randconfig-r013-20230717   gcc  
i386                 randconfig-r015-20230717   gcc  
i386                 randconfig-r035-20230717   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230717   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                 randconfig-r003-20230717   gcc  
m68k                 randconfig-r004-20230717   gcc  
m68k                 randconfig-r032-20230717   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r014-20230717   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r022-20230717   clang
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230717   gcc  
nios2                randconfig-r012-20230717   gcc  
openrisc             randconfig-r003-20230717   gcc  
openrisc             randconfig-r004-20230717   gcc  
openrisc             randconfig-r021-20230717   gcc  
openrisc             randconfig-r023-20230717   gcc  
openrisc             randconfig-r024-20230717   gcc  
openrisc             randconfig-r033-20230717   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r031-20230717   gcc  
parisc               randconfig-r036-20230717   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r001-20230717   clang
powerpc              randconfig-r016-20230717   gcc  
powerpc              randconfig-r026-20230717   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230717   clang
riscv                randconfig-r006-20230717   clang
riscv                randconfig-r021-20230717   gcc  
riscv                randconfig-r031-20230717   clang
riscv                randconfig-r034-20230717   clang
riscv                randconfig-r042-20230717   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230717   gcc  
s390                 randconfig-r044-20230717   gcc  
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r005-20230717   gcc  
sh                   randconfig-r034-20230717   gcc  
sh                   randconfig-r036-20230717   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230717   gcc  
sparc                randconfig-r011-20230717   gcc  
sparc                randconfig-r022-20230717   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230717   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230717   clang
x86_64       buildonly-randconfig-r002-20230717   clang
x86_64       buildonly-randconfig-r003-20230717   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230717   gcc  
x86_64               randconfig-x002-20230717   gcc  
x86_64               randconfig-x003-20230717   gcc  
x86_64               randconfig-x004-20230717   gcc  
x86_64               randconfig-x005-20230717   gcc  
x86_64               randconfig-x006-20230717   gcc  
x86_64               randconfig-x011-20230717   clang
x86_64               randconfig-x012-20230717   clang
x86_64               randconfig-x013-20230717   clang
x86_64               randconfig-x014-20230717   clang
x86_64               randconfig-x015-20230717   clang
x86_64               randconfig-x016-20230717   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
