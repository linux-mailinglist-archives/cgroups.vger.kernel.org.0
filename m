Return-Path: <cgroups+bounces-421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D67EBB22
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 03:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB94CB20B65
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7B644;
	Wed, 15 Nov 2023 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Eyagvo7h"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB61642;
	Wed, 15 Nov 2023 02:12:15 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151BC8;
	Tue, 14 Nov 2023 18:12:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRr9Ei3nV5Mve16BLjlRicQVWeXxNbkMBsePrcIpY5qBfF2+b+z3bZZQPvOtZQW5hj4W3dTN7BC/vzj7z06T+2xozQf+X3gJggt3RFxtUpLUrS4/sQsAB4o+IEKYl5fB0gnEJ2m7GpqOuMgLNpZfuJY18Kc6aYgFkiTYruPar1Y7rw053YP69JcvaRP6NY1BN3xDhEnbbgqQWN8GTTdXW/PgY5eh40idaADJYin9bZFzcLnerTQa9HVQWcI7kWltmnd1dEzP+gaGAZ13o2wa2Fo4QMJjLMLvnS5IjljfGnvaSKXyvYmWXWgLOQC0E9UBWer8YBdvo6p8JRW7ya1PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU6JtVK/yCuO8qPAYIFbuvPS/6Bo0WBkN67f8QH8OHg=;
 b=lfMN4p0bIx3Y5BDiPp6aHl2nlPMaqnK5AzbvcE3XdPkcdO8h6P4BbSSTtBDDeMpDPQYyJmc7p0IE9jjZB7XHgO0rXAswSZW3WIn6n/WiezIP6p86ojNBKhTZA9rLG7b0NWRiKJ+sVDXo/P7PnU/VJmTe6/NmskrZlo79RbFU8rCe+BhPGIBstGT6yxRQ7+nnZSmQxt61cNmAR8bufjPF3uTEQ1+fBCK0orYZDPfU+IKIuFiWhwXfonOpEAUH8rR/58n7UAA5spJh8r5kuMWHFHzlalFN5GmocVa778RBxUZQfNa0hKJQh5vRecVaeuDxuZvKG7InQ5ilwnB3oba5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU6JtVK/yCuO8qPAYIFbuvPS/6Bo0WBkN67f8QH8OHg=;
 b=Eyagvo7hwkYppY/JzzjEOSf24TpDduCuiXU3Pq73q78QvGseqFLmoi9fm/b9cX+g642hY48xF9tvDQB4M52+3dWtb3+j+z967LJ6UgmYYoJj1p9O66NULSMr+9IXqevo3wTAWwStNHuDfrwg65SHkf+b+mWclmj+9GomxLg3+EK1LIFTPKfhuuoSb2JKSZO7fxUL5Cjjsq5W93EU4BMUEKatnfEtJGAyc8nb+oGp2Kl0MrOLtdLkA01KKIa1vlZ5eLuZE7dS7AAK1Dkgy1qCFA/4Tdurt9XIVf5FeOIKacKYsngg0UGZXHJ5CHTYo0tRJerF7GgdiX9rJX7swwMZ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6199.apcprd06.prod.outlook.com (2603:1096:101:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.37; Wed, 15 Nov
 2023 02:12:05 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%7]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 02:12:04 +0000
