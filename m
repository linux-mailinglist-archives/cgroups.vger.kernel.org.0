Return-Path: <cgroups+bounces-9743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0CB45893
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3731C883E0
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF11D5CC9;
	Fri,  5 Sep 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n95GwHw7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8461C5D4B;
	Fri,  5 Sep 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078301; cv=none; b=k8NLQd5qTlPj4B/i2GwQ36UGq8XBgN/8B88ByyD/g8Y91pmoJ2tcLjlkMNtWUfogQMjy6bovVXwUnjufO2wWuM17vCMroI307O3ioMGfIXsueYArYWW6GBe6XXyJWmmyLPQYXFIaGC2JAsGs736bXq17NYpkQ0aowK0U25cr83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078301; c=relaxed/simple;
	bh=HHJV0tl8h7ZJtN1tdfZD7llAJ5LamlTFFDGb/7EvYOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFbVjPzouDKOD3A3TIFI7op9b0vDmsSLlc2Pvtmmmjcls8BHQLCxj8AIX5DnBXzVpm8et0cCwWs9YeIRtqCZGEedfS0XB+mHgddS6Uni6lzF2Zp3mbY+8V6oGJvwkwNik6Fg2NMwPAak/0yvUWdGfcadoJhhPS8/+cRRaoPa9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n95GwHw7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757078300; x=1788614300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHJV0tl8h7ZJtN1tdfZD7llAJ5LamlTFFDGb/7EvYOQ=;
  b=n95GwHw7dhHsnCnLeLNJ8et0N8awdOu+HG/0NAsIVCRxnlD0tCNGkfJw
   wY2/RqdMOfqc4iYu+ZJrMhMZFJfj+tXzmU4Wg3oM3JgX4qWivOrJiizGg
   9fVS5nA6ub5tPWIAFKQuGQvws4XnO2AUzgIBYbJStF8l9BPx+9kAIJNJl
   X4ROIp+tX4KQGdMcceJKm/CVC9NOHqylMAwfYwWcuw3J0beNB7XB36XLX
   mvsyUmK6AGjtUCXlsm0RjHTJfHE979ifmsOBV/MF8F60YIo/DwCRz1+SB
   yKxdTaSRKqyo2yabwkObDDxJA+ByyGYy9S2Kv72M1pim7kVKty/2Ud7Cg
   g==;
X-CSE-ConnectionGUID: ya0ZOYB2QhqTJhfkghJhyg==
X-CSE-MsgGUID: yeA+VDk4T+iYvQ1J1bt+2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82021616"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82021616"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:18:19 -0700
X-CSE-ConnectionGUID: kYszwXuYS2yQlrsxhQccpw==
X-CSE-MsgGUID: 8dZHDGHwRMCY2zPALp+dTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="176499606"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2025 06:18:17 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuWKV-0000RX-1l;
	Fri, 05 Sep 2025 13:18:15 +0000
Date: Fri, 5 Sep 2025 21:17:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Tao <escape@linux.alibaba.com>, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <202509052150.4GQ04PJn-lkp@intel.com>
References: <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>

Hi Yi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on kees/for-next/execve akpm-mm/mm-everything tip/sched/core linus/master v6.17-rc4]
[cannot apply to next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Tao/cgroup-replace-global-percpu_rwsem-with-signal_struct-group_rwsem-when-writing-cgroup-procs-threads/20250904-194505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape%40linux.alibaba.com
patch subject: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with signal_struct->group_rwsem when writing cgroup.procs/threads
config: i386-buildonly-randconfig-004-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052150.4GQ04PJn-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052150.4GQ04PJn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052150.4GQ04PJn-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/cgroup.c: In function 'cgroup_attach_lock':
>> kernel/cgroup/cgroup.c:2511:28: error: 'favor_dynmods' undeclared (first use in this function); did you mean 'Opt_favordynmods'?
    2511 |                 if (tsk && favor_dynmods)
         |                            ^~~~~~~~~~~~~
         |                            Opt_favordynmods
   kernel/cgroup/cgroup.c:2511:28: note: each undeclared identifier is reported only once for each function it appears in
   kernel/cgroup/cgroup.c: In function 'cgroup_attach_unlock':
   kernel/cgroup/cgroup.c:2526:28: error: 'favor_dynmods' undeclared (first use in this function); did you mean 'Opt_favordynmods'?
    2526 |                 if (tsk && favor_dynmods)
         |                            ^~~~~~~~~~~~~
         |                            Opt_favordynmods


vim +2511 kernel/cgroup/cgroup.c

  2482	
  2483	/**
  2484	 * cgroup_attach_lock - Lock for ->attach()
  2485	 * @tsk: thread group to lock
  2486	 * @lock_threadgroup: whether to down_write rwsem
  2487	 *
  2488	 * cgroup migration sometimes needs to stabilize threadgroups against forks and
  2489	 * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
  2490	 * implementations (e.g. cpuset), also need to disable CPU hotplug.
  2491	 * Unfortunately, letting ->attach() operations acquire cpus_read_lock() can
  2492	 * lead to deadlocks.
  2493	 *
  2494	 * Bringing up a CPU may involve creating and destroying tasks which requires
  2495	 * read-locking threadgroup_rwsem, so threadgroup_rwsem nests inside
  2496	 * cpus_read_lock(). If we call an ->attach() which acquires the cpus lock while
  2497	 * write-locking threadgroup_rwsem, the locking order is reversed and we end up
  2498	 * waiting for an on-going CPU hotplug operation which in turn is waiting for
  2499	 * the threadgroup_rwsem to be released to create new tasks. For more details:
  2500	 *
  2501	 *   http://lkml.kernel.org/r/20220711174629.uehfmqegcwn2lqzu@wubuntu
  2502	 *
  2503	 * Resolve the situation by always acquiring cpus_read_lock() before optionally
  2504	 * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  2505	 * CPU hotplug is disabled on entry.
  2506	 */
  2507	void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup)
  2508	{
  2509		cpus_read_lock();
  2510		if (lock_threadgroup) {
> 2511			if (tsk && favor_dynmods)
  2512				down_write(&tsk->signal->group_rwsem);
  2513			else
  2514				percpu_down_write(&cgroup_threadgroup_rwsem);
  2515		}
  2516	}
  2517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

