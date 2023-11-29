Return-Path: <cgroups+bounces-675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF27FDB59
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FFBB20D35
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E338DED;
	Wed, 29 Nov 2023 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="C5r6pVRb"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C910CB;
	Wed, 29 Nov 2023 07:26:15 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C8C6D100013;
	Wed, 29 Nov 2023 18:26:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C8C6D100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1701271573;
	bh=akCVsohWzhgHFlDJGn9FqbXDx2oHKT/KQD6M/QgipVI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=C5r6pVRbhIu+BDwsK3OYZYLx6h9KNlw/q4UG0htK7NLAnCkfKNfmrvcon83pRq//a
	 5kkglds76vx9nzbXUUTN6k4MORleHYuQ3480JShCcmpmht2EzrHetRNuRdmpqkMEhI
	 1AUNrTJtIRxsPKLleSlAQsEObzTz6pwKucHcAo5DEHtkZcyxtOWVqP66wqMRijm5NH
	 542M4jLnr0MCMJpm3uZ/299COj/eN1ZrtZpbTgbFcfeW2eNW08iFt06LlJCU09W6BH
	 pzNC6NKjwcOkmLGuRSdAP3DU+kQwoanFcQVhZr8XOeDkEPo5UXXAuFbNGcls4vkK4F
	 AAny+LeUluCqw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 18:26:13 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 18:26:13 +0300
Date: Wed, 29 Nov 2023 18:26:13 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Michal Hocko <mhocko@suse.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<roman.gushchin@linux.dev>, <shakeelb@google.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231129152613.6vfz4b675u7wbz25@CAB-WSD-L081021>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
 <ZWWzwhWnW1_iX0FP@tiehlicka>
 <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181705 [Nov 29 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;git.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/29 13:21:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/29 13:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/29 12:04:00 #22572143
X-KSMG-AntiVirus-Status: Clean, skipped

On Wed, Nov 29, 2023 at 06:20:57PM +0300, Dmitry Rokosov wrote:
> On Tue, Nov 28, 2023 at 10:32:50AM +0100, Michal Hocko wrote:
> > On Mon 27-11-23 19:16:37, Dmitry Rokosov wrote:
> > > On Mon, Nov 27, 2023 at 01:50:22PM +0100, Michal Hocko wrote:
> > > > On Mon 27-11-23 14:36:44, Dmitry Rokosov wrote:
> > > > > On Mon, Nov 27, 2023 at 10:33:49AM +0100, Michal Hocko wrote:
> > > > > > On Thu 23-11-23 22:39:37, Dmitry Rokosov wrote:
> > > > > > > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > > > > > > Currently, it is not possible to trace this point from non-direct
> > > > > > > reclaim paths. However, direct reclaim has its own tracepoint, so there
> > > > > > > is no issue there. In certain cases, when debugging memcg pressure,
> > > > > > > developers may need to identify all potential requests for memcg
> > > > > > > reclamation including kswapd(). The patchset introduces the tracepoints
> > > > > > > mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> > > > > > > 
> > > > > > > Example of output in the kswapd context (non-direct reclaim):
> > > > > > >     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > > > >     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> > > > > > 
> > > > > > In the previous version I have asked why do we need this specific
> > > > > > tracepoint when we already do have trace_mm_vmscan_lru_shrink_{in}active
> > > > > > which already give you a very good insight. That includes the number of
> > > > > > reclaimed pages but also more. I do see that we do not include memcg id
> > > > > > of the reclaimed LRU, but that shouldn't be a big problem to add, no?
> > > > > 
> > > > > >From my point of view, memcg reclaim includes two points: LRU shrink and
> > > > > slab shrink, as mentioned in the vmscan.c file.
> > > > > 
> > > > > 
> > > > > static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> > > > > ...
> > > > > 		reclaimed = sc->nr_reclaimed;
> > > > > 		scanned = sc->nr_scanned;
> > > > > 
> > > > > 		shrink_lruvec(lruvec, sc);
> > > > > 
> > > > > 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> > > > > 			    sc->priority);
> > > > > ...
> > > > > 
> > > > > So, both of these operations are important for understanding whether
> > > > > memcg reclaiming was successful or not, as well as its effectiveness. I
> > > > > believe it would be beneficial to summarize them, which is why I have
> > > > > created new tracepoints.
> > > > 
> > > > This sounds like nice to have rather than must. Put it differently. If
> > > > you make existing reclaim trace points memcg aware (print memcg id) then
> > > > what prevents you from making analysis you need?
> > > 
> > > You are right, nothing prevents me from making this analysis... but...
> > > 
> > > This approach does have some disadvantages:
> > > 1) It requires more changes to vmscan. At the very least, the memcg
> > > object should be forwarded to all subfunctions for LRU and SLAB
> > > shrinkers.
> > 
> > We should have lruvec or memcg available. lruvec_memcg() could be used
> > to get memcg from the lruvec. It might be more places to add the id but
> > arguably this would improve them to identify where the memory has been
> > scanned/reclaimed from.
> >  
> 
> Oh, thank you, didn't see this conversion function before...
> 
> > > 2) With this approach, we will not have the ability to trace a situation
> > > where the kernel is requesting reclaim for a specific memcg, but due to
> > > limits issues, we are unable to run it.
> > 
> > I do not follow. Could you be more specific please?
> > 
> 
> I'm referring to a situation where kswapd() or another kernel mm code
> requests some reclaim pages from memcg, but memcg rejects it due to
> limits checkers. This occurs in the shrink_node_memcgs() function.
> 
> ===
> 		mem_cgroup_calculate_protection(target_memcg, memcg);
> 
> 		if (mem_cgroup_below_min(target_memcg, memcg)) {
> 			/*
> 			 * Hard protection.
> 			 * If there is no reclaimable memory, OOM.
> 			 */
> 			continue;
> 		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> 			/*
> 			 * Soft protection.
> 			 * Respect the protection only as long as
> 			 * there is an unprotected supply
> 			 * of reclaimable memory from other cgroups.
> 			 */
> 			if (!sc->memcg_low_reclaim) {
> 				sc->memcg_low_skipped = 1;
> 				continue;
> 			}
> 			memcg_memory_event(memcg, MEMCG_LOW);
> 		}
> ===
> 
> With separate shrink begin()/end() tracepoints we can detect such
> problem.
> 
> 
> > > 3) LRU and SLAB shrinkers are too common places to handle memcg-related
> > > tasks. Additionally, memcg can be disabled in the kernel configuration.
> > 
> > Right. This could be all hidden in the tracing code. You simply do not
> > print memcg id when the controller is disabled. Or just simply print 0.
> > I do not really see any major problems with that.
> > 
> > I would really prefer to focus on that direction rather than adding
> > another begin/end tracepoint which overalaps with existing begin/end
> > traces and provides much more limited information because I would bet we
> > will have somebody complaining that mere nr_reclaimed is not sufficient.
> 
> Okay, I will try to prepare a new patch version with memcg printing from
> lruvec and slab tracepoints.
> 
> Then Andrew should drop the previous patchsets, I suppose. Please advise
> on the correct workflow steps here.

Actually, it has already been merged into linux-next... I just checked.
Maybe it would be better to prepare lruvec and slab memcg printing as a
separate patch series?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0e7f0c52a76cb22c8633f21bff6e48fabff6016e

-- 
Thank you,
Dmitry

