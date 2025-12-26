Return-Path: <cgroups+bounces-12758-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C22CACDEFD7
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 21:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDF1D30012C2
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8872FE05D;
	Fri, 26 Dec 2025 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkgmkrAy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE22F999F;
	Fri, 26 Dec 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766781694; cv=none; b=oV0gjBggAmQ2bJsGB/RykOMqUbzJbJlX+nLwXAa5YjW73zTDeW+OBlWzfQMdbl/P0/puQsbv82mvRpJF3EO+KER6dpqUPbWKXb8SazJXfO1e35MaADANwfe/+rRda3YU1GLDrWZZeS1hDR717mtAW5kzCeF6FK0H146hO27uDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766781694; c=relaxed/simple;
	bh=zBQzHfUqOC2GvX06d1WmW6+lrYJwfd4jNRhhz+TtBZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn0X/uKjS+rVS99gQhmRCoXRvttPyS1ZO3Tjdvf/B+ZUNMkrW3Rsr+G/R76KhyIM8kPMywGiWDyDexAhgQhaPHxyVu913PMS8oA/X7N52kd43YFoEHgO0o124KhFzpk21vG7h0GNswNSKravcCh88J521/Nca9j6tZ+CHYVPG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkgmkrAy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766781693; x=1798317693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zBQzHfUqOC2GvX06d1WmW6+lrYJwfd4jNRhhz+TtBZc=;
  b=mkgmkrAytVUlWkmd3A5NBoCsbhy4xkw5o1dXumJslNxjhHhZqRw2pceU
   vHn7mz8hEJ198389oWSssh8PEC9sdh0ttnieXUKk+zFO68JtAdOZd95eI
   J+Hn1ee8fje0N9JE5i8SFQsrDKzz+P2EqhpXwceKDqK13mzg1Pu9IkXDc
   O12gqlIlUvKelH/RY7HWikmIvuYWGaYAxgk2W2sQlH3psHRcXrHmwe5yr
   yqLH26g2VvsSMtISDjRLAWS08qLuNp12ZijhFiOTGjFonP7aOjXbw63es
   PHC9rtP7LQu+879MapjKimslQi+drG1ay/tm3KIik8sSkZGUkpK+0EhW9
   w==;
X-CSE-ConnectionGUID: LvD78UrxRziOEXdNU/DTSg==
X-CSE-MsgGUID: ytQpJKMPSHGDJwk+F4tZHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68458820"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68458820"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 12:41:32 -0800
X-CSE-ConnectionGUID: FjJZNzGsTxSVpfeh4W0yOw==
X-CSE-MsgGUID: QyamsYnjQEa1dXYFzSx0WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="223928691"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Dec 2025 12:41:28 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZEcn-000000005LP-17e6;
	Fri, 26 Dec 2025 20:41:25 +0000
Date: Sat, 27 Dec 2025 04:40:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, Jiayuan Chen <jiayuan.chen@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/memcg: scale memory.high penalty based on refault
 recency
Message-ID: <202512270457.MunhjmYM-lkp@intel.com>
References: <20251226064257.245581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226064257.245581-1-jiayuan.chen@linux.dev>

Hi Jiayuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiayuan-Chen/mm-memcg-scale-memory-high-penalty-based-on-refault-recency/20251226-144331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251226064257.245581-1-jiayuan.chen%40linux.dev
patch subject: [PATCH v1] mm/memcg: scale memory.high penalty based on refault recency
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20251227/202512270457.MunhjmYM-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251227/202512270457.MunhjmYM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512270457.MunhjmYM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/workingset.c: In function 'workingset_refault':
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/linux/compiler_types.h:611:23: note: in definition of macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:631:9: note: in expansion of macro '_compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/linux/compiler_types.h:611:23: note: in definition of macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:631:9: note: in expansion of macro '_compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/linux/compiler_types.h:611:23: note: in definition of macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:631:9: note: in expansion of macro '_compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/linux/compiler_types.h:611:23: note: in definition of macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:631:9: note: in expansion of macro '_compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/linux/compiler_types.h:611:23: note: in definition of macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:631:9: note: in expansion of macro '_compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~
   In file included from ./arch/nios2/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:380,
                    from include/asm-generic/bug.h:5,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/nios2/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/cgroup.h:12,
                    from include/linux/memcontrol.h:13,
                    from mm/workingset.c:8:
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/asm-generic/rwonce.h:55:27: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                           ^
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~
>> mm/workingset.c:570:33: error: invalid use of undefined type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                                 ^~
   include/asm-generic/rwonce.h:55:34: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                  ^
   mm/workingset.c:570:17: note: in expansion of macro 'WRITE_ONCE'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                 ^~~~~~~~~~


vim +570 mm/workingset.c

   529	
   530	/**
   531	 * workingset_refault - Evaluate the refault of a previously evicted folio.
   532	 * @folio: The freshly allocated replacement folio.
   533	 * @shadow: Shadow entry of the evicted folio.
   534	 *
   535	 * Calculates and evaluates the refault distance of the previously
   536	 * evicted folio in the context of the node and the memcg whose memory
   537	 * pressure caused the eviction.
   538	 */
   539	void workingset_refault(struct folio *folio, void *shadow)
   540	{
   541		bool file = folio_is_file_lru(folio);
   542		struct pglist_data *pgdat;
   543		struct mem_cgroup *memcg;
   544		struct lruvec *lruvec;
   545		bool workingset;
   546		long nr;
   547	
   548		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
   549	
   550		if (lru_gen_enabled()) {
   551			lru_gen_refault(folio, shadow);
   552			return;
   553		}
   554	
   555		/*
   556		 * The activation decision for this folio is made at the level
   557		 * where the eviction occurred, as that is where the LRU order
   558		 * during folio reclaim is being determined.
   559		 *
   560		 * However, the cgroup that will own the folio is the one that
   561		 * is actually experiencing the refault event. Make sure the folio is
   562		 * locked to guarantee folio_memcg() stability throughout.
   563		 */
   564		nr = folio_nr_pages(folio);
   565		memcg = folio_memcg(folio);
   566		pgdat = folio_pgdat(folio);
   567		lruvec = mem_cgroup_lruvec(memcg, pgdat);
   568	
   569		if (memcg)
 > 570			WRITE_ONCE(memcg->last_refault, jiffies);
   571	
   572		mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
   573	
   574		if (!workingset_test_recent(shadow, file, &workingset, true))
   575			return;
   576	
   577		folio_set_active(folio);
   578		workingset_age_nonresident(lruvec, nr);
   579		mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file, nr);
   580	
   581		/* Folio was active prior to eviction */
   582		if (workingset) {
   583			folio_set_workingset(folio);
   584			/*
   585			 * XXX: Move to folio_add_lru() when it supports new vs
   586			 * putback
   587			 */
   588			lru_note_cost_refault(folio);
   589			mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
   590		}
   591	}
   592	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

