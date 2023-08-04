Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17219770C2E
	for <lists+cgroups@lfdr.de>; Sat,  5 Aug 2023 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHDW41 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Aug 2023 18:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjHDW40 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Aug 2023 18:56:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A44EFF
        for <cgroups@vger.kernel.org>; Fri,  4 Aug 2023 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691189760; x=1722725760;
  h=date:from:to:cc:subject:message-id;
  bh=hfF3/XNtO5GMLVdHtHiqICmQvusiPwZsKUswqCeygGg=;
  b=RCohxkZp5THuhi61SmFMwM1NAyS4cxADYPNfIlfpdEWLAMPLI8QYDfRb
   OoWjYfgnnrTKB1Ts7PwRK6pujtUTVNyTqKA5NGWSxKMKYTL7nMyzVR/cD
   FimizASBh2SUo3TilS+9Vhq4WqbS440jKpfU9b+Cunj4wJGG8M6UdzdzJ
   4AnGmGJgTFY/QIGdT2p7E0N2W51ItZfhSCi+ffPtHSlyPco5LE6ISioJS
   H3NUEkOLhFZVLwMfSsCDclWTyeg+fVbDmlP+e/3ul48YUfdlyMR27F5tt
   3D1kcmVCOem4mDWB5hmSN7fdIqhIwwIlEaBXch5itFGH2GT6evpR5lrCG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373918945"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="373918945"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="800263243"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="800263243"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 15:55:56 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS3i5-0003AB-0o;
        Fri, 04 Aug 2023 22:55:53 +0000
Date:   Sat, 05 Aug 2023 06:55:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 7f828eacc4bbfd3ceea8ea17051858262fe04122
Message-ID: <202308050619.1QqYWdse-lkp@intel.com>
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
branch HEAD: 7f828eacc4bbfd3ceea8ea17051858262fe04122  cgroup: fix obsolete function name in cgroup_destroy_locked()

elapsed time: 1305m

configs tested: 134
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230801   gcc  
arc                  randconfig-r023-20230801   gcc  
arc                  randconfig-r036-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230801   clang
arm                  randconfig-r011-20230801   gcc  
arm                  randconfig-r012-20230731   gcc  
arm                  randconfig-r021-20230801   gcc  
arm                  randconfig-r033-20230731   clang
arm                  randconfig-r035-20230731   clang
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230731   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230801   gcc  
csky                 randconfig-r032-20230731   gcc  
hexagon              randconfig-r004-20230801   clang
hexagon              randconfig-r014-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230801   clang
i386                 randconfig-r026-20230801   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230801   gcc  
m68k                 randconfig-r025-20230801   gcc  
microblaze           randconfig-r001-20230801   gcc  
microblaze           randconfig-r002-20230801   gcc  
microblaze           randconfig-r003-20230801   gcc  
microblaze           randconfig-r015-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230801   clang
mips                 randconfig-r005-20230801   clang
mips                 randconfig-r026-20230801   gcc  
mips                 randconfig-r036-20230731   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230801   gcc  
openrisc             randconfig-r015-20230801   gcc  
openrisc             randconfig-r032-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc               randconfig-r021-20230801   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r035-20230731   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230801   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230801   gcc  
s390                 randconfig-r031-20230731   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230801   gcc  
sh                   randconfig-r023-20230801   gcc  
sh                   randconfig-r024-20230801   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230801   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230801   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r031-20230731   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230801   gcc  
xtensa               randconfig-r034-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
