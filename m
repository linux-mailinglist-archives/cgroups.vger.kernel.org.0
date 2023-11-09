Return-Path: <cgroups+bounces-276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E407E68E9
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1CFB20D1E
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBE11198;
	Thu,  9 Nov 2023 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lAJ35mcj"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC961802A;
	Thu,  9 Nov 2023 10:55:23 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77CD41;
	Thu,  9 Nov 2023 02:55:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlRuYwjdND/HcLQ1o/U2/JQO2qaoHgpVL7brWVVKA6pjRDlmJ4TQGCQ/fhMMFABR8uMkQvJle5IfyGgQ/jxjI5WQxeB5sJXuIeWQGyxpPb2tZQSodT9vESXqfflRE6hvDzoJsmLFb8PZJ6kH1j8iT83BhOkSFhYJ4sCfl3FngtzT1i5ZRbHvZI7ScFxYEhvcID/t1U3eUoFmzySi749IGwh0bPySQyS9JJK3k6hhfbAMBSZ6JdktlCsV00FDjau+4CxpZUwI9g94nSXImE7/Ax92gI0P18EAwjLukIJ45aofEkAJMN7H9XCVmaw76UMatsCbMAzmkfSNkOEhfSPMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfMcuMyVa5E3l2CKKN3SYmT7n86qn4rvBZMmCk1ISG0=;
 b=iyI5GDJafXvE790WwMr6/2PdLks/+mWVlFSpRNsei6pJ7NxW6827q4OVFvYh7aoOH420rKh9Pc1HjjCitseVG/soqeoZRY1/TyLd1FgqkmBQoH6dlHoUjO5ydoGuWT8PZENLA3XyA/TsHlxzMY2je1VlcEaTJj7yMIXqPYXqqLdu/2VxsSDglh4aB2lrxsfEK3aIbYq8SauPNIa2xVC2TzRUpSwp1pKy7d1yeAMwPArHHg1OYNC/z94/ILABij8ZGV0PBS4USQi8/G7Fx4yZajcN9gcu44uytTSYS0H0bAsgLrGFtswyBZ9efSy0Km1qy7XW2Bfj5rlimKZiC00exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfMcuMyVa5E3l2CKKN3SYmT7n86qn4rvBZMmCk1ISG0=;
 b=lAJ35mcjwvDm7GtVCIFMTmkTtf6i8lSyZw30fwZrh5emCwymNmNph1RRohUqRYCMdwZnKoQrEFHDpI1nj4N9B9ZdqrENwbKh9mrCSF4LsnfYcPXY1MC6irGJc6+DHMjQgpAzXI7Mvovk4//6T6VOduu1p9HsoSvWyc57wom5ck5U4OkWpYeKwo4psVm4CcuYbIN6+mlbrO7r2OvXVzNpf/Gqkn5+7FOxLqug9ksI7AtxNTnmk08RrnXInRT5xUpYMDiM6StyhfJKqhpn9/+1Cap23rC7XumpERo6BjGQtFrmo0LFmJYKCxH1NwKvAnNl83umIpLjWq2HNeYwQ9Rtnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5815.apcprd06.prod.outlook.com (2603:1096:101:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Thu, 9 Nov
 2023 10:55:16 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 10:55:16 +0000
