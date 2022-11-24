Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFD637971
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 13:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKXM5U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 07:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKXM5R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 07:57:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044062059
        for <cgroups@vger.kernel.org>; Thu, 24 Nov 2022 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294636; x=1700830636;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Kw0L4NM8Tm+uPTRhWMFYNJRMX46UCwAiJrVgnDn31pM=;
  b=c8KEdTIsWqs0OH5VrynNTVSK9ulWqyomSYcr2pwwO6mbv2WZLbUA/6OE
   fBY6+5bjq2SVG8ya3K/hF5uBHOZ6ScmV242ULYiDFpcDcg2YGO196LXdO
   RJCFFA5HXVAHb1xHuHVgUB9RbysIMfh67Pv5I2A7BU2Mp8b7pXJkYa42p
   kL9ArZ9sNLjvDW65AMZQT9w/NINVIM726OtEKHfUzwyJa2+olABw2hDX9
   HaFfsNDl50u0tQFwjN3mLtEPgtAnYuH3O2Mycw3negD12Y0BbtJjG+9Kw
   4UyF3u3SUg0WzSfFVKh0T2aPGD0bkCwqFhASZL+ElBK4yaSzfp/GG+oTY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311931653"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311931653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 04:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="816844235"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="816844235"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2022 04:57:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyBn0-0003tp-1L;
        Thu, 24 Nov 2022 12:57:14 +0000
Date:   Thu, 24 Nov 2022 20:57:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 674b745e22b3caae48ad20422795eefd3f832a7b
Message-ID: <637f6a27.Fe0r8IMIiZfjGK9w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 674b745e22b3caae48ad20422795eefd3f832a7b  cgroup: remove rcu_read_lock()/rcu_read_unlock() in critical section of spin_lock_irq()

elapsed time: 1162m

configs tested: 45
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                                defconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a015-20221121
x86_64                            allnoconfig
x86_64                              defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
