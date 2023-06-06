Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C243D724321
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjFFMxr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Jun 2023 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFFMxr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Jun 2023 08:53:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043F10E0
        for <cgroups@vger.kernel.org>; Tue,  6 Jun 2023 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686056007; x=1717592007;
  h=date:from:to:cc:subject:message-id;
  bh=CF3/yFoewQI//AcbLzXWs+UUHkXC8hHZ5dZgsCfPf5Q=;
  b=XvLv0C7rkEwV2bLuGJCJ3L/IBGTw0Gd9VgO7qxz+lGVgRVZ21N6qx25h
   w8Cb1Iav7W8YuPPQABgkg2Nsd9lRhiyuYl9IA0FX/EaxaQoq/cSxNTwHI
   puxsR5hns+u+Y7wTk6Ay769IFym1O33N3L6nLxOjr9nXi5iDDWmiJqUFK
   Vhtt7eecxv5ifnIRLlCF+vRRdgmrnN3resGvzj+sRwSJA2KGTWZWq1/hP
   ad4RqsU/03Bx7GWv+/dmfHn9Rjb4oSM63fEvESwlm0w79/b3btQq1bdB2
   s4zs3JreP4FrwNp6AWHbKQImdSHcXvEJir88qWIRI0xv3KvWE9zJfiMMn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="341299875"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="341299875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="709066199"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="709066199"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2023 05:53:24 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6WBf-0005Fg-2K;
        Tue, 06 Jun 2023 12:53:23 +0000
Date:   Tue, 06 Jun 2023 20:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 f32b14ba70a963d7199f0dad9fa48514e1246a07
Message-ID: <20230606125255.dBJ0Z%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: f32b14ba70a963d7199f0dad9fa48514e1246a07  Merge branch 'for-6.4-fixes' into for-next

elapsed time: 725m

