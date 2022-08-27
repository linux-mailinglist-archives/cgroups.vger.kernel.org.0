Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200F5A36D1
	for <lists+cgroups@lfdr.de>; Sat, 27 Aug 2022 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH0J6y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Aug 2022 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiH0J6v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Aug 2022 05:58:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D41FA6C06
        for <cgroups@vger.kernel.org>; Sat, 27 Aug 2022 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661594331; x=1693130331;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WaFvIrAEWKWz2RDrxHGrksTyxHIFPZuupvnsdXUTTTs=;
  b=DvrLG2ZtQ8I/LupBcqkjmgNvJZewtB7qW2Lj4S9pHsOWPm6JE767Y4YK
   uz6DKvFw6uOZe1IYWbZh1dvm3gtG19g8jzrMKd6KeOiNX20bRbIVGKJMh
   oPrwm25TIFyRMcIvj4HpZ1ZKDz2xHr2SxMj/CYuSMQQ8JkIy74XYMDFpz
   qPhFrmCRlnUSM6V+DZpqA/rZl4JCVZrezvS8bJAHnvPJioppmCvbGopJc
   SYyJa3v9vrA49kPimcdhCVFYvcoSanuG1x4AYk2UIwvdUr6wr5x4guj6l
   lq1zodfDdRo9KHHfz/hcP1jHg3TBLgONcKveCVHsvlq4CyVXD2anbVEGO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="294659887"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="294659887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 02:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="939024093"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2022 02:58:49 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRsaW-00003p-38;
        Sat, 27 Aug 2022 09:58:48 +0000
Date:   Sat, 27 Aug 2022 17:58:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 a4781930055b8f08c36f02877868bf794e92024d
Message-ID: <6309ead2.gkDAQUDb+/Mdporm%lkp@intel.com>
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
branch HEAD: a4781930055b8f08c36f02877868bf794e92024d  Merge branch 'for-6.1' into for-next

elapsed time: 722m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
loongarch                         allnoconfig
i386                                defconfig
arc                                 defconfig
loongarch                           defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
i386                          randconfig-a014
sh                               allmodconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
powerpc                          allmodconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
x86_64                           allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a016
alpha                            allyesconfig
arc                              allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arm                              allyesconfig
parisc                              defconfig
arm64                            allyesconfig
nios2                               defconfig
nios2                            allyesconfig
parisc                           allyesconfig
parisc64                            defconfig
arc                  randconfig-r043-20220824
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220826
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220823
riscv                randconfig-r042-20220826
arc                  randconfig-r043-20220826
arc                  randconfig-r043-20220825
i386                          randconfig-a001
i386                          randconfig-a003
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a005
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                          rsk7203_defconfig
parisc                generic-32bit_defconfig
arm                            xcep_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
ia64                             allmodconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r045-20220825
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
hexagon              randconfig-r045-20220827
riscv                randconfig-r042-20220827
hexagon              randconfig-r041-20220827
s390                 randconfig-r044-20220827
s390                 randconfig-r044-20220823
hexagon              randconfig-r045-20220826
hexagon              randconfig-r041-20220826
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                      obs600_defconfig
arm                                 defconfig
arm                         bcm2835_defconfig
arm                           sama7_defconfig
riscv                            alldefconfig
arm                         mv78xx0_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
