Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC485278FD
	for <lists+cgroups@lfdr.de>; Sun, 15 May 2022 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiEOSDT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 May 2022 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEOSDR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 May 2022 14:03:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEEC27175
        for <cgroups@vger.kernel.org>; Sun, 15 May 2022 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652637796; x=1684173796;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DjjK1tG+kWb1f3DCQqtNmM5DQuzesVC2Ohp+zNRjklA=;
  b=kj5hUq/+0NXngZI0UwllA+dcEUwMqW9e7ah73pfVSlQpJ8jnVyN8wIk6
   /LisUprre2tait8xyLb7ppPQL9MFGs62AHkMJjFJFWVTAKtfl73aqUDvW
   QvWbViSMqu69Emvz6VZ2fIkJuS/KcfSgRPCCTtfsrsRAJxkxr0WWs69Qm
   ugS5E1HAObCrZ/Y0GcfK8I4S8wRP0kwIbQ/I4DoUw62/1Cinw8yq8LBBZ
   AMMLQGiFBcEE3yF5BHK3lzG6JG73lc/F7xKG0ho7VvpS9Zl61fUDKqKtr
   aMIaUk6OQljqaxFguYbpySSgi3OdztC4gufpYDkmtWS9EQoY83+9buoaP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="252736304"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="252736304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 11:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="625618850"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2022 11:03:14 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqIaI-0001rp-2W;
        Sun, 15 May 2022 18:03:14 +0000
Date:   Mon, 16 May 2022 02:02:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-5.19] BUILD SUCCESS
 213adc63dfbcdff9a0c19ec1f2681fda9c05cf6d
Message-ID: <6281404b.QQS1cQCnHJJXvjwf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19
branch HEAD: 213adc63dfbcdff9a0c19ec1f2681fda9c05cf6d  kseltest/cgroup: Make test_stress.sh work if run interactively

elapsed time: 2726m

configs tested: 149
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
powerpc              randconfig-c003-20220512
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
um                               alldefconfig
parisc                generic-64bit_defconfig
xtensa                    xip_kc705_defconfig
xtensa                generic_kc705_defconfig
sh                   secureedge5410_defconfig
arc                                 defconfig
mips                             allmodconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
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
alpha                               defconfig
nios2                            allyesconfig
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
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
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
mips                   sb1250_swarm_defconfig
powerpc                      ppc44x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
