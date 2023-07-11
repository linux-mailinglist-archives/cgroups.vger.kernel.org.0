Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A554374EAD5
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGKJje (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 05:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGKJjV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 05:39:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E813910F9
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689068342; x=1720604342;
  h=date:from:to:cc:subject:message-id;
  bh=N1LdrD0T7R8hlsa1sWwu5bKiaBknxeYxY7mcVYyH/Nc=;
  b=nMjGwYQiDqHUP0HpKlTzwlBTxVKDU0RO8UCM6mI7ggqyxnpWUs8R2uvq
   I1ySHeNGZqBCMBOijzti61k6pOAnc8Av3ADmSGeMeALmrhLHAeoHfFfX7
   o+zrEgvEVKodjEOHOlRJ+bFf6TT9KR0dGHpN2V/jYwHw5+IACSeju2bPP
   pDLFEWcxQn+DFVU2ahRXnUGBjt6GQoTAWLb1YnyjsXKPFSY9Udtl31RRV
   Ss+JPn6wbap6LzHCQnqpMsm7EXP/1p5REGFPDvn8NPztSPbpMaQYZhle1
   ca9xj9mPoM9A3iDYcmzS+ZJggdrlALge8W8nBH20mpFOFf+uk63eAgX4n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="368072708"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368072708"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 02:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="715124824"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715124824"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 02:38:57 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJ9pg-0004g4-2O;
        Tue, 11 Jul 2023 09:38:56 +0000
Date:   Tue, 11 Jul 2023 17:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 3ae0b773211ed0231e7ee3e8d28ec4ab9bc5134b
Message-ID: <202307111749.89zcAkgJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 3ae0b773211ed0231e7ee3e8d28ec4ab9bc5134b  cgroup/cpuset: Allow suppression of sched domain rebuild in update_cpumasks_hier()

elapsed time: 720m

configs tested: 135
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230710   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230710   gcc  
arc                  randconfig-r043-20230710   gcc  
arc                  randconfig-r043-20230711   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230710   clang
arm                  randconfig-r025-20230710   gcc  
arm                  randconfig-r046-20230710   gcc  
arm                  randconfig-r046-20230711   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230710   clang
arm64                randconfig-r025-20230710   clang
arm64                randconfig-r034-20230710   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r035-20230710   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r041-20230711   clang
hexagon              randconfig-r045-20230710   clang
hexagon              randconfig-r045-20230711   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230710   gcc  
i386         buildonly-randconfig-r006-20230711   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
i386                 randconfig-r024-20230710   clang
i386                 randconfig-r031-20230710   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230710   gcc  
loongarch            randconfig-r022-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230710   gcc  
m68k                 randconfig-r012-20230710   gcc  
m68k                 randconfig-r026-20230710   gcc  
m68k                 randconfig-r034-20230710   gcc  
microblaze           randconfig-r011-20230710   gcc  
microblaze           randconfig-r013-20230710   gcc  
microblaze           randconfig-r032-20230710   gcc  
microblaze           randconfig-r035-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230710   clang
mips                 randconfig-r014-20230710   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230710   gcc  
openrisc             randconfig-r003-20230710   gcc  
openrisc             randconfig-r006-20230710   gcc  
openrisc             randconfig-r021-20230710   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230710   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230710   gcc  
riscv                randconfig-r013-20230710   clang
riscv                randconfig-r026-20230710   clang
riscv                randconfig-r042-20230711   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230710   gcc  
s390                 randconfig-r031-20230710   gcc  
s390                 randconfig-r036-20230710   gcc  
s390                 randconfig-r044-20230710   clang
s390                 randconfig-r044-20230711   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230710   gcc  
sh                   randconfig-r033-20230710   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230710   gcc  
sparc64              randconfig-r016-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230710   clang
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r033-20230710   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
