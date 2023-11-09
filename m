Return-Path: <cgroups+bounces-281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88657E6B02
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A468C1C209E6
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE3182A7;
	Thu,  9 Nov 2023 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ozwYTQKz"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362D1DA28;
	Thu,  9 Nov 2023 13:10:36 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E630C2;
	Thu,  9 Nov 2023 05:10:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlMkA0l+SEnGj4Zt/8mHcgI5u11EaT8oQ0c+g9Wo5WEm+yFi6rUCQ2y4dAGA4jDzewwOA4o8AcWDBQQhlKrAOCYvAGuFMue3yqku8zNTJXimdcZqnrizbh6eenXoLsIsZ3KLCRVSWPHWbP96OGfL5+KmdcJ5ufLP0WFHZQzpoSt0q5MbQXSIdf8rMK0N/Qw9ZWwv/dEpEGtwexK8y58zkRCQ9d0RPK5ZLGe5tUFGmYCgS/BbA1tv2qRNAS9fO0KA0Ai2cqvHdG0uBcZ8N3SnQuStoEOBKWEzof3Edpo2anpDuHz7QGLqM3OKtHvvc5dNpoCoNlcAT/AgJMdN1YdIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nyT3QMpelmI1rg46wdJGUWZNmdUq7FFmGRdVV7SSuk=;
 b=GcTBMzcmlfb2aOExcEkLgKjxModfu9/NbVFQdqba213MBnrGTH/nJoOi61YiGKB93rK0JpdDuDLNhHdmSLfuDQsVu1+vvk69Ckmw/V7fD8RL5b4FEWjUVw6dfg7AoLeBJlpneoKnllDCYsZ+SPGZjEGZd9+05b1ZQRswMiuAvoKv0sSXAfi5QmrRGS+PLkbeVHKaAMuWqkRGSRING0U21PYZc52tQ45t2rsE199LZw6QarkZxyLNklc1ccilyQU4qdzrAnD9I4li75P0mDKDVrDwYhn1tYkf482bXBxAs8OMTOUYHwd8TWFQd1cEHl4drN0VlJ697jy69PN0Pw/zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyT3QMpelmI1rg46wdJGUWZNmdUq7FFmGRdVV7SSuk=;
 b=ozwYTQKzOBBiIpkFnvA7YZSoftmBHyuicIgfHu8rXteFE1uiJR48Q06bejwHs90l9zbm0E/lzBptuMhVgUgnKQR5FAiTZBA6zhtapxQgy6OCXAu9khmvkpjIy6uuBj22gepMABvA2isbkJTc86Wwv6DZPAdEQJPQ+Ixy6lrNRkxN9SEI0ewPXlOE6Q/wbu/PY9A7QENWfMRjMIxu43UjVBiLJEC2t3PoZ+ON4TV92Z8WQwxN56xAUT7zRq63TIZSP4HqKY5BurOEf+4eeuOz7J+QJN/It9qKeOVRr1XRSI94Dkzhqj6wbNjgxy2bATCg15qmdFqmp70r97HfUKADXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 13:10:33 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 13:10:32 +0000
