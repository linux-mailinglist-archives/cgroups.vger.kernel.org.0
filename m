Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F32686490
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjBAKmX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 05:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjBAKmE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 05:42:04 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3964D92
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 02:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675248100; x=1706784100;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=53o9cuavzgsjn6igDc0NGGo4ZRr2UiYoFtrLpTaOA8Q=;
  b=HPtlWkOoDpzUGKCXGxED39MVKiR6/L3JYXwxOw+CiGz7E4t0tw7bBbo3
   vwAq4YRGIr0EZafeKHBRjJ0H44oBge88XSHRX6kr7DLamLCWOE1MBJXPC
   tGdC1QV9cYqxoxg/0/zbwhff9G7raVuJYlLh84XAXljmRRXIGwSRIq3A2
   4ZDazyxAL6oCPz3EALaOc3xE9B3Ou+68oJXNscXRv2JqoEeLJgP/9B4MD
   fi7WgPuTV41qGhXsDxDvmbMgC7FM/u5K3iEMdUuyQ0xYt/FmatekvaTns
   smyqcdNuaiB3dK7UU6ffAJXT+4nKNxuhprlAkIzYgr11W5g1yWfyv2JVO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390497640"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390497640"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 02:41:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773392646"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="773392646"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2023 02:41:21 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNAYK-0005MI-2g;
        Wed, 01 Feb 2023 10:41:20 +0000
Date:   Wed, 01 Feb 2023 18:40:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 54b970021f92dc38f266926a31549bb88764f37d
Message-ID: <63da41b9.+m+tppQCMMBI0EbB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 54b970021f92dc38f266926a31549bb88764f37d  Merge branch 'for-6.2-fixes' into for-next

elapsed time: 737m

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
um                             i386_defconfig
s390                             allyesconfig
um                           x86_64_defconfig
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a001-20230130
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a003-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
arc                  randconfig-r043-20230129
i386                 randconfig-a006-20230130
arm                  randconfig-r046-20230129
i386                 randconfig-a004-20230130
i386                 randconfig-a005-20230130
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a015-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
