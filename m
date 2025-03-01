Return-Path: <cgroups+bounces-6756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B018A4AE41
	for <lists+cgroups@lfdr.de>; Sun,  2 Mar 2025 00:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2573B401F
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3971D63D9;
	Sat,  1 Mar 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbePXwdE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EC23F36A
	for <cgroups@vger.kernel.org>; Sat,  1 Mar 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740870074; cv=none; b=lrI1L0lqrWAjftATpqJ304hgNEXSkbsnIT1o5vVv9cJ5yZ8SFBJnN0dj0IzrewHeg51ea2PEZf/AfABjkE7JmewCCtPcp4CSTWeWkqLZKUqAvqJ7Fk3eR5MSZumYbyZhFftyOucr8UTlp7T+M7Y3k67ACnwcgsG9OjG5ryQx8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740870074; c=relaxed/simple;
	bh=7w2CX1Ue6tyDuYsaxdofmnT+sluFZwvTVHk4Da0sm+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD1597ZkhKKCdZofPXD10/viDyIsLXVHxbX2UTo15cE7C8trVqR4rkdJDNFr0qJiLoPlJixAC2VKaQ15CcQahS3HM3adP3z4auXKELqopwUJuvlWpsOk0k+VDAfCwJYRwNvkH7AB0nqcoQ8V6I0ssEzYcVTWzvrneWSs8YfQDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbePXwdE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740870073; x=1772406073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7w2CX1Ue6tyDuYsaxdofmnT+sluFZwvTVHk4Da0sm+I=;
  b=hbePXwdEUVVVv4FycDCFaln6W9VzNu06sKpwjNNMt8KiXtSyG5FbJ9g6
   m5KNQof9zWiLfd0NMKTAUWv4gpAG0UuSZDvgxJWGWxIXCDsEflRPLbcxD
   8+MHwa9EUqei2X+qOQrlSZqRL2vV2oXsYRGnDcrXt0aTRT1SLZIaKFR4u
   Ti2ezgkStFdRMHXrsvy0ebFFlJAVySG41MxO7OCCZTN+CiI9vSG48dwYs
   N2LzD635+ebndMMCcfW8JibwGi8UkXdOq/NJiuvrFFp5p1GzFfd1sreHB
   RT81nb8iYmoUV9/71zvRQOZquKLcxTjt4OLUjy7Ovof8xD9kv7oUqUkkO
   g==;
X-CSE-ConnectionGUID: fkNkZKKMTYy4iuKNU4Nkhw==
X-CSE-MsgGUID: 3AsMhfjsSOmc7FOJ7IPNgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41895978"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="41895978"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 15:01:12 -0800
X-CSE-ConnectionGUID: 3MvU6VudQkqtGj/otM+KYg==
X-CSE-MsgGUID: 8qNv6xtxTou9EF4gBFQ4/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121772219"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 01 Mar 2025 15:01:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toVpP-000GnW-2y;
	Sat, 01 Mar 2025 23:01:04 +0000
Date: Sun, 2 Mar 2025 07:00:47 +0800
From: kernel test robot <lkp@intel.com>
To: inwardvessel <inwardvessel@gmail.com>, tj@kernel.org,
	shakeel.butt@linux.dev, yosryahmed@google.com, mhocko@kernel.org,
	hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <202503020616.SJVwhuOV-lkp@intel.com>
References: <20250227215543.49928-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-4-inwardvessel@gmail.com>

Hi inwardvessel,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.14-rc4]
[cannot apply to tj-cgroup/for-next next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/inwardvessel/cgroup-move-cgroup_rstat-from-cgroup-to-cgroup_subsys_state/20250228-055819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250227215543.49928-4-inwardvessel%40gmail.com
patch subject: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
config: hexagon-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020616.SJVwhuOV-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020616.SJVwhuOV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020616.SJVwhuOV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:339:2: error: member reference base type 'spinlock_t *' (aka 'struct spinlock *') is not a structure or union
     339 |         lockdep_assert_held(&lock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:285:17: note: expanded from macro 'lockdep_assert_held'
     285 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep.h:252:52: note: expanded from macro 'lockdep_is_held'
     252 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^ ~~~~~~~
   include/linux/lockdep.h:279:32: note: expanded from macro 'lockdep_assert'
     279 |         do { WARN_ON(debug_locks && !(cond)); } while (0)
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   1 error generated.


vim +339 kernel/cgroup/rstat.c

   330	
   331	/* see cgroup_rstat_flush() */
   332	static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
   333			spinlock_t *lock)
   334		__releases(lock) __acquires(lock)
   335	{
   336		struct cgroup *cgrp = css->cgroup;
   337		int cpu;
   338	
 > 339		lockdep_assert_held(&lock);
   340	
   341		for_each_possible_cpu(cpu) {
   342			struct cgroup_subsys_state *pos;
   343	
   344			pos = cgroup_rstat_updated_list(css, cpu);
   345			for (; pos; pos = pos->rstat_flush_next) {
   346				if (!pos->ss)
   347					cgroup_base_stat_flush(pos->cgroup, cpu);
   348				else
   349					pos->ss->css_rstat_flush(pos, cpu);
   350	
   351				bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
   352			}
   353	
   354			/* play nice and yield if necessary */
   355			if (need_resched() || spin_needbreak(lock)) {
   356				__cgroup_rstat_unlock(lock, cgrp, cpu);
   357				if (!cond_resched())
   358					cpu_relax();
   359				__cgroup_rstat_lock(lock, cgrp, cpu);
   360			}
   361		}
   362	}
   363	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

