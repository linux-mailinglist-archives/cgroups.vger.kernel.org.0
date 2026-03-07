Return-Path: <cgroups+bounces-14695-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOUHB083rGkbnAEAu9opvQ
	(envelope-from <cgroups+bounces-14695-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 15:33:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE822C2F1
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 15:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14DE30428B5
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC0275864;
	Sat,  7 Mar 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ausBEM6j"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784629D277;
	Sat,  7 Mar 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772894010; cv=none; b=Zd9Bn1MN7ZAcwGQsvFNxn9THA88YIYCuRcXjqT9/oQ8V7WIEnmrXdfelDAI35b15A20aC95Uazu+HAGG4molQOC1f0GRkKviSljT9uQYB79eFcfNzZfGynbHLAnVnwbvwiOJriMFiGgXcpVaP/0Gm7BdtNGza350jR+o9uS0c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772894010; c=relaxed/simple;
	bh=MQ+yt5XOavwgGdppdINTOkJAiLO6+ABk5bgoDv4J9aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mua+NbiOcQcLJr7QXThkAhN/nN5bTBLR9/mGuUk0KhmLQleyGXR0cPo3qehoBdQA5iwHehldHgZh2BloTnH0yupWES+aXi3aMh04oIWz20+DJ5u1StdyQw88aw2dCDoIcr3saSCwJTP8/iXzRMIVgVH3ioR4gTmQ/GJOb+8LwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ausBEM6j; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772894008; x=1804430008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQ+yt5XOavwgGdppdINTOkJAiLO6+ABk5bgoDv4J9aI=;
  b=ausBEM6jYC86N99qeFPtYU40P58/jgnk2xlRfBUg3/qsWH+5dBNygbhd
   fMRBQ+BXGBwEjdCX87nohfEse+umLtBm7tUOPkoK3iQyvEYdJFiRH4S5X
   6FdGD329SpHfAUmc8FUPI6Svgptml6PivUUy5Yc9QtqOQMOLBnR7WganJ
   WucDgH4kt/v1iCmgw0xzXYStk7quqxrzvNPIIl+5gE5sEk4YDyHNrnbfN
   vjkNL45sUcWvM1ktgye/nXj4g4jt349DOFgvNVHV7dAF/I58FeCEiA7no
   mAD70KdZy2kpA3FWk45b3G7iS3ljqyDmUjMh+x27bnz6ssHaizGpWVmsh
   A==;
X-CSE-ConnectionGUID: jl4yDdU3SPKg0HktE9p/KQ==
X-CSE-MsgGUID: G8rJ5F2GTFCeZC4C1LUkSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="74171587"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="74171587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 06:33:28 -0800
X-CSE-ConnectionGUID: bfLuj/j3TcaKl8o5BKZvKg==
X-CSE-MsgGUID: 5d60jMlaTaa8hpa25AhjXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="215902739"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Mar 2026 06:33:21 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vysiT-0000000025R-3M8N;
	Sat, 07 Mar 2026 14:33:17 +0000
Date: Sat, 7 Mar 2026 22:32:47 +0800
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
Message-ID: <202603072210.TSPUKsyq-lkp@intel.com>
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
X-Rspamd-Queue-Id: 72BE822C2F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-14695-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi JP,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/JP-Kobryn-Meta/mm-mempolicy-track-page-allocations-per-mempolicy/20260307-125642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260307045520.247998-1-jp.kobryn%40linux.dev
patch subject: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
config: x86_64-randconfig-074-20260307 (https://download.01.org/0day-ci/archive/20260307/202603072210.TSPUKsyq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603072210.TSPUKsyq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603072210.TSPUKsyq-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/mempolicy.c: In function 'mpol_count_numa_alloc':
   mm/mempolicy.c:2489:17: error: implicit declaration of function 'mem_cgroup_from_task'; did you mean 'mem_cgroup_from_css'? [-Wimplicit-function-declaration]
    2489 |         memcg = mem_cgroup_from_task(current);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 mem_cgroup_from_css
>> mm/mempolicy.c:2489:15: error: assignment to 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2489 |         memcg = mem_cgroup_from_task(current);
         |               ^


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

