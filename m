Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C606268AE77
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 06:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBEFsR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 00:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEFsQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 00:48:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CE222EE;
        Sat,  4 Feb 2023 21:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675576095; x=1707112095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iEw0zlMttW4+qyyZlq9G8QxHxm7XJTMCir7vrzAuEcs=;
  b=Ryd1yiqrDN1wP5nWzz2s/cxmTqD9mIKgqjcG28pJdhNh6eJTCnu4xRkN
   xG9LiDmKg/Fdlha9hhsNaPMrR10Cf8vT8lHfLP1LOpbXFU5GmvP7gkR/3
   eHoNi8mheJ46T73rHXX28j8whY6OUflHls9EYwBq+YQcshA6nwuMKNCVv
   EMSZJH5D7NuBs2ZIo0uefPPLuEk5ZVmVAJNVRqS6ekPIjZJ0h9yYg9Y+V
   QmGPH8DeG1jv1IttRTe8NisjwngZoDhWGYr1symHfPVWosoW9rTHXbGFE
   CiHMXBUcwznjhLNZVVQ5CvlNNuetAiBMykLSz7c+QXsHhOkt1Es2W+58C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="317023737"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="317023737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 21:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="696544694"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="696544694"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2023 21:48:09 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOXsn-0001lo-0V;
        Sun, 05 Feb 2023 05:48:09 +0000
Date:   Sun, 5 Feb 2023 13:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Frederic Weisbecker <frederic@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <202302051316.1kdX7ylk-lkp@intel.com>
References: <20230203232409.163847-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203232409.163847-3-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Frederic,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on horms-ipvs-next/master horms-ipvs/master linus/master v6.2-rc6 next-20230203]
[cannot apply to paulmck-rcu/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frederic-Weisbecker/sched-isolation-Merge-individual-nohz_full-features-into-a-common-housekeeping-flag/20230204-072510
patch link:    https://lore.kernel.org/r/20230203232409.163847-3-frederic%40kernel.org
patch subject: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20230205/202302051316.1kdX7ylk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/89596a035dc10e00cb66d4e75e49d69b75413807
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Frederic-Weisbecker/sched-isolation-Merge-individual-nohz_full-features-into-a-common-housekeeping-flag/20230204-072510
        git checkout 89596a035dc10e00cb66d4e75e49d69b75413807
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pci/pci-driver.c:15:
>> include/linux/sched/isolation.h:58:10: error: implicit declaration of function 'housekeeping_test_cpu' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
                   ^
   include/linux/sched/isolation.h:58:10: note: did you mean 'housekeeping_any_cpu'?
   include/linux/sched/isolation.h:27:19: note: 'housekeeping_any_cpu' declared here
   static inline int housekeeping_any_cpu(enum hk_type type)
                     ^
   1 error generated.
--
   In file included from kernel/sched/fair.c:38:
>> include/linux/sched/isolation.h:58:10: error: implicit declaration of function 'housekeeping_test_cpu' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
                   ^
   include/linux/sched/isolation.h:58:10: note: did you mean 'housekeeping_any_cpu'?
   include/linux/sched/isolation.h:27:19: note: 'housekeeping_any_cpu' declared here
   static inline int housekeeping_any_cpu(enum hk_type type)
                     ^
   kernel/sched/fair.c:688:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]
   int sched_update_scaling(void)
       ^
   kernel/sched/fair.c:688:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_update_scaling(void)
   ^
   static 
   1 warning and 1 error generated.


vim +/housekeeping_test_cpu +58 include/linux/sched/isolation.h

    55	
    56	static inline bool cpu_is_isolated(int cpu)
    57	{
  > 58		return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
    59			 !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE);
    60	}
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
