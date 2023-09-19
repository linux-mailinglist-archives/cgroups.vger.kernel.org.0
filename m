Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB677A5D33
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjISJA6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 05:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjISJA6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 05:00:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A56E6
        for <cgroups@vger.kernel.org>; Tue, 19 Sep 2023 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695114052; x=1726650052;
  h=date:from:to:cc:subject:message-id;
  bh=xHQOuMaHrJWYK7naFJJN1BcQwrWKdaI0G8zIIOwKMGA=;
  b=hdRKEPFG2oWKlMZDC6hEICkLMocnijkoAXUt0rSSkeWjZFb6ZEHLEy/t
   xqcKxvY2HpQP+xeQvAbHd5a/ikblZFcG0ZOzPISgM02QkpNsey0gLFLQi
   8Nb1x9UuaH9elT3aoa2GWPnQ9IispDX0R+NU0ZvW/zuD5pVfIFA4aS8PP
   ugthEDDDbPQZv4zBB8OyVZbPtAYe19+kPB3U4ROyDyQP09SH0PuEAiZ9S
   bGuaINfqhCq8DtlKBn1BAqMkgOPLURlu3rTXLHVmCLVnAOgzTKWAOkA5L
   iXtlcyC1PI/3i5R9GnNTsgOye5ztMPdSd5afrwg1YO2WvPq1E7QXLgSlZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="364936675"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="364936675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="781233219"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="781233219"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2023 02:00:50 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiWYx-000792-1k;
        Tue, 19 Sep 2023 08:59:22 +0000
Date:   Tue, 19 Sep 2023 16:58:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 105f3fe9188b37752c25d154870ceca352c9213f
Message-ID: <202309191659.qdv9GUqz-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 105f3fe9188b37752c25d154870ceca352c9213f  cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition

elapsed time: 726m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20230919   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                   randconfig-001-20230919   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230919   gcc  
i386         buildonly-randconfig-002-20230919   gcc  
i386         buildonly-randconfig-003-20230919   gcc  
i386         buildonly-randconfig-004-20230919   gcc  
i386         buildonly-randconfig-005-20230919   gcc  
i386         buildonly-randconfig-006-20230919   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230919   gcc  
i386                  randconfig-002-20230919   gcc  
i386                  randconfig-003-20230919   gcc  
i386                  randconfig-004-20230919   gcc  
i386                  randconfig-005-20230919   gcc  
i386                  randconfig-006-20230919   gcc  
i386                  randconfig-011-20230919   gcc  
i386                  randconfig-012-20230919   gcc  
i386                  randconfig-013-20230919   gcc  
i386                  randconfig-014-20230919   gcc  
i386                  randconfig-015-20230919   gcc  
i386                  randconfig-016-20230919   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230919   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20230919   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230919   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230919   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230919   gcc  
x86_64       buildonly-randconfig-002-20230919   gcc  
x86_64       buildonly-randconfig-003-20230919   gcc  
x86_64       buildonly-randconfig-004-20230919   gcc  
x86_64       buildonly-randconfig-005-20230919   gcc  
x86_64       buildonly-randconfig-006-20230919   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230919   gcc  
x86_64                randconfig-002-20230919   gcc  
x86_64                randconfig-003-20230919   gcc  
x86_64                randconfig-004-20230919   gcc  
x86_64                randconfig-005-20230919   gcc  
x86_64                randconfig-006-20230919   gcc  
x86_64                randconfig-071-20230919   gcc  
x86_64                randconfig-072-20230919   gcc  
x86_64                randconfig-073-20230919   gcc  
x86_64                randconfig-074-20230919   gcc  
x86_64                randconfig-075-20230919   gcc  
x86_64                randconfig-076-20230919   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
