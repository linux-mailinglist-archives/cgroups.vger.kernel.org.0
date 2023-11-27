Return-Path: <cgroups+bounces-568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547097F9EBD
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F63A28159F
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD31A5B4;
	Mon, 27 Nov 2023 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Iivz9lHn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC73B8;
	Mon, 27 Nov 2023 03:37:41 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 431C112001E;
	Mon, 27 Nov 2023 14:37:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 431C112001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1701085060;
	bh=ngPthKNSbqBvX4ng8JZc0JixK0jI2zKMbqB/abEZ/Dw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Iivz9lHnTMGoUYPpuaaH+uCenvSk6ZN7gGLPHlEfsNNTD9i4jG3Cf9DvOrx7rPnR7
	 yho9zRRXiavy62iqJJAfLYqZv75wmeaSTGApDPshJLzsqoYccKdI4hwzbLHdswwle8
	 mlEdOXPNg2E7ScsXJMCosaOFVtsIj4sukfa9OmwH6lZiLR5dVMrI1dDHj6QvQUioqc
	 DUl4Qog8CDbfp2bjCypesUlDUOrsWTOBl5J+Q04ofy7SbMVPWTo1yDMaWnBtDlM/4Y
	 sOqoeu0yQI7zeSSbMkNngUMEoABArZV8uITDSG7QuUTxGN6aBGWTTFN4tlPEm4o6gI
	 VpwoYaeOCIQ+g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 27 Nov 2023 14:37:40 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 14:37:39 +0300
Date: Mon, 27 Nov 2023 14:37:39 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Michal Hocko <mhocko@suse.com>
CC: <shakeelb@google.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<hannes@cmpxchg.org>, <roman.gushchin@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <20231127113739.djqzy2p2ofstjmm3@CAB-WSD-L081021>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-3-ddrokosov@salutedevices.com>
 <ZV3WnIJMzxT-Zkt4@tiehlicka>
 <20231122105836.xhlgbwmwjdwd3g5v@CAB-WSD-L081021>
 <ZV4BK0wbUAZBIhmA@tiehlicka>
 <20231122185727.vcfg56d7sekdfhnm@CAB-WSD-L081021>
 <20231123112629.2rwxr7gtmbyirwua@CAB-WSD-L081021>
 <ZWRgeAMxQ580-Fgd@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWRgeAMxQ580-Fgd@tiehlicka>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181606 [Nov 27 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/27 09:57:00 #22553179
X-KSMG-AntiVirus-Status: Clean, skipped

Michal,

On Mon, Nov 27, 2023 at 10:25:12AM +0100, Michal Hocko wrote:
> On Thu 23-11-23 14:26:29, Dmitry Rokosov wrote:
> > Michal, Shakeel,
> > 
> > Sorry for pinging you here, but I don't quite understand your decision
> > on this patchset.
> > 
> > Is it a NAK or not? If it's not, should I consider redesigning
> > something? For instance, introducing stub functions to
> > remove ifdefs from shrink_node_memcgs().
> > 
> > Thank you for taking the time to look into this!
> 
> Sorry for a late reply. I have noticed you have posted a new version.
> Let me have a look and comment there.

No problem! Thanks a lot for your time and attention! Let's continue in
the next version thread.

-- 
Thank you,
Dmitry

