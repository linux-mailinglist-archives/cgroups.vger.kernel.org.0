Return-Path: <cgroups+bounces-12761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A2CCDF005
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 21:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 896A63003048
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320D2FB08C;
	Fri, 26 Dec 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGKb5FZg"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398120D4FC;
	Fri, 26 Dec 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766782294; cv=none; b=e1MaxHY48wLkyOh0b45bcxUvBpl5nT+8+KYRq7jz0+twndliirbvsLsIfhwOIgxnD4Gh5IL+w9LCm3kBJI2Jpk37Oqyq9OtbfHkuEMYHZxxSDMBwinjf6wNqQXAQJlca/tqvilh6wWAWdyGzi+lllqJHImSH5npzerrweAK3dX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766782294; c=relaxed/simple;
	bh=cIai1HhnCTdXbz4D4yQFoHY8vOuTPp1/oRc27ajVe+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkB1AVCZ6X6wzBpMB94wc6INddBayY6ghWUlw3MIpx/KXGqEtaiMLOf/t8BVOBDirZgePPjI2qluir38yiqT09vDdtf6Vn8ZlgJj3T8bH4wzA/0FeYdpWV5i4xPFKn6hMPGEvJvs9SjSTa3YEXVa3jecx46y5O8jbAeMNEg47CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGKb5FZg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766782293; x=1798318293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cIai1HhnCTdXbz4D4yQFoHY8vOuTPp1/oRc27ajVe+E=;
  b=kGKb5FZgGGkV1R480tQRoYU1qJd6/Bv4HROKwNW3oVkCBz47jMWxbrvu
   HE7btpIQ5/B+sIAIx724XjUmnETmLyvBd/SubILNOy95q5wfVmsPJSAno
   rD/BZchwzxGnAe43cbeAulZ+dC1r6mqh7IG3C2lC9ht1ylR9G91x77eRS
   1F1aP64PfLPFMktZYt/K55n9L/jg/vYxflCRhkX7SeOZxlwvic6DMEc1h
   kWszOqF1eP5Fru+uVDp+GFNJJPcvmIU++NtOv6khynqtb6RF61koDdq7I
   ByoUBPVSzAWdurHhI/LPnGWcG4wSQX29UrZtdWXyiC/KENTKMt0Q8eurC
   Q==;
X-CSE-ConnectionGUID: 3BWX65bfQjqMvcGzMDM7gw==
X-CSE-MsgGUID: IuxTcoSDRPO7o8IjaZqTtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11653"; a="79246670"
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="79246670"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 12:51:32 -0800
X-CSE-ConnectionGUID: YqE5d6ZPQYO0wJ3eYfLzyQ==
X-CSE-MsgGUID: xXoAATubQzuBV+NEBEv4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,178,1763452800"; 
   d="scan'208";a="201371819"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Dec 2025 12:51:27 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZEmT-000000005Ld-1ea1;
	Fri, 26 Dec 2025 20:51:25 +0000
Date: Sat, 27 Dec 2025 04:51:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
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
Message-ID: <202512270405.sx7TY5MG-lkp@intel.com>
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
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251227/202512270405.sx7TY5MG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251227/202512270405.sx7TY5MG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512270405.sx7TY5MG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:592:10: note: expanded from macro '__native_word'
     592 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:631:22: note: expanded from macro 'compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:619:23: note: expanded from macro '_compiletime_assert'
     619 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:611:9: note: expanded from macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:592:39: note: expanded from macro '__native_word'
     592 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:631:22: note: expanded from macro 'compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:619:23: note: expanded from macro '_compiletime_assert'
     619 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:611:9: note: expanded from macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:593:10: note: expanded from macro '__native_word'
     593 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:631:22: note: expanded from macro 'compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:619:23: note: expanded from macro '_compiletime_assert'
     619 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:611:9: note: expanded from macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:593:38: note: expanded from macro '__native_word'
     593 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:631:22: note: expanded from macro 'compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:619:23: note: expanded from macro '_compiletime_assert'
     619 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:611:9: note: expanded from macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:631:22: note: expanded from macro 'compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:619:23: note: expanded from macro '_compiletime_assert'
     619 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:611:9: note: expanded from macro '__compiletime_assert'
     611 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |                      ^
   include/asm-generic/rwonce.h:55:20: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                           ^
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
>> mm/workingset.c:570:19: error: incomplete definition of type 'struct mem_cgroup'
     570 |                 WRITE_ONCE(memcg->last_refault, jiffies);
         |                            ~~~~~^
   include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |                      ^
   include/asm-generic/rwonce.h:55:27: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                  ^
   include/linux/shrinker.h:55:9: note: forward declaration of 'struct mem_cgroup'
      55 |         struct mem_cgroup *memcg;
         |                ^
   7 errors generated.


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

