Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B527E52FFB7
	for <lists+cgroups@lfdr.de>; Sun, 22 May 2022 00:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347004AbiEUWGG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 18:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347037AbiEUWF6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 18:05:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3DB871;
        Sat, 21 May 2022 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653170756; x=1684706756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6HTHMCVnQ4K4/esHmjURBt62rjHIzXzIoUJiVwHvEPE=;
  b=bAycBBqufeQoX4Un5PG3zttMzFWZzl45gK2ZF56YoK53Ba8aGJntFIT5
   UgfaQgh7q6MZ/EmoII7SHkgTUvbKzDWLtD82KZgShmuuUYX4NDE2wfbes
   Us1gz/301rWHCKKxdC0blnRdYtcS1L4VrhDSsZcIz9iCWqyiLORAHZhJH
   YRF9G3sxaAMr55uYx+rhih9k9lzLl21DBS8NzicpiynosLHNsIvXAHubU
   zbwTPGCkTMxUWTy4FGBscbMbg+9UWpW5LdpgoS2fY45mbYLuwmfM3elNy
   +FJ1oFV2IWB6RN/dtTsUibXqmG8lkVaY5CgnkG39jYYUYs91930EIN1CG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="260499936"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="260499936"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 15:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="716081444"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2022 15:05:53 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsXEO-0006e2-Ka;
        Sat, 21 May 2022 22:05:52 +0000
Date:   Sun, 22 May 2022 06:05:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasily Averin <vvs@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 6/9] memcg: enable accounting for percpu allocation
 of struct cgroup_rstat_cpu
Message-ID: <202205220531.AVnBFrgq-lkp@intel.com>
References: <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Vasily,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tj-cgroup/for-next driver-core/driver-core-testing linus/master v5.18-rc7 next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasily-Averin/memcg-enable-accounting-for-struct-cgroup/20220522-004124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 991d8d8142cad94f9c5c05db25e67fa83d6f772a
config: arm-imxrt_defconfig (https://download.01.org/0day-ci/archive/20220522/202205220531.AVnBFrgq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c1b7edf1635aaef50d25ba8246a5e5c997a6bf44
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vasily-Averin/memcg-enable-accounting-for-struct-cgroup/20220522-004124
        git checkout c1b7edf1635aaef50d25ba8246a5e5c997a6bf44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/cgroup/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/cgroup/rstat.c: In function 'cgroup_rstat_init':
>> kernel/cgroup/rstat.c:261:70: error: macro "alloc_percpu_gfp" requires 2 arguments, but only 1 given
     261 |                                                    GFP_KERNEL_ACCOUNT);
         |                                                                      ^
   In file included from include/linux/hrtimer.h:19,
                    from include/linux/sched.h:19,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   include/linux/percpu.h:133: note: macro "alloc_percpu_gfp" defined here
     133 | #define alloc_percpu_gfp(type, gfp)                                     \
         | 
>> kernel/cgroup/rstat.c:260:35: error: 'alloc_percpu_gfp' undeclared (first use in this function)
     260 |                 cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu
         |                                   ^~~~~~~~~~~~~~~~
   kernel/cgroup/rstat.c:260:35: note: each undeclared identifier is reported only once for each function it appears in


vim +/alloc_percpu_gfp +261 kernel/cgroup/rstat.c

   253	
   254	int cgroup_rstat_init(struct cgroup *cgrp)
   255	{
   256		int cpu;
   257	
   258		/* the root cgrp has rstat_cpu preallocated */
   259		if (!cgrp->rstat_cpu) {
 > 260			cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu
 > 261							   GFP_KERNEL_ACCOUNT);
   262			if (!cgrp->rstat_cpu)
   263				return -ENOMEM;
   264		}
   265	
   266		/* ->updated_children list is self terminated */
   267		for_each_possible_cpu(cpu) {
   268			struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
   269	
   270			rstatc->updated_children = cgrp;
   271			u64_stats_init(&rstatc->bsync);
   272		}
   273	
   274		return 0;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
