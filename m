Return-Path: <cgroups+bounces-12553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D6CD315B
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 593D23002533
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5942DF122;
	Sat, 20 Dec 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SA8zPB/F"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556D2D94A9;
	Sat, 20 Dec 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766242821; cv=none; b=rPQyw+ADIFGiBYRgKKtboSWnKDZRlk1xENHtUzaMh8zlbwLPq9O3ZdzVIUgtmgV9oC+S/DMYH/GRs1i5zd+uSHwqJS/xq2M6Pgy8M/pxhYAczMxdKZPolDtDIH3TLAxWJK36Vx9LSHXXiTE3cwXBmussnQveCnKU1MxOXmALvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766242821; c=relaxed/simple;
	bh=nAnK3wG0RXziPz7E4YON0DH/0jR4RzGtYIeGV6e9eM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9toDTl2u+4CTdrJXyIdhCQVTi+Mu010kQlXa7yy2qMWwzYEJFNFBbWQWvSjweq7K4iEVCswkozTPj8iMV8k0eYgXrBLCaco+I9WZRrHykSgHd+M2afzpFig8OYaNiluC1Qs8aV6VoH54LhnziE4CIlO8bFdVtaZCXZXTL18M3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SA8zPB/F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766242820; x=1797778820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nAnK3wG0RXziPz7E4YON0DH/0jR4RzGtYIeGV6e9eM4=;
  b=SA8zPB/F25dXNfUQWSddSWwq9NYRdSspS6vv0u/f4B4V6GwQxFVZaSO4
   AxQ8brZ6lU8Okj2p//7NBoKr5TT2sOU8g2eQoX0Xecxub9n2d/PoV/vMd
   vYbPTHJTDDuqwT8IhE2ela1zehRlftJUmyJsGXtFUZTAQc2lW0jrzSJQk
   uW+GiPIWgAhJuNjY2winYYFdw0El1XnP4ELFFmJUvq1mkmoZCsbkaIAHN
   xrRjZ46sHG70D6UdgWeaqVhmiQUSjX3u+CNc0oGYD6NTf1+sGviE5CeqC
   p4OD4WnTQciVt8mlfb/kGI9lXebn80hLl1bgZfQwLA6xOlrRod5kbWN9+
   w==;
X-CSE-ConnectionGUID: FIIq50q7Tv6dWGyn1brQCg==
X-CSE-MsgGUID: iYoF0BeXQKiuxSB0xilDrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="72034868"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="72034868"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:00:19 -0800
X-CSE-ConnectionGUID: eWNAbC0nRfCspnSKssnnHQ==
X-CSE-MsgGUID: YNbLtCx4Tp+NnLAk2qHUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="198359996"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Dec 2025 07:00:12 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWyRF-000000004hZ-0SYh;
	Sat, 20 Dec 2025 15:00:09 +0000
Date: Sat, 20 Dec 2025 22:59:32 +0800
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
Message-ID: <202512202230.1uoB5chV-lkp@intel.com>
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
config: sparc64-randconfig-r134-20251218 (https://download.01.org/0day-ci/archive/20251220/202512202230.1uoB5chV-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202230.1uoB5chV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202230.1uoB5chV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-iocost.c:3006:53: error: expected ';' after expression
    3006 |         iocg->level = cgroup_level(blkg->blkcg->css.cgroup)
         |                                                            ^
         |                                                            ;
   1 error generated.


vim +3006 block/blk-iocost.c

  2981	
  2982	static void ioc_pd_init(struct blkg_policy_data *pd)
  2983	{
  2984		struct ioc_gq *iocg = pd_to_iocg(pd);
  2985		struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
  2986		struct ioc *ioc = q_to_ioc(blkg->q);
  2987		struct ioc_now now;
  2988		struct blkcg_gq *tblkg;
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

