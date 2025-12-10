Return-Path: <cgroups+bounces-12311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E8CB19AA
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 02:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFCC930D1FD5
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E31225A5B;
	Wed, 10 Dec 2025 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzcKvmtx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081B13B584;
	Wed, 10 Dec 2025 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330593; cv=none; b=ixHy03lqfw6OaqdBiMWW8tUTozmyaamRf0Es81bxoaGjaBnrr4K7J8NygqjIeQOiufPxsKjmMpASQ8LBe7hCkT2MvDBhIpiWyB708kEPnCWSaLqjiJ+EuwM6lLSLZPmkWOdHK6ci3UaPEzm7Ba/gQbpykKoWPV4NbkD0sP1elq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330593; c=relaxed/simple;
	bh=khF7mS5pnq1YnL1FTDwYR8u3vG6BRMqesr0++X/h1x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZZSTCwY8WsBzcRrDhDf3NuRt8BgQKtHfAQTaknze2gGmQlsyzJqjZkcra7SI8VU+QK2Nbv3Unfw5zZbPL8Gf//x8Wv+FfVS2ZzjtmHLkFBFlr7vhiJPYX7LOF3uqaHrIupDKgtF1nGVa2nTFyRzEdj4E1DQvAb7pRND8gIa3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzcKvmtx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765330592; x=1796866592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=khF7mS5pnq1YnL1FTDwYR8u3vG6BRMqesr0++X/h1x0=;
  b=hzcKvmtxRDgOV88nfQ6J4hrJfB6Dim8dFronn1ZZ6zx+UI2u4ehif+3N
   pkOkmTt1JYxZuSuP5PPpLA6H7ME1frEG5nTevh95l+WD9CGpFD5OdIkTw
   7D7PMWHcF+gZjRsEBM4MKHTZWbGWvt/wdgaCnKa61l3QnAzREF9pPmViy
   Kc7yw8J/RRHMSV194FSKIFILDOL0WUzavAuND8+IdOrn9PmkEa5gk1ZVB
   G77YGx89tgfOHzOloH8SeZGvl5OO4WIq0Y7pyfFRiWe2j5vIXZ6jvdD4m
   HYht3uQ3gozB+XEcWZ796CwRGT9PQOl2TVgE1Ntwouqnt0YhiyE/hoItM
   w==;
X-CSE-ConnectionGUID: /wS5khPnQtSdMA0rg8HsFQ==
X-CSE-MsgGUID: kFHiDOk+S9+ZOqyWPmrrwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="54842106"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="54842106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 17:36:31 -0800
X-CSE-ConnectionGUID: u3aX/YPmS3elk3EL5uqLTQ==
X-CSE-MsgGUID: HK6gFFGXSX+9FE+AKcY2hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196281100"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Dec 2025 17:36:27 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT97x-000000002Ut-1bTw;
	Wed, 10 Dec 2025 01:36:25 +0000
Date: Wed, 10 Dec 2025 09:35:54 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huaweicloud.com
Subject: Re: [PATCH -next 2/2] memcg: remove mem_cgroup_size()
Message-ID: <202512100924.LqJqXM7P-lkp@intel.com>
References: <20251209130251.1988615-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209130251.1988615-3-chenridong@huaweicloud.com>

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251209]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/memcg-move-mem_cgroup_usage-memcontrol-v1-c/20251209-211854
base:   next-20251209
patch link:    https://lore.kernel.org/r/20251209130251.1988615-3-chenridong%40huaweicloud.com
patch subject: [PATCH -next 2/2] memcg: remove mem_cgroup_size()
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20251210/202512100924.LqJqXM7P-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100924.LqJqXM7P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512100924.LqJqXM7P-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'apply_proportional_protection':
>> mm/vmscan.c:2488:63: error: invalid use of undefined type 'struct mem_cgroup'
    2488 |                 unsigned long usage = page_counter_read(&memcg->memory);
         |                                                               ^~


vim +2488 mm/vmscan.c

  2450	
  2451	static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
  2452			struct scan_control *sc, unsigned long scan)
  2453	{
  2454		unsigned long min, low;
  2455	
  2456		mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
  2457	
  2458		if (min || low) {
  2459			/*
  2460			 * Scale a cgroup's reclaim pressure by proportioning
  2461			 * its current usage to its memory.low or memory.min
  2462			 * setting.
  2463			 *
  2464			 * This is important, as otherwise scanning aggression
  2465			 * becomes extremely binary -- from nothing as we
  2466			 * approach the memory protection threshold, to totally
  2467			 * nominal as we exceed it.  This results in requiring
  2468			 * setting extremely liberal protection thresholds. It
  2469			 * also means we simply get no protection at all if we
  2470			 * set it too low, which is not ideal.
  2471			 *
  2472			 * If there is any protection in place, we reduce scan
  2473			 * pressure by how much of the total memory used is
  2474			 * within protection thresholds.
  2475			 *
  2476			 * There is one special case: in the first reclaim pass,
  2477			 * we skip over all groups that are within their low
  2478			 * protection. If that fails to reclaim enough pages to
  2479			 * satisfy the reclaim goal, we come back and override
  2480			 * the best-effort low protection. However, we still
  2481			 * ideally want to honor how well-behaved groups are in
  2482			 * that case instead of simply punishing them all
  2483			 * equally. As such, we reclaim them based on how much
  2484			 * memory they are using, reducing the scan pressure
  2485			 * again by how much of the total memory used is under
  2486			 * hard protection.
  2487			 */
> 2488			unsigned long usage = page_counter_read(&memcg->memory);
  2489			unsigned long protection;
  2490	
  2491			/* memory.low scaling, make sure we retry before OOM */
  2492			if (!sc->memcg_low_reclaim && low > min) {
  2493				protection = low;
  2494				sc->memcg_low_skipped = 1;
  2495			} else {
  2496				protection = min;
  2497			}
  2498	
  2499			/* Avoid TOCTOU with earlier protection check */
  2500			usage = max(usage, protection);
  2501	
  2502			scan -= scan * protection / (usage + 1);
  2503	
  2504			/*
  2505			 * Minimally target SWAP_CLUSTER_MAX pages to keep
  2506			 * reclaim moving forwards, avoiding decrementing
  2507			 * sc->priority further than desirable.
  2508			 */
  2509			scan = max(scan, SWAP_CLUSTER_MAX);
  2510		}
  2511		return scan;
  2512	}
  2513	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

