Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A527AA5A3
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIUXa1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Sep 2023 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXa0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Sep 2023 19:30:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE52F7;
        Thu, 21 Sep 2023 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695339019; x=1726875019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ME8C2bw+S9S5r4SeJgGmarGxYaSLP1dZzXZxGZxMzo=;
  b=MSAOqJ9oQanJO6+5O8aFhH0QDQ+sj1HqNdXA6JK1mDiOJUqrgZZ445tf
   GU5ybosImird11keYMkbtGGMEyg6K2GVP9gPnpqa3G2NWXbA0omtmaLjl
   Q17W6MN03fKeUPOA5GlhhDsyR+Y3kx9P66hM8S4VqFSPFDbdrDaom6djJ
   6JkT0/GGrigAR8jVR4vJB2XaIjzABznABJaJf/+pE5fREjjbfJ5UPMaU8
   /3AwVWwvQnqvrDIYlGl8etbYQ1Ncj5b42+heyBRz9isV/gFhTrfsnRN5s
   UK+PWcCmtPSAX6DrUL7M0xh8nTdnk0GKuLMSwfyRHHhoqKE1vJKUQN368
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360076105"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="360076105"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 16:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="723960313"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="723960313"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 16:30:14 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjT7c-0000Xt-1e;
        Thu, 21 Sep 2023 23:30:12 +0000
Date:   Fri, 22 Sep 2023 07:29:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH 4/5] mm: workingset: move the stats flush into
 workingset_test_recent()
Message-ID: <202309220704.NF0GCRP2-lkp@intel.com>
References: <20230921081057.3440885-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921081057.3440885-5-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yosry,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20230921-161246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230921081057.3440885-5-yosryahmed%40google.com
patch subject: [PATCH 4/5] mm: workingset: move the stats flush into workingset_test_recent()
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230922/202309220704.NF0GCRP2-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309220704.NF0GCRP2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309220704.NF0GCRP2-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/workingset.c: In function 'workingset_test_recent':
>> mm/workingset.c:461:25: error: dereferencing pointer to incomplete type 'struct mem_cgroup'
     css_get(&eviction_memcg->css);
                            ^~


vim +461 mm/workingset.c

   405	
   406	/**
   407	 * workingset_test_recent - tests if the shadow entry is for a folio that was
   408	 * recently evicted. Also fills in @workingset with the value unpacked from
   409	 * shadow.
   410	 * @shadow: the shadow entry to be tested.
   411	 * @file: whether the corresponding folio is from the file lru.
   412	 * @workingset: where the workingset value unpacked from shadow should
   413	 * be stored.
   414	 *
   415	 * Return: true if the shadow is for a recently evicted folio; false otherwise.
   416	 */
   417	bool workingset_test_recent(void *shadow, bool file, bool *workingset)
   418	{
   419		struct mem_cgroup *eviction_memcg;
   420		struct lruvec *eviction_lruvec;
   421		unsigned long refault_distance;
   422		unsigned long workingset_size;
   423		unsigned long refault;
   424		int memcgid;
   425		struct pglist_data *pgdat;
   426		unsigned long eviction;
   427	
   428		rcu_read_lock();
   429	
   430		if (lru_gen_enabled()) {
   431			bool recent = lru_gen_test_recent(shadow, file,
   432							  &eviction_lruvec, &eviction,
   433							  workingset);
   434			rcu_read_unlock();
   435			return recent;
   436		}
   437	
   438		unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
   439		eviction <<= bucket_order;
   440	
   441		/*
   442		 * Look up the memcg associated with the stored ID. It might
   443		 * have been deleted since the folio's eviction.
   444		 *
   445		 * Note that in rare events the ID could have been recycled
   446		 * for a new cgroup that refaults a shared folio. This is
   447		 * impossible to tell from the available data. However, this
   448		 * should be a rare and limited disturbance, and activations
   449		 * are always speculative anyway. Ultimately, it's the aging
   450		 * algorithm's job to shake out the minimum access frequency
   451		 * for the active cache.
   452		 *
   453		 * XXX: On !CONFIG_MEMCG, this will always return NULL; it
   454		 * would be better if the root_mem_cgroup existed in all
   455		 * configurations instead.
   456		 */
   457		eviction_memcg = mem_cgroup_from_id(memcgid);
   458		if (!mem_cgroup_disabled() && !eviction_memcg)
   459			return false;
   460	
 > 461		css_get(&eviction_memcg->css);
   462		rcu_read_unlock();
   463	
   464		/* Flush stats (and potentially sleep) outside the RCU read section */
   465		mem_cgroup_flush_stats_ratelimited();
   466	
   467		eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
   468		refault = atomic_long_read(&eviction_lruvec->nonresident_age);
   469	
   470		/*
   471		 * Calculate the refault distance
   472		 *
   473		 * The unsigned subtraction here gives an accurate distance
   474		 * across nonresident_age overflows in most cases. There is a
   475		 * special case: usually, shadow entries have a short lifetime
   476		 * and are either refaulted or reclaimed along with the inode
   477		 * before they get too old.  But it is not impossible for the
   478		 * nonresident_age to lap a shadow entry in the field, which
   479		 * can then result in a false small refault distance, leading
   480		 * to a false activation should this old entry actually
   481		 * refault again.  However, earlier kernels used to deactivate
   482		 * unconditionally with *every* reclaim invocation for the
   483		 * longest time, so the occasional inappropriate activation
   484		 * leading to pressure on the active list is not a problem.
   485		 */
   486		refault_distance = (refault - eviction) & EVICTION_MASK;
   487	
   488		/*
   489		 * Compare the distance to the existing workingset size. We
   490		 * don't activate pages that couldn't stay resident even if
   491		 * all the memory was available to the workingset. Whether
   492		 * workingset competition needs to consider anon or not depends
   493		 * on having free swap space.
   494		 */
   495		workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
   496		if (!file) {
   497			workingset_size += lruvec_page_state(eviction_lruvec,
   498							     NR_INACTIVE_FILE);
   499		}
   500		if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
   501			workingset_size += lruvec_page_state(eviction_lruvec,
   502							     NR_ACTIVE_ANON);
   503			if (file) {
   504				workingset_size += lruvec_page_state(eviction_lruvec,
   505							     NR_INACTIVE_ANON);
   506			}
   507		}
   508	
   509		mem_cgroup_put(eviction_memcg);
   510		return refault_distance <= workingset_size;
   511	}
   512	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
