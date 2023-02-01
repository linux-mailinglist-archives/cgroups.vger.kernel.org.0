Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2502F686491
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBAKmd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 05:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjBAKmV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 05:42:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28129BBA8
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 02:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675248120; x=1706784120;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lj7bYoUxEgM5E8UcuKNL+8R4gEJUEDzXv4nx8o3TFtE=;
  b=mJ3y+7yv6ANCLMLEhZlYmq68JHBz/Utvtq9zTZk7zMKZEoyRiVpzTCRm
   lnFuAOfM02g47kL4E/4WDQ0zmakB9x6O1YFp7lAgOj2LePMGdTvlzt1oU
   C8qoRWD3M6hjMlZHSZL+2YnAcb2gZdm+GxmtW3LE6tFRzb6DQvf/QrvwQ
   IS49OL/QO2X881sKV14MKBTxkZ9iwJfIqLBAj6e3ImN1Vzg63lKIMoF/N
   7KHcvM6WHznbnapffq46mssvboACNVF4L7tm3ILG9Nd87J4XsLJudRhcs
   QV9c78DgNmu4Odu5rtKAaKzU6AP1X1A+aCS+rxzqhC6e+yH2R4bsxw4Ok
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325809565"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325809565"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 02:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="807519401"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="807519401"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2023 02:41:26 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNAYK-0005MM-2p;
        Wed, 01 Feb 2023 10:41:20 +0000
Date:   Wed, 01 Feb 2023 18:40:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-6.2-fixes] BUILD SUCCESS
 40deb00b6ec5658946b313c70b54cbce24236fda
Message-ID: <63da41b7.KuNlkH6/A62SIrpj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-6.2-fixes
branch HEAD: 40deb00b6ec5658946b313c70b54cbce24236fda  Merge branch 'for-6.2-fixes' into test-merge-for-6.2-fixes

elapsed time: 736m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
i386                 randconfig-a013-20230130
riscv                randconfig-r042-20230129
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
