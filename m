Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4737A5F3D1E
	for <lists+cgroups@lfdr.de>; Tue,  4 Oct 2022 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJDHTb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 03:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJDHTa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 03:19:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0441D32
        for <cgroups@vger.kernel.org>; Tue,  4 Oct 2022 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664867970; x=1696403970;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Dua2vkeJXhGD2pJC42kY/gAtbX8tYNywuN+EFBVnfbs=;
  b=jgIKnvarQYglAFh8SumrHxja2WGUxGf0nqcUp7lXXeDLrpl8J0edaCx1
   yAeABAVjydNeJgaEbYpy3Y7GLw5mMqkVGUXlMMkHPafMcX0KnDwNIpy3F
   ojmc5GYL0XJafZe+rlAd5JtQVFP32iV3i866mdm38Ct7VGefPNYrnqyWy
   f7GAEBi81+GyYbQkWCUjuVwUmgmkCipuBo+4idic+DGVJ1wzl/TWGmN/c
   t9WZC02uU6k0Tj2mt5nP+5UoKM4+LfvcjkLIihk2J72AF28cigyQQSygM
   dzkQH2t3FTeEJrkjD2pRhKHV691/NxdotwinN0z74wMVB5W2fJCxA6Vt3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="286037287"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="286037287"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 00:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="692385423"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="692385423"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2022 00:19:28 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofcD9-0005QT-1d;
        Tue, 04 Oct 2022 07:19:27 +0000
Date:   Tue, 04 Oct 2022 15:19:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-6.1] BUILD SUCCESS
 99996071fa0f2cbf22697f6e82014ecb15a53b2a
Message-ID: <633bde6d.XLJnwp9n9pOAEuvu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-6.1
branch HEAD: 99996071fa0f2cbf22697f6e82014ecb15a53b2a  Merge branch 'for-6.1' into test-merge-for-6.1

elapsed time: 743m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-syz
alpha                               defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                                defconfig
riscv                randconfig-r042-20221003
s390                             allyesconfig
arc                  randconfig-r043-20221003
s390                 randconfig-r044-20221003
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a015-20221003
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
i386                 randconfig-a016-20221003
m68k                             allmodconfig
i386                                defconfig
i386                 randconfig-a014-20221003
i386                 randconfig-a011-20221003
arc                              allyesconfig
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
alpha                            allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a016-20221003
arc                  randconfig-r043-20221002
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a006-20221003
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
