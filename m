Return-Path: <cgroups+bounces-6466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42460A2D42E
	for <lists+cgroups@lfdr.de>; Sat,  8 Feb 2025 06:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90E63AB6DE
	for <lists+cgroups@lfdr.de>; Sat,  8 Feb 2025 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE411A254C;
	Sat,  8 Feb 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNQyCJEY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887D192D76;
	Sat,  8 Feb 2025 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738993698; cv=none; b=OA1RS0155YYIgWgx/3PrdACp7s6NQN8L2kRseTu9Aqem84omUIH95oj5s0pAJuwHvY/5nQxnl8YztW9juygOSTXWnu11Bw+h67qtfJB7lVm2p3z5ZZwjcixn2ZlfWwkrlsGqRWULDRCWZbb6OJy0/g2W12b0noeSrDHRdyk/c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738993698; c=relaxed/simple;
	bh=/+xK94e+yjaY7pIU+ENGfoo6EpPjaPcXcfXS8xbIUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJCYQwQKXQaQll6xA+AkPqkEGGH0s+i9Vt9KRROBzqEMX34lyIz+KU13OVAzCKilqQR4JI57rCghhCc0bQ7dDuvW+XlujWvFtg0d5NgvNNdiZTMs/2RjE0ITBr8jrcrID6t8MQOFYirOwvpCQLWnHC0k2rOtdxDnhXhsEeEspSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNQyCJEY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738993697; x=1770529697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/+xK94e+yjaY7pIU+ENGfoo6EpPjaPcXcfXS8xbIUxY=;
  b=jNQyCJEYkZIrafra+y7HMU2/6wmYXRoqfpBMKabviDFmfJF2LdupvqVK
   z4PnILdathXy1LprFjtPt5ew9cK4AqncWRaFzvTiih9KXR5iwsPa5HM7x
   1PPmUpyswkpO+n+isdVjAnWNHFs3W+lkSjj1YjerpXcRdtASmBN9zT6sN
   kktN08xXznnyIVcIJoQiU72lDCkE752yNEJUXc0Op7RjCBnJGKEPVIGsu
   eHT6XR/6hwgQCxEjFBYvfuXvnSiIyvPyXp48UG5Nu2wnPR8J3ZjMuHDXf
   pC0x4+Rv4ZcCmLnk8qug5POA4cvuZWJ79ofSwBbhkrXEaDCpXARl8SmxS
   Q==;
X-CSE-ConnectionGUID: n1QVsGoeR56q0kn3bNYGYA==
X-CSE-MsgGUID: dL3SFRVBQmitS6PVfHDsAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="51028460"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="51028460"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 21:48:14 -0800
X-CSE-ConnectionGUID: +EAt0Cf+T5aw3Y22PjBv1g==
X-CSE-MsgGUID: H41t+OPjTw20gvwb7MPZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134955065"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Feb 2025 21:48:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgdhF-000zbV-0g;
	Sat, 08 Feb 2025 05:48:05 +0000
Date: Sat, 8 Feb 2025 13:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"(open list:CONTROL GROUP (CGROUP))" <cgroups@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Add run_delay accounting for cgroups
Message-ID: <202502081318.c9fYNNx8-lkp@intel.com>
References: <20250207041012.89192-3-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207041012.89192-3-wuyun.abel@bytedance.com>

Hi Abel,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on tip/sched/core akpm-mm/mm-everything linus/master v6.14-rc1 next-20250207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Wu/cgroup-rstat-Fix-forceidle-time-in-cpu-stat/20250207-121257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250207041012.89192-3-wuyun.abel%40bytedance.com
patch subject: [PATCH v3 2/2] cgroup/rstat: Add run_delay accounting for cgroups
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250208/202502081318.c9fYNNx8-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502081318.c9fYNNx8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502081318.c9fYNNx8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:19:
   In file included from include/linux/sched/isolation.h:5:
   In file included from include/linux/cpuset.h:17:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_policy.c:59:
>> kernel/sched/cputime.c:254:22: error: no member named 'rq_sched_info' in 'struct rq'
     254 |         return cpu_rq(cpu)->rq_sched_info.run_delay;
         |                ~~~~~~~~~~~  ^
   3 warnings and 1 error generated.


vim +254 kernel/sched/cputime.c

   251	
   252	u64 get_cpu_run_delay(int cpu)
   253	{
 > 254		return cpu_rq(cpu)->rq_sched_info.run_delay;
   255	}
   256	#endif
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

