Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F065FB99
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 07:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjAFGtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 01:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAFGty (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 01:49:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5A6EC83
        for <cgroups@vger.kernel.org>; Thu,  5 Jan 2023 22:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672987793; x=1704523793;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oQQNlW233skbq3EJwlwoMPlwJ/s4JIGZDq3ttf0iuRs=;
  b=kJXcaJ4N+eJKGLvV1jmez4vGqg8mEEdsu8HXk5TBxs5gtoCEwBrUrAl9
   pvkKWLuj5ZB+ho4e/3wbsSmI2axPqbOFvEHnoN40Ck3Q2HELypKnIe/tn
   e3VOWpduuHXW4PjThRcOiXyn7w2bgIHnF5ZOG9pFcFEKVM7qkjdvClKtO
   jFvBp2Qh1EhulBLsdyOOmAe8p/mFatpgqSH1UNhyuLn9keoSN4YYJLrGK
   AsHiq1pZZomrwbNVsDXwXsMio9qU1QyfOtwXvsCw5mH/TXvqZcXvDudJb
   6+idaKl4oAgSCkJTs/PvS3clQLzkdyBOmX46ETRcVW9vqhOFTDoZ/HF8g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="386871523"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="386871523"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 22:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605822120"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="605822120"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2023 22:49:51 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDgY2-00035M-0i;
        Fri, 06 Jan 2023 06:49:50 +0000
Date:   Fri, 06 Jan 2023 14:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Subject: [tj-cgroup:for-next] BUILD SUCCESS
 980660cae7994ab03b31b2a32940c70e8421fc99
Message-ID: <63b7c464.ZOXle8Ow7lBDtrz6%lkp@intel.com>
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
branch HEAD: 980660cae7994ab03b31b2a32940c70e8421fc99  docs: cgroup-v1: use numbered lists for user interface setup

elapsed time: 729m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
x86_64                            allnoconfig
s390                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
s390                 randconfig-r044-20230105
sh                               allmodconfig
s390                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20230105
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
i386                          randconfig-a005
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20230105
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
arm                                 defconfig
ia64                             allmodconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
arm                  randconfig-r046-20230105
hexagon              randconfig-r045-20230105
hexagon              randconfig-r041-20230105
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a012

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
