Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C470DD58
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjEWNTS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjEWNTR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 09:19:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9ADFF
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684847956; x=1716383956;
  h=date:from:to:cc:subject:message-id;
  bh=FDIN1q8G+Yfb+H24iH4LnJ3xIhTP1enJL3LhPYkmvYc=;
  b=PgDRoZhdY+MIWZsJHTbouhOdNAQDJGLdo64rZxAnygOxiAJ9lEAqf8L7
   +GpfeeUrEmdwTUkh5CwQ60oM0KZexA5K1WcPe6ASh3wWuxA38ZYXYCiLr
   4W/qKhFRwhdKzBb5/AtxegSIYPTG7gaz7s95oo7jBCPMFcoogPqBBP6oT
   kRJLR3qc0tzhPG10DWkVE+LM4RpkmXhcLactTxZ87TBUcbZj3X7mOQXAk
   T1wat+jRkineuiq04sUZC+SMyDvFF6XOb8wUYui6ogXw5pTURXzM9RkaI
   am7vqO4K0dCm73unvAhNKT1icU/QAIDNgYiIb632tKucNYBX1lT4N+hZE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="332845365"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="332845365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="769014046"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="769014046"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2023 06:19:15 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1Rv0-000DnU-2h;
        Tue, 23 May 2023 13:19:14 +0000
Date:   Tue, 23 May 2023 21:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 e5dfd745f9ab5182845c4d1b0bcf93bcf7945388
Message-ID: <20230523131902.yuN6q%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230523172912/lkp-src/repo/*/tj-cgroup
https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: e5dfd745f9ab5182845c4d1b0bcf93bcf7945388  Merge branch 'for-6.4-fixes' into for-next

elapsed time: 723m

configs tested: 149
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230521   gcc  
alpha        buildonly-randconfig-r006-20230522   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230521   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230522   gcc  
arc                  randconfig-r033-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230521   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230521   clang
arm64                randconfig-r021-20230521   gcc  
arm64                randconfig-r023-20230521   gcc  
arm64                randconfig-r023-20230522   clang
csky                                defconfig   gcc  
csky                 randconfig-r024-20230521   gcc  
csky                 randconfig-r025-20230521   gcc  
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-r003-20230522   gcc  
i386                 randconfig-r013-20230522   clang
i386                 randconfig-r032-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230522   gcc  
ia64         buildonly-randconfig-r002-20230521   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230522   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230521   gcc  
loongarch            randconfig-r026-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230521   gcc  
m68k                 randconfig-r016-20230522   gcc  
m68k                 randconfig-r022-20230522   gcc  
microblaze   buildonly-randconfig-r005-20230522   gcc  
microblaze   buildonly-randconfig-r006-20230521   gcc  
microblaze           randconfig-r031-20230521   gcc  
microblaze           randconfig-r032-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230522   clang
mips                 randconfig-r036-20230522   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r015-20230522   gcc  
openrisc             randconfig-r016-20230521   gcc  
openrisc             randconfig-r021-20230522   gcc  
openrisc             randconfig-r033-20230522   gcc  
openrisc             randconfig-r034-20230521   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230521   gcc  
powerpc              randconfig-r036-20230521   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230522   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230521   gcc  
sh                   randconfig-r001-20230522   gcc  
sh                   randconfig-r002-20230521   gcc  
sh                   randconfig-r004-20230521   gcc  
sparc        buildonly-randconfig-r004-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230522   gcc  
sparc                randconfig-r013-20230521   gcc  
sparc                randconfig-r014-20230522   gcc  
sparc                randconfig-r022-20230521   gcc  
sparc                randconfig-r034-20230522   gcc  
sparc64      buildonly-randconfig-r003-20230522   gcc  
sparc64              randconfig-r026-20230522   gcc  
sparc64              randconfig-r031-20230522   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230522   gcc  
xtensa               randconfig-r035-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
