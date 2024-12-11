Return-Path: <cgroups+bounces-5796-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB79C9ECA03
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE35162DD6
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE61EC4E0;
	Wed, 11 Dec 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnjyCm23"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD18489;
	Wed, 11 Dec 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911907; cv=none; b=b+hPVI0aou0HoQ3Y+s70stUh3WJM1moyOdnK4CQLZbBj/BGEMw8dx3rz4eOCpOpPToO4xmUBIvfNeMj1Q6C1LZWEA7g+ZinziQTqVhgxRWxQZoAVjeJDq9oN1NybdFoBUPJvZUpY3iVSQJu44YvMvn7nxXBY5BZrjpqP+0QLEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911907; c=relaxed/simple;
	bh=tGwE365nj1d7bmLvCqz8mxqdyk12syQR16BTjMYprpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAcYqH/vDiqWwaDHuVpDVLYOq2+/G6wYDYRDqSNpuhpwrD5DO2rzOqNlWBmA+ximYOvj4ZSJ4N+WyuiLH2803CTUlsxpGTZePdYGDQOWGYdifMGwnRbIqzLsStK75N36kpGYBBeYCRz0TPLYH5qhTm3dOlv3L7JvCMc4TmZJ+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnjyCm23; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733911906; x=1765447906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tGwE365nj1d7bmLvCqz8mxqdyk12syQR16BTjMYprpg=;
  b=dnjyCm23jGW/kFWnKJ3hgidaTJYYCR5okxJTxwoJpitCifoxfh2DPO7z
   iATQyCoDAzzo0T2W3mL+2rPhtGpXl1GhluyHNfwBlFIoqH9bm1tmeJyws
   A8lAH0Xmsc7vB4LkH+DkzhwzNkC2FpwoznwSqjet3ZzpB+WjnKgO4o90y
   qbC/B6CHZB2Tl25mB4364djSuLygz9jfgLlTKDhalDiqPShF7Nt0iDNg0
   yCWalujWIbvv/EvIv+dqYAYogBWkRbPoNY67kESMj3kP5MEswgI9JKEFE
   33vxI20jSN3yo8cs+6uB/JX+8+Vg/fbA60UTSJwbG4+a3n4jgUFxpScOJ
   Q==;
X-CSE-ConnectionGUID: Ul3ymRylR+OLplaHVTrlCw==
X-CSE-MsgGUID: 8R7GZVZWQyq1Hpfaz8pVAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34016597"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34016597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 02:11:45 -0800
X-CSE-ConnectionGUID: N5KSQ7dBS/m9MGGu6Z2PWw==
X-CSE-MsgGUID: Ulot6HeBQAei+KlKGMZ0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="126584011"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2024 02:11:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLJgw-0006X3-2Q;
	Wed, 11 Dec 2024 10:11:38 +0000
