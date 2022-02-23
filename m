Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD44C110F
	for <lists+cgroups@lfdr.de>; Wed, 23 Feb 2022 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiBWLNB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Feb 2022 06:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiBWLM4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Feb 2022 06:12:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28689CF1
        for <cgroups@vger.kernel.org>; Wed, 23 Feb 2022 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645614749; x=1677150749;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UaB/xzidvRGHRZl35orXEO8AoLRThwMZp15id5ztVSQ=;
  b=EVUrV0sLKMr7CDTJN25++ih/z/4esH0BXHw44BD7ILEAyKeA8S09a6bc
   OGD5kapdWLG0K8cjbcUqEZ1DZQamniGwjXwKtlXgsDbSR24q84i5YhM1i
   e7RJeCmLnx+9z4qQiH/0m0hINhN0dlzP0Rlw1XXtp9bjoeD0laPI9bLfo
   QVK9zK8ktnbIkYBKXEqeUuGVkMdL0YDMhtSIKztfWENhv+n9I2w8Js+o3
   RzK52h81MoroPKpMYO0vn3l4tvYY35CMXJwoRwYwFe99k7qWVyXzMtrjC
   YRxfzUP325i6QuFB8q/IUZqVpcrKTbxV02xFa2+3bGiENa943qwXAQDBr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232561581"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="232561581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="781602116"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 03:12:27 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMpZK-0001JR-Uw; Wed, 23 Feb 2022 11:12:26 +0000
Date:   Wed, 23 Feb 2022 19:11:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.17-fixes] BUILD SUCCESS
 c70cd039f1d779126347a896a58876782dcc5284
Message-ID: <6216166f.GgjiobT0DQTXr+b9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes
branch HEAD: c70cd039f1d779126347a896a58876782dcc5284  cpuset: Fix kernel-doc

elapsed time: 736m

configs tested: 161
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220221
mips                            ar7_defconfig
sh                             espt_defconfig
sh                   sh7770_generic_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     asp8347_defconfig
powerpc                     stx_gp3_defconfig
powerpc                       maple_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                         ps3_defconfig
m68k                        m5307c3_defconfig
mips                         db1xxx_defconfig
sparc                               defconfig
arm                          pxa910_defconfig
m68k                       m5475evb_defconfig
m68k                       m5275evb_defconfig
arm                         assabet_defconfig
m68k                             allyesconfig
arm                          gemini_defconfig
arm                       imx_v6_v7_defconfig
powerpc                       ppc64_defconfig
ia64                            zx1_defconfig
arm                        multi_v7_defconfig
arm                             ezx_defconfig
arm                          exynos_defconfig
arc                     haps_hs_smp_defconfig
arm                           stm32_defconfig
um                                  defconfig
arm                           sunxi_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     redwood_defconfig
alpha                               defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
powerpc                      ppc6xx_defconfig
mips                            gpr_defconfig
sh                          rsk7203_defconfig
mips                         bigsur_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
arm                        shmobile_defconfig
x86_64                           alldefconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
mips                           ci20_defconfig
arm                           h3600_defconfig
arc                        nsim_700_defconfig
arm                  randconfig-c002-20220221
arm                  randconfig-c002-20220222
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a003-20220221
x86_64               randconfig-a002-20220221
x86_64               randconfig-a005-20220221
x86_64               randconfig-a006-20220221
x86_64               randconfig-a001-20220221
x86_64               randconfig-a004-20220221
i386                 randconfig-a002-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
arc                  randconfig-r043-20220222
riscv                randconfig-r042-20220222
s390                 randconfig-r044-20220222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220221
x86_64               randconfig-c007-20220221
arm                  randconfig-c002-20220221
mips                 randconfig-c004-20220221
i386                 randconfig-c001-20220221
riscv                randconfig-c006-20220221
powerpc                      katmai_defconfig
arm                          imote2_defconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                      pxa255-idp_defconfig
arm                     am200epdkit_defconfig
arm                          pxa168_defconfig
arm                         s5pv210_defconfig
arm                            dove_defconfig
arm64                            allyesconfig
powerpc                     tqm8540_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220221
x86_64               randconfig-a015-20220221
x86_64               randconfig-a014-20220221
x86_64               randconfig-a016-20220221
x86_64               randconfig-a013-20220221
x86_64               randconfig-a012-20220221
i386                 randconfig-a016-20220221
i386                 randconfig-a012-20220221
i386                 randconfig-a015-20220221
i386                 randconfig-a011-20220221
i386                 randconfig-a014-20220221
i386                 randconfig-a013-20220221
hexagon              randconfig-r045-20220221
hexagon              randconfig-r041-20220221
riscv                randconfig-r042-20220221
hexagon              randconfig-r041-20220222
hexagon              randconfig-r045-20220222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
