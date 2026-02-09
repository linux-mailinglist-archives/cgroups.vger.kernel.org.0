Return-Path: <cgroups+bounces-13799-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMSyAbhCiWmK5QQAu9opvQ
	(envelope-from <cgroups+bounces-13799-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 03:13:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B410B009
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 03:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A46301828B
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 02:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE52C0F72;
	Mon,  9 Feb 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRZUVrfZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1289298CC9;
	Mon,  9 Feb 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770603162; cv=none; b=g02vYWycedeVO5TotGbnXQ3iUPDAErC6D+ma3dnXvlExN28ZklTr7iaxSMBNdFhc1GaDVG2rEYcp8uNSYfc9gN5Zf7vDag08GPTM1cj4F/r+x/fpgTkTh7TD9w8daIcVyEMMfF8WSs9rVpUje7iHkO3m1lOn7ALMchFIVYb3JF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770603162; c=relaxed/simple;
	bh=JimVqJbGLErbVoUw3/1ZrbUgMnX0GyqHbji4ngZyjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pghK4iAe241F0swaUWEsRTwwfndheTAZJxSiMd7Hh+aT8Rf/lALVpvd2b/fsHsO7GVASvr4Bsfmhvjfj9Yn92Ejkpovq2zMGv/37T+cfuUxVX2vKYEhzXO5iwHeex48zm2u5JA89ytLmeGSg/Kl9CWZ4yNKgiElx7ryFHzSFZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRZUVrfZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770603162; x=1802139162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JimVqJbGLErbVoUw3/1ZrbUgMnX0GyqHbji4ngZyjxg=;
  b=XRZUVrfZN1YeqcWqOV3iaLeLkICotbytFhmKAYWDtEBtAKp6nbnt8Jgy
   nH2VkHdget2mUJfBy2z4dtLpv2UzpFn6Uc+I413cKfhgiV7+oWY3ycxmB
   9wxMlIm4cprop2N3zD4enfYh89xZxAwxuNkC9JR4YB3+l98QNMjSwbjBP
   bOZQp96BzqsvCvM0z4rzk2goHUlXk62rUbu/JA5cWbp6fX5+li4Kywknc
   AjO/20b4OCkeeZDHOFFMOqtdWEOpBZwTQU4mXDcBiEdGwkvQvHoVLJ5rP
   mOxURgPm9MwIEq+vZt4Y0m1vSl5CvjvvF/KAfjksGmtO4Dni0tBYEE43U
   Q==;
X-CSE-ConnectionGUID: pHpeYrKrR+yK0NtvwnfcxA==
X-CSE-MsgGUID: oVqHP5o/Rm+ZxER3vPk8Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83152686"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83152686"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 18:12:41 -0800
X-CSE-ConnectionGUID: xhkRuhfrTKGXkNC6w+H8Gw==
X-CSE-MsgGUID: V2n4KtwMTbyb4rXhMCRIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211241351"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Feb 2026 18:12:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpGlL-00000000mVk-0Sao;
	Mon, 09 Feb 2026 02:12:31 +0000
Date: Mon, 9 Feb 2026 10:12:02 +0800
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
Subject: Re: [PATCH v3 18/20] memcg: swap: only charge physical swap slots
Message-ID: <202602091006.0jXoavPW-lkp@intel.com>
References: <20260208215839.87595-19-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208215839.87595-19-nphamcs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-13799-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 946B410B009
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
patch link:    https://lore.kernel.org/r/20260208215839.87595-19-nphamcs%40gmail.com
patch subject: [PATCH v3 18/20] memcg: swap: only charge physical swap slots
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20260209/202602091006.0jXoavPW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260209/202602091006.0jXoavPW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602091006.0jXoavPW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vswap.c:637:2: error: call to undeclared function 'mem_cgroup_clear_swap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     637 |         mem_cgroup_clear_swap(entry, 1);
         |         ^
   mm/vswap.c:637:2: note: did you mean 'mem_cgroup_uncharge_swap'?
   include/linux/swap.h:658:20: note: 'mem_cgroup_uncharge_swap' declared here
     658 | static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
         |                    ^
>> mm/vswap.c:661:2: error: call to undeclared function 'mem_cgroup_record_swap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     661 |         mem_cgroup_record_swap(folio, entry);
         |         ^
   mm/vswap.c:661:2: note: did you mean 'mem_cgroup_uncharge_swap'?
   include/linux/swap.h:658:20: note: 'mem_cgroup_uncharge_swap' declared here
     658 | static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
         |                    ^
   2 errors generated.


vim +/mem_cgroup_clear_swap +637 mm/vswap.c

   528	
   529	/*
   530	 * Caller needs to handle races with other operations themselves.
   531	 *
   532	 * Specifically, this function is safe to be called in contexts where the swap
   533	 * entry has been added to the swap cache and the associated folio is locked.
   534	 * We cannot race with other accessors, and the swap entry is guaranteed to be
   535	 * valid the whole time (since swap cache implies one refcount).
   536	 *
   537	 * We cannot assume that the backends will be of the same type,
   538	 * contiguous, etc. We might have a large folio coalesced from subpages with
   539	 * mixed backend, which is only rectified when it is reclaimed.
   540	 */
   541	 static void release_backing(swp_entry_t entry, int nr)
   542	{
   543		struct vswap_cluster *cluster = NULL;
   544		struct swp_desc *desc;
   545		unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
   546		unsigned long phys_swap_released = 0;
   547		unsigned int phys_swap_type = 0;
   548		bool need_flushing_phys_swap = false;
   549		swp_slot_t flush_slot;
   550		int i;
   551	
   552		VM_WARN_ON(!entry.val);
   553	
   554		rcu_read_lock();
   555		for (i = 0; i < nr; i++) {
   556			desc = vswap_iter(&cluster, entry.val + i);
   557			VM_WARN_ON(!desc);
   558	
   559			/*
   560			 * We batch contiguous physical swap slots for more efficient
   561			 * freeing.
   562			 */
   563			if (phys_swap_start != phys_swap_end &&
   564					(desc->type != VSWAP_SWAPFILE ||
   565						swp_slot_type(desc->slot) != phys_swap_type ||
   566						swp_slot_offset(desc->slot) != phys_swap_end)) {
   567				need_flushing_phys_swap = true;
   568				flush_slot = swp_slot(phys_swap_type, phys_swap_start);
   569				flush_nr = phys_swap_end - phys_swap_start;
   570				phys_swap_start = phys_swap_end = 0;
   571			}
   572	
   573			if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
   574				zswap_entry_free(desc->zswap_entry);
   575			} else if (desc->type == VSWAP_SWAPFILE) {
   576				phys_swap_released++;
   577				if (!phys_swap_start) {
   578					/* start a new contiguous range of phys swap */
   579					phys_swap_start = swp_slot_offset(desc->slot);
   580					phys_swap_end = phys_swap_start + 1;
   581					phys_swap_type = swp_slot_type(desc->slot);
   582				} else {
   583					/* extend the current contiguous range of phys swap */
   584					phys_swap_end++;
   585				}
   586			}
   587	
   588			desc->slot.val = 0;
   589	
   590			if (need_flushing_phys_swap) {
   591				spin_unlock(&cluster->lock);
   592				cluster = NULL;
   593				swap_slot_free_nr(flush_slot, flush_nr);
   594				need_flushing_phys_swap = false;
   595			}
   596		}
   597		if (cluster)
   598			spin_unlock(&cluster->lock);
   599		rcu_read_unlock();
   600	
   601		/* Flush any remaining physical swap range */
   602		if (phys_swap_start) {
   603			flush_slot = swp_slot(phys_swap_type, phys_swap_start);
   604			flush_nr = phys_swap_end - phys_swap_start;
   605			swap_slot_free_nr(flush_slot, flush_nr);
   606		}
   607	
   608		if (phys_swap_released)
   609			mem_cgroup_uncharge_swap(entry, phys_swap_released);
   610	 }
   611	
   612	/*
   613	 * Entered with the cluster locked, but might unlock the cluster.
   614	 * This is because several operations, such as releasing physical swap slots
   615	 * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
   616	 * deadlocks.
   617	 *
   618	 * This is safe, because:
   619	 *
   620	 * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
   621	 *    down to 0, so no one can change its internal state
   622	 *
   623	 * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
   624	 *    the cluster itself valid.
   625	 *
   626	 * We will exit the function with the cluster re-locked.
   627	 */
   628	static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
   629		swp_entry_t entry)
   630	{
   631		/* Clear shadow if present */
   632		if (xa_is_value(desc->shadow))
   633			desc->shadow = NULL;
   634		spin_unlock(&cluster->lock);
   635	
   636		release_backing(entry, 1);
 > 637		mem_cgroup_clear_swap(entry, 1);
   638	
   639		/* erase forward mapping and release the virtual slot for reallocation */
   640		spin_lock(&cluster->lock);
   641		release_vswap_slot(cluster, entry.val);
   642	}
   643	
   644	/**
   645	 * folio_alloc_swap - allocate virtual swap space for a folio.
   646	 * @folio: the folio.
   647	 *
   648	 * Return: 0, if the allocation succeeded, -ENOMEM, if the allocation failed.
   649	 */
   650	int folio_alloc_swap(struct folio *folio)
   651	{
   652		swp_entry_t entry;
   653	
   654		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
   655		VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
   656	
   657		entry = vswap_alloc(folio);
   658		if (!entry.val)
   659			return -ENOMEM;
   660	
 > 661		mem_cgroup_record_swap(folio, entry);
   662		swap_cache_add_folio(folio, entry, NULL);
   663	
   664		return 0;
   665	}
   666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

