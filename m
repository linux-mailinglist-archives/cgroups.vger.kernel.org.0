Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F975DB5A
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGVJ2T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 22 Jul 2023 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGVJ2S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 22 Jul 2023 05:28:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF02D46
        for <cgroups@vger.kernel.org>; Sat, 22 Jul 2023 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690018097; x=1721554097;
  h=date:from:to:cc:subject:message-id;
  bh=jUvJFyjqxIXL1l2xtdYEqopTLc3bjd1qeXeM4VuTEC8=;
  b=U7g4WafIaK3m71dbH3XlB4vikAFiDQ00H/Q/B60Mo3usAegGhvNjkJDi
   3WGUDLlkIvXlsFQyoe01Z6LaG0w+WADzCaOtcnx5eOjEhrv23tVkAafzI
   pomm4M9YCa0+SaLNrrJyq3Xzwuxyadx2EhIF+mu0jC/IUHWs5kGNnYXPJ
   exjtLt+Q+orur/qBfEDqWjhPrTnTZg8/hHLyu0R2W02HnOEkXgGDJpusD
   0js6ZN3O63n/4xblECPu7KL8D9982tUghoK/uqk5epZcFSAuHxWyIgrQ7
   cG+GFoy3VpIFxiSPwo4N0y/dGS4lf8EIUQZ5CwxVIOrgC+laaoQrK1xjC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369847751"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="369847751"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 02:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="815286851"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815286851"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2023 02:28:16 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN8u3-0008D2-1D;
        Sat, 22 Jul 2023 09:27:58 +0000
Date:   Sat, 22 Jul 2023 17:26:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a3fdeeb3f1c1fad3b7b07aa96a7e422fde3c2c15
Message-ID: <202307221719.nAJ25wyg-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a3fdeeb3f1c1fad3b7b07aa96a7e422fde3c2c15  cgroup: fix obsolete comment above cgroup_create()

elapsed time: 727m

configs tested: 125
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230720   gcc  
alpha                randconfig-r014-20230720   gcc  
alpha                randconfig-r021-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230720   clang
arm                  randconfig-r033-20230720   clang
arm                  randconfig-r046-20230720   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230720   gcc  
arm64                randconfig-r022-20230720   clang
arm64                randconfig-r032-20230720   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230720   gcc  
csky                 randconfig-r005-20230720   gcc  
csky                 randconfig-r012-20230720   gcc  
csky                 randconfig-r016-20230720   gcc  
hexagon              randconfig-r024-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
i386                 randconfig-r002-20230720   gcc  
i386                 randconfig-r021-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230720   gcc  
loongarch            randconfig-r023-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230720   gcc  
m68k                 randconfig-r014-20230720   gcc  
m68k                 randconfig-r025-20230720   gcc  
microblaze           randconfig-r011-20230720   gcc  
microblaze           randconfig-r024-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230720   clang
mips                 randconfig-r012-20230720   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230720   gcc  
openrisc             randconfig-r022-20230720   gcc  
openrisc             randconfig-r025-20230720   gcc  
openrisc             randconfig-r036-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230720   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230720   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230720   gcc  
sh                   randconfig-r011-20230720   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230720   gcc  
sparc                randconfig-r034-20230720   gcc  
sparc64              randconfig-r013-20230720   gcc  
sparc64              randconfig-r036-20230720   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230720   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230720   clang
x86_64               randconfig-r033-20230720   gcc  
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
