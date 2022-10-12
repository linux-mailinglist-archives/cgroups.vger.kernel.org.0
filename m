Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30AA5FCCD5
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 23:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJLVN6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Oct 2022 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJLVN5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Oct 2022 17:13:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3495E114DEE
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665609237; x=1697145237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qZzua5PDKzEZ6e2jr/iS/AKZJ3Y7nnDsxgMA/rguTJw=;
  b=lmJMfHDAG6pgPYMW+NPYe+lFe5rP5gFLQ9GatIVYS8YCLoRWtvEzpchg
   MXCq8CKRG9advc9CJzEqXdIIVAXwwfeC+YPkKuMGVtMBf6e46+4Pd0UX2
   DtssnF8NbNtCr6vx6vdFztMRjdW4ImAv7qguBsRf+0bGat0x7PLaOfJGj
   1Mamxf2aP1dumjxReheH3L6Hl8NIn+jxHTbv/qJ0c+H5in13fWM2FdwFK
   rTLoAOofoRbcemwpYcDketAlXtAWVk6mDk8TNpNLvJvHa+/nzaNE1cWO2
   4qHudo+oE+QdGGYxOqd8RRVNwLyFZmCMYB/IQzknGM2QRmrD5DNGYCcrb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="369076060"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="369076060"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="955905377"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="955905377"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Oct 2022 14:13:55 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oij34-0004CB-1j;
        Wed, 12 Oct 2022 21:13:54 +0000
Date:   Thu, 13 Oct 2022 05:13:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 b675d4bdfefac2fd46838383ecb3c06ad0f4c94d
Message-ID: <63472e05.hqNnPVO5l4FeC+e3%lkp@intel.com>
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
branch HEAD: b675d4bdfefac2fd46838383ecb3c06ad0f4c94d  mm: cgroup: fix comments for get from fd/file helpers

elapsed time: 746m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a013
m68k                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a011
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
m68k                             allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
arc                  randconfig-r043-20221012
riscv                randconfig-r042-20221012
s390                                defconfig
i386                                defconfig
s390                 randconfig-r044-20221012
i386                          randconfig-a001
s390                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221012
hexagon              randconfig-r045-20221012
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
