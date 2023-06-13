Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF45572DE43
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbjFMJuc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jun 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbjFMJuQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jun 2023 05:50:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1A10FF
        for <cgroups@vger.kernel.org>; Tue, 13 Jun 2023 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686649789; x=1718185789;
  h=date:from:to:cc:subject:message-id;
  bh=CtxMiaAukUMUkvFSpOBRzZj9xvTlF97d33DazXOzJRs=;
  b=jid5VOiO8e0WjHsJGtFdPweLK2Ehq1Sc5wwEAHgS9xdJLt4xpIFF3juW
   FhwfbuxPTeaDXJsIj0G/XBKVLsabYDOPf44j342KswM3f181zQIo7+ZR5
   ZzI3MRhJskw1dCRc1B6XMniZ10H3HzDwH8dCNu/h4FV4VnEI05xMW3c8J
   v6kJ6ro1M31OSy6DO5hZXnQyPXUKq/19HxcxU2CCVI41N3heCkZ1ebFbv
   pUBUiecoN32agMGIjhyjmvM13nlQ0ii5tb7Kb5hKrX3yThWntLlELh4xM
   k6EX9Ez2tbg50iV9UD5hsaZHoIRR8KiYht+2Pq6b3foB2p02uzyK0aK0D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338643419"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="338643419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835817243"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835817243"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2023 02:49:46 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q90eo-0001Bg-0X;
        Tue, 13 Jun 2023 09:49:46 +0000
Date:   Tue, 13 Jun 2023 17:49:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.4-fixes] BUILD SUCCESS
 6f363f5aa845561f7ea496d8b1175e3204470486
Message-ID: <202306131737.wHQXVOOY-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.4-fixes
branch HEAD: 6f363f5aa845561f7ea496d8b1175e3204470486  cgroup: Do not corrupt task iteration when rebinding subsystem

elapsed time: 726m

configs tested: 124
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r003-20230612   gcc  
arm                  randconfig-r024-20230612   clang
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230612   clang
csky                                defconfig   gcc  
csky                 randconfig-r031-20230612   gcc  
csky                 randconfig-r034-20230612   gcc  
hexagon              randconfig-r031-20230612   clang
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
i386                 randconfig-r021-20230612   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230612   gcc  
m68k                 randconfig-r033-20230612   gcc  
microblaze   buildonly-randconfig-r002-20230612   gcc  
microblaze           randconfig-r013-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                 randconfig-r001-20230612   gcc  
mips                         rt305x_defconfig   gcc  
nios2        buildonly-randconfig-r004-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230612   gcc  
openrisc             randconfig-r015-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230612   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230612   gcc  
parisc               randconfig-r035-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc                      obs600_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230612   clang
riscv                randconfig-r011-20230612   gcc  
riscv                randconfig-r033-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r002-20230612   gcc  
sh                   randconfig-r012-20230612   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230612   gcc  
sparc                randconfig-r022-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
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
x86_64               randconfig-r014-20230612   gcc  
x86_64               randconfig-r026-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230612   gcc  
xtensa               randconfig-r014-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
