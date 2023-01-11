Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861A665911
	for <lists+cgroups@lfdr.de>; Wed, 11 Jan 2023 11:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjAKKc5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 05:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjAKKc4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 05:32:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680432019
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673433176; x=1704969176;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VweBvKjHJD+r5ZR2MO5op5fuxLWkKhRPAyTdeyT7nFc=;
  b=fvz9ngN1hN1IN8m10z0ToLKtY1cjmVM5pyzSO2Pn5ql86dvMZ/BJyjRU
   qkkxdxG7M1Pb/CDDqU/ergRhq8RPNlqxKK27ycLFbvfM+wpN4s5LXsr3C
   vsA3mjn+E2JIwDiiAbBvMn1ISzApvUojzbRk5HYX65eXnzaa0YrARo4cj
   Hv4LHdDma6lx/21/UA/AnQgpHaWKfwoOl/SycHBu0YI2waqY3qRAxY33L
   RGqlzuUyl+Xbfxylu+UFQdCkb7VxBDmBaNho6Rj4Cz78M62PDY3Fr+qLF
   Ki6MkHg7DSR5lwbRK7hfeFBdfnS1K1QUuZybOn0v3am8K0Ch/JzbdhaM1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350610280"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350610280"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 02:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687889050"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687889050"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jan 2023 02:32:53 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFYPb-00090y-1x;
        Wed, 11 Jan 2023 10:32:51 +0000
Date:   Wed, 11 Jan 2023 18:32:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 32a47817d07557ffca9992964c514fd79bda6fba
Message-ID: <63be9022.dV2GuG+zKzioP4xX%lkp@intel.com>
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
branch HEAD: 32a47817d07557ffca9992964c514fd79bda6fba  cgroup/cpuset: fix a few kernel-doc warnings & coding style

elapsed time: 720m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20230110
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a003
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012

clang tested configs:
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
hexagon              randconfig-r041-20230110
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
riscv                randconfig-r042-20230111
s390                 randconfig-r044-20230111
hexagon              randconfig-r041-20230111
hexagon              randconfig-r045-20230111
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
