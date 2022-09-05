Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616D5ACEF7
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiIEJhR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiIEJhQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 05:37:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6524A809
        for <cgroups@vger.kernel.org>; Mon,  5 Sep 2022 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662370636; x=1693906636;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q6MAvMNFf4RmDnWHKYWm3tbmkFeeRNmSqUr6d6c+B/k=;
  b=H3du/rlb1x/mN6qtHFlNoOEaNReD6ZBGFobbae2nY0DqU8pSBYVuYKWO
   yoIFf2U82JoxOGTS21H9BoI5Do+g8IJHD8a+DqxlNUIlzUr7bX1mR7MTb
   v2PfKOveFRZcM0HhyRRrg8ZFcjzxVeR0cjrwP9lDBUXQKMsFuVCWxCTpM
   Mpk6TXWIBwX9OrJoMgp97MpZgTH5c7vH5zQXdihqB3ofe2UiYgppjcnXl
   KR1NDdjuANLlQ/89cQYhaJPN+aOFcWe6uhPfXEE8xYYwHnv+gkh8X/USs
   cIawBspvpkOjdeMiw2P3W5WQcmv3wxhr+iynpKRQJmGjKufFNcZDkJMiX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="360304839"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="360304839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 02:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="646835465"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2022 02:37:08 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oV8XU-00040q-0M;
        Mon, 05 Sep 2022 09:37:08 +0000
Date:   Mon, 05 Sep 2022 17:36:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.1] BUILD SUCCESS
 a8c52eba880a6e8c07fc2130604f8e386b90b763
Message-ID: <6315c32a.iDsFKkdoDHQjUf7r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.1
branch HEAD: a8c52eba880a6e8c07fc2130604f8e386b90b763  kselftest/cgroup: Add cpuset v2 partition root state test

elapsed time: 728m

configs tested: 166
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a003-20220905
i386                 randconfig-a004-20220905
i386                 randconfig-a001-20220905
i386                 randconfig-a002-20220905
i386                 randconfig-a005-20220905
arm                                 defconfig
i386                 randconfig-a006-20220905
x86_64               randconfig-a003-20220905
arc                               allnoconfig
alpha                             allnoconfig
x86_64               randconfig-a002-20220905
csky                              allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a004-20220905
x86_64               randconfig-a005-20220905
x86_64               randconfig-a001-20220905
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20220905
x86_64                         rhel-8.3-kunit
powerpc                      makalu_defconfig
x86_64                           rhel-8.3-kvm
sh                         microdev_defconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220905
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
m68k                             allmodconfig
arc                  randconfig-r043-20220904
openrisc                       virt_defconfig
x86_64                              defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
s390                 randconfig-r044-20220904
arm                              allyesconfig
arm                          pxa3xx_defconfig
x86_64                           allyesconfig
arm                             ezx_defconfig
powerpc                      ppc40x_defconfig
arc                              allyesconfig
sh                          sdk7786_defconfig
x86_64                               rhel-8.3
i386                                defconfig
alpha                            allyesconfig
m68k                             allyesconfig
riscv                randconfig-r042-20220904
i386                             alldefconfig
ia64                          tiger_defconfig
sh                         apsh4a3a_defconfig
i386                             allyesconfig
mips                           jazz_defconfig
arm                        realview_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                  maltasmvp_eva_defconfig
sh                           se7712_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ep88xc_defconfig
sh                   sh7770_generic_defconfig
sh                   secureedge5410_defconfig
powerpc                  iss476-smp_defconfig
mips                         db1xxx_defconfig
sh                           se7780_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                        mvebu_v7_defconfig
parisc                generic-32bit_defconfig
arc                          axs101_defconfig
m68k                             alldefconfig
arm                           viper_defconfig
m68k                            q40_defconfig
sparc64                             defconfig
powerpc                 mpc837x_mds_defconfig
powerpc              randconfig-c003-20220904
i386                          randconfig-c001
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sparc                               defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
arm                           corgi_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                         apollo_defconfig
powerpc                        warp_defconfig
riscv                    nommu_k210_defconfig
arm                       imx_v6_v7_defconfig
arc                              alldefconfig
arm                         axm55xx_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                 randconfig-c001-20220905
ia64                             allmodconfig
arm                        mini2440_defconfig
m68k                          atari_defconfig
mips                  decstation_64_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                       m5208evb_defconfig
microblaze                          defconfig
sh                              ul2_defconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
powerpc                     asp8347_defconfig
arm                          pxa910_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220905
x86_64               randconfig-c001-20220905
mips                      loongson3_defconfig
openrisc                 simple_smp_defconfig
powerpc                    sam440ep_defconfig
xtensa                  nommu_kc705_defconfig
arm                            mps2_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig

clang tested configs:
i386                 randconfig-a013-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a016-20220905
mips                       rbtx49xx_defconfig
x86_64               randconfig-a015-20220905
x86_64               randconfig-a014-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a011-20220905
arm                        neponset_defconfig
hexagon              randconfig-r045-20220905
x86_64               randconfig-a013-20220905
hexagon              randconfig-r045-20220904
x86_64               randconfig-a011-20220905
mips                          malta_defconfig
hexagon                             defconfig
i386                 randconfig-a014-20220905
riscv                randconfig-r042-20220905
i386                 randconfig-a015-20220905
hexagon              randconfig-r041-20220904
i386                 randconfig-a016-20220905
hexagon              randconfig-r041-20220905
s390                 randconfig-r044-20220905
powerpc                        fsp2_defconfig
arm                              alldefconfig
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
powerpc                   bluestone_defconfig
powerpc                     tqm5200_defconfig
arm                            mmp2_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa270_defconfig
powerpc                    socrates_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
