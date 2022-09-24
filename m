Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C541F5E8F90
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 21:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIXTy5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Sep 2022 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIXTy4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 24 Sep 2022 15:54:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC5913CC5
        for <cgroups@vger.kernel.org>; Sat, 24 Sep 2022 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664049295; x=1695585295;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=O0R0FiEG4FP7J+K98C0IyrgS0VpqWjwZzP/fC0s/q0o=;
  b=Lnu3gVQ5b7/CN6tCOBnD0iq37bCakRmnXCvNj0hBTHu0LY+kXIfohSMg
   H0pT6fY1KW0771mJ6vtSTX8cN+oMPYMUSAfCSIEUFUI5CKW0w/i0yNL7B
   maQaJNy1IEC0XNCI+YD6sLt1l2qWAppL5wNf0EOhaKP9h4X0bgM4PyL65
   xBB/rIIgJB9rZ5+AeoeJkP1IBBmZrciNHo6fRa+A5jcvQ6aLacv2g9Kcc
   TQkYeIjpNBwZXwueFuhfI3Ik5yEUGpgAQm78OOoWvBm3O7H9uFgk/W2bq
   wsSdTSWHyP7vcchlee4pInpFLeCGHx+oXS2q2agvTvRpo95jGd54KJKyD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="362629565"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="362629565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 12:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="653789774"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2022 12:54:53 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocBEi-0006ww-1b;
        Sat, 24 Sep 2022 19:54:52 +0000
Date:   Sun, 25 Sep 2022 03:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.1] BUILD SUCCESS
 b74440d89895816660236be4433f0891e37d44eb
Message-ID: <632f605a.cnBa0LmDhXlAn4LY%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.1
branch HEAD: b74440d89895816660236be4433f0891e37d44eb  iocost_monitor: reorder BlkgIterator

elapsed time: 979m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20220923
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
s390                 randconfig-r044-20220923
x86_64                        randconfig-a006
riscv                randconfig-r042-20220923
x86_64                        randconfig-a011
m68k                             allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                                defconfig
x86_64                        randconfig-a015
i386                          randconfig-a003
arc                              allyesconfig
arm                                 defconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a005
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220925
s390                 randconfig-r044-20220925
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
hexagon              randconfig-r045-20220923
hexagon              randconfig-r041-20220923
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
