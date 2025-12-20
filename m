Return-Path: <cgroups+bounces-12555-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D5CD37AB
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 22:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 508D93002E81
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 21:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97C2EC0B2;
	Sat, 20 Dec 2025 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j622IMLR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50351A3154;
	Sat, 20 Dec 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267397; cv=none; b=NCjVuofxyNUbgXVYoLFtjyZVhg/F9hquwxjeCoIkNWQ9VMl+zre0KnTNXyPKcNlUexrSDY0jsn/qLIn8sP6zM5mp+hoD0sngA2vIK7w/o16s8xd7bOguRFFfGbgVZj9wmEJ1imr1I40nnMJ7Ji57+vakfwwv1G56vfexfsWKIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267397; c=relaxed/simple;
	bh=p5MfNjz+/wJNYDsq5XB9RKtrRlUy9BblRhiK8tcu5I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGYOPDY+183zYs7Wqhcnw8p5eSkPUrNoeJ6LqLLNAD57EHe6fDt3wBiVS/uOrDizTnngX2qN/v6Pj8PWYVYUdAdquaQxMfmXVUN8EGj2svtvoC9ajMzH9+R7UIEL+q0jdfb2p//E4cw391dKVFvOsyxPSkPNrWaA/eGpjG+q/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j622IMLR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766267395; x=1797803395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5MfNjz+/wJNYDsq5XB9RKtrRlUy9BblRhiK8tcu5I0=;
  b=j622IMLR7KyLeACZ4jH8UvGIInaHSOEd38t0nqKgntu/4pYxBU5iPf/K
   p/Lw69n1T7zRvicgX5SOGHS5Hby2UagpnZsAwTnkXhYjX67leHqcw4SNd
   lPPol+dR3gqVLPBEDGwK8qyT1lyF8MG/DhyKDiCUybwH3ZY9H9c9ohQ4w
   CHDgnzeSfJgSUu+iBVEdf/7X/s0ujfoDJorO/Sc6L58bxXW6Z70u9kc0u
   yzX4sQf/uRYcKZqBbIJmK9NyNPRt+hs9+w+blBWyzNjXY6j1Hyw/0d2FF
   S6lye/tdRz2vCur34XUErREEw/Rxc+q3qc+eJ0rsRACxUhuLhdy3slkJ6
   Q==;
X-CSE-ConnectionGUID: ILbP2eevTnyz2eZqrHCj/A==
X-CSE-MsgGUID: iw0IUMj1R9CCBmuhidwiig==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="71818555"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="71818555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 13:49:54 -0800
X-CSE-ConnectionGUID: HA+sPQP0SAWiXeVfc3FElQ==
X-CSE-MsgGUID: jt+gQQj+TOmrkp7T1EFbrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="229832146"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Dec 2025 13:49:46 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX4pb-0000000059d-2H5N;
	Sat, 20 Dec 2025 21:49:43 +0000
Date: Sun, 21 Dec 2025 05:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Yu Kuai <yukuai@fnnas.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH 2/4] cgroup: Introduce cgroup_level() helper
Message-ID: <202512210532.ziNaxDJf-lkp@intel.com>
References: <20251217162744.352391-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217162744.352391-3-mkoutny@suse.com>

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Koutn/cgroup-Eliminate-cgrp_ancestor_storage-in-cgroup_root/20251218-004346
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20251217162744.352391-3-mkoutny%40suse.com
patch subject: [PATCH 2/4] cgroup: Introduce cgroup_level() helper
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210532.ziNaxDJf-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210532.ziNaxDJf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210532.ziNaxDJf-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   block/blk-iocost.c: In function 'ioc_pd_init':
>> block/blk-iocost.c:3006:60: error: expected ';' before 'for'
    3006 |         iocg->level = cgroup_level(blkg->blkcg->css.cgroup)
         |                                                            ^
         |                                                            ;
    3007 | 
    3008 |         for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
         |         ~~~                                                 
>> block/blk-iocost.c:2988:26: warning: unused variable 'tblkg' [-Wunused-variable]
    2988 |         struct blkcg_gq *tblkg;
         |                          ^~~~~


vim +3006 block/blk-iocost.c

  2981	
  2982	static void ioc_pd_init(struct blkg_policy_data *pd)
  2983	{
  2984		struct ioc_gq *iocg = pd_to_iocg(pd);
  2985		struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
  2986		struct ioc *ioc = q_to_ioc(blkg->q);
  2987		struct ioc_now now;
> 2988		struct blkcg_gq *tblkg;
  2989		unsigned long flags;
  2990	
  2991		ioc_now(ioc, &now);
  2992	
  2993		iocg->ioc = ioc;
  2994		atomic64_set(&iocg->vtime, now.vnow);
  2995		atomic64_set(&iocg->done_vtime, now.vnow);
  2996		atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
  2997		INIT_LIST_HEAD(&iocg->active_list);
  2998		INIT_LIST_HEAD(&iocg->walk_list);
  2999		INIT_LIST_HEAD(&iocg->surplus_list);
  3000		iocg->hweight_active = WEIGHT_ONE;
  3001		iocg->hweight_inuse = WEIGHT_ONE;
  3002	
  3003		init_waitqueue_head(&iocg->waitq);
  3004		hrtimer_setup(&iocg->waitq_timer, iocg_waitq_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
  3005	
> 3006		iocg->level = cgroup_level(blkg->blkcg->css.cgroup)
  3007	
  3008		for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
  3009			struct ioc_gq *tiocg = blkg_to_iocg(tblkg);
  3010			iocg->ancestors[tiocg->level] = tiocg;
  3011		}
  3012	
  3013		spin_lock_irqsave(&ioc->lock, flags);
  3014		weight_updated(iocg, &now);
  3015		spin_unlock_irqrestore(&ioc->lock, flags);
  3016	}
  3017	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

