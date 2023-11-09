Return-Path: <cgroups+bounces-280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29DF7E6AFC
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03251C20B9D
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A615EA1;
	Thu,  9 Nov 2023 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GdPAI5qt"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5110953;
	Thu,  9 Nov 2023 13:07:41 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449E12D55;
	Thu,  9 Nov 2023 05:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjKUUi+z2oYSwwTlp5gJVO/7Cpm7x7f82lC7eeCX0XVWfuew3ruB9rgwCzvXGpv23WPIhF4WsTZNN1bnjiiI/VVD7iLplK2SEE+yrMd9DRqhWWIDtDXBUBLXE2w01mPHVNkSDo7Co8mJLyK/50XzJEe59rwkhKTcjLJ8aBqc7/z6YTH4E3uRNPUrPNGeIfDxTj7hvRddxdQYEM1N8IiuugjmqKPB2/MrPgCIb5ULN5x1ruP1iGDVkRZG8vKwNOJQthC6IpRkwotaxqc8fd9skRtNQFEsJMzoKBabRo+ZksMvxoxcj04kHPNjJpyKgnP3T9O6ABGnq/Qz7603ILPowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXLHoBft3PFdyrEWviTmr47oqVChTZkeGwhvNzSWS4Y=;
 b=QsDyvGPPzxLZfNXKsD5esLZheNQcZC2hv08J4za3xMF71bHTncBhGboJdiL0oxp9rcu+U5XjJufTzTPBltNkCh/lE2Cp9N4RRh6kdIM/Qfdcr2VeZ1Ua55RqnOzOYXdaP6U+lrE2zKfV/EtafhQEVDfMEsEpoGbGSk6Oa0olMaoxdcOyTqDCQhkWb7SQoB/BAh9luAEbSu+TOepZ2uEAs9cdgxciMbwEmBE29eb/b7Z2cYxc3HNtjBX7+2hrFtkEt8XmiyjnnYXb/aF0ASfeWDgnYUDyrVklx3dnxS7msJTOh10spoESfnfNjhHzAchXK95u8vIq5i4qWhr1tk7UEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXLHoBft3PFdyrEWviTmr47oqVChTZkeGwhvNzSWS4Y=;
 b=GdPAI5qtvtSopwe33gttIKJD/odRkgrXNaOSmZXdJ5WFsmOxuzWeWjekUgmPAW7T283soWRg/PF8jvuM0TmsA6BGvgB+S+ihSHQIJnetnT+ilzTth4FnYsinIFpe82Lt0XphR3dAN0Oaw91lcCL4TZJeBG2F6rT9q/mJGJhtOdpJ4Ldt++stNeP4s2vt6PkyydN7zwunqI9V6IrmJsEHoyugYew7W41NaWeAZEC8VPEWTuFQC1DUvmDvr+MthUreYia/iWPI3bHVj/1BxOcQSYA+3MZi8ecBQoWebA8Cffc1XF4fvo8M1VxEYcuG+kCc0/4xMHSMvYu2saFkhqiRJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 13:07:36 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 13:07:35 +0000
