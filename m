Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32385532CCC
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiEXPDQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbiEXPDQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 11:03:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05908AE6B;
        Tue, 24 May 2022 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653404594; x=1684940594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NAtbRL6rOJ7RfXXVkiq9+gyiENENpvBI07+NLn2VSMw=;
  b=c1bdDpux4Sfd5IHYdQSdQ6WSYVmHxybh9l3M+Iv7qA60wduzv0tOOUJC
   xi8TmqJaSms+vB4NcKwAObmfHm/exAnNwiT/cIdqXnMvJwxli8Yyk8xQu
   ipuZKvxDillUdqPaf4/RKCpKl90YbNrO7U0R9uLdH4owUnEjNzx7B3CqQ
   8q1RPsfhaOKy0quVQxl4id6MtOkTh//yGhz+K/9/T3X/1/pznW90uKfx4
   vvy2qGbNx9P3h5yO8KSzQqwa5apcjDaBBVT/ZB/V3Ks07MbhAcrFUApGd
   icgC4/5shiNYySbTlaOtKSywNAJ0yKX/q16yMQR1zZbsbJPDQ9VofzhNE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273280997"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273280997"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 08:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="559147778"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2022 08:03:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntW3z-0002A2-9L;
        Tue, 24 May 2022 15:03:11 +0000
Date:   Tue, 24 May 2022 23:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     hezhongkun <hezhongkun.hzk@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        Hezhongkun <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH] mm: memcontrol: add the mempolicy interface for cgroup
 v2.
Message-ID: <202205242200.VGAUIGvw-lkp@intel.com>
References: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220524/202205242200.VGAUIGvw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6adb0a02c27c8811bee9783451ee25155baf490e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hezhongkun/mm-memcontrol-add-the-mempolicy-interface-for-cgroup-v2/20220524-183922
        git checkout 6adb0a02c27c8811bee9783451ee25155baf490e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> mm/mempolicy.c:182:29: error: call to undeclared function 'mem_cgroup_from_task'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct mem_cgroup *memcg = mem_cgroup_from_task(p);
                                      ^
   mm/mempolicy.c:182:29: note: did you mean 'mem_cgroup_from_css'?
   include/linux/memcontrol.h:1267:20: note: 'mem_cgroup_from_css' declared here
   struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
                      ^
>> mm/mempolicy.c:182:21: warning: incompatible integer to pointer conversion initializing 'struct mem_cgroup *' with an expression of type 'int' [-Wint-conversion]
           struct mem_cgroup *memcg = mem_cgroup_from_task(p);
                              ^       ~~~~~~~~~~~~~~~~~~~~~~~
>> mm/mempolicy.c:184:23: error: incomplete definition of type 'struct mem_cgroup'
           pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
                           ~~~~~^
   include/linux/mm_types.h:31:8: note: forward declaration of 'struct mem_cgroup'
   struct mem_cgroup;
          ^
   mm/mempolicy.c:184:43: error: incomplete definition of type 'struct mem_cgroup'
           pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_task_policy(p);
                                               ~~~~~^
   include/linux/mm_types.h:31:8: note: forward declaration of 'struct mem_cgroup'
   struct mem_cgroup;
          ^
   mm/mempolicy.c:179:19: warning: no previous prototype for function 'get_cgrp_or_task_policy' [-Wmissing-prototypes]
   struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
                     ^
   mm/mempolicy.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
   ^
   static 
   mm/mempolicy.c:1799:29: error: call to undeclared function 'mem_cgroup_from_task'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct mem_cgroup *memcg = mem_cgroup_from_task(current);
                                      ^
   mm/mempolicy.c:1799:21: warning: incompatible integer to pointer conversion initializing 'struct mem_cgroup *' with an expression of type 'int' [-Wint-conversion]
           struct mem_cgroup *memcg = mem_cgroup_from_task(current);
                              ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/mempolicy.c:1801:23: error: incomplete definition of type 'struct mem_cgroup'
           pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_vma_policy(vma, addr);
                           ~~~~~^
   include/linux/mm_types.h:31:8: note: forward declaration of 'struct mem_cgroup'
   struct mem_cgroup;
          ^
   mm/mempolicy.c:1801:43: error: incomplete definition of type 'struct mem_cgroup'
           pol = (memcg && memcg->mempolicy) ? memcg->mempolicy : get_vma_policy(vma, addr);
                                               ~~~~~^
   include/linux/mm_types.h:31:8: note: forward declaration of 'struct mem_cgroup'
   struct mem_cgroup;
          ^
   3 warnings and 6 errors generated.


vim +/mem_cgroup_from_task +182 mm/mempolicy.c

   178	
   179	struct mempolicy *get_cgrp_or_task_policy(struct task_struct *p)
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
