Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E285AFFD0
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIGJDM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIGJDM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 05:03:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C59A7AB8
        for <cgroups@vger.kernel.org>; Wed,  7 Sep 2022 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662541391; x=1694077391;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C5y/vnT/NUzg5fjxihzNiyz5pzYDkhUGKC98I3pIurc=;
  b=jklAxerdM7SlDNx6aCaIYAKJjJdg2XGQ27ePCuPQlG+dx1uF1IUbG+ry
   clFiJYEd0yKd0Ohl0+pwloDhHzIzR6zFZQm+DW986sKNh1HRqu8ILdDSC
   3Plpgir8jF3g1o/f/BD2nhMZD+1AELe+cxGOn7ngVFmAE0t25UWddwS7J
   HAVkRGgqpAsHnpHwvy4xuTEMbZWsVhhzBoxtViqDjYXi9NmOeqPHkmWbl
   +3FrOccYAYicyAz215jtdtsScv5Oqlz6Xx6sq2PHO21AxXhiL0E26QGb3
   kiz6eTw7ZQOX7chSbWfZCak7ejNSYV5kbLhiI1cywYohxIFSwqkz46D24
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360766692"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="360766692"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="591609651"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 02:03:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVqxg-0006Mp-28;
        Wed, 07 Sep 2022 09:03:08 +0000
Date:   Wed, 07 Sep 2022 17:02:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.0-fixes] BUILD SUCCESS
 a81e18e963ce13ecfa4f0f11b185bc8372f203f8
Message-ID: <63185e11.IDnV1xl/sjGGCbYG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.0-fixes
branch HEAD: a81e18e963ce13ecfa4f0f11b185bc8372f203f8  cpuset: Add Waiman Long as a cpuset maintainer

elapsed time: 917m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                             allyesconfig
m68k                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
parisc64                            defconfig
powerpc                 canyonlands_defconfig
arm                           viper_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
riscv                randconfig-r042-20220906
arc                  randconfig-r043-20220906
s390                 randconfig-r044-20220906
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                mpc7448_hpc2_defconfig
alpha                               defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
i386                          randconfig-c001
csky                             alldefconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
xtensa                          iss_defconfig
arm                          iop32x_defconfig
mips                           ip32_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                           se7750_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
sh                           se7705_defconfig
powerpc                      bamboo_defconfig
powerpc                      makalu_defconfig
arc                         haps_hs_defconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         lubbock_defconfig
m68k                       m5475evb_defconfig
sh                        edosk7705_defconfig
s390                             allmodconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
m68k                        mvme16x_defconfig
xtensa                  nommu_kc705_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                            titan_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7264_defconfig
sh                 kfr2r09-romimage_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                       spear13xx_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-k001
arm                              alldefconfig
powerpc                        icon_defconfig
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
