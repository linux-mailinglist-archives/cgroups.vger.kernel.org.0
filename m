Return-Path: <cgroups+bounces-5494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47569C29C1
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 04:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06654B2205B
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 03:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8913A863;
	Sat,  9 Nov 2024 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J84mkEXf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16D1EEE9;
	Sat,  9 Nov 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123816; cv=none; b=UFZkFvRBzEM9MrfIAKRe/83tECVgw0DpkYxBrCdQsyrJkRdEi1Czx3rlGGUuzybohusGJna97EaJ7SVZSmNzYltT6om+IGC5nqNBkh3Ev7BWxXN9rjsUuwPSlBWxjPWSrNzomWo911c2HOwCJHjPsfkAIdagMRq1utVuJCVgjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123816; c=relaxed/simple;
	bh=Y8gRkvKe4SZgufdVa38PVa6F32tIaLfPt8fCTz17p8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzOoygDpzphBnd/Dsi9vBrCKiF7YBxKZUBunQUrQ0AcUzAk803Dz79bm4S6Oa35qQTdabiYQGVol8U6hMq+it0ZylV/Bw9M/M/kknRpeqZ/cL6RxVy5SEHnLI4ZwtcMhozhNoJcNvfKf6rDC3A6dyRRDXvJfcCT5eIGD/Hl9DXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J84mkEXf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731123814; x=1762659814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8gRkvKe4SZgufdVa38PVa6F32tIaLfPt8fCTz17p8c=;
  b=J84mkEXfHJBRTs6IcrMmgigJClIAf2ZxcBCmvkzvqKwEiKhm7QPYH0k2
   v2N0p7Ew5/Efxq6QymW4qDOK7uMrSqCAyT9rulx500CHkLmd7xovPfCC6
   FP/HYu6KNbaarllpQ3Pu8BOrkIMPX8fzfh6lD5TnR6s64PqttbwCEpDKn
   3HrNwxAcCdpFsuv1sPFYzUO8Cn3YX1yoP3kCVAF4jJL9/iHtgeUNUT3Ty
   Xnl/49CILIVwyibCHQ+OtO4anPauaC5bXbEmNw3mbPsmOZF8RZsHSlf7s
   5kblxKgOgiMzcdQUBGtCXB1xCQUy8B3ureEGJRg3kX6qX4EaDHt6Pk9Rf
   A==;
X-CSE-ConnectionGUID: Wmdnyq1qQGODQxM0DsayTA==
X-CSE-MsgGUID: JxFQc5dXRsiucm+fsw50Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="31119795"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="31119795"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 19:43:34 -0800
X-CSE-ConnectionGUID: DQEC6TZSTMOTmE2o2Y8U8w==
X-CSE-MsgGUID: ncml/TeXT0KH3hsYQspbEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="90956920"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Nov 2024 19:43:30 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9cNk-000s2w-0i;
	Sat, 09 Nov 2024 03:43:28 +0000
