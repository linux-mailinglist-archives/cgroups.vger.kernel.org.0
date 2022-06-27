Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E155D898
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiF0Vw4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 17:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbiF0Vw4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 17:52:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2F31A2
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656366775; x=1687902775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NhWs8N/vjGrSh+fTgN9/egbjqvHltxsKp1DleB6Ms/c=;
  b=TjZFdQcm5M82QMGPauzqt945s4u0UFmGON3tT21tYM+HPuhkel6I8ICV
   JKwpPXKEvyypiHpTrEzfAPZwVDIMNrsqDhSR4agkPhc++2pfT/Vv2jDTj
   nY+/HpaLHlPtjPLDACn2zkb660OFEK9SwkGto5aT+TUUY2PGABj03JKMw
   EKzqZYolHwoM3mQ62Ciz1ANoQZKP/h2Y3h1sgVQU/Ybw3iWVIdXeNrw+2
   2V/138sYv9i9OsBntZr0GHqTzXWbBlviqOvCUigrWbi10ZLpFz0Ug6H22
   xmw7JS3YhaSzZidVNglVu9CVgg7vVrDaIpI2skdwe34DMj/w6HJCy7gS9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343260023"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343260023"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657862954"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2022 14:52:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5wf7-00095O-3n;
        Mon, 27 Jun 2022 21:52:53 +0000
Date:   Tue, 28 Jun 2022 05:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 27924b13fcce42222e836394711fe1e7ec010cc6
Message-ID: <62ba268a.Cvk3y//WW7NkdOa8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 27924b13fcce42222e836394711fe1e7ec010cc6  Merge branch 'for-5.20' into for-next

elapsed time: 721m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220627
sparc64                             defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
sh                        sh7785lcr_defconfig
arm                          pxa910_defconfig
mips                      maltasmvp_defconfig
arc                        nsim_700_defconfig
arc                           tb10x_defconfig
sh                   sh7770_generic_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
x86_64               randconfig-k001-20220627
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a013-20220627
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a014-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a013-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                      acadia_defconfig
mips                           ip27_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a004-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a002-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
