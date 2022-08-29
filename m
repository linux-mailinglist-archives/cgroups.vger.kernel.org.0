Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11F5A51EB
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiH2Qfs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiH2Qfn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 12:35:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867919C31
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661790942; x=1693326942;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PzjTy3Tf5l7Kwdi/mu9ZiYf4YGlZVX2h1EMncBFMCi0=;
  b=Et6t9deUaiDR27zrjjgs3daPY1erU531iEgKwPijXRionP5q5IvLgzCV
   Q31msJjHiAQWP2YOk+MbY1w6SvHPSJ3CvUgWQk45mQiwtlUODpDSmjiea
   IUeLO+dA70mMU6aCABF+TINhv2qvgBr+NoBbCiq/ycTDFfUJlrywdUZNT
   YyWIEBvFYH5PcEKfPrZrnrnSTaeiuQTH9FfOegvrCIyxOenMWSv7clqkn
   1oYD9BK7AK7AgO/i15k080VKohmMvxP58UiJuKkVd32vkRuBOV3k7mRBR
   +JDXEPT4qhP7e9+bN5wgIYzxFiKAVdJ0f/8gN9SA09jMX1W/oiHmudHJn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295717701"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295717701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 09:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="787135495"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2022 09:35:41 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oShjg-00006k-1v;
        Mon, 29 Aug 2022 16:35:40 +0000
Date:   Tue, 30 Aug 2022 00:34:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.1] BUILD SUCCESS
 c0f2df49cf2471289d5aabf16f50ac26eb268f7d
Message-ID: <630ceaa4.HyGHzLSEmyMoQYFz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.1
branch HEAD: c0f2df49cf2471289d5aabf16f50ac26eb268f7d  cgroup: Fix build failure when CONFIG_SHRINKER_DEBUG

elapsed time: 721m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
nios2                               defconfig
um                             i386_defconfig
parisc                              defconfig
um                           x86_64_defconfig
parisc64                            defconfig
csky                              allnoconfig
nios2                            allyesconfig
csky                                defconfig
loongarch                         allnoconfig
arc                               allnoconfig
arc                                 defconfig
x86_64                              defconfig
parisc                           allyesconfig
x86_64                               rhel-8.3
alpha                               defconfig
i386                        debian-10.3-kunit
sparc                               defconfig
loongarch                           defconfig
i386                         debian-10.3-func
alpha                             allnoconfig
m68k                             allmodconfig
riscv                             allnoconfig
x86_64                                  kexec
i386                                defconfig
x86_64                           allyesconfig
xtensa                           allyesconfig
powerpc                           allnoconfig
i386                          debian-10.3-kvm
x86_64                           rhel-8.3-kvm
i386                 randconfig-a005-20220829
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20220828
riscv                               defconfig
sparc                            allyesconfig
i386                 randconfig-a006-20220829
arc                              allyesconfig
arc                  randconfig-r043-20220829
s390                             allmodconfig
riscv                    nommu_virt_defconfig
mips                             allyesconfig
riscv                          rv32_defconfig
arc                  randconfig-r043-20220828
i386                 randconfig-a001-20220829
alpha                            allyesconfig
s390                                defconfig
i386                   debian-10.3-kselftests
x86_64                           rhel-8.3-syz
i386                 randconfig-a003-20220829
x86_64                          rhel-8.3-func
m68k                             allyesconfig
sh                               allmodconfig
i386                              debian-10.3
i386                 randconfig-a002-20220829
x86_64                         rhel-8.3-kunit
arm                                 defconfig
s390                             allyesconfig
arm                              allmodconfig
s390                 randconfig-r044-20220828
x86_64                        randconfig-a004
i386                 randconfig-a004-20220829
arm64                               defconfig
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
i386                             allyesconfig
ia64                             allmodconfig
um                                  defconfig
m68k                                defconfig
ia64                                defconfig
x86_64               randconfig-a003-20220829
powerpc                        cell_defconfig
x86_64               randconfig-a004-20220829
sh                            titan_defconfig
powerpc                     tqm8555_defconfig
x86_64                        randconfig-a006
powerpc                          allyesconfig
arm                          pxa3xx_defconfig
riscv                            allmodconfig
x86_64               randconfig-a005-20220829
xtensa                              defconfig
i386                          randconfig-c001
x86_64               randconfig-a002-20220829
x86_64               randconfig-a006-20220829
arm                           imxrt_defconfig
riscv                            allyesconfig
sh                             sh03_defconfig
x86_64               randconfig-a001-20220829
arm64                            allyesconfig
arm                              allyesconfig
sh                          urquell_defconfig
parisc                generic-32bit_defconfig
sh                           se7705_defconfig
arm                        mini2440_defconfig
powerpc                      ppc40x_defconfig
i386                 randconfig-c001-20220829
powerpc                     taishan_defconfig
arm                         axm55xx_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
arm                             ezx_defconfig
arm                            mps2_defconfig

clang tested configs:
x86_64               randconfig-a011-20220829
hexagon              randconfig-r041-20220829
riscv                randconfig-r042-20220829
x86_64               randconfig-a014-20220829
hexagon              randconfig-r041-20220828
x86_64               randconfig-a016-20220829
s390                 randconfig-r044-20220829
i386                 randconfig-a011-20220829
hexagon              randconfig-r045-20220828
mips                           ip28_defconfig
powerpc                     tqm8560_defconfig
powerpc                      walnut_defconfig
i386                 randconfig-a014-20220829
x86_64               randconfig-a015-20220829
hexagon              randconfig-r045-20220829
x86_64               randconfig-a012-20220829
x86_64                        randconfig-a001
x86_64               randconfig-a013-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
x86_64                        randconfig-a003
i386                 randconfig-a015-20220829
powerpc                    ge_imp3a_defconfig
x86_64                        randconfig-a005
i386                 randconfig-a016-20220829
mips                  cavium_octeon_defconfig
mips                          ath25_defconfig
arm                     davinci_all_defconfig
powerpc                     mpc512x_defconfig
riscv                    nommu_virt_defconfig
arm                             mxs_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