Date: Sat, 9 Nov 2024 11:42:43 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, shakeel.butt@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Message-ID: <202411091159.y6yDCkdf-lkp@intel.com>
References: <20241108212946.2642085-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108212946.2642085-3-joshua.hahnjy@gmail.com>

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20241108]
[cannot apply to linus/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/memcg-hugetlb-Introduce-memcg_accounts_hugetlb/20241109-053045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241108212946.2642085-3-joshua.hahnjy%40gmail.com
patch subject: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241109/202411091159.y6yDCkdf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411091159.y6yDCkdf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411091159.y6yDCkdf-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/hugetlb.c: In function 'alloc_hugetlb_folio':
>> mm/hugetlb.c:3083:15: error: implicit declaration of function 'mem_cgroup_charge_hugetlb'; did you mean 'mem_cgroup_charge_skmem'? [-Werror=implicit-function-declaration]
    3083 |         ret = mem_cgroup_charge_hugetlb(folio, gfp);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |               mem_cgroup_charge_skmem
   cc1: some warnings being treated as errors


vim +3083 mm/hugetlb.c

  2963	
  2964	struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
  2965					    unsigned long addr, int avoid_reserve)
  2966	{
  2967		struct hugepage_subpool *spool = subpool_vma(vma);
  2968		struct hstate *h = hstate_vma(vma);
  2969		struct folio *folio;
  2970		long map_chg, map_commit;
  2971		long gbl_chg;
  2972		int ret, idx;
  2973		struct hugetlb_cgroup *h_cg = NULL;
  2974		bool deferred_reserve;
  2975		gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
  2976	
  2977		idx = hstate_index(h);
  2978		/*
  2979		 * Examine the region/reserve map to determine if the process
  2980		 * has a reservation for the page to be allocated.  A return
  2981		 * code of zero indicates a reservation exists (no change).
  2982		 */
  2983		map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
  2984		if (map_chg < 0)
  2985			return ERR_PTR(-ENOMEM);
  2986	
  2987		/*
  2988		 * Processes that did not create the mapping will have no
  2989		 * reserves as indicated by the region/reserve map. Check
  2990		 * that the allocation will not exceed the subpool limit.
  2991		 * Allocations for MAP_NORESERVE mappings also need to be
  2992		 * checked against any subpool limit.
  2993		 */
  2994		if (map_chg || avoid_reserve) {
  2995			gbl_chg = hugepage_subpool_get_pages(spool, 1);
  2996			if (gbl_chg < 0)
  2997				goto out_end_reservation;
  2998	
  2999			/*
  3000			 * Even though there was no reservation in the region/reserve
  3001			 * map, there could be reservations associated with the
  3002			 * subpool that can be used.  This would be indicated if the
  3003			 * return value of hugepage_subpool_get_pages() is zero.
  3004			 * However, if avoid_reserve is specified we still avoid even
  3005			 * the subpool reservations.
  3006			 */
  3007			if (avoid_reserve)
  3008				gbl_chg = 1;
  3009		}
  3010	
  3011		/* If this allocation is not consuming a reservation, charge it now.
  3012		 */
  3013		deferred_reserve = map_chg || avoid_reserve;
  3014		if (deferred_reserve) {
  3015			ret = hugetlb_cgroup_charge_cgroup_rsvd(
  3016				idx, pages_per_huge_page(h), &h_cg);
  3017			if (ret)
  3018				goto out_subpool_put;
  3019		}
  3020	
  3021		ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
  3022		if (ret)
  3023			goto out_uncharge_cgroup_reservation;
  3024	
  3025		spin_lock_irq(&hugetlb_lock);
  3026		/*
  3027		 * glb_chg is passed to indicate whether or not a page must be taken
  3028		 * from the global free pool (global change).  gbl_chg == 0 indicates
  3029		 * a reservation exists for the allocation.
  3030		 */
  3031		folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
  3032		if (!folio) {
  3033			spin_unlock_irq(&hugetlb_lock);
  3034			folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
  3035			if (!folio)
  3036				goto out_uncharge_cgroup;
  3037			spin_lock_irq(&hugetlb_lock);
  3038			if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
  3039				folio_set_hugetlb_restore_reserve(folio);
  3040				h->resv_huge_pages--;
  3041			}
  3042			list_add(&folio->lru, &h->hugepage_activelist);
  3043			folio_ref_unfreeze(folio, 1);
  3044			/* Fall through */
  3045		}
  3046	
  3047		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
  3048		/* If allocation is not consuming a reservation, also store the
  3049		 * hugetlb_cgroup pointer on the page.
  3050		 */
  3051		if (deferred_reserve) {
  3052			hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
  3053							  h_cg, folio);
  3054		}
  3055	
  3056		spin_unlock_irq(&hugetlb_lock);
  3057	
  3058		hugetlb_set_folio_subpool(folio, spool);
  3059	
  3060		map_commit = vma_commit_reservation(h, vma, addr);
  3061		if (unlikely(map_chg > map_commit)) {
  3062			/*
  3063			 * The page was added to the reservation map between
  3064			 * vma_needs_reservation and vma_commit_reservation.
  3065			 * This indicates a race with hugetlb_reserve_pages.
  3066			 * Adjust for the subpool count incremented above AND
  3067			 * in hugetlb_reserve_pages for the same page.  Also,
  3068			 * the reservation count added in hugetlb_reserve_pages
  3069			 * no longer applies.
  3070			 */
  3071			long rsv_adjust;
  3072	
  3073			rsv_adjust = hugepage_subpool_put_pages(spool, 1);
  3074			hugetlb_acct_memory(h, -rsv_adjust);
  3075			if (deferred_reserve) {
  3076				spin_lock_irq(&hugetlb_lock);
  3077				hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
  3078						pages_per_huge_page(h), folio);
  3079				spin_unlock_irq(&hugetlb_lock);
  3080			}
  3081		}
  3082	
> 3083		ret = mem_cgroup_charge_hugetlb(folio, gfp);
  3084		if (ret == -ENOMEM) {
  3085			spin_unlock_irq(&hugetlb_lock);
  3086			free_huge_folio(folio);
  3087			return ERR_PTR(-ENOMEM);
  3088		}
  3089		else if (!ret)
  3090			lruvec_stat_mod_folio(folio, NR_HUGETLB,
  3091			      pages_per_huge_page(h));
  3092	
  3093		return folio;
  3094	
  3095	out_uncharge_cgroup:
  3096		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
  3097	out_uncharge_cgroup_reservation:
  3098		if (deferred_reserve)
  3099			hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
  3100							    h_cg);
  3101	out_subpool_put:
  3102		if (map_chg || avoid_reserve)
  3103			hugepage_subpool_put_pages(spool, 1);
  3104	out_end_reservation:
  3105		vma_end_reservation(h, vma, addr);
  3106		return ERR_PTR(-ENOSPC);
  3107	}
  3108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

