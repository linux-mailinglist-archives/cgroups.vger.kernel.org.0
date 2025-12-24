Return-Path: <cgroups+bounces-12631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF453CDB547
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 05:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF0983022490
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77A329C41;
	Wed, 24 Dec 2025 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1rqss/u"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F322328600;
	Wed, 24 Dec 2025 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550533; cv=none; b=o/HDOdmYh+W5DdYRRJ4Dhv1Fi9BVU3orGXt0D5efqUDcTTZOTZeI7smE4cBFREDdnkvoHJXugvgAp2/fzJFy7f2dJ5cbWGyXSfQAFttQmdyg9aXSiuedjURHkj/51b8g9GChZPsrQbT6Ee+cPBYFa7c/L2LiV1OTLvyetlwMrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550533; c=relaxed/simple;
	bh=tPiWJ1qOPpAdLCRMXmRnKkf27N/SE5ckemAkPYk1rO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuHjghnn/tNfYsUeaq7hmt5d3Tfg4gMt4druXjKqZhJGM7fDGJiNN1GxadMtCblCacLhgE42pn1oh4WqflI4qE9Ev9fIUy4OXt5xTZgX+MHyIF7m7yhlR8aLYdQqc+7a50kMt6igTG1OvuJ6J4fNg8F9gMtt0LkgLixIHpV865E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1rqss/u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766550531; x=1798086531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPiWJ1qOPpAdLCRMXmRnKkf27N/SE5ckemAkPYk1rO4=;
  b=A1rqss/ujsUi694Mq68J+I7r1zoKY5OiOKwIFX+crIxOusRbWOvxxhc9
   eI7Yjb6gA69GCbYgT1F67NMdgh6vXWDK6Sl9w3IJ0U9e3eU3gkJ5jYl7v
   O8Y98z4kD2eP77uKMqAKXAOZcWluE+KsDRc7EwsYUiJVzGWOHP7oo1PyO
   2k8dFzgMdnAGbkl9lNTTIoz1qCSf+Oy4k2xYIpb8UFIgiBOkLDRbtxYt7
   Hlvo+wWKq3jQwpd4OwedLEgJZ7ywVjw5OJv5Pbnb5QpgvCmfleC+0Z+eZ
   x1RfeR0VrJytUUBBZ7xoEySFA2QUOgwfDOfOZ2EYxRsIfn958/WTgxkc+
   w==;
X-CSE-ConnectionGUID: WdmHEgBiTvOfR4eYEYURrQ==
X-CSE-MsgGUID: 1TgbJNurRBy49Z6G6t51zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="70974261"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="70974261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 20:28:51 -0800
X-CSE-ConnectionGUID: VrfUAIozQxmXPwuuM2h2/g==
X-CSE-MsgGUID: CuZUL9r7SIeY3noXw8lfiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="199689484"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 23 Dec 2025 20:28:49 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYGUQ-0000000066q-2MMP;
	Wed, 24 Dec 2025 04:28:46 +0000
Date: Wed, 24 Dec 2025 05:28:08 +0100
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
Message-ID: <202512240512.qCx1CzKN-lkp@intel.com>
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
[also build test ERROR on next-20251219]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/cgroup-v2-freezer-allow-freezing-with-kthreads/20251223-182826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20251223102124.738818-4-ptikhomirov%40virtuozzo.com
patch subject: [PATCH 2/2] cgroup-v2/freezer: Print information about unfreezable process
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251224/202512240512.qCx1CzKN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240512.qCx1CzKN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240512.qCx1CzKN-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/freezer.c: In function 'warn_freeze_timeout_task':
>> kernel/cgroup/freezer.c:374:14: error: implicit declaration of function 'try_get_task_stack'; did you mean 'tryget_task_struct'? [-Wimplicit-function-declaration]
     374 |         if (!try_get_task_stack(task))
         |              ^~~~~~~~~~~~~~~~~~
         |              tryget_task_struct
>> kernel/cgroup/freezer.c:377:9: error: implicit declaration of function 'put_task_stack'; did you mean 'put_task_struct'? [-Wimplicit-function-declaration]
     377 |         put_task_stack(task);
         |         ^~~~~~~~~~~~~~
         |         put_task_struct


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

