Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D886BF993
	for <lists+cgroups@lfdr.de>; Sat, 18 Mar 2023 12:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCRLRq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Mar 2023 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRLRp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Mar 2023 07:17:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611F52F67
        for <cgroups@vger.kernel.org>; Sat, 18 Mar 2023 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679138264; x=1710674264;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1N7+RKWsa6sOqJntApG0I0tuGZ6JmxGuC5S+moVW86g=;
  b=Rypcq+aWjC75qYjzSjvn90gYoUL7VP/uA4G+r+M6+Fdu5zaNd30V50yT
   h1FB+0m+7NVlCvgFFVFaeey87/Dy/g1CYXuR5/RVopVhWcBsgZMJUlf8H
   /4M6PRE8XxVeKD44mI4nKrOlkTMyRhJqXp4eZuafH26N+K++VYjfR5lNB
   7KQA2y0gGic9g4ACinBt9IoiGZK3RE3uj3jg5eZ8in81lFA9NREqF5vny
   DsZ5yf7N+L2vQ3s59cUsfW5kRZUIZFv2Xk64UAeQBYV1KE9oBLa3TngFf
   dlLbPON/5mvFfDstOb5IMPwAR3JfkAqR5b2X06A6jt9RTYtg1jnhKmlMa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424703571"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="424703571"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 04:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="744833661"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="744833661"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2023 04:17:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdUZB-000A1E-2t;
        Sat, 18 Mar 2023 11:17:41 +0000
Date:   Sat, 18 Mar 2023 19:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.3-fixes] BUILD SUCCESS
 fcdb1eda5302599045bb366e679cccb4216f3873
Message-ID: <64159da3.oln5hYujAtZviVX2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.3-fixes
branch HEAD: fcdb1eda5302599045bb366e679cccb4216f3873  cgroup: fix display of forceidle time at root

elapsed time: 733m

