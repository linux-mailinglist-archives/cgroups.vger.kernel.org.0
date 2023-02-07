Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9568D2B3
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBGJZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 04:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjBGJZA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 04:25:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4C103
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675761899; x=1707297899;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OQnVfL3U0a2lX1wg31o5Rh9wwEzGnW1Dn3J+rQW84eE=;
  b=AkWmEzwK+PM0zdU7CTm0+kuySGdoLx203/MCbzjDBb7jRYaH9IddP2sA
   h7S6YR+FGYnhmxUb2GRB4MQX6LWERe9NZrXrDW4IJAFZxFOnhmGhogfW5
   N4Vq1QDqeCmKKEwHlMeiC98P8snWj3YgIOtkqtTrsDS3Cu11oeDdZOyzV
   Ji6lcg9sdwu/MbhNk7BLpulIE7sE59oCkMA7Dcg7xIwaQuDAgquHn0vME
   ZCKwMqUoe2y6NeXNAv7QET9OJZ9xu5tlfhAyCa7IAE9w3NqTI8ZLrTOlm
   MjE/iDMLAbVZ1ePnOmaSM4KvAAPeNOFnKZpOeL8DKi9h8b2ajYT6jV4JG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356829201"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="356829201"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 01:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="735487306"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="735487306"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2023 01:24:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPKDc-0003Ol-2K;
        Tue, 07 Feb 2023 09:24:52 +0000
Date:   Tue, 07 Feb 2023 17:24:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-6.2-fixes] BUILD SUCCESS
 7a2127e66a00e073db8d90f9aac308f4a8a64226
Message-ID: <63e218be.rts7KrRWUOS7E2nR%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.2-fixes
branch HEAD: 7a2127e66a00e073db8d90f9aac308f4a8a64226  cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task

elapsed time: 729m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64               randconfig-a014-20230206
alpha                            allyesconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a015-20230206
ia64                             allmodconfig
x86_64               randconfig-a012-20230206
x86_64               randconfig-a016-20230206
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230205
x86_64                              defconfig
arm                  randconfig-r046-20230205
i386                 randconfig-a011-20230206
arc                  randconfig-r043-20230206
i386                 randconfig-a014-20230206
x86_64                               rhel-8.3
i386                 randconfig-a012-20230206
x86_64                           allyesconfig
riscv                randconfig-r042-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                                defconfig
sh                               allmodconfig
mips                           jazz_defconfig
sh                          r7780mp_defconfig
um                               alldefconfig
xtensa                  nommu_kc705_defconfig
m68k                         amcore_defconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                          atari_defconfig
sh                         ap325rxa_defconfig
sh                           se7705_defconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
hexagon              randconfig-r041-20230205
i386                 randconfig-a002-20230206
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
i386                 randconfig-a004-20230206
hexagon              randconfig-r041-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a006-20230206
i386                 randconfig-a005-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
powerpc                      ppc44x_defconfig
hexagon                             defconfig
powerpc                      obs600_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
