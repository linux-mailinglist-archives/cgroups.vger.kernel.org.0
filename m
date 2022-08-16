Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF29595B77
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiHPMM1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiHPMLy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 08:11:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D8647E9
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651556; x=1692187556;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ao5tAKMATYIlCAWYSMy9a0wQ8v63GMU1EE+8N7QQoHo=;
  b=awaxVp/PO2EGYn3LJ5ixSwN9GWSnWaD4pXIFJ+TrFiKNGWEA5iDKFCZu
   a208v8Vd5dYmAt0AXJSJuN7a2J2jaKGnsr2QEnTZpds/7Fu90EjY2GRN2
   I3o7ATIwZNPXqO8gKKD0H8mWpgWhNgqycMds1l+r9WU8Y75N4vnclecdm
   GbdnNV3MSminRVq2TymBpF/WZRvNW1y4NYdpXLp8E88DG08obucnBKcSA
   OKYMX00hLqBdQDRHV27AWOUXDGxy2uU7619kUX9QV4C4QvmWLIvpVP/Ou
   2SSbZtkTGsycyOg8p+BAnYtfdRgEpFesPW6tTDUonLPtNAkZetEmpM359
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="275254388"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="275254388"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="635864265"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 05:05:54 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNvKU-0001lP-0N;
        Tue, 16 Aug 2022 12:05:54 +0000
Date:   Tue, 16 Aug 2022 20:05:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.1] BUILD SUCCESS
 7f203bc89eb66d6afde7eae91347fc0352090cc3
Message-ID: <62fb87f7.ev0O+WhLKQuzdHyI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.1
branch HEAD: 7f203bc89eb66d6afde7eae91347fc0352090cc3  cgroup: Replace cgroup->ancestor_ids[] with ->ancestors[]

elapsed time: 728m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
x86_64               randconfig-a006-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a001-20220815
x86_64               randconfig-a002-20220815
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
s390                       zfcpdump_defconfig
powerpc                 mpc8540_ads_defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
powerpc              randconfig-c003-20220815
i386                 randconfig-c001-20220815
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
m68k                            q40_defconfig
arm                         s3c6400_defconfig
powerpc                      makalu_defconfig
arc                            hsdk_defconfig
powerpc                    klondike_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
xtensa                         virt_defconfig
powerpc                       eiger_defconfig
arm                          iop32x_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
nios2                               defconfig
arm                         vf610m4_defconfig

clang tested configs:
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a013-20220815
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a016-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a012-20220815
arm                        multi_v5_defconfig
x86_64               randconfig-k001-20220815
powerpc                          g5_defconfig
powerpc                          allmodconfig
powerpc                 mpc836x_mds_defconfig
arm                       mainstone_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc832x_rdb_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                       versatile_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
