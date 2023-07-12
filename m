Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641675097A
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGLNUA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGLNT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 09:19:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224FE65
        for <cgroups@vger.kernel.org>; Wed, 12 Jul 2023 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689167998; x=1720703998;
  h=date:from:to:cc:subject:message-id;
  bh=vNt8OHLtOfBKfmsAo3z/otbcCbBXr87NpxvWdxkI0Tg=;
  b=iFcFda/LoW+8ZqJS471x4zJR4gYoTB16jqaqm5l+tD3B9p47GUCt8eGv
   Spz+hx4u+BCbRULmrH7sT4jJ9byibfT04+e12iZAUC2zyN92JwrktP2ya
   K09zYtHHvtE3HHmODeLpSO2ngw/B1XvAfY9QRYFue0FxCTc1bqBZHfbvJ
   SMQ4CjhqrwRGHaL45UlZz9R6R1hsF2CPFkfMZNbsgUbN7Ao7QgIX+IaJv
   eVjx06tDlSBgutVIucjraXFGxj+d0wH5xUxpJYdc+fG2VVN+EVFIPc2xz
   c7dV4TKWBNvb+4M1QQaBEUykNTym5XWzpjYmiRHQh8YonxK9R4S2653pI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344486142"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="344486142"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 06:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845656969"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="845656969"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2023 06:19:56 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJZl5-0005iN-0t;
        Wed, 12 Jul 2023 13:19:55 +0000
Date:   Wed, 12 Jul 2023 21:19:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 d1d4ff5d11a5887a9c4cfc00294bc68ba03e7c16
Message-ID: <202307122149.6CRM7iE7-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: d1d4ff5d11a5887a9c4cfc00294bc68ba03e7c16  cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED

elapsed time: 724m

configs tested: 137
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230712   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230712   gcc  
arc                  randconfig-r014-20230712   gcc  
arc                  randconfig-r034-20230712   gcc  
arc                  randconfig-r043-20230712   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230712   clang
arm                  randconfig-r005-20230712   clang
arm                  randconfig-r046-20230712   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230712   gcc  
arm64                randconfig-r005-20230712   gcc  
arm64                randconfig-r015-20230712   clang
arm64                randconfig-r034-20230712   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r036-20230712   gcc  
hexagon              randconfig-r013-20230712   clang
hexagon              randconfig-r015-20230712   clang
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r006-20230712   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i016-20230712   clang
i386                 randconfig-r024-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230712   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r031-20230712   gcc  
m68k                 randconfig-r035-20230712   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 randconfig-r032-20230712   clang
mips                 randconfig-r033-20230712   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230712   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r002-20230712   gcc  
openrisc             randconfig-r006-20230712   gcc  
openrisc             randconfig-r022-20230712   gcc  
openrisc             randconfig-r023-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc              randconfig-r004-20230712   gcc  
powerpc              randconfig-r012-20230712   clang
powerpc                     tqm8541_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230712   clang
riscv                randconfig-r026-20230712   clang
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r011-20230712   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230712   gcc  
sparc64              randconfig-r023-20230712   gcc  
sparc64              randconfig-r026-20230712   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r021-20230712   gcc  
um                   randconfig-r025-20230712   gcc  
um                   randconfig-r032-20230712   clang
um                   randconfig-r035-20230712   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230712   gcc  
x86_64               randconfig-r006-20230712   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230712   gcc  
xtensa               randconfig-r016-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
