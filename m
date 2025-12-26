Return-Path: <cgroups+bounces-12750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC1CDEBC0
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 14:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EABA3007B43
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E3322B94;
	Fri, 26 Dec 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPBqEMby"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D513148A1;
	Fri, 26 Dec 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766755414; cv=none; b=XfjLGhvOScpZgi8eioiLR2pwxLYBPu/d0vtWKxFWRdbqy1heteEdflYnQlrRB7/5sqIGtfPbGtbF775wMsQ/eXnE0hD01HyJNf0uyA2ZxY8QVZPYkm17JJsRG4MV4hZY4VcwSzbpb883RkKSfmOf889JQhrcLYUpzExcjb5SHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766755414; c=relaxed/simple;
	bh=kYn0/jK2orN0CbLrDQMs5+dFtIP9GLMhhA/ko+U2UKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaEJyqmcdtw6z+vlUzjrAzcsQRQ7aV4wynFPUjRBUXmakSsWS4a509Z7uM8MCT3WszwmtfiXgt0t0eAyvEmbug++rQNOjNIAgFbwZgkU8El9J0QRWQMlOqeLcUoRSvSRMcD3ckSKBCY8NOpygmj5m6nLaVLH29BawFPgT2FvBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPBqEMby; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766755414; x=1798291414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYn0/jK2orN0CbLrDQMs5+dFtIP9GLMhhA/ko+U2UKE=;
  b=IPBqEMbyCiqFNDo8zrbtwGebbTghiXLW8qBRribmPfstPrwaOAjht8TQ
   hKFGOk39y0jk3INLVOKgJtm6+Zt+ct87dk8FjNPumQZwAWqiJ7L/bjr2u
   lKuK7X0JRTBq67554GQJK898VsAhJr6amMTLzBTaxrDX+dHNrx/cIzfSO
   JKHMPv3lpQsor5fDy6N+ky1fkkr3cdfrjP4zi+bYV1y7nWeVBPeoKjj56
   2oWbGqz07p8fMKoGTNGeGAVftYZZm3ag8x9or6fUsP+yg7AL53y513sWR
   LikCzYQKYMq3juRMLHTURl143MI7myrLBF3+1kBs6a9v8zxqGYbuI+LL9
   A==;
X-CSE-ConnectionGUID: XSSpR7ZbTuik4LDwxT1H4A==
X-CSE-MsgGUID: O84+jNSmROKSlmLP/Y8lKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11653"; a="72365581"
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="72365581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 05:23:33 -0800
X-CSE-ConnectionGUID: sMaK0WugQFSQyyqBCrCHgQ==
X-CSE-MsgGUID: SYbRYuy0TaqPlTD/iFOvsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="204522834"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Dec 2025 05:23:29 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZ7mw-0000000053J-3fOD;
	Fri, 26 Dec 2025 13:23:26 +0000
Date: Fri, 26 Dec 2025 21:23:04 +0800
From: kernel test robot <lkp@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	damon@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Message-ID: <202512262017.v77XZpwk-lkp@intel.com>
References: <20251225232116.294540-9-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225232116.294540-9-shakeel.butt@linux.dev>

Hi Shakeel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sj/damon/next]
[cannot apply to akpm-mm/mm-everything tj-cgroup/for-next linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shakeel-Butt/memcg-introduce-private-id-API-for-in-kernel-users/20251226-072954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
patch link:    https://lore.kernel.org/r/20251225232116.294540-9-shakeel.butt%40linux.dev
patch subject: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20251226/202512262017.v77XZpwk-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251226/202512262017.v77XZpwk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512262017.v77XZpwk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/openrisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/openrisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:6,
                    from mm/damon/sysfs.c:8:
   mm/damon/sysfs.c: In function 'debug_show':
>> include/linux/kern_levels.h:5:25: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:585:9: note: in expansion of macro 'printk'
     585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:585:16: note: in expansion of macro 'KERN_INFO'
     585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   mm/damon/sysfs.c:2704:17: note: in expansion of macro 'pr_info'
    2704 |                 pr_info("id: %u, path: %s\n", mem_cgroup_id(memcg), path);
         |                 ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

