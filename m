Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ECF65E90F
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 11:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjAEKeg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 05:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjAEKeR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 05:34:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3332EA6
        for <cgroups@vger.kernel.org>; Thu,  5 Jan 2023 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672914706; x=1704450706;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p//dgkXaSRaAXYrWVLyuFQT8CV14x392E80VhZ3qB5A=;
  b=k+PBM7gEKZ7ggvweniU7a0flNeAlFDjini7YD4vI20g2eBLC2Mpzfx4i
   8VXM2FP7/WK8s9TIlv3sAgWTU3xMdPY2Z2QjU/s0reyXsFxJOYZl+9CKA
   oBgDcD3poaIyGCGAMJtkPij7y1n2Y3Nk55NopMZssZJxDgCHJGMapFdT5
   Yh/kWwD72D6QYhEa0V2T0NNQ8lp0mMv5PPEZdgpAc1swKcdH5htnpPWxL
   oy6lDTFNf9E0V+VYK3bOc0dMjeEg7EPXZWQGAtkZ5TC7P2+XG9tUYJ/+Y
   B26CEf7p5o4WD7o34ldbp1vdHpCAfHe3fs+VtGp1Yo5sfItYcccdP+wtp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="384464548"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="384464548"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657469556"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="657469556"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jan 2023 02:31:44 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDNXE-0001Xb-01;
        Thu, 05 Jan 2023 10:31:44 +0000
Date:   Thu, 05 Jan 2023 18:31:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 21786e5cb375a1e58a9175fee423e1d7f892d965
Message-ID: <63b6a6f2.kedxrqkA4mpMHNvR%lkp@intel.com>
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
branch HEAD: 21786e5cb375a1e58a9175fee423e1d7f892d965  cgroup/cpuset: no need to explicitly init a global static variable

elapsed time: 724m

configs tested: 54
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
i386                 randconfig-a005-20230102
x86_64                              defconfig
i386                 randconfig-a006-20230102
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a003-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a005-20230102
x86_64               randconfig-a006-20230102
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a006
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
