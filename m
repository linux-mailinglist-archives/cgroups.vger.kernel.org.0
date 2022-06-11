Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85B75473FA
	for <lists+cgroups@lfdr.de>; Sat, 11 Jun 2022 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiFKKyO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 11 Jun 2022 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiFKKyO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 11 Jun 2022 06:54:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED7EE02
        for <cgroups@vger.kernel.org>; Sat, 11 Jun 2022 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654944852; x=1686480852;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dMfi3JFqP/5HNTIVD1cl3zNvzANcKbIBmYyQT0IKXPM=;
  b=J5wDOQbui0dvaaW1aUfrLDUHOw097EorUHibNQyZxMT5X6NiY66WrNyp
   eHCOsGnjvMCI3p7aa0QCqlg+p78WHc0fPAJT9W7+smn+vbSp5NKNJQODm
   XDVwopwtOpItkDwVAf/xPM5kHO22RC0mRQnVMKXkEwlAgVavzM7pWqQd1
   iCV5s3lPqLGjRXBByZ6PjiDiIR+kV7yzvBZA5rY5TVzshxxb5ubEnkGMh
   a7nsotTHB05QM8OVu0bm7CAaEjSP+wVQypG4r1UwSaHMue8yZo3F9hO0J
   dfVqNwxpHKHoil+JHqoYkQTqxeLLkowtvd/z6h5W7twSJ4F1SCewjVBH3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="303246955"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="303246955"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 03:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="672318587"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2022 03:54:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzyks-000Ioz-OU;
        Sat, 11 Jun 2022 10:54:10 +0000
Date:   Sat, 11 Jun 2022 18:53:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 5f69a6577bc33d8f6d6bbe02bccdeb357b287f56
Message-ID: <62a4743f.sj9KOMk5GZYO0a1Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 5f69a6577bc33d8f6d6bbe02bccdeb357b287f56  psi: dont alloc memory for psi by default

elapsed time: 5373m

configs tested: 70
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                                 defconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                   debian-10.3-kselftests
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
i386                              debian-10.3
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a006
i386                          randconfig-a012
x86_64                        randconfig-a004
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
