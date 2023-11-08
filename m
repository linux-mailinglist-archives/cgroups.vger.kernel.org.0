Return-Path: <cgroups+bounces-244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76807E5272
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 10:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BB21C20CC7
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F4DDD8;
	Wed,  8 Nov 2023 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p17qpL3k"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CDDF43;
	Wed,  8 Nov 2023 09:12:31 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157641A7;
	Wed,  8 Nov 2023 01:12:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhgwiTCm6IIETE9rT6/aXwj5Lr+NZgQ8hYVA50x5mSOvzi9549fdwLzZfKy7eEYa80jbFu91qS64eSbGev5Fj9P3NU8vFa6YbaX/dj0s95Z3Hzg2v+kvAU4rgX1UAEqk16JDyUSpmg7UAqOLvaza28HcWk4Z6yDEUMMb0L+1lY37d2GFzlR3nGlyhS2sWcktbVBUdHHkVO3LyRQlR54YrZobdXNqrWQyQ3qglfVluaETJxoPC4FePfn6JX1EzTLFHjSDHIeT/JvdFH45EbwUkQLNnRHi7IIgHgWqWDRjiP5F5skwVn9M3Dy50OQgoVZaK1VicrHzZSHDyx1a7uu8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cubfbL8yZwMGSX8M8II3GwbdxgDJ8oTk7RmwY0Mhep8=;
 b=oIHyzoUdnmR/rhAHCzEnKLS65Py7y5wWUKj/VZZEg25ppKhltzyTgFGRJ4jKNDjbTuFJS6a3gkho+EdkKRg9VLjbZXLkjibHsSnEj63T3qicyIn+iPWSTyxfmSsCK4NLOQpEpWgcTJojqQQAvffri/Xz3SfK3WZytES9MKisSy1XT1LEPyByhe7FUt5heXHts3XTbUbB2fs/qOXeDZjW1+3yEN3zcHzqddCdLk3N/gyvzT0Gh3sdH8ntQJkd2qtmGEziueZ7S6gq47JentyDlnBEQ84ruFbq1Sc8bMBiXwWExx6nBPj2mjvTlKvd6AzA95vbRM3bazcaTPkJwCsBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cubfbL8yZwMGSX8M8II3GwbdxgDJ8oTk7RmwY0Mhep8=;
 b=p17qpL3k7423g760MMvSgBxLzyr5pF2zC/TtQH6gDkUbi6Rg+JfU582RUEhY51M3bDf56M7iWLbXd6ovmccJYL9kj76R1M2ghDOGWFe5mmUzYDuBR3l48jnyv+KwbvrhkCQuNXv7hSACjWwawhJpzLOJzjWgBrMAYombr0HY5bLp5V96KU37B5UvdhboTpcEzijirUGXoU4t3UVDMO3ilURvbkQVIG5Ybbs3spp/c8YoWkpZiAD9ORLtYDnFiNA+I5bjqjiTLst6jgtek8B4yRFveq9vgwUs9Np+XUbmZepB+uMdDuxitXhzfNKgdrWBvGKwPDPIAv5V+jwGAoZ7cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB4180.apcprd06.prod.outlook.com (2603:1096:820:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 09:12:26 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 09:12:26 +0000
Message-ID: <f952117e-cc7f-41b9-9571-1d32b157cc82@vivo.com>
Date: Wed, 8 Nov 2023 17:12:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Liu Shixin <liushixin2@huawei.com>,
 Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <CAJD7tkYVtaX=W5XWhn-Y+d==mbHs5AZG-7sAaYmo7FDONpoQ7g@mail.gmail.com>
 <4c7db101-a34f-47ff-ba64-952516cc193a@vivo.com>
 <CAJD7tkZ2cnp6tSr6jb2Xpt4J-5oeTmAq1KNw6f7KBWPfjca8gA@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAJD7tkZ2cnp6tSr6jb2Xpt4J-5oeTmAq1KNw6f7KBWPfjca8gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR0601MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 25287e41-a999-47bb-4b2e-08dbe03ad397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FDbup8Eu8mOpSLKjPqva5O0L5n3PJXj7r/ZzKOflouecBt2CO8ZBntTsPvU5kku37cpbFBLmWtMS/djxPS0o3u6a7xXSrAW7QvV5Ok9JcQM6CP4oBnTW1iwatsWlI2hYgIXl8s8KTvLG2wx7NVARMUP6/lXFcYYsg+1VRhX1gkS5NGJdpXWIfTpAT83oDisgSL3TCmCSmNMdFK9tgj8hIEKyJN7d0H0bp2+AKl+26HAp0EmNriWHXQELB6P0AzW+q+SzGPA+ufO/Xlw3MK1kKOPZ3GX+nb19sWFz4wlvev50rAlusClR+fqCZVW6IcfGBuE5eSCTspzoSR6mBoDnyr2Ue8ogBIfqT3iIN525nGtkTL8XwOydgj6EW9CW1LSpiqx6d1WVW1Y7UwZ5Q9e8ehsE+xEabkSkUk5MwyKZSWyNu5VLnDYA7ziXcxDdmZfHgQcGlMeb10B8FKFOQDCwHwrN5RW2m//B33809xQeXQfwGFc8ANN5g9XZsanrkTnHkU1Vg9NXq07ocdSDkE4lT7FngXjYMX5JunNQBP4XMoj/is9l9t3oUhCzgFRZlghnqpEPKCtDVsrw+t+McMS9+Q1njetWk321uTcQAP+1M85ON0j5br10gDNrbXj8/8thGA+Ipz7N2xYz+tfk7ggrSv7KicUxVW/UDYVhpLK6IYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(6512007)(107886003)(478600001)(26005)(6486002)(86362001)(8936002)(5660300002)(31696002)(36756003)(4326008)(41300700001)(2906002)(7416002)(966005)(8676002)(54906003)(66556008)(66476007)(316002)(66946007)(38350700005)(6916009)(52116002)(53546011)(6666004)(6506007)(45080400002)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZScmEybWFSZXlKOVh1Yk9kcFQ5a1dhUnJkamVXaVg5Z0JuSEQvbDROMThC?=
 =?utf-8?B?UDU3TVVGYlBXcTQzMkdkNU12WGhRMlZGSEExMXBNNEtFVTF4MnpBTGx1aVJx?=
 =?utf-8?B?T2QvS3o1U1hPdVluVisrSFhDdlFvWG1WNHJsL3lLZElpb0NBTC80RklNR2tV?=
 =?utf-8?B?MGZJT2RWSWRRdW13NlF2SU1ud2ppYW53RU1uZnN4a2tURGh4YVdJN1kzZHox?=
 =?utf-8?B?di9wYnJRdkVNTkhKWHNyaytrWm9xYzI0eHV1aGh3TDNpV3BlT3EwZWY4RlNs?=
 =?utf-8?B?eTh1cS9SMS85Z2pQdjNVb29JREtvb1k1L1U1clBIMVRCU0VTWHBTekw1ZGls?=
 =?utf-8?B?WlZvRyt5K241ZGJxbnpIUzFaS0JDZnNGc2tjc05uS2ovaUR4SFFMOHAyaUtS?=
 =?utf-8?B?TFN1SGlENG5FNzhFZFVUd04rRWg4ejhjNnhZeGNEYVNhK2RaeFB0TmtSdVph?=
 =?utf-8?B?Sms2WVJNTnRlci9EdDNyRVVneDFJcnh4ZWVYU0FkNHdRYXZmeTBoRFplTnBL?=
 =?utf-8?B?V1F2L0tKWmZ2OS90YWZwV1h5UEUvN0prYlVWMGhaU2F2am9pa0xXMXh2LzZJ?=
 =?utf-8?B?eVRQR1R2MDllNE5ETisyQlB4VmhOaW8vR1FRUiswMXdjQkFWaHJkVWxUOGtV?=
 =?utf-8?B?aU9ibWxmTmRmTW5nYjZ1UVhZZ2hsZUVGdTRmZUowemN3RmxrNGMxUnZPTFhD?=
 =?utf-8?B?dk5sOGhnTStQU1A3L0x1K3E1QXcxS3Vvc1c2QlVpY0J5VnYvR0dMUG12a2tG?=
 =?utf-8?B?cWIwMno2dkNYRzJnWW9sQzRmSlZjTkJPcnRubHBrWXJEVmdLa01FSStZclVo?=
 =?utf-8?B?MEhKUjRic003S0RCeG9ldmZmN1B6S29YcHRzU3ovMDVkcjhLcFp2eHFPRkJ6?=
 =?utf-8?B?V0FJNEhUVlR3QVNjSzVFOUltL2xDNDhGSnFycjdvSnFXYlByWWh2WFVOR3NN?=
 =?utf-8?B?SFNoTmtxcTZFSlBuNUhOYTZpTFhnVHFhaGZYbUV4S1llR2hEZlZYeTdqSHBS?=
 =?utf-8?B?bndBSUszdENPd3Vrd2hwWGQ2d3Ywbkl5ZGZ2WHNLS0tJY0YrVXpZOTlaZExZ?=
 =?utf-8?B?ZHhtYkpSOVl3MVlHbHl3MXMza0NzK2s2UmIySmRVc3c2MjNOanRVSGdWU1p3?=
 =?utf-8?B?YlJzQWZtV25NVHBGMXJlMEJNVEVFbHMzMHhPTWp6MXhJK2VHKzRYR3F3WDYw?=
 =?utf-8?B?czB5RTJSQlZ0Zm5VSytxZDAwZFJ3WnFlRjRsY2Y3K05tSzVQZGZVTGJieXN4?=
 =?utf-8?B?eFFWMnE5bEtsZlRBOTZlRTRMUlppZndNNy9tN1lhRXpzSWh3MzFpdW9FZWZX?=
 =?utf-8?B?K0xhakpJWVd2QVJCR3JVaEREMUFNdHp2ZmtwQWo4YTljSFBYcE9uNWlaU3Jh?=
 =?utf-8?B?RHFnRGZUYVhvSHMvWDV3bDNaY3p4LzlRUjBhOVFUYXJlSUpZY0dpQ0EvVVRx?=
 =?utf-8?B?bzVkRE16ZjJBVlord1ZCeXRpVHJoN2dZeW5vOXpBZlFRblhPRXNFdlg5VzJp?=
 =?utf-8?B?SjIzcVhWNWFNVjJYNWZ4TW8xU2VBdWdMaE03ZjgrUjI2aGdObG9ZRnhtZElV?=
 =?utf-8?B?SXBxQ25DYUVseFZQWDRCcVdYdFM3MGZTS0t4YXlyTU5naDNHak15dVE4TzE5?=
 =?utf-8?B?VFQ3eU5Ub05SWVFla2FoZDFnMG9QV3V2a1dVOEl5U1ozb3ZjbDdSVjhod3gx?=
 =?utf-8?B?c1gwc2hEa0liQzdKOFhhNXhFQ09qamR0U0ZZWHozbEpCM1BiSmdrcVgwU3Ny?=
 =?utf-8?B?clE3dGd6TURURS94cE5FVGo3Q2ZOUm5KN0VwWVlNUjJvelZiVnlSYjAvMGhZ?=
 =?utf-8?B?RGdDOXNIUWtweU9GM0JmMlFYVFJpdW1QcFh0QXI3RGk3dW5BRGkrWG8xVzVj?=
 =?utf-8?B?K1lONlE4YTVSVGhrOXEyQ1ZzQmdLeHNzY1pEU1dLQTJrRUxkZHM4Yy9qemgz?=
 =?utf-8?B?NWxkc2RiaU4vcUp6c3B4MWRZZ0JUcU0yNkNDanNEQTZ3MHVpY3dwSjNtdjQ4?=
 =?utf-8?B?cGwzdWFnUVIxNkkzdUdzYVBUQUxXMDBka3hhRjJGRU1McE94V2krYzljeGFD?=
 =?utf-8?B?cW1UTktPcDZMTkxwNFoxTXRDU1hDeDV2cDNwMmRHY3NmSk5HZ0tqSmU4L3ps?=
 =?utf-8?Q?hM2ICx/lUiFpIxcw6vU4b2cNI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25287e41-a999-47bb-4b2e-08dbe03ad397
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:12:26.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+XlpSIqQ3UDBJ389oO1vC/F03pbMHVVyWCuwLyr4ynqFVgFuqKSvwC2WfD9jb1yGYOWd6If6Er0bfy3H/nH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4180


在 2023/11/8 16:59, Yosry Ahmed 写道:
> On Wed, Nov 8, 2023 at 12:26 AM Huan Yang <link@vivo.com> wrote:
>>
>> 在 2023/11/8 16:00, Yosry Ahmed 写道:
>>> +Wei Xu +David Rientjes
>>>
>>> On Tue, Nov 7, 2023 at 10:59 PM Huan Yang <link@vivo.com> wrote:
>>>> In some cases, we need to selectively reclaim file pages or anonymous
>>>> pages in an unbalanced manner.
>>>>
>>>> For example, when an application is pushed to the background and frozen,
>>>> it may not be opened for a long time, and we can safely reclaim the
>>>> application's anonymous pages, but we do not want to touch the file pages.
>>>>
>>>> This patchset extends the proactive reclaim interface to achieve
>>>> unbalanced reclamation. Users can control the reclamation tendency by
>>>> inputting swappiness under the original interface. Specifically, users
>>>> can input special values to extremely reclaim specific pages.
>>> I proposed this a while back:
>>>
>>> https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com/
>> Well to know this, proactive reclaim single type is usefull in our
>> production too.
>>> The takeaway from the discussion was that swappiness is not the right
>>> way to do this. We can add separate arguments to specify types of
>>> memory to reclaim, as Roman suggested in that thread. I had some
>>> patches lying around to do that at some point, I can dig them up if
>>> that's helpful, but they are probably based on a very old kernel now,
>>> and before MGLRU landed. IIRC it wasn't very difficult, I think I
>>> added anon/file/shrinkers bits to struct scan_control and then plumbed
>>> them through to memory.reclaim.
>>>
>>>> Example:
>>>>           echo "1G" 200 > memory.reclaim (only reclaim anon)
>>>>             echo "1G" 0  > memory.reclaim (only reclaim file)
>>>>             echo "1G" 1  > memory.reclaim (only reclaim file)
>>> The type of interface here is nested-keyed, so if we add arguments
>>> they need to be in key=value format. Example:
>>>
>>> echo 1G swappiness=200 > memory.reclaim
>> Yes, this is better.
>>> As I mentioned above though, I don't think swappiness is the right way
>>> of doing this. Also, without swappiness, I don't think there's a v1 vs
>>> v2 dilemma here. memory.reclaim can work as-is in cgroup v1, it just
>>> needs to be exposed there.
>> Cgroupv1 can't use memory.reclaim, so, how to exposed it? Reclaim this by
>> pass memcg's ID?
> That was mainly about the idea that cgroup v2 does not have per-memcg
> swappiness, so this proposal seems to be inclined towards v1, at least
I seem current comments of mem_cgroup_swappiness it is believed that
per-memcg swappiness can be added.

But, we first need to explain that using swappiness is a very useful way.
And in the discussions of your patchset, end that not use it.
> conceptually. Either way, we need to add memory.reclaim to the v1
> files to get it to work on v1. Whether this is acceptable or not is up
> to the maintainers. I personally don't think it's a problem, it should
Yes, but, I understand that cgroup v2 is a trend, so it is 
understandable that no
new interfaces are added to v1. :)
Maybe you can promoting the use of cgroupv2 on Android?
> work as-is for v1.

