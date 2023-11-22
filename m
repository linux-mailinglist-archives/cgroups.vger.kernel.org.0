Return-Path: <cgroups+bounces-509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8B7F4476
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 11:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12A6B20FA3
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E226292;
	Wed, 22 Nov 2023 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="G84a0EFV"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2170B92;
	Wed, 22 Nov 2023 02:58:38 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B645C120069;
	Wed, 22 Nov 2023 13:58:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B645C120069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700650716;
	bh=zFx+5dXlR2EQJnObSWY+xM9oMXFlaTN9St5MLae6TwM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=G84a0EFVLTgDdOvzlXW6Mebu1TojgZDXRItdf9fVmFZptmL/l4AUVXhCOIcCS6MlY
	 F3AlevIX7gjzhw4tHFR/HPMzOyEWKhNnpdWCqD4bFODqBbEoGdNOZKnrzzdKpdoAnU
	 L7G/cZEMqghNyITCn6zr97jKaLuiz81Xlf3bWFkBQTyZrN0eOju9xmwfXbrASCzCF/
	 id2MaU/PYACpREAf8Lvad1T8JfY3/Z/SDHdOBupzg2wLKLbfXzbiHVf/wFrHoHhE/I
	 l7irZapLjznCc0Uxpi6nfeX3qRnSjOXyJsRfpbkOvhFOkXwVI4DnJgDbabHMWfPK9o
	 E7iNEXuUIrLpA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 22 Nov 2023 13:58:36 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 13:58:36 +0300
Date: Wed, 22 Nov 2023 13:58:36 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Michal Hocko <mhocko@suse.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<roman.gushchin@linux.dev>, <shakeelb@google.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231122105836.xhlgbwmwjdwd3g5v@CAB-WSD-L081021>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-3-ddrokosov@salutedevices.com>
 <ZV3WnIJMzxT-Zkt4@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV3WnIJMzxT-Zkt4@tiehlicka>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181528 [Nov 22 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/22 09:18:00 #22500551
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Michal,

Thank you for the quick review!

On Wed, Nov 22, 2023 at 11:23:24AM +0100, Michal Hocko wrote:
> On Wed 22-11-23 13:01:56, Dmitry Rokosov wrote:
> > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > Currently, it is not possible to trace this point from non-direct
> > reclaim paths.
> 
> Is this really true? AFAICS we have
> mm_vmscan_lru_isolate
> mm_vmscan_lru_shrink_active
> mm_vmscan_lru_shrink_inactive
> 
> which are in the vry core of the memory reclaim. Sure post processing
> those is some work.

Sure, you are absolutely right. In the usual scenario, the memcg
shrinker utilizes two sub-shrinkers: slab and LRU. We can enable the
tracepoints you mentioned and analyze them. However, there is one
potential issue. Enabling these tracepoints will trigger the reclaim
events show for all pages. Although we can filter them per pid, we
cannot filter them per cgroup. Nevertheless, there are times when it
would be extremely beneficial to comprehend the effectiveness of the
reclaim process within the relevant cgroup. For this reason, I am adding
the cgroup name to the memcg tracepoints and implementing a cumulative
tracepoint for memcg shrink (LRU + slab)."

> 
> [...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 45780952f4b5..6d89b39d9a91 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6461,6 +6461,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  		 */
> >  		cond_resched();
> >  
> > +#ifdef CONFIG_MEMCG
> > +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> > +						   sc->gfp_mask,
> > +						   memcg);
> > +#endif
> 
> this is a common code path for node and direct reclaim which means that
> we will have multiple begin/end tracepoints covering similar operations.
> To me that sounds excessive. If you are missing a cumulative kswapd
> alternative to 
> mm_vmscan_direct_reclaim_begin
> mm_vmscan_direct_reclaim_end
> mm_vmscan_memcg_reclaim_begin
> mm_vmscan_memcg_reclaim_end
> mm_vmscan_memcg_softlimit_reclaim_begin
> mm_vmscan_memcg_softlimit_reclaim_end
> mm_vmscan_node_reclaim_begin
> mm_vmscan_node_reclaim_end
> 
> then place it into kswapd path. But it would be really great to
> elaborate some more why this is really needed. Cannot you simply
> aggregate stats for kswapd from existing tracepoints?
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Thank you,
Dmitry

