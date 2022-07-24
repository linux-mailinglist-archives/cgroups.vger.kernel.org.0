Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161957F2C6
	for <lists+cgroups@lfdr.de>; Sun, 24 Jul 2022 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiGXDpc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Jul 2022 23:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbiGXDp3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Jul 2022 23:45:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2988FE0EC
        for <cgroups@vger.kernel.org>; Sat, 23 Jul 2022 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658634327; x=1690170327;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tXTRGfVOyX64rXW9Adgpf02Ds8hM0NdjqtiDxM3Mp78=;
  b=OgQHFDfU+RdEt7nhv64C5rEtjDB+e1dn/KQpx5KwI+WeduFJ7y3yrqbo
   UgtUQvsYtj6j4S6uMx9Wwy0EqYotu5aAM28UmIJ2YPON23TjJrtuvRikz
   h85N8mBgjD2LrSrHzBccWmWplLo/krba3/NbcfFPkI+3zWHTHeNDobb7L
   RDtkP/rtE3g86GMampNnX+cHKnUtvsGmyrTaN8F8GtY3wYAMGpMy8mcw+
   7DlqJYLdad/Qzcec7u9EPXVlF8wLHXrWO0KEhRzVCOGHimMc2PtmMzWjR
   6PEHa8fnSZzU7SstpgtPPE5VBYgIpAYwE9fBRGaZFlrvdKFWsfW8mCfH1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="349209744"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="349209744"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 20:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="926486225"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2022 20:45:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFSYW-0003VJ-0h;
        Sun, 24 Jul 2022 03:45:24 +0000
Date:   Sun, 24 Jul 2022 11:44:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 dfce5395b3a007a1a5c3a99a8523a4fc266d858a
Message-ID: <62dcc02e.K9qoXN0TyDfSwFoW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: dfce5395b3a007a1a5c3a99a8523a4fc266d858a  Merge branch 'for-5.20' into for-next

elapsed time: 720m

configs tested: 129
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220724
i386                          randconfig-c001
sh                               alldefconfig
arm                          lpd270_defconfig
m68k                            mac_defconfig
um                                  defconfig
arm                           h5000_defconfig
mips                  decstation_64_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
mips                         bigsur_defconfig
sh                          rsk7269_defconfig
sh                     magicpanelr2_defconfig
sh                          r7785rp_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
mips                 decstation_r4k_defconfig
sh                        sh7763rdp_defconfig
m68k                         amcore_defconfig
arm                            hisi_defconfig
sh                         ap325rxa_defconfig
xtensa                  nommu_kc705_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
sh                                  defconfig
parisc                generic-64bit_defconfig
riscv                               defconfig
powerpc                 mpc837x_rdb_defconfig
mips                          rb532_defconfig
openrisc                         alldefconfig
arm                          simpad_defconfig
mips                           ci20_defconfig
sh                          kfr2r09_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
arm                            pleb_defconfig
ia64                         bigsur_defconfig
loongarch                           defconfig
parisc64                         alldefconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220724
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
arc                  randconfig-r043-20220723
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
mips                          malta_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       mainstone_defconfig
mips                        qi_lb60_defconfig
mips                        bcm63xx_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
mips                      malta_kvm_defconfig
mips                           rs90_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724
hexagon              randconfig-r041-20220723
riscv                randconfig-r042-20220723
hexagon              randconfig-r045-20220723
s390                 randconfig-r044-20220723

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
