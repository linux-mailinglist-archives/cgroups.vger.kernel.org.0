Return-Path: <cgroups+bounces-534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE377F5A4F
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698BA281729
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506518E17;
	Thu, 23 Nov 2023 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XY3DeP5s"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47281BF;
	Thu, 23 Nov 2023 00:45:18 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F1F25120002;
	Thu, 23 Nov 2023 11:45:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F1F25120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700729115;
	bh=k/7vxiY5zeoTfQ1bw6Cwc7xvQr3MSHEmQlGxKNyL2pk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=XY3DeP5sB2Q9aYHR9//a4sv7k57jPA0BYaKk3gVPw1I2i02N8NLP3VjHtRiDO12wa
	 U9rizn6PXynLquIkV7Ub9FDKm4eUFMgQNs0UznUAi+zYtp5BzGDXZweVw5pbvPHmb3
	 5V0AShrc+q4v7wa95sQuK5jpBsHo9sPr5wo88nMwhOG2P7H0y4ATR0t35dv6InlaMO
	 ftKs5Me4qHBqOfbbOD3cWmKRfGD9eN/4bO2EOKZfElgVIGuE5Sv3NXLf1TLDcX8Oa6
	 UXK1mKHpZeYys4gGYhlfwYZmZt/R6v23wYJi4PizpKhAGKgW5iV5mHN1NXZCxn6Zon
	 NinIm6kkbsNWg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 11:45:15 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 11:45:15 +0300
Date: Thu, 23 Nov 2023 11:45:10 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Shakeel Butt <shakeelb@google.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg
 tracepoints
Message-ID: <20231123084510.wwnkjyrrbp5vltkg@CAB-WSD-L081021>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-2-ddrokosov@salutedevices.com>
 <20231123072126.jpukmc6rqmzckdw2@google.com>
 <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
 <20231123081547.7fbxd4ts3qohrioq@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231123081547.7fbxd4ts3qohrioq@google.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181552 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 06:37:00 #22507858
X-KSMG-AntiVirus-Status: Clean, skipped

On Thu, Nov 23, 2023 at 08:15:47AM +0000, Shakeel Butt wrote:
> On Thu, Nov 23, 2023 at 11:03:34AM +0300, Dmitry Rokosov wrote:
> [...]
> > > > +		cgroup_name(memcg->css.cgroup,
> > > > +			__entry->name,
> > > > +			sizeof(__entry->name));
> > > 
> > > Any reason not to use cgroup_ino? cgroup_name may conflict and be
> > > ambiguous.
> > 
> > I actually didn't consider it, as the cgroup name serves as a clear tag
> > for filtering the appropriate cgroup in the entire trace file. However,
> > you are correct that there might be conflicts with cgroup names.
> > Therefore, it might be better to display both tags: ino and name. What
> > do you think on this?
> > 
> 
> I can see putting cgroup name can avoid pre or post processing, so
> putting both are fine. Though keep in mind that cgroup_name acquires a
> lock which may impact the applications running on the system.

Are you talking about kernfs_rename_lock? Yes, it's acquired each
time... Unfortunatelly, I don't know a way to save cgroup_name one time
somehow...

-- 
Thank you,
Dmitry

