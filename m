Return-Path: <cgroups+bounces-308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F4D7E7856
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 04:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C34281843
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9AA5693;
	Fri, 10 Nov 2023 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="meA3WLj+"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185B1876;
	Fri, 10 Nov 2023 03:49:01 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C04468F;
	Thu,  9 Nov 2023 19:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQhUYw/6S5ZnPUjPo3uLxZdwJzRvR2ebPMSepALunY8RxMW8lKGNhH8+SvGdCKk8I8p2yq13/+0HZsvuvSK8/B4PCaKf5HQpF46JtR4mYSKowuO1rPVsoGZFP6ouRfD10GnjW1+pPCSFUvG/6tFu14pQ6T5IpC7vT/f9zXZhVMe6wlUDM6iWlAT+VQjK8xXUtYnrKpKOjLFcZ8N5ZvEnlxMBARqJj7sX4iH1gyXP7fpAtw7f1KVEc/zbd90OlfJUFY0t5m3FiKZ/a+F6d7yHMCgGKq7yEkNHyX/9Q8HU0jE0dLcloLi+KSuoxZA14q0LApzSHqTotq0DPLI+dxfWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0WGeXvAh19NRdNRUuRnWgbq0puTmvNN1JrC/4VXgOc=;
 b=EENRAMwPquAOx+ikTvGA9xT1hLCXzazAq18YHXI807RmPiKatiRliAAS7wOptmHsk80UCUex7bL7la2XPXsIDVfczPwme+G5AQBO6v6fhSNJ9q7d6K+14zonykWPU7/W5TSf37gxouZtvDSr6bYHcvFrCnyCaA3qrj+6JVVPS17Kt7G5ZKXKwtigIaQ6hWoYEgsoWM3G6AQlz5agkoZlWA4V6UB4YP6sIAvEYeJcHNsMFqq6Vm5jkOFtqFuY9GCWiyzTR+TRH/u0PesQJiMrMhbWVJztvbYNkW90AHZ9vESWLuICRsWiSjd0+/MSTYQc3T26KVDKla0zAirMBVfArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0WGeXvAh19NRdNRUuRnWgbq0puTmvNN1JrC/4VXgOc=;
 b=meA3WLj+DLcqo3d9wXAeTYPohfRGruqKq3YZUWWJwbv2o3Mk5jq9o5w55OVWW7bh3fnwWlWc8FQU4kOt5abH2Eho3WxSU2ebPo47UIqjnYhjfKSq79vGfRp4mlUiLyJ0yt6kuses1Q3U1UV0bkL9Mf01zImvYOsEeA6t8zgt0ed3ShlNWw/L6IMoDeybLllqC6hkJEdp8st8sIyxrrotOuuShuGYu2tfahZoUkRe2KfJz6+2ZqxBwnbKPbbFt9vUaxjeortfr74Oev81A87hCRFPzIOlvmd9qps2qSV/J4eppgkRoWpr8NOrUiKlWnseQ7AipD72DBPI4igWshpx7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB4394.apcprd06.prod.outlook.com (2603:1096:4:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.33; Fri, 10 Nov
 2023 03:48:56 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 03:48:56 +0000
Message-ID: <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
Date: Fri, 10 Nov 2023 11:48:49 +0800
User-Agent: Mozilla Thunderbird
From: Huan Yang <link@vivo.com>
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
References: <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com> <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com> <ZUziy-6QPdTIDJlm@tiehlicka>
In-Reply-To: <ZUziy-6QPdTIDJlm@tiehlicka>
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
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eef3fa4-345a-410e-12fa-08dbe19ff684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ulL6sBcFmUNPDF7UQFGNpj88CaHnY0mQVg3sHzUv5J9+/G87BOaWX7vGpTgssXAoDjYqhDRK2yJa9u2MjsV4nV2HU/m1xwugPr0aErKMN/7aSKMd11MeIM8iewjtBrJFHGi3nl8+gejcR5DDJRJGSZg7oUh+OfIlvw3sLEOsbyp36YpWA6pqeu6IuA7tENnCgMof4y2NlxNMukfRmwFJ73BCV1AS7pa53At9q8pKzlEJ65DJoab2Up0lMkQHLxIgb2LdWQlKDKJyeXWwEx0Z09qobCZzXykFhAbdLv2RfOw7ykBP41tfNaQ7CJ5BF3jLqyrsPmVQu9BAdpB3ebYcGeLdE+6+bVSH6h/jQ+XZKlVYG6VRCvCmJkV5WlgW3puTJuiNPt/rYa4IeYhhVIZRQb2KRz8uyijzZNxqP/ePic5zHD8vLIt+YuSxA0HeRgQbSL/RmSfvpoMkagtP1sUqbq5HsOjPNxaqxufFSeB2B3pxDjHbloo85WFLZAZFcBerYBSza8r/m+W0mSATZWAEoAT6chaA7Ac1BQf37IM5onXMNiGbLDo1VCeoN0OOi7Q1XdwLDGbYuu+bL4JaF7M8SPguOuN4h9xfmfuOCmfpEPv2Sgkf2mcZLGunkivuefes3nd78yRzojMOAR6jGc3I9VD++IigM0xGjj0I0VfCknNoeFrwLc+wPaK8cC+axAPs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(4326008)(8936002)(478600001)(66556008)(316002)(54906003)(38350700005)(5660300002)(66476007)(6916009)(8676002)(86362001)(7416002)(6666004)(41300700001)(6506007)(31696002)(52116002)(2906002)(6486002)(2616005)(66946007)(6512007)(38100700002)(107886003)(36756003)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhGb0NxSXF0dlAyMGJvMGRBWW5GU3d2UUVTendqcVdzTUNYRm5GN3FZZVRq?=
 =?utf-8?B?L054ZkxDK0FGMzZSWXFOWEdaQS9aVjJkOHZ5NWY1bUh5cHdHdVBsNlQ4UE9v?=
 =?utf-8?B?OGxPeXRtbXNBdldwTk1LVGNNajhRb0pEdldVSWxYa0JGc1V3anF3czJENXlO?=
 =?utf-8?B?bU9vbUdrNVptRUNhR3h3cS8zYURMeHk2RlZtZGN4RzdxTVNmT1hQRWhEbGtt?=
 =?utf-8?B?QmUwMkdHYm1DV3hLalBEWHBGNHN0WG1LeWRROEt5a09DYURKQjlYNksra21D?=
 =?utf-8?B?Z3BtTkJvQVFtTU10aHpVRkk0WHA5OVdyekpvK2VIYjZReGNFaXhKQnlhWXRn?=
 =?utf-8?B?c1d1OTJlZmt2eld6Q1VZb1MzRjJ4VEwzcHBhNUxndUMxUmU0V0gwUEZoMXpK?=
 =?utf-8?B?OUdTdWJ1Y0JCOThzdFB4ekRBazZTVy9ZanBxOXR1eXBpeUZxUFZDNDFWV2NH?=
 =?utf-8?B?YkpWbFFuZURsQkhJNjB5cE0vTmhBZFZseTc3TE1yQnVxQ3hWQ3Iwa0dBV1Uz?=
 =?utf-8?B?dHUvTER6K0ZERndnaG4yR3NqeWdzakhYRmRTd29PZmlLeFVkRWJKdlZ4WGhq?=
 =?utf-8?B?Q0ZIcTJjZmFaZjVPZjBReUFzLys1TnJoRlAzazFZVGlHMWdqYkJsZ2lWT09O?=
 =?utf-8?B?ay9Yb0Z0ZGpBUXUzU0hQVWYyNFo0ZXJHdWZLZ3duU1RzYmo4L3c1ajRKZ3Fw?=
 =?utf-8?B?U09jaFJEQ09sNmlUaFFOMjRUZXlFbFpZc2lWZ3J1dXR6T2lFcTB6ZVB3WFVL?=
 =?utf-8?B?VUlwZFZQOUNaOWtFY2NZTjVwTU51ZmRTNTl4eWFNNGdoNkZZZVUzbTJwTmpy?=
 =?utf-8?B?cVUvTnZ2c3BCYTZMMVo4bUwvUGVibCsvUkhLNHV5dGdkVzJjU1VDS0doaVd6?=
 =?utf-8?B?WWRSSGlhTmdJVy9WcXVES0hxZjN0NERuNGVLM3JyaVdyS1c0UmFvTEF2Nnhk?=
 =?utf-8?B?VUJNM1F0bmp5c2toc0hOWmdKSlVrU24rQXhVakdxd1VzYUo2TmMwU2ZRNTFI?=
 =?utf-8?B?MzhBQThjSldlZHRXU3krUnNxbCt5QzZYbzBaR1hUUkhJNmwrUkdsWUxFSDls?=
 =?utf-8?B?QkgrQzRMOXVYT1F1RlA0MmVUc1V1YmpPcnZZbmJrRlJGaVdoZWkxbzlMWXRt?=
 =?utf-8?B?RExxSGJVdWx3NVBrUk5HNWhGY1BMQmFkRVNXOEdWTGdqWWNOaVNUYlVEN1RC?=
 =?utf-8?B?bzBWV1VXOTJGZU1qYS83YnZISmhXTGRHQlhoYjVQdGR6eDljb0Q1N3NYYm45?=
 =?utf-8?B?a0FnbFpoR1grTU9pZGNIZlpSNXZNekx4MmIwend0YzNIVldMM3JTNDRhNEFH?=
 =?utf-8?B?cVQzSHRPQitwcEkrTitOOXlLQTJKTXlnYkhCSVhTR2ZETkVReFR4ald3TjlQ?=
 =?utf-8?B?eGMrdmFidUw5alRuOEJGRElXVDlXNURiOCt6bUtpNEg0V1BwdWc1a09Fa0ox?=
 =?utf-8?B?cDZJQUh5cS9LcGY1bk1wVDRqZ0d6RkRGZExCRnRqWWJxbjVsKzdrNmVCN3V3?=
 =?utf-8?B?b2tBaFN0VFZTNVZJbGk5cEFpUWtUNFFMSUNpMEtNQlhraDYyU0JoN2JNSkNH?=
 =?utf-8?B?dlhMZ2pXK3Y3UncwSWpZd2JlbFdCVWpBZGhRYWZXVXlxaEVlN2srR2Q4NjVQ?=
 =?utf-8?B?M2ZkVFkzY3VJNUFFUnEyWTFzVXEwcExDTkdLQURZcVVDSzhPQkx0bDBPWFNH?=
 =?utf-8?B?Z3U3T0tkSFFUN29ER04wWmFsdXFSdXR3SnozNjVkd1U0Y3NIYkRSb1ZWQ1dw?=
 =?utf-8?B?Y0xjTVVDN1V1alF0eWFHeWtnbzMyK0hJVndOdkt5OVVwdEtSazVYSE5abW85?=
 =?utf-8?B?clQwMEd5UTRWUjN3MmdRM0J2d09pM3NocTBqOTJMakJFRUdYN1U0QjlPVFdJ?=
 =?utf-8?B?bFMyakdQWmJLU1dqVHRTd0prdE5KT0pSUVZOWENyVnFLRVA4Ky91Z1BrVTNY?=
 =?utf-8?B?YUZicTFwTnJtUGxCS2ZDdTdMbnpiME5sVkdZanFrWlU5Sy95UEZINk1hSDNu?=
 =?utf-8?B?SEk0UmdkOWhrQ3BHMW84STRSbEV1SE9kbVFJOEJYVHlvdUZ6Nm80czRiRWxw?=
 =?utf-8?B?WEtlZ0R6QngyRUYvaGdsOG9SdmUyOWp0L2wxUEtwZktuZkJMQmJTcmpJc0oz?=
 =?utf-8?Q?fcUD++nZDhSyO/PUFasKeAl55?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eef3fa4-345a-410e-12fa-08dbe19ff684
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 03:48:55.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln6bSxl9jnx40jKTJ2fjGKKrEtONCj58GNIxkRvX8mL3YJind6Al03/XdWpEnrWMMFhrYJ6W0BJT7V+PpYzsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4394


在 2023/11/9 21:46, Michal Hocko 写道:
> On Thu 09-11-23 21:07:29, Huan Yang wrote:
> [...]
>>>> Of course, as you suggested, madvise can also achieve this, but
>>>> implementing it in the agent may be more complex.(In terms of
>>>> achieving the same goal, using memcg to group all the processes of an
>>>> APP and perform proactive reclamation is simpler than using madvise
>>>> and scanning multiple processes of an application using an agent?)
>>> It might be more involved but the primary question is whether it is
>>> usable for the specific use case. Madvise interface is not LRU aware but
>>> you are not really talking about that to be a requirement? So it would
>>> really help if you go deeper into details on how is the interface
>>> actually supposed to be used in your case.
>> In mobile field, we usually configure zram to compress anonymous page.
>> We can approximate to expand memory usage with limited hardware memory
>> by using zram.
>>
>> With proper strategies, an 8GB RAM phone can approximate the usage of a 12GB
>> phone
>> (or more).
>>
>> In our strategy, we group memcg by application. When the agent detects that
>> an
>> application has entered the background, then frozen, and has not been used
>> for a long time,
>> the agent will slowly issue commands to reclaim the anonymous page of that
>> application.
>>
>> With this interface, `echo memory anon > memory.reclaim`
> This doesn't really answer my questions above.
>    
>>> Also make sure to exaplain why you cannot use other existing interfaces.
>>> For example, why you simply don't decrease the limit of the frozen
>>> cgroup and rely on the normal reclaim process to evict the most cold
>> This is a question of reclamation tendency, and simply decreasing the limit
>> of the frozen cgroup cannot achieve this.
> Why?

Can I ask how to limit the reclamation to only anonymous pages using the 
limit?

>>> memory? What are you basing your anon vs. file proportion decision on?
>> When zram is configured and anonymous pages are reclaimed proactively, the
>> refault
>> probability of anonymous pages is low when an application is frozen and not
>> reopened.
>> Also, the cost of refaulting from zram is relatively low.
>>
>> However, file pages usually have shared properties, so even if an
>> application is frozen,
>> other processes may still access the file pages. If a limit is set and the
>> reclamation encounters
>> file pages, it will cause a certain amount of refault I/O, which is costly
>> for mobile devices.
> Two points here (and the reason why I am repeatedly asking for some
> data) 1) are you really seeing shared and actively used page cache pages
When we call the current proactive reclamation interface to actively 
reclaim memory,
the debug program can usually observe that file pages are partially 
reclaimed.

However, when we start other APPs for testing(the current reclaimed APP 
is in the background),
the trace shows that there is a lot of block I/O for the background 
application.
> being reclaimed? 2) Is the refault IO really a problem. What kind of
> storage those phone have that this is more significant than potentially
> GB of compressed anonymous memory which would need CPU to refaulted
Phone typically use UFS.
> back. I mean do you have any actual numbers to show that the default
> reclaim strategy would lead to a less utilized or less performant
> system?
Also, When the application enters the foreground, the startup speed may 
be slower. Also trace
show that here are a lot of block I/O. (usually 1000+ IO count and 
200+ms IO Time)
We usually observe very little block I/O caused by zram refault.(read: 
1698.39MB/s, write: 995.109MB/s),
usually, it is faster than random disk reads.(read: 48.1907MB/s write: 
49.1654MB/s). This test by
zram-perf and I change a little to test UFS.

Therefore, if the proactive reclamation encounters many file pages, the 
application may become
slow when it is opened.

-- 
Thanks,
Huan Yang


