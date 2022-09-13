Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20C5B6C4A
	for <lists+cgroups@lfdr.de>; Tue, 13 Sep 2022 13:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiIMLT0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Sep 2022 07:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiIMLTX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Sep 2022 07:19:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124CA5F219
        for <cgroups@vger.kernel.org>; Tue, 13 Sep 2022 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663067963; x=1694603963;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VuzEZYW6Pt0tQoB2D48o2CtKMKmaBmwAd0vC/OxLbQg=;
  b=jYbYfjEnQ65CHoqsTCrBBP5WbPRKvx1/LEZwaO7BXlSN6bf55bS5iyY3
   4/Mcqq0sZ264GjeHk3IPt3Kh5RH2phzfcjgc+t8MXBJ7Pou8WLMcMqBGm
   7wzKfCDxf3+Emv5MYxm0A1gCOyVlPvdf4N0ex247xU23LxLAnmp+mrxLV
   E2Yy71vf4c/LfLMaWxzB3Jg+8u+CdgSgdZ16oJdK4rK8Nb9bRjRFXqeIm
   tLj+GwZsdFeogFS9ims78bXSHyqVWD0tAMIfHsfr2Ailx7BfWZNVsgYIa
   CzY7/UCebbCNAZvjuBehT/S+SvV2dDJE36ytpNlbWg0/lLOpzlDHgTw71
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="296845875"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="296845875"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 04:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="649621956"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2022 04:19:20 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY3wl-0003XM-2p;
        Tue, 13 Sep 2022 11:19:19 +0000
Date:   Tue, 13 Sep 2022 19:18:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:cgroup-driver_core-for-v6.1] BUILD SUCCESS
 ee244c732790b535e1435e4e8ad4a63eff5b62ca
Message-ID: <6320670d.USwV3o2zrygqg8WL%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git cgroup-driver_core-for-v6.1
branch HEAD: ee244c732790b535e1435e4e8ad4a63eff5b62ca  Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core into cgroup-driver_core-for-v6.1

elapsed time: 732m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
riscv                randconfig-r042-20220911
arc                  randconfig-r043-20220912
arc                  randconfig-r043-20220911
powerpc                           allnoconfig
i386                 randconfig-a001-20220912
i386                 randconfig-a002-20220912
s390                 randconfig-r044-20220911
i386                 randconfig-a004-20220912
i386                 randconfig-a003-20220912
x86_64                               rhel-8.3
i386                 randconfig-a006-20220912
i386                 randconfig-a005-20220912
arc                              allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
x86_64               randconfig-a001-20220912
powerpc                          allmodconfig
arm                                 defconfig
x86_64                           allyesconfig
x86_64               randconfig-a006-20220912
x86_64               randconfig-a004-20220912
x86_64               randconfig-a002-20220912
arm                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a005-20220912
x86_64               randconfig-a003-20220912
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220912
hexagon              randconfig-r045-20220911
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912
riscv                randconfig-r042-20220912
i386                 randconfig-a014-20220912
i386                 randconfig-a015-20220912
i386                 randconfig-a013-20220912
i386                 randconfig-a016-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
x86_64               randconfig-a011-20220912
x86_64               randconfig-a012-20220912
x86_64               randconfig-a013-20220912
x86_64               randconfig-a014-20220912
x86_64               randconfig-a016-20220912
x86_64               randconfig-a015-20220912

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
