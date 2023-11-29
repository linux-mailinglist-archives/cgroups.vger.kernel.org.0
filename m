Return-Path: <cgroups+bounces-686-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417F7FDEDC
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 18:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4580F1C20C2B
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFE55AB81;
	Wed, 29 Nov 2023 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fhIsZVEC"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CDB9;
	Wed, 29 Nov 2023 09:50:02 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D1065100013;
	Wed, 29 Nov 2023 20:50:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D1065100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1701280200;
	bh=w/vcxLuvL4bYagE3sFg1qmNDtBHSFkm5vrXEEsp+H3A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=fhIsZVECVT80mvBztgePCDfDhnH+BNC6Ph0ZibOZCiHrvrrF7yXGq9OPCKpNxuYPt
	 HpAeyiPcAtM3aIVzuROEdv/GEupZj6aP7EVVePikDiQmIZpx8gmZriMc7SHd8vN0ui
	 aktKWyegsMXKP9wbygusgf7xvLlnzytfFWXEFlbdkYjEhXj0g/r4nUOgRmSwWh888b
	 ZD3/G4+9h+Myo+gurPyv5qnxF9zWxK1QFUWxamfwPOh6V7lCXOh3hnr0YjJZGP+x+R
	 8gLvZXLAbIK6dJb4L+8vVhIc/fwopcId2tyna5vRGISffHN03LDElBh4KeYshupH8T
	 KxHJPeeB9ofCw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 20:49:59 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 20:49:59 +0300
Date: Wed, 29 Nov 2023 20:49:54 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Michal Hocko <mhocko@suse.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
	<rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231129174954.bmujk37cufq37oyp@CAB-WSD-L081021>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
 <ZWWzwhWnW1_iX0FP@tiehlicka>
 <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
 <20231129093341.02605a16142fc3e04384c52e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129093341.02605a16142fc3e04384c52e@linux-foundation.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181709 [Nov 29 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/29 16:31:00 #22572963
X-KSMG-AntiVirus-Status: Clean, skipped

On Wed, Nov 29, 2023 at 09:33:41AM -0800, Andrew Morton wrote:
> On Wed, 29 Nov 2023 18:20:57 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > Okay, I will try to prepare a new patch version with memcg printing from
> > lruvec and slab tracepoints.
> > 
> > Then Andrew should drop the previous patchsets, I suppose. Please advise
> > on the correct workflow steps here.
> 
> This series is present in mm.git's mm-unstable branch.  Note
> "unstable".  So dropping the v3 series and merging v4 is totally not a
> problem.  It's why this branch exists - it's daily rebasing, in high
> flux.
> 
> When a patchset is considered stabilized and ready, I'll move it into
> the mm-stable branch, which is (supposed to be) the non-rebasing tree
> for next merge window.
> 
> If you have small fixes then I prefer little fixup patches against what
> is presently in mm-unstable.
> 
> If you send replacement patches then no problem, I'll check to see
> whether I should turn them into little fixup deltas.
> 
> I prefer little fixups so that people can see what has changed, so I
> can see which review/test issues were addressed and so that people
> don't feel a need to re-review the whole patchset.
> 
> If generation of little fixups is impractical, I'll drop the old series
> entirely and I'll merge the new one.
> 
> Each case is a judgement call, please send whatever you think makes
> most sense given the above.

Thank you for the detailed explanation! It is now completely clear to
me! I will be sending the new patch series soon.

-- 
Thank you,
Dmitry

