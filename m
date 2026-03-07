Return-Path: <cgroups+bounces-14699-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ7VNFqDrGk1qQEAu9opvQ
	(envelope-from <cgroups+bounces-14699-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 20:58:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D122D6FE
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 20:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDAE8300CA02
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8D38F231;
	Sat,  7 Mar 2026 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXdxDGOy"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96717361DA5;
	Sat,  7 Mar 2026 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913496; cv=none; b=u4AElGw0Oli44rMHyzu0zJKo8kdE3OjOZpC8rMAID3FDtZGsuRk59zV+v4xsmgOops9qznumNyQDfwCyoClz/o1tew9iGy97dJa9XlWCYCqqc2qk++gPJxdRWUrf7x0152PiZ0KC+gadG5rtZrihHYVtsRrHRhglBSILoz52x0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913496; c=relaxed/simple;
	bh=6EfkCLhJg+AlZw6TkaO6d/504vUAp5tN3HoH1lQUwjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2JSyoShBsFzH0kCY8pg6DqdpYpHGMF23KpKBVNT32I1e9fBmD7xN80fhfrN3YWf/gt6rE8GXlW0iC6P3ViQefokdBHxvwgit7b701UAFajLN7wv79oDKAy7sXYtrS3lsm1KNpO80KNiUoqZOTUjactrm3QS+OAFVMiR1tepP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXdxDGOy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772913494; x=1804449494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EfkCLhJg+AlZw6TkaO6d/504vUAp5tN3HoH1lQUwjY=;
  b=MXdxDGOyDZOvGWmfnN6+XCR7wkzT+E+dYMqsY1zLzix+mE0uTzTMw4yx
   kr8F/GXZi4JhXmc12GRHRXRgAT9K2yzpBB5MGfWQNpEVNk9S/M6SjBULE
   943RqL6x/VwMyW1wM5t9uOHIW+SnZ2B4SVWzl1NVpMUXWYLFje0c76EVA
   coB7yB+ewuNMXFLMd0o0qWMeMp0wU/V/QHxgjJqbj4IiGAmwTXnF9xIfB
   Q0B1Xlflc/4eGn1ffpCgjpFqJT30boPQn/KQrwAFFsS0Dx6Z/lisXd1YQ
   o7PBBV/1cs9/Bm0M9Nd7CL9mrr7+xzsChCabHVYWgJwsTyxaeND8n7PEz
   A==;
X-CSE-ConnectionGUID: q2DgOJgkQSKaHZt0+JIVWg==
X-CSE-MsgGUID: Hq2ZkY4BRJO/XXEz5XPE7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="74038493"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="74038493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 11:58:13 -0800
X-CSE-ConnectionGUID: Wlk16Iu4Q/eU4k+9d912cQ==
X-CSE-MsgGUID: /0+ldayrS5+1d6aZKJqv6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="218552919"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2026 11:58:05 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyxmj-000000002b5-2cTQ;
	Sat, 07 Mar 2026 19:58:01 +0000
Date: Sun, 8 Mar 2026 03:57:41 +0800
From: kernel test robot <lkp@intel.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, apopple@nvidia.com,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <202603080349.ya7tIjgk-lkp@intel.com>
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307045520.247998-1-jp.kobryn@linux.dev>
X-Rspamd-Queue-Id: 7B9D122D6FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-14699-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi JP,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn-Meta/mm-mempolicy-track-page-allocations-per-mempolicy/20260307-125642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260307045520.247998-1-jp.kobryn%40linux.dev
patch subject: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
config: arm64-randconfig-001-20260307 (https://download.01.org/0day-ci/archive/20260308/202603080349.ya7tIjgk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080349.ya7tIjgk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080349.ya7tIjgk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   mm/mempolicy.c: In function 'mpol_count_numa_alloc':
>> mm/mempolicy.c:2489:10: error: implicit declaration of function 'mem_cgroup_from_task'; did you mean 'perf_cgroup_from_task'? [-Werror=implicit-function-declaration]
     memcg = mem_cgroup_from_task(current);
             ^~~~~~~~~~~~~~~~~~~~
             perf_cgroup_from_task
>> mm/mempolicy.c:2489:8: warning: assignment to 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     memcg = mem_cgroup_from_task(current);
           ^
   cc1: some warnings being treated as errors


vim +2489 mm/mempolicy.c

  2429	
  2430	/*
  2431	 * Count a mempolicy allocation. Stats are tracked per-node and per-cgroup.
  2432	 * The following numa_{hit/miss/foreign} pattern is used:
  2433	 *
  2434	 *   hit
  2435	 *     - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
  2436	 *     - for other policies, allocation succeeded on intended node
  2437	 *     - counted on the node of the allocation
  2438	 *   miss
  2439	 *     - allocation intended for other node, but happened on this one
  2440	 *     - counted on other node
  2441	 *   foreign
  2442	 *     - allocation intended on this node, but happened on other node
  2443	 *     - counted on this node
  2444	 */
  2445	static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
  2446					  struct page *page, unsigned int order)
  2447	{
  2448		int actual_nid = page_to_nid(page);
  2449		long nr_pages = 1L << order;
  2450		enum node_stat_item hit_idx;
  2451		struct mem_cgroup *memcg;
  2452		struct lruvec *lruvec;
  2453		bool is_hit;
  2454	
  2455		if (!root_mem_cgroup || mem_cgroup_disabled())
  2456			return;
  2457	
  2458		/*
  2459		 * Start with hit then use +1 or +2 later on to change to miss or
  2460		 * foreign respectively if needed.
  2461		 */
  2462		switch (pol->mode) {
  2463		case MPOL_PREFERRED:
  2464			hit_idx = NUMA_MPOL_PREFERRED_HIT;
  2465			break;
  2466		case MPOL_PREFERRED_MANY:
  2467			hit_idx = NUMA_MPOL_PREFERRED_MANY_HIT;
  2468			break;
  2469		case MPOL_BIND:
  2470			hit_idx = NUMA_MPOL_BIND_HIT;
  2471			break;
  2472		case MPOL_INTERLEAVE:
  2473			hit_idx = NUMA_MPOL_INTERLEAVE_HIT;
  2474			break;
  2475		case MPOL_WEIGHTED_INTERLEAVE:
  2476			hit_idx = NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT;
  2477			break;
  2478		default:
  2479			hit_idx = NUMA_MPOL_LOCAL_HIT;
  2480			break;
  2481		}
  2482	
  2483		if (pol->mode == MPOL_BIND || pol->mode == MPOL_PREFERRED_MANY)
  2484			is_hit = node_isset(actual_nid, pol->nodes);
  2485		else
  2486			is_hit = (actual_nid == intended_nid);
  2487	
  2488		rcu_read_lock();
> 2489		memcg = mem_cgroup_from_task(current);
  2490	
  2491		if (is_hit) {
  2492			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(actual_nid));
  2493			mod_lruvec_state(lruvec, hit_idx, nr_pages);
  2494		} else {
  2495			/* account for miss on the fallback node */
  2496			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(actual_nid));
  2497			mod_lruvec_state(lruvec, hit_idx + 1, nr_pages);
  2498	
  2499			/* account for foreign on the intended node */
  2500			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(intended_nid));
  2501			mod_lruvec_state(lruvec, hit_idx + 2, nr_pages);
  2502		}
  2503	
  2504		rcu_read_unlock();
  2505	}
  2506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

