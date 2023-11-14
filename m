Return-Path: <cgroups+bounces-406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1B7EAFEC
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 13:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B801C20A85
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1E18B13;
	Tue, 14 Nov 2023 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PgFVw23k"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DD3FB12;
	Tue, 14 Nov 2023 12:37:24 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F2130;
	Tue, 14 Nov 2023 04:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv5AZZTYiQVQZj3uRi9hgI3YI1VuNiYzI3HLcBvmmX/3fjcqQ33ym01R92YerWDbMtvejLOiDQIyvITgJTbaBR3cjoEugnjQ4tPp0Cq+lLzO/YgruPz1o+9mjw6fjx4qYC70GBVe4dxi93V+mF8aaAYaTaUVEBdcM79tXvG1qoh1ktzYik7YRdxyfUcEgnVdvuMdAifxjdJYZ7R6kDnT5n2VKr7JMs9IzMmdY0dfpIZccJKaC9DvQg4R7DPODs+NTa8ETh07A1uZ1R6IPO2tyILKIf0bHfcJ+Xy4ZPUnCv2+K9Xo0X0lP8NShXgWyS9OkYa3/A/kOEAtq7TdgAhDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/uurate3Q2acPclnqV0WxixPXJDhd+l+peAPxLoYss=;
 b=Csx5AO8/O06DQU9DE4xPwyTQluTNPO5c9fKqo3IBG3VoBiacTzRkFpJAhhhKoXRM01Okt/TBOrhnPGEb0O/jkat65ahjwpivxewW88qTCJeJYtM2Kq3NnqxgW33t9CG8wKRDkfz0LBWUmeo0++fR/v/56/dB18LBjqokAWplgEzmDuEvoNmszEqrvQKowfyfOC2lUl8qV54oK0jpCqbZlIKl7A1ulJNtujQOj9t0xy19L04JsuNUzshT97m19wpafO5jHhsFvFjUqQagfDT9ZC0milHwYUsxE72OSuqxU1K+7ke7Ba4WD3jdTuxRAjzVr+czGBpdpRAeXMWCciIvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/uurate3Q2acPclnqV0WxixPXJDhd+l+peAPxLoYss=;
 b=PgFVw23kWwulH2YNvSMBFZIoEA52cS1iMK6WeRcBmT4b/AM6nPag4YnGSLjIR+uYVXIaOeUDgkixGIPLQVdEX14jPnbFauAZGSn9+VQfIbnO1xtbd27beuKB2TDX3vR7PR8zXLmSpsnHuz/RXdWyw4+rs5LT4fogiMWGfnfzDBUUf1PN2Y4yesloerI4awax0bfaKCfa7O83Lfrg8tEu+9Qe0YFgFk4PZHMYjd23XrLqWOfshXaSAcfj03NHwoF5hggAWtkyUp075bMGhX8abWU1P+4NUrt7dDijckl7hcmmkoF5OrLHzC+SnOY5wrnkqte7ovNtZYLadibQTh4wHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB4444.apcprd06.prod.outlook.com (2603:1096:4:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.33; Tue, 14 Nov
 2023 12:37:15 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Tue, 14 Nov 2023
 12:37:14 +0000
Message-ID: <e5099669-3d99-4a9d-b56e-15ce4fc3f366@vivo.com>
Date: Tue, 14 Nov 2023 20:37:07 +0800
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
References: <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com> <ZU4i36tKnyXZ8lZD@tiehlicka>
 <dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com> <ZVNGMmvCmQWSqEyF@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZVNGMmvCmQWSqEyF@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: f506acb1-436b-41e0-9d76-08dbe50e6dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9ZzJ26ncRXnsVneZYS0KpYapHgN+HlBUA7OOyzGatn9PhJTS5VsQllIC60W86JKlMEX1qzq6l0WCUXodl0CbiwaUQbmEJmo2ZVaYn4b2xexoy+Hsam4TJlT5IZ0PDsDDlMruGbs5WY0ThtFH433Y8KXMZnHk+/PkrkvtUroh3sQf92zOM7x8exprl+Q/N+jTbc/nU7wUYlPnADUTux0XChllXiCgVryiFOvoKPdY0PpaEbKZBFNJ+uWvQFhinwGNOfqOe49lH5qOyY9J/MYyaVXVkcgMelM63TuJnIgfgT7rkYQBCwDL7jKigNohi2zWXYAVSOg/RblJoajBsCKmRehv8LgLdgMrbtvlIUdl9EogrqjniPic7Sf2m5eqHtDvkUr6v4lOVuf9PwX/RiOBiU4ilx6Xx8HSfrYg0JDxAijtBTOM+IwXk3Zfh4kLXTuNxjA47jV72J8vHPdv0fvOjs1PC/W3hkedvknioXUsFDDYZUkXdrXB7TtZvJbrOgTg+7VzO3sNeho/xuvbXfA/O+P6lZafJ3d6klcJGG77fPyH23XKhuiHZLJNXBcyxfW/MWykgQH4qZ6JKCbeKXlMMlVXuiv4DYaizM1+d0o1AGcGwxJeqCmeLyEe0DddS3OxLUhWmDOrWvnacMdk55COmsIUfO++HC/C3t5do6K6sLMKcGuOxVIq0S6jBMXIQrBGkJrG4grdlwQX8SkSeXLWpblNMmw0KfnCxHraWII5QQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(38350700005)(6512007)(107886003)(2616005)(5660300002)(6506007)(31686004)(7416002)(52116002)(26005)(66556008)(6666004)(66899024)(2906002)(83380400001)(66946007)(54906003)(66476007)(6916009)(478600001)(41300700001)(36756003)(316002)(8936002)(4326008)(8676002)(38100700002)(86362001)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5kOUdoNDQxYjh2eXo1UE0wNjBQaWVYVldxVzVTekhCTFdQMkRlV0lHTkdN?=
 =?utf-8?B?QXBVTTlqNmxrL3Z5d2pxb2NtY1I1QmRQYW1oV0djNmh1MFZZYVNCYkhyTld1?=
 =?utf-8?B?cldxemE2aHhlMFBYNGwvb3c0ajRZdGdaWHlxTjZSb041VFpiK1dVNXhqdWF1?=
 =?utf-8?B?bHJHZS9YOEJTWWF1NXMra2VTSUJ4MHZYREh0RzFVTkdOZmkzS1JXRE9ZalM0?=
 =?utf-8?B?ektkeFdINmZVdlM5bzN3UGlJeGh3cm1BYUcwVmVNWDRPNDNVWXZxd0Y4cHY4?=
 =?utf-8?B?bTBaWmFPSUNvRVJQYWlnS3JjUlc4VU5oTytxVU13THpORkRreC9lSmtYSVY2?=
 =?utf-8?B?YVpLSHRGRkhzQ1ZYMlpBYTZPYTBzVjFndU1kU3VURERZbzNoNzM4ejRZc29y?=
 =?utf-8?B?Q0RWRTBCTE5BWWZIYjBwcEY0eXFDQnhhTVAyTVRKeittZW8zM0Q2ME1PTHBj?=
 =?utf-8?B?SWZjUStuUytJdjd0OHVTRVNiZVF4Um9Vbm42akN0cVc1ZEs2aFo4M3ZzS0c0?=
 =?utf-8?B?ZHdrRS9RUmZLK2FzTFUwYkI2OC9xSktmN3NWSEt3ckJwVGxMamdrK0lHY2xI?=
 =?utf-8?B?MU0zNVl0MFpjYU96TFMzR2Y1NkM2c3EyOENSdzhrbENyQVVLVmNjRkt3c08r?=
 =?utf-8?B?UndkTkx6ajVXUWxhNHdneFZnSHQ0c2hFQ3JEZzBtcEZ3bENxalZCOFZWTnVS?=
 =?utf-8?B?cUxhU2ZadTBIOVBmdlJMd3cyUUZtdGdQRVJxR20vS2RiUlFKTVRpNE9OZkph?=
 =?utf-8?B?L20xNTJPNGx6dGphdUFYOUhoUFRFWmxTZkRQNHVkNkRyRVlUQ1JlcUpLVDB6?=
 =?utf-8?B?QThWalZzZmE0aUs3aXFTOWVhYjFHdStGanFwOGVWRjI3ZnNpc09Ccjh3RGdU?=
 =?utf-8?B?K2Zyek9aeFFTQ2lkeGdMUXAzbDh4Tjc4d3JwckM5TURoZjRKTXZOTkZ0YkNS?=
 =?utf-8?B?NWxkNmV5QnhiRStBKzVHT25yeUxoeERxbEg3MzJXRTJwYkNJVXRpbUpGZFZw?=
 =?utf-8?B?d1BlQWttWXl3WG5rSksvalBGT0VKUnhMSzRLM1AzNG9xdm1pby94ZFB3dFUr?=
 =?utf-8?B?dXJiV1ZkK1U5VlhmM09wekZST3IwdGNscjd6ZmhwV2xNakRuTUdqTTdzM2Yv?=
 =?utf-8?B?S2NVd3A3dE0vcmxFYUk5QmZvbmtmS2VaUnNNUm5xMUNOejVyQi8vTkVTclNy?=
 =?utf-8?B?OGV2TGlPNGFLMi9aWWI0Qkw4WmtJSnZYZFFyQm13UEZiT29wRThXUU12TjE4?=
 =?utf-8?B?NmVTaXRoWEZkSEFybVdQOFE1aFFuam1jSEF4dmhrMDVNVjQ4RkpxdUN0dllQ?=
 =?utf-8?B?WTJjblpwQmk4RERiUEswVGxkOWZMMkVpd1JabGQxd2VzaG1NZXNDYkw4WnBX?=
 =?utf-8?B?UG8wc1luREpZdDNJTnRpamhGZXM0LzhXbXBqcjNIdXM5SXozMjB1NnRtMUpO?=
 =?utf-8?B?aWxVdzhFU0FmSVQxb212ZEhHT1Z5SkpZRFVXL2tVbTE0SzZlNExwL3d4NkMw?=
 =?utf-8?B?TDBucjhjNjJDTDgva2E2WEhmbFkvWDB0bEZ5bUtQYUhDcHZoQVlHY1owdjJK?=
 =?utf-8?B?TCs2enhpcVFWbFJQYll5NGVsSjVMZUt3OWViVzJkSkpGWjJVR0FRNG85ZFY2?=
 =?utf-8?B?UE9pZ0ZPdW1hRGU1Z00xc0FLVE5YbU0xV0FmTDIwbUFBYW5PVm1YcVI1V0xI?=
 =?utf-8?B?OXQ1L2lSU1orMXEzU0dSdGt0YW9lUzBTQStVak5lSGVCcUJraVlOVElRanlp?=
 =?utf-8?B?NlJMejVITUYxOVppQU1haTBhZkdHMncxT2hsOXRtSG44TlJsaHduVUZkQ2FJ?=
 =?utf-8?B?RC82WlQvem9lWjJNc1FRalFuN1VvdGozbnpoOXk5K1JCRklHTEo5QVAzb2Y1?=
 =?utf-8?B?VjlUdnA4cTY5ZGFaODQ4MW13UmZjMnc3aUxUbGdVVTdDY3dPNzdUT3IyV09j?=
 =?utf-8?B?N1Frb0ZqRW9kSDlKOFFVQWZnWEo4STRIOWlpcDJKd1pLMS9meFJRUWxhSGlY?=
 =?utf-8?B?d2VQcStXNXZIR0NPZktDREVFdlZJaDlDeTN5ZG10NkpwOVpkSlFIcFJJS3J3?=
 =?utf-8?B?d0NXS0FZWHZqa3hsN21UbFJiSUdyUVBCeHFVQ0QzdnFhNktKNDF4K0h3aVAv?=
 =?utf-8?Q?LyqfojvC12UUhq2IBiaqTuSQu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f506acb1-436b-41e0-9d76-08dbe50e6dcd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:37:14.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXbiR+gEqz8S88YbIU3+7qMUtYNl9OLGKbg9svMgu4akjEeJDB1olpdSs88XcAPRNAG9FdycXscKIcea1YdHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4444


在 2023/11/14 18:04, Michal Hocko 写道:
> On Mon 13-11-23 09:54:55, Huan Yang wrote:
>> 在 2023/11/10 20:32, Michal Hocko 写道:
>>> On Fri 10-11-23 14:21:17, Huan Yang wrote:
>>> [...]
>>>>> BTW: how do you know the number of pages to be reclaimed proactively in
>>>>> memcg proactive reclaiming based solution?
>>>> One point here is that we are not sure how long the frozen application
>>>> will be opened, it could be 10 minutes, an hour, or even days.  So we
>>>> need to predict and try, gradually reclaim anonymous pages in
>>>> proportion, preferably based on the LRU algorithm.  For example, if
>>>> the application has been frozen for 10 minutes, reclaim 5% of
>>>> anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.  It is even more
>>>> complicated as it requires adding a mechanism for predicting failure
>>>> penalties.
>>> Why would make your reclaiming decisions based on time rather than the
>>> actual memory demand? I can see how a pro-active reclaim could make a
>>> head room for an unexpected memory pressure but applying more pressure
>>> just because of inactivity sound rather dubious to me TBH. Why cannot
>>> you simply wait for the external memory pressure (e.g. from kswapd) to
>>> deal with that based on the demand?
>> Because the current kswapd and direct memory reclamation are a passive
>> memory reclamation based on the watermark, and in the event of triggering
>> these reclamation scenarios, the smoothness of the phone application cannot
>> be guaranteed.
> OK, so you are worried about latencies on spike memory usage.
>
>> (We often observe that when the above reclamation is triggered, there
>> is a delay in the application startup, usually accompanied by block
>> I/O, and some concurrency issues caused by lock design.)
> Does that mean you do not have enough head room for kswapd to keep with
Yes, but if set high watermark a little high, the power consumption will 
be very high.
We usually observe that kswapd will run frequently.
Even if we have set a low kswapd water level, kswapd CPU usage can still be
high in some extreme scenarios.(For example, when starting a large 
application that
needs to acquire a large amount of memory in a short period of time. 
)However, we will
not discuss it in detail here, the reasons are quite complex, and we 
have not yet sorted
out a complete understanding of them.
> the memory demand? It is really hard to discuss this without some actual
> numbers or more specifics.
>   
>> To ensure the smoothness of application startup, we have a module in
>> Android called LMKD (formerly known as lowmemorykiller). Based on a
>> certain algorithm, LMKD detects if application startup may be delayed
>> and proactively kills inactive applications.  (For example, based on
>> factors such as refault IO and swap usage.)
>>
>> However, this behavior may cause the applications we want to protect
>> to be killed, which will result in users having to wait for them to
>> restart when they are reopened, which may affect the user
>> experience.(For example, if the user wants to reopen the application
>> interface they are working on, or re-enter the order interface they
>> were viewing.)
> This suggests that your LMKD doesn't pick up the right victim to kill.
> And I suspect this is a fundamental problem of those pro-active oom
Yes, but, our current LMKD configuration is already very conservative, which
can cause lag in some scenarios, but we will not analyze the reasons in 
detail here.
> killer solutions.
>
>> Therefore, the above proactive reclamation interface is designed to
>> compress memory types with minimal cost for upper-layer applications
>> based on reasonable strategies, in order to avoid triggering LMKD or
>> memory reclamation as much as possible, even if it is not balanced.
> This would suggest that MADV_PAGEOUT is really what you are looking for.
Yes, I agree, especially to avoid reclaiming shared anonymous pages.

However, I did some shallow research and found that MADV_PAGEOUT does not
reclaim pages with mapcount != 1. Our applications are usually composed 
of multiple
processes, and some anonymous pages are shared among them. When the 
application
is frozen, the memory that is only shared among the processes within the 
application should
be released, but MADV_PAGEOUT seems not to be suitable for this 
scenario?(If I
misunderstood anything, please correct me.)

In addition, I still have doubts that this approach will consume a lot 
of strategy
resources, but it is worth studying.

Thanks.
> If you really aim at compressing a specific type of memory then tweking
> reclaim to achieve that sounds like a shortcut because madvise based
> solution is more involved. But that is not a solid justification for
> adding a new interface.
Yes, but this RFC is just adding an additional configuration option to 
the proactive
reclaim interface. And in the reclaim path, prioritize processing these 
requests
with reclaim tendencies. However, using `unlikely` judgment should not have
much impact.

-- 
Thanks,
Huan Yang


