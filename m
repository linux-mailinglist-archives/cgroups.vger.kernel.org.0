Return-Path: <cgroups+bounces-5495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708DD9C2A4D
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 06:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466DF1C20F98
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 05:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0944113C9D9;
	Sat,  9 Nov 2024 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2NZaIko"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F613B2A2;
	Sat,  9 Nov 2024 05:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731129938; cv=none; b=BTv0BAi5wKundKNQ65fG8ZCxDJSIzWUDjvZqWcIKLWfbMjDYyaY9UXwwwK3DIjU1TYdMuoXP4uRkVp3xsJblFwpgsupBkkxomEHcw573I/DJjnE8RLWd+gk3jmPMKlox0IQK+SwWIyHH2oyL3hYcwwdo055kZqqsFT64LKVt8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731129938; c=relaxed/simple;
	bh=V7Rias5c3jg1UeLsuYAuYQvGfeJT4hPJeYrmiPdzrs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaiWafMB8gTVv38X0frLCWMDtSVBhq53ev/1ztogoM1/MPY93IEwvMC2/xdfMuossRWqTldKsFd95IbWNBf2uDgxzAh7hrYzemgrTnBlp5POFZlY7emVXGspx7A/wi5A13JtBanQopXoI3rGK97AwV/AsbwJ6RFUF82pXS3/Y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2NZaIko; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731129936; x=1762665936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7Rias5c3jg1UeLsuYAuYQvGfeJT4hPJeYrmiPdzrs0=;
  b=j2NZaIkoxFeG3x3X0cZUZ9CZ5PDp6U24NXKLuQDeIVCGeBKMfKRaW7Pj
   j2aj2KoF6LmSKsCvf0KW0j7rGM3dirVDJykblFEC967mM6qWaAIO6JxkV
   S8se4QymOu+woD5ymLIY4SQDpDjtrVSBId0BAJ5ErIPXTfNww9e8/r7sX
   M40Mte0YQRh2mrY3S8BCsszSx5GaT+8b+x6Ge06BT58uhv0QMFHpUYtpf
   gOWHHSM1UvS+hDhCIUojM7zO1BLZD4Ye2yyxZv7rZB1uLTHt1fNti3qyi
   yPmCakAQn3Rwz/dk+Ha/cHQr6hJAX2p95cTK93z+GECDcmxS3GgjI5rLd
   g==;
X-CSE-ConnectionGUID: L1KHj/mPSyidEGSDA+1Cmw==
X-CSE-MsgGUID: QwsjFY0JSQCEdkliqvcOUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="31244370"
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="31244370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 21:25:35 -0800
X-CSE-ConnectionGUID: u1xmh9p1SpC3dBpK8TB6yA==
X-CSE-MsgGUID: s4hlyDFJQem3BV+GLbwc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="109196451"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2024 21:25:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9dyU-000s6K-1e;
	Sat, 09 Nov 2024 05:25:30 +0000
Date: Sat, 9 Nov 2024 13:24:40 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, shakeel.butt@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Message-ID: <202411091344.51lAbqmY-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-002-20241109 (https://download.01.org/0day-ci/archive/20241109/202411091344.51lAbqmY-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411091344.51lAbqmY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411091344.51lAbqmY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/hugetlb.c:8:
   In file included from include/linux/mm.h:2211:
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
>> mm/hugetlb.c:3083:8: error: call to undeclared function 'mem_cgroup_charge_hugetlb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3083 |         ret = mem_cgroup_charge_hugetlb(folio, gfp);
         |               ^
   mm/hugetlb.c:3083:8: note: did you mean 'mem_cgroup_charge_skmem'?
   include/linux/memcontrol.h:1613:6: note: 'mem_cgroup_charge_skmem' declared here
    1613 | bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
         |      ^
   3 warnings and 1 error generated.


vim +/mem_cgroup_charge_hugetlb +3083 mm/hugetlb.c

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

