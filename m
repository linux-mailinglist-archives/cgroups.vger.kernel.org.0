Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369D14D8B57
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 19:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiCNSJ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCNSJZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 14:09:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BBE007
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647281295; x=1678817295;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZsZ/YVPtgr3g0B7nWePzofoAP8EzCT6HF1aDW+aWnQ0=;
  b=hJJUUFV6F2873zXs/c8tL/invZuH40gwt+lCyY97RPGTjxMrydlcD/hq
   uljUlu/tQBxeaPIqdGvshCf1ArBlMOMAB7jXZ77waBAhOcDaM+Lgl7dl8
   9iOS0I7B76+3TTy6vnCe80zPak8aKMV+/lumo9w2sPd4Fo7hTP4I4Ep1l
   8j756v+DPJd+aQ5zyEZt0B6CR8MD9uCB82LuxQpwMli4vpsYO4TUWZQcI
   iFfyuB6C5GwJ8JYUYngwAct56wdW4s/XvYsHQvyFmTHUlT+79LBi1C5BI
   Ur2UMLPimajizq8xO76/oytYImeQ0nB/vxCSFt8wrQrRPV//9968fEGlB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="254935384"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="254935384"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 11:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="645906067"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2022 11:08:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTp76-000A73-4W; Mon, 14 Mar 2022 18:08:12 +0000
Date:   Tue, 15 Mar 2022 02:07:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.18] BUILD SUCCESS
 f9da322e864e5cd3dc217480e73f78f47cf40c5b
Message-ID: <622f844f./amqu4oGlkN9QUak%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18
branch HEAD: f9da322e864e5cd3dc217480e73f78f47cf40c5b  cgroup: cleanup comments

elapsed time: 727m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220314
mips                 randconfig-c004-20220314
powerpc              randconfig-c003-20220313
arm                            zeus_defconfig
sh                                  defconfig
mips                           xway_defconfig
arm                          pxa910_defconfig
m68k                          multi_defconfig
h8300                            allyesconfig
arm                           u8500_defconfig
mips                        jmr3927_defconfig
arm                            xcep_defconfig
sh                           se7343_defconfig
sh                          rsk7264_defconfig
m68k                        mvme16x_defconfig
powerpc                         ps3_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7269_defconfig
powerpc                      mgcoge_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
powerpc                     tqm8555_defconfig
powerpc                 linkstation_defconfig
powerpc                      bamboo_defconfig
ia64                         bigsur_defconfig
um                           x86_64_defconfig
arm                         lpc18xx_defconfig
i386                                defconfig
sh                          kfr2r09_defconfig
mips                      fuloong2e_defconfig
sparc                            alldefconfig
sh                   sh7770_generic_defconfig
s390                                defconfig
powerpc                      makalu_defconfig
sh                            migor_defconfig
xtensa                  nommu_kc705_defconfig
arc                           tb10x_defconfig
powerpc                       maple_defconfig
arm                             rpc_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                   motionpro_defconfig
arc                                 defconfig
sh                            titan_defconfig
xtensa                  audio_kc705_defconfig
sh                      rts7751r2d1_defconfig
nds32                               defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sh                           se7721_defconfig
s390                          debug_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8548_defconfig
i386                             alldefconfig
arc                         haps_hs_defconfig
x86_64                              defconfig
sh                        sh7785lcr_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7750_defconfig
arm                        mini2440_defconfig
mips                           ip32_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7780_defconfig
ia64                             allmodconfig
arm                           h3600_defconfig
arm                            lart_defconfig
mips                 decstation_r4k_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
arc                  randconfig-r043-20220313
arc                  randconfig-r043-20220314
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20220313
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
hexagon                             defconfig
powerpc                    socrates_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
arm                       cns3420vb_defconfig
arm                      pxa255-idp_defconfig
arm                        magician_defconfig
arm                         lpc32xx_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kilauea_defconfig
mips                      malta_kvm_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
