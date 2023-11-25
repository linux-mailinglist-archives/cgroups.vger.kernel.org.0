Return-Path: <cgroups+bounces-555-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E464E7F88FA
	for <lists+cgroups@lfdr.de>; Sat, 25 Nov 2023 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972A528174A
	for <lists+cgroups@lfdr.de>; Sat, 25 Nov 2023 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1178F6B;
	Sat, 25 Nov 2023 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Rdqj6MRD"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09369B7;
	Sat, 25 Nov 2023 00:07:23 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 772FF10001E;
	Sat, 25 Nov 2023 11:07:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 772FF10001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700899641;
	bh=K7fr0lZtqmONXfZHNs6nAmOycaDMnGOOKILgnfl+LIQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Rdqj6MRDCKN2d8lc2syBteEBMtCQzrlDYW1KBbOPAp2s2tKlmV7KiOjHS9Neuvewn
	 fnOOkbNxnP5WMHD4M5jcgpHPxZVfBN76FrhWwFI30da+XEY4W3/vf36jTJI2PuM3Q+
	 49VPziGMV9x5OuXaBS6+syprhr0oAXnCg/ZhQpEVScT2/SZOzTXAJXD9VUcxcJABIb
	 KFBOUhr9GFdmWSjwTy6oVwJmLwkvGynMvjkWYLXn6wPxwF4RNoVKYwGq42VXgeUUr8
	 9jDtwNXUTTZYb4uk+aSzz6foNiREai7FXC7jFS5aN8xiuy8cUDzzheBXBO5Zd1P8gW
	 svF/Z1UB/R/Cw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 25 Nov 2023 11:07:21 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 25 Nov
 2023 11:07:21 +0300
Date: Sat, 25 Nov 2023 11:07:20 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
	<rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] samples: introduce cgroup events listeners
Message-ID: <20231125080720.h7kbdzumlsi6ltrj@CAB-WSD-L081021>
References: <20231123071945.25811-1-ddrokosov@salutedevices.com>
 <20231124114230.22ed97e85058dc339947f13f@linux-foundation.org>
 <20231124200633.scnct5f7auawsjn2@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231124200633.scnct5f7auawsjn2@CAB-WSD-L081021>
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
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/25 05:15:00 #22531701
X-KSMG-AntiVirus-Status: Clean, skipped

Andrew,

On Fri, Nov 24, 2023 at 11:06:33PM +0300, Dmitry Rokosov wrote:
> On Fri, Nov 24, 2023 at 11:42:30AM -0800, Andrew Morton wrote:
> > On Thu, 23 Nov 2023 10:19:42 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > 
> > > To begin with, this patch series relocates the cgroup example code to
> > > the samples/cgroup directory, which is the appropriate location for such
> > > code snippets.
> > 
> > butbut.  Didn't we decide to do s/cgroup/memcg/ throughout?
> 
> I believe the samples directory should be named "samples/cgroup" instead
> of "memcg" because the cgroup v1 event listener cannot be renamed to
> "memcg" due to the common naming of cgroup v1 event_control (this sample
> uses that control to access eventfd).
> 
> Additionally, I think it would be a good idea to add the new samples for
> cgroup helpers in that directory.
> 
> That's why I have only renamed the new memcg listener.

I looked into this more deeply. And yes, the old cgroup.event_control
has the common name, but it's used in the memcg implementation only.

So, if we plan to introduce new samples for cgroup, I suggest we use the
following naming convention:

1) Directory: samples/cgroup
2) V1 sample: memcg_v1_event_listener
3) V2 sample: memcg_v2_event_listener

Please let me know what you think about this. If it's okay with you, I
will prepare the v4 version with the above changes. I would appreciate
any feedback on that!"

-- 
Thank you,
Dmitry

