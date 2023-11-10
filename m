Return-Path: <cgroups+bounces-307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E744E7E77B5
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 03:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE1F1C20C87
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD6EDD;
	Fri, 10 Nov 2023 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PAe2uygv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4606365;
	Fri, 10 Nov 2023 02:46:26 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA78133;
	Thu,  9 Nov 2023 18:46:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoAdCnyFuZn91EZSTzZQDBqeqXq7f2lS7rhBwT4cwLwFDFc0nGHL/tg7sPBqO9WsPCH1rjvdfNh4k3vuM6N6SAnHYzrx+E4NWgJlzBQCjWRA9RLI7s2BjdkBlNL1NAppxWsu8u1gzZVY3umsU2eAaowLe1JOU+imew59aP+gnFVmvr63SDjrn60oWapipm8kYGhaT4Ir6TO/tGSzCju6DH/tLvUPBjXARTDDs2AOEvMVkfU4v8XolhdE8/Ex0ZCNgGaxOlc0jeqdF/1/CjwtPkIqmb+zAegNpYHP41h+bsoipUgHjI3c7AOUKuKwfb3Th9IKurEDh69PfaTQiJnTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWCUaVn263Bz0xoiETmgXPyffd0LpAzDQtWx2nPL7NM=;
 b=Rsp7297xZSF+IOVr/3fSS1OEoJ4Fczr1MzP0mFX/feJLfubfDewGMvrR9LUqf93h7QYV4o+JtYrWknhWTGzp6S24PTbWvQ5UhCegvsTNN4UVJpombslgzefxzN7RXQtSeLZgmMr9YCSXH/Nlib6rzauxbUDpKFqfumkilYgcJFngCOrBWWDRgQbDh2eU6Y19xovBZ+gg/501am6z1PyHjZNpSTHflUl7Sv6YysPDLs/0Osk17YbaY2+UWy6LDtkhKpWu19ufftT7fflo6XTOSOTM80tLtvz8b08CaVVOv0hBLTaEbMXZOjw3cXq7Qr4NIakbteXuVXj6vvNFomKAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWCUaVn263Bz0xoiETmgXPyffd0LpAzDQtWx2nPL7NM=;
 b=PAe2uygv9VedZIMGEGogLRRZWK7LttJk4mgKiBGnsxorO41mEqf4P2gl7t46AG37dPznLTZEsqARZPgGCfOs/qbdGbEYTvbf2pDbD+p6xQ3NPx/PzRaq7D0kbLN16ySp6sWKtlrCjd1Ado8iAaHTgwTrJanRpgvk25O0PJTJ1ef/46J82F4Aqw/IIpgizcDj0NQAtPVNlWnZIRr/5yjHgfNU58iK4f91xarC/0nuyM/PhfMOIYSTPySd5y6nQwbDFZmb6RSUggiHraHYs8CtRMxOlWCnWRSYmk76+AW8Nhsxze+HlUxrS4OLUUJCLpvQD/NbGNPOzK/8efa8sIhYtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB3947.apcprd06.prod.outlook.com (2603:1096:4:f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.31; Fri, 10 Nov 2023 02:44:51 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 02:44:51 +0000
Message-ID: <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
Date: Fri, 10 Nov 2023 10:44:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
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
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka> <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB3947:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c6e6c3-bab4-4e3d-f74a-08dbe19702e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dfpTcCt9jhKWVQ3VBSNpGX9irMfuD3ko6aXzp1vfVE2HLYsG1h9HQPK2Tyb6kWzZt+UHte93C70+TTDInHsMKAf0tdGyoItNqY7QppNx3QA5FSlPVKEVABiZDwPQmDpMwsARGSWcqqpNxVVhssAM2Po1d/Kz3+eTevvVNE4HRADfODkFO6yLcLcGjoyjb87b9sraHaCB3NaUj/T6GLxwUrOncRsxecFy5Ce+6xweu69Xy8lq/zkxVbid/ylFsX+QTQpqt0OlSC76uLR9Dbt7T9Cdma5TzrfvSPXHbFvlpjWE0ih/0gK8uHNckQoVSyiIqLydsxdt72+Y1jqX0L5mp2uAeCfioUMZYQKVXh4yFXpNvfxlQUKwoIrQUkGgElrB/o8tufUmar3lt10nNqQzqlvZsSRmK4ySozMVJ4h3XsbUyDy8dJLtnxzVrKAcc2bdJe3hN7pbDvOnWtus9YY9h61AxTGmHzDXbIr8O6Cv0eiU8TSNBiY+hqQ56Z9ruQ0iLX5tBtn9q6jih6LPoSYMBEqr2rQrXzzO5/miXeXcxIo39vsLggTS11tOqR6wI/M78wVt1qXg5jw6Pkncta77eA3XYkFanT3SYUT1YEJfNCThEpHycUJsoUdmIK1Jiv6K4tw5Y8NmBKIhKVP28w5FyJ4IO5Hn/SkK5QHT7/k02d0uMZ5bgeg8XrhJH8saKoGeQPNuQdlyiBOS4HB3qUoKI8ULGn5gdRxI9zq/RGpleGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(83380400001)(2616005)(107886003)(966005)(478600001)(6486002)(8936002)(66476007)(36756003)(2906002)(7416002)(8676002)(4326008)(86362001)(6916009)(54906003)(38350700005)(5660300002)(66556008)(66946007)(31696002)(26005)(41300700001)(316002)(6506007)(52116002)(6666004)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3dHamJBb3pFYVE4dFdGbEFidGtadHRJMEpqZnBNNWlpS3l4UjRBdVZkMWI5?=
 =?utf-8?B?YTdEdHRxOG5SS0YwZzVpaWVKYWh0UEEvMk1XcUhCaFNvd1dQSU9tY3hBRk1V?=
 =?utf-8?B?cXRrOFBJK3hVMDZQWUdNaHNqUXBGN2tCczlnaS9zN294aDFhSDZkOXVFU3N5?=
 =?utf-8?B?OTJBVkdtdENXZG1PUm5JSkx0ZWhRd1BqeVdPYjl2S1F5eFdsNXpCTFdJemht?=
 =?utf-8?B?eVBSODlxNlJ6WDd5ZUVlM3VaTzZFbERFaUJRb3lGNnpTSkZXeXBseittcEdN?=
 =?utf-8?B?cnVNZE90L0RGWUVuZko1dnNZeUFKem1tTUUzTGpxVEJqQTN2LzRsZzdNRG1O?=
 =?utf-8?B?MTVCVXYrMURkMlNlZk45T2hLNmZ6VnR2VDUrQVhkTnRyRHIybHlUQzBGRS9l?=
 =?utf-8?B?RlVkTnhmMTI0b0gvR3hhLzc4ejhqN0VsMlYvMy9henNTZllEY002MzArUEJV?=
 =?utf-8?B?cWRlWFh3QkxIc3BiS1BPZ2ZFSlM4aHcrK0tYVXhXaEkyOG03TTYrcDdHVFdp?=
 =?utf-8?B?cU5LaUFmdzdZd0lZNklqSWg4eXJWci91YTJVVTJvVExINzVwanIrNS8raytV?=
 =?utf-8?B?dHFtZldVR2M4b0ovUTBjRmMzQmxzYXRLems3L3ZQcUQ4KzNkaXF4RUcrcUoz?=
 =?utf-8?B?eWFhczJsSVN3ZjVOaWQ3UnhtajNUcUlkZnc5S3BOVTRRRm9ya0l2YzFzUFJL?=
 =?utf-8?B?dGdlTVdTbHR6WmgwZHFMVENhdDMyU0o5Vk5NWGZza2FsM1AwNVd1bGNjR1l0?=
 =?utf-8?B?LzMyczh3cHF3bEc2MXEyWGpOTTlnSDBHVGNEL1RVTHZBMGllT0NxNXJMbW53?=
 =?utf-8?B?T3pxd0UyOHBOazE4dU9JTmFoR3p5dWRSMytYU3Q0U2grcjdjcSszT0tJaHBL?=
 =?utf-8?B?ais5ZjFFSHQycER4d29vcVkwNExaOEtJZkpQTEVVS3ZITmhpLzg1OStnbFdQ?=
 =?utf-8?B?Snl5YU96bWNsYjNtMEpUc0IyamlDNmtKU3dmWHBPUHZpUVhBMnpXVzBSSFRR?=
 =?utf-8?B?Z3h1QWdjVW5MMUVFeStSNFloVDh2MzRLNE9JRjVJRFRLUjlheTFqSk5pbU9W?=
 =?utf-8?B?bmVDT0xSRDNmL1hoQzRqVVEyY0N3QWpoWklUMzBFVDJKeCtVTm5aK0l4QkE1?=
 =?utf-8?B?UTdmbDJZS3A2bHo0dXA1bnZFSisyMmJBeStNblduQjVWRWJvYS9TOFdFcUQ5?=
 =?utf-8?B?RCtIblY5N0VnV3haWE83WSszTWFKaGgrb2pwWm1ld0lsVnoyb0NCbi8rSm1T?=
 =?utf-8?B?NHdiYmtnR21NSFcyQWNyZWxvMUxvd1d6eVZEUXZPNm1MaytTa2dsM0JyaFRh?=
 =?utf-8?B?di9FaExWQm5IYjNiNGd0KzFLd0NsblJwaWpOSHZpblU4OVNZbUI1TmNuNldj?=
 =?utf-8?B?RkREZ3F1OVVUMHZ4NEswM1cwNXNNSjdYNzB5aVFYdDBCWldGWll5UGZzT3Zz?=
 =?utf-8?B?a2dxb2p1NTlGMlRRVnlsZk1GOTFCSTJVbjA0N3JRZFVGQzRJYXdBQngwRkhN?=
 =?utf-8?B?TmlsSXFSSjJkUFJiQ005SzhWYmNveVNuRzBWSEdqSE5XMWt5TGUxNTVocU5W?=
 =?utf-8?B?UzRROU1TM2p3S2VGS0FueDc5Ynd2UUpnS3FTNVdHS0d0UHQweXhWSzM1RG9L?=
 =?utf-8?B?YkQyVXQySy9WZ3QrZHNKSjIzcmQvaGtybUFoeTBLUGJ4YnA1Vms3ek9mUFRr?=
 =?utf-8?B?aWpyU01uVi8wNi9nT1I4aDg4UVlHeGpMVWJaNmMySnZRQlJrNmlxU3NyNVFp?=
 =?utf-8?B?cjdwOWZLdjFDa0RxTlhURU55YUtSYkNaLy9VUmFSZXN5YlVXUzAzYWdpeWEy?=
 =?utf-8?B?Q3ZadlRoZVB3S3NVdGpZcG51Wkw0anc0Y2M3emUvNmg4Z2tBVGhIWEVhS2xI?=
 =?utf-8?B?V2NHQmZwNlJIVGIxT1c3Yjl2QTNtWVRPRW1NTThIYjNyL1lVRGhSK0V6TEJv?=
 =?utf-8?B?RU9FQTAvODZPaXRXODRxZHhwVzQzQWRZUUxJaWJpTG41NU1YbkFtSjFOcldU?=
 =?utf-8?B?ZTltNnl3Rmg2bXE3WGgreE5Bdmo4UXpsZzdiZzlMQVRSbTcwTDN3TzExcVpL?=
 =?utf-8?B?cTVUS1ZZdzlJSnY5M2VzaVlmS3I4K1NRMEpUUVZ4MmtWb1JXWHBPYXpoTkNv?=
 =?utf-8?Q?d14OJTRYsDf2xfBI4GCViZ00O?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c6e6c3-bab4-4e3d-f74a-08dbe19702e2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 02:44:51.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzWjIoMGMgRsICgb2sWWeupvsvv3Sl69FBTHdu+964N3Gl/kgpmWkt+oISQ+GeDwkvvdKdiM2oz32bXqY99ggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3947


在 2023/11/10 9:19, Huang, Ying 写道:
> [Some people who received this message don't often get email from ying.huang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Huan Yang <link@vivo.com> writes:
>
>> 在 2023/11/9 18:39, Michal Hocko 写道:
>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Thu 09-11-23 18:29:03, Huan Yang wrote:
>>>> HI Michal Hocko,
>>>>
>>>> Thanks for your suggestion.
>>>>
>>>> 在 2023/11/9 17:57, Michal Hocko 写道:
>>>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> On Thu 09-11-23 11:38:56, Huan Yang wrote:
>>>>> [...]
>>>>>>> If so, is it better only to reclaim private anonymous pages explicitly?
>>>>>> Yes, in practice, we only proactively compress anonymous pages and do not
>>>>>> want to touch file pages.
>>>>> If that is the case and this is mostly application centric (which you
>>>>> seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
>>>>> instead.
>>>> Madvise  may not be applicable in this scenario.(IMO)
>>>>
>>>> This feature is aimed at a core goal, which is to compress the anonymous
>>>> pages
>>>> of frozen applications.
>>>>
>>>> How to detect that an application is frozen and determine which pages can be
>>>> safely reclaimed is the responsibility of the policy part.
>>>>
>>>> Setting madvise for an application is an active behavior, while the above
>>>> policy
>>>> is a passive approach.(If I misunderstood, please let me know if there is a
>>>> better
>>>> way to set madvise.)
>>> You are proposing an extension to the pro-active reclaim interface so
>>> this is an active behavior pretty much by definition. So I am really not
>>> following you here. Your agent can simply scan the address space of the
>>> application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOUT)
>>> on the private memory is that is really what you want/need.
>> There is a key point here. We want to use the grouping policy of memcg
>> to perform
>> proactive reclamation with certain tendencies. Your suggestion is to
>> reclaim memory
>> by scanning the task process space. However, in the mobile field,
>> memory is usually
>> viewed at the granularity of an APP.
>>
>> Therefore, after an APP is frozen, we hope to reclaim memory uniformly
>> according
>> to the pre-grouped APP processes.
>>
>> Of course, as you suggested, madvise can also achieve this, but
>> implementing it in
>> the agent may be more complex.(In terms of achieving the same goal,
>> using memcg
>> to group all the processes of an APP and perform proactive reclamation
>> is simpler
>> than using madvise and scanning multiple processes of an application
>> using an agent?)
> I still think that it's not too complex to use process_madvise() to do
> this.  For each process of the application, the agent can read
> /proc/PID/maps to get all anonymous address ranges, then call
> process_madvise(MADV_PAGEOUT) to reclaim pages.  This can even filter
> out shared anonymous pages.  Does this work for you?

Thanks for this suggestion. This way can avoid touch shared anonymous, it's
pretty well. But, I have some doubts about this, CPU resources are 
usually limited in
embedded devices, and power consumption must also be taken into 
consideration.

If this approach is adopted, the agent needs to periodically scan frozen 
applications
and set pageout for the address space. Is the frequency of this active 
operation more
complex and unsuitable for embedded devices compared to reclamation based on
memcg grouping features?

In addition, without LRU, it is difficult to control the reclamation of 
only partially cold
anonymous page data of frozen applications. For example, if I only want 
to proactively
reclaim 100MB of anonymous pages and issue the proactive reclamation 
interface,
we can use the LRU feature to only reclaim 100MB of cold anonymous pages.
However, this cannot be achieved through madvise.(If I have 
misunderstood something,
please correct me.)

>
> --
> Best Regards,
> Huang, Ying

-- 
Thanks,
Huan Yang


