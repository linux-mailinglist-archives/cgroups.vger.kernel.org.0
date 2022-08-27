Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572A35A36D2
	for <lists+cgroups@lfdr.de>; Sat, 27 Aug 2022 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiH0J7z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Aug 2022 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiH0J7y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Aug 2022 05:59:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53EB63
        for <cgroups@vger.kernel.org>; Sat, 27 Aug 2022 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661594391; x=1693130391;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Jor5C3RZvzsBklkN5ewnq75cKZenDzHrI/wkmCzUFcQ=;
  b=jCqx4sRPa/C2HUDI7oWW3gq6YXQWrruCOn4pW69u0At5UIwuugJcl7KR
   aHKXIcQdjSDBl6ASdcaKa4FfzZFUtK7Po+5KIe4UcJ6EKNjW9SRApGlTP
   OYP0IwWE+ntuMa/qepcrvMOwvWLYscWglqJzv3tCvRlXaO1FSMRzm5wq/
   dcigOBvf2aPvDn8R0hSGPFSPx65uh0erRWWEzja5W5+1ZcBcwL2xmvvCN
   xCMT/OgAJRE/kAJjJdR8xPkeO48byK1KLMLtBHG+n7GspE7cqYTKfqd8V
   p+yQKRZCJ0TFkOwTVJ8Kdzu9EcHLwJdeFBpuB8VyWiSN84ILCzZ7eobhE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281619120"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="281619120"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 02:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="679126399"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2022 02:59:49 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRsbV-00003v-01;
        Sat, 27 Aug 2022 09:59:49 +0000
Date:   Sat, 27 Aug 2022 17:58:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.1] BUILD SUCCESS
 075b593f54f0f3883532cb750081cae6917bc8fe
Message-ID: <6309ead8.s3jshyFq93JAfvDI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.1
branch HEAD: 075b593f54f0f3883532cb750081cae6917bc8fe  cgroup: Use cgroup_attach_{lock,unlock}() from cgroup_attach_task_all()

elapsed time: 723m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
arc                                 defconfig
um                             i386_defconfig
loongarch                         allnoconfig
um                           x86_64_defconfig
alpha                               defconfig
loongarch                           defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
powerpc                           allnoconfig
i386                          randconfig-a014
x86_64                              defconfig
x86_64                        randconfig-a015
i386                          randconfig-a012
m68k                             allmodconfig
i386                             allyesconfig
i386                          randconfig-a016
powerpc                          allmodconfig
arc                              allyesconfig
sh                               allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
arm                                 defconfig
x86_64                        randconfig-a002
s390                                defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
nios2                               defconfig
x86_64                        randconfig-a004
m68k                             allyesconfig
nios2                            allyesconfig
x86_64                           allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
parisc64                            defconfig
x86_64                         rhel-8.3-kunit
parisc                              defconfig
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
parisc                           allyesconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20220824
riscv                randconfig-r042-20220824
s390                 randconfig-r044-20220824
ia64                             allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                            allmodconfig
powerpc                          allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          rsk7203_defconfig
parisc                generic-32bit_defconfig
arm                            xcep_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
riscv                randconfig-r042-20220826
s390                 randconfig-r044-20220826
arc                  randconfig-r043-20220826
arc                  randconfig-r043-20220825
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220827
riscv                randconfig-r042-20220827
hexagon              randconfig-r041-20220827
s390                 randconfig-r044-20220827
powerpc                      obs600_defconfig
arm                                 defconfig
arm                         bcm2835_defconfig
arm                           sama7_defconfig
riscv                            alldefconfig
arm                         mv78xx0_defconfig
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220825
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220823
hexagon              randconfig-r041-20220825
s390                 randconfig-r044-20220825
s390                 randconfig-r044-20220823

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
