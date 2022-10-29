Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317916121C1
	for <lists+cgroups@lfdr.de>; Sat, 29 Oct 2022 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJ2JZZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Oct 2022 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ2JZY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Oct 2022 05:25:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6F66131
        for <cgroups@vger.kernel.org>; Sat, 29 Oct 2022 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667035522; x=1698571522;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=doRL1DVr9fa4daC4PHQlYi3fJEz389CZ7Oz/F424Jaw=;
  b=SARTPgLYwzPFB6tP3wJ9eLHC5Hey0xuiqDJsaj4xbUGIQReFUPaSnAxh
   UQQW/zJU/AYBspbfmpgxE/vxBrb53i7zadODfw9vYSKWi24Lffkwjwlji
   llqwQDrntLfaW2dhyXkNXQrO02WGbP87BBCLCHikjD05tDxoB158wYJf8
   qKYS6FhhihxjWZ6bmlm6UDWyUa80YL86hUipyeZPETO5C2BQXTAqRPbNV
   jaEg9kxIZKN5yKyIZ+JV75XqCEUp4wQ7HoqN0XHAMy59pZQaQAVe2G0US
   +haVVftUr2OQRTtqjU53cjRL/gUmG1CaAc+NH9S3Y96wiFIAJSBhSp7yU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="289045451"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="289045451"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 02:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758348850"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="758348850"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2022 02:25:21 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooi5g-000As6-26;
        Sat, 29 Oct 2022 09:25:20 +0000
Date:   Sat, 29 Oct 2022 17:24:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD REGRESSION
 6ab428604f724cf217a47b7d3f3353aab815b40e
Message-ID: <635cf14c.5TSA5uJJpTPz+0MC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 6ab428604f724cf217a47b7d3f3353aab815b40e  cgroup: Implement DEBUG_CGROUP_REF

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202210291258.Php0YV92-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "css_get" [drivers/block/loop.ko] undefined!
ERROR: modpost: "css_get" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "css_put" [drivers/block/loop.ko] undefined!
ERROR: modpost: "css_put" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "css_put" [net/netfilter/xt_cgroup.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc-allmodconfig
    |-- ERROR:css_get-drivers-block-loop.ko-undefined
    |-- ERROR:css_get-fs-btrfs-btrfs.ko-undefined
    |-- ERROR:css_put-drivers-block-loop.ko-undefined
    |-- ERROR:css_put-fs-btrfs-btrfs.ko-undefined
    `-- ERROR:css_put-net-netfilter-xt_cgroup.ko-undefined

elapsed time: 723m

configs tested: 84
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
s390                 randconfig-r044-20221028
ia64                             allmodconfig
i386                          randconfig-a005
i386                                defconfig
i386                          randconfig-a001
arc                  randconfig-r043-20221028
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                           allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a015
m68k                             allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a012
x86_64                        randconfig-a011
riscv                randconfig-r042-20221028
arm                                 defconfig
m68k                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                      makalu_defconfig
arm                           u8500_defconfig
arm                         lpc18xx_defconfig
arm                      jornada720_defconfig
sh                           se7722_defconfig
arm                        spear6xx_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
i386                          randconfig-c001
sparc                            allyesconfig
powerpc                    sam440ep_defconfig
csky                             alldefconfig
m68k                        mvme16x_defconfig
powerpc                 canyonlands_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221028
x86_64                        randconfig-a012
i386                          randconfig-a011
hexagon              randconfig-r045-20221028
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
s390                 randconfig-r044-20221029
hexagon              randconfig-r041-20221029
hexagon              randconfig-r045-20221029
riscv                randconfig-r042-20221029
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
