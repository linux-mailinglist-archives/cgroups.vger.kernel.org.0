Return-Path: <cgroups+bounces-265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C978C7E62B1
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 04:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB7E281251
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 03:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108E5672;
	Thu,  9 Nov 2023 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lioaIE1o"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABA5668;
	Thu,  9 Nov 2023 03:39:09 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D826A5;
	Wed,  8 Nov 2023 19:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktfnjGoxiDzDvcgY7VtQBG6gKOIrKZfSOgbzbOPoSy7KhraoS7oavWz3B7AHpahTdsOQ1oN7i4puppm//SJY7ayHiA/yfPGaVgqkqAzuZUk3IFxfk4lS8/aMwV88g0YjWn04NbYIcjsF9NyNM/V4FLllE6Z17wX8XYz4olJDlgBJN/VpX3cMyL6zso3Ron/NiU1Dy95fwNoYH6s9aYMaiK36X/zhJBADoE6OtZWLBBS16KH71HE3fO7v8iNBiTcPZyU9GnosUj/KWS/xp4Xt9YTEVWFPg8kBLu/o2hqkjI/zlgxsuGQEC9tvkDA2iEWSj1JvanNVZIC774VI/cX4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY/dh/RIQyCLso0MO6WQhMsTilQI2mO+pwiTKBFtHzc=;
 b=BYkX6iBUpZerKbKAD1GV/EqJiOVUIJOzZiniA2xlzdssKJ5RqQD+eeg6FdCKsjmv/+vp78Ll9HvwNBwzcs8rJSP6j62YwN5856kyN4TnKeLSWz6V6VcPYf4Zc2FiVgZN4VdhDw1WbljJSx1scgdv1v2jktDyV2by0aKfr7n6xvs3IBzuKLRbUIdQ/e4+4PGtzvOn7WCWAIaqCX9d9rqJX51eSyiGIrlh53r7+bf6wX6pOrEEAUsjWbKRms4DThnxshiinyXqk8vzsLGWn+P/m/zKKwqQitnLoVeCJ/svDMdlJlXsbQWe5ZCQRHap6Hg5GvXd8NfK0+mYzSs10mnMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY/dh/RIQyCLso0MO6WQhMsTilQI2mO+pwiTKBFtHzc=;
 b=lioaIE1oZVnGE7xvUd6nsOx2LQeQC8GLdkNyF7HyCR53LVkM7YACSTXDfuC68oIKQF7Sy8yvWVHRFuXCAOFNyf07mSwWqpi/u8D6fchukLbmwuY68yPlYKZpbUQdpXLt/EFpebXXNVX076dSV4iB4d0XqOqkZkKxjGFuB8JPTIYBKfIChGbZy+bGS/a5NRKew9nQiupPD+OMXTUOiefweFFAV8lO+uRYzkDceB6JiebXjKlM0u+C3/vQdr81k1MW0HTUQeXkomAxOjyIMYD9JfiAw1IW0K6UBWIPmHqu1vpomr3VyZ4JbIXgT7iFNQEVUO3KFvhsdcMQQr4Ktf1C8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB4148.apcprd06.prod.outlook.com (2603:1096:820:30::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 03:39:03 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 03:39:02 +0000
Message-ID: <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
Date: Thu, 9 Nov 2023 11:38:56 +0800
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
From: Huan Yang <link@vivo.com>
In-Reply-To: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR0601MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecdc35c-e9c6-4068-0d89-08dbe0d56a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FnSGrA88y73r9cdnfJeKt6S8714URoOiuf1dRsLL3dBT0QsjPaLsRlFVe8lzh/r44XBFjC77KfG+xUKdV/wnMHcgfr2mskUDWlyikn3mCvH0025dSGtQy21lVS3G9dvms+AWq4RdZtZVma6euDLgnwJYOMz1mSI2SRYLZ6TpFZd7/kcwYQ8TX8JV6e1I2YTRpPukrw8N868gVGvRiaw7s3KboyW9xYF/V0bjVYNup8ABkhMYhbthLqXBa//QdwR7LQ19E3xNatBmWEnUUWu3arAo/gTLnXUKF4KhLubf7Ag40bgTWC/PG7mdUXJNqnErcEPg/gtDZZBxc/sOSKLtzGJLI+SMCqzRGNSoOjEiSgyCkZWLC9NjyIHdeTn39F0ZF6qcjemqrVHOH2T4YF+3XWvNXWSdCLUa4yevo3ZIlKyXPh65AVV2TwhKeUzDRSAjOkCDpbFCJfgSJLZUb1/gQJXEWQ5vKf2Nt/gzrq3yjJuk+vCkaEacCDz+b2eFcPbFjPoJ2c76hMvuXr4mbK6KMMx/xMJfKPeWFv0ey4XNfQYENvMrw+UH2owvinaEGfuBFM2dFuo+1FovFdqYrHuqnaHkRudM0ar8G5qWFt5444fsch2qFqrxEeuVY4K0Mkvh9gyO9lN9ogtrgLxTfMEjIGEi9B4hI0VeL/rJNuE5KhVDqvPcT+zjDEkiYmtqnzUOceiGrVDNbseFhQ0j9DqLMxqll9lRWS9X+fVDYK2vihw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(107886003)(41300700001)(6512007)(6486002)(2616005)(478600001)(6666004)(52116002)(966005)(6506007)(7416002)(26005)(4326008)(8676002)(316002)(8936002)(5660300002)(83380400001)(66476007)(66946007)(54906003)(66556008)(6916009)(2906002)(31686004)(86362001)(31696002)(38100700002)(38350700005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGhwNkYrQWcvcjdkTUgzNC9UelZhdjZ2SXc3eXdDbURmMElUTFpVRFRNQTFV?=
 =?utf-8?B?QzllMVl1b2tObVBXRFR6SVloS1NYc1ZCdEdGY0NBUVJ5UXMvaVduemxDSTRR?=
 =?utf-8?B?SkkxbUdFV2FndnVuT0FoRWMzM2tmS2gxVzFtdzVnKzJIU282bUgyQ0swdFVF?=
 =?utf-8?B?dFZPOTU1V2V0WmZONUdVeEg2UHFxZm4wOG9EbElKeEJGRWw5RERiVzMzbkhi?=
 =?utf-8?B?SHdMSFVHVncrMmJwTE53czBRZzk5Qmx0dHA2Q29lazRobHFhNFZvNnNPZnpo?=
 =?utf-8?B?UHlFdlRFbjFSdkVUeTE4WWp2azJzakNRaktzRk1oQzdTUkNNdHk0ZEdSejhu?=
 =?utf-8?B?WG9wM3NrbzdUOWVEbklMVGpFbDBaS05paW5ISWdEa2xBUWtEVlFybThHeWc0?=
 =?utf-8?B?TldtTkNiRlNyTDB4cWUzTHlVZGgxaERzZHprRVU3Um9Nc2pFMXUyL0VsYWpT?=
 =?utf-8?B?UU5OdkNlanpOclhmb2RkVVAvVmY3QmxYdTVJTGlEaWU2VkpVanpkcDBIV2Zn?=
 =?utf-8?B?YXJjN2NyRERvYWE5azB0Z25BUEhWVGtSY0JYZHZCbGZucThaaG13NkREOUlR?=
 =?utf-8?B?UjZvM0dnNzFNTFNxdWVWMm1hT28xMmJkVmFlUVpvdXlxNXdzbTU1bFI1cGlI?=
 =?utf-8?B?NWlWMGMyM0V2bWdSWUd6WFJTZXVTZy93VS9LaEdYdHd2dGhVOWNLbUpmYzc1?=
 =?utf-8?B?UllNbDFnZTR5bTdBbzIwVzJjUlNHaFZBVktyVWxFWWFnV3R4dUNuc0dVc2JU?=
 =?utf-8?B?dzIzTWU4bStkekhSSEx0SmtGRDNRZVhzOE1ja25ESzZGeUc2dWF6SmNsbk1t?=
 =?utf-8?B?NTZYNlEvcWQyWEhtcTk2bFcwZFZUUW1OcElsZlZBbk9xaEE1aCtFOHF6NlJI?=
 =?utf-8?B?T0dVWjZEYUVsZG9CaXRHM2ZzSk9YVjA1NGpwRjl6anV5VFRobUdEU3p2aTdQ?=
 =?utf-8?B?d0JnUnFXemFJSzljTUlqQWpzalJqVDlzU3FhN2dNUERzTWRwcmp4UnRyZ0dI?=
 =?utf-8?B?ZnJTU3cwMGVRd0c3Mzd6TndHYk12MEZUeDBUcTZvYXJZRTduRGcxQmFZbldY?=
 =?utf-8?B?SERCYmdrODRYSXZJa2toMVFBV1lvUzU0MVRtS1ZaSkJmRXkvOVJLdVNTTVpm?=
 =?utf-8?B?T2p6SEd0aTIvUzNxL1ZWSU9IOTc1N09XUHdxdFlNQ3NuTjRXbTUzYUxlK010?=
 =?utf-8?B?b3VnVUFTaUJJYng5aUgvNjhZRFAyMkdwL2ZmdVdtKzQxdUZyK3hNOVFTRnhm?=
 =?utf-8?B?Nm5MN2pDZVlHMWNFdEhWOU1PV3J0aTVmdmZQY1VEUk1nSld4b3Q1RTkwWGRR?=
 =?utf-8?B?RnVHUE9KSzBRU1lFVGFsamgvTWxnTVpQM1ZNS3kxN2NMV1Jib0s0TXhHUmFn?=
 =?utf-8?B?eitFUEJkdTNvdzh2OWorTFVYaXExcjVaVnNFNWhQb29hcGdnT1JqRXlJOEVl?=
 =?utf-8?B?VmxZdUY4Mko0bE1kZ0RlWkNWZFJDNWQ3Ulozemh1aTJOWHVoMFl3Wm44WklY?=
 =?utf-8?B?emZLanorNGVFTFhraUVGWTdiTktMc3JWeXFFMXdTMUJxMDJFcUY3M3cyTWl0?=
 =?utf-8?B?QUpJQThVKzJ6NlBEbTJQV2ovQzNZcUZJN2F1SlVVS0hIL1AzNmE2T04rYWx0?=
 =?utf-8?B?WDZaRk9LZENHL00zVlB0WUM4eWJuSHJ0dGtMd080SUYvOUtrUS9OWHR0c1Rh?=
 =?utf-8?B?ZUJudzFVU3R0Rlo5ajdjNXBJb0xvZjFCc2JIbGhmMWgybkhxN2hUTFlyNW42?=
 =?utf-8?B?bjJpR05uQlUrNkpVYVorYXh6cnBNR1NPS3MwM01OcytEaHhHempRUElMUDdm?=
 =?utf-8?B?RkRhSjdNSGg5dTVwK1BmZ0ZCOWF3c0pHbWp6MjFZaVZRUStqaHdwTStnTkRn?=
 =?utf-8?B?aVRwb2VXZFRqZFNYR0dBQXprM1lVeTdlRHcxZTdWMmdIeW03QlVPd2c4V0xp?=
 =?utf-8?B?VmpXMjFDTE14RzdoMHpUYlludjVVQk5jdCtyWkJ6TVRMSldMUmJ4eXdmd2Iw?=
 =?utf-8?B?MitvVmZad0UrK1F5VkVoZWU4Z0VrZGlZS1ZMdExUajd2UEpFWjA0eXhsUExk?=
 =?utf-8?B?TTNTYXBLTUV6SUsrVG5QY1lpRittbGE3WmZ1UVNkTlBWc3ZJTkhzc0VWVzVC?=
 =?utf-8?Q?yOcsDEcew0J3Ldw2HGwSZfN76?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecdc35c-e9c6-4068-0d89-08dbe0d56a84
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 03:39:02.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEx2GSnBsxEXQCYeq0FblN+QAvGZIQpqEMf4FVMFpFriGwNYCIUBsTMFvWjzN1/cW8MmaggFIm86aO0NpIfc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4148


在 2023/11/9 11:15, Huang, Ying 写道:
> [Some people who received this message don't often get email from ying.huang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Huan Yang <link@vivo.com> writes:
>
>> 在 2023/11/8 22:06, Michal Hocko 写道:
>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Wed 08-11-23 14:58:11, Huan Yang wrote:
>>>> In some cases, we need to selectively reclaim file pages or anonymous
>>>> pages in an unbalanced manner.
>>>>
>>>> For example, when an application is pushed to the background and frozen,
>>>> it may not be opened for a long time, and we can safely reclaim the
>>>> application's anonymous pages, but we do not want to touch the file pages.
>>> Could you explain why? And also why do you need to swap out in that
>>> case?
>> When an application is frozen, it usually means that we predict that
>> it will not be
>> used for a long time. In order to proactively save some memory, our
>> strategy will
>> choose to compress the application's private data into zram. And we
>> will also
>> select some of the cold application data that we think is in zram and
>> swap it out.
>>
>> The above operations assume that anonymous pages are private to the
>> application.
> If so, is it better only to reclaim private anonymous pages explicitly?
Yes, in practice, we only proactively compress anonymous pages and do not
want to touch file pages.

However, I like the phrase "Provide mechanisms, not strategies". Maybe 
letter
zcache can use well, we can also proactively compress certain file pages at
a lower cost.

So, maybe give a way to only reclaim page cache is good?

> Add another option for that?

But, yes, I also believe that providing a way to specify the tendency to 
reclaim
anonymous and file types can achieve a certain degree of flexibility.
And swappiness-based control is currently not very accurate.

>
>> After the application is frozen, compressing these pages into zram can
>> save memory
>> to some extent without worrying about frequent refaults.
>>
>> And the cost of refaults on zram is lower than that of IO.
> If so, swappiness should be high system-wise?

Yes, I agree. Swappiness should not be used to control unbalanced 
reclamation.

Moreover, this patchset actually use flags to control unbalanced 
reclamation.

Therefore, the proactive reclamation interface should receive additional 
options
(such as anon, file) instead of swappiness.

>
> --
> Best Regards,
> Huang, Ying
>
>>>> This patchset extends the proactive reclaim interface to achieve
>>>> unbalanced reclamation. Users can control the reclamation tendency by
>>>> inputting swappiness under the original interface. Specifically, users
>>>> can input special values to extremely reclaim specific pages.
>>> Other have already touched on this in other replies but v2 doesn't have
>>> a per-memcg swappiness
>>>
>>>> Example:
>>>>         echo "1G" 200 > memory.reclaim (only reclaim anon)
>>>>           echo "1G" 0  > memory.reclaim (only reclaim file)
>>>>           echo "1G" 1  > memory.reclaim (only reclaim file)
>>>>
>>>> Note that when performing unbalanced reclamation, the cgroup swappiness
>>>> will be temporarily adjusted dynamically to the input value. Therefore,
>>>> if the cgroup swappiness is further modified during runtime, there may
>>>> be some errors.
>>> In general this is a bad semantic. The operation shouldn't have side
>>> effect that are potentially visible for another operation.
>> So, maybe pass swappiness into sc and keep a single reclamation ensure that
>> swappiness is not changed?
>> Or, it's a bad idea that use swappiness to control unbalance reclaim.
>>> --
>>> Michal Hocko
>>> SUSE Labs

