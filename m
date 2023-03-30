Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9E6CFCAC
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjC3H0E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC3H0D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:26:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC69E26A4
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680161161; x=1711697161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XJiNYmedYAVnEhjts6BhrgRV8G7RScLuEikrZx7vNdQ=;
  b=ccGlWo6IN9HUw5pOeSuZ3LVbIxBGePq/Da8IfxzZOml9tPgjiqkv3gVO
   c7J6pDc0yiYLJJNAaRw9SVz+WYh/RvU8Bbeek2cvOuDcnW9JVd5wkf7Q5
   P2Gem1y/CoynKL8ZTaZgXB5hAEgQEM0NJcg9jdkJx2wdzU+GpVxhbWm/I
   Mj+x3gy8AgK2wsvv68xS4h4cr7qmwiWZ6OBgLpclkNGpAxm0OW2leBWsa
   vExtNgxcaAckHGIYP2WSUI1Opb/5NMAHNtIMWez1XzARObmYIw5h+uXMi
   vj0ES8DwFgDzVKylRS9xMxx2xSOS/WRbwDn3+2ZKGp2hobwoyFjP0DKan
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="406049862"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="406049862"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="717199067"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="717199067"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2023 00:23:37 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phmdE-000KVq-2a;
        Thu, 30 Mar 2023 07:23:36 +0000
Date:   Thu, 30 Mar 2023 15:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 d86bd73e834f24e04a7eb67540ec9bbcbffad446
Message-ID: <642538c3.pRqCeXxdYGkQ3lZm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: d86bd73e834f24e04a7eb67540ec9bbcbffad446  Merge branch 'for-6.4' into for-next

elapsed time: 727m

configs tested: 206
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha        buildonly-randconfig-r004-20230329   gcc  
alpha        buildonly-randconfig-r005-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230329   gcc  
alpha                randconfig-r015-20230329   gcc  
alpha                randconfig-r023-20230329   gcc  
alpha                randconfig-r026-20230329   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230329   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                  randconfig-r021-20230329   gcc  
arm                  randconfig-r023-20230329   gcc  
arm                  randconfig-r046-20230329   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r003-20230329   gcc  
arm64                randconfig-r025-20230329   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230329   gcc  
csky                 randconfig-r004-20230329   gcc  
csky                 randconfig-r011-20230329   gcc  
csky                 randconfig-r026-20230330   gcc  
csky                 randconfig-r031-20230329   gcc  
csky                 randconfig-r033-20230329   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon      buildonly-randconfig-r005-20230329   clang
hexagon              randconfig-r001-20230329   clang
hexagon              randconfig-r015-20230329   clang
hexagon              randconfig-r016-20230329   clang
hexagon              randconfig-r032-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r045-20230329   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230329   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230329   gcc  
ia64                 randconfig-r005-20230329   gcc  
ia64                 randconfig-r006-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r026-20230329   gcc  
ia64                 randconfig-r033-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230329   gcc  
loongarch    buildonly-randconfig-r004-20230329   gcc  
loongarch    buildonly-randconfig-r006-20230329   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230329   gcc  
loongarch            randconfig-r004-20230329   gcc  
loongarch            randconfig-r006-20230329   gcc  
loongarch            randconfig-r013-20230329   gcc  
loongarch            randconfig-r015-20230329   gcc  
loongarch            randconfig-r021-20230329   gcc  
loongarch            randconfig-r036-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230329   gcc  
m68k         buildonly-randconfig-r002-20230329   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230329   gcc  
m68k                 randconfig-r014-20230329   gcc  
m68k                 randconfig-r022-20230329   gcc  
m68k                 randconfig-r025-20230329   gcc  
microblaze   buildonly-randconfig-r001-20230329   gcc  
microblaze           randconfig-r013-20230329   gcc  
microblaze           randconfig-r016-20230329   gcc  
microblaze           randconfig-r023-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
microblaze           randconfig-r032-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230329   clang
mips                 randconfig-r001-20230329   clang
mips                 randconfig-r011-20230329   gcc  
mips                 randconfig-r012-20230329   gcc  
mips                 randconfig-r021-20230330   gcc  
mips                 randconfig-r025-20230329   gcc  
nios2        buildonly-randconfig-r003-20230329   gcc  
nios2        buildonly-randconfig-r004-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230329   gcc  
nios2                randconfig-r025-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
openrisc     buildonly-randconfig-r002-20230329   gcc  
openrisc             randconfig-r006-20230329   gcc  
openrisc             randconfig-r021-20230329   gcc  
openrisc             randconfig-r026-20230329   gcc  
openrisc             randconfig-r036-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230329   gcc  
parisc               randconfig-r004-20230329   gcc  
parisc               randconfig-r006-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r022-20230330   gcc  
parisc               randconfig-r023-20230330   gcc  
parisc               randconfig-r024-20230329   gcc  
parisc               randconfig-r025-20230329   gcc  
parisc               randconfig-r032-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc              randconfig-r003-20230329   gcc  
powerpc              randconfig-r024-20230329   clang
powerpc              randconfig-r026-20230329   clang
powerpc              randconfig-r034-20230329   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230329   gcc  
riscv                randconfig-r006-20230329   gcc  
riscv                randconfig-r022-20230329   clang
riscv                randconfig-r031-20230329   gcc  
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230329   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230329   gcc  
s390                 randconfig-r014-20230329   clang
s390                 randconfig-r016-20230329   clang
s390                 randconfig-r022-20230329   clang
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r026-20230329   clang
s390                 randconfig-r034-20230329   gcc  
s390                 randconfig-r035-20230329   gcc  
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230329   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r005-20230329   gcc  
sh                   randconfig-r022-20230329   gcc  
sh                   randconfig-r024-20230329   gcc  
sh                   randconfig-r031-20230329   gcc  
sparc        buildonly-randconfig-r003-20230329   gcc  
sparc        buildonly-randconfig-r004-20230329   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230329   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc                randconfig-r024-20230330   gcc  
sparc64      buildonly-randconfig-r005-20230329   gcc  
sparc64      buildonly-randconfig-r006-20230329   gcc  
sparc64              randconfig-r003-20230329   gcc  
sparc64              randconfig-r031-20230329   gcc  
sparc64              randconfig-r032-20230329   gcc  
sparc64              randconfig-r034-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230329   gcc  
xtensa       buildonly-randconfig-r004-20230329   gcc  
xtensa               randconfig-r024-20230329   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  
xtensa               randconfig-r033-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
