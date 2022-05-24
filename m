Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FC532ADF
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiEXNLn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 09:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiEXNLl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 09:11:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17A1A07A;
        Tue, 24 May 2022 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653397897; x=1684933897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DAhDI6GjyqETdXWl+Dy+y5irHu9wRTkAlq4aGCSkc28=;
  b=R8vWXP2K95iUDbXcZjo87ZXDMmrBT26Kjunn6t2tiE34n4e0+Hb0KAhf
   upEh4gnxhF4msqEdnIsfainf7vyWzE1P8T8cbQ0i8vzMiRcFqr3xXeu4M
   uuv7hqoaBVX3Sp6MAGC1o5eSM17KP5tn2Y3CnjiHkuRaAc+M5PywefR7L
   XckwthKborKJsXfRuDNClQBz78FNZ6ZuKouJliQPAFRbF7cgutYuIFgCf
   XLGFtwijQj2j0VRhhjWDrhm8ebEqFIaGbAAE/7WNlP3G+TotAGKKzAvLg
   klSWMYnXEJOZ49Bu+/J05KdFWfG9E5W5XrkWgjFegPR8Es7ri6tS4LxGb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="334172072"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="334172072"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="663904189"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 06:11:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntUJx-00024I-A5;
        Tue, 24 May 2022 13:11:33 +0000
Date:   Tue, 24 May 2022 21:10:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, Hezhongkun <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH] mm: memcontrol: add the mempolicy interface for cgroup
 v2.
Message-ID: <202205242108.pqUxw2OF-lkp@intel.com>
References: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi hezhongkun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18 next-20220524]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/hezhongkun/mm-memcontrol-add-the-mempolicy-interface-for-cgroup-v2/20220524-183922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 143a6252e1b8ab424b4b293512a97cca7295c182
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220524/202205242108.pqUxw2OF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6adb0a02c27c8811bee9783451ee25155baf490e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hezhongkun/mm-memcontrol-add-the-mempolicy-interface-for-cgroup-v2/20220524-183922
        git checkout 6adb0a02c27c8811bee9783451ee25155baf490e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> mm/mempolicy.c:179:19: warning: no previous prototype for 'get_cgrp_or_task_policy' [-Wmissing-prototypes]
     179 | struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   mm/mempolicy.c: In function 'get_cgrp_or_task_policy':
>> mm/mempolicy.c:182:36: error: implicit declaration of function 'mem_cgroup_from_task'; did you mean 'perf_cgroup_from_task'? [-Werror=implicit-function-declaration]
     182 |         struct mem_cgroup *memcg = mem_cgroup_from_task(p);
         |                                    ^~~~~~~~~~~~~~~~~~~~
         |                                    perf_cgroup_from_task
>> mm/mempolicy.c:182:36: warning: initialization of 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> mm/mempolicy.c:184:30: error: invalid use of undefined type 'struct mem_cgroup'
     184 |         pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
         |                              ^~
   mm/mempolicy.c:184:50: error: invalid use of undefined type 'struct mem_cgroup'
     184 |         pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
         |                                                  ^~
   mm/mempolicy.c: In function 'get_cgrp_or_vma_policy':
   mm/mempolicy.c:1799:36: warning: initialization of 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1799 |         struct mem_cgroup *memcg = mem_cgroup_from_task(current);
         |                                    ^~~~~~~~~~~~~~~~~~~~
   mm/mempolicy.c:1801:30: error: invalid use of undefined type 'struct mem_cgroup'
    1801 |         pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_vma_policy(vma, addr);
         |                              ^~
   mm/mempolicy.c:1801:50: error: invalid use of undefined type 'struct mem_cgroup'
    1801 |         pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_vma_policy(vma, addr);
         |                                                  ^~
   cc1: some warnings being treated as errors


vim +182 mm/mempolicy.c

   178	
 > 179	struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
   180	{
   181		struct mempolicy *pol;
 > 182		struct mem_cgroup *memcg = mem_cgroup_from_task(p);
   183	
 > 184		pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
   185		return pol;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
