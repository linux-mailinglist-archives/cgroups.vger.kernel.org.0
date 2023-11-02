Return-Path: <cgroups+bounces-157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8BC7DEB93
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 05:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFF8281A0E
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381C1860;
	Thu,  2 Nov 2023 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuKr9Zvm"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158011FA1;
	Thu,  2 Nov 2023 04:03:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DC127;
	Wed,  1 Nov 2023 21:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698897801; x=1730433801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZAhTTJPnwNh7IED7EgXf3uaooCsbRednT45HuNxBBu4=;
  b=IuKr9Zvm/wvAGpp3Hg7eb3B5k8/lD3F/QXJWv/tsS/fFGd6zKSGkPVKg
   0HYisRJ/qp42XUtKppZ5L9u2+XJUc/gLKfuYt+HnNSWRjrpFIfv1ggQZ/
   g/4CcPNVYrGK+GoM5WvQv0kASJ8Y9VDJfqH+Mstg7tkxQqOfNH3WP6AIm
   dnzWxcexRDFZjiFAN8JlaO4IeNFGysLAiMsvuvtvVixxFDGL3rX7++yBl
   QLFIlf0LH9r3KV5uGBy14LomV/EdfX7GbpiUrn9CrlT1SgzUzM5K8HKb6
   T9u/qZDk9t9pZm4ttmSioUi82TIa7ai6x8ozGbaT+0s1yLH30qLgL7vPv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="388448262"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="388448262"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 21:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="851785059"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="851785059"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2023 21:03:17 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qyOvK-000166-2h;
	Thu, 02 Nov 2023 04:03:14 +0000
Date: Thu, 2 Nov 2023 12:03:06 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, kernel@sberdevices.ru,
	rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <202311021126.DNKIAcbq-lkp@intel.com>
References: <20231101102837.25205-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101102837.25205-3-ddrokosov@salutedevices.com>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Rokosov/mm-memcg-print-out-cgroup-name-in-the-memcg-tracepoints/20231101-183040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231101102837.25205-3-ddrokosov%40salutedevices.com
patch subject: [PATCH v1 2/2] mm: memcg: introduce new event to trace shrink_memcg
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20231102/202311021126.DNKIAcbq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021126.DNKIAcbq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021126.DNKIAcbq-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'shrink_node_memcgs':
>> mm/vmscan.c:5811:17: error: implicit declaration of function 'trace_mm_vmscan_memcg_shrink_begin'; did you mean 'trace_mm_vmscan_lru_shrink_active'? [-Werror=implicit-function-declaration]
    5811 |                 trace_mm_vmscan_memcg_shrink_begin(memcg,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 trace_mm_vmscan_lru_shrink_active
   mm/vmscan.c:5845:17: error: implicit declaration of function 'trace_mm_vmscan_memcg_shrink_end'; did you mean 'trace_mm_vmscan_lru_shrink_active'? [-Werror=implicit-function-declaration]
    5845 |                 trace_mm_vmscan_memcg_shrink_end(memcg,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 trace_mm_vmscan_lru_shrink_active
   cc1: some warnings being treated as errors


vim +5811 mm/vmscan.c

  5791	
  5792	static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
  5793	{
  5794		struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
  5795		struct mem_cgroup *memcg;
  5796	
  5797		memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
  5798		do {
  5799			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
  5800			unsigned long reclaimed;
  5801			unsigned long scanned;
  5802	
  5803			/*
  5804			 * This loop can become CPU-bound when target memcgs
  5805			 * aren't eligible for reclaim - either because they
  5806			 * don't have any reclaimable pages, or because their
  5807			 * memory is explicitly protected. Avoid soft lockups.
  5808			 */
  5809			cond_resched();
  5810	
> 5811			trace_mm_vmscan_memcg_shrink_begin(memcg,
  5812							   sc->order,
  5813							   sc->gfp_mask);
  5814	
  5815			mem_cgroup_calculate_protection(target_memcg, memcg);
  5816	
  5817			if (mem_cgroup_below_min(target_memcg, memcg)) {
  5818				/*
  5819				 * Hard protection.
  5820				 * If there is no reclaimable memory, OOM.
  5821				 */
  5822				continue;
  5823			} else if (mem_cgroup_below_low(target_memcg, memcg)) {
  5824				/*
  5825				 * Soft protection.
  5826				 * Respect the protection only as long as
  5827				 * there is an unprotected supply
  5828				 * of reclaimable memory from other cgroups.
  5829				 */
  5830				if (!sc->memcg_low_reclaim) {
  5831					sc->memcg_low_skipped = 1;
  5832					continue;
  5833				}
  5834				memcg_memory_event(memcg, MEMCG_LOW);
  5835			}
  5836	
  5837			reclaimed = sc->nr_reclaimed;
  5838			scanned = sc->nr_scanned;
  5839	
  5840			shrink_lruvec(lruvec, sc);
  5841	
  5842			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
  5843				    sc->priority);
  5844	
  5845			trace_mm_vmscan_memcg_shrink_end(memcg,
  5846							 sc->nr_reclaimed - reclaimed);
  5847	
  5848			/* Record the group's reclaim efficiency */
  5849			if (!sc->proactive)
  5850				vmpressure(sc->gfp_mask, memcg, false,
  5851					   sc->nr_scanned - scanned,
  5852					   sc->nr_reclaimed - reclaimed);
  5853	
  5854		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
  5855	}
  5856	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

