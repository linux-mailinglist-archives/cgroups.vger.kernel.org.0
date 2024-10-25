Return-Path: <cgroups+bounces-5241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7D9AF5F5
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 02:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AE0B21F75
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 00:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8412572;
	Fri, 25 Oct 2024 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgnqvMFS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25D5221
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815094; cv=none; b=Ab2gBQ69Bz5cuRBvCCzT6Pn4wBSUgmYyNStMAOaHPYT1yAqt18VLM6KmX/V5wrCga/dnlXCsC3a/0WdwEVCZF+PlDKYKTEr27UmwbOKNyFN4CjSqy2iAgY1WlOoPynhuuptpJUadb7jWHQs+fynlKAeu3UL1GRBl8eLorbMv2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815094; c=relaxed/simple;
	bh=USYJo6QAgIU+OcO7CNSnuj4I1wMoyUyaUIuZpwK3lwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTtFet/i3e5qN4Lm3BTCjSJ3z5SYf4k2azZ4mr6e05/zdngwJR+KhKugED8utU7gGDvBZndcE8+uzhlsP0zs3u5ix31CuvnMMWqPNMb5+bKAoOOlcI4UwoZkNfrppFOYSGLjqCmFR45+O4QZCgZTpbfcMeoiiVSRUwx4iEhvgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgnqvMFS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729815092; x=1761351092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=USYJo6QAgIU+OcO7CNSnuj4I1wMoyUyaUIuZpwK3lwk=;
  b=PgnqvMFSsoYXrTg1cyCah/Mym0NPAOGkmG5WR8gy8eQgsvpX1Ts1wtah
   RtcsPaj0yds8T7ZX8nUBahR+/5tD0Z+IChfY443pjfd1D7KR0oPb0Be8w
   YQdtLfxmgNAzl9A8bXD/m+IJO6vLtuvr62P6VF2vz7zWlVgxdSjBGawyi
   +hQGl6/qSOTfZYrU9SxQfVx3hbcvccGhHYBIFS4BiyDmxvb/ldWpDakus
   f26IUDNArY0a23rNiThrKCfHC7YzTcjaCjwuogIsDwX2+qHmDzhWazIIL
   nRejfDwLNObqp7Bv8AGCkxCDEvZBYm9MlW2AiASZn/X6smffi4+vZoTCd
   w==;
X-CSE-ConnectionGUID: ehnJUWg6T7O1zfxJ6BNdrA==
X-CSE-MsgGUID: mteniS1lQGixySVXLdsokw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54877316"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="54877316"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:11:32 -0700
X-CSE-ConnectionGUID: 04ancdkiQTGNyo5erMwanQ==
X-CSE-MsgGUID: abV4XZMkRIGXHMPL4UPgqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85523483"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Oct 2024 17:11:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t47vK-000XJ6-0S;
	Fri, 25 Oct 2024 00:11:26 +0000
Date: Fri, 25 Oct 2024 08:11:20 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, hannes@cmpxchg.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nphamcs@gmail.com,
	mhocko@kernel.org, roman.gushcin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, lnyng@meta.com, akpm@linux-foundation.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <202410250704.0LVzYMzi-lkp@intel.com>
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/memcg-hugetlb-Adding-hugeTLB-counters-to-memcg/20241024-043559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241023203433.1568323-1-joshua.hahnjy%40gmail.com
patch subject: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
config: i386-buildonly-randconfig-003-20241025 (https://download.01.org/0day-ci/archive/20241025/202410250704.0LVzYMzi-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250704.0LVzYMzi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250704.0LVzYMzi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/hugetlb.c:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/hugetlb.c:37:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/hugetlb.c:1928:6: error: use of undeclared identifier 'cgrp_dfl_root'
    1928 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |             ^
>> mm/hugetlb.c:1928:28: error: use of undeclared identifier 'CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING'
    1928 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |                                   ^
   mm/hugetlb.c:3099:6: error: use of undeclared identifier 'cgrp_dfl_root'
    3099 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |             ^
   mm/hugetlb.c:3099:28: error: use of undeclared identifier 'CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING'
    3099 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |                                   ^
   3 warnings and 4 errors generated.


vim +/cgrp_dfl_root +1928 mm/hugetlb.c

  1880	
  1881	void free_huge_folio(struct folio *folio)
  1882	{
  1883		/*
  1884		 * Can't pass hstate in here because it is called from the
  1885		 * generic mm code.
  1886		 */
  1887		struct hstate *h = folio_hstate(folio);
  1888		int nid = folio_nid(folio);
  1889		struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
  1890		bool restore_reserve;
  1891		unsigned long flags;
  1892	
  1893		VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
  1894		VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
  1895	
  1896		hugetlb_set_folio_subpool(folio, NULL);
  1897		if (folio_test_anon(folio))
  1898			__ClearPageAnonExclusive(&folio->page);
  1899		folio->mapping = NULL;
  1900		restore_reserve = folio_test_hugetlb_restore_reserve(folio);
  1901		folio_clear_hugetlb_restore_reserve(folio);
  1902	
  1903		/*
  1904		 * If HPageRestoreReserve was set on page, page allocation consumed a
  1905		 * reservation.  If the page was associated with a subpool, there
  1906		 * would have been a page reserved in the subpool before allocation
  1907		 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
  1908		 * reservation, do not call hugepage_subpool_put_pages() as this will
  1909		 * remove the reserved page from the subpool.
  1910		 */
  1911		if (!restore_reserve) {
  1912			/*
  1913			 * A return code of zero implies that the subpool will be
  1914			 * under its minimum size if the reservation is not restored
  1915			 * after page is free.  Therefore, force restore_reserve
  1916			 * operation.
  1917			 */
  1918			if (hugepage_subpool_put_pages(spool, 1) == 0)
  1919				restore_reserve = true;
  1920		}
  1921	
  1922		spin_lock_irqsave(&hugetlb_lock, flags);
  1923		folio_clear_hugetlb_migratable(folio);
  1924		hugetlb_cgroup_uncharge_folio(hstate_index(h),
  1925					     pages_per_huge_page(h), folio);
  1926		hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
  1927						  pages_per_huge_page(h), folio);
> 1928		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
  1929			lruvec_stat_mod_folio(folio, HUGETLB_B, -pages_per_huge_page(h));
  1930		mem_cgroup_uncharge(folio);
  1931		if (restore_reserve)
  1932			h->resv_huge_pages++;
  1933	
  1934		if (folio_test_hugetlb_temporary(folio)) {
  1935			remove_hugetlb_folio(h, folio, false);
  1936			spin_unlock_irqrestore(&hugetlb_lock, flags);
  1937			update_and_free_hugetlb_folio(h, folio, true);
  1938		} else if (h->surplus_huge_pages_node[nid]) {
  1939			/* remove the page from active list */
  1940			remove_hugetlb_folio(h, folio, true);
  1941			spin_unlock_irqrestore(&hugetlb_lock, flags);
  1942			update_and_free_hugetlb_folio(h, folio, true);
  1943		} else {
  1944			arch_clear_hugetlb_flags(folio);
  1945			enqueue_hugetlb_folio(h, folio);
  1946			spin_unlock_irqrestore(&hugetlb_lock, flags);
  1947		}
  1948	}
  1949	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