Message-ID: <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
Date: Thu, 9 Nov 2023 21:07:29 +0800
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
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka> <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com> <ZUzTVgK_i05uiHiB@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZUzTVgK_i05uiHiB@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 886bedd4-dd5b-4011-b9de-08dbe124d77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TQUraJz6PEYducrszdNAK+mwTJJb/MxOu848x9MZmb0JMXjm+Gy/qlz38SYmxRvJpyH/M+4oV72lrlu2t7qhzS98QQyrnQ2Kh65H6/Z9EK/3Z4FWrorQYkq76gltRY/vVPM24vWEZgYW9PmYbnTHw83VEojwI7mDHrE2SfNUsE6/nQxF4kQYafw7tfnjg4B83hg6QEraimAGfBlEew3N9Z8kIcfe+G/T7p6HwuNU6yOA+h9c7UowkCU18qAUi6tlVyxRnRDZYzS3G/4WLW2psUrfHZPWutp4H59VPD93nNJDhFfGYYrQl/husz2qBIxcGtKQgccKkiClCmj17EFqcEuJltGHfCNzvG4cuFO69UOXSBId1JqSCzbsYp8NEwpuQXDLWqLWOrxmAJxDsxolm0Z4ytLqcLaGDcprmqEA0Wuk5X7i4rn81pXU0EZLvNsg3h4fcJNOsu+tkph3qk6Db0ZUK6GcSrMVHtvaWmjTYTsa67SLSkeFb16PIxGKerY/4mkCG5vUjRWy0wYxmzkLiv6+ll/T3Zu02IH6eXrNyQ7ONYxrLM0XOrwkST52Zu7JYiVJKBYrkocV6bt9qBp6bU24Gb277GLmtGy0SlCXmzUd5hym76T7ynTgTXMCzfmMHPRnn5EexK9id/ujrjaOjYRb+pwqGxubhqibCDZ79lRjFMPw1IwPt79JO0Uc9xiNvtoHQmC43x1/MEZFqQAxsw85xFUE6jAYoJy7zWtzgqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39850400004)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(38100700002)(31686004)(4326008)(8676002)(41300700001)(83380400001)(7416002)(86362001)(31696002)(316002)(6512007)(8936002)(5660300002)(107886003)(66899024)(2616005)(66946007)(66556008)(66476007)(38350700005)(6916009)(6506007)(52116002)(54906003)(6666004)(478600001)(966005)(6486002)(26005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a29IcEtjTUZSc2ZmUmdmYk43OVlLcVJZd0p5N3BTQkxkYWNqZkM3blFUV2Q0?=
 =?utf-8?B?WlpsNUlMQTVNNkE5TCtaaW84djdIbC81MDV0eHhCN1d0TWs3NnpXa3F5YWpB?=
 =?utf-8?B?SlQvcVY4ZC9xRlh5RkhjbXVCazladXpkUnZrV1N3RkhnN3NkM3JmQlcrU1BK?=
 =?utf-8?B?WTZ4SCs2TkJmMlBWSWxEdUdLclMrb2k0U1ZEVXR1cXBMaTcxUTdQZzNMdDVR?=
 =?utf-8?B?c0FxSVlVS2JkZnJTb2hlN0RRYnFwNjhVQm0wdnlKdHlhWjUxT3BLQnFEcWRO?=
 =?utf-8?B?TzQ4NnR0SlBoZkt6MmEwRndhTGQ1YXZ0KzBCK0hac0lwUURHRUZ1b1kyTnFx?=
 =?utf-8?B?U1ZWUWYrZlp3eXhZNGl1N1kydnhzaEZISTZXRjY3NE1TT21pMDRrRTgxaTEz?=
 =?utf-8?B?RUlvN1NlNWhFTTRoZ1YvbDdjbHRWNkV0NFQrc1NZSkRGRjY0RzV5amg2N3dD?=
 =?utf-8?B?R0pMUmlJVkpsdVd0RUhPOFpSVDNuVkc1MytRYTErSjZMb0hJRUd3ckV4OUFo?=
 =?utf-8?B?VnZkVlpic2dXTDY1TTFrRFVMaXNveEhqaGpGZlFWSFV6azBXaWg1QkNVY3Vh?=
 =?utf-8?B?M0tCT29kUDcwajBIeWJUTWx0NjRZMjRHNENrM1NxMEd4cFp1ODBpR0tXTVBs?=
 =?utf-8?B?eVBOaFNXU1V0T3VLZHFySE5FTEJqV2Y5NFdhbUF4YkJ0TGtPcGNubHdTRWkz?=
 =?utf-8?B?NktKS21KMXdDdjVMTVJLUmpEOFFaOTRBVDRVYXdYSUhOY21xUU1IR3VQand3?=
 =?utf-8?B?SVNjR0JXUHNjZm9kL3ZFYVZJeWl6a1ZSY2laWnJFcEtlL0hwUXo3UmhhbUN6?=
 =?utf-8?B?WmRkUXN6UUVqcDllaHlySURhR1pCZHBId1ZMMmM1UDI5dS9NeS9IVGNDSE4w?=
 =?utf-8?B?TXJaZ1RFZHhPVkxOTUhtUnRWYTJZeEtRLzVqUCtBdXNJNnFsK0VyMHlvOWZC?=
 =?utf-8?B?VHFrVjVDeXVEQkZMQlVJM0ltSUx2Qjd2VEllN1dlK0xGRzhpYW9uNWhzMnc5?=
 =?utf-8?B?QnI2a2MvNWdETkExV1F5Q0plSkJvNUs1Y3gwOXV5czBjQ3daZkphU2cyR0Jt?=
 =?utf-8?B?UjUyOWFPK3dJSTlDcG44dXkrSTJmSVEwNUJEQ0FsZXFWekN6SW41OXR1REcy?=
 =?utf-8?B?aE5IL2tlay8zSllWQVJsN09FcWVsNG1OTkRkRGh2eEJNd3lNbytBcXpMaTVX?=
 =?utf-8?B?U1RGclVNbUUrYnNKVVRvK2pYUEswL2hBMS9vVlBFcGtyNG04NGV5ODZzdEtu?=
 =?utf-8?B?ajJCQ3JKWHFwNHBUZnE5Rk1kK2FCS3g0WGgvSW1qakg0WVR1WDZDWjUzd3VH?=
 =?utf-8?B?SSsrVzBZMkxPQzYxcGlDMm9IL2lOWTZtMVZaMnFNTWlUdGU4SE5wLzhTWm1G?=
 =?utf-8?B?czNsRkNHMXFCWXRVN2tVeENCYnc5cEpOcGJoZ1hkbGRUcGIweTBCRU9XZ1F6?=
 =?utf-8?B?amU3OTA5dXJDYk9JMThSMmJQaEFnQ2s1MUM3bVZBTDVzS1JaRFRWNnB4QU9S?=
 =?utf-8?B?UUk0TGZVOCtxV0xrbG1mNzBDVEJDWC9DYjNCbnhXNVhYY1FpRDc1UXIxT0Zl?=
 =?utf-8?B?MFBvWTBxR2FJd3FqRHpDeitEU096OTRRZnZ5NytJaVpPSWJZT1lKMTNPeWoy?=
 =?utf-8?B?eUpDWk91RWF6YUNkU0pwZ3ZHa0c4K3kvRkNDTzNpNVdkNnRIRHUybjR0YWF2?=
 =?utf-8?B?aitYbEdPeGZMOEZMRG5EME0raEhMQWtRcGpMZkMwNC9sTS9xam1xVTJtOEtW?=
 =?utf-8?B?RjZreFpReGdNYVluMG4vQ1N2UWIySWdXRXQyZXdySnFMVFh2MmN6cFBBeTEr?=
 =?utf-8?B?RThPVlhFUUFBODRabS9JWnlQOElrTXNXOEszZ1JXdVhOMWYvQUo2aWlMQTZJ?=
 =?utf-8?B?cUJuWTVpcGh4aE5HOUFWdFNyUkk4bnhZdzh4WEZlenZ3dnRmNjBEcDg4R1Jn?=
 =?utf-8?B?ZG02QjFQdVJJcXMvREtVOHNCY3FjcVpMVktnN2VVbU8xVUFYNzJYc3grVDJj?=
 =?utf-8?B?cEhWZUkwV0RTcDBzSTc1cFUzYWtpbW1tNFc5amdIUFFhcW1sUVM1QzBPTjF4?=
 =?utf-8?B?d01GVjJKMjluRUVtUFZJK2dtRlpUWW1KOE1XajBIdys0dHlzQW96SXEzRksv?=
 =?utf-8?Q?U6yv8uGUA27ZJjlZTPs3B+r+l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886bedd4-dd5b-4011-b9de-08dbe124d77c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:07:35.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vybgSKCFKL8kXRPpE/O6s6yxsuC1kkXsAEzxYWOVjpwv52L7efSGv/cwRz2pV2qE2/hRoQtD/xhqHDDzgTJVLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4173

HI,

在 2023/11/9 20:40, Michal Hocko 写道:
> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu 09-11-23 18:50:36, Huan Yang wrote:
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
>> to perform proactive reclamation with certain tendencies. Your
>> suggestion is to reclaim memory by scanning the task process space.
>> However, in the mobile field, memory is usually viewed at the
>> granularity of an APP.
> OK, sthis is likely a terminology gap on my end. By application you do
> not really mean a process but rather a whole cgroup. That would have
> been really useful to be explicit about.
I'm sorry for the confusion. But, in reality, the example I gave was 
just the one we use
here. In terms of policy, any reasonable method can be chosen to 
organize cgroups
and reclaim memory with certain tendencies.
But, let's continue the discussion assuming that memcg is grouped by 
application to
avoid confusion.
>
>> Therefore, after an APP is frozen, we hope to reclaim memory uniformly
>> according to the pre-grouped APP processes.
>>
>> Of course, as you suggested, madvise can also achieve this, but
>> implementing it in the agent may be more complex.(In terms of
>> achieving the same goal, using memcg to group all the processes of an
>> APP and perform proactive reclamation is simpler than using madvise
>> and scanning multiple processes of an application using an agent?)
> It might be more involved but the primary question is whether it is
> usable for the specific use case. Madvise interface is not LRU aware but
> you are not really talking about that to be a requirement? So it would
> really help if you go deeper into details on how is the interface
> actually supposed to be used in your case.
In mobile field, we usually configure zram to compress anonymous page.
We can approximate to expand memory usage with limited hardware memory
by using zram.

With proper strategies, an 8GB RAM phone can approximate the usage of a 
12GB phone
(or more).

In our strategy, we group memcg by application. When the agent detects 
that an
application has entered the background, then frozen, and has not been 
used for a long time,
the agent will slowly issue commands to reclaim the anonymous page of 
that application.

With this interface, `echo memory anon > memory.reclaim`

>
> Also make sure to exaplain why you cannot use other existing interfaces.
> For example, why you simply don't decrease the limit of the frozen
> cgroup and rely on the normal reclaim process to evict the most cold
This is a question of reclamation tendency, and simply decreasing the 
limit of the frozen
cgroup cannot achieve this.
> memory? What are you basing your anon vs. file proportion decision on?
When zram is configured and anonymous pages are reclaimed proactively, 
the refault
probability of anonymous pages is low when an application is frozen and 
not reopened.
Also, the cost of refaulting from zram is relatively low.

However, file pages usually have shared properties, so even if an 
application is frozen,
other processes may still access the file pages. If a limit is set and 
the reclamation encounters
file pages, it will cause a certain amount of refault I/O, which is 
costly for mobile devices.

Therefore, we want to have a proactive reclamation interface that has a 
tendency to only
reclaim anonymous pages rather than file pages.

By doing so, more application data can be stored in the background, and 
when the application
is reopened from the background, cold start can be avoided.(Cold start 
means that the application
needs to reload the required data and reinitialize its running logic.)
>
> In other words more details, ideally with some numbers and make sure to
> describe why existing APIs cannot be used.
> --
> Michal Hocko
> SUSE Labs

-- 
Thanks,
Huan Yang