configs tested: 308
configs skipped: 31

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha        buildonly-randconfig-r002-20230313   gcc  
alpha        buildonly-randconfig-r004-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230313   gcc  
alpha                randconfig-r016-20230312   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r034-20230313   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230313   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc          buildonly-randconfig-r005-20230313   gcc  
arc          buildonly-randconfig-r006-20230313   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230312   gcc  
arc                  randconfig-r006-20230313   gcc  
arc                  randconfig-r011-20230313   gcc  
arc                  randconfig-r013-20230313   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r023-20230313   gcc  
arc                  randconfig-r026-20230312   gcc  
arc                  randconfig-r031-20230312   gcc  
arc                  randconfig-r032-20230312   gcc  
arc                  randconfig-r032-20230318   gcc  
arc                  randconfig-r034-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arc                  randconfig-r043-20230318   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230313   gcc  
arm          buildonly-randconfig-r004-20230313   gcc  
arm          buildonly-randconfig-r005-20230313   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230313   clang
arm                  randconfig-r006-20230313   clang
arm                  randconfig-r016-20230313   gcc  
arm                  randconfig-r024-20230313   gcc  
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r026-20230313   gcc  
arm                  randconfig-r035-20230312   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230313   gcc  
arm64        buildonly-randconfig-r006-20230313   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230312   clang
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r005-20230312   clang
arm64                randconfig-r006-20230312   clang
arm64                randconfig-r011-20230312   gcc  
arm64                randconfig-r012-20230313   clang
arm64                randconfig-r021-20230312   gcc  
arm64                randconfig-r034-20230313   gcc  
csky         buildonly-randconfig-r004-20230312   gcc  
csky         buildonly-randconfig-r005-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230312   gcc  
csky                 randconfig-r003-20230312   gcc  
csky                 randconfig-r013-20230312   gcc  
csky                 randconfig-r022-20230313   gcc  
csky                 randconfig-r023-20230312   gcc  
csky                 randconfig-r025-20230313   gcc  
csky                 randconfig-r033-20230313   gcc  
csky                 randconfig-r035-20230312   gcc  
csky                 randconfig-r036-20230312   gcc  
hexagon              randconfig-r001-20230313   clang
hexagon              randconfig-r015-20230312   clang
hexagon              randconfig-r016-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230313   gcc  
i386         buildonly-randconfig-r003-20230313   gcc  
i386         buildonly-randconfig-r006-20230313   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                          randconfig-c001   gcc  
i386                 randconfig-r004-20230313   gcc  
i386                 randconfig-r005-20230313   gcc  
i386                 randconfig-r032-20230313   gcc  
i386                 randconfig-r035-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230313   gcc  
ia64                 randconfig-r006-20230313   gcc  
ia64                 randconfig-r011-20230312   gcc  
ia64                 randconfig-r012-20230312   gcc  
ia64                 randconfig-r015-20230315   gcc  
ia64                 randconfig-r016-20230312   gcc  
ia64                 randconfig-r022-20230313   gcc  
ia64                 randconfig-r023-20230313   gcc  
ia64                 randconfig-r025-20230313   gcc  
ia64                 randconfig-r031-20230312   gcc  
ia64                 randconfig-r036-20230318   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230313   gcc  
loongarch    buildonly-randconfig-r002-20230313   gcc  
loongarch    buildonly-randconfig-r005-20230312   gcc  
loongarch    buildonly-randconfig-r006-20230313   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230313   gcc  
loongarch            randconfig-r021-20230312   gcc  
loongarch            randconfig-r022-20230312   gcc  
loongarch            randconfig-r026-20230312   gcc  
loongarch            randconfig-r036-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230313   gcc  
m68k         buildonly-randconfig-r004-20230313   gcc  
m68k         buildonly-randconfig-r006-20230313   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230313   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r011-20230312   gcc  
m68k                 randconfig-r011-20230313   gcc  
m68k                 randconfig-r012-20230312   gcc  
m68k                 randconfig-r014-20230313   gcc  
m68k                 randconfig-r014-20230315   gcc  
m68k                 randconfig-r016-20230313   gcc  
m68k                 randconfig-r031-20230313   gcc  
m68k                 randconfig-r033-20230318   gcc  
m68k                 randconfig-r035-20230318   gcc  
microblaze   buildonly-randconfig-r002-20230312   gcc  
microblaze   buildonly-randconfig-r002-20230313   gcc  
microblaze   buildonly-randconfig-r006-20230312   gcc  
microblaze           randconfig-r001-20230312   gcc  
microblaze           randconfig-r001-20230313   gcc  
microblaze           randconfig-r006-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230312   gcc  
mips         buildonly-randconfig-r004-20230313   clang
mips         buildonly-randconfig-r006-20230313   clang
mips                     decstation_defconfig   gcc  
mips                 randconfig-r001-20230312   gcc  
mips                 randconfig-r013-20230312   clang
mips                 randconfig-r015-20230313   gcc  
mips                 randconfig-r033-20230312   gcc  
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230312   gcc  
nios2                randconfig-r012-20230313   gcc  
nios2                randconfig-r015-20230313   gcc  
nios2                randconfig-r016-20230313   gcc  
nios2                randconfig-r021-20230313   gcc  
nios2                randconfig-r026-20230312   gcc  
openrisc     buildonly-randconfig-r001-20230312   gcc  
openrisc     buildonly-randconfig-r003-20230312   gcc  
openrisc     buildonly-randconfig-r005-20230313   gcc  
openrisc             randconfig-r012-20230313   gcc  
openrisc             randconfig-r014-20230312   gcc  
openrisc             randconfig-r014-20230313   gcc  
openrisc             randconfig-r021-20230313   gcc  
openrisc             randconfig-r032-20230312   gcc  
openrisc             randconfig-r036-20230312   gcc  
parisc       buildonly-randconfig-r006-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc               randconfig-r005-20230313   gcc  
parisc               randconfig-r013-20230312   gcc  
parisc               randconfig-r014-20230312   gcc  
parisc               randconfig-r021-20230313   gcc  
parisc               randconfig-r023-20230313   gcc  
parisc               randconfig-r026-20230313   gcc  
parisc               randconfig-r033-20230313   gcc  
parisc               randconfig-r034-20230313   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230312   gcc  
powerpc      buildonly-randconfig-r005-20230312   gcc  
powerpc      buildonly-randconfig-r006-20230312   gcc  
powerpc              randconfig-c003-20230312   gcc  
powerpc              randconfig-r003-20230313   gcc  
powerpc              randconfig-r012-20230312   gcc  
powerpc              randconfig-r015-20230313   clang
powerpc              randconfig-r026-20230312   gcc  
powerpc              randconfig-r036-20230313   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230312   gcc  
riscv        buildonly-randconfig-r002-20230313   clang
riscv        buildonly-randconfig-r004-20230312   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230312   clang
riscv                randconfig-r004-20230313   gcc  
riscv                randconfig-r005-20230318   clang
riscv                randconfig-r011-20230313   clang
riscv                randconfig-r012-20230312   gcc  
riscv                randconfig-r014-20230312   gcc  
riscv                randconfig-r024-20230312   gcc  
riscv                randconfig-r031-20230313   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                randconfig-r042-20230318   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230312   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230312   gcc  
s390                 randconfig-r013-20230313   clang
s390                 randconfig-r021-20230312   gcc  
s390                 randconfig-r023-20230312   gcc  
s390                 randconfig-r025-20230312   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
s390                 randconfig-r044-20230318   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230313   gcc  
sh           buildonly-randconfig-r005-20230312   gcc  
sh           buildonly-randconfig-r006-20230313   gcc  
sh                   randconfig-r015-20230312   gcc  
sh                   randconfig-r016-20230312   gcc  
sh                   randconfig-r023-20230313   gcc  
sh                   randconfig-r024-20230312   gcc  
sh                   randconfig-r024-20230313   gcc  
sh                   randconfig-r035-20230312   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230313   gcc  
sparc                randconfig-r015-20230312   gcc  
sparc                randconfig-r021-20230312   gcc  
sparc                randconfig-r022-20230312   gcc  
sparc                randconfig-r023-20230312   gcc  
sparc                randconfig-r034-20230312   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc64      buildonly-randconfig-r001-20230312   gcc  
sparc64      buildonly-randconfig-r003-20230312   gcc  
sparc64      buildonly-randconfig-r003-20230313   gcc  
sparc64              randconfig-r001-20230313   gcc  
sparc64              randconfig-r002-20230312   gcc  
sparc64              randconfig-r004-20230312   gcc  
sparc64              randconfig-r004-20230313   gcc  
sparc64              randconfig-r012-20230313   gcc  
sparc64              randconfig-r015-20230312   gcc  
sparc64              randconfig-r021-20230312   gcc  
sparc64              randconfig-r021-20230313   gcc  
sparc64              randconfig-r022-20230312   gcc  
sparc64              randconfig-r024-20230312   gcc  
sparc64              randconfig-r024-20230313   gcc  
sparc64              randconfig-r025-20230313   gcc  
sparc64              randconfig-r026-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r004-20230313   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-k001-20230313   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r016-20230313   clang
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230312   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa       buildonly-randconfig-r005-20230312   gcc  
xtensa       buildonly-randconfig-r006-20230312   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r001-20230313   gcc  
xtensa               randconfig-r003-20230312   gcc  
xtensa               randconfig-r015-20230312   gcc  
xtensa               randconfig-r016-20230312   gcc  
xtensa               randconfig-r023-20230312   gcc  
xtensa               randconfig-r032-20230313   gcc  
xtensa               randconfig-r033-20230312   gcc  
xtensa               randconfig-r034-20230312   gcc  
xtensa               randconfig-r034-20230318   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
