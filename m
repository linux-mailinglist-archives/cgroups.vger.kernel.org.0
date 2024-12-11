Return-Path: <cgroups+bounces-5842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28439EDBCA
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 00:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF8E166D64
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1045C1F2C4D;
	Wed, 11 Dec 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkgkb5nQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AD1C173C;
	Wed, 11 Dec 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960254; cv=none; b=fsJ0TE9wZ7bx50BksLz64TSRgRVnGAtNZpHN/08V9pMAkgVA9lx5cs+352BLsB5z1+UyGokiX2vIZ+YISvWf+7bdGq8oXTGW76wtXg3DTy+xQgaeS5xX38xtY6BbhSTDep+UB+5obPyhGFmUt4yGXBAhn4dtmW7Jzz1M98EXv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960254; c=relaxed/simple;
	bh=utgvRHnj1gJiZOnHD5B9sfHVvbJudFuB2vzSHjnVxu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7LQNJ1VuMpBYFl7UyBNFa67sjhDdVVbqAZNVF4X/3WFwHIhcyW3Iu0RJ6cwPKNEkHRbBadoaG6l2N61eKSuUgzjw3kLYEnzXo+/3LOpidhMp+bLKxqu9+tHvysYGedcKUbIlMgX02q8IC7WWLwDd1rmxr3v4csRVVEk2k4OaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkgkb5nQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733960253; x=1765496253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=utgvRHnj1gJiZOnHD5B9sfHVvbJudFuB2vzSHjnVxu8=;
  b=mkgkb5nQKts6T6yi/86tmUZG49wW/l9kRN6Cg7yEgZPMB2FaPwDv3Yx7
   mZ+9my8Y+Aml7smT0Ue+4K9MFmOn//NUBTvl0fn+vv+OSnYblwx+EWFsp
   NCLYRyZ987KH6qHIQF1nKKbYPeQHSqRKdURvE+KiZGGvOgXwkeJZRak0S
   vQGTA+XwFNkIXAballNDEOYOG0PSwXHVLZ5A+aWnKNVg3YTD6DferAsJM
   BGHqlLhV59MOwKHuzVnBn+FOr+4AUAW2gXZIPOT8Q8QpL2o+TY3tRMEPF
   TbRtpTUvCyj8SrdY75Ek2QGTuZiEoI1YqWPWAw9GKMnHXvlRn6VbeXhbD
   A==;
X-CSE-ConnectionGUID: hauxCewHRHmC+QPwFtGYPA==
X-CSE-MsgGUID: XNT/iSzdSHywu1pjqYfCVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="21944864"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="21944864"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 15:37:32 -0800
X-CSE-ConnectionGUID: xCKDKHoOQui+/6SOMOPh1w==
X-CSE-MsgGUID: Jg0/3VBrSXecJmDkOFjPMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95846851"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 Dec 2024 15:37:30 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLWGl-0007DJ-0s;
	Wed, 11 Dec 2024 23:37:27 +0000
Date: Thu, 12 Dec 2024 07:36:43 +0800
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
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <202412120722.YWlWwpqk-lkp@intel.com>
References: <20241211043252.3295947-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/vmalloc-Account-memcg-per-vmalloc/20241211-123433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241211043252.3295947-2-willy%40infradead.org
patch subject: [PATCH 2/2] vmalloc: Account memcg per vmalloc
config: sparc64-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20241212/202412120722.YWlWwpqk-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120722.YWlWwpqk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120722.YWlWwpqk-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: mm/vmalloc.o: in function `vfree':
>> mm/vmalloc.c:3386:(.text+0x6bbc): undefined reference to `obj_cgroup_uncharge_vmalloc'
   sparc64-linux-ld: mm/vmalloc.o: in function `__vmalloc_area_node':
>> mm/vmalloc.c:3676:(.text+0x6f94): undefined reference to `obj_cgroup_charge_vmalloc'


vim +3386 mm/vmalloc.c

  3329	
  3330	/**
  3331	 * vfree - Release memory allocated by vmalloc()
  3332	 * @addr:  Memory base address
  3333	 *
  3334	 * Free the virtually continuous memory area starting at @addr, as obtained
  3335	 * from one of the vmalloc() family of APIs.  This will usually also free the
  3336	 * physical memory underlying the virtual allocation, but that memory is
  3337	 * reference counted, so it will not be freed until the last user goes away.
  3338	 *
  3339	 * If @addr is NULL, no operation is performed.
  3340	 *
  3341	 * Context:
  3342	 * May sleep if called *not* from interrupt context.
  3343	 * Must not be called in NMI context (strictly speaking, it could be
  3344	 * if we have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, but making the calling
  3345	 * conventions for vfree() arch-dependent would be a really bad idea).
  3346	 */
  3347	void vfree(const void *addr)
  3348	{
  3349		struct vm_struct *vm;
  3350		int i;
  3351	
  3352		if (unlikely(in_interrupt())) {
  3353			vfree_atomic(addr);
  3354			return;
  3355		}
  3356	
  3357		BUG_ON(in_nmi());
  3358		kmemleak_free(addr);
  3359		might_sleep();
  3360	
  3361		if (!addr)
  3362			return;
  3363	
  3364		vm = remove_vm_area(addr);
  3365		if (unlikely(!vm)) {
  3366			WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
  3367					addr);
  3368			return;
  3369		}
  3370	
  3371		if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
  3372			vm_reset_perms(vm);
  3373		for (i = 0; i < vm->nr_pages; i++) {
  3374			struct page *page = vm->pages[i];
  3375	
  3376			BUG_ON(!page);
  3377			/*
  3378			 * High-order allocs for huge vmallocs are split, so
  3379			 * can be freed as an array of order-0 allocations
  3380			 */
  3381			__free_page(page);
  3382			cond_resched();
  3383		}
  3384		if (!(vm->flags & VM_MAP_PUT_PAGES))
  3385			atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
> 3386		obj_cgroup_uncharge_vmalloc(vm->objcg, vm->nr_pages);
  3387		kvfree(vm->pages);
  3388		kfree(vm);
  3389	}
  3390	EXPORT_SYMBOL(vfree);
  3391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

