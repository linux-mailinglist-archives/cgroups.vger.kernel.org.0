Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC575A526C
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiH2Q7d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiH2Q7L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 12:59:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708A9A9F5
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661792348; x=1693328348;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4xNxUlLRo8RNo/PnbNMC7o9sRxId5J/hCVlHSPShx/o=;
  b=eZVJQo1QHdnP7fYaMsGwJg+ZMGTScqMVXs2JH7at3725C4VU8X2xtO6v
   qgpo4Y28xZieejIkkownS5i/Oycd1EDcLYS477cjfns3u/3mkhZQrww9f
   5HMwTmSvrpkhoJkm/lJMzCwRYgECFunT1eo0sB+/U0y/mJCVyddKVPwz5
   YT13B78wcZHMAZT7qK8V112gB1aUa1KvYXUz72Fj12H6MT+HEL/cBX5PI
   w9XWTpqWMCiZLn1T+jXhYW9aGJ1So+9mkIIWGl5wh/Lt0UgFLRnYOirqK
   SGCX4h8ytYSu7dLKn7w+XE+/DVYW/zIugyWQC4aIETyGLS73KlfD7PfaJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275340427"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="275340427"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 09:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="737392525"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2022 09:35:41 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oShjg-00006h-1p;
        Mon, 29 Aug 2022 16:35:40 +0000
Date:   Tue, 30 Aug 2022 00:34:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5214a36f9afe3bc1bb393e78934fa3e8f10f5e3d
Message-ID: <630ceaa2.R70XOuUPqaApf87v%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5214a36f9afe3bc1bb393e78934fa3e8f10f5e3d  Merge branch 'for-6.1' into for-next

elapsed time: 721m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                        debian-10.3-kunit
i386                         debian-10.3-func
um                           x86_64_defconfig
i386                          debian-10.3-kvm
um                             i386_defconfig
loongarch                         allnoconfig
parisc                           allyesconfig
loongarch                           defconfig
parisc                              defconfig
nios2                               defconfig
nios2                            allyesconfig
parisc64                            defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
csky                                defconfig
riscv                    nommu_k210_defconfig
x86_64               randconfig-a003-20220829
m68k                             allmodconfig
arc                              allyesconfig
arc                                 defconfig
alpha                            allyesconfig
alpha                               defconfig
riscv                    nommu_virt_defconfig
sparc                               defconfig
x86_64               randconfig-a004-20220829
s390                                defconfig
x86_64               randconfig-a005-20220829
riscv                          rv32_defconfig
x86_64                              defconfig
x86_64               randconfig-a002-20220829
s390                             allmodconfig
x86_64               randconfig-a006-20220829
x86_64                                  kexec
m68k                             allyesconfig
sparc                            allyesconfig
i386                 randconfig-a001-20220829
xtensa                           allyesconfig
x86_64               randconfig-a001-20220829
riscv                randconfig-r042-20220828
i386                 randconfig-a003-20220829
arc                               allnoconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
i386                 randconfig-a002-20220829
riscv                            allmodconfig
alpha                             allnoconfig
i386                                defconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20220829
csky                              allnoconfig
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20220829
arm                                 defconfig
powerpc                          allyesconfig
mips                             allyesconfig
i386                 randconfig-a005-20220829
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
riscv                            allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a006-20220829
i386                          randconfig-a014
arc                  randconfig-r043-20220828
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220828
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-c001
ia64                             allmodconfig
x86_64                           alldefconfig
loongarch                        alldefconfig
sh                           se7780_defconfig
arm                         lubbock_defconfig
arc                           tb10x_defconfig
arm64                            allyesconfig
arm                           corgi_defconfig
sh                                  defconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a013
arm                        keystone_defconfig
sh                           se7724_defconfig
powerpc                      mgcoge_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
powerpc                  iss476-smp_defconfig
xtensa                              defconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20220829
powerpc                     taishan_defconfig
arm                         axm55xx_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                                defconfig
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
arm                             ezx_defconfig
arm                            mps2_defconfig

clang tested configs:
x86_64               randconfig-a011-20220829
i386                          randconfig-a013
x86_64               randconfig-a014-20220829
x86_64               randconfig-a012-20220829
hexagon              randconfig-r041-20220829
i386                          randconfig-a011
riscv                randconfig-r042-20220829
x86_64               randconfig-a013-20220829
hexagon              randconfig-r041-20220828
i386                          randconfig-a015
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220828
hexagon              randconfig-r045-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a015-20220829
arm                       versatile_defconfig
x86_64                        randconfig-a012
powerpc                     kmeter1_defconfig
riscv                    nommu_virt_defconfig
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
arm                             mxs_defconfig
arm                        mvebu_v5_defconfig
i386                 randconfig-a016-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
