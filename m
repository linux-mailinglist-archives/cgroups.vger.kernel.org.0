Return-Path: <cgroups+bounces-142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5887DE3F5
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3901C20D25
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90314297;
	Wed,  1 Nov 2023 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dz8JZcPQ"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633A14292;
	Wed,  1 Nov 2023 15:45:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24D111;
	Wed,  1 Nov 2023 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698853513; x=1730389513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uD79xch+yhiRL277ZQ02UoFmVoZX8XE900MgWoHMgQ=;
  b=Dz8JZcPQuTmuxWsjUh3k5rs/5IcUABwxYGlJFbzVMjdQV4Ua2Z6N9uIO
   R2ex54xgVuOXAXyIzh5FV2eil87jMgzpc4YaiKhfSVLb26Ugv7lHOR7D3
   0xxGnIEEQut4IJleb//41Cw+w6LOdvfx4UZqG3Ai7v5yCIpI+lvgSiIwA
   bmafLjzp8ShfI/dmF/iWDn6JSO6KAIVjgzidhozgGkcGVDDxMcz9E4IhN
   c3/iQsC+JPGm4ugO64gDbr5sXC/vA6QZxaOxFcWU/E1t58cDV5m5Y3EzO
   kNBjHYX0k4Tu4/AReiX/b6hrtfY6TBqWnq7C9ph9Yr9CDUPqtH24QSZkn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385694835"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="385694835"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 08:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="790136244"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="790136244"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Nov 2023 08:45:07 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qyDOz-0000rE-0z;
	Wed, 01 Nov 2023 15:45:05 +0000
Date: Wed, 1 Nov 2023 23:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <202311012319.7ULVSdyR-lkp@intel.com>
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
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20231101/202311012319.7ULVSdyR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311012319.7ULVSdyR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311012319.7ULVSdyR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/vmscan.c:19:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from mm/vmscan.c:19:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from mm/vmscan.c:19:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> mm/vmscan.c:5811:3: error: implicit declaration of function 'trace_mm_vmscan_memcg_shrink_begin' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   trace_mm_vmscan_memcg_shrink_begin(memcg,
                   ^
   mm/vmscan.c:5811:3: note: did you mean 'trace_mm_vmscan_lru_shrink_active'?
   include/trace/events/vmscan.h:467:1: note: 'trace_mm_vmscan_lru_shrink_active' declared here
   TRACE_EVENT(mm_vmscan_lru_shrink_active,
   ^
   include/linux/tracepoint.h:566:2: note: expanded from macro 'TRACE_EVENT'
           DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
           ^
   include/linux/tracepoint.h:432:2: note: expanded from macro 'DECLARE_TRACE'
           __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
           ^
   include/linux/tracepoint.h:355:21: note: expanded from macro '__DECLARE_TRACE'
           static inline void trace_##name(proto)                          \
                              ^
   <scratch space>:33:1: note: expanded from here
   trace_mm_vmscan_lru_shrink_active
   ^
>> mm/vmscan.c:5845:3: error: implicit declaration of function 'trace_mm_vmscan_memcg_shrink_end' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   trace_mm_vmscan_memcg_shrink_end(memcg,
                   ^
   mm/vmscan.c:5845:3: note: did you mean 'trace_mm_vmscan_memcg_shrink_begin'?
   mm/vmscan.c:5811:3: note: 'trace_mm_vmscan_memcg_shrink_begin' declared here
                   trace_mm_vmscan_memcg_shrink_begin(memcg,
                   ^
   12 warnings and 2 errors generated.


vim +/trace_mm_vmscan_memcg_shrink_begin +5811 mm/vmscan.c

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
> 5845			trace_mm_vmscan_memcg_shrink_end(memcg,
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

