Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24245FC05F
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJLF7k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Oct 2022 01:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJLF72 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Oct 2022 01:59:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E8ACA34
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 22:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665554364; x=1697090364;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FSmTMj7EKKSZu90bhrN2dE6B347/TX2bLtN2Z4e0N/g=;
  b=HhB5M8qItW4e9kDYvo56BWoTEOxapDUbXirQGPp2rguqT5wkMR6aGeV8
   C70EEDxUWS5gKGCbKNzPGHjHuALFc08MImZSAee5i+8SWRo++boDj6mPX
   k6ZjS/8nddHDB1Xufv0zXZRoaFBaR+RhyWdVtd0/w82Sds8WUt8YD7tMs
   WC2DEGuJrimU3sO2sGdmQzgMLvu8ee64ekW0LLuZSj3/TDdfGVnVuOeTO
   nh9iq/QJO0d0tF57KXfxfcb4LF+ow571Su/EafhoELk+J6fyekNnyBIPE
   soaMjMYeNnhnxEDghHO9uIM56HOLkJLGNu4miRlLttib+Zzz2mEHP3UUz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="331197145"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="331197145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 22:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="659811474"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="659811474"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2022 22:59:11 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiUlq-0003XT-2t;
        Wed, 12 Oct 2022 05:59:10 +0000
Date:   Wed, 12 Oct 2022 13:58:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS WITH WARNING
 8248fe413216732f98563e8882b6c6ae617c327b
Message-ID: <63465771.HuIMUTop7iDUWBQ9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: 8248fe413216732f98563e8882b6c6ae617c327b  perf stat: Support old kernels for bperf cgroup counting

Warning reports:

https://lore.kernel.org/lkml/202210120440.qmxr3KCs-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/cgroup/cgroup.c:6765: warning: expecting prototype for cgroup_get_from_fd(). Prototype was for cgroup_v1v2_get_from_fd() instead

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- alpha-randconfig-r026-20221012
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- loongarch-allyesconfig
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- m68k-allmodconfig
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- m68k-randconfig-r005-20221010
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- mips-allmodconfig
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- openrisc-randconfig-r023-20221012
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- powerpc-allmodconfig
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
|-- riscv-allyesconfig
|   `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead
`-- sparc-allyesconfig
    `-- kernel-cgroup-cgroup.c:warning:expecting-prototype-for-cgroup_get_from_fd().-Prototype-was-for-cgroup_v1v2_get_from_fd()-instead

elapsed time: 725m

configs tested: 64
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20221010
s390                                defconfig
riscv                randconfig-r042-20221010
arc                  randconfig-r043-20221010
x86_64                           allyesconfig
i386                 randconfig-a012-20221010
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64               randconfig-a011-20221010
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
i386                 randconfig-a011-20221010
arc                              allyesconfig
x86_64               randconfig-a014-20221010
x86_64               randconfig-a016-20221010
x86_64               randconfig-a015-20221010
m68k                             allmodconfig
x86_64               randconfig-a012-20221010
x86_64               randconfig-a013-20221010
i386                 randconfig-a013-20221010
i386                 randconfig-a014-20221010
ia64                             allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a015-20221010
mips                             allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
i386                 randconfig-a016-20221010
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig

clang tested configs:
i386                 randconfig-a003-20221010
i386                 randconfig-a004-20221010
hexagon              randconfig-r041-20221010
i386                 randconfig-a002-20221010
hexagon              randconfig-r045-20221010
i386                 randconfig-a005-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a006-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a005-20221010
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
