Return-Path: <cgroups+bounces-685-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B007FDE7E
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042BD28270E
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6FC4C3AC;
	Wed, 29 Nov 2023 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="UGlogolA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1BCA;
	Wed, 29 Nov 2023 09:35:42 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 191CD100019;
	Wed, 29 Nov 2023 20:35:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 191CD100019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1701279341;
	bh=o5aURXIRpu1BR0yiHfEtpAHoFraXQHCwoLT8rRosZhw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=UGlogolADou1QOUgsNC1t11B9ahIDxCTpBFfbrJFu2a1er/NYLPbtkI50EXZLJ1M9
	 r/lQbeIEtZYstKx8E5vxCHxnVqEBcEbjYRR+rWnXdk8MP33+d7oStH6WVTDSn0WKH9
	 hX+Twj7gK6pyEQXwafxmFCPiHn+Wuw1upudk64ZeUBXFs60pHabdDaz2h2TezVO1xE
	 ShoLtETH7VYwM3DnM414Qpi1T6JE/VVoVlc2iA8dgZoVbu17DYc8Aooi38yDDx8LKX
	 Ecztmf+OOB4I4nJiXYXlVGfF7N0uoru7CiVSdYo3hyNUEY7POAFPQQbQAgrk0hzLeq
	 egy/qE4FxnC8g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 20:35:40 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 20:35:40 +0300
Date: Wed, 29 Nov 2023 20:35:40 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<hannes@cmpxchg.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231129173540.gl2pufeo6ciubcny@CAB-WSD-L081021>
References: <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
 <ZWWzwhWnW1_iX0FP@tiehlicka>
 <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
 <ZWdhjYPjbsoUE_mI@tiehlicka>
 <20231129165752.7r4o3jylbxrj7inb@CAB-WSD-L081021>
 <ZWdwifakPuMZbFUV@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWdwifakPuMZbFUV@tiehlicka>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181708 [Nov 29 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/29 16:31:00 #22572963
X-KSMG-AntiVirus-Status: Clean, skipped

On Wed, Nov 29, 2023 at 06:10:33PM +0100, Michal Hocko wrote:
> On Wed 29-11-23 19:57:52, Dmitry Rokosov wrote:
> > On Wed, Nov 29, 2023 at 05:06:37PM +0100, Michal Hocko wrote:
> > > On Wed 29-11-23 18:20:57, Dmitry Rokosov wrote:
> > > > On Tue, Nov 28, 2023 at 10:32:50AM +0100, Michal Hocko wrote:
> > > > > On Mon 27-11-23 19:16:37, Dmitry Rokosov wrote:
> > > [...]
> > > > > > 2) With this approach, we will not have the ability to trace a situation
> > > > > > where the kernel is requesting reclaim for a specific memcg, but due to
> > > > > > limits issues, we are unable to run it.
> > > > > 
> > > > > I do not follow. Could you be more specific please?
> > > > > 
> > > > 
> > > > I'm referring to a situation where kswapd() or another kernel mm code
> > > > requests some reclaim pages from memcg, but memcg rejects it due to
> > > > limits checkers. This occurs in the shrink_node_memcgs() function.
> > > 
> > > Ohh, you mean reclaim protection
> > > 
> > > > ===
> > > > 		mem_cgroup_calculate_protection(target_memcg, memcg);
> > > > 
> > > > 		if (mem_cgroup_below_min(target_memcg, memcg)) {
> > > > 			/*
> > > > 			 * Hard protection.
> > > > 			 * If there is no reclaimable memory, OOM.
> > > > 			 */
> > > > 			continue;
> > > > 		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> > > > 			/*
> > > > 			 * Soft protection.
> > > > 			 * Respect the protection only as long as
> > > > 			 * there is an unprotected supply
> > > > 			 * of reclaimable memory from other cgroups.
> > > > 			 */
> > > > 			if (!sc->memcg_low_reclaim) {
> > > > 				sc->memcg_low_skipped = 1;
> > > > 				continue;
> > > > 			}
> > > > 			memcg_memory_event(memcg, MEMCG_LOW);
> > > > 		}
> > > > ===
> > > > 
> > > > With separate shrink begin()/end() tracepoints we can detect such
> > > > problem.
> > > 
> > > How? You are only reporting the number of reclaimed pages and no
> > > reclaimed pages could be not just because of low/min limits but
> > > generally because of other reasons. You would need to report also the
> > > number of scanned/isolated pages.
> > >  
> > 
> > From my perspective, if memory control group (memcg) protection
> > restrictions occur, we can identify them by the absence of the end()
> > pair of begin(). Other reasons will have both tracepoints raised.
> 
> That is not really great way to detect that TBH. Trace events could be
> lost and then you simply do not know what has happened.

I see, thank you very much for the detailed review! I will prepare a new
patchset with memcg names in the lruvec and slab paths, will back soon.

-- 
Thank you,
Dmitry

