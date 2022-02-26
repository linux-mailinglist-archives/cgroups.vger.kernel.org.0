Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B984C5365
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 03:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiBZCeQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 21:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiBZCeM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 21:34:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3D10DA52;
        Fri, 25 Feb 2022 18:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645842817; x=1677378817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=43gOqWKi55OYaSFCmbMbQJLx6uNrCxT4m6xOeQarbNM=;
  b=KY0eDzs5a1HLp3NCS23fsfS9LgrbfSTyiuIMdRdbOgiNcSx7DIBLJeu0
   MzEE25T8o3W5O+Ao77K1c4S3jTK3/duxyfiyzv1+pibX5lHqn7omOw/N4
   B33T1cNzPl0p6oNxCG3/giJx0QuFIwuwuA5ifHTRIdwMAq2zgD7DftAVc
   8PmVyq/dPDYq2bFaPFQqD8WBu8o8IOJ6V43sEZNF+ZQUgXvoLp81tCIVt
   7tIJjr+FMd2R0qXfgjeZrf2TDMZS1PdYCeNnnyE9ccqUgECmqd51/XxhZ
   A0i02vY3rzKXdu7hdZVzYTPr2E9lFx6gWy/3y6L+igzAagBPUH2m1xuui
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="277261931"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="277261931"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 18:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="492163099"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2022 18:33:33 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNmto-0004yF-P9; Sat, 26 Feb 2022 02:33:32 +0000
Date:   Sat, 26 Feb 2022 10:32:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     kbuild-all@lists.01.org, Ivan Babrou <ivan@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Daniel Dao <dqminh@cloudflare.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: async flush memcg stats from perf sensitive
 codepaths
Message-ID: <202202261045.FAsMZlyD-lkp@intel.com>
References: <20220226002412.113819-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226002412.113819-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Shakeel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on linus/master v5.17-rc5 next-20220224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shakeel-Butt/memcg-async-flush-memcg-stats-from-perf-sensitive-codepaths/20220226-082444
base:   https://github.com/hnaz/linux-mm master
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220226/202202261045.FAsMZlyD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/5dffeb24975bc4cbe99af650d833eb0183a4882f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shakeel-Butt/memcg-async-flush-memcg-stats-from-perf-sensitive-codepaths/20220226-082444
        git checkout 5dffeb24975bc4cbe99af650d833eb0183a4882f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'shrink_node':
>> mm/vmscan.c:3191:2: error: implicit declaration of function 'mem_cgroup_flush_stats_async'; did you mean 'mem_cgroup_flush_stats'? [-Werror=implicit-function-declaration]
    3191 |  mem_cgroup_flush_stats_async();
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  mem_cgroup_flush_stats
   cc1: some warnings being treated as errors
--
   mm/workingset.c: In function 'workingset_refault':
>> mm/workingset.c:358:2: error: implicit declaration of function 'mem_cgroup_flush_stats_async'; did you mean 'mem_cgroup_flush_stats'? [-Werror=implicit-function-declaration]
     358 |  mem_cgroup_flush_stats_async();
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |  mem_cgroup_flush_stats
   cc1: some warnings being treated as errors


