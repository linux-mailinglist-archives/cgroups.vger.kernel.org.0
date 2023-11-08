Return-Path: <cgroups+bounces-252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108297E5FA5
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 22:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194311C20AC3
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED16374CB;
	Wed,  8 Nov 2023 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqmKSTtA"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59F374C3;
	Wed,  8 Nov 2023 21:07:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D772584;
	Wed,  8 Nov 2023 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699477671; x=1731013671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b6UoMOuB9Vc+Ox/xONoBAd6Z0ZkA6LvZweCBIByPU6I=;
  b=nqmKSTtAyx8uO4rUfxYFejL31VoPgsoctzN6L8G7dviVAm3EnfNRwIVT
   KYcdiRX5Ykm+SlF5RhC1z7EAI5Q01JE0DPS8jvEqgcHMPc2GQkr3Ub+An
   MHoHi43vI+SbWqls0FLHhX7Y5EeRXa0qT1FkJeboe9GryiS8AUyscxnSN
   2ViWTYUifmMuIqSYL5E9ldOX1BzyENYLFPFbjQ3wBQ4rBxVdh2TCuC0MQ
   jqibnyHcbnwAdrNElXMgTgte0kOVY5vbHzGiFFWsz5c3zMAJTxJAjfctt
   NZBwzSjXhyxT3cIwgwIXrpd3qvuIVE+I9L769d14HmkuphLBwSyZrI62D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="392735140"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="392735140"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 13:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756665102"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="756665102"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2023 13:07:44 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0pm1-0008Bo-21;
	Wed, 08 Nov 2023 21:07:41 +0000
Date: Thu, 9 Nov 2023 05:06:47 +0800
From: kernel test robot <lkp@intel.com>
To: Huan Yang <link@vivo.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>, Peter Xu <peterx@redhat.com>,
	Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: Re: [PATCH 4/4] mm: memcg: apply proactive reclaim into cgroupv1
Message-ID: <202311090446.NKFRnuGv-lkp@intel.com>
References: <20231108065818.19932-5-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108065818.19932-5-link@vivo.com>

Hi Huan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tj-cgroup/for-next linus/master v6.6 next-20231108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huan-Yang/mm-vmscan-LRU-unbalance-cgroup-reclaim/20231108-151757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231108065818.19932-5-link%40vivo.com
patch subject: [PATCH 4/4] mm: memcg: apply proactive reclaim into cgroupv1
reproduce: (https://download.01.org/0day-ci/archive/20231109/202311090446.NKFRnuGv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090446.NKFRnuGv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/cgroup-v1/memory.rst:93: WARNING: Malformed table.
>> Documentation/admin-guide/cgroup-v1/memory.rst:977: WARNING: Title underline too short.

vim +93 Documentation/admin-guide/cgroup-v1/memory.rst

    62	
    63	==================================== ==========================================
    64	 tasks				     attach a task(thread) and show list of
    65					     threads
    66	 cgroup.procs			     show list of processes
    67	 cgroup.event_control		     an interface for event_fd()
    68					     This knob is not available on CONFIG_PREEMPT_RT systems.
    69	 memory.usage_in_bytes		     show current usage for memory
    70					     (See 5.5 for details)
    71	 memory.memsw.usage_in_bytes	     show current usage for memory+Swap
    72					     (See 5.5 for details)
    73	 memory.limit_in_bytes		     set/show limit of memory usage
    74	 memory.memsw.limit_in_bytes	     set/show limit of memory+Swap usage
    75	 memory.failcnt			     show the number of memory usage hits limits
    76	 memory.memsw.failcnt		     show the number of memory+Swap hits limits
    77	 memory.max_usage_in_bytes	     show max memory usage recorded
    78	 memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
    79	 memory.soft_limit_in_bytes	     set/show soft limit of memory usage
    80					     This knob is not available on CONFIG_PREEMPT_RT systems.
    81	 memory.stat			     show various statistics
    82	 memory.use_hierarchy		     set/show hierarchical account enabled
    83	                                     This knob is deprecated and shouldn't be
    84	                                     used.
    85	 memory.force_empty		     trigger forced page reclaim
    86	 memory.pressure_level		     set memory pressure notifications
    87	 memory.swappiness		     set/show swappiness parameter of vmscan
    88					     (See sysctl's vm.swappiness)
    89	 memory.move_charge_at_immigrate     set/show controls of moving charges
    90	                                     This knob is deprecated and shouldn't be
    91	                                     used.
    92	 memory.oom_control		     set/show oom controls.
  > 93	 memory.memory		     proactive reclaim.
    94	 memory.numa_stat		     show the number of memory usage per numa
    95					     node
    96	 memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
    97	                                     memory hard limit. Kernel hard limit is not
    98	                                     supported since 5.16. Writing any value to
    99	                                     do file will not have any effect same as if
   100	                                     nokmem kernel parameter was specified.
   101	                                     Kernel memory is still charged and reported
   102	                                     by memory.kmem.usage_in_bytes.
   103	 memory.kmem.usage_in_bytes          show current kernel memory allocation
   104	 memory.kmem.failcnt                 show the number of kernel memory usage
   105					     hits limits
   106	 memory.kmem.max_usage_in_bytes      show max kernel memory usage recorded
   107	
   108	 memory.kmem.tcp.limit_in_bytes      set/show hard limit for tcp buf memory
   109	 memory.kmem.tcp.usage_in_bytes      show current tcp buf memory allocation
   110	 memory.kmem.tcp.failcnt             show the number of tcp buf memory usage
   111					     hits limits
   112	 memory.kmem.tcp.max_usage_in_bytes  show max tcp buf memory usage recorded
   113	==================================== ==========================================
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