Message-ID: <9c92ada7-e6b3-424b-b940-44048b723d87@vivo.com>
Date: Wed, 15 Nov 2023 10:11:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Liu Shixin <liushixin2@huawei.com>,
 Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com> <ZU4i36tKnyXZ8lZD@tiehlicka>
 <dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com> <ZVNGMmvCmQWSqEyF@tiehlicka>
 <e5099669-3d99-4a9d-b56e-15ce4fc3f366@vivo.com> <ZVNwFV7Fid34pU-M@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZVNwFV7Fid34pU-M@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 917f7796-9ef8-422c-4bb5-08dbe58042dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WWRMZM2VBoLCzUYXB36AF1UgRr5f0XFPoK6smcsK9UTWciegyS8Z3EXeZj0ZaCVg3KZMxT5S2eBT8b2c6C2nvF+W7h+v62exg9YZSkXcSnsThIXYnCkvgDqXTlsrJmKKlivSj0faRwkYEiy6Z4NV4MplgNBi8Lzlt3R27LzTYYqrArfQZ0ikzX50UM+Vw2HaEOBi/InkyrEdJIV/hgWGqrOuAjREImTFpTHUFHuai2OIuLRzdMnNiTNk67SwLBDgVFOB0sE5D+ht5dG2oD464aXfyG0hpYqNGIWVWlNP9w6GXbR9AsWZQR3XogR4rHG8jyV7N+qqT8yxNrextjdI990yKhPjDsPpBzpW34YSS5Gug6EVK2CMeA7AiJLG2M/en/AqUft4xiw7/4z2e6eDrYTxCsikOnDOG+anyqHz/A93rmOt6zdmion55fT9frz86KFqqx/TKGEtQdEpcBmDBKkhsaOM/JUyMOG3YPiVWGonLZMwrSm59NDAq6Uj+830VJx1DghI4DuQEt2YBmtHKPGtU6dgOyaCaEBHInC341biZ0i4cZnklAHY/jnWdzjDY2c3kMeigWq3SNpLh+72WvzXaLy4IPAY2zUPcf77329PsEwoQC/jHzlvSEXVSRPxHNGqDkrhwn3iMpFivOI4OgcOMeNcTuxOIOgPjinNswCUyt8Ns5j01/PdZ7wya0gRgkgZiKc9pY6SmE5Ew1hSL2IJ4OlQL+xqGf5MhWz8Y9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(38350700005)(31686004)(66899024)(66476007)(66946007)(6916009)(54906003)(66556008)(31696002)(86362001)(38100700002)(36756003)(83380400001)(6512007)(107886003)(26005)(6666004)(2616005)(52116002)(41300700001)(2906002)(478600001)(6506007)(316002)(6486002)(7416002)(8676002)(5660300002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1I0VW55VXN3SWx4aHYxUHNNSFlrTnlPaGMyL3lYTkY5cXRxekJDZlVGMHZU?=
 =?utf-8?B?OGplNDU5bVVES2ZHNEN0cUpIQW5WR2EvOHdJS2tnMUthazBqOUZSelV6RkMr?=
 =?utf-8?B?ei92cHZiQmwrK240NkVTYkZIV1J4WC94YkVCQy84NmNJQWllNzBsc29SejRu?=
 =?utf-8?B?TUgwQWxxK0RGRUg2c0FpNUQ3OVlubnR0c3FKbTVKSnFtbURybWR0TTJnZVM1?=
 =?utf-8?B?TmhmL3RlMzJuVFE4b1BKOS9lQ0hBVVRYZzlLZmxGbUdXU2Y4cStIa3RnVnVj?=
 =?utf-8?B?SW5aa2RHVGlrS25aWjBWTzdITDN4S1ZQZzE0MW03QWIvK3NkVmpvbGVzcUF4?=
 =?utf-8?B?d1QvUDNKUjNEMDV1bGZWSG41dXBpRnl4eEFuUy93TGRmdGU3YTc4S2pRYys4?=
 =?utf-8?B?Tlp4Yk9VT2tBM1lJM2sxMHhiV1BoRlpRUXdjV1VKRWc4bjIxR0ZaRk8zMEZo?=
 =?utf-8?B?cFZ3VWtseDJjeTdvUDNsTkVPVzE1eldnTy9BQnhVVm1hUFFuV2dCanJQOVlJ?=
 =?utf-8?B?eFRFV2d4N0R1RCt3V0tiMjVhazVRRlFuY2x5a0hWM0s1WWQzcWdocGgvWU83?=
 =?utf-8?B?bGswMUgvbVRPUVlheENHaVRhdmE2dmhiTzNTRzNneDZaZ2hTK0t4bzVRT1Rk?=
 =?utf-8?B?T1NJWXNFSXRWUlhRUk5MR3pqdTBBSjI3dzlzRUhacDk4aytpOUROYjBEQW9Q?=
 =?utf-8?B?alNvbTNoSkNJa3hVZHV6QVVyVzYrZzVIMldFRjV5TVFzTHA3RGZ1MHl1Q1U5?=
 =?utf-8?B?UTl6SkUxckVmN0lQSGdiUTQ1VVJBMFBxV2N4cnkrU1FsL1h5QUtqazUxd0xI?=
 =?utf-8?B?dmdya0VaQTNBQ1FxU2xWejJudlp0bkN3OUNyYUJmRGFvdU92U2g4eitQaFZO?=
 =?utf-8?B?cWU3L2N3UlJxdkdyY0psUFdxSTZyNjZoUW83aE1ZcEMzU2FnY0kyR1pxQmg2?=
 =?utf-8?B?aU0xdnNJU2ZIM1IvSE9lWXdhNm1ZR2k1RkgwQ3gzWGNtVU5NQy9rWnFoQXdF?=
 =?utf-8?B?SVNBZ3hBQkpMVGRuVk84bUQzQjdiSWNVd1o1RFlDMzkvWnowMnEwMThSaVht?=
 =?utf-8?B?M0plVnducHNNTktLYkYzdEsxN3QrTDBVNXVzdHZ5RlJCMitsOXlxV1pJYllo?=
 =?utf-8?B?akpJTkZXQXZ2RXhPWk5GY0NrVWdxQjZycFdGMFVZQUMxSkQ3UHByRitHY243?=
 =?utf-8?B?VkxkZEc4bUpRY2JvTE9LUHNwWks3bGFRc2syY0ZlZHRnN296VURFZ3pSQ2lm?=
 =?utf-8?B?MkVJV05pNUR5V0tKclFMeXZSeVhtNHNCVXQwdXcvbk5mR081Z2pBUklOZzlP?=
 =?utf-8?B?WitpRUVUcEhBZjdLa01xZnRDVUVzNWlyQzJaYkVTRmxWVmsxSUNNR3FJYkRa?=
 =?utf-8?B?Ty9Oc2hERVpEbU9qcVhRbEZIWEFkdzlMZ0xXTkpyNkJWbjhrdmZaUXd0S1Er?=
 =?utf-8?B?Q2xuVE9wOG4rdExnSHFYd2h0ZUl3ZmhvdEg4VCsrdVI3R29hRXMyZlVNS0pm?=
 =?utf-8?B?cHBWaHg0YjhjUUF6aGVXY3UyMTRqOVIxSElUeTNOdStsNktwMnNBa3Zhbm1Q?=
 =?utf-8?B?eVJkbmJVei92MGd4amo0Y2tmZlQ2YW5mdUo5a0YxUGEwRVNEbzF1VXZjRzQ4?=
 =?utf-8?B?N3dMZTJIQnQwUHdDVVpJOHpuMW1SOWZEZzZ0ckZpVDVUQ3Y3SHlMV24yeTVQ?=
 =?utf-8?B?TlhpMm9uMEdJVE1mNnpzU0hvclZQZWxoTUdtV3E4Zm9lN3ZxZTBlM3FRLzNO?=
 =?utf-8?B?TnhUNlduZ0ptK3UzMGt0ZTZHK09iUUhhdS9sK0RVYVlzSHBYOHQ0dldYQnRi?=
 =?utf-8?B?VkJjRUp4QVZqOGY2L3IyczhyTm8zTXRyOS91TXhHNmU2MG1xS05VM3BZM3Za?=
 =?utf-8?B?QktVZ0JITXNXSmg2VUFHc3p3eWIyTmFNcWZCVHprRENPNm9zMTBOb0pSZmov?=
 =?utf-8?B?N2xjU2oyZUZCc3g1SnE2R1dUYmR4Q0RFT2p4Sjhmc3kwaGYwOGk1czMzeDlz?=
 =?utf-8?B?MG9sTGkranBLUHArU1hIVG1TRjB1LzIyblpxRVZ0UGxmUTFMTHJiSHgvbXVy?=
 =?utf-8?B?KzRXUCs4UCtRdnNTdmJhOFFYVnAxdFZvUXI5NTNXcGcyZTRld2pVaGRXTjJS?=
 =?utf-8?Q?1Ui3abe1W9Sl59jt03E7GEOwB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917f7796-9ef8-422c-4bb5-08dbe58042dc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 02:12:04.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6DabIfTAOzO/kDRgBkz/pStXljCybbcnsJ9R5OMAAwktxA8RQyCPeQXiuRl3Isiqg2qeickpyNNuAoF+dziWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6199


在 2023/11/14 21:03, Michal Hocko 写道:
> On Tue 14-11-23 20:37:07, Huan Yang wrote:
>> 在 2023/11/14 18:04, Michal Hocko 写道:
>>> On Mon 13-11-23 09:54:55, Huan Yang wrote:
>>>> 在 2023/11/10 20:32, Michal Hocko 写道:
>>>>> On Fri 10-11-23 14:21:17, Huan Yang wrote:
>>>>> [...]
>>>>>>> BTW: how do you know the number of pages to be reclaimed proactively in
>>>>>>> memcg proactive reclaiming based solution?
>>>>>> One point here is that we are not sure how long the frozen application
>>>>>> will be opened, it could be 10 minutes, an hour, or even days.  So we
>>>>>> need to predict and try, gradually reclaim anonymous pages in
>>>>>> proportion, preferably based on the LRU algorithm.  For example, if
>>>>>> the application has been frozen for 10 minutes, reclaim 5% of
>>>>>> anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.  It is even more
>>>>>> complicated as it requires adding a mechanism for predicting failure
>>>>>> penalties.
>>>>> Why would make your reclaiming decisions based on time rather than the
>>>>> actual memory demand? I can see how a pro-active reclaim could make a
>>>>> head room for an unexpected memory pressure but applying more pressure
>>>>> just because of inactivity sound rather dubious to me TBH. Why cannot
>>>>> you simply wait for the external memory pressure (e.g. from kswapd) to
>>>>> deal with that based on the demand?
>>>> Because the current kswapd and direct memory reclamation are a passive
>>>> memory reclamation based on the watermark, and in the event of triggering
>>>> these reclamation scenarios, the smoothness of the phone application cannot
>>>> be guaranteed.
>>> OK, so you are worried about latencies on spike memory usage.
>>>
>>>> (We often observe that when the above reclamation is triggered, there
>>>> is a delay in the application startup, usually accompanied by block
>>>> I/O, and some concurrency issues caused by lock design.)
>>> Does that mean you do not have enough head room for kswapd to keep with
>> Yes, but if set high watermark a little high, the power consumption
>> will be very high.  We usually observe that kswapd will run
>> frequently.  Even if we have set a low kswapd water level, kswapd CPU
>> usage can still be high in some extreme scenarios.(For example, when
>> starting a large application that needs to acquire a large amount of
>> memory in a short period of time.)However, we will not discuss it in
>> detail here, the reasons are quite complex, and we have not yet sorted
>> out a complete understanding of them.
> This is definitely worth investigating further before resorting to
> proposing a new interface. If the kswapd consumes CPU cycles
> unproductively then we should look into why.
Yes, this is my current research objective.
>
> If there is a big peak memory demand then that surely requires CPU
> capacity for the memory reclaim. The work has to be done, whether that
> is in kswapd or the pro-active reclaimer context. I can imagine the
> latter one could be invoked with a better timing in mind but that is not
> a trivial thing to do. There are examples where this could be driven by
> PSI feedback loop but from what you have mention earlier you are doing a
> idle time based reclaim. Anyway, this is mostly a tuning related
> discussion. I wanted to learn more about what you are trying to achieve
> and so far it seems to me you are trying to workaround some issues and
> a) we would like to learn about those issues and b) a new interface is
> unlikely a good fit to paper over a suboptimal behavior.
Our current research goal is to find a possible dynamic balance between the
time consumption of passive memory reclamation and the application death
caused by active process killing.

