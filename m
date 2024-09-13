Return-Path: <cgroups+bounces-4879-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE462978AE4
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B94CB216EE
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12EA16F0EB;
	Fri, 13 Sep 2024 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+2wC8Fw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF1155A4F;
	Fri, 13 Sep 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264477; cv=none; b=FK7KTDP6vyb97FHkh94i5K3dT0cRjCIx9qICezSqRaQXYpuJfnm0NwJovF6QApaK/0C3DwsZ6inL3vhPH/BdokEcAONTmotdd+xzeN8HSZNHZj+g5Fd9BCJ5lEP1wL2M8ja1dT48BpxSDb2TMTbpp81eXrgEAlRrqhfX8W1WUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264477; c=relaxed/simple;
	bh=zAwlk67tqKRq3ykb3Dq/lPmctb9a7uuG+dbiA68cadA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiZbuGrbEVKahl+GXjPF7I5wtZdJ+FP70CU4saB1NKtGTEBKvpMOtl1S5CGit9jCqbrTiLFTcuhUhWVgARIHyzPc9lTdRu/wbBhHEfbaDbgCv2zGatoKFR2p8g1/w4UAKXojxfp7jTJvCCIPLApYvkdVsQ0slMvjXJexoroaXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+2wC8Fw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726264476; x=1757800476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zAwlk67tqKRq3ykb3Dq/lPmctb9a7uuG+dbiA68cadA=;
  b=l+2wC8FwoUf4jv/m9AM4NRcj4YUfouCYP0vBIl3Vt6x3Ia4u41tFL51g
   YUxgyNQ6s2DlUIu7RyRMBwVa/2RZuBiTVSC1Ww8QTM5e8OIsgEkZG16YV
   v7H7r4GUsGO3ODDcmzIpec5+c6isY/8vZX0rm1VcWxg9upnwqXGsU3gmF
   b2NX8LJ5o7ky4lHqR2YBCTCwTts1ebn3RW0FfGEaYh5rCTSxy5TL/DzJt
   A3FRBnwv4FzMp+7aW6c4qfCEBOKdn0+UbJSWnlYqdgprBeb56adDSDMiC
   SOH2CY4YFfVm5n4R0mVrVwrmSxPVBTsgE3PM5L/46LoGAewjO6H+icqM4
   A==;
X-CSE-ConnectionGUID: gCbj0OLlQCGNBssXS9LvyQ==
X-CSE-MsgGUID: 66RUN85vSOWmVDkg05o5sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28964284"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28964284"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 14:54:32 -0700
X-CSE-ConnectionGUID: FOi80xTeS1Oe+X0B2eo2eQ==
X-CSE-MsgGUID: XvYNeoeQRMufVwcHM+SBeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72802514"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Sep 2024 14:54:28 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spEFF-00074a-1x;
	Fri, 13 Sep 2024 21:54:25 +0000
Date: Sat, 14 Sep 2024 05:53:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
	cgroups@vger.kernel.org, yosryahmed@google.com,
	shakeel.butt@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
	lizefan.x@bytedance.com, longman@redhat.com,
	kernel-team@cloudflare.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
Message-ID: <202409140533.2vt8QPj8-lkp@intel.com>
References: <172616070094.2055617.17676042522679701515.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172616070094.2055617.17676042522679701515.stgit@firesoul>

