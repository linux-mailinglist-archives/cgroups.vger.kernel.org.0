Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28272DE36
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjFMJtA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jun 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241996AbjFMJsn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jun 2023 05:48:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA67D26A9
        for <cgroups@vger.kernel.org>; Tue, 13 Jun 2023 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686649667; x=1718185667;
  h=date:from:to:cc:subject:message-id;
  bh=HZd48uqxfaDIgHt97ozisplnqXPdXA6oeXgYNnFAeSk=;
  b=jHCa+ffQarVbxH08zjO8B3/Z1wcdlyrM1Gqi+GBrJY8geG3ekS9u1cj2
   p6Dw6QC1PJ+wc4Ei1HlWshklxLJCkGQiAE4bmEKv5KpnkDAuKSwbaoMRl
   EovUWZZAa1yELYFvXgDlt4F88qyKz4/pH99ncGoFn5Z2f/98hzrSksn/Y
   JdgPjoa/51jtRXJj8g7QYwzEAj22gPRGclMadK7pj91ovx+QrROpNJurG
   O5azViRsC627PrtEKGLx/8IiP1viSILugFBX4ri4frgDuIRYfAi2yZuZv
   vX+s2u5mjSdDpQruGRKL730jEC+00rAi49Vb/FAmXgdGtYtfP9lNdMdVi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444657856"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="444657856"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="711575425"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="711575425"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 02:47:46 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q90cr-0001AZ-1J;
        Tue, 13 Jun 2023 09:47:45 +0000
Date:   Tue, 13 Jun 2023 17:47:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 18740f47e5fa808d936213e4bbc6aaa25d7a2525
Message-ID: <202306131723.aar3nZ0K-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 18740f47e5fa808d936213e4bbc6aaa25d7a2525  Merge branch 'for-6.5' into for-next

elapsed time: 723m

configs tested: 130
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230612   gcc  
arc                  randconfig-r033-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r016-20230612   clang
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230612   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230612   gcc  
csky                 randconfig-r003-20230612   gcc  
csky                 randconfig-r031-20230612   gcc  
csky                 randconfig-r032-20230612   gcc  
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230612   gcc  
m68k                 randconfig-r023-20230612   gcc  
m68k                 randconfig-r033-20230612   gcc  
microblaze           randconfig-r013-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230612   gcc  
mips                     cu1830-neo_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                 randconfig-r001-20230612   gcc  
mips                 randconfig-r031-20230612   gcc  
mips                 randconfig-r034-20230612   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230612   gcc  
nios2                randconfig-r022-20230612   gcc  
openrisc     buildonly-randconfig-r004-20230612   gcc  
openrisc             randconfig-r015-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
openrisc             randconfig-r036-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230612   gcc  
parisc               randconfig-r012-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc      buildonly-randconfig-r005-20230612   gcc  
powerpc                      obs600_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230612   clang
riscv                randconfig-r011-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r002-20230612   gcc  
sh                   randconfig-r012-20230612   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230612   gcc  
sparc                randconfig-r011-20230612   gcc  
sparc64      buildonly-randconfig-r001-20230612   gcc  
sparc64              randconfig-r013-20230612   gcc  
sparc64              randconfig-r015-20230612   gcc  
sparc64              randconfig-r021-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r005-20230612   clang
x86_64               randconfig-r014-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