configs tested: 183
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230605   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230606   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230606   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230605   clang
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230605   gcc  
arm                  randconfig-r036-20230605   gcc  
arm                  randconfig-r046-20230606   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230606   gcc  
arm64                randconfig-r025-20230606   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230605   gcc  
csky                 randconfig-r015-20230605   gcc  
csky                 randconfig-r021-20230606   gcc  
csky                 randconfig-r022-20230606   gcc  
csky                 randconfig-r032-20230605   gcc  
csky                 randconfig-r033-20230606   gcc  
csky                 randconfig-r035-20230606   gcc  
hexagon      buildonly-randconfig-r003-20230606   clang
hexagon              randconfig-r041-20230606   clang
hexagon              randconfig-r045-20230606   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230606   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230605   clang
i386                 randconfig-i001-20230606   gcc  
i386                 randconfig-i002-20230605   clang
i386                 randconfig-i002-20230606   gcc  
i386                 randconfig-i003-20230605   clang
i386                 randconfig-i003-20230606   gcc  
i386                 randconfig-i004-20230605   clang
i386                 randconfig-i004-20230606   gcc  
i386                 randconfig-i005-20230605   clang
i386                 randconfig-i005-20230606   gcc  
i386                 randconfig-i006-20230605   clang
i386                 randconfig-i006-20230606   gcc  
i386                 randconfig-i011-20230605   gcc  
i386                 randconfig-i011-20230606   clang
i386                 randconfig-i012-20230605   gcc  
i386                 randconfig-i012-20230606   clang
i386                 randconfig-i013-20230605   gcc  
i386                 randconfig-i013-20230606   clang
i386                 randconfig-i014-20230605   gcc  
i386                 randconfig-i014-20230606   clang
i386                 randconfig-i015-20230605   gcc  
i386                 randconfig-i015-20230606   clang
i386                 randconfig-i016-20230605   gcc  
i386                 randconfig-i016-20230606   clang
i386                 randconfig-i051-20230605   clang
i386                 randconfig-i051-20230606   gcc  
i386                 randconfig-i052-20230605   clang
i386                 randconfig-i052-20230606   gcc  
i386                 randconfig-i053-20230605   clang
i386                 randconfig-i053-20230606   gcc  
i386                 randconfig-i054-20230605   clang
i386                 randconfig-i054-20230606   gcc  
i386                 randconfig-i055-20230605   clang
i386                 randconfig-i055-20230606   gcc  
i386                 randconfig-i056-20230605   clang
i386                 randconfig-i056-20230606   gcc  
i386                 randconfig-i061-20230605   clang
i386                 randconfig-i061-20230606   gcc  
i386                 randconfig-i062-20230605   clang
i386                 randconfig-i062-20230606   gcc  
i386                 randconfig-i063-20230605   clang
i386                 randconfig-i063-20230606   gcc  
i386                 randconfig-i064-20230605   clang
i386                 randconfig-i064-20230606   gcc  
i386                 randconfig-i065-20230605   clang
i386                 randconfig-i065-20230606   gcc  
i386                 randconfig-i066-20230605   clang
i386                 randconfig-i066-20230606   gcc  
i386                 randconfig-r002-20230605   clang
i386                 randconfig-r006-20230606   gcc  
i386                 randconfig-r036-20230606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230605   gcc  
loongarch            randconfig-r011-20230605   gcc  
loongarch            randconfig-r025-20230605   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230606   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230606   gcc  
m68k                 randconfig-r006-20230605   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230606   clang
mips                 randconfig-r025-20230606   gcc  
nios2        buildonly-randconfig-r003-20230606   gcc  
nios2        buildonly-randconfig-r004-20230606   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230605   gcc  
nios2                randconfig-r021-20230605   gcc  
nios2                randconfig-r024-20230605   gcc  
nios2                randconfig-r034-20230606   gcc  
openrisc     buildonly-randconfig-r001-20230605   gcc  
openrisc     buildonly-randconfig-r002-20230606   gcc  
openrisc             randconfig-r032-20230605   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230605   gcc  
parisc               randconfig-r022-20230605   gcc  
parisc               randconfig-r031-20230605   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230605   clang
powerpc              randconfig-r002-20230605   clang
powerpc              randconfig-r012-20230606   clang
powerpc              randconfig-r021-20230606   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230606   clang
riscv        buildonly-randconfig-r002-20230606   clang
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230606   gcc  
riscv                randconfig-r032-20230606   gcc  
riscv                randconfig-r042-20230606   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230606   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230606   gcc  
s390                 randconfig-r035-20230605   clang
s390                 randconfig-r044-20230606   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230605   gcc  
sh                   randconfig-r006-20230605   gcc  
sh                   randconfig-r026-20230605   gcc  
sh                   randconfig-r034-20230605   gcc  
sparc        buildonly-randconfig-r002-20230605   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230605   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230606   gcc  
x86_64               randconfig-a002-20230606   gcc  
x86_64               randconfig-a003-20230606   gcc  
x86_64               randconfig-a004-20230606   gcc  
x86_64               randconfig-a005-20230606   gcc  
x86_64               randconfig-a006-20230606   gcc  
x86_64               randconfig-a011-20230606   clang
x86_64               randconfig-a012-20230606   clang
x86_64               randconfig-a013-20230606   clang
x86_64               randconfig-a014-20230606   clang
x86_64               randconfig-a015-20230606   clang
x86_64               randconfig-a016-20230606   clang
x86_64               randconfig-r003-20230606   gcc  
x86_64               randconfig-r013-20230605   gcc  
x86_64               randconfig-r031-20230605   clang
x86_64               randconfig-x051-20230605   gcc  
x86_64               randconfig-x051-20230606   clang
x86_64               randconfig-x052-20230605   gcc  
x86_64               randconfig-x052-20230606   clang
x86_64               randconfig-x053-20230605   gcc  
x86_64               randconfig-x053-20230606   clang
x86_64               randconfig-x054-20230606   clang
x86_64               randconfig-x055-20230606   clang
x86_64               randconfig-x056-20230606   clang
x86_64               randconfig-x061-20230606   clang
x86_64               randconfig-x062-20230606   clang
x86_64               randconfig-x063-20230606   clang
x86_64               randconfig-x064-20230606   clang
x86_64               randconfig-x065-20230606   clang
x86_64               randconfig-x066-20230606   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230605   gcc  
xtensa               randconfig-r023-20230605   gcc  
xtensa               randconfig-r024-20230606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
