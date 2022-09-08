Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D45B19B3
	for <lists+cgroups@lfdr.de>; Thu,  8 Sep 2022 12:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiIHKME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIHKMD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 06:12:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A12615E
        for <cgroups@vger.kernel.org>; Thu,  8 Sep 2022 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662631923; x=1694167923;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uLQDszh3PEbuhemVaQifrSvUHmnBnUTcv80XeYlBkL4=;
  b=miYsYnSxF1eIW6pUiYTGob93XaJEI4A8Tsc0n31/RsVkOpaHfWUW8Vn4
   n4BD7GDzkhT6EfdvNT1p1SaUYLfJSx5QTZI8zwuAKkOAlNVzqMj1BkUVv
   ZKnYKRME+WTEOOyfoPvrrpgqbsLoi6gwAohvQ7VDahdGjDZMbFaG027lU
   +ZjWRQ9+GJxfKab1IImh0vObNgfq15x1p/9Wh+NPDoEvge42sFJu02jFv
   u8uWN2C+QuOMLOPXqBJq84o8mBeamgdoAWARDg9DYuCD9Zf2a0o0Ps32x
   vhezFOra77tvLf5guBTESUcqTSOTQr50j5ESCVIy2SwVOyWdpCoIqCWja
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294713398"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="294713398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="645019333"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 03:12:00 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWEVs-0007c1-0x;
        Thu, 08 Sep 2022 10:12:00 +0000
Date:   Thu, 08 Sep 2022 18:11:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a2675ab75dff48666c07afa488eaba0d684becbc
Message-ID: <6319bfd0.zQXE8Febd8iKVjkd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: a2675ab75dff48666c07afa488eaba0d684becbc  Merge branch 'for-6.1' into for-next

elapsed time: 1054m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
m68k                             allyesconfig
arc                  randconfig-r043-20220907
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                              defconfig
i386                          randconfig-a001
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arm64                            allyesconfig
arm                              allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
csky                                defconfig
sparc                            alldefconfig
i386                             allyesconfig
sparc                               defconfig
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
ia64                          tiger_defconfig
arc                              alldefconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
sparc                             allnoconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
sh                     sh7710voipgw_defconfig
sh                             sh03_defconfig
sh                           se7750_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7780mp_defconfig
arm                            qcom_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                         wii_defconfig
xtensa                  cadence_csp_defconfig
m68k                       m5275evb_defconfig
sh                         ap325rxa_defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
microblaze                          defconfig
powerpc                        cell_defconfig
parisc64                         alldefconfig
arm                        realview_defconfig
xtensa                              defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220907
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                 mpc8315_rdb_defconfig
mips                           ip22_defconfig
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                      pxa255-idp_defconfig
s390                             alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
