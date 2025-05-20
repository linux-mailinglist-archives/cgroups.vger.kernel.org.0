Return-Path: <cgroups+bounces-8268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C692DABD90F
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C6F8C100C
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7622D7A8;
	Tue, 20 May 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YppeWIkj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648622CBE4;
	Tue, 20 May 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746822; cv=none; b=byvoKxIyh/lxoiNHGnDE7++JXPZKbEzFW+rSxx0NgrOcjX9GUxmVmkOtAiQEUHFYhK6JygkerFyP6hKHoHNTkF2OQ3pqTuc7NJaUuRAt/K5umDx+7G6MJh1TEFcYHI6qRUYhu4LF5X3WuCROBrPt0pyPB3vsDPJAKf5R+fRYyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746822; c=relaxed/simple;
	bh=OsUk1HDLzXJbjJz5VCLQBVaTC8gEtGoSU5l12/RHrKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsH4b1SXLHCL92kVW3K7gNZtMAhlWjy+m222QiyCIZBNX65cm37TmjXRlcleaP/rvdHvlqDnZET2U5sjrWYx106yRk9Sp5elWxXq9AqBCk7/nRegQjqGH3TwQ00CT87hEQprHeE11Q9jXBJ06P7diQtRb93xVuwVrvgexo4n8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YppeWIkj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747746820; x=1779282820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OsUk1HDLzXJbjJz5VCLQBVaTC8gEtGoSU5l12/RHrKg=;
  b=YppeWIkjp6D2bTxbKNJXnlupB1mbHaXIZiUkM75Q9DphFKK8v1CJsQ3l
   HHLhTvTnJYl9BYY6kvjbdXTCsJcoa11efvEMRC6y4t0bAPyovc8C8ep30
   mDGr1TgWOUMNKD0NfKB1v624JqXP56f+ZiDnHkh9hzfMvIt58OEMyhmOj
   29/rMhPbsZjpS1ajiePGZntc2I5qTF8mEJ71NU9t6E4EpzzENcOL9NpTK
   /rhYvlfzIjHjxMeQ4GHMz+TqDlwnHqbBXiIU7hN+hhVpWGIx4/DWCtzGR
   IqWTPkWGE/051KkadR2bj6b58+efQor5G4ojsWsfeUeGBIpYb1YX6246j
   w==;
X-CSE-ConnectionGUID: bSdvcZk2RbyxaN6K9xKgcg==
X-CSE-MsgGUID: /7faESv+SYqWLS1wZ8OgFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="61074171"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="61074171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 06:13:40 -0700
X-CSE-ConnectionGUID: rA1loLxxTQa7qEkXvaO1Fw==
X-CSE-MsgGUID: 2vu6Lnj/S4ysDQHYaBmWIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140109610"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 May 2025 06:13:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHMml-000MbQ-1y;
	Tue, 20 May 2025 13:13:35 +0000
Date: Tue, 20 May 2025 21:13:27 +0800
From: kernel test robot <lkp@intel.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, tj@kernel.org,
	hannes@cmpxchg.org, longman@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
Message-ID: <202505202106.sXzGXeU4-lkp@intel.com>
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>

Hi Zhongkun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhongkun-He/cpuset-introduce-non-blocking-cpuset-mems-setting-option/20250520-111737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250520031552.1931598-1-hezhongkun.hzk%40bytedance.com
patch subject: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
config: sparc64-randconfig-001-20250520 (https://download.01.org/0day-ci/archive/20250520/202505202106.sXzGXeU4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505202106.sXzGXeU4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505202106.sXzGXeU4-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/cpuset.c: In function 'cpuset_write_resmask':
>> kernel/cgroup/cpuset.c:3246:3: error: a label can only be part of a statement and a declaration is not a statement
      bool skip_migrate_once = false;
      ^~~~


vim +3246 kernel/cgroup/cpuset.c

  3215	
  3216	/*
  3217	 * Common handling for a write to a "cpus" or "mems" file.
  3218	 */
  3219	ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
  3220					    char *buf, size_t nbytes, loff_t off)
  3221	{
  3222		struct cpuset *cs = css_cs(of_css(of));
  3223		struct cpuset *trialcs;
  3224		int retval = -ENODEV;
  3225	
  3226		buf = strstrip(buf);
  3227		cpus_read_lock();
  3228		mutex_lock(&cpuset_mutex);
  3229		if (!is_cpuset_online(cs))
  3230			goto out_unlock;
  3231	
  3232		trialcs = alloc_trial_cpuset(cs);
  3233		if (!trialcs) {
  3234			retval = -ENOMEM;
  3235			goto out_unlock;
  3236		}
  3237	
  3238		switch (of_cft(of)->private) {
  3239		case FILE_CPULIST:
  3240			retval = update_cpumask(cs, trialcs, buf);
  3241			break;
  3242		case FILE_EXCLUSIVE_CPULIST:
  3243			retval = update_exclusive_cpumask(cs, trialcs, buf);
  3244			break;
  3245		case FILE_MEMLIST:
> 3246			bool skip_migrate_once = false;
  3247	
  3248			if ((of->file->f_flags & O_NONBLOCK) &&
  3249				is_memory_migrate(cs) &&
  3250				!cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 0))
  3251				skip_migrate_once = true;
  3252	
  3253			retval = update_nodemask(cs, trialcs, buf);
  3254	
  3255			/* Restore the migrate flag */
  3256			if (skip_migrate_once)
  3257				cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 1);
  3258			break;
  3259		default:
  3260			retval = -EINVAL;
  3261			break;
  3262		}
  3263	
  3264		free_cpuset(trialcs);
  3265		if (force_sd_rebuild)
  3266			rebuild_sched_domains_locked();
  3267	out_unlock:
  3268		mutex_unlock(&cpuset_mutex);
  3269		cpus_read_unlock();
  3270		flush_workqueue(cpuset_migrate_mm_wq);
  3271		return retval ?: nbytes;
  3272	}
  3273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

