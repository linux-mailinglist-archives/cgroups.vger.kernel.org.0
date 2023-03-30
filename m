Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AAD6CFCA2
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjC3HXl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC3HXk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:23:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966035A2
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680161019; x=1711697019;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JeOnVJIFdSeUD3sDSNJpbac8JC/yWe8ezu/XalkayH8=;
  b=hW7gvLTqpIH4YsbSrNqAblSvm4MPLDZJtlo0I/s8qYMqomcgEY8zeK0j
   pjlUO+DOLiyP9OfwQnWjCXR9jp3MhtyRRuSEoBtkdS0KxRM1/EmGNU1xW
   cDkjxCDWC8/5qZWU+GvfB6JCUQNrj+URVCXCv5yRz706H3WmowLy6A6eD
   EqZxDYg2HsqiA0PxDhT7fbU7vo6hmQsLjhQ8V8+nDF6wiJ4Zi0PV+k7gh
   MnJt3DlH05KThfrD5jFP6zo0XbkKxyiZsqGWykzjq17lnzmGr4szbe9Ww
   UFIcn0S6/SAmCgbZOvqAKwWmDxmuWZe2KFx+ovd9laCyUN75pOFM4LKpp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329585082"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329585082"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858802272"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="858802272"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 00:23:37 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phmdE-000KVo-2X;
        Thu, 30 Mar 2023 07:23:36 +0000
Date:   Thu, 30 Mar 2023 15:23:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.4] BUILD SUCCESS
 1bf33285d98536da6b015627341e4f789fee067e
Message-ID: <642538f4.C9gtvGJ/Fc/WCkqC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.4
branch HEAD: 1bf33285d98536da6b015627341e4f789fee067e  cgroup/cpuset: Minor updates to test_cpuset_prs.sh

elapsed time: 728m

configs tested: 206
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230329   gcc  
alpha                randconfig-r005-20230329   gcc  
alpha                randconfig-r015-20230329   gcc  
alpha                randconfig-r023-20230329   gcc  
alpha                randconfig-r036-20230329   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230329   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                  randconfig-r023-20230329   gcc  
arm                  randconfig-r046-20230329   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r003-20230329   gcc  
arm64                randconfig-r006-20230329   gcc  
arm64                randconfig-r014-20230329   clang
arm64                randconfig-r025-20230329   clang
csky         buildonly-randconfig-r006-20230329   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230329   gcc  
csky                 randconfig-r004-20230329   gcc  
csky                 randconfig-r011-20230329   gcc  
csky                 randconfig-r026-20230330   gcc  
csky                 randconfig-r031-20230329   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon              randconfig-r016-20230329   clang
hexagon              randconfig-r034-20230329   clang
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
ia64         buildonly-randconfig-r001-20230329   gcc  
ia64         buildonly-randconfig-r003-20230329   gcc  
ia64         buildonly-randconfig-r005-20230329   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230329   gcc  
ia64                 randconfig-r005-20230329   gcc  
ia64                 randconfig-r006-20230329   gcc  
ia64                 randconfig-r012-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r026-20230329   gcc  
ia64                 randconfig-r033-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
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
m68k         buildonly-randconfig-r002-20230329   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230329   gcc  
m68k                 randconfig-r014-20230329   gcc  
m68k                 randconfig-r022-20230329   gcc  
m68k                 randconfig-r035-20230329   gcc  
microblaze   buildonly-randconfig-r001-20230329   gcc  
microblaze           randconfig-r012-20230329   gcc  
microblaze           randconfig-r016-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
microblaze           randconfig-r032-20230329   gcc  
microblaze           randconfig-r035-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230329   clang
mips                 randconfig-r002-20230329   clang
mips                 randconfig-r012-20230329   gcc  
mips                 randconfig-r021-20230329   gcc  
mips                 randconfig-r021-20230330   gcc  
mips                 randconfig-r025-20230329   gcc  
nios2        buildonly-randconfig-r001-20230329   gcc  
nios2        buildonly-randconfig-r003-20230329   gcc  
nios2        buildonly-randconfig-r004-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230329   gcc  
nios2                randconfig-r025-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
openrisc     buildonly-randconfig-r002-20230329   gcc  
openrisc     buildonly-randconfig-r004-20230329   gcc  
openrisc             randconfig-r004-20230329   gcc  
openrisc             randconfig-r006-20230329   gcc  
openrisc             randconfig-r015-20230329   gcc  
openrisc             randconfig-r021-20230329   gcc  
openrisc             randconfig-r026-20230329   gcc  
openrisc             randconfig-r036-20230329   gcc  
parisc       buildonly-randconfig-r005-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230329   gcc  
parisc               randconfig-r011-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r022-20230330   gcc  
parisc               randconfig-r023-20230330   gcc  
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
powerpc              randconfig-r032-20230329   gcc  
powerpc              randconfig-r034-20230329   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230329   clang
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
s390                 randconfig-r022-20230329   clang
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r035-20230329   gcc  
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230329   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r005-20230329   gcc  
sh                   randconfig-r015-20230329   gcc  
sh                   randconfig-r022-20230329   gcc  
sh                   randconfig-r023-20230329   gcc  
sparc        buildonly-randconfig-r003-20230329   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230329   gcc  
sparc                randconfig-r013-20230329   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc                randconfig-r024-20230330   gcc  
sparc                randconfig-r031-20230329   gcc  
sparc64      buildonly-randconfig-r005-20230329   gcc  
sparc64      buildonly-randconfig-r006-20230329   gcc  
sparc64              randconfig-r003-20230329   gcc  
sparc64              randconfig-r024-20230329   gcc  
sparc64              randconfig-r031-20230329   gcc  
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
xtensa       buildonly-randconfig-r004-20230329   gcc  
xtensa               randconfig-r024-20230329   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  
xtensa               randconfig-r032-20230329   gcc  
xtensa               randconfig-r033-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
