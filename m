Return-Path: <cgroups+bounces-535-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DD7F5DAF
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3D0B212E4
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637A22F16;
	Thu, 23 Nov 2023 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gCrG99tM"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9943D6C;
	Thu, 23 Nov 2023 03:21:40 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5DABC120003;
	Thu, 23 Nov 2023 14:21:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5DABC120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700738497;
	bh=Vn+apVzXsEM6pqvtCgpqeXfkP+wK1W/P560NUnnIQWw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=gCrG99tMe19Ma2XQZX1ZrXApT9lHM0RmaeJnK+ikOirwkyOLHbdW0T3SCq4RMakMz
	 YTjh901E2O56zBcccytdOogebIZZqVtHZPxHkhRKLCvgje7gCky0Pqv6kQsx3EAH1s
	 i9E2aCGP59MEwj5lNDzIa2EO+u6owlAOoJwSdCLtMJYYpWpTxXWY0a8euMGMBhXef1
	 J36qV8oONQzlLFd9wHo/LD0kE9Jq1hCZl/OsauD24GposE5t0uaLW63ymrd+4uSICA
	 cb/DJ8cq2SQlYYC/rtV1cUh/iJTvPZ9PUwq6X8lppbaqf++BEh/B8pccZKKrYDkj9t
	 lKyWHhsrXpC8Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 14:21:37 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 14:21:37 +0300
Date: Thu, 23 Nov 2023 14:21:36 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Shakeel Butt <shakeelb@google.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg
 tracepoints
Message-ID: <20231123112136.n7qgkevgrracuk7m@CAB-WSD-L081021>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-2-ddrokosov@salutedevices.com>
 <20231123072126.jpukmc6rqmzckdw2@google.com>
 <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
 <20231123081547.7fbxd4ts3qohrioq@google.com>
 <20231123084510.wwnkjyrrbp5vltkg@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231123084510.wwnkjyrrbp5vltkg@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181556 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 09:18:00 #22508170
X-KSMG-AntiVirus-Status: Clean, skipped

Shakeel,

On Thu, Nov 23, 2023 at 11:45:10AM +0300, Dmitry Rokosov wrote:
> On Thu, Nov 23, 2023 at 08:15:47AM +0000, Shakeel Butt wrote:
> > On Thu, Nov 23, 2023 at 11:03:34AM +0300, Dmitry Rokosov wrote:
> > [...]
> > > > > +		cgroup_name(memcg->css.cgroup,
> > > > > +			__entry->name,
> > > > > +			sizeof(__entry->name));
> > > > 
> > > > Any reason not to use cgroup_ino? cgroup_name may conflict and be
> > > > ambiguous.
> > > 
> > > I actually didn't consider it, as the cgroup name serves as a clear tag
> > > for filtering the appropriate cgroup in the entire trace file. However,
> > > you are correct that there might be conflicts with cgroup names.
> > > Therefore, it might be better to display both tags: ino and name. What
> > > do you think on this?
> > > 
> > 
> > I can see putting cgroup name can avoid pre or post processing, so
> > putting both are fine. Though keep in mind that cgroup_name acquires a
> > lock which may impact the applications running on the system.
> 
> Are you talking about kernfs_rename_lock? Yes, it's acquired each
> time... Unfortunatelly, I don't know a way to save cgroup_name one time
> somehow...

I delved deeper and realized that kernfs_rename_lock is a read-write
lock, but it's a global one. While it's true that we only enable
tracepoints during specific periods of the host's lifetime, the trace
system is still a fast way to debug things. So, you're absolutely right,
we shouldn't slow down the system unnecessarily.

Therefore, today I will prepare a new version with only the cgroup ino.
Thank you for pointing that out to me!

-- 
Thank you,
Dmitry

