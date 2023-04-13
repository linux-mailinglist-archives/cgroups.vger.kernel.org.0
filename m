Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5D6E0791
	for <lists+cgroups@lfdr.de>; Thu, 13 Apr 2023 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMHSz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Apr 2023 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMHSy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Apr 2023 03:18:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602959E6
        for <cgroups@vger.kernel.org>; Thu, 13 Apr 2023 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681370333; x=1712906333;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NDEujnZQpenuL81XfbXK8el7oFe4TTEP4/sD+/MeZqQ=;
  b=mgMbWJBr6b2hvcyesCNPZLSvGm98FY8yRvFh84liONanWth3j6pnmNEe
   9AoYcBFBUFpqQZTokuLQemrXyTUfyhTfo7dYTX5Scw5sA/wVyRKgRg8nP
   Th+oz8oDIzLW98G5SD8t2Jw+l8iPnmeYTRwey4EYhtFja8eKq81icgY9R
   FFeoifAhqaHQ+0VsYdkInjTOr6tDkQcEpxQySma7pxW0gnXiwj3xoKHDL
   iPxVlR6/f6N6LT9PocXS/HI1bwM+L6VtuQkG9gmaPItdEARBxVo93QRNO
   YpEcghNSHI2YW+5HnvIpgCxcwfhGM+0+fX2SteotZLyOjjOtIdUtUxAOO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="345900833"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345900833"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682845180"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682845180"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2023 00:18:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmrE7-000YTN-1P;
        Thu, 13 Apr 2023 07:18:39 +0000
Date:   Thu, 13 Apr 2023 15:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.3-fixes] BUILD SUCCESS
 7e27cb6ad4d85fc8bac2a2a896da62ef66b8598e
Message-ID: <6437aca1.FkqVDIaFGTrtii66%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.3-fixes
branch HEAD: 7e27cb6ad4d85fc8bac2a2a896da62ef66b8598e  cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for top_cpuset

elapsed time: 722m

configs tested: 141
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230410   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230409   gcc  
alpha                randconfig-r032-20230412   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230409   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230409   clang
arm          buildonly-randconfig-r005-20230409   clang
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r046-20230412   clang
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r023-20230410   gcc  
arm64                randconfig-r026-20230409   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230410   gcc  
csky                 randconfig-r021-20230409   gcc  
csky                 randconfig-r024-20230410   gcc  
csky                 randconfig-r033-20230409   gcc  
hexagon              randconfig-r015-20230409   clang
hexagon              randconfig-r035-20230412   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r045-20230412   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
ia64                 randconfig-r031-20230410   gcc  
ia64                 randconfig-r033-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230410   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r013-20230410   gcc  
loongarch            randconfig-r014-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
m68k                 randconfig-r031-20230409   gcc  
m68k                 randconfig-r032-20230410   gcc  
m68k                 randconfig-r036-20230409   gcc  
microblaze   buildonly-randconfig-r002-20230410   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r016-20230409   gcc  
microblaze           randconfig-r023-20230410   gcc  
microblaze           randconfig-r036-20230412   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                           mtx1_defconfig   clang
nios2        buildonly-randconfig-r004-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230412   gcc  
nios2                randconfig-r035-20230410   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r024-20230410   gcc  
parisc       buildonly-randconfig-r001-20230410   gcc  
parisc       buildonly-randconfig-r003-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r034-20230412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r021-20230410   gcc  
powerpc              randconfig-r025-20230409   gcc  
powerpc              randconfig-r026-20230410   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230410   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230409   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230410   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r023-20230409   gcc  
sh                   randconfig-r032-20230409   gcc  
sh                   randconfig-r034-20230410   gcc  
sparc        buildonly-randconfig-r001-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230409   gcc  
sparc64              randconfig-r006-20230409   gcc  
sparc64              randconfig-r022-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64               randconfig-r022-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230409   gcc  
xtensa               randconfig-r031-20230412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
