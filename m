Return-Path: <cgroups+bounces-5223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB09AEB19
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FFE1F21698
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6C1D63E5;
	Thu, 24 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDNBrReM"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D1150990
	for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785188; cv=none; b=e/MPodLeiU+8FXDGAXDeMrXhjjXKMCJjdF57IuszwowVBRlbWm0+gs2IsC377lLEGB5C80GbGlPRtXH5JvrRwTrsiSe9mr6/W+3mknTnhA0xCNR110C0D45dKoVfXgdq4l1q62LovSIPwKq1F4jFA/UHJtlaUu+yDMHBvr6OOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785188; c=relaxed/simple;
	bh=b532RgiuDEm4JTJPEDSHVCxNSmNv2ryBPx5Lxa5U6v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBk+aQifZ7NjnPoYbfUyKj/A77ZSD+DhA40SNnu9krTe5PkaK/B63CZJOYXH1KBLw1snkDf1u8x7vRlXgGosVB16O4kADegC4YszxfJaP/Fqa1CXssU45oPJCtg9e3S4q2wioP+59l0VEnqWi8SgIbgGPlNPyNo8sK/U18D1/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDNBrReM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729785186; x=1761321186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b532RgiuDEm4JTJPEDSHVCxNSmNv2ryBPx5Lxa5U6v4=;
  b=aDNBrReMWBGTFkvZOBnpYP/S8NL0xAZuBBwkbhlvb2Jiv9Bqhig9SSxS
   +tkEMnZ0RfASZYW8GS6H8oYoK/UKWWcDCTYMBwo0L5Qqi8Q66GnLLrKiE
   YvplQCvilOChx/4k4Wv4fW2eJvquyTp89qO/8bP5ujL89sMh9bbqPUbYC
   Xx6nWcbvvOsG0Y1KNU5MXaud2gIXWeD2nVYMhMIrPmcxOc4YnwNdl8/MJ
   DQyLqVM+wTv+4912erBn93mg7bSkFrIKjNDS7XoiX1Bo/bWP29z0+Z40M
   8Vh2i1zbieg9r25feuktGCsKBj/U/2Q7MoKWFFUI5+Uht63e59ig/Lu8p
   w==;
X-CSE-ConnectionGUID: Tgl+NendQ1yQ8+7LPHn4ig==
X-CSE-MsgGUID: RsbWEHDhQSO+P5dkEsgqwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33329764"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33329764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:53:05 -0700
X-CSE-ConnectionGUID: 8Nvuz2CGTz+MUeXtp/r/7Q==
X-CSE-MsgGUID: 9Lly+ommTJuhSHlb9S7/WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85243329"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Oct 2024 08:53:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t408y-000Wcn-13;
	Thu, 24 Oct 2024 15:53:00 +0000
Date: Thu, 24 Oct 2024 23:52:37 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, hannes@cmpxchg.org
Cc: oe-kbuild-all@lists.linux.dev, nphamcs@gmail.com, mhocko@kernel.org,
	roman.gushcin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, lnyng@meta.com, akpm@linux-foundation.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <202410242321.pttwmbpo-lkp@intel.com>
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
config: powerpc-ep88xc_defconfig (https://download.01.org/0day-ci/archive/20241024/202410242321.pttwmbpo-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410242321.pttwmbpo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242321.pttwmbpo-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/hugetlb.c: In function 'free_huge_folio':
>> mm/hugetlb.c:1928:13: error: 'cgrp_dfl_root' undeclared (first use in this function)
    1928 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |             ^~~~~~~~~~~~~
   mm/hugetlb.c:1928:13: note: each undeclared identifier is reported only once for each function it appears in
>> mm/hugetlb.c:1928:35: error: 'CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING' undeclared (first use in this function)
    1928 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/hugetlb.c: In function 'alloc_hugetlb_folio':
   mm/hugetlb.c:3099:13: error: 'cgrp_dfl_root' undeclared (first use in this function)
    3099 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |             ^~~~~~~~~~~~~
   mm/hugetlb.c:3099:35: error: 'CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING' undeclared (first use in this function)
    3099 |         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

