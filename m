Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7668D2B4
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 10:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBGJZF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 04:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjBGJZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 04:25:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66EFF
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675761900; x=1707297900;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tZeg7KmC9ygFNzgU2adpRB6vGpha/V8DpA5Cu+yDEHA=;
  b=j0c/C38MQgtSRYaKTAKPy6vTsjJnR593LyW1dJpY6x396Atu7l6D7x6q
   XCga4FE/be3JLtvEVPKkqXdSfgv6dGfu9yl+qwmAtbYhXb1wIddWh7tTb
   05sZtAkopiyqobONelSzMiE9R3YrGBnWqBQJRRzzZnh64eT9XB3JEiNYb
   3RVAiCJ2cUyvey/trblhMRklFshf0X/zXBq0joxmtBQ+cteub2s7RqZpn
   11K3JoiizPUDGPxYYvcy3TFGf6TypXs0goxyeY5hj6OabxZoYFKD8rawQ
   50D6sRay2dMY7FEH4XlvKv9Rb0WQxWoAW+yYHMPgKFR9BywLbmNDdjrf1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356829203"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="356829203"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 01:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="735487307"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="735487307"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2023 01:24:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPKDc-0003On-2O;
        Tue, 07 Feb 2023 09:24:52 +0000
Date:   Tue, 07 Feb 2023 17:24:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 14fffd51f9027fd393b3b074f11bc49c16fdf990
Message-ID: <63e218ba.SCYYyKVdnx2yT/JM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 14fffd51f9027fd393b3b074f11bc49c16fdf990  Merge branch 'for-6.2-fixes' into for-next

elapsed time: 729m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
m68k                             allmodconfig
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
m68k                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
ia64                             allmodconfig
s390                             allmodconfig
powerpc                           allnoconfig
s390                             allyesconfig
i386                 randconfig-a011-20230206
x86_64                           rhel-8.3-bpf
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a013-20230206
x86_64                           rhel-8.3-kvm
i386                 randconfig-a016-20230206
i386                 randconfig-a015-20230206
x86_64               randconfig-a014-20230206
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
sh                               allmodconfig
x86_64                              defconfig
mips                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20230204
arc                  randconfig-r043-20230204
arc                  randconfig-r043-20230206
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206
arm                                 defconfig
i386                                defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
arm                            mps2_defconfig
arm                           h3600_defconfig
m68k                       bvme6000_defconfig
arm                            xcep_defconfig
powerpc                       eiger_defconfig
powerpc                      ppc6xx_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206
hexagon              randconfig-r041-20230206
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230204
hexagon              randconfig-r045-20230206
powerpc                 mpc8315_rdb_defconfig
arm                         hackkit_defconfig
i386                              allnoconfig
powerpc                     akebono_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
