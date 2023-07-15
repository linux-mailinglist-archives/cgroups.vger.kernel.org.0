Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E833754744
	for <lists+cgroups@lfdr.de>; Sat, 15 Jul 2023 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGOHn5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Jul 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHn4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 15 Jul 2023 03:43:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563AB2D66
        for <cgroups@vger.kernel.org>; Sat, 15 Jul 2023 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689407035; x=1720943035;
  h=date:from:to:cc:subject:message-id;
  bh=ycUr7gaSc1XLC5Erd4gqzznreFmdwj6QbJmjcC2J3M8=;
  b=WG7Ih5NmD1ueowoLmD58RRMhxCe01++CQGjPGt+tGjnyxqT3LW1PDarc
   Onudfj+0oqoSNWGb0t18itWUfCw+VioSDkSly2M9tyAbpoAKNQx+GqFWZ
   Sr9/lQCQ3oYCGOXcGavw2HJMJ4IyzuogxzwWiz5k0Ljw/8IZ49egGtBzF
   zJx5BCEgYop0qUEXDHk4VufWRyxmtzVoX5O+u9Ornv6bx22Hj52mDO6ef
   zIAX6WAJQc8JWiivfu+vpOGG0/F+iMJi+l6APJ119vB8K+AWxOsbqSQMb
   7MgKKA6F2N7SkHNNez+PGl3jYwpZU8hBaq9g8fsxGbov8UnJ2DN1ub2js
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355578386"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="355578386"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 00:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="725954131"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="725954131"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2023 00:43:53 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKZwW-00080l-36;
        Sat, 15 Jul 2023 07:43:52 +0000
Date:   Sat, 15 Jul 2023 15:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 ceddae22cd08ba9f52a995cfb573fee89fa4afc4
Message-ID: <202307151550.cXFf1Dgm-lkp@intel.com>
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
branch HEAD: ceddae22cd08ba9f52a995cfb573fee89fa4afc4  cgroup: remove obsolete comment above struct cgroupstats

elapsed time: 724m

configs tested: 154
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230714   gcc  
alpha                randconfig-r032-20230714   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r006-20230714   gcc  
arc                  randconfig-r035-20230714   gcc  
arc                  randconfig-r043-20230714   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                  randconfig-r015-20230714   gcc  
arm                  randconfig-r046-20230714   gcc  
arm                          sp7021_defconfig   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230714   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230714   gcc  
csky                 randconfig-r013-20230714   gcc  
csky                 randconfig-r021-20230714   gcc  
hexagon              randconfig-r016-20230714   clang
hexagon              randconfig-r026-20230715   clang
hexagon              randconfig-r033-20230714   clang
hexagon              randconfig-r035-20230714   clang
hexagon              randconfig-r041-20230714   clang
hexagon              randconfig-r045-20230714   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230714   gcc  
i386         buildonly-randconfig-r005-20230714   gcc  
i386         buildonly-randconfig-r006-20230714   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230714   gcc  
i386                 randconfig-i002-20230714   gcc  
i386                 randconfig-i003-20230714   gcc  
i386                 randconfig-i004-20230714   gcc  
i386                 randconfig-i005-20230714   gcc  
i386                 randconfig-i006-20230714   gcc  
i386                 randconfig-i011-20230714   clang
i386                 randconfig-i012-20230714   clang
i386                 randconfig-i013-20230714   clang
i386                 randconfig-i014-20230714   clang
i386                 randconfig-i015-20230714   clang
i386                 randconfig-i016-20230714   clang
i386                 randconfig-r016-20230714   clang
i386                 randconfig-r031-20230714   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230714   gcc  
loongarch            randconfig-r025-20230715   gcc  
loongarch            randconfig-r033-20230714   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230714   gcc  
nios2                randconfig-r011-20230714   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r001-20230714   gcc  
openrisc             randconfig-r005-20230714   gcc  
openrisc             randconfig-r014-20230714   gcc  
openrisc             randconfig-r034-20230714   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230714   gcc  
parisc               randconfig-r025-20230714   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                  mpc885_ads_defconfig   clang
powerpc              randconfig-r011-20230714   clang
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230714   gcc  
riscv                randconfig-r042-20230714   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230714   clang
s390                 randconfig-r024-20230714   clang
s390                 randconfig-r034-20230714   gcc  
s390                 randconfig-r044-20230714   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230714   gcc  
sh                   randconfig-r022-20230714   gcc  
sh                   randconfig-r026-20230714   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230714   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r036-20230714   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230714   gcc  
x86_64       buildonly-randconfig-r002-20230714   gcc  
x86_64       buildonly-randconfig-r003-20230714   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r021-20230715   gcc  
x86_64               randconfig-r036-20230714   gcc  
x86_64               randconfig-x001-20230714   clang
x86_64               randconfig-x002-20230714   clang
x86_64               randconfig-x003-20230714   clang
x86_64               randconfig-x004-20230714   clang
x86_64               randconfig-x005-20230714   clang
x86_64               randconfig-x006-20230714   clang
x86_64               randconfig-x011-20230714   gcc  
x86_64               randconfig-x012-20230714   gcc  
x86_64               randconfig-x013-20230714   gcc  
x86_64               randconfig-x014-20230714   gcc  
x86_64               randconfig-x015-20230714   gcc  
x86_64               randconfig-x016-20230714   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230715   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
