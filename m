Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7A6E078E
	for <lists+cgroups@lfdr.de>; Thu, 13 Apr 2023 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMHRn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Apr 2023 03:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDMHRm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Apr 2023 03:17:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9337DA5
        for <cgroups@vger.kernel.org>; Thu, 13 Apr 2023 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681370261; x=1712906261;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=psFmwSLPVI7dPRE+/KXYzR41EA0ppN9Bg2WjyOZGt1w=;
  b=VkUKMrZlNfHdC7RZC/g/czLRuk2flxHUikqR8hXYLFECvHjnNaZVxcWL
   rC7QGxLK8IQYDb4eq90w+8c0RYaIvRy8vkcCtipBJfZBF6/v3zzbWsRvE
   tjRdGm4Mwy4HJN/rF8mz7/vWjMJ6J0kcne+p/tz8xxU2xN1vzBvYB4sho
   Lcqb1tRm6iPNdZ65cQgK+lu66XfVZRdYLarIgIV4L3Tro/T5V+ZoqrqSN
   360BHEiGkM0RiimN890cWLcZVvRlJdl6bb/cQAVv4yYsE402X+eQerjA3
   wB56v8ZPIliJAOM62lRAVjfeOzRjLBZwrYp1PW8pwk3SoXXgQBkm1xRiY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406946704"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406946704"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833023369"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="833023369"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2023 00:17:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmrD9-000YSi-06;
        Thu, 13 Apr 2023 07:17:39 +0000
Date:   Thu, 13 Apr 2023 15:17:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 bad2750ad28b10ac9b5d4ab351efc157e49e6b00
Message-ID: <6437ac81.Fy102Hu67dTxoQ2w%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: bad2750ad28b10ac9b5d4ab351efc157e49e6b00  Merge branch 'for-6.3-fixes' into for-next

elapsed time: 721m

configs tested: 126
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230409   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230409   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230409   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r046-20230412   clang
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230409   clang
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r023-20230410   gcc  
arm64                randconfig-r026-20230409   gcc  
csky         buildonly-randconfig-r004-20230410   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230410   gcc  
csky                 randconfig-r021-20230409   gcc  
csky                 randconfig-r024-20230410   gcc  
hexagon      buildonly-randconfig-r006-20230409   clang
hexagon              randconfig-r015-20230409   clang
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
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230410   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r013-20230410   gcc  
loongarch            randconfig-r014-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230409   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r016-20230409   gcc  
microblaze           randconfig-r023-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                           mtx1_defconfig   clang
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r005-20230409   gcc  
openrisc     buildonly-randconfig-r006-20230410   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r024-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r021-20230410   gcc  
powerpc              randconfig-r025-20230409   gcc  
powerpc              randconfig-r026-20230410   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230409   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230410   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230410   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r023-20230409   gcc  
sparc        buildonly-randconfig-r002-20230410   gcc  
sparc        buildonly-randconfig-r005-20230410   gcc  
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
