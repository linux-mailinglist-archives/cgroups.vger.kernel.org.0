Return-Path: <cgroups+bounces-13801-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHhHHFJFiWkT5gQAu9opvQ
	(envelope-from <cgroups+bounces-13801-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 03:24:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0210B10B
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 03:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F503014751
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FF2C0F72;
	Mon,  9 Feb 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOKRM+R0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557123D291;
	Mon,  9 Feb 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770603760; cv=none; b=fUTdhN3Onmm1I/O0YU5BJZM7IJvX3D1k+0yS4fxF0zcJFKNqWfEvzf/JhKC4aA7A2hY3r9CZ87flUhDtyxr0LsbVR76npdEJGce9wPIZMCLzHE+R44Sqkuqfkl3ccw55ObZJt+o7MvvOkFFJWysVkXCC3h4S5XgwQSBHQF6amaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770603760; c=relaxed/simple;
	bh=lN29YV+zBAydXqnE2rZS6mvynhrdF/TkVSR0zGXivNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/GGF4VebFvAiUGr2UYAaE2iSZPM5yyksqKPAakpcf0mit7rXDIXurSa1em0p40hlUK1Ck2VWUMniTUyxJ/q7WKMAP3MKq9ibl0jAZXX8tRlZ/y9BblLrKqf/DqsAv0MYdiZruMpsZ7Vjt4x4AHNulK5VXAFuLVQbkimwTH8uBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOKRM+R0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770603761; x=1802139761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lN29YV+zBAydXqnE2rZS6mvynhrdF/TkVSR0zGXivNw=;
  b=SOKRM+R0/vzHBNMav07l4ZRcr20e9pREyMIjL86+eBdyOZUSO0Ql5S/y
   HL/+PTVtAYXAS0wnDWkoifN6F4S13WAFvNLGlTIV8C+Ny8xkeO7EhPvlZ
   J06KOW/yL+cPVRFzUYa7b76YOx7rL8lzZZgE4RUfvYcLuW6UK7RXDiUf8
   GLXnVrbHA4PzL0MapoG/6kYhI8IEj9/FXdvjZ+ANMBO46sSTylAM4QAJB
   HdD5+dNqy5BNVIB31FCoWMB0sNxMoSZmrrXn4vhJbf2xag4uZZeCJNUPH
   dkcYk/CyL0eMqVwHqmS9g9Ilv9jwh09dNblST2QahL/s4+OoBqrHxjbsR
   A==;
X-CSE-ConnectionGUID: D7hi41ZeSK2rgCxpFGIJOg==
X-CSE-MsgGUID: NYd0jqiwRDKzgNc1UpfKYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="97170091"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="97170091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 18:22:40 -0800
X-CSE-ConnectionGUID: CJ2DLclWQsCDNhy6DDl/HQ==
X-CSE-MsgGUID: WlgPUJxwRzOOIAmFmBzJ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241664631"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 18:22:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpGv1-00000000mVw-0scF;
	Mon, 09 Feb 2026 02:22:31 +0000
Date: Mon, 9 Feb 2026 10:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
	joshua.hahnjy@gmail.com
Subject: Re: [PATCH v3 01/20] mm/swap: decouple swap cache from physical swap
 infrastructure
Message-ID: <202602091044.soVrWeDA-lkp@intel.com>
References: <20260208215839.87595-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208215839.87595-2-nphamcs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-13801-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21A0210B10B
X-Rspamd-Action: no action

Hi Nhat,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19]
[cannot apply to akpm-mm/mm-everything tj-cgroup/for-next tip/smp/core next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/swap-rearrange-the-swap-header-file/20260209-065842
base:   linus/master
patch link:    https://lore.kernel.org/r/20260208215839.87595-2-nphamcs%40gmail.com
patch subject: [PATCH v3 01/20] mm/swap: decouple swap cache from physical swap infrastructure
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20260209/202602091044.soVrWeDA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260209/202602091044.soVrWeDA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602091044.soVrWeDA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:715:3: error: call to undeclared function 'swap_cache_lock_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     715 |                 swap_cache_lock_irq();
         |                 ^
>> mm/vmscan.c:762:3: error: call to undeclared function 'swap_cache_unlock_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     762 |                 swap_cache_unlock_irq();
         |                 ^
   mm/vmscan.c:762:3: note: did you mean 'swap_cluster_unlock_irq'?
   mm/swap.h:350:20: note: 'swap_cluster_unlock_irq' declared here
     350 | static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
         |                    ^
   mm/vmscan.c:801:3: error: call to undeclared function 'swap_cache_unlock_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     801 |                 swap_cache_unlock_irq();
         |                 ^
   3 errors generated.
--
>> mm/shmem.c:2168:2: error: call to undeclared function 'swap_cache_lock_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2168 |         swap_cache_lock_irq();
         |         ^
>> mm/shmem.c:2173:2: error: call to undeclared function 'swap_cache_unlock_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2173 |         swap_cache_unlock_irq();
         |         ^
   2 errors generated.


vim +/swap_cache_lock_irq +715 mm/vmscan.c

   700	
   701	/*
   702	 * Same as remove_mapping, but if the folio is removed from the mapping, it
   703	 * gets returned with a refcount of 0.
   704	 */
   705	static int __remove_mapping(struct address_space *mapping, struct folio *folio,
   706				    bool reclaimed, struct mem_cgroup *target_memcg)
   707	{
   708		int refcount;
   709		void *shadow = NULL;
   710	
   711		BUG_ON(!folio_test_locked(folio));
   712		BUG_ON(mapping != folio_mapping(folio));
   713	
   714		if (folio_test_swapcache(folio)) {
 > 715			swap_cache_lock_irq();
   716		} else {
   717			spin_lock(&mapping->host->i_lock);
   718			xa_lock_irq(&mapping->i_pages);
   719		}
   720	
   721		/*
   722		 * The non racy check for a busy folio.
   723		 *
   724		 * Must be careful with the order of the tests. When someone has
   725		 * a ref to the folio, it may be possible that they dirty it then
   726		 * drop the reference. So if the dirty flag is tested before the
   727		 * refcount here, then the following race may occur:
   728		 *
   729		 * get_user_pages(&page);
   730		 * [user mapping goes away]
   731		 * write_to(page);
   732		 *				!folio_test_dirty(folio)    [good]
   733		 * folio_set_dirty(folio);
   734		 * folio_put(folio);
   735		 *				!refcount(folio)   [good, discard it]
   736		 *
   737		 * [oops, our write_to data is lost]
   738		 *
   739		 * Reversing the order of the tests ensures such a situation cannot
   740		 * escape unnoticed. The smp_rmb is needed to ensure the folio->flags
   741		 * load is not satisfied before that of folio->_refcount.
   742		 *
   743		 * Note that if the dirty flag is always set via folio_mark_dirty,
   744		 * and thus under the i_pages lock, then this ordering is not required.
   745		 */
   746		refcount = 1 + folio_nr_pages(folio);
   747		if (!folio_ref_freeze(folio, refcount))
   748			goto cannot_free;
   749		/* note: atomic_cmpxchg in folio_ref_freeze provides the smp_rmb */
   750		if (unlikely(folio_test_dirty(folio))) {
   751			folio_ref_unfreeze(folio, refcount);
   752			goto cannot_free;
   753		}
   754	
   755		if (folio_test_swapcache(folio)) {
   756			swp_entry_t swap = folio->swap;
   757	
   758			if (reclaimed && !mapping_exiting(mapping))
   759				shadow = workingset_eviction(folio, target_memcg);
   760			__swap_cache_del_folio(folio, swap, shadow);
   761			memcg1_swapout(folio, swap);
 > 762			swap_cache_unlock_irq();
   763			put_swap_folio(folio, swap);
   764		} else {
   765			void (*free_folio)(struct folio *);
   766	
   767			free_folio = mapping->a_ops->free_folio;
   768			/*
   769			 * Remember a shadow entry for reclaimed file cache in
   770			 * order to detect refaults, thus thrashing, later on.
   771			 *
   772			 * But don't store shadows in an address space that is
   773			 * already exiting.  This is not just an optimization,
   774			 * inode reclaim needs to empty out the radix tree or
   775			 * the nodes are lost.  Don't plant shadows behind its
   776			 * back.
   777			 *
   778			 * We also don't store shadows for DAX mappings because the
   779			 * only page cache folios found in these are zero pages
   780			 * covering holes, and because we don't want to mix DAX
   781			 * exceptional entries and shadow exceptional entries in the
   782			 * same address_space.
   783			 */
   784			if (reclaimed && folio_is_file_lru(folio) &&
   785			    !mapping_exiting(mapping) && !dax_mapping(mapping))
   786				shadow = workingset_eviction(folio, target_memcg);
   787			__filemap_remove_folio(folio, shadow);
   788			xa_unlock_irq(&mapping->i_pages);
   789			if (mapping_shrinkable(mapping))
   790				inode_lru_list_add(mapping->host);
   791			spin_unlock(&mapping->host->i_lock);
   792	
   793			if (free_folio)
   794				free_folio(folio);
   795		}
   796	
   797		return 1;
   798	
   799	cannot_free:
   800		if (folio_test_swapcache(folio)) {
   801			swap_cache_unlock_irq();
   802		} else {
   803			xa_unlock_irq(&mapping->i_pages);
   804			spin_unlock(&mapping->host->i_lock);
   805		}
   806		return 0;
   807	}
   808	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

