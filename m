Return-Path: <cgroups+bounces-554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90187F88F8
	for <lists+cgroups@lfdr.de>; Sat, 25 Nov 2023 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95C9281796
	for <lists+cgroups@lfdr.de>; Sat, 25 Nov 2023 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D08F6A;
	Sat, 25 Nov 2023 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="L8l7YgL6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B41B5;
	Sat, 25 Nov 2023 00:01:42 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7A0EA12000E;
	Sat, 25 Nov 2023 11:01:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7A0EA12000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700899299;
	bh=uEk8q/kq9AE9p0w4e4ChlZbiimRJBLVAau+P2hZKkoY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=L8l7YgL6FRxqw7y61ctjYc9spkqYyGqxPrZheyjd9kK0ZwOaILTV5wzMCv/RY56qc
	 OHl7q0cD/7hSIYB9v2nTOKmKxJIkTb7jrG96mpVMLhEkbscsy35kp1edClilV55kYX
	 DOmL11OKiM7ngNdPcCnv2pk4gElk1Xqohl/NNFiWuCMRV556GoPS19EQ6Hunoaa7ph
	 lCZ6wMMTAIqvUyJ+5TGZJg37axTN8xju0oeMQ7gMjR2FYC+Q8yl+mJ4v9Usyu/8MGJ
	 e7/QoP7P/akxD40yWvjBEIEsjorQUoqdJkS25evOnLX6Jd/foOtCt1/PGZmWLWmpF1
	 VSzJn42fnBV2g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 25 Nov 2023 11:01:37 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 25 Nov
 2023 11:01:37 +0300
Date: Sat, 25 Nov 2023 11:01:37 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Shakeel Butt <shakeelb@google.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
	<mhocko@suse.com>, <akpm@linux-foundation.org>, <kernel@sberdevices.ru>,
	<rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231125080137.2fhmi4374yxqjyix@CAB-WSD-L081021>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <20231125063616.dex3kh3ea43ceyu3@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231125063616.dex3kh3ea43ceyu3@google.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181592 [Nov 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/25 05:15:00 #22531701
X-KSMG-AntiVirus-Status: Clean, skipped

On Sat, Nov 25, 2023 at 06:36:16AM +0000, Shakeel Butt wrote:
> On Thu, Nov 23, 2023 at 10:39:37PM +0300, Dmitry Rokosov wrote:
> > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > Currently, it is not possible to trace this point from non-direct
> > reclaim paths. However, direct reclaim has its own tracepoint, so there
> > is no issue there. In certain cases, when debugging memcg pressure,
> > developers may need to identify all potential requests for memcg
> > reclamation including kswapd(). The patchset introduces the tracepoints
> > mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> > 
> > Example of output in the kswapd context (non-direct reclaim):
> >     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
> >     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
> >     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
> >     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
> >     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
> >     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> >     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  include/trace/events/vmscan.h | 22 ++++++++++++++++++++++
> >  mm/vmscan.c                   |  7 +++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> > index e9093fa1c924..a4686afe571d 100644
> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -180,6 +180,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_r
> >  	TP_ARGS(order, gfp_flags, memcg)
> >  );
> >  
> > +DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_shrink_begin,
> > +
> > +	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
> > +
> > +	TP_ARGS(order, gfp_flags, memcg)
> > +);
> > +
> > +#else
> > +
> > +#define trace_mm_vmscan_memcg_shrink_begin(...)
> > +
> >  #endif /* CONFIG_MEMCG */
> >  
> >  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
> > @@ -243,6 +254,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_rec
> >  	TP_ARGS(nr_reclaimed, memcg)
> >  );
> >  
> > +DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_shrink_end,
> > +
> > +	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
> > +
> > +	TP_ARGS(nr_reclaimed, memcg)
> > +);
> > +
> > +#else
> > +
> > +#define trace_mm_vmscan_memcg_shrink_end(...)
> > +
> >  #endif /* CONFIG_MEMCG */
> >  
> >  TRACE_EVENT(mm_shrink_slab_start,
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 45780952f4b5..f7e3ddc5a7ad 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6461,6 +6461,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  		 */
> >  		cond_resched();
> >  
> > +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> > +						   sc->gfp_mask,
> > +						   memcg);
> > +
> 
> If you place the start of the trace here, you may have only the begin
> trace for memcgs whose usage are below their min or low limits. Is that
> fine? Otherwise you can put it just before shrink_lruvec() call.
> 

From my point of view, it's fine. For situations like the one you
described, when we only see the begin() tracepoint raised without the
end(), we understand that reclaim requests are being made but cannot be
satisfied due to certain conditions within memcg (such as limits).

There may be some spam tracepoints in the trace pipe, which is a disadvantage
of this approach.

How important do you think it is to understand such situations? Or do
you suggest moving the begin() tracepoint after the memcg limits checks
and don't care about it?

> >  		mem_cgroup_calculate_protection(target_memcg, memcg);
> >  
> >  		if (mem_cgroup_below_min(target_memcg, memcg)) {
> > @@ -6491,6 +6495,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> >  			    sc->priority);
> >  
> > +		trace_mm_vmscan_memcg_shrink_end(sc->nr_reclaimed - reclaimed,
> > +						 memcg);
> > +
> >  		/* Record the group's reclaim efficiency */
> >  		if (!sc->proactive)
> >  			vmpressure(sc->gfp_mask, memcg, false,
> > -- 
> > 2.36.0
> > 

-- 
Thank you,
Dmitry

