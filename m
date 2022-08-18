Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3799C597E3F
	for <lists+cgroups@lfdr.de>; Thu, 18 Aug 2022 07:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiHRFsh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Aug 2022 01:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiHRFse (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Aug 2022 01:48:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A861209E
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660801712; x=1692337712;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UjqwlFoJPGJ3vP6eEhtndfd/Jlg91tFLIqFswAULmfs=;
  b=EJxBLO6lXR62JeBGd/ODqGqGlm7nU7r8yo7KSw3JpX5r4o4mQ+lrFumj
   ze3dTZYlTPrZyKVcyj0K8W9TMKT85vUmoJ4Zw+coRXd7ZKgYgpClNOyln
   Z9Uz7ZmRnqvnM3OxNGoUDefRng7AfEBuQjIkgXIev6YWBLXunGJW/RTIH
   3cCU/wZPc/U6VMSxhHguK6eHJKD/MQWUp8gK0sEDIshBEeCkfrL5Pglf3
   wfLJ2OYSO2MWI+V2zJ0kJYNmYWrAHnBhFfdbJveVKoLX3siC+c3XWwRau
   oHBv70WX1xch+UTZijlc8vYTXLCppz/9SkrHNS0TkObSQ+1ckiZPW3CN/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="273063408"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="273063408"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 22:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="675928646"
Received: from lkp-server01.sh.intel.com (HELO 6cc724e23301) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 22:48:30 -0700
Received: from kbuild by 6cc724e23301 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOYOM-00006Z-0o;
        Thu, 18 Aug 2022 05:48:30 +0000
Date:   Thu, 18 Aug 2022 13:47:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.0-fixes] BUILD SUCCESS
 4f7e7236435ca0abe005c674ebd6892c6e83aeb3
Message-ID: <62fdd274.QjonNlmiFOqWNsux%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.0-fixes
branch HEAD: 4f7e7236435ca0abe005c674ebd6892c6e83aeb3  cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock

elapsed time: 723m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
arc                  randconfig-r043-20220818
x86_64                        randconfig-a013
s390                 randconfig-r044-20220818
x86_64                        randconfig-a011
riscv                randconfig-r042-20220818
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                              defconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
i386                             allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                             pxa_defconfig
powerpc                      ppc40x_defconfig
powerpc                      mgcoge_defconfig
powerpc                      cm5200_defconfig
i386                          randconfig-c001
arc                          axs101_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
alpha                            alldefconfig
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
sh                        edosk7705_defconfig
arm                          pxa3xx_defconfig
mips                           ip32_defconfig
arm                            xcep_defconfig
sh                               alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r041-20220818
hexagon              randconfig-r045-20220818
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                 xes_mpc85xx_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
