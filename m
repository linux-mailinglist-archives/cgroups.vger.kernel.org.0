Return-Path: <cgroups+bounces-12616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A791CDAA92
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 22:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A17303974C
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 20:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A430FC15;
	Tue, 23 Dec 2025 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1FLaU+I"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC3211A05;
	Tue, 23 Dec 2025 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523569; cv=none; b=lH7Ac0H8DyGfxNqVBwUuGuPI6u5TrFrEL2iUYqDV2HOqLNtY/Y3cuUX5Q+8LJ1wIwD0taqB5xQHajj3bdk+uHlMeIGbm912eNWbLrE2MIDdc9MRo+xmaPwdXJTSLmNggcPXgClJuLu9b4NYKMGY0+x5HHgT1qP2hOX76Ld0YYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523569; c=relaxed/simple;
	bh=WFi7cvhAPiPh/XR+92Qqh6vdtwN3HsAQzlz22Tp190A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsKtelhCaM9H6Bt8ZRGpLUyJ/EpuxPvPSsRuV4gKiM+z5MT3+7cgBdHe0w66dKsgIfWwll8iPs6WxCW2f1wVG3oYihk8fP7DVpVotPa0tAI/SlLH4okdcs8jKkwU7IOpV8U/rc256I4+hoMTFR+RUh6yOUKUVKNbmzh2XOhlPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1FLaU+I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766523567; x=1798059567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFi7cvhAPiPh/XR+92Qqh6vdtwN3HsAQzlz22Tp190A=;
  b=D1FLaU+IoRZpmeTdsv3H1Vgt5JBFMTFy4yuCJkdJfBz3AJRCNyX3UarN
   FmQSrF1AqC31JV83Ej0cioDQnVD3v3oY3UPqqDl7B8zCBhxDKbVf553OD
   NSBctp0a/ev5xQFRngVQC/7bGqFE3ljyOPF0AqYKmk8BTjGKkycITb1cx
   1ASX4NLz99DvwFb3TYuvJTZA9OmV1oJW0HqGwyJr621qRCljXvFBL5XIh
   QmmDmUuy84ONuymSg9rNbGfFC1XPeu4p9nsVzVI/sp1aWu9Lz6Qe742Dc
   a5uhgU4KZVvTqdPQPHmulC8+woHOlZB4o0JjnKe6yFmZLk8RR0WwAYi9V
   g==;
X-CSE-ConnectionGUID: 4dnyDQfKRMG0/hfNstKIig==
X-CSE-MsgGUID: ty10qx5eSquB6mx8oHH96A==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68415523"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="68415523"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 12:59:26 -0800
X-CSE-ConnectionGUID: dDDoQCVvRCCDHIFDxhpvxg==
X-CSE-MsgGUID: kzgOIQu/SqCJ7OoAlAsY/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="199105678"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Dec 2025 12:59:25 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY9TV-000000002N7-2fPV;
	Tue, 23 Dec 2025 20:59:21 +0000
Date: Wed, 24 Dec 2025 04:58:39 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
Message-ID: <202512240409.06R0khaZ-lkp@intel.com>
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
config: s390-randconfig-r071-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240409.06R0khaZ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240409.06R0khaZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240409.06R0khaZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/freezer.c: In function 'warn_freeze_timeout_task':
>> kernel/cgroup/freezer.c:374:7: error: implicit declaration of function 'try_get_task_stack'; did you mean 'tryget_task_struct'? [-Werror=implicit-function-declaration]
     if (!try_get_task_stack(task))
          ^~~~~~~~~~~~~~~~~~
          tryget_task_struct
>> kernel/cgroup/freezer.c:377:2: error: implicit declaration of function 'put_task_stack'; did you mean 'put_task_struct'? [-Werror=implicit-function-declaration]
     put_task_stack(task);
     ^~~~~~~~~~~~~~
     put_task_struct
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=y]
   Selected by [y]:
   - CAN [=y] && NET [=y]


vim +374 kernel/cgroup/freezer.c

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

