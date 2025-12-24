Return-Path: <cgroups+bounces-12629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BCCCDB423
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68743028583
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C5326D6B;
	Wed, 24 Dec 2025 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErON+okC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A442EC55D;
	Wed, 24 Dec 2025 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766546863; cv=none; b=Oxy63lqXWusTYL+CXaivt22yMGqLphfHzNcPtNZC0qV8Vjazw81Ev36+atX4pSlJWkm4c+GNPU3mqojlAzva6llbB0xdp8d+8xt2/OVhP/TTOHbGs3eCDSf4FXU6fMV2aV6pF/pRsuRD39PQBZfuEn20i19gUW33IAbD1QGs7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766546863; c=relaxed/simple;
	bh=nA7u6gjpcNff6GD+HoSy6Nia4ZNz+eOojZUn1RsdchI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNik5mzMXoI4NblqLeWN2QcqpmJB6+rHqJoFCvY2rAbynkjT82bp4VYbA7MmVZemYA2fQQG0X/i1lvqaUvTiy9JTKvtvy30Y0LZ5HrOdU+2p1oDv9Z1yTEfFe7DHIY8w8Rhie14GsUcxEBSpbUOvN70SYzSQTnYAP+kERxK2AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErON+okC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766546861; x=1798082861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nA7u6gjpcNff6GD+HoSy6Nia4ZNz+eOojZUn1RsdchI=;
  b=ErON+okCR6O/B3u39bIauFJqOyAjhyjFcQzMnuNYu+Xx3wdjoJh3mh5f
   gzi543Pp0QsNVmAHOLitjubd5xL1PcCKZoaSLaFgnr789tTD09OfMjfnL
   B/DbroOT1xhGD1OAiN9qj3LwzSn+vE1D2ChuXyLx/gNHPceSuNfl/UIR6
   SoXCOe4Iwao1HmjYuIlWcRORwmOM/A+f/yk9Gqnz3XQahJtCyrR0FpIKP
   1g72Q7ySvDj/M94GleCX0xT10KW956C37HmdadhFV74dFDiyqppYjYrVw
   2y8jD4GGAQqZlNihOb6q1kpd9yb67meNjAGxTpbIEzg+/nvLHPH5DOZ/U
   Q==;
X-CSE-ConnectionGUID: g9TXbeylTrW8DHxWWy4S2g==
X-CSE-MsgGUID: bKoJPSHUT3yti360neYXMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="67585962"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="67585962"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 19:27:39 -0800
X-CSE-ConnectionGUID: Pb2VFdUITb2atK7bdBZXkw==
X-CSE-MsgGUID: i3pkqJNGQ8O7oBU6ueHwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="204993889"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 Dec 2025 19:27:37 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYFXC-000000002d7-39Xr;
	Wed, 24 Dec 2025 03:27:34 +0000
Date: Wed, 24 Dec 2025 11:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Tejun Heo <tj@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
Message-ID: <202512241151.JDZuy1z3-lkp@intel.com>
References: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>

Hi Pavel,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/cgroup-v2-freezer-allow-freezing-with-kthreads/20251223-182826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20251223102124.738818-4-ptikhomirov%40virtuozzo.com
patch subject: [PATCH 2/2] cgroup-v2/freezer: Print information about unfreezable process
config: sparc64-randconfig-002-20251224 (https://download.01.org/0day-ci/archive/20251224/202512241151.JDZuy1z3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512241151.JDZuy1z3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512241151.JDZuy1z3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cgroup/freezer.c:374:7: error: call to undeclared function 'try_get_task_stack'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     374 |         if (!try_get_task_stack(task))
         |              ^
   kernel/cgroup/freezer.c:374:7: note: did you mean 'tryget_task_struct'?
   include/linux/sched/task.h:120:35: note: 'tryget_task_struct' declared here
     120 | static inline struct task_struct *tryget_task_struct(struct task_struct *t)
         |                                   ^
>> kernel/cgroup/freezer.c:377:2: error: call to undeclared function 'put_task_stack'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     377 |         put_task_stack(task);
         |         ^
   kernel/cgroup/freezer.c:377:2: note: did you mean 'put_task_struct'?
   include/linux/sched/task.h:128:20: note: 'put_task_struct' declared here
     128 | static inline void put_task_struct(struct task_struct *t)
         |                    ^
   2 errors generated.


vim +/try_get_task_stack +374 kernel/cgroup/freezer.c

   357	
   358	static void warn_freeze_timeout_task(struct cgroup *cgrp, int timeout,
   359					     struct task_struct *task)
   360	{
   361		char *buf __free(kfree) = NULL;
   362		pid_t tgid;
   363	
   364		buf = kmalloc(PATH_MAX, GFP_KERNEL);
   365		if (!buf)
   366			return;
   367	
   368		if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
   369			return;
   370	
   371		tgid = task_pid_nr_ns(task, &init_pid_ns);
   372		pr_warn("Freeze of %s took %ld sec, due to unfreezable process %d:%s.\n",
   373			buf, timeout / USEC_PER_SEC, tgid, task->comm);
 > 374		if (!try_get_task_stack(task))
   375			return;
   376		show_stack(task, NULL, KERN_WARNING);
 > 377		put_task_stack(task);
   378	}
   379	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