vim +3191 mm/vmscan.c

  3175	
  3176	static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
  3177	{
  3178		struct reclaim_state *reclaim_state = current->reclaim_state;
  3179		unsigned long nr_reclaimed, nr_scanned;
  3180		struct lruvec *target_lruvec;
  3181		bool reclaimable = false;
  3182		unsigned long file;
  3183	
  3184		target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
  3185	
  3186	again:
  3187		/*
  3188		 * Flush the memory cgroup stats, so that we read accurate per-memcg
  3189		 * lruvec stats for heuristics.
  3190		 */
> 3191		mem_cgroup_flush_stats_async();
  3192	
  3193		memset(&sc->nr, 0, sizeof(sc->nr));
  3194	
  3195		nr_reclaimed = sc->nr_reclaimed;
  3196		nr_scanned = sc->nr_scanned;
  3197	
  3198		/*
  3199		 * Determine the scan balance between anon and file LRUs.
  3200		 */
  3201		spin_lock_irq(&target_lruvec->lru_lock);
  3202		sc->anon_cost = target_lruvec->anon_cost;
  3203		sc->file_cost = target_lruvec->file_cost;
  3204		spin_unlock_irq(&target_lruvec->lru_lock);
  3205	
  3206		/*
  3207		 * Target desirable inactive:active list ratios for the anon
  3208		 * and file LRU lists.
  3209		 */
  3210		if (!sc->force_deactivate) {
  3211			unsigned long refaults;
  3212	
  3213			refaults = lruvec_page_state(target_lruvec,
  3214					WORKINGSET_ACTIVATE_ANON);
  3215			if (refaults != target_lruvec->refaults[0] ||
  3216				inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
  3217				sc->may_deactivate |= DEACTIVATE_ANON;
  3218			else
  3219				sc->may_deactivate &= ~DEACTIVATE_ANON;
  3220	
  3221			/*
  3222			 * When refaults are being observed, it means a new
  3223			 * workingset is being established. Deactivate to get
  3224			 * rid of any stale active pages quickly.
  3225			 */
  3226			refaults = lruvec_page_state(target_lruvec,
  3227					WORKINGSET_ACTIVATE_FILE);
  3228			if (refaults != target_lruvec->refaults[1] ||
  3229			    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
  3230				sc->may_deactivate |= DEACTIVATE_FILE;
  3231			else
  3232				sc->may_deactivate &= ~DEACTIVATE_FILE;
  3233		} else
  3234			sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
  3235	
  3236		/*
  3237		 * If we have plenty of inactive file pages that aren't
  3238		 * thrashing, try to reclaim those first before touching
  3239		 * anonymous pages.
  3240		 */
  3241		file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
  3242		if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
  3243			sc->cache_trim_mode = 1;
  3244		else
  3245			sc->cache_trim_mode = 0;
  3246	
  3247		/*
  3248		 * Prevent the reclaimer from falling into the cache trap: as
  3249		 * cache pages start out inactive, every cache fault will tip
  3250		 * the scan balance towards the file LRU.  And as the file LRU
  3251		 * shrinks, so does the window for rotation from references.
  3252		 * This means we have a runaway feedback loop where a tiny
  3253		 * thrashing file LRU becomes infinitely more attractive than
  3254		 * anon pages.  Try to detect this based on file LRU size.
  3255		 */
  3256		if (!cgroup_reclaim(sc)) {
  3257			unsigned long total_high_wmark = 0;
  3258			unsigned long free, anon;
  3259			int z;
  3260	
  3261			free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
  3262			file = node_page_state(pgdat, NR_ACTIVE_FILE) +
  3263				   node_page_state(pgdat, NR_INACTIVE_FILE);
  3264	
  3265			for (z = 0; z < MAX_NR_ZONES; z++) {
  3266				struct zone *zone = &pgdat->node_zones[z];
  3267				if (!managed_zone(zone))
  3268					continue;
  3269	
  3270				total_high_wmark += high_wmark_pages(zone);
  3271			}
  3272	
  3273			/*
  3274			 * Consider anon: if that's low too, this isn't a
  3275			 * runaway file reclaim problem, but rather just
  3276			 * extreme pressure. Reclaim as per usual then.
  3277			 */
  3278			anon = node_page_state(pgdat, NR_INACTIVE_ANON);
  3279	
  3280			sc->file_is_tiny =
  3281				file + free <= total_high_wmark &&
  3282				!(sc->may_deactivate & DEACTIVATE_ANON) &&
  3283				anon >> sc->priority;
  3284		}
  3285	
  3286		shrink_node_memcgs(pgdat, sc);
  3287	
  3288		if (reclaim_state) {
  3289			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
  3290			reclaim_state->reclaimed_slab = 0;
  3291		}
  3292	
  3293		/* Record the subtree's reclaim efficiency */
  3294		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
  3295			   sc->nr_scanned - nr_scanned,
  3296			   sc->nr_reclaimed - nr_reclaimed);
  3297	
  3298		if (sc->nr_reclaimed - nr_reclaimed)
  3299			reclaimable = true;
  3300	
  3301		if (current_is_kswapd()) {
  3302			/*
  3303			 * If reclaim is isolating dirty pages under writeback,
  3304			 * it implies that the long-lived page allocation rate
  3305			 * is exceeding the page laundering rate. Either the
  3306			 * global limits are not being effective at throttling
  3307			 * processes due to the page distribution throughout
  3308			 * zones or there is heavy usage of a slow backing
  3309			 * device. The only option is to throttle from reclaim
  3310			 * context which is not ideal as there is no guarantee
  3311			 * the dirtying process is throttled in the same way
  3312			 * balance_dirty_pages() manages.
  3313			 *
  3314			 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
  3315			 * count the number of pages under pages flagged for
  3316			 * immediate reclaim and stall if any are encountered
  3317			 * in the nr_immediate check below.
  3318			 */
  3319			if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
  3320				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
  3321	
  3322			/* Allow kswapd to start writing pages during reclaim.*/
  3323			if (sc->nr.unqueued_dirty == sc->nr.file_taken)
  3324				set_bit(PGDAT_DIRTY, &pgdat->flags);
  3325	
  3326			/*
  3327			 * If kswapd scans pages marked for immediate
  3328			 * reclaim and under writeback (nr_immediate), it
  3329			 * implies that pages are cycling through the LRU
  3330			 * faster than they are written so forcibly stall
  3331			 * until some pages complete writeback.
  3332			 */
  3333			if (sc->nr.immediate)
  3334				reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
  3335		}
  3336	
  3337		/*
  3338		 * Tag a node/memcg as congested if all the dirty pages were marked
  3339		 * for writeback and immediate reclaim (counted in nr.congested).
  3340		 *
  3341		 * Legacy memcg will stall in page writeback so avoid forcibly
  3342		 * stalling in reclaim_throttle().
  3343		 */
  3344		if ((current_is_kswapd() ||
  3345		     (cgroup_reclaim(sc) && writeback_throttling_sane(sc))) &&
  3346		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
  3347			set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
  3348	
  3349		/*
  3350		 * Stall direct reclaim for IO completions if the lruvec is
  3351		 * node is congested. Allow kswapd to continue until it
  3352		 * starts encountering unqueued dirty pages or cycling through
  3353		 * the LRU too quickly.
  3354		 */
  3355		if (!current_is_kswapd() && current_may_throttle() &&
  3356		    !sc->hibernation_mode &&
  3357		    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
  3358			reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
  3359	
  3360		if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
  3361					    sc))
  3362			goto again;
  3363	
  3364		/*
  3365		 * Kswapd gives up on balancing particular nodes after too
  3366		 * many failures to reclaim anything from them and goes to
  3367		 * sleep. On reclaim progress, reset the failure counter. A
  3368		 * successful direct reclaim run will revive a dormant kswapd.
  3369		 */
  3370		if (reclaimable)
  3371			pgdat->kswapd_failures = 0;
  3372	}
  3373	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
