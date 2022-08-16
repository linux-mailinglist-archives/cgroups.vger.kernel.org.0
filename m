Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D2595B66
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiHPMIo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiHPMIB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 08:08:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EF3BFD
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651196; x=1692187196;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/vKH5VFn9cxuG6Qu4j0g+vr4bidhC9vvX+MnqT0OT1o=;
  b=UKOQ3PS9XydAce+oKQPgtZoAuBlk3ZMqsgw8vXSCnGtJu8psy5TkaWa0
   nUjwpAANU0kJvd2IJC8trUb5xXZaNPaHSXpfLWSL9HXikIX3PDD6dDl+v
   CV17tLA08UgBThh/SbiFpwcmfBV/llRSXFD9WSJCLG5nQzie3BNAjgSh+
   r4QT3s9viJ3p6I8KHMArIuioH0BHVcOk0qTll1tqWxnIqeM2SUfvKpO+r
   oPiKworFnjRopnzZk99Ggory7NarOcfAwL8y0iRFq1h9DVdRL8Fuc28oC
   mpuj3Yfuyj2vf8S24Flwe5ATg1RjL8/sTbziWOt9RtoOeK5QYJoIZDN17
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="271968809"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="271968809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="583277986"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2022 04:59:54 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNvEf-0001kg-2x;
        Tue, 16 Aug 2022 11:59:53 +0000
Date:   Tue, 16 Aug 2022 19:59:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 8eb57231f546431eaaa568a421b78adc3c25c733
Message-ID: <62fb86ab.4McPHOeYFAhp8a9J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 8eb57231f546431eaaa568a421b78adc3c25c733  Merge branch 'for-6.1' into for-next

elapsed time: 723m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arm                                 defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64               randconfig-a001-20220815
m68k                             allmodconfig
i386                 randconfig-a003-20220815
powerpc                          allmodconfig
x86_64               randconfig-a003-20220815
arc                              allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a004-20220815
x86_64               randconfig-a002-20220815
alpha                            allyesconfig
i386                 randconfig-a006-20220815
m68k                             allyesconfig
arm                              allyesconfig
mips                             allyesconfig
i386                 randconfig-a005-20220815
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a002-20220815
x86_64               randconfig-a005-20220815
i386                 randconfig-a001-20220815
arc                  randconfig-r043-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a006-20220815
ia64                             allmodconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc              randconfig-c003-20220815
i386                 randconfig-c001-20220815
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
nios2                               defconfig
arm                         vf610m4_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig

clang tested configs:
i386                 randconfig-a012-20220815
i386                 randconfig-a011-20220815
hexagon              randconfig-r045-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a014-20220815
x86_64               randconfig-a013-20220815
i386                 randconfig-a015-20220815
riscv                randconfig-r042-20220815
i386                 randconfig-a016-20220815
x86_64               randconfig-a016-20220815
hexagon              randconfig-r041-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
s390                 randconfig-r044-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
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
