Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B752710B8E
	for <lists+cgroups@lfdr.de>; Thu, 25 May 2023 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbjEYL5B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 May 2023 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbjEYL4r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 May 2023 07:56:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A709C
        for <cgroups@vger.kernel.org>; Thu, 25 May 2023 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685015805; x=1716551805;
  h=date:from:to:cc:subject:message-id;
  bh=+Vxdnx5rNbSPNRVvKqdJGYekurYteL4GgkOHEqtwvXI=;
  b=fdvXj9N9VpvqbHmJDYNOJ0qDAScw5K6LWnBST7SGpmiRZRd0fxDsTfNe
   K576h0xnYgdxjpGGeQX6xcE/TTSm1aJvvPcku5pXNqdqvfO0mWFrhV2AU
   TbxRRiT/oo1A8vMhj4xE7Rmg9aoCDg5IultL85ilG22kzKRFNSXiKd6cZ
   Dia7QNxXQvxxK0FbxkeVVdYHxskkyZon8otZnjDFHY9X50k/2NUxtuemI
   Or58dykZrqLR6o6Q4tnL0w8XClTnSZVD6Z6jAAvqELAfSBG/hbi3x89j2
   DkhGIXmk2Yr9zbgThIKJ51DkyHu2V47bH3Mu3mElzjvdoYBzYiAeHSjYV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="343337335"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="343337335"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="794617886"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="794617886"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 May 2023 04:56:44 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q29aF-000FiL-0w;
        Thu, 25 May 2023 11:56:43 +0000
Date:   Thu, 25 May 2023 19:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.5] BUILD SUCCESS
 659db0789c2e66c5d6a52d57008e3a7401a3ffff
Message-ID: <20230525115554.3LIiJ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.5
branch HEAD: 659db0789c2e66c5d6a52d57008e3a7401a3ffff  cgroup: Update out-of-date comment in cgroup_migrate()

elapsed time: 742m

configs tested: 178
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230524   gcc  
alpha                randconfig-r016-20230524   gcc  
alpha                randconfig-r034-20230524   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230524   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230525   gcc  
arc                  randconfig-r012-20230524   gcc  
arc                  randconfig-r043-20230524   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230524   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230524   clang
arm                  randconfig-r046-20230524   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230524   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230524   clang
arm64                randconfig-r032-20230524   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230524   gcc  
csky                 randconfig-r033-20230524   gcc  
csky                 randconfig-r035-20230524   gcc  
hexagon              randconfig-r003-20230525   clang
hexagon              randconfig-r004-20230525   clang
hexagon              randconfig-r026-20230524   clang
hexagon              randconfig-r041-20230524   clang
hexagon              randconfig-r045-20230524   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230524   gcc  
i386                 randconfig-i002-20230524   gcc  
i386                 randconfig-i003-20230524   gcc  
i386                 randconfig-i004-20230524   gcc  
i386                 randconfig-i005-20230524   gcc  
i386                 randconfig-i006-20230524   gcc  
i386                 randconfig-i011-20230524   clang
i386                 randconfig-i012-20230524   clang
i386                 randconfig-i013-20230524   clang
i386                 randconfig-i014-20230524   clang
i386                 randconfig-i015-20230524   clang
i386                 randconfig-i016-20230524   clang
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230524   gcc  
i386                 randconfig-i062-20230524   gcc  
i386                 randconfig-i063-20230524   gcc  
i386                 randconfig-i064-20230524   gcc  
i386                 randconfig-i065-20230524   gcc  
i386                 randconfig-i066-20230524   gcc  
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i073-20230524   clang
i386                 randconfig-i074-20230524   clang
i386                 randconfig-i075-20230524   clang
i386                 randconfig-i076-20230524   clang
i386                 randconfig-i081-20230524   clang
i386                 randconfig-i082-20230524   clang
i386                 randconfig-i083-20230524   clang
i386                 randconfig-i084-20230524   clang
i386                 randconfig-i085-20230524   clang
i386                 randconfig-i086-20230524   clang
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i094-20230524   gcc  
i386                 randconfig-i095-20230524   gcc  
i386                 randconfig-i096-20230524   gcc  
i386                 randconfig-r011-20230524   clang
i386                 randconfig-r015-20230524   clang
ia64         buildonly-randconfig-r005-20230524   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r035-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230524   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230524   gcc  
loongarch            randconfig-r036-20230524   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230524   gcc  
m68k                 randconfig-r032-20230524   gcc  
microblaze           randconfig-r006-20230525   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r014-20230524   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r034-20230524   gcc  
parisc                           alldefconfig   gcc  
parisc       buildonly-randconfig-r004-20230524   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r031-20230524   gcc  
parisc               randconfig-r033-20230524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230524   clang
powerpc              randconfig-r024-20230524   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230524   gcc  
riscv                randconfig-r042-20230524   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230524   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230524   gcc  
sparc        buildonly-randconfig-r001-20230524   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r002-20230525   gcc  
sparc64              randconfig-r013-20230524   gcc  
sparc64              randconfig-r023-20230524   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230524   gcc  
x86_64               randconfig-a002-20230524   gcc  
x86_64               randconfig-a003-20230524   gcc  
x86_64               randconfig-a004-20230524   gcc  
x86_64               randconfig-a005-20230524   gcc  
x86_64               randconfig-a006-20230524   gcc  
x86_64               randconfig-a011-20230524   clang
x86_64               randconfig-a012-20230524   clang
x86_64               randconfig-a013-20230524   clang
x86_64               randconfig-a014-20230524   clang
x86_64               randconfig-a015-20230524   clang
x86_64               randconfig-a016-20230524   clang
x86_64               randconfig-k001-20230524   clang
x86_64               randconfig-x051-20230524   clang
x86_64               randconfig-x052-20230524   clang
x86_64               randconfig-x053-20230524   clang
x86_64               randconfig-x054-20230524   clang
x86_64               randconfig-x055-20230524   clang
x86_64               randconfig-x056-20230524   clang
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x071-20230524   gcc  
x86_64               randconfig-x072-20230524   gcc  
x86_64               randconfig-x073-20230524   gcc  
x86_64               randconfig-x074-20230524   gcc  
x86_64               randconfig-x075-20230524   gcc  
x86_64               randconfig-x076-20230524   gcc  
x86_64               randconfig-x081-20230524   gcc  
x86_64               randconfig-x082-20230524   gcc  
x86_64               randconfig-x083-20230524   gcc  
x86_64               randconfig-x084-20230524   gcc  
x86_64               randconfig-x085-20230524   gcc  
x86_64               randconfig-x086-20230524   gcc  
x86_64               randconfig-x091-20230524   clang
x86_64               randconfig-x092-20230524   clang
x86_64               randconfig-x093-20230524   clang
x86_64               randconfig-x094-20230524   clang
x86_64               randconfig-x095-20230524   clang
x86_64               randconfig-x096-20230524   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230524   gcc  
xtensa               randconfig-r025-20230524   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
