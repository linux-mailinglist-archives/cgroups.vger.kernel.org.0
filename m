Return-Path: <cgroups+bounces-8557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B746ADCBB4
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F5C3AF25F
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BE2D12F6;
	Tue, 17 Jun 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G25B1B90"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7E28C5D2;
	Tue, 17 Jun 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163972; cv=none; b=JQkplmAVk1Li7yhG0FZh3LdbCNWdW9b//wH1IRxl1+CXSKkhxP7f3PaVZlDQDJmRzWmDHD68kaXOiVwPuEiNIpE5Hr6zqPFBqjoNRRlSAIV0eqDfAG8BUCZrjrJ35MDwAOq+WSCVIkbQqlEGYNJMjKuRZp4TRbojP2O/P74Wd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163972; c=relaxed/simple;
	bh=zILH5TNoJc5zMvfEscKNBmXmXTpPOoWuuNaoGP3L7SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJrtXiawxz2XRxMzlCFVEVfESUP+Zmosl/YfmkhNTchLGci7eUNevLcq3pcg+/AkozXZ+EaoE6eQKm0SNi8J6WcDA3N4VEJqFzP+zmCqkY0LBL5czqJss+Jwd7AqKNebITda8o9TZWwD2/mxz2SkS+uMqA3prH/65A0bBrZir0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G25B1B90; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750163971; x=1781699971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zILH5TNoJc5zMvfEscKNBmXmXTpPOoWuuNaoGP3L7SU=;
  b=G25B1B90mnopF5rhe4L1KzG0oBAg9qofRQJVn34iG6lEGUc5fgbsre1E
   KyNZnjVghU8FDxOQnQNOez9cWtoseFUBgUt4HgtDCiaPaUdlUHDKrD4LJ
   8fTqmW6ftmb8liGOhUQmCBmuzq3MPB1YvY98kLDn4zC1egzB14HXekaTI
   qP/1gaXbX2f9nw11g2LkyzYjirOxlJ71hgdvmkLPsTyCoDy9teYSzNJbX
   TqQtWquM6UriNxB2BFC46QvLdw0QZwWqa2ainNrZsv6SmIbJSwJ1AvVML
   1BuXzYaKGGxrw1S3eEsEf9cw9DyKGUimQYLPHx+c4YaEKafM7CYIaZLg9
   w==;
X-CSE-ConnectionGUID: 3dR3esYETMaW661Tl4qT8A==
X-CSE-MsgGUID: +jtyI4a9TlqZjdKR6OMEqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63694597"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="63694597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 05:39:30 -0700
X-CSE-ConnectionGUID: uE5B/mTYToyjA3wyKB/qQA==
X-CSE-MsgGUID: 9C9Sa59nQemNZDhh9ZWPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="179640279"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Jun 2025 05:39:28 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRVb3-000FyM-2Q;
	Tue, 17 Jun 2025 12:39:25 +0000
Date: Tue, 17 Jun 2025 20:38:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Subject: Re: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <202506172020.kFkGyrEE-lkp@intel.com>
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>

