Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF006FC5CC
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjEIMGv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjEIMGu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 08:06:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786510F3
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683634009; x=1715170009;
  h=date:from:to:cc:subject:message-id;
  bh=XbYGJAu1p+Y1z9nbuMQD5fz8jpS+b+N8stWFwx8d1e8=;
  b=GQMsD0Ni2t5l+6hxtdn9QDjmZvgI4ULqPnIQnXnJlR1+znG/w1WZQSuO
   vq+3CshBC35YqZLsXtE3/24+pIYc11OYaMqwWhtyjTJ2yAAe0zqUZruJO
   bV7XRB7V1fm+H98fyM8aSWX8s09cxvgGGudm82bldtS4HS2GJR+y0IxRc
   TJAtdOymR+h75yATvFn9ixjaOESZ9xqBvjwLXKhz91RPZ0DpyhhXQCVSY
   2G7Wq+ZVQ6iYjyNw9U7Zjvm9/weU198hYL8PgPskT0uUDh8hqNC1nMCxZ
   EiKNnzExVVDse4REuFHg2DE7P5TOy3d4AlTOG34bLBgc8eAZKO26pJQZX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339131486"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="339131486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="1028794713"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="1028794713"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2023 05:06:47 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwM7C-00028x-2o;
        Tue, 09 May 2023 12:06:46 +0000
Date:   Tue, 09 May 2023 20:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 2ef269ef1ac006acf974793d975539244d77b28f
Message-ID: <20230509120631.uuDD2%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 2ef269ef1ac006acf974793d975539244d77b28f  cgroup/cpuset: Free DL BW in case can_attach() fails

elapsed time: 734m

configs tested: 165
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230508   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230507   gcc  
alpha                randconfig-r023-20230507   gcc  
alpha                randconfig-r025-20230507   gcc  
alpha                randconfig-r026-20230507   gcc  
alpha                randconfig-r032-20230507   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230507   gcc  
arc          buildonly-randconfig-r003-20230508   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230507   gcc  
arm          buildonly-randconfig-r002-20230508   clang
arm          buildonly-randconfig-r003-20230507   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230507   clang
arm                  randconfig-r014-20230508   clang
arm                  randconfig-r026-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230507   gcc  
arm64        buildonly-randconfig-r006-20230507   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230507   clang
arm64                randconfig-r031-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230507   gcc  
csky                 randconfig-r014-20230508   gcc  
hexagon      buildonly-randconfig-r002-20230508   clang
hexagon      buildonly-randconfig-r006-20230508   clang
hexagon              randconfig-r006-20230507   clang
hexagon              randconfig-r011-20230508   clang
hexagon              randconfig-r023-20230507   clang
hexagon              randconfig-r034-20230507   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r002-20230508   clang
i386                 randconfig-r015-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230508   gcc  
ia64                 randconfig-r021-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230508   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230507   gcc  
loongarch            randconfig-r014-20230507   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230508   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230507   gcc  
m68k                 randconfig-r024-20230507   gcc  
microblaze   buildonly-randconfig-r002-20230507   gcc  
microblaze   buildonly-randconfig-r005-20230507   gcc  
microblaze           randconfig-r004-20230508   gcc  
microblaze           randconfig-r011-20230507   gcc  
microblaze           randconfig-r011-20230508   gcc  
microblaze           randconfig-r013-20230507   gcc  
microblaze           randconfig-r015-20230507   gcc  
microblaze           randconfig-r022-20230507   gcc  
microblaze           randconfig-r024-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230507   gcc  
mips                 randconfig-r026-20230507   gcc  
mips                 randconfig-r033-20230507   clang
mips                 randconfig-r034-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230507   gcc  
nios2                randconfig-r014-20230507   gcc  
nios2                randconfig-r021-20230507   gcc  
nios2                randconfig-r033-20230507   gcc  
nios2                randconfig-r036-20230507   gcc  
openrisc     buildonly-randconfig-r006-20230507   gcc  
openrisc             randconfig-r001-20230507   gcc  
openrisc             randconfig-r013-20230507   gcc  
openrisc             randconfig-r015-20230507   gcc  
openrisc             randconfig-r031-20230507   gcc  
openrisc             randconfig-r036-20230507   gcc  
parisc       buildonly-randconfig-r004-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230507   gcc  
powerpc              randconfig-r005-20230508   clang
powerpc              randconfig-r006-20230508   clang
powerpc              randconfig-r022-20230508   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230507   clang
riscv        buildonly-randconfig-r005-20230507   clang
riscv        buildonly-randconfig-r005-20230508   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230508   gcc  
riscv                randconfig-r025-20230508   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230508   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230508   clang
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230507   gcc  
sh           buildonly-randconfig-r005-20230508   gcc  
sh                   randconfig-r013-20230508   gcc  
sparc        buildonly-randconfig-r001-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230507   gcc  
sparc                randconfig-r035-20230507   gcc  
sparc64      buildonly-randconfig-r004-20230508   gcc  
sparc64              randconfig-r012-20230508   gcc  
sparc64              randconfig-r022-20230507   gcc  
sparc64              randconfig-r032-20230507   gcc  
sparc64              randconfig-r035-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230508   gcc  
xtensa               randconfig-r021-20230508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
