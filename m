Return-Path: <cgroups+bounces-680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10167FDDC7
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 17:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5828284F
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD863B782;
	Wed, 29 Nov 2023 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="QyEeJHDy"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B670D6E;
	Wed, 29 Nov 2023 08:57:55 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D921512000B;
	Wed, 29 Nov 2023 19:57:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D921512000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1701277072;
	bh=upFUqpfrDquVThehPQDeK2Tu8Ir/v12aprC4JpKU8g8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=QyEeJHDyMXu3Q+rlfWn4C2wnOcfgs5R9+/8V5/w7GE8JbjSqUchhlkwfgYa8X7vt0
	 QU5j3vJciChTqH9yqdDdTyhBzZhWl2sfX4f3UNBrSLnt0woaXc/i9ISrlj5i7Yk1gu
	 VuB+0bZjvyEowbIpCyi8Ghq8X+I1diR+JfYzzv5Xaz4BUBMehQZbDR6iFPfUwRK2U2
	 5xYjvU7x/If4jFf7xqkvQ8ROrC8Z61gdDhTskFDJhEt2zuztgu4xto9WND+WOSqwPP
	 qoaRD5b22jczH3m5D0MqzXw8IB196L7wEx/ia6A8QM1OqfOGEMvAjZ065aZOHBEKXd
	 YGaRAbUe7ZaGQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 19:57:52 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 19:57:52 +0300
Date: Wed, 29 Nov 2023 19:57:52 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Michal Hocko <mhocko@suse.com>, <akpm@linux-foundation.org>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<roman.gushchin@linux.dev>, <shakeelb@google.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231129165752.7r4o3jylbxrj7inb@CAB-WSD-L081021>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
 <ZWWzwhWnW1_iX0FP@tiehlicka>
 <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
 <ZWdhjYPjbsoUE_mI@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWdhjYPjbsoUE_mI@tiehlicka>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181706 [Nov 29 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/29 12:04:00 #22572143
X-KSMG-AntiVirus-Status: Clean, skipped

On Wed, Nov 29, 2023 at 05:06:37PM +0100, Michal Hocko wrote:
> On Wed 29-11-23 18:20:57, Dmitry Rokosov wrote:
> > On Tue, Nov 28, 2023 at 10:32:50AM +0100, Michal Hocko wrote:
> > > On Mon 27-11-23 19:16:37, Dmitry Rokosov wrote:
> [...]
> > > > 2) With this approach, we will not have the ability to trace a situation
> > > > where the kernel is requesting reclaim for a specific memcg, but due to
> > > > limits issues, we are unable to run it.
> > > 
> > > I do not follow. Could you be more specific please?
> > > 
> > 
> > I'm referring to a situation where kswapd() or another kernel mm code
> > requests some reclaim pages from memcg, but memcg rejects it due to
> > limits checkers. This occurs in the shrink_node_memcgs() function.
> 
> Ohh, you mean reclaim protection
> 
> > ===
> > 		mem_cgroup_calculate_protection(target_memcg, memcg);
> > 
> > 		if (mem_cgroup_below_min(target_memcg, memcg)) {
> > 			/*
> > 			 * Hard protection.
> > 			 * If there is no reclaimable memory, OOM.
> > 			 */
> > 			continue;
> > 		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> > 			/*
> > 			 * Soft protection.
> > 			 * Respect the protection only as long as
> > 			 * there is an unprotected supply
> > 			 * of reclaimable memory from other cgroups.
> > 			 */
> > 			if (!sc->memcg_low_reclaim) {
> > 				sc->memcg_low_skipped = 1;
> > 				continue;
> > 			}
> > 			memcg_memory_event(memcg, MEMCG_LOW);
> > 		}
> > ===
> > 
> > With separate shrink begin()/end() tracepoints we can detect such
> > problem.
> 
> How? You are only reporting the number of reclaimed pages and no
> reclaimed pages could be not just because of low/min limits but
> generally because of other reasons. You would need to report also the
> number of scanned/isolated pages.
>  

From my perspective, if memory control group (memcg) protection
restrictions occur, we can identify them by the absence of the end()
pair of begin(). Other reasons will have both tracepoints raised.

> > > > 3) LRU and SLAB shrinkers are too common places to handle memcg-related
> > > > tasks. Additionally, memcg can be disabled in the kernel configuration.
> > > 
> > > Right. This could be all hidden in the tracing code. You simply do not
> > > print memcg id when the controller is disabled. Or just simply print 0.
> > > I do not really see any major problems with that.
> > > 
> > > I would really prefer to focus on that direction rather than adding
> > > another begin/end tracepoint which overalaps with existing begin/end
> > > traces and provides much more limited information because I would bet we
> > > will have somebody complaining that mere nr_reclaimed is not sufficient.
> > 
> > Okay, I will try to prepare a new patch version with memcg printing from
> > lruvec and slab tracepoints.
> > 
> > Then Andrew should drop the previous patchsets, I suppose. Please advise
> > on the correct workflow steps here.
> 
> Andrew usually just drops the patch from his tree and it will disappaer
> from the linux-next as well.

Okay, I understand, thank you!

Andrew, could you please take a look? I am planning to prepare a new
patch version based on Michal's suggestion, so previous one should be
dropped.

-- 
Thank you,
Dmitry

