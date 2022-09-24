Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C845E8F97
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiIXUND (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Sep 2022 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIXUNC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 24 Sep 2022 16:13:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDDE50539
        for <cgroups@vger.kernel.org>; Sat, 24 Sep 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664050382; x=1695586382;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U+bIEEkIfNCoeP/hr6ZQOjzkdg8ynhrDiqTk+PM9l0o=;
  b=P8PXCE4aYpMJw+yfXJ3xHgPmqJ58+Eegu1RCLTZXZ2S34HpU/pGEstQm
   XRcQUztrlo4k0ED3GnduB33PkEnxxMoEXCP7+ipHVh/D4z5D78D5SAjfa
   Vd5qjEQzmO4heHGj5C74iiSty1Yy27O93PcV5p4n318wccVuiu9ihPWW/
   vwMUNeCqGpiQ3BISvQ5QsR5rJtsVTfGq2J2vqnR8d2OpEVdOYlgHavu9P
   P7rTkjnn/9vvxIQSRwHVxJq155MEYcycnNm0f361LS5f5UVme6QwSmC5i
   5UhyrPh3SZDDFmvN+IOsCYFn+XEoW1a1e/S58qiQo+vlZWjJaabu5NiQS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="280531317"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="280531317"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 13:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="571754870"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2022 13:13:00 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocBWF-0006xh-2N;
        Sat, 24 Sep 2022 20:12:59 +0000
Date:   Sun, 25 Sep 2022 04:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 cdf56564f9fe3638407014a830f3c762d126d4bc
Message-ID: <632f64af.3IKw0Hdo/G2kPymG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
branch HEAD: cdf56564f9fe3638407014a830f3c762d126d4bc  Merge branch 'for-6.1' into for-next

elapsed time: 997m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
s390                                defconfig
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220923
x86_64                              defconfig
x86_64                           allyesconfig
s390                 randconfig-r044-20220923
arc                              allyesconfig
x86_64                               rhel-8.3
riscv                randconfig-r042-20220923
alpha                            allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a004
sh                               allmodconfig
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                                defconfig
x86_64                        randconfig-a006
arm                                 defconfig
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
arm                              allyesconfig
arm64                            allyesconfig
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
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