Hi Bertrand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on linus/master v6.16-rc2 next-20250617]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bertrand-Wlodarczyk/cgroup-rstat-change-cgroup_base_stat-to-atomic/20250617-183242
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250617102644.752201-2-bertrand.wlodarczyk%40intel.com
patch subject: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
config: arc-randconfig-001-20250617 (https://download.01.org/0day-ci/archive/20250617/202506172020.kFkGyrEE-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250617/202506172020.kFkGyrEE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506172020.kFkGyrEE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/rstat.c: In function 'css_rstat_init':
>> kernel/cgroup/rstat.c:415:55: warning: variable 'rstatbc' set but not used [-Wunused-but-set-variable]
     415 |                         struct cgroup_rstat_base_cpu *rstatbc;
         |                                                       ^~~~~~~
   kernel/cgroup/rstat.c: In function 'root_cgroup_cputime':
   kernel/cgroup/rstat.c:629:42: error: passing argument 2 of 'atomic64_add' from incompatible pointer type [-Werror=incompatible-pointer-types]
     629 |                 atomic64_add(sys + user, &cputime->sum_exec_runtime);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:67,
                    from include/linux/thread_info.h:27,
                    from include/linux/sched.h:14,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   include/linux/atomic/atomic-instrumented.h:1680:33: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
    1680 | atomic64_add(s64 i, atomic64_t *v)
         |                     ~~~~~~~~~~~~^
   In file included from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:2209,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   kernel/cgroup/rstat.c: In function 'cgroup_base_stat_cputime_show':
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   kernel/cgroup/rstat.c:677:9: note: in expansion of macro 'do_div'
     677 |         do_div(utime, NSEC_PER_USEC);
         |         ^~~~~~
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   kernel/cgroup/rstat.c:681:9: note: in expansion of macro 'do_div'
     681 |         do_div(stime, NSEC_PER_USEC);
         |         ^~~~~~
   include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
     183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   kernel/cgroup/rstat.c:685:9: note: in expansion of macro 'do_div'
     685 |         do_div(ntime, NSEC_PER_USEC);
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +/rstatbc +415 kernel/cgroup/rstat.c

a17556f8d9798e Tejun Heo 2018-04-26  380  
a97915559f5c5f JP Kobryn 2025-04-03  381  int css_rstat_init(struct cgroup_subsys_state *css)
a17556f8d9798e Tejun Heo 2018-04-26  382  {
a97915559f5c5f JP Kobryn 2025-04-03  383  	struct cgroup *cgrp = css->cgroup;
a17556f8d9798e Tejun Heo 2018-04-26  384  	int cpu;
5da3bfa029d680 JP Kobryn 2025-05-14  385  	bool is_self = css_is_self(css);
a17556f8d9798e Tejun Heo 2018-04-26  386  
5da3bfa029d680 JP Kobryn 2025-05-14  387  	if (is_self) {
5da3bfa029d680 JP Kobryn 2025-05-14  388  		/* the root cgrp has rstat_base_cpu preallocated */
5da3bfa029d680 JP Kobryn 2025-05-14  389  		if (!cgrp->rstat_base_cpu) {
5da3bfa029d680 JP Kobryn 2025-05-14  390  			cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
5da3bfa029d680 JP Kobryn 2025-05-14  391  			if (!cgrp->rstat_base_cpu)
a17556f8d9798e Tejun Heo 2018-04-26  392  				return -ENOMEM;
a17556f8d9798e Tejun Heo 2018-04-26  393  		}
5da3bfa029d680 JP Kobryn 2025-05-14  394  	} else if (css->ss->css_rstat_flush == NULL)
5da3bfa029d680 JP Kobryn 2025-05-14  395  		return 0;
5da3bfa029d680 JP Kobryn 2025-05-14  396  
5da3bfa029d680 JP Kobryn 2025-05-14  397  	/* the root cgrp's self css has rstat_cpu preallocated */
5da3bfa029d680 JP Kobryn 2025-05-14  398  	if (!css->rstat_cpu) {
5da3bfa029d680 JP Kobryn 2025-05-14  399  		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
5da3bfa029d680 JP Kobryn 2025-05-14  400  		if (!css->rstat_cpu) {
5da3bfa029d680 JP Kobryn 2025-05-14  401  			if (is_self)
5da3bfa029d680 JP Kobryn 2025-05-14  402  				free_percpu(cgrp->rstat_base_cpu);
a17556f8d9798e Tejun Heo 2018-04-26  403  
f6e9a26e2d488c JP Kobryn 2025-04-03  404  			return -ENOMEM;
f6e9a26e2d488c JP Kobryn 2025-04-03  405  		}
f6e9a26e2d488c JP Kobryn 2025-04-03  406  	}
f6e9a26e2d488c JP Kobryn 2025-04-03  407  
a17556f8d9798e Tejun Heo 2018-04-26  408  	/* ->updated_children list is self terminated */
a17556f8d9798e Tejun Heo 2018-04-26  409  	for_each_possible_cpu(cpu) {
5da3bfa029d680 JP Kobryn 2025-05-14  410  		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
5da3bfa029d680 JP Kobryn 2025-05-14  411  
5da3bfa029d680 JP Kobryn 2025-05-14  412  		rstatc->updated_children = css;
a17556f8d9798e Tejun Heo 2018-04-26  413  
5da3bfa029d680 JP Kobryn 2025-05-14  414  		if (is_self) {
5da3bfa029d680 JP Kobryn 2025-05-14 @415  			struct cgroup_rstat_base_cpu *rstatbc;
5da3bfa029d680 JP Kobryn 2025-05-14  416  
5da3bfa029d680 JP Kobryn 2025-05-14  417  			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
a17556f8d9798e Tejun Heo 2018-04-26  418  		}
5da3bfa029d680 JP Kobryn 2025-05-14  419  	}
a17556f8d9798e Tejun Heo 2018-04-26  420  
a17556f8d9798e Tejun Heo 2018-04-26  421  	return 0;
a17556f8d9798e Tejun Heo 2018-04-26  422  }
a17556f8d9798e Tejun Heo 2018-04-26  423  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

