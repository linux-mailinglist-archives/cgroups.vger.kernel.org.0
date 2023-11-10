Return-Path: <cgroups+bounces-311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6B7E792E
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 07:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AC12817BC
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDCF5C9A;
	Fri, 10 Nov 2023 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="phknc30Q"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB463A8;
	Fri, 10 Nov 2023 06:21:35 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF00B6E8D;
	Thu,  9 Nov 2023 22:21:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKI0bx/A15yIopXmC2b7lRlT6r+yorjjl9Qy43GxjqL7gQRXEELjpODu+mvSVk46cS9ZOJfMDYWkCctiCQcqOwrju5euAOBHv9ljSQpsdNF1eGZh9dkJ9SBgszt5InxErLg3tEecFieRd9YF5LZHsVDMpMIRM11lJxJSJJfo+3BXZFKwulgOEfGmU7HY233YTQw+4NlE044VwNtbVWuz/hD4WtB2QuFNyDLXN+x60+HzngClOFIDbpuoN9Y7CQpMPXHVsL5TMWBTRv0bb0MCXKnbsMXQreO64N/x/Hc2EMiT4Rp+ykXbTswXeXNS2ud8gj/yRur4k1v+EF1xHRR+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+58Nk36lfmjZCQdUYOqd24Ykg5kv8bs/7eUJ4gVI4U=;
 b=LCI6xFNRn02tiUus5O9LM0wrn5DQhQYYXZdJ724KJadX9bkNt6wlpx3xbEF8QuQEGgggyCR6vgDuDuJ0eT3fkxFlb5hTe5oQQGiDASUWZEwSvjE/451gmN3Bx8NztdDVhWuDXItkAJSBMPj5HUrbSXxcIk53OSZ1+bcv+5o8UKuaD33ep+uPxqrbrwq3cKyA0pQti/h4vtLuwiymxjSifbcfU1tI9e4wKLjy6fFq7LDXV0oDdBeYfnY9DOuRPq4U6PpWyBxmDY8psk9u0rgA/hUxYYdfEsYuViNIJYNnAOaxCWQ/aAAvt9/TvcTPzWS16ME4PwbFeWio6xqtV1b7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+58Nk36lfmjZCQdUYOqd24Ykg5kv8bs/7eUJ4gVI4U=;
 b=phknc30QoYlbbKsyprBJbywu9z+w8KFXNm274pZju7zqS2MAV4OgMJ3kldRVjdnYabL+bRrbvEsxjDoE/eLOMSPF1kn6mogjn1m46gNKu7KqLO1uoOYmVWigORc3TPFdjls8zcdGsxQLrMxD1NdoaLDIiiH88e4qYhZIXMqPwgCdh8LH/gVYiQ/YE3kWRblWzNECOC4PvcPghkO/BnDNRYEkHXr1IdGY102oYvWTA9Z0G97GSGX8O7+F/RBXJ6WjbXVRc2FqTgnkmADiKHK+X2mCPCWJv+9l80RZquYQZLUlZnBWQSG2X9JcTEkl6ojhBqPqr6XVl1W3d1i9u2Luxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6809.apcprd06.prod.outlook.com (2603:1096:990:4c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Fri, 10 Nov
 2023 06:21:24 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 06:21:24 +0000
Message-ID: <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com>
Date: Fri, 10 Nov 2023 14:21:17 +0800
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
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: a8afbbd5-1f48-43df-83e4-08dbe1b54334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v3ZCbaLGHCiO0NH8e1ff/swhWTs+wnjOGZY8YZWC6xqEXTrNp6G0oX2v0nxUbPXsl/YDtMbcJNkBwxMiunyjfQJPTEi3KbK6Dbnbks9Ayb/q6e8ccEPU68WcAiTa4aL9r+D0o38nVWvERXQOVa1xz1//QF9VwaS0KzqP2OWZPuShWJsqs06LLhAnNiD3+0UAzwPpBlpkdI5KGCSQHrh/UEBihN1UZvKTscz4o2tqHTqQ/0KFfj4Ufy+RvSWB4ZFkL1AdmgVe4JtuomyJ5kQa32mb7qKd922J477hI4Fzj98Il35drRT99TsXf9wBiSb1infW5WtcSfaA2L1OTYmDvT7kPfkSR1xA6iaoOUbSvmwXiTbnbvG9xQTkQKlj6q7Xjr+73dXz8FZv5jSoMz3I58N0Ug9e0+ErphwJSuodPZ2gBAtYmTixEKGRDwWabQrMUuYrAjCA3XBwotg0u3qRJ1YIkIvaGg+Kpjbapk4pO+ZLvfGVq23orLXmq4BcwSXG2ISw2BZ9N0jTyZmTt3qWXvmBs3OWAEycSLOH6kxPci1rLPY8ZzE4V7sAhPOo9MjCP4dD1RlJNR1pWY84gPBDNkMCTzszm+Rjy/wC91nrgVAYBQz9P+ROk4+F7m7aP59uLB/4Cn0ZguryMGwjsmrN0bUqln57OJRowYmRm4V5ogzLc15tHGg8EnYXq/NWqgKvbDGRx3ET6PkxAzeFWzfPl/AZcPTDqZb/A926Hpx6mDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799009)(64100799003)(186009)(6486002)(6666004)(966005)(52116002)(6506007)(6512007)(2616005)(83380400001)(4326008)(107886003)(7416002)(5660300002)(66476007)(26005)(8936002)(478600001)(54906003)(41300700001)(316002)(6916009)(66946007)(2906002)(66556008)(86362001)(31696002)(38100700002)(36756003)(38350700005)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1OR3JsbzlqalFhWEtTVWI3eWtMVm92M3FvdE5GQ2FyMDM2ZzZJekpseDdp?=
 =?utf-8?B?dEpSYUpWeDVhWC9LWEpVaTN3N1hhRzFPbU9tR3BjUXVaVzc1MEhOYVR0ZlV1?=
 =?utf-8?B?WXR4VDNoU2x3NnEwMUNQZnVXVGs2TVNQUFMwc2FTeWNZM0F4TXcvclpHNkJl?=
 =?utf-8?B?R2Q2dXNMN1ZBaU9iUGdXRnJqbkhyR1doRXFuSXNydVQ5MElObHoxRUFPV00x?=
 =?utf-8?B?bHdGQ1V3clh0QmVPejgxYTNUREplL21IVEJjbW55V3puUUdRWW5jMUpOWFBn?=
 =?utf-8?B?WDhpb1JyRy9WYVpiSzFNb2JNUDZ4VFpuZkFPTm0zNlpzck93cUhDMGN3Uno5?=
 =?utf-8?B?VzRhcXZGZmlKVkJoYXNHWnR6SjZ5YW9jc3ZjZktRYWQzOHlEbUJNR3RHdURS?=
 =?utf-8?B?VXNhWk9EbWI1Mnc4YzdlN1cvYzIzY0ozWTRBYUcyaFFFaFhBaDBneWkybW5X?=
 =?utf-8?B?MVBkODYvK1MxTGZoeGV6dm9kYm5DbnhLRkwwV1ZvcXgyeUVwb3QrVkdyODIy?=
 =?utf-8?B?aWRrSzVOeTRtUTJCem5oLzdVSU9ZNDQyTk5rYlpEbzhxQ2NhRzZsNGVtQ3pV?=
 =?utf-8?B?U0pQSDJNNWJnTHBMYkhsMk1HSHdWVmV1d0Q0NzQzM01XbkhyUTJERUkrbXNs?=
 =?utf-8?B?Wll3ZzNMRGh3MGZXMWlhaFIyd3g4WGhHckNMeXUyQktHL1JCM0UxOG0yaEJo?=
 =?utf-8?B?OG1nblJMZlIvNWJ5K3paelNxdExlK2JaYkoya1lMbk9tOXN4clBlNWlKVEpJ?=
 =?utf-8?B?RGJCZDRzUWpVVWFPSE9uMUM5ai9aQ1pMSlN2Q1BoYVVIMURZdnd2RHpOVlJx?=
 =?utf-8?B?MGowR2dGZkJLVE82UFdNbU5JQXNUNjVGYW15R201Ymgyc1lPMFAzeTVBSm9G?=
 =?utf-8?B?a2U4d29iOGJtRkE3MFdlMmdPcG9DYXJPbmpJR2pZaG5rdktVNy8xRUFGY242?=
 =?utf-8?B?czQ4SWdYQjlURlBId01YcVZzek80Z1F4VUVBYVh6WG93cTBDYjM0MmdNTTN6?=
 =?utf-8?B?aE16RmhyODNrQzR1cFpuejFkZ1hvNHpHZVkxc3M3SWhlVzRTTER2UHhoNmQ1?=
 =?utf-8?B?SnRBZTRDMG5YSENjclNwRHdqVDVBdmxVQ1dyTXJmcWZZOFI2Rzd6N0hOdTJ3?=
 =?utf-8?B?ckhRaW5YdUJNZXQxQ3lLNUhTMW1FcDJmeG5NbVNaS3JBRmtmZDFMSTFVakRC?=
 =?utf-8?B?RzRua20xeFlYQnI3NFpydER0MWU1ZmZTUFUvcFlQN1pNYU1BTjVPeHRQbUww?=
 =?utf-8?B?LzZiWE1sYmRDaWRBN2ErUlRoSlNmL2ZIcjBtaXRiSzRYMVFiU1RwYmZTc0FL?=
 =?utf-8?B?dFpiRHF4aVVUc3NvQy9DOEVyVnF0SnlsZFEydUdzQWRFZ2FObHBJb2VudHBC?=
 =?utf-8?B?bEhMd1F2OVYxLy84V1EzczA3cGljaUVTandVRDRaaGdleVlySXczRlNJdGdj?=
 =?utf-8?B?Mk8zQ296aHJqL2dvNUpUd3RGWnpFREM3RENubTdOeHJkcFpudmpPRUxGSUtm?=
 =?utf-8?B?RUlzaVhXRFVrWWFVeHBtWkhIb1V2QWZlTGY5c1E2OERET2o0N1k0OWJqNTBj?=
 =?utf-8?B?WEh2b0RqSHpsWmFGZ0VXMysrQVBLTmYyN2dlcUF2LzUwMEQxSGtPWEtNMk9B?=
 =?utf-8?B?Mmt0VHNvY2tyblVoNjhFZnpaMHU4Y0tNdGlKMS9HRnZ1bG5IS2VWZUhlajdV?=
 =?utf-8?B?dTlSRytENkE5VWxZY0ViMlRZUzFoREZtMno4Zy8wZGRWR0lqTDVCUEFnSU9Q?=
 =?utf-8?B?czBKVnJHMXRzaXVONXVZbExIVjBWRmNyZXdQMXRqVFQxU05tdlFxVUEyejZR?=
 =?utf-8?B?WU44dFFXL0liMW1jYWI1aURIdHNZUTYvR25DYVBYcE5iQjRueE9UZUZmK0FT?=
 =?utf-8?B?RGdSYzhueHhhNHlBN2JWczRYYk0rOEVTRllNd2xVZkhZYTAxRlBxYmhxbUZv?=
 =?utf-8?B?ZVdwamIzajJXWkxwbytyd3F6NFNNQTRHQ25kRmRMdGFnSWdMM2x2aHAxT09H?=
 =?utf-8?B?ckFNQ1QxNFIxS1FKd3IxZ0tEd1hMUUxDR3MvQUlGRG4renFIZUV4V29kekI3?=
 =?utf-8?B?akhocW00R1VpV2JVSGc3UWxPVWhSVXdyYmVEd0Rna1FkZ3UzL29rOVNDRWw4?=
 =?utf-8?Q?3a1IyAYgviiVNDMo9sXSDFQkg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8afbbd5-1f48-43df-83e4-08dbe1b54334
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 06:21:23.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9RR/Je3SoifQm0w43pE0nA9lWIHhXUdnfhLBmF/UrOx3nbsBjt+KK4vjn1reEZf35wKX+q2x4QUJAWX1gzUSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6809


在 2023/11/10 12:00, Huang, Ying 写道:
> [Some people who received this message don't often get email from ying.huang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Huan Yang <link@vivo.com> writes:
>
>> 在 2023/11/10 9:19, Huang, Ying 写道:
>>> [Some people who received this message don't often get email from ying.huang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Huan Yang <link@vivo.com> writes:
>>>
>>>> 在 2023/11/9 18:39, Michal Hocko 写道:
>>>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> On Thu 09-11-23 18:29:03, Huan Yang wrote:
>>>>>> HI Michal Hocko,
>>>>>>
>>>>>> Thanks for your suggestion.
>>>>>>
>>>>>> 在 2023/11/9 17:57, Michal Hocko 写道:
>>>>>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>
>>>>>>> On Thu 09-11-23 11:38:56, Huan Yang wrote:
>>>>>>> [...]
>>>>>>>>> If so, is it better only to reclaim private anonymous pages explicitly?
>>>>>>>> Yes, in practice, we only proactively compress anonymous pages and do not
>>>>>>>> want to touch file pages.
>>>>>>> If that is the case and this is mostly application centric (which you
>>>>>>> seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
>>>>>>> instead.
>>>>>> Madvise  may not be applicable in this scenario.(IMO)
>>>>>>
>>>>>> This feature is aimed at a core goal, which is to compress the anonymous
>>>>>> pages
>>>>>> of frozen applications.
>>>>>>
>>>>>> How to detect that an application is frozen and determine which pages can be
>>>>>> safely reclaimed is the responsibility of the policy part.
>>>>>>
>>>>>> Setting madvise for an application is an active behavior, while the above
>>>>>> policy
>>>>>> is a passive approach.(If I misunderstood, please let me know if there is a
>>>>>> better
>>>>>> way to set madvise.)
>>>>> You are proposing an extension to the pro-active reclaim interface so
>>>>> this is an active behavior pretty much by definition. So I am really not
>>>>> following you here. Your agent can simply scan the address space of the
>>>>> application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOUT)
>>>>> on the private memory is that is really what you want/need.
>>>> There is a key point here. We want to use the grouping policy of memcg
>>>> to perform
>>>> proactive reclamation with certain tendencies. Your suggestion is to
>>>> reclaim memory
>>>> by scanning the task process space. However, in the mobile field,
>>>> memory is usually
>>>> viewed at the granularity of an APP.
>>>>
>>>> Therefore, after an APP is frozen, we hope to reclaim memory uniformly
>>>> according
>>>> to the pre-grouped APP processes.
>>>>
>>>> Of course, as you suggested, madvise can also achieve this, but
>>>> implementing it in
>>>> the agent may be more complex.(In terms of achieving the same goal,
>>>> using memcg
>>>> to group all the processes of an APP and perform proactive reclamation
>>>> is simpler
>>>> than using madvise and scanning multiple processes of an application
>>>> using an agent?)
>>> I still think that it's not too complex to use process_madvise() to do
>>> this.  For each process of the application, the agent can read
>>> /proc/PID/maps to get all anonymous address ranges, then call
>>> process_madvise(MADV_PAGEOUT) to reclaim pages.  This can even filter
>>> out shared anonymous pages.  Does this work for you?
>> Thanks for this suggestion. This way can avoid touch shared anonymous, it's
>> pretty well. But, I have some doubts about this, CPU resources are
>> usually limited in
>> embedded devices, and power consumption must also be taken into
>> consideration.
>>
>> If this approach is adopted, the agent needs to periodically scan
>> frozen applications
>> and set pageout for the address space. Is the frequency of this active
>> operation more
>> complex and unsuitable for embedded devices compared to reclamation based on
>> memcg grouping features?
> In memcg based solution, when will you start the proactive reclaiming?
> You can just replace the reclaiming part of the solution from memcg
> proactive reclaiming to process_madvise(MADV_PAGEOUT).  Because you can
> get PIDs in a memcg.  Is it possible?
>
>> In addition, without LRU, it is difficult to control the reclamation
>> of only partially cold
>> anonymous page data of frozen applications. For example, if I only
>> want to proactively
>> reclaim 100MB of anonymous pages and issue the proactive reclamation
>> interface,
>> we can use the LRU feature to only reclaim 100MB of cold anonymous pages.
>> However, this cannot be achieved through madvise.(If I have
>> misunderstood something,
>> please correct me.)
> IIUC, it should be OK to reclaim all private anonymous pages of an
> application in your specific use case?  If you really want to restrict
This is a gradual process, It will not reclaim all anonymous pages at once.
> the number of pages reclaimed, it's possible too.  You can restrict the
> size of address range to call process_madvise(MADV_PAGEOUT), and check
> the RSS of the application.  The accuracy of the number reclaimed isn't
> good.  But I think that it should OK in practice?
If you only want to reclaim all anonymous memory, this can indeed be done,
and fast. :)
>
> BTW: how do you know the number of pages to be reclaimed proactively in
> memcg proactive reclaiming based solution?
One point here is that we are not sure how long the frozen application 
will be
opened, it could be 10 minutes, an hour, or even days.
So we need to predict and try, gradually reclaim anonymous pages in 
proportion,
preferably based on the LRU algorithm.
For example, if the application has been frozen for 10 minutes, reclaim 
5% of
anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.
It is even more complicated as it requires adding a mechanism for predicting
failure penalties.
>
> --
> Best Regards,
> Huang, Ying

-- 
Thanks,
Huan Yang


