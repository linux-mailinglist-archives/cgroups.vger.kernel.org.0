Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7435FB14E
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJKLR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJKLR1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 07:17:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74085167DF
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665487046; x=1697023046;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HwwtWoDq4wy6K6LEkAoGaoTIfiEUpw75Mm1enDNt/sw=;
  b=VSW1qs3W996YmIlGvhgqsQsGOJKW3cytr28jc+4IMa7t/3oHq1+TQxAv
   QDvDTRKWBkM4PzhDQuSedV62scPbiKN0zFqx5rrRnIL45xoUUBateGjcW
   rqTF2lKkOVzib5kMutE8glp4KMPrLPAIs4/UJ8tWUApCl1jRRi3hKGo+2
   nt4jU88aONTH3zWyQA9brrnr06Jiq0UyjOqOtJ4nOCRdcYjwAGJuN597I
   +/qk772VD46SSG5aAnGBws+DMBRZKZyL7kf/hoRzWEfdlbYEBj/+5nQzl
   jd/6XRjEf5GicuS0i/kEHfGIV8m6pIefmtp7w3na5/Ir9l/kkxI9LijhW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="305530780"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="305530780"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 04:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577403386"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="577403386"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 04:17:25 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiDGG-0002nm-1F;
        Tue, 11 Oct 2022 11:17:24 +0000
Date:   Tue, 11 Oct 2022 19:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 03db7716159477b595e9af01be8003b7e994cc79
Message-ID: <634550a2.o/y75F8TcI9EWfEn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 03db7716159477b595e9af01be8003b7e994cc79  Revert "cgroup: enable cgroup_get_from_file() on cgroup1"

elapsed time: 724m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
arc                  randconfig-r043-20221010
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                 randconfig-r044-20221010
riscv                randconfig-r042-20221010
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
s390                                defconfig
alpha                            allyesconfig
x86_64                              defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
s390                             allmodconfig
i386                 randconfig-a015-20221010
sh                               allmodconfig
i386                                defconfig
mips                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                 randconfig-a016-20221010
s390                             allyesconfig
i386                 randconfig-a011-20221010
arm                                 defconfig
i386                 randconfig-a013-20221010
x86_64                               rhel-8.3
i386                 randconfig-a014-20221010
i386                 randconfig-a012-20221010
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64               randconfig-a011-20221010
i386                             allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a014-20221010
arm                              allyesconfig
x86_64               randconfig-a012-20221010
x86_64               randconfig-a013-20221010
x86_64               randconfig-a016-20221010
x86_64               randconfig-a015-20221010
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
i386                 randconfig-a005-20221010
i386                 randconfig-a003-20221010
i386                 randconfig-a006-20221010
i386                 randconfig-a002-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a004-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a005-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a003-20221010
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
