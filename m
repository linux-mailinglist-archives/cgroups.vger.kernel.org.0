Return-Path: <cgroups+bounces-14017-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JDpDgEMl2lEuAIAu9opvQ
	(envelope-from <cgroups+bounces-14017-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 14:11:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B215EF1C
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 14:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41B0302AE23
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7D33A9F9;
	Thu, 19 Feb 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td0ZmKSF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CC20C463;
	Thu, 19 Feb 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506647; cv=none; b=tWwoPPRdOupNl5cSq8VZOwGcx4U3cLfBiXhl6MleaAIiGY63QKTVYhKCRdt0/75MF1flcjdRtUssru5mi11FrFQcCg4KFjV67l2Oggca3sfEIzNWfxjjiWUsjZnW18PfzZQOZpObIhD/1wt0ymDwHbj/3K6s3kAIrMgv7DatE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506647; c=relaxed/simple;
	bh=+ASt9RW3S8U9bMhrhcg5P9CXnzpEpApS+qGIkng/w1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAa4aF/jBg/EQste3CLk0lMWJ43s6RcEr0JKrP5KB50L3oxQBUwvxYZpTBNK/vW/JfSohpgM+huUgAKJHfrStcedb/cFRsNfKcrKXEBGf5ZM3Vzq8cmleSOmyBdXZkRpAo614fVno3ZTT1w8t9+r9tgsMkpv1f2hLqRw2Hwb9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td0ZmKSF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771506646; x=1803042646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ASt9RW3S8U9bMhrhcg5P9CXnzpEpApS+qGIkng/w1I=;
  b=Td0ZmKSFaTMTgHddpbHIgqBNS7fgWM2bVuUZMWgS4dFAdLupdfTTpN88
   JnTsfuouRNL0m4Nb3a21y3V9DJyWmq361QPaDxckXea+ThOq1rc7FMtHO
   VmMcoUd2AreTa0NRay8d/OBHrAR/61o5G2nkRnJI9/oCuF4Pz+IO69Zl+
   cC2doY+MAJo6PWBM0RHLqkIQOZGjjLftMKl0OFMUTreJHgsAe/kMDFr4S
   h3nHmltdf+uOW42bVKgPcq+EX5VjPRKI6FWBgORP0V/OtIpbL7kJ5bBXz
   UJpd2g4t/VDgSWEFiFMhe3EYdQLM0DNQtvpBA8/Wa2VBZwSe/DDdtoD4N
   Q==;
X-CSE-ConnectionGUID: RjQjhmt5TJGj/OKOHM0kJQ==
X-CSE-MsgGUID: AQq12pBkQFWBdN/nPTul5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="82914217"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="82914217"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 05:10:45 -0800
X-CSE-ConnectionGUID: NHFBFnBWR4uJA67vO80HYg==
X-CSE-MsgGUID: jVog3KgkTsunK42T2C/5Ig==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 05:10:39 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vt3ng-000000003yL-3aSU;
	Thu, 19 Feb 2026 13:10:36 +0000
Date: Thu, 19 Feb 2026 14:10:08 +0100
From: kernel test robot <lkp@intel.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>, linux-mm@kvack.org,
	mst@redhat.com, mhocko@suse.com, vbabka@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, apopple@nvidia.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
	eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
	hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com
Subject: Re: [PATCH v3] mm: move pgscan, pgsteal, pgrefill to node stats
Message-ID: <202602191417.23zH3uja-lkp@intel.com>
References: <20260218222652.108411-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218222652.108411-1-jp.kobryn@linux.dev>
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
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-14017-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 929B215EF1C
X-Rspamd-Action: no action

Hi JP,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn-Meta/mm-move-pgscan-pgsteal-pgrefill-to-node-stats/20260219-063016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260218222652.108411-1-jp.kobryn%40linux.dev
patch subject: [PATCH v3] mm: move pgscan, pgsteal, pgrefill to node stats
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260219/202602191417.23zH3uja-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602191417.23zH3uja-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602191417.23zH3uja-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/vmscan.c: In function 'scan_folios':
>> mm/vmscan.c:4542:28: warning: unused variable 'memcg' [-Wunused-variable]
    4542 |         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
         |                            ^~~~~


vim +/memcg +4542 mm/vmscan.c

ac35a490237446 Yu Zhao        2022-09-18  4527  
af827e0904899f Koichiro Den   2025-05-31  4528  static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
af827e0904899f Koichiro Den   2025-05-31  4529  		       struct scan_control *sc, int type, int tier,
af827e0904899f Koichiro Den   2025-05-31  4530  		       struct list_head *list)
ac35a490237446 Yu Zhao        2022-09-18  4531  {
669281ee7ef731 Kalesh Singh   2023-08-01  4532  	int i;
669281ee7ef731 Kalesh Singh   2023-08-01  4533  	int gen;
b0e9e710c6bb5a JP Kobryn      2026-02-18  4534  	enum node_stat_item item;
ac35a490237446 Yu Zhao        2022-09-18  4535  	int sorted = 0;
ac35a490237446 Yu Zhao        2022-09-18  4536  	int scanned = 0;
ac35a490237446 Yu Zhao        2022-09-18  4537  	int isolated = 0;
8c2214fc9a470a Jaewon Kim     2023-10-03  4538  	int skipped = 0;
49d921b471c513 Chen Ridong    2025-12-04  4539  	int scan_batch = min(nr_to_scan, MAX_LRU_BATCH);
49d921b471c513 Chen Ridong    2025-12-04  4540  	int remaining = scan_batch;
391655fe08d1f9 Yu Zhao        2022-12-21  4541  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
ac35a490237446 Yu Zhao        2022-09-18 @4542  	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
ac35a490237446 Yu Zhao        2022-09-18  4543  
ac35a490237446 Yu Zhao        2022-09-18  4544  	VM_WARN_ON_ONCE(!list_empty(list));
ac35a490237446 Yu Zhao        2022-09-18  4545  
ac35a490237446 Yu Zhao        2022-09-18  4546  	if (get_nr_gens(lruvec, type) == MIN_NR_GENS)
ac35a490237446 Yu Zhao        2022-09-18  4547  		return 0;
ac35a490237446 Yu Zhao        2022-09-18  4548  
ac35a490237446 Yu Zhao        2022-09-18  4549  	gen = lru_gen_from_seq(lrugen->min_seq[type]);
ac35a490237446 Yu Zhao        2022-09-18  4550  
669281ee7ef731 Kalesh Singh   2023-08-01  4551  	for (i = MAX_NR_ZONES; i > 0; i--) {
ac35a490237446 Yu Zhao        2022-09-18  4552  		LIST_HEAD(moved);
8c2214fc9a470a Jaewon Kim     2023-10-03  4553  		int skipped_zone = 0;
669281ee7ef731 Kalesh Singh   2023-08-01  4554  		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
6df1b2212950aa Yu Zhao        2022-12-21  4555  		struct list_head *head = &lrugen->folios[gen][type][zone];
ac35a490237446 Yu Zhao        2022-09-18  4556  
ac35a490237446 Yu Zhao        2022-09-18  4557  		while (!list_empty(head)) {
ac35a490237446 Yu Zhao        2022-09-18  4558  			struct folio *folio = lru_to_folio(head);
ac35a490237446 Yu Zhao        2022-09-18  4559  			int delta = folio_nr_pages(folio);
ac35a490237446 Yu Zhao        2022-09-18  4560  
ac35a490237446 Yu Zhao        2022-09-18  4561  			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
ac35a490237446 Yu Zhao        2022-09-18  4562  			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
ac35a490237446 Yu Zhao        2022-09-18  4563  			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
ac35a490237446 Yu Zhao        2022-09-18  4564  			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
ac35a490237446 Yu Zhao        2022-09-18  4565  
ac35a490237446 Yu Zhao        2022-09-18  4566  			scanned += delta;
ac35a490237446 Yu Zhao        2022-09-18  4567  
669281ee7ef731 Kalesh Singh   2023-08-01  4568  			if (sort_folio(lruvec, folio, sc, tier))
ac35a490237446 Yu Zhao        2022-09-18  4569  				sorted += delta;
ac35a490237446 Yu Zhao        2022-09-18  4570  			else if (isolate_folio(lruvec, folio, sc)) {
ac35a490237446 Yu Zhao        2022-09-18  4571  				list_add(&folio->lru, list);
ac35a490237446 Yu Zhao        2022-09-18  4572  				isolated += delta;
ac35a490237446 Yu Zhao        2022-09-18  4573  			} else {
ac35a490237446 Yu Zhao        2022-09-18  4574  				list_move(&folio->lru, &moved);
8c2214fc9a470a Jaewon Kim     2023-10-03  4575  				skipped_zone += delta;
ac35a490237446 Yu Zhao        2022-09-18  4576  			}
ac35a490237446 Yu Zhao        2022-09-18  4577  
8c2214fc9a470a Jaewon Kim     2023-10-03  4578  			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
ac35a490237446 Yu Zhao        2022-09-18  4579  				break;
ac35a490237446 Yu Zhao        2022-09-18  4580  		}
ac35a490237446 Yu Zhao        2022-09-18  4581  
8c2214fc9a470a Jaewon Kim     2023-10-03  4582  		if (skipped_zone) {
ac35a490237446 Yu Zhao        2022-09-18  4583  			list_splice(&moved, head);
8c2214fc9a470a Jaewon Kim     2023-10-03  4584  			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
8c2214fc9a470a Jaewon Kim     2023-10-03  4585  			skipped += skipped_zone;
ac35a490237446 Yu Zhao        2022-09-18  4586  		}
ac35a490237446 Yu Zhao        2022-09-18  4587  
ac35a490237446 Yu Zhao        2022-09-18  4588  		if (!remaining || isolated >= MIN_LRU_BATCH)
ac35a490237446 Yu Zhao        2022-09-18  4589  			break;
ac35a490237446 Yu Zhao        2022-09-18  4590  	}
ac35a490237446 Yu Zhao        2022-09-18  4591  
e452872b40e3f1 Hao Jia        2025-03-18  4592  	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
b0e9e710c6bb5a JP Kobryn      2026-02-18  4593  	mod_lruvec_state(lruvec, item, isolated);
b0e9e710c6bb5a JP Kobryn      2026-02-18  4594  	mod_lruvec_state(lruvec, PGREFILL, sorted);
b0e9e710c6bb5a JP Kobryn      2026-02-18  4595  	mod_lruvec_state(lruvec, PGSCAN_ANON + type, isolated);
49d921b471c513 Chen Ridong    2025-12-04  4596  	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, scan_batch,
8c2214fc9a470a Jaewon Kim     2023-10-03  4597  				scanned, skipped, isolated,
8c2214fc9a470a Jaewon Kim     2023-10-03  4598  				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
1bc542c6a0d144 Zeng Jingxiang 2024-10-26  4599  	if (type == LRU_GEN_FILE)
1bc542c6a0d144 Zeng Jingxiang 2024-10-26  4600  		sc->nr.file_taken += isolated;
ac35a490237446 Yu Zhao        2022-09-18  4601  	/*
e9d4e1ee788097 Yu Zhao        2022-12-21  4602  	 * There might not be eligible folios due to reclaim_idx. Check the
e9d4e1ee788097 Yu Zhao        2022-12-21  4603  	 * remaining to prevent livelock if it's not making progress.
ac35a490237446 Yu Zhao        2022-09-18  4604  	 */
ac35a490237446 Yu Zhao        2022-09-18  4605  	return isolated || !remaining ? scanned : 0;
ac35a490237446 Yu Zhao        2022-09-18  4606  }
ac35a490237446 Yu Zhao        2022-09-18  4607  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

