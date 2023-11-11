Return-Path: <cgroups+bounces-335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6897E8B10
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA911C20366
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416314F6A;
	Sat, 11 Nov 2023 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ic12kTh1"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A614AA3;
	Sat, 11 Nov 2023 13:39:36 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850C3865;
	Sat, 11 Nov 2023 05:39:33 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 33B4512000F;
	Sat, 11 Nov 2023 16:39:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 33B4512000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699709970;
	bh=G9YxL4kI0JYIQ9JKZB5K/WOCXsm+GLv6gOHgIo4/KBk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ic12kTh15UpO5oHHFo2Ubg5EejgkWe2IBbPF7u//2M3akY7etfhgMeB4x4D868XXZ
	 DcgicjB6tzXB/TbAF0lu2O4p/9Mf8w5MzGQ6G1aQutX4NF16SgNKvSHyTeRxIwskA4
	 Kgr7BnAnea5F1PJ7Fyay+LdxPFvAEHxPuyc2lhe1VF7pMEgXYOe1bVfzoM6Sfs90aT
	 fjHP2A0YVtIgJa3hAbMqTpLo/yXUt57VkU+bWMrjlP/evl+wfNTkPSNBQrKmKYq3PX
	 fZUqcoSHRqPpWcC3ZaWuxzn2dHLwwly6zJJeftLUP72CXyVgbq5eJnd2/dmGMftuSo
	 SPP6sy980FgdQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 11 Nov 2023 16:39:29 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Sat, 11 Nov
 2023 16:39:29 +0300
Date: Sat, 11 Nov 2023 16:39:29 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
	<rockosov@gmail.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] samples: introduce cgroup events listeners
Message-ID: <20231111133929.vyyq33f2jppcgmd3@CAB-WSD-L081021>
References: <20231110082045.19407-1-ddrokosov@salutedevices.com>
 <20231110085952.b55345df8dd18019f0581fc1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231110085952.b55345df8dd18019f0581fc1@linux-foundation.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181295 [Nov 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/11 11:21:00 #22436810
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Andrew,

On Fri, Nov 10, 2023 at 08:59:52AM -0800, Andrew Morton wrote:
> On Fri, 10 Nov 2023 11:20:42 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > To begin with, this patch series relocates the cgroup example code to
> > the samples/cgroup directory, which is the appropriate location for such
> > code snippets.
> > 
> > Furthermore, a new cgroup v2 events listener is introduced. This
> > listener is a simple yet effective tool for monitoring memory events and
> > managing counter changes during runtime.
> 
> Is this correctly named?  It's a memcg event listener. 
> "cgroup_v2_event_listener" implies that it will display events for
> other/all cgroup v2 controllers.

Yes, you are totally correct. The previous cgroup event listener was
applicable for any cgroup event that uses the eventfd API. But my sample
is only usable for memcg. I'll rename it. Thank you for your suggestion.

-- 
Thank you,
Dmitry

