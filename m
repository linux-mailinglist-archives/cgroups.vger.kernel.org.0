Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEC686492
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBAKmk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 05:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjBAKm3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 05:42:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB69756
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675248124; x=1706784124;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g6n1pzIxc/IThPSoKWzX6Ba49VHs2cTMTP6K0bCIqrw=;
  b=iAsvweJMcRHt1W0pk5jXVqKP2iezDcMrQ8Ix3ht+c3dRypviFkFOusAs
   gS27KFyse5zf/8YEMz9XTKpg9c8rwYtx6DzbddeM2DpCAif0+lKdVJSeo
   qKKAxqlZNX8zLEVKnry3P2S7AxOwLAaStLl6HrNN38AUYP4A0SbEjeBDQ
   XTB1Qj6LVAlzwKHSL6DmgEOjBuDpwDB7feHBPhx5AcuF4O/E3F/2+9+pH
   BKLy0s0XLOtBjkDO5FIRoZMTmEQ0iflQ2AyG4M3PUMfr5TzTLvzoBByJM
   DjLtyp947VB96/3EVLwDzSy4T2aqxnN/UcBq6iIslnnFb0pBXejmBm4EI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390497642"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390497642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 02:41:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773392647"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="773392647"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2023 02:41:21 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNAYK-0005MK-2l;
        Wed, 01 Feb 2023 10:41:20 +0000
Date:   Wed, 01 Feb 2023 18:40:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.2-fixes] BUILD SUCCESS
 e5ae8803847b80fe9d744a3174abe2b7bfed222a
Message-ID: <63da41bb.2l41rZ/Q0vluO1ic%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.2-fixes
branch HEAD: e5ae8803847b80fe9d744a3174abe2b7bfed222a  cgroup/cpuset: Fix wrong check in update_parent_subparts_cpumask()

elapsed time: 738m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
x86_64               randconfig-a006-20230130
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
x86_64               randconfig-a005-20230130
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
mips                             allyesconfig
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