Date: Wed, 11 Dec 2024 18:11:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmalloc: Move memcg logic into memcg code
Message-ID: <202412111725.koF7jNeD-lkp@intel.com>
References: <20241210193035.2667005-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210193035.2667005-1-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/vmalloc-Move-memcg-logic-into-memcg-code/20241211-033214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241210193035.2667005-1-willy%40infradead.org
patch subject: [PATCH] vmalloc: Move memcg logic into memcg code
config: m68k-randconfig-r112-20241211 (https://download.01.org/0day-ci/archive/20241211/202412111725.koF7jNeD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241211/202412111725.koF7jNeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412111725.koF7jNeD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/vmalloc.c:3675:55: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int nr_pages @@     got restricted gfp_t [assigned] [usertype] gfp_mask @@
   mm/vmalloc.c:3675:55: sparse:     expected unsigned int nr_pages
   mm/vmalloc.c:3675:55: sparse:     got restricted gfp_t [assigned] [usertype] gfp_mask
>> mm/vmalloc.c:3675:69: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted gfp_t [usertype] gfp @@     got unsigned int nr_pages @@
   mm/vmalloc.c:3675:69: sparse:     expected restricted gfp_t [usertype] gfp
   mm/vmalloc.c:3675:69: sparse:     got unsigned int nr_pages
   mm/vmalloc.c:180:74: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:231:74: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:282:74: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:384:46: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:407:46: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:427:46: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:531:46: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:549:46: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:567:46: sparse: sparse: self-comparison always evaluates to false
   mm/vmalloc.c:1054:25: sparse: sparse: context imbalance in 'find_vmap_area_exceed_addr_lock' - wrong count at exit
   mm/vmalloc.c:4426:28: sparse: sparse: context imbalance in 'vread_iter' - unexpected unlock

vim +3675 mm/vmalloc.c

  3623	
  3624	static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  3625					 pgprot_t prot, unsigned int page_shift,
  3626					 int node)
  3627	{
  3628		const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
  3629		bool nofail = gfp_mask & __GFP_NOFAIL;
  3630		unsigned long addr = (unsigned long)area->addr;
  3631		unsigned long size = get_vm_area_size(area);
  3632		unsigned long array_size;
  3633		unsigned int nr_small_pages = size >> PAGE_SHIFT;
  3634		unsigned int page_order;
  3635		unsigned int flags;
  3636		int ret;
  3637	
  3638		array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
  3639	
  3640		if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
  3641			gfp_mask |= __GFP_HIGHMEM;
  3642	
  3643		/* Please note that the recursion is strictly bounded. */
  3644		if (array_size > PAGE_SIZE) {
  3645			area->pages = __vmalloc_node_noprof(array_size, 1, nested_gfp, node,
  3646						area->caller);
  3647		} else {
  3648			area->pages = kmalloc_node_noprof(array_size, nested_gfp, node);
  3649		}
  3650	
  3651		if (!area->pages) {
  3652			warn_alloc(gfp_mask, NULL,
  3653				"vmalloc error: size %lu, failed to allocated page array size %lu",
  3654				nr_small_pages * PAGE_SIZE, array_size);
  3655			free_vm_area(area);
  3656			return NULL;
  3657		}
  3658	
  3659		set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
  3660		page_order = vm_area_page_order(area);
  3661	
  3662		/*
  3663		 * High-order nofail allocations are really expensive and
  3664		 * potentially dangerous (pre-mature OOM, disruptive reclaim
  3665		 * and compaction etc.
  3666		 *
  3667		 * Please note, the __vmalloc_node_range_noprof() falls-back
  3668		 * to order-0 pages if high-order attempt is unsuccessful.
  3669		 */
  3670		area->nr_pages = vm_area_alloc_pages((page_order ?
  3671			gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
  3672			node, page_order, nr_small_pages, area->pages);
  3673	
  3674		atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> 3675		ret = obj_cgroup_charge_vmalloc(&area->objcg, gfp_mask, area->nr_pages);
  3676		if (ret)
  3677			goto fail;
  3678	
  3679		/*
  3680		 * If not enough pages were obtained to accomplish an
  3681		 * allocation request, free them via vfree() if any.
  3682		 */
  3683		if (area->nr_pages != nr_small_pages) {
  3684			/*
  3685			 * vm_area_alloc_pages() can fail due to insufficient memory but
  3686			 * also:-
  3687			 *
  3688			 * - a pending fatal signal
  3689			 * - insufficient huge page-order pages
  3690			 *
  3691			 * Since we always retry allocations at order-0 in the huge page
  3692			 * case a warning for either is spurious.
  3693			 */
  3694			if (!fatal_signal_pending(current) && page_order == 0)
  3695				warn_alloc(gfp_mask, NULL,
  3696					"vmalloc error: size %lu, failed to allocate pages",
  3697					area->nr_pages * PAGE_SIZE);
  3698			goto fail;
  3699		}
  3700	
  3701		/*
  3702		 * page tables allocations ignore external gfp mask, enforce it
  3703		 * by the scope API
  3704		 */
  3705		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
  3706			flags = memalloc_nofs_save();
  3707		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
  3708			flags = memalloc_noio_save();
  3709	
  3710		do {
  3711			ret = vmap_pages_range(addr, addr + size, prot, area->pages,
  3712				page_shift);
  3713			if (nofail && (ret < 0))
  3714				schedule_timeout_uninterruptible(1);
  3715		} while (nofail && (ret < 0));
  3716	
  3717		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
  3718			memalloc_nofs_restore(flags);
  3719		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
  3720			memalloc_noio_restore(flags);
  3721	
  3722		if (ret < 0) {
  3723			warn_alloc(gfp_mask, NULL,
  3724				"vmalloc error: size %lu, failed to map pages",
  3725				area->nr_pages * PAGE_SIZE);
  3726			goto fail;
  3727		}
  3728	
  3729		return area->addr;
  3730	
  3731	fail:
  3732		vfree(area->addr);
  3733		return NULL;
  3734	}
  3735	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

