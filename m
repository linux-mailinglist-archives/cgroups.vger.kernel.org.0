Return-Path: <cgroups+bounces-5763-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1FD9E4637
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 22:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A51650A5
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D718E368;
	Wed,  4 Dec 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ff906mvn"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39918D626;
	Wed,  4 Dec 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346088; cv=none; b=ZZjCs5zv9Ih3pbbJhISlYnfVRUjA+eBtYWRwCBsC1WNA+gITD8mbH3x44KeedAlL4c5kORD71/K/ZNr+LxhX0VueUG4GvdQCE+N8pvzoPeLPnIj0pS96cW/KjrjWVE6pmw/pKQx+uc7gCK+IP5wSpFWxe3CgSR3Blz8TTYErBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346088; c=relaxed/simple;
	bh=+B1b48erQIeQixduuLKyl6Gzmhalqkxt2Aqtmj7j3GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9Xo2CkEXdYygCmbMjmOesq34AG1eHT7MxhIjJxqkl49IyXuFvcmwNjmsuBFA71JAZQLiDc7gmXAUAGjSkNH/ShvDJsSaoVAFSV9OrBkRaseHXfL31T910yLhoNA4FF4aOOwgTO73UcaFVl1XDBCHSDkwuI4PLGoTmHP5qrwXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ff906mvn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733346086; x=1764882086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+B1b48erQIeQixduuLKyl6Gzmhalqkxt2Aqtmj7j3GM=;
  b=Ff906mvnYMV5si/CcTD0cLqwit7SefMn5eCjJnVSgvK/zri0F9MRPgee
   b18ZskXh9ysUVjA0LobPevxfKtW/9Edlh/fHs/uR+xqQ1QLiVkvFkkgFq
   q28MbxR0zL/FLPs7X1oor0yTfbORv4pQRJEi6v1QG1yJ2jzo8P9Ibl2Ia
   bvysHY2fltIrLIfjmno8N3eRP5ZZ7XvGcLeEbx74wAZH2JgG+OmG77N12
   61AsO67FEXzuEjyB2lWg5UDokPSLeVUj+QHQBrNSsg6SrPzEogNJdcvo8
   5mnn0+/KIbdax5lG+3HQZvRG+oq5N7BODA7drmeGbPwnytu3EbJpUcN+b
   g==;
X-CSE-ConnectionGUID: qYsQ8u/SR4GCsXi9JFAfqQ==
X-CSE-MsgGUID: 52ci3bg1QL28QnQgKWFfZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33376970"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33376970"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:01:25 -0800
X-CSE-ConnectionGUID: nWMhahjzT6unCm7yL0vWZw==
X-CSE-MsgGUID: rdAyQyECS1GnVqSYeIN72A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="97937244"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Dec 2024 13:01:21 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIwUo-0003UF-2o;
	Wed, 04 Dec 2024 21:01:18 +0000
Date: Thu, 5 Dec 2024 05:00:57 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	cgroups@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2.1 1/1] kernel/cgroup: Add "dmem" memory accounting
 cgroup
Message-ID: <202412050415.jf4sa0gH-lkp@intel.com>
References: <20241204143112.1250983-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204143112.1250983-1-dev@lankhorst.se>

Hi Maarten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.13-rc1 next-20241204]
[cannot apply to drm-misc/drm-misc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/kernel-cgroup-Add-dmem-memory-accounting-cgroup/20241204-233207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20241204143112.1250983-1-dev%40lankhorst.se
patch subject: [PATCH v2.1 1/1] kernel/cgroup: Add "dmem" memory accounting cgroup
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241205/202412050415.jf4sa0gH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050415.jf4sa0gH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050415.jf4sa0gH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/cgroup/dmem.c: In function 'dmem_cgroup_state_evict_valuable':
>> kernel/cgroup/dmem.c:302:30: warning: variable 'climit' set but not used [-Wunused-but-set-variable]
     302 |         struct page_counter *climit, *ctest;
         |                              ^~~~~~
--
>> kernel/cgroup/dmem.c:300: warning: Excess function parameter 'dev' description in 'dmem_cgroup_state_evict_valuable'
>> kernel/cgroup/dmem.c:300: warning: Excess function parameter 'index' description in 'dmem_cgroup_state_evict_valuable'
>> kernel/cgroup/dmem.c:635: warning: Function parameter or struct member 'region' not described in 'dmem_cgroup_try_charge'
>> kernel/cgroup/dmem.c:635: warning: Excess function parameter 'dev' description in 'dmem_cgroup_try_charge'


vim +/climit +302 kernel/cgroup/dmem.c

   280	
   281	/**
   282	 * dmem_cgroup_state_evict_valuable() - Check if we should evict from test_pool
   283	 * @dev: &dmem_cgroup_region
   284	 * @index: The index number of the region being tested.
   285	 * @limit_pool: The pool for which we hit limits
   286	 * @test_pool: The pool for which to test
   287	 * @ignore_low: Whether we have to respect low watermarks.
   288	 * @ret_hit_low: Pointer to whether it makes sense to consider low watermark.
   289	 *
   290	 * This function returns true if we can evict from @test_pool, false if not.
   291	 * When returning false and @ignore_low is false, @ret_hit_low may
   292	 * be set to true to indicate this function can be retried with @ignore_low
   293	 * set to true.
   294	 *
   295	 * Return: bool
   296	 */
   297	bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
   298					      struct dmem_cgroup_pool_state *test_pool,
   299					      bool ignore_low, bool *ret_hit_low)
 > 300	{
   301		struct dmem_cgroup_pool_state *pool = test_pool;
 > 302		struct page_counter *climit, *ctest;
   303		u64 used, min, low;
   304	
   305		/* Can always evict from current pool, despite limits */
   306		if (limit_pool == test_pool)
   307			return true;
   308	
   309		if (limit_pool) {
   310			if (!parent_dmemcs(limit_pool->cs))
   311				return true;
   312	
   313			for (pool = test_pool; pool && limit_pool != pool; pool = pool_parent(pool))
   314				{}
   315	
   316			if (!pool)
   317				return false;
   318		} else {
   319			/*
   320			 * If there is no cgroup limiting memory usage, use the root
   321			 * cgroup instead for limit calculations.
   322			 */
   323			for (limit_pool = test_pool; pool_parent(limit_pool); limit_pool = pool_parent(limit_pool))
   324				{}
   325		}
   326	
   327		climit = &limit_pool->cnt;
   328		ctest = &test_pool->cnt;
   329	
   330		dmem_cgroup_calculate_protection(limit_pool, test_pool);
   331	
   332		used = page_counter_read(ctest);
   333		min = READ_ONCE(ctest->emin);
   334	
   335		if (used <= min)
   336			return false;
   337	
   338		if (!ignore_low) {
   339			low = READ_ONCE(ctest->elow);
   340			if (used > low)
   341				return true;
   342	
   343			*ret_hit_low = true;
   344			return false;
   345		}
   346		return true;
   347	}
   348	EXPORT_SYMBOL_GPL(dmem_cgroup_state_evict_valuable);
   349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