Message-ID: <d49acb29-c1e6-429b-8d94-a5a8e1e2f548@vivo.com>
Date: Thu, 9 Nov 2023 18:55:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka> <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <ZUysGhwqo_XZSV-M@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZUysGhwqo_XZSV-M@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcecc72-55c6-4ff1-b8d8-08dbe1125b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	onyJPUy/Z0AxYVVWj3uvyxaFdzq3FUTgLqsnKiGI/WrfWixM1fqR89RUjE1ycX4KFOO+czW7QFQh2gd5Frd3IoVeR3Z8grMr5XVivHNylvp9IAmZ0mHjcoPOz8+pkcSBSl6PPmIQvY94la6/dySawniBqjrHE40CJu8fLlMIAoQvXwj9zVwkfQ1e45KONg1EWYB6dlVSqaCdQNb9E7qnDU2kh/JT4KOefBP4dXY4YRO8Wg9I/KYbb9FilkPKpszJPRT7AsMTzYUdw5pFPS82UN4YOjB8Hfr41PNxh5EUk2q2EwKDkQj8L86AgoBPgcAN6/5c57ZKuY4Vqk9K4TTOmTSDVG429pHlNxzwaicWnlzAzOjHYILoktgdFTo9VHFVlatNjBkJuUDlLmPBTDrgjCOqcduJg5HeJyCPnEb9UMB/O/PxyHb1sIoow7um9fBPy6q3IbSAKd3agC/70gpcgRH/z/wpGNhgKg7NwEjGY62x6TIZdhDnrtBM/XBHBKMqhFDjwJl/4UE4qgHVXuQBLoRZxI5JTVl2V6zdiRwJzuHBSnSPcopvqhSvdEAig4QIdSph2yYgnLSzlVV0rQLdxDrNoeIxNGEz/Y7anKnSw6VYUux/SOP8Nbbgz6mle0EnUMs1fAPJv4a6sSTIxyXTtzF6EgONU33gEbMDyU5tVwnidlQ31t86KwWcn1l80CG5zVY3aqr8B51K/qaVi3fekoqGEiTBFLfnxr6KFQ3LRgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799009)(186009)(451199024)(66476007)(66556008)(54906003)(66946007)(26005)(2906002)(316002)(31696002)(83380400001)(6916009)(7416002)(107886003)(86362001)(31686004)(2616005)(5660300002)(6512007)(41300700001)(6506007)(52116002)(38350700005)(478600001)(6666004)(6486002)(36756003)(8936002)(4326008)(8676002)(38100700002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejRoWjBISnRITWc4VTNlUTUxRXpob2JhUjhFRHFES3kxN1VMMUJNQmwyRWNG?=
 =?utf-8?B?WGJtOHJIVDQ4YXFjOFNDeTVyODJod0RzVEplV1k3NFN5TkpMVnFNSTNYcWVQ?=
 =?utf-8?B?NXpweGY5OUpWRnZRaE9BUUFnemRvVS9JU1Z6aEVaWVIxLzQ3QVorM28xSVAy?=
 =?utf-8?B?b0wybHNHcG9lRHp5OHAwU2FmNHFsbVBsQnpKRTVxRjBhMjlXeTRoVGYyRzcy?=
 =?utf-8?B?ZVpRVFpqSmpnaEQ3a1lvT1dyKzVhREpLYnI3eVlGMFdOeERWMVhzV0pTNlVF?=
 =?utf-8?B?YnhNMm9EZnNTcEhHbk9odUVTMXRJSkNjVFdub0lmMTRaQk1uMXF2SFk3N0FS?=
 =?utf-8?B?QWx4MEI3SDRLbnJlK05xL1c3QXpJQVpSbk8rei83eThDdDFIRFVwT1RSc3hP?=
 =?utf-8?B?UkRhNDkwVjFkSEgvNE8zVmdEa2cwcFVBMkJxa2FDSlRjSk9EbDJMTUM3RW41?=
 =?utf-8?B?ODdqVDN1aFJXbHY4dDk4bDJ0akdZcDdyNEl4aXM0MmFhV2k4eWxvTlI5N0hu?=
 =?utf-8?B?NmhqQ1VscnNhTEw3aUhGS3hOeDljK1JuZ01QWWdDVnZZZFFsSzFYUG9KbnJ0?=
 =?utf-8?B?R3ZLK3R1b1M5c29uam5rWnN5clZaYk1sU3F6YTNwUE5ScDhVdEdid1ljeDJF?=
 =?utf-8?B?cXp5T1FyU3BZUDA4Qm5PT2p0QWNncmRQUWR3TlloL3FEOXhMWWxPL002ZzJp?=
 =?utf-8?B?WlBVcmZYS1V0WERPdUoxNEN4V0dtb1RGbHFMeWZGWVJVSVlWT3huWW04aVdX?=
 =?utf-8?B?OUxwWlVUOU4zRjgyUnFvWGRCbmw3VzR2a1poY2xzOS9NcWNXV0pSMkhuM0xm?=
 =?utf-8?B?d1EzNEhpSUpxR1J2dU5zNCs1OEhLMUVWa01GdVBnUU9GM1UyNUZoais2RVhS?=
 =?utf-8?B?cGtYdjF1L2JaSUhWOHJjVDNCUkRUdWUwOFNaZnRPWGdmWDBuU1dIVTYvenFu?=
 =?utf-8?B?MXJnR0pJcTlUZnMxRm5iSkRLekZBekQyaUlQbXgzcDF0VXZPc2Z0QStGWWVP?=
 =?utf-8?B?aFVHdlJBS0M2aUpBcmVaaHY5NHhxMEpRQitiN04wMVkwU25YZkphTENHSnpy?=
 =?utf-8?B?V3hUU1lOMGFVOU5XR2UxdnBTdEdDV1RjVFdiNzRBNlFHWmtRdlkwWFVCTHVB?=
 =?utf-8?B?dzBMZzZ3a28yQmFMbk12NnBYdG51Z3dGZzM4b0tOSHdkK3ZqaWZZOTFTR1Az?=
 =?utf-8?B?Z2JlRTUxK1UzdUNkR0l6OUhlS3hMbU5MMEtXOTVDRzV2aEltU0RaOFl1SkhW?=
 =?utf-8?B?dUdaL3lBQmJ0RWNOWVpRWmlCcyt4QUJnUG0rZ0RETTZxZTlRRHpLNnR1Wlhy?=
 =?utf-8?B?c1pRSnllWWJ2UFp2c0lkKzd5R0NVdWZCSmFMUi84eHNMVTZlWEhIc3J6L2x5?=
 =?utf-8?B?WjB3Tzh5eHUxY1ZPVEthTERGdzdSQk9OSXlqTkRFYWpxOFpPck93VGpyYmlX?=
 =?utf-8?B?OGQrKytBVFNnYzF4L2M3QmsrbklWd1BZQjgrZXNQbXVZV1hqTE1sdzFFSnM5?=
 =?utf-8?B?NUpuOXh1OGlGbkNmSDZRY1FNdW5zTFZ2VnBHaksrWjVmdE5yejY3VkVaZ1E4?=
 =?utf-8?B?a21oQlBPVjVybXdUNi9sUDI3WjBJSTZVOE55bmZRUm5JL2hPWVNUaVZQSDZZ?=
 =?utf-8?B?ZEsxeWhEcGd4ZjhHemN3WUFBeUNZeDkrV1pZTEs3dE1ub284TmFMZndvNHIz?=
 =?utf-8?B?b1FscnJuU1NzTFc4ZjhvMEVDaXlITUxnSFFkN0M5QVZYSnk2bTR5QXlNOWFC?=
 =?utf-8?B?RS9DUVdVTDdVaTNzSEt2RlU3OEtNSFAxMzFtQ1lHWDlYTTZJaS8zZWl4R1JI?=
 =?utf-8?B?MHAvUVphQVI1WWJsNGpWUzJMZVduV1ZHNEh5enI2ZEoyZ1Jla2JCZ0FieWF0?=
 =?utf-8?B?Zjh2ZHFSWHcyTEdlVUZQNlpLYStrSXhKSmdKY1ZYWFlDakM4NU1zY1RQTGgr?=
 =?utf-8?B?cWcyUzRaQnZTUDY4ejBDOUswbk1kQUhBb2VHdWFWSENFQ0F0NkxmczlpbHFS?=
 =?utf-8?B?VWxoWkFDTmJmcnRFUjV5cjJCZ2xuU0FyU0FYdm8vZGtmbFpxL2w5ZURML3hB?=
 =?utf-8?B?dkFJUTVMQXAxU21nZ2lvNENDbDdZdlBnQUNLL1pPOCtBK2xpWk8vdmZ6UWNT?=
 =?utf-8?Q?HM2hw+ZCo1l9Ly5xKazpb6BtR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcecc72-55c6-4ff1-b8d8-08dbe1125b28
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 10:55:16.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viMNDxAn52Sx9ul0gsZB5amVP3aROL0qONFvyzRdk8JebzZWzSmd10bbWMYg/odMggBWcw9oDMqsS67Cgl/IAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5815


在 2023/11/9 17:53, Michal Hocko 写道:
> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu 09-11-23 09:56:46, Huan Yang wrote:
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
>> it will not be used for a long time. In order to proactively save some
>> memory, our strategy will choose to compress the application's private
>> data into zram. And we will also select some of the cold application
>> data that we think is in zram and swap it out.
>>
>> The above operations assume that anonymous pages are private to the
>> application.  After the application is frozen, compressing these pages
>> into zram can save memory to some extent without worrying about
>> frequent refaults.
> Why don't you rely on the default reclaim heuristics? In other words do
As I mentioned earlier, the madvise approach may not be suitable for my 
needs.
> you have any numbers showing that a selective reclaim results in a much

In the mobile field, we have a core metric called application residency.

This mechanism can help us improve the application residency if we can 
provide
a good freeze detection and proactive reclamation policy.

I can only provide specific data from our internal tests, and it may be 
older data,
and it tested using cgroup v1:

In 12G ram phone, app residency improve from 29 to 38.


> better behavior? How do you evaluate that?
>
>> And the cost of refaults on zram is lower than that of IO.
>>
>>
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
> That would be a much saner approach.
>
>> Or, it's a bad idea that use swappiness to control unbalance reclaim.
> Memory reclaim is not really obliged to consider swappiness. In fact the
> actual behavior has changed several times in the past and it is safer to
> assume this might change in the future again.
Thank you for the guidance.
>
> --
> Michal Hocko
> SUSE Labs

-- 
Thanks,
Huan Yang