Message-ID: <dd209adc-e14b-4760-846b-cea2c625f21f@vivo.com>
Date: Thu, 9 Nov 2023 21:10:26 +0800
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
 <ZUysGhwqo_XZSV-M@tiehlicka> <d49acb29-c1e6-429b-8d94-a5a8e1e2f548@vivo.com>
 <ZUzUhWsrzDQwMKQ-@tiehlicka>
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZUzUhWsrzDQwMKQ-@tiehlicka>
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
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 176bb945-1a33-49c9-595a-08dbe1254123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d+xf0Rxbq5cbr2Kc8KmlsIIiqV25+l3djVDyJt8HJPimNdTs+zREKVnZWE6Hn647bU/0DLRqh14dqC+b3FBvdIOQW88Aa6Z37tFh9GJj6Lrc4KU0Zrl+ssxfIgsbrH94nha43DOFJWfFpj+mbDzX8UKsdSPn0JScusRHMp7GIudFBbBF+ZHFz2VrcDfoWhwfXxqlGukfutQkJXb4AG2uFqg0k9G7nr4NsulkEWZgQaoRggx2mKhDXllAFUfQ4EAE9cAjw912WvPusaLxXp7OJWcrQiA12F9iOTXdBFm91HwtFHCGodJ8IeylJdBrTlpq+kmyzbGnVyJc19gmmMS3tTzAEghX1t4I4fXztnpwP03cvauys4NcgkAcOWqcGv5mQClK8Jx12s1JRcw8lSc+WX+Y+N95rd38snukXS+jQugEV4yvMYVW0VgJQKMLjhoksQdg2TytpP21ABnxrim7dXKYXiEQBKIkVZ42wf+TJfDS/kOuudNCPwVISB7VP6XKggGWh1L+ESTivqVi1cDbBgzBUq73sui8XQFR7xUKSMqhQ5whfFbMxTIFdFnZOY6d2GtN7HEWd/9lKuQthwvdrhzc4hG4KJJPR/N3+LtarHby6RPSV6XLni7i9tGf2QuuUNcUpvdZ2sqzR7Wq8fcw6YsIkDtzldDrJ3oKVjOen1tlarGekZw5j0x+tuFtAIR+Lb6GvJVLf2JhncTWQ4t1lzDkE0ussVVyr8u8D5r2k/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39850400004)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(38100700002)(31686004)(4326008)(8676002)(41300700001)(83380400001)(7416002)(86362001)(31696002)(316002)(6512007)(8936002)(5660300002)(107886003)(2616005)(66946007)(66556008)(66476007)(38350700005)(6916009)(6506007)(52116002)(54906003)(6666004)(478600001)(966005)(6486002)(26005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9sZVNyeXBXdlB1RmR5QTU1V1A3VEV6WENFR0RZdkdCL3c3VVQ3eFE1Qk9M?=
 =?utf-8?B?cHhjK3EvVFVwZFJyR0UzclVXWHgzMGlyZld5R0dDYlEzL0RnK2hra2ZHTkZE?=
 =?utf-8?B?eUw1MUJwdTN0b0MyV0dGL3NKSkZkcWVQMS94THFpUWZ1cHdhYTZrSXFhSmwr?=
 =?utf-8?B?NFd5Uks3YklEUE1ib3QvYURKemQyUkpkV3VOK2NIYmlvVDhKb0JzOElvQisz?=
 =?utf-8?B?Y0RlNkQwell6SDF5dTZmWUx3VS9CeU5JYTJ5R1kwMmVkYkIvRGZMdnd2TTVU?=
 =?utf-8?B?VFo2U1lPeUc0cVNNbjJ6cXpCUjVRRlBoOVBBMnRaYzM5VjR0RldQcWFIWnJ1?=
 =?utf-8?B?R25WRjZCckFBVjd6TWdHeVA3Q1JFUTJ6WXNQRWxUZEFjNzRkYmlHbzBTSGVq?=
 =?utf-8?B?d3dmSXJRL2VPUHltK3dlSUVQWU1ROVRUcFpndTVTVktnVy9mZDRYcTJtOHNk?=
 =?utf-8?B?OXA2d0hlT0xOVU5lY1NIWHMzeC93WEhSSnBEdEsydm40TGhJa1BQYjZSWUdD?=
 =?utf-8?B?SDBBcU9uM21aaTdmZFdMeXdWTEg2dHM5Mm5mUk5WQ3dFaXBhU0pDVjI5RGtC?=
 =?utf-8?B?eWg1N3dmRmtZT2REOVR1VGVqRloxU2NUam9BVVdGUnBJMjdDT25sTnE4Vkd1?=
 =?utf-8?B?bDJBeVNhamkzdThUQUdRbU4xdWNNaEFUMmJEK1NxQno3SHFhTVlnRWl5T3ky?=
 =?utf-8?B?R3NleFdPL3NpZC9qbzZyY2ZzMTdwYTVMSWJZdU1sL21XRkVpZUMvZks4MXNy?=
 =?utf-8?B?UWg0dmZNZ0pGcThTclE2U2IrZFhYd2pqdGN1OVo3VzlTelJGU3gwbE5jSXBl?=
 =?utf-8?B?VWx5bk5aQlVQTitGY3UvQTJKQmFGRnlKSUVjSENNWHBQK1dnUEUweUo2YzEy?=
 =?utf-8?B?b0REWk94M280YWtzMldvdW1lcUlPVVNyZVpkRVFEbkJqUjBFa3RkZnhlbTBN?=
 =?utf-8?B?Vkw3ZDgvblF4REVPQ1dlTGtCemZHdVJjMnpYb0lRcnZuK1FLUnZJUC9xSVRR?=
 =?utf-8?B?OXMybTByMGFOWmV0RElBY01KbStGYnQyODQ2ak52RWJzYW9LZ2ZRdkgrYmpi?=
 =?utf-8?B?VHRSSU4zenlPQ25hSTM5Y09WWXpPVGN5aU9ac2JOTldJOTZucGZxTHVvMktz?=
 =?utf-8?B?ZDl4ZnBEK29NSmNuM1Qvc3BGVzlvUVRsUXkzSExUWGRvUzA2VTVyS3dpT0ZX?=
 =?utf-8?B?ZmtYM1lMQkhqM1NlaDNIZzZMSGpOYkh1eGNYRVhOMTRtbVJoVmlDUG4ydnVJ?=
 =?utf-8?B?dnkxc0FSeHFJU0x2ZkxHTnV0NkhLN3BYVy9PY2hQdFFpdStsUkJzd2NSL1d1?=
 =?utf-8?B?VWMzU2N2dWtXZ2lzdUpXeFZkODgyQTFlT1gvQXA1QnVGbExiV0NTV0hwekJQ?=
 =?utf-8?B?YWt4cW5PM282ZTBjM29LSDRxTXJJaElsNWtGaExTMDhNWEh4UUVKUk1xejZx?=
 =?utf-8?B?WkFwemF4QXZYaU0vVGI2K1hzRGZlMHBWaEhTNDZiU2tYY09RZFc4REViZ09I?=
 =?utf-8?B?TWtUQ1I0UWx6Y2dvRmJDYndleHhSbUdCdFJDUWhqa29JN0ZmTk1tR1R4TTNx?=
 =?utf-8?B?Q0pCdXcrazQ3dkVmQ2ppRnZheEdTRHROTjR0cFo4dUhtQzVDcndnZXVjYldh?=
 =?utf-8?B?ZVRCMUk4bS9aa2lVQlRQT0lhN2x2WTl3V0VzS2c0RDRqU0xkSmFiYnV3ci8z?=
 =?utf-8?B?SWdIaVBUMG1lS2Z3UmY2ckhjRTJnUTR3clV1STVzejVRVjRkb3VLYWhseW80?=
 =?utf-8?B?a0o0WENQVzR3Y0xKY2tVUnlwN3Z6WFc3ZEhRSFdmdzdrME9kdktvZ0x3ckx4?=
 =?utf-8?B?cDJwMjkwY201alRTN250cXNJMnlnZTRpaWYzSkc5REExdkkzR1RHMk5oWmlT?=
 =?utf-8?B?bEV3UXpTUEw4dk9zamhLM0FRK1FFd3Y1aEdEQ2pHdlJ2VGJJMlRsOHpySm5m?=
 =?utf-8?B?OFdOalRENlhRcWJjMTFXRXIxYjdZQ28xMXl0SUMyRVlaRkFFZzdsWTJ2VHR2?=
 =?utf-8?B?Tlp2bDVGeVR0QXJvUTZtaFVRQ0xyMVdXbmtFVmxpRVpaVG1MSVNBWWF1dVY4?=
 =?utf-8?B?ODFMTXNydnB2TDJ4Sk8zUWwzaVk2bjJ0WXJ2TXJzYVNZRXgrNU56WFpJbmxE?=
 =?utf-8?Q?8TurOdrbVb8BzNRX1crLpDdsK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176bb945-1a33-49c9-595a-08dbe1254123
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:10:32.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy2JHs7Bq6nybhQgbxkSFsveNi0sYIqeVrhmp2h5sE16t5Sy2tN0Y3U/HZF4Icvz9gKeam5Yj3ZiHmkgthU2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4173


在 2023/11/9 20:45, Michal Hocko 写道:
> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu 09-11-23 18:55:09, Huan Yang wrote:
>> 在 2023/11/9 17:53, Michal Hocko 写道:
>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Thu 09-11-23 09:56:46, Huan Yang wrote:
>>>> 在 2023/11/8 22:06, Michal Hocko 写道:
>>>>> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> On Wed 08-11-23 14:58:11, Huan Yang wrote:
>>>>>> In some cases, we need to selectively reclaim file pages or anonymous
>>>>>> pages in an unbalanced manner.
>>>>>>
>>>>>> For example, when an application is pushed to the background and frozen,
>>>>>> it may not be opened for a long time, and we can safely reclaim the
>>>>>> application's anonymous pages, but we do not want to touch the file pages.
>>>>> Could you explain why? And also why do you need to swap out in that
>>>>> case?
>>>> When an application is frozen, it usually means that we predict that
>>>> it will not be used for a long time. In order to proactively save some
>>>> memory, our strategy will choose to compress the application's private
>>>> data into zram. And we will also select some of the cold application
>>>> data that we think is in zram and swap it out.
>>>>
>>>> The above operations assume that anonymous pages are private to the
>>>> application.  After the application is frozen, compressing these pages
>>>> into zram can save memory to some extent without worrying about
>>>> frequent refaults.
>>> Why don't you rely on the default reclaim heuristics? In other words do
>> As I mentioned earlier, the madvise approach may not be suitable for my
>> needs.
> I was asking about default reclaim behavior not madvise here.
Sorry for the misunderstand.
>
>>> you have any numbers showing that a selective reclaim results in a much
>> In the mobile field, we have a core metric called application residency.
> As already pointed out in other reply, make sure you explain this so
> that we, who are not active in mobile field, can understand the metric,
> how it is affected by the tooling relying on this interface.
OK.
>
>> This mechanism can help us improve the application residency if we can
>> provide a good freeze detection and proactive reclamation policy.
>>
>> I can only provide specific data from our internal tests, and it may
>> be older data, and it tested using cgroup v1:
>>
>> In 12G ram phone, app residency improve from 29 to 38.
> cgroup v1 is in maintenance mode and new extension would need to pass
> even a higher feasibility test than v2 based interface. Also make sure
> that you are testing the current upstream kernel.
OK, if patchset v2 expect, I will change work into cgroup v2 and give 
test data.
>
> Also let me stress out that you are proposing an extension to the user
> visible API and we will have to maintain that for ever. So make sure
> your justification is solid and understandable.
Thank you very much for your explanation. Let's focus on these 
discussions in
another email.
> --
> Michal Hocko
> SUSE Labs

-- 
Thanks,
Huan Yang


