Return-Path: <cgroups+bounces-149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAAF7DE5A3
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF0A2812AD
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821A1864E;
	Wed,  1 Nov 2023 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DhowvoYC"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0F125B8;
	Wed,  1 Nov 2023 17:54:06 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9838BC1;
	Wed,  1 Nov 2023 10:54:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 37A22120003;
	Wed,  1 Nov 2023 20:54:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 37A22120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698861240;
	bh=N5nlonZuNjgCoLi9q6ufNWD+EONGzw0UYQZjHj7RM9k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=DhowvoYC4CshzYzuBjplMTqrLoHBsAikvWrJZh4CtL+Tf7f4qS8KZ1AWMJDu8JRgA
	 SR45M+nCRDcC3OeZA3ldlJH8CpVfTH0JZaEG439lKiE5s8kCH3ch9P0r0dohX3V+SY
	 itXLv+B7+/paAmQJClID7ujFPEmSqEw+97sgAf9cUsn7kshEbOg+PF7hED3be8w54k
	 8zsPjcpG2J89IPmXjOg/xQgSx8KSOX0cQYkdQlfg5d8nUacE2wTqNtb89bGtvR2kvE
	 YON6o9SfFhHswmB+AIfBaLAEciUVQxoaMbNSGHl3I+/3qbAg7lWWguc9rz3JNWdxGL
	 kd8wOzx8Vb18g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 20:53:59 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 1 Nov
 2023 20:53:59 +0300
Date: Wed, 1 Nov 2023 20:53:59 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: kernel test robot <lkp@intel.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <kernel@sberdevices.ru>,
	<rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231101175359.kxnat357ysqgbbh7@CAB-WSD-L081021>
References: <20231101102837.25205-3-ddrokosov@salutedevices.com>
 <202311012319.7ULVSdyR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311012319.7ULVSdyR-lkp@intel.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181058 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;download.01.org:7.1.1;github.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;git.kernel.org:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/01 16:22:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/01 16:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 15:56:00 #22380151
X-KSMG-AntiVirus-Status: Clean, skipped

Oh, I apologize for that. It seems that I need to wrap the new
tracepoint calls with CONFIG_MEMCG. I will proceed to prepare the new
version.

On Wed, Nov 01, 2023 at 11:44:10PM +0800, kernel test robot wrote:
> Hi Dmitry,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Rokosov/mm-memcg-print-out-cgroup-name-in-the-memcg-tracepoints/20231101-183040
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20231101102837.25205-3-ddrokosov%40salutedevices.com
> patch subject: [PATCH v1 2/2] mm: memcg: introduce new event to trace shrink_memcg
> config: um-allyesconfig (https://download.01.org/0day-ci/archive/20231101/202311012319.7ULVSdyR-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311012319.7ULVSdyR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311012319.7ULVSdyR-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from mm/vmscan.c:19:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from mm/vmscan.c:19:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from mm/vmscan.c:19:
>    In file included from include/linux/kernel_stat.h:9:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsb(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsw(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            readsl(PCI_IOBASE + addr, buffer, count);
>                   ~~~~~~~~~~ ^
>    include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesb(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesw(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
>    include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            writesl(PCI_IOBASE + addr, buffer, count);
>                    ~~~~~~~~~~ ^
> >> mm/vmscan.c:5811:3: error: implicit declaration of function 'trace_mm_vmscan_memcg_shrink_begin' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>                    trace_mm_vmscan_memcg_shrink_begin(memcg,
>                    ^
>    mm/vmscan.c:5811:3: note: did you mean 'trace_mm_vmscan_lru_shrink_active'?
>    include/trace/events/vmscan.h:467:1: note: 'trace_mm_vmscan_lru_shrink_active' declared here
>    TRACE_EVENT(mm_vmscan_lru_shrink_active,
>    ^
>    include/linux/tracepoint.h:566:2: note: expanded from macro 'TRACE_EVENT'
>            DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>            ^
>    include/linux/tracepoint.h:432:2: note: expanded from macro 'DECLARE_TRACE'
>            __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
>            ^
>    include/linux/tracepoint.h:355:21: note: expanded from macro '__DECLARE_TRACE'
>            static inline void trace_##name(proto)                          \
>                               ^
>    <scratch space>:33:1: note: expanded from here
>    trace_mm_vmscan_lru_shrink_active
>    ^
> >> mm/vmscan.c:5845:3: error: implicit declaration of function 'trace_mm_vmscan_memcg_shrink_end' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>                    trace_mm_vmscan_memcg_shrink_end(memcg,
>                    ^
>    mm/vmscan.c:5845:3: note: did you mean 'trace_mm_vmscan_memcg_shrink_begin'?
>    mm/vmscan.c:5811:3: note: 'trace_mm_vmscan_memcg_shrink_begin' declared here
>                    trace_mm_vmscan_memcg_shrink_begin(memcg,
>                    ^
>    12 warnings and 2 errors generated.
> 
> 
> vim +/trace_mm_vmscan_memcg_shrink_begin +5811 mm/vmscan.c
> 
>   5791	
>   5792	static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>   5793	{
>   5794		struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
>   5795		struct mem_cgroup *memcg;
>   5796	
>   5797		memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
>   5798		do {
>   5799			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>   5800			unsigned long reclaimed;
>   5801			unsigned long scanned;
>   5802	
>   5803			/*
>   5804			 * This loop can become CPU-bound when target memcgs
>   5805			 * aren't eligible for reclaim - either because they
>   5806			 * don't have any reclaimable pages, or because their
>   5807			 * memory is explicitly protected. Avoid soft lockups.
>   5808			 */
>   5809			cond_resched();
>   5810	
> > 5811			trace_mm_vmscan_memcg_shrink_begin(memcg,
>   5812							   sc->order,
>   5813							   sc->gfp_mask);
>   5814	
>   5815			mem_cgroup_calculate_protection(target_memcg, memcg);
>   5816	
>   5817			if (mem_cgroup_below_min(target_memcg, memcg)) {
>   5818				/*
>   5819				 * Hard protection.
>   5820				 * If there is no reclaimable memory, OOM.
>   5821				 */
>   5822				continue;
>   5823			} else if (mem_cgroup_below_low(target_memcg, memcg)) {
>   5824				/*
>   5825				 * Soft protection.
>   5826				 * Respect the protection only as long as
>   5827				 * there is an unprotected supply
>   5828				 * of reclaimable memory from other cgroups.
>   5829				 */
>   5830				if (!sc->memcg_low_reclaim) {
>   5831					sc->memcg_low_skipped = 1;
>   5832					continue;
>   5833				}
>   5834				memcg_memory_event(memcg, MEMCG_LOW);
>   5835			}
>   5836	
>   5837			reclaimed = sc->nr_reclaimed;
>   5838			scanned = sc->nr_scanned;
>   5839	
>   5840			shrink_lruvec(lruvec, sc);
>   5841	
>   5842			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>   5843				    sc->priority);
>   5844	
> > 5845			trace_mm_vmscan_memcg_shrink_end(memcg,
>   5846							 sc->nr_reclaimed - reclaimed);
>   5847	
>   5848			/* Record the group's reclaim efficiency */
>   5849			if (!sc->proactive)
>   5850				vmpressure(sc->gfp_mask, memcg, false,
>   5851					   sc->nr_scanned - scanned,
>   5852					   sc->nr_reclaimed - reclaimed);
>   5853	
>   5854		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
>   5855	}
>   5856	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Thank you,
Dmitry