The current strategy is to use proactive memory reclamation to intervene in
this process. As mentioned earlier, by actively reclaiming anonymous pages
that are deemed safe to reclaim, we can increase the currently available 
memory,
avoid lag when starting new applications, and prevent the death of resident
applications.

Through the previous discussions, it seems that we have reached a consensus
that although the active memory reclamation interface can achieve this goal,
it is not the best approach. Using MADV can both use existing methods to
achieve this goal and decide whether to reclaim based on the 
characteristics of
the anon vma, especially the anon_vma name set.

Therefore, I will also push for internal research on this approach.
>
>>> This would suggest that MADV_PAGEOUT is really what you are looking
>>> for.
>> Yes, I agree, especially to avoid reclaiming shared anonymous pages.
>>
>> However, I did some shallow research and found that MADV_PAGEOUT does
>> not reclaim pages with mapcount != 1. Our applications are usually
>> composed of multiple processes, and some anonymous pages are shared
>> among them. When the application is frozen, the memory that is only
>> shared among the processes within the application should be released,
>> but MADV_PAGEOUT seems not to be suitable for this scenario?(If I
>> misunderstood anything, please correct me.)
> Hmm, OK it seems that we are hitting some terminology problems. The
> discussion was about private memory so far (essentially MAP_PRIVATE)
> now you are talking about a shared anonymous memory. That would imply
> shmem and that is indeed not supported by MADV_PAGEOUT. The reason for
> that is that this poses a security risk for time based attacks. I can
> imagine, though, that we could extend the behavior to support shared
> mappings if they do not cross a security boundary (e.g. mapped by the
> same user). This would require some analysis though.
OK, thanks. I have communicated with our internal team and found out that
this part of the memory usage will not be particularly large.
>   
>> In addition, I still have doubts that this approach will consume a lot
>> of strategy resources, but it is worth studying.
>>> If you really aim at compressing a specific type of memory then
>>> tweking reclaim to achieve that sounds like a shortcut because
>>> madvise based solution is more involved. But that is not a solid
>>> justification for adding a new interface.
>> Yes, but this RFC is just adding an additional configuration option to
>> the proactive reclaim interface. And in the reclaim path, prioritize
>> processing these requests with reclaim tendencies. However, using
>> `unlikely` judgment should not have much impact.
> Just adding an adding configuration option means user interface contract
> that needs to be maintained for ever. Our future reclaim algorithm migh
> change (and in fact it has already changed quite a bit with MGLRU) and
> explicit request for LRU type specific reclaim might not even have any
> sense. See that point?
Yes, I get it.  This also means that if the reclaim algorithm changes, 
the current
implementation of tendencies will need to be modified accordingly, which 
requires
a certain cost to maintain.
If the current implementation of tendencies cannot prove its necessity, 
it should
be keep deep research.
This solution may be simpler for me to achieve our internal goals, but 
it may not be
the best solution.So, MADV_PAGEOUT is worth to research.

This conversation was very beneficial for me.
Thank you all very much.
>
-- 
Thanks,
Huan Yang