Hi Jesper,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on axboe-block/for-next linus/master v6.11-rc7]
[cannot apply to akpm-mm/mm-everything next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/cgroup-rstat-Avoid-flushing-if-there-is-an-ongoing-root-flush/20240913-010800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/172616070094.2055617.17676042522679701515.stgit%40firesoul
patch subject: [PATCH V11] cgroup/rstat: Avoid flushing if there is an ongoing root flush
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240914/202409140533.2vt8QPj8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140533.2vt8QPj8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140533.2vt8QPj8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:2265:2: error: call to undeclared function 'mem_cgroup_flush_stats_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2265 |         mem_cgroup_flush_stats_relaxed(sc->target_mem_cgroup);
         |         ^
   mm/vmscan.c:2265:2: note: did you mean 'mem_cgroup_flush_stats_ratelimited'?
   include/linux/memcontrol.h:1429:20: note: 'mem_cgroup_flush_stats_ratelimited' declared here
    1429 | static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
         |                    ^
   1 error generated.


vim +/mem_cgroup_flush_stats_relaxed +2265 mm/vmscan.c

  2250	
  2251	static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
  2252	{
  2253		unsigned long file;
  2254		struct lruvec *target_lruvec;
  2255	
  2256		if (lru_gen_enabled())
  2257			return;
  2258	
  2259		target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
  2260	
  2261		/*
  2262		 * Flush the memory cgroup stats, so that we read accurate per-memcg
  2263		 * lruvec stats for heuristics.
  2264		 */
> 2265		mem_cgroup_flush_stats_relaxed(sc->target_mem_cgroup);
  2266	
  2267		/*
  2268		 * Determine the scan balance between anon and file LRUs.
  2269		 */
  2270		spin_lock_irq(&target_lruvec->lru_lock);
  2271		sc->anon_cost = target_lruvec->anon_cost;
  2272		sc->file_cost = target_lruvec->file_cost;
  2273		spin_unlock_irq(&target_lruvec->lru_lock);
  2274	
  2275		/*
  2276		 * Target desirable inactive:active list ratios for the anon
  2277		 * and file LRU lists.
  2278		 */
  2279		if (!sc->force_deactivate) {
  2280			unsigned long refaults;
  2281	
  2282			/*
  2283			 * When refaults are being observed, it means a new
  2284			 * workingset is being established. Deactivate to get
  2285			 * rid of any stale active pages quickly.
  2286			 */
  2287			refaults = lruvec_page_state(target_lruvec,
  2288					WORKINGSET_ACTIVATE_ANON);
  2289			if (refaults != target_lruvec->refaults[WORKINGSET_ANON] ||
  2290				inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
  2291				sc->may_deactivate |= DEACTIVATE_ANON;
  2292			else
  2293				sc->may_deactivate &= ~DEACTIVATE_ANON;
  2294	
  2295			refaults = lruvec_page_state(target_lruvec,
  2296					WORKINGSET_ACTIVATE_FILE);
  2297			if (refaults != target_lruvec->refaults[WORKINGSET_FILE] ||
  2298			    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
  2299				sc->may_deactivate |= DEACTIVATE_FILE;
  2300			else
  2301				sc->may_deactivate &= ~DEACTIVATE_FILE;
  2302		} else
  2303			sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
  2304	
  2305		/*
  2306		 * If we have plenty of inactive file pages that aren't
  2307		 * thrashing, try to reclaim those first before touching
  2308		 * anonymous pages.
  2309		 */
  2310		file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
  2311		if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
  2312		    !sc->no_cache_trim_mode)
  2313			sc->cache_trim_mode = 1;
  2314		else
  2315			sc->cache_trim_mode = 0;
  2316	
  2317		/*
  2318		 * Prevent the reclaimer from falling into the cache trap: as
  2319		 * cache pages start out inactive, every cache fault will tip
  2320		 * the scan balance towards the file LRU.  And as the file LRU
  2321		 * shrinks, so does the window for rotation from references.
  2322		 * This means we have a runaway feedback loop where a tiny
  2323		 * thrashing file LRU becomes infinitely more attractive than
  2324		 * anon pages.  Try to detect this based on file LRU size.
  2325		 */
  2326		if (!cgroup_reclaim(sc)) {
  2327			unsigned long total_high_wmark = 0;
  2328			unsigned long free, anon;
  2329			int z;
  2330	
  2331			free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
  2332			file = node_page_state(pgdat, NR_ACTIVE_FILE) +
  2333				   node_page_state(pgdat, NR_INACTIVE_FILE);
  2334	
  2335			for (z = 0; z < MAX_NR_ZONES; z++) {
  2336				struct zone *zone = &pgdat->node_zones[z];
  2337	
  2338				if (!managed_zone(zone))
  2339					continue;
  2340	
  2341				total_high_wmark += high_wmark_pages(zone);
  2342			}
  2343	
  2344			/*
  2345			 * Consider anon: if that's low too, this isn't a
  2346			 * runaway file reclaim problem, but rather just
  2347			 * extreme pressure. Reclaim as per usual then.
  2348			 */
  2349			anon = node_page_state(pgdat, NR_INACTIVE_ANON);
  2350	
  2351			sc->file_is_tiny =
  2352				file + free <= total_high_wmark &&
  2353				!(sc->may_deactivate & DEACTIVATE_ANON) &&
  2354				anon >> sc->priority;
  2355		}
  2356	}
  2357	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

