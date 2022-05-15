Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF865278E8
	for <lists+cgroups@lfdr.de>; Sun, 15 May 2022 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiEORZU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 May 2022 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiEORZT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 May 2022 13:25:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32613D00
        for <cgroups@vger.kernel.org>; Sun, 15 May 2022 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652635518; x=1684171518;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lpaTDZklbx46DWOvkutIlcBRyYPhTVCjD7qS22KfmgQ=;
  b=VW2PLSJGeUpwu/YK3dnqsr5Uj7L6vC16GkvpQ4YBfmKfJvk/W3y/4v4X
   pnzjV7KtDAk/0jdxo2IiZP7A1Z+V3mZNANzxMa554PnDXrpn+Hr3n05iY
   0O4nNkABf7/oXRnZvPKQ7CB3zy4jrnBd8cgv1CHpdPYHd4HdQ5BxrLqW0
   /DNEEtsXbL1rHsq1D4xvN4ZRiUzt6HjadL2/b4UMyzqPRDWoyhUvTnLLV
   YvOCLiZdR/c8d0bRZJZvjm0bpeVMWtM5TJJx84TmEBThGMt8rWj6dtrNG
   WtfKreoQlTahyLcAmiLgkcR51RP78ESwpLb2pZ+vW0yX64AbPF9iSzBMB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="331282399"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="331282399"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 10:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="604553457"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2022 10:25:14 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqHzV-0001qA-6A;
        Sun, 15 May 2022 17:25:13 +0000
Date:   Mon, 16 May 2022 01:24:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 4d00bb3c2f23d1d8b8a25ed0cf288ebdf047aed4
Message-ID: <6281373d.DhY5vuB4tRbE/W+6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 4d00bb3c2f23d1d8b8a25ed0cf288ebdf047aed4  Merge branch 'for-5.19' into for-next

elapsed time: 2687m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           stm32_defconfig
csky                                defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8555_defconfig
arm                          simpad_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
sh                          urquell_defconfig
h8300                     edosk2674_defconfig
arm                            hisi_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7712_defconfig
sh                   secureedge5410_defconfig
arc                                 defconfig
mips                             allmodconfig
arm                        trizeps4_defconfig
mips                         tb0226_defconfig
arm                         axm55xx_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
powerpc                     taishan_defconfig
sparc                       sparc32_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
sh                        sh7763rdp_defconfig
powerpc                           allnoconfig
powerpc                 mpc837x_mds_defconfig
mips                       capcella_defconfig
arm                     eseries_pxa_defconfig
parisc                generic-64bit_defconfig
mips                           gcw0_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                             allyesconfig
xtensa                  nommu_kc705_defconfig
mips                 decstation_r4k_defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          landisk_defconfig
arm                         s3c6400_defconfig
sh                   rts7751r2dplus_defconfig
mips                         mpc30x_defconfig
sh                         ecovec24_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
powerpc                     stx_gp3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220512
riscv                randconfig-r042-20220512
s390                 randconfig-r044-20220512
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
powerpc                     tqm5200_defconfig
powerpc                      ppc64e_defconfig
x86_64                           allyesconfig
arm                         orion5x_defconfig
arm                      pxa255-idp_defconfig
arm                  colibri_pxa270_defconfig
arm                        magician_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
riscv                             allnoconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220512
hexagon              randconfig-r045-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
