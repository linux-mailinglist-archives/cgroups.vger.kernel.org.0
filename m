Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9156F64A702
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiLLSYd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 13:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiLLSY1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 13:24:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067310B59
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670869412; x=1702405412;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Je6X+s01mDoT2Sf7Kwx1QyNMCpd9G+wHiFeag94YT4Y=;
  b=QlGrbi58tdRMY3jNuiXp/H3EOaVOkVXhT/8A4LtFSYxpbNBfXHT/ikna
   jPLCxUYvWM6pISN/905MxaG6uWrc1hun2bGIFoOx2/k+YRsoui9tNHRB+
   ohJe7phwE0ACrN/g2T8TlBFEg54sh9ZN/FNshwjTc96R78HkiqX+RrJEG
   M9/LTgwEm+ISc4k/9wvEkSqoWuh+2xNyUQHQALgsc1d/6oDgf8wV8aDvY
   HAYVlGO6It3cGScTw4RmcftKYqKkGLNhEiYkTD7jBX62UUfYM0Fe4qPF/
   WFUoIK1gEDJ+6a9GSgDLd6rbArDX4Rs9KPgRfZf3rD+H1nZesxCfcNX2D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316626069"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="316626069"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 10:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="755048809"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="755048809"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2022 10:23:30 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4nSc-0003qt-0X;
        Mon, 12 Dec 2022 18:23:30 +0000
Date:   Tue, 13 Dec 2022 02:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:test-merge-for-6.2] BUILD SUCCESS
 2d9b8d3cdccefbe671c36772bae76c1f0192c3de
Message-ID: <63977191.wvtuRWB8Cv3ECZnE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git test-merge-for-6.2
branch HEAD: 2d9b8d3cdccefbe671c36772bae76c1f0192c3de  Merge branch 'for-6.2' into test-merge-for-6.2

elapsed time: 725m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
i386                 randconfig-a013-20221212
i386                 randconfig-a014-20221212
x86_64                            allnoconfig
i386                 randconfig-a012-20221212
x86_64                              defconfig
i386                 randconfig-a011-20221212
s390                             allmodconfig
x86_64                           rhel-8.3-bpf
i386                                defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
i386                 randconfig-a015-20221212
s390                                defconfig
i386                 randconfig-a016-20221212
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64                          rhel-8.3-rust
m68k                             allmodconfig
x86_64               randconfig-a012-20221212
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64               randconfig-a014-20221212
x86_64               randconfig-a013-20221212
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a011-20221212
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20221212
x86_64                          rhel-8.3-func
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221212
arm64                            allyesconfig
x86_64               randconfig-a016-20221212
arm                              allyesconfig
sh                               allmodconfig
i386                             allyesconfig
arc                  randconfig-r043-20221211
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221212
arm                  randconfig-r046-20221211
i386                          randconfig-c001
s390                 randconfig-r044-20221212
powerpc                 mpc837x_mds_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc40x_defconfig
xtensa                              defconfig
m68k                           sun3_defconfig
sparc                               defconfig
powerpc                         wii_defconfig
nios2                         10m50_defconfig
nios2                               defconfig
mips                          rb532_defconfig
m68k                         amcore_defconfig
arm                            hisi_defconfig
arm                         lpc18xx_defconfig
arm                            xcep_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
sh                        edosk7760_defconfig
arc                            hsdk_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc8540_ads_defconfig
sh                             espt_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      pcm030_defconfig
powerpc                mpc7448_hpc2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a002-20221212
i386                 randconfig-a003-20221212
i386                 randconfig-a001-20221212
x86_64               randconfig-a002-20221212
i386                 randconfig-a004-20221212
x86_64               randconfig-a001-20221212
i386                 randconfig-a006-20221212
x86_64               randconfig-a004-20221212
i386                 randconfig-a005-20221212
x86_64               randconfig-a003-20221212
x86_64               randconfig-a006-20221212
arm                  randconfig-r046-20221212
x86_64               randconfig-a005-20221212
riscv                randconfig-r042-20221211
hexagon              randconfig-r045-20221211
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221212
s390                 randconfig-r044-20221211
hexagon              randconfig-r041-20221212
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
