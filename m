Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7867773F11
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHHQmb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHHQlr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 12:41:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EDD59EA
        for <cgroups@vger.kernel.org>; Tue,  8 Aug 2023 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510104; x=1723046104;
  h=date:from:to:cc:subject:message-id;
  bh=pk4aQ0FfxkHhiRBx3kOsi8unsqRNnMKZMr1hDMA2n2g=;
  b=Yj8WviLuoaXH6CjdIV5wngsLNXuGK0acoDFnV2cabYEYktiX/oNgkgIi
   pDJxD8XS3Zd5PK7R7DSLVpZVXLIqtZcH7qKi7/nsc+Z2vHWngQ8kue/Dx
   INW9zxXeiBurA55S2xirnBRsDyDG1BFBWg+ih476RC6j2kMz9Q+rqsPOo
   r5Ahli/rMkdUzAvPd3WKaY6QFd6g6lUSa8MBW8q5FHSEmWpdc4ujBlmI8
   vU8HpJy8RUp4yA86PkD3pqUnGrkR/IAK0LaCljY6merSRalpkyHkFJS4i
   yl5VdgP7JR09oXqx3YUIfTMzgVYEAWUb09ac8KSq/3HOPbgbswNdNZeX+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369637910"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="369637910"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977742353"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977742353"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2023 00:01:50 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTGiz-0005BV-2v;
        Tue, 08 Aug 2023 07:01:49 +0000
Date:   Tue, 08 Aug 2023 15:00:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 0437719c1a97791481c5fd59642494f2108701a8
Message-ID: <202308081551.ERxqlVdc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 0437719c1a97791481c5fd59642494f2108701a8  cgroup/rstat: Record the cumulative per-cpu time of cgroup and its descendants

elapsed time: 724m

configs tested: 127
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230807   gcc  
alpha                randconfig-r006-20230807   gcc  
alpha                randconfig-r013-20230807   gcc  
alpha                randconfig-r014-20230807   gcc  
alpha                randconfig-r025-20230807   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230807   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230807   gcc  
arm                  randconfig-r032-20230807   clang
arm                  randconfig-r033-20230807   clang
arm                  randconfig-r046-20230807   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230807   gcc  
arm64                randconfig-r005-20230807   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230807   gcc  
hexagon              randconfig-r011-20230807   clang
hexagon              randconfig-r031-20230807   clang
hexagon              randconfig-r041-20230807   clang
hexagon              randconfig-r045-20230807   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230807   gcc  
i386         buildonly-randconfig-r005-20230807   gcc  
i386         buildonly-randconfig-r006-20230807   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230807   gcc  
i386                 randconfig-i002-20230807   gcc  
i386                 randconfig-i003-20230807   gcc  
i386                 randconfig-i004-20230807   gcc  
i386                 randconfig-i005-20230807   gcc  
i386                 randconfig-i006-20230807   gcc  
i386                 randconfig-i011-20230807   clang
i386                 randconfig-i012-20230807   clang
i386                 randconfig-i013-20230807   clang
i386                 randconfig-i014-20230807   clang
i386                 randconfig-i015-20230807   clang
i386                 randconfig-i016-20230807   clang
i386                 randconfig-r031-20230807   gcc  
i386                 randconfig-r032-20230807   gcc  
i386                 randconfig-r034-20230807   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230807   gcc  
loongarch            randconfig-r003-20230807   gcc  
loongarch            randconfig-r025-20230807   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r015-20230807   gcc  
microblaze           randconfig-r021-20230807   gcc  
microblaze           randconfig-r035-20230807   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230807   gcc  
mips                 randconfig-r023-20230807   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230807   gcc  
nios2                randconfig-r034-20230807   gcc  
nios2                randconfig-r036-20230807   gcc  
openrisc             randconfig-r022-20230807   gcc  
openrisc             randconfig-r024-20230807   gcc  
openrisc             randconfig-r026-20230807   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230807   gcc  
parisc               randconfig-r012-20230807   gcc  
parisc               randconfig-r026-20230807   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r005-20230807   gcc  
powerpc              randconfig-r011-20230807   clang
powerpc              randconfig-r015-20230807   clang
powerpc              randconfig-r036-20230807   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230807   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230807   clang
s390                 randconfig-r044-20230807   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230807   gcc  
sparc                randconfig-r023-20230807   gcc  
sparc64              randconfig-r013-20230807   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230807   gcc  
x86_64       buildonly-randconfig-r002-20230807   gcc  
x86_64       buildonly-randconfig-r003-20230807   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r004-20230807   gcc  
x86_64               randconfig-x001-20230807   clang
x86_64               randconfig-x002-20230807   clang
x86_64               randconfig-x003-20230807   clang
x86_64               randconfig-x004-20230807   clang
x86_64               randconfig-x005-20230807   clang
x86_64               randconfig-x006-20230807   clang
x86_64               randconfig-x011-20230807   gcc  
x86_64               randconfig-x012-20230807   gcc  
x86_64               randconfig-x013-20230807   gcc  
x86_64               randconfig-x014-20230807   gcc  
x86_64               randconfig-x015-20230807   gcc  
x86_64               randconfig-x016-20230807   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
