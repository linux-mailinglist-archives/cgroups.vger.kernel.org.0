Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF943584C0F
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 08:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiG2GgR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiG2GgE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 02:36:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F657391C
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659076531; x=1690612531;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wmrB32ud727k1HoVT2qjOvqbMhSqmy8KWN0Rbdoy5tg=;
  b=JfnUqYOCFfLdPuKE0fgZgrETMyTg2ehy/lXKIV/xNjr2PEtIywXVODdY
   FuOx4BgzjkExZfNVIOFDa46EPmMV8DSrwkIzlEXAA3d4joGOyipN76gIM
   J88KQAWduE3bobat/ES6xzBs/GhYfhuqYg1Kr/w02Dq6JTEmKxhlvagRt
   hUq/WOIkfUrIGqCg+ubfW7O2sLwLNMsXV+YLuU+t9AXUBvxlRU8Dhsl1R
   TH2a4manAe/Bz7EcYmq2w0GV/JUeJ9x/1S3Gi5rx38+ttUAcs2bdi2Wdz
   ku/5YagKqUGUT0Rka/Vz2QlCHLj3sIa/8i81DLz0XiQMh28jcm338DiFb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289474512"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289474512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="743432487"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2022 23:35:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHJar-000BEa-0o;
        Fri, 29 Jul 2022 06:35:29 +0000
Date:   Fri, 29 Jul 2022 14:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 3109920b3d95ebee86198757328eefe51f458b06
Message-ID: <62e37f77.X2YzH9qbG5BBPuo+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 3109920b3d95ebee86198757328eefe51f458b06  Merge branch 'for-5.20' into for-next

elapsed time: 723m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                          randconfig-a001
powerpc                          allmodconfig
i386                          randconfig-a003
i386                          randconfig-a005
sh                               allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a013
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220728
arm64                            allyesconfig
arm                              allyesconfig
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
ia64                          tiger_defconfig
microblaze                          defconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
alpha                               defconfig
m68k                        m5407c3_defconfig
powerpc                     taishan_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220728
hexagon              randconfig-r041-20220728
x86_64                        randconfig-a005
powerpc                      katmai_defconfig
arm                  colibri_pxa300_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
