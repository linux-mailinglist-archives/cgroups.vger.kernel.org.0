Return-Path: <cgroups+bounces-152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EFB7DE5DA
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 19:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE551F21C01
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C5818E12;
	Wed,  1 Nov 2023 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Tcn4RcdV"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66618E0E;
	Wed,  1 Nov 2023 18:07:50 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C362219D;
	Wed,  1 Nov 2023 11:07:40 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 67E1A10002D;
	Wed,  1 Nov 2023 21:07:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 67E1A10002D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698862059;
	bh=NKk0Ei5MZui3Aywy6eGW1GkpmW3iDmxKvWin8MaGXgg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Tcn4RcdV/HCxG/U9qbWo8mJj96iMrkRvfvy9pXkpfIJ8F5Geon8pTIer16QyOkYL+
	 KKHr+w4rEIKxD4ssopU5w63z7o5YUaEF6b94Z10ugkixJmJvBDKemr2omtYu/z9Mfr
	 UifDNCKg3i0TrmVR0NYCNWpfnrUUCbJW65mDCCW3/FTZz7aP5NeMAMWcQkfVSejAEF
	 PitoFOCAeY6qpl0s1R7O3971tCX2RSkqdGxx8K13qG/JKQqJAdKlhGjAoYmX9IAKUt
	 TbjrNfwTn785fQPN9VUL0p8zPMiEuvkazRb4iVrYmAa9wFavZr4f6dsz90biw3Teer
	 lBI9Ermt4DOqw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 21:07:39 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 1 Nov
 2023 21:07:39 +0300
Date: Wed, 1 Nov 2023 21:07:33 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
CC: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v1] tools/cgroup: introduce cgroup v2 memory.events
 listener
Message-ID: <20231101180733.ok7j34izehrpyfpy@CAB-WSD-L081021>
References: <20231013184107.28734-1-ddrokosov@salutedevices.com>
 <eqvaejfo5uoz5m7e5g3wjgegfo4ribajdgu57fst3hu5m6gfa4@beugaul6pjjz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eqvaejfo5uoz5m7e5g3wjgegfo4ribajdgu57fst3hu5m6gfa4@beugaul6pjjz>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181058 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 17:32:00 #22380453
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Michal,

Thank you for the feedback!

On Wed, Nov 01, 2023 at 04:56:47PM +0100, Michal Koutný wrote:
> Hi.
> 
> I think the tools/cgroup/cgroup_event_listener.c was useful in the past
> to demonstrate the non-traditional API of cgroup.event_control with FDs
> passing left and right.
> 
> 
> On Fri, Oct 13, 2023 at 09:41:07PM +0300, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > This is a simple listener for memory events that handles counter
> > changes in runtime. It can be set up for a specific memory cgroup v2.
> 
> Event files on v2 are based on more standard poll or inotify APIs so
> they don't need such a (cgroup specific) demo. Additionally, the demo
> program lists individual events, so it'd be a maintenance burden to keep
> them in sync with the kernel implementation.

From my perspective, eventfd serves as the standard mechanism as well.
Therefore, when incorporating the cgroup v1 event listener test into my
project, I initially turned to the tools example, which proved to be
immensely beneficial. Conversely, the cgroup v2 inotify example can
solely be found within the kernel selftests. Although the prevalence of
inotify makes this somewhat understandable, having an additional example
would provide supplementary documentation, which is often invaluable to
developers operating in userspace. Of course, there are maintenance
expenses associated with this approach, as you rightly pointed out.
However, I am willing to undertake the responsibility of maintaining
this example if necessary.

-- 
Thank you,
Dmitry

