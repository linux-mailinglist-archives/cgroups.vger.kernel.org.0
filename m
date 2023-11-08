Return-Path: <cgroups+bounces-243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E117E525F
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 10:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B7428144F
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D37DDD2;
	Wed,  8 Nov 2023 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FE2PfRdO"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748ADDB7;
	Wed,  8 Nov 2023 09:06:04 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF3171C;
	Wed,  8 Nov 2023 01:06:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df/8Drq0r0zZiB+1WB6IzHjh7iK2YqdRHUzm46Xpe+keYKViO+DRilH3vUw7sCNFeJ33r2J1yUDc+qtqlmakQ+kP91wKEKe/wGO4UMSbl8JeP8BtICufPRIKyMemkjhSS5hy6BAYINUgDfUlgWVArJfqa85l7hJ3sgzhdvwIdq0JKD1vsJ8HZ12MaKiWq68tlsQPvV/hOmxwJjSb2ArJJi1jMF2fx3Ft9bkZKHTauAYNnH8vK4dUSZF58EBX9wh31HFDsa0xqrjZ2woBS+tNQdfSFR0ATPjwPyMhb3COhLAAqGza6rblsARU+RNl8X7+Q6G3U3mFEpU/lC09pnClDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkntYTgJ8iEZHD58k6xWGAvdVK+sucSsH3qxJET96HY=;
 b=mwsUhAyQN+3zTVX4loP0yYI1s8ZCHBt2hCNxTIvADR3OsPfkkcHhKP2Xu4GXtC8urviDOfbghWYVVxMBkKeq3HO36gkwOTaP30ABEpRVmnrLPc3L14nCyixuTnZYKmYOWICCtxes+qpUyybOG0B/dxdsB7X4lhIQAGt9vTRe7ctgzpApCNXhlERh4ibUogArpSsLccoPniYh022/YB0FUCUQxJb523ESkn+Vzvpq0m/fkOTL5H5kwOaly2kzPP2BYl/Ri8XlBC+BLgBdZfonPYidg/4JskwNFVwjrjQpSNEHX5X4aL8k/xJyo1/Xl1e35QkycbDvqLovtH4vD6+Bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkntYTgJ8iEZHD58k6xWGAvdVK+sucSsH3qxJET96HY=;
 b=FE2PfRdOVo3Mkc2JV5wcK2psLCGE89YaKF5Cghhjl2UCbsbOsQve5wiQWVcMFBGzD7wFlExkW1bVruZ8xThRuE20uYhVx7oIv2+IB6vNTJoQIjHwGpa70jEdu+0u2mDT9yA4q5kg3mWyPPRpUI+n3Es/wlN4I06P5Y2EVN6jZq2KlbJDeWiTMacY85rKEo9ziNGegy2AhX5SF6qelzT2RO/bgeZBGxM2r0KFBRImdqUjOIs4GPExWi1AauyQQq4Hfkm3pgWYX6EG6F/R558HEU8lhCyO74aJ1pYrrjAgrtaviWDpVtR0qcvsUbxxVh0njxKXs+5FeO8HmU3uAZCv5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6737.apcprd06.prod.outlook.com (2603:1096:990:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 09:06:00 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 09:06:00 +0000
Message-ID: <8d28e404-d5cc-4098-b745-b59608b1a66f@vivo.com>
Date: Wed, 8 Nov 2023 17:05:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20231108065818.19932-1-link@vivo.com>
 <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com>
 <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJD7tkY2iOeaYfzjRp__kVDyYYK5_KycS6PnMTtudUHghTnZLw@mail.gmail.com>
 <4db7e55f-c6cb-4be2-89e1-339f6e32b85b@vivo.com>
 <CAJD7tkbnGykSriLVKeZOoWxHzM6o6AfCASONFCdaeNg2oaa1LA@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAJD7tkbnGykSriLVKeZOoWxHzM6o6AfCASONFCdaeNg2oaa1LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: cede2b06-c695-4f38-4f04-08dbe039ed1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OR4kxPi/b3ZU9fR0f+kfXsomOj4ABugAA35JkrQOiYW6ri4Ovod+8uHaRHoQmrcmMTVbiSFYJb2+csZDVEzvhiZe/JeexdO40ZrF/KudGnLU+D700ZNSRLfZDjttpJ54GLd8nGr43+y9pVp0ihsoDYmg/jmgzy08y4pLJ8sc5usRVyAADyRnzYuxV5K7xlHNtRJ46R/2p/6uoamIXMDj4WdMIuVJ9j6ybxQSyw3hW4x699F80PUC5Aw7yMAXKni3q3qJCLeTtm1YVzugUq/36UbKvJ8/qT0At6cvfcsLRQK/9bdQU5leWFN4XqOx4biVygUGbJHYu5W0pKMyT111+/9m/qR70J8WdwmfIYi3EXkeWx0af6QtE2ABd5XLVEwRtSDe8JXJWFEYX3PpuHoQb84hUxydLkNfJQ4R7fzxynMUmDk4XamW9mfNJgfvHDaC+XybhLeDpnbYwV1/Mqv2jqcIP8eMlNdYmMzEg7pdVl9J9Ju9vaowg1wxHycQBb7wu0A3HYaVJE5261USQ18XVO9Yjn+wkXfBe4fODzNs1xbLs/hMlWXyqGHZKOoUiAaeFSjLm89nBu9CsHxZg3k6OtB0YJZVyZCKXS8AT4P2CHP33keKYjqKa8F75LSNc7ticBGypeULtjlzgJt9Vf+SdEb2TyYgo3hBsapwFBhF7p+fSUf9/lP9jc2TYJ3wPVti
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(52116002)(6512007)(6486002)(6506007)(2616005)(6666004)(53546011)(478600001)(107886003)(26005)(2906002)(41300700001)(5660300002)(7416002)(66476007)(66946007)(54906003)(66556008)(4326008)(316002)(6916009)(8676002)(8936002)(83380400001)(38350700005)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUlzZEJWVUxEVkg2SFRJV3U2bzZ5OXVaRWhlR09BR2hCRHJjNlk2cXZodmhs?=
 =?utf-8?B?VzQvZXRKOU9ZanJrUGJ2eUZyeHFkdE1EV21nUHllMW9yUUFVMlRQNkRWOVFr?=
 =?utf-8?B?TURPTE9Dd2wvdGNXNzArTTJTVnFiK3FsVTdSYm5CZ1RuVE1QL2VLTUVqQTI0?=
 =?utf-8?B?eWQ2aTZIK2x5N2VPcGxqdDdGZVFBTWtwdVJod2QvMGxZaFpkTzBQU204UzVT?=
 =?utf-8?B?cEN3WUJZb000REhlcUJTcU4vMVNFNHE4SjRUMk1sSGpLbjROSDl0Rmc5SjhR?=
 =?utf-8?B?YnEreWNXakpEQkxzcTY2ZEM5UnZzOHp5OU1mc0lVUWMweXFoaHM0OStpUnRS?=
 =?utf-8?B?VUI2dTZ2WERMZlBtbTFieHdHejFYeng0L3d2dnBiUXhyN3VBNGpTMi8wTklZ?=
 =?utf-8?B?YXZaemV5TzNnMlU4cXJhM09GM3NlM2MrMmtVTTE2eHoxQ3pmU0pOSFo2QkRh?=
 =?utf-8?B?ZGF0bUgxZnY2N3FGalprWXJ5QkVOOXUyOCt3ZUxmRFRycjhtS2ZyaTFuRXpB?=
 =?utf-8?B?QmtBakVZNklDbFpwN0t3QlhOTkpyaTdkT1BPbksvUnEya2JtVmN5Z1ZyNWh1?=
 =?utf-8?B?VGxwbFdoV0doUFlqOGVmY3BLNm5UMC9aU1YrSEJzK1FUNXAwWGU4cUNTUG0z?=
 =?utf-8?B?ZjdRdk1WUVpLRVhWeFV4S0ViQUNzaEtTZzczUHlNYkJrYjNnRTlCN1hoa0pQ?=
 =?utf-8?B?dU9XcWlWL0ZpOVl0ZnRyQnlnNkNlWVJSM2NCMGpQVytxT0w0bktjdVE4Qmxt?=
 =?utf-8?B?UUZlV1FBZm5LSXVhZ3F0SWMxajNhT1BTODVJMmptQm5Nb29zelZtWnBtYi83?=
 =?utf-8?B?M3NhYlU1Zi9COHBSOXc1YmN6MUJCd0o4czczRllxcXR3VU1qNnZhY1BKc0tC?=
 =?utf-8?B?WUpPbVc1OGVpRjhXaWVOZjQ4OURoczJqZDZRSFVzL2NlWk9SV1Ewdm5lSEhv?=
 =?utf-8?B?TTlMM28zRzVHK1lPMVRmcmc1Tk1NNlJTWVRSRE0yTlFnUzU4RTBXVnFVTmJ2?=
 =?utf-8?B?bzhtN0Jab0RQWVJHQnh6SlVzbmh6SEhxTVd4S3kzeUZweGRKYmlLS2JyVVcy?=
 =?utf-8?B?SVlrMVlhc2xIWUtEMTVNV0tjWkUvbWM3T0VnTWpjaUlhcm5LdHZiUXBRbytq?=
 =?utf-8?B?RURHQk8yZ2NCS1dtWnlSVldnWHNvUXk3elZGTE9TRkpKYWs5U3M5b2xHTGpD?=
 =?utf-8?B?R0xPRDV4TXZYSFRDV3hKdVZINmdZNUNLWDRHRnIzOVMyZzBKRWV6TURBTXh5?=
 =?utf-8?B?dDFPMWUxKzh3RGlOVE1Vb1BhRlp1WFhUZlJZaGtzMmE0L21rSGRCNUg5T244?=
 =?utf-8?B?OWo4akNVQjNlc1lPNHZUc1ZjdSt5NWhsQm9vVDEzOUx0YVNJTzIzeTRuTk5M?=
 =?utf-8?B?YUFsNTNMT0FMaGJZYmhrT3pYeVcvcEkxMUxKQmJMbTBzcWNaQjI0TnVJYVNt?=
 =?utf-8?B?S2s1Mk1nTVY3eDZLcFV6VDV2UlVzSHRjbllOYzB4UTFlZUxkdzVucWhNbmlv?=
 =?utf-8?B?amlTeDd1WEsxUnZHWUdTbjhYUFFnUE9OSFRoajVlaE81YTd0UWUxcnNTVkgw?=
 =?utf-8?B?Ti80dlplNS9qVndxSGNDb3BWOWVNUEVTaTFxVkhQSVF6b1BqbDF4cFhONGJI?=
 =?utf-8?B?U3BTNmRHTi9JQnlUNFpJaCtLT0Fna0h4bC8xSS9PMjNUbExSWTdaNGVxOGU2?=
 =?utf-8?B?NmhrYkRtU3RVZ2NqQmFYeVNNV0kxcTBoK1M2NmZmOVJsR2RqMVdCcmlKNDJi?=
 =?utf-8?B?S3hRa1Y2V29LN2hVdGNBSUNZNDFIN3F1N1FudTJ6N3lWOTRzbnl1cmNQaWtm?=
 =?utf-8?B?MWFKWFk3QktqUW5TT0hHSG5KeE12dW85dHhaeFNXR0lQN2tPY2ZUbXhnMzdG?=
 =?utf-8?B?TzhnUkg5T2FvWWs3OVduclF1L1V2QTByZ1lTN1MxcXYxUlZoNGdOYy9wMnk0?=
 =?utf-8?B?NzZVZFllL2lZVzI5YjN5Tzk1ek1YVm5IdVM5Y0N0MTc1RkVqa0tTT1pyMS94?=
 =?utf-8?B?RG40SzBxUW5BZzBkcVhENnlqR1BCTGZ6RVBncHpOS0NNaG1CcnhUTXU5U3Zz?=
 =?utf-8?B?cDlBZEo0KythdDlPekFzQVR3Qyt5U2JzU1lONjlNQ2lBVnlDTDlzNVlvOVBK?=
 =?utf-8?Q?lAl7my7lFehera2404FxFN/XH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cede2b06-c695-4f38-4f04-08dbe039ed1f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:06:00.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB8InK9ZC4uat+7xv6q38Wn75pnQMm7q5Gc9oNMehmT1k06gyxzFQ1Rt/0PRlNa6F1e5Jkx0eFd1q2lBIpMuDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6737


在 2023/11/8 17:00, Yosry Ahmed 写道:
> On Wed, Nov 8, 2023 at 12:22 AM Huan Yang <link@vivo.com> wrote:
>>
>> 在 2023/11/8 16:14, Yosry Ahmed 写道:
>>> On Wed, Nov 8, 2023 at 12:11 AM Huang, Ying <ying.huang@intel.com> wrote:
>>>> Huan Yang <link@vivo.com> writes:
>>>>
>>>>> HI Huang, Ying
>>>>>
>>>>> Thanks for reply.
>>>>>
>>>>> 在 2023/11/8 15:35, Huang, Ying 写道:
>>>>>> Huan Yang <link@vivo.com> writes:
>>>>>>
>>>>>>> In some cases, we need to selectively reclaim file pages or anonymous
>>>>>>> pages in an unbalanced manner.
>>>>>>>
>>>>>>> For example, when an application is pushed to the background and frozen,
>>>>>>> it may not be opened for a long time, and we can safely reclaim the
>>>>>>> application's anonymous pages, but we do not want to touch the file pages.
>>>>>>>
>>>>>>> This patchset extends the proactive reclaim interface to achieve
>>>>>>> unbalanced reclamation. Users can control the reclamation tendency by
>>>>>>> inputting swappiness under the original interface. Specifically, users
>>>>>>> can input special values to extremely reclaim specific pages.
>>>>>>    From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
>>>>>> swappiness.  So you need to add that firstly?
>>>>> Sorry for this mistake, we always work on cgroupv1, so, not notice
>>>>> this commit 4550c4e, thank your for point that.
>>>>>
>>>>> I see this commit comment that `that's a different discussion`, but,
>>>>> to implements this, I will try add.
>>>>>
>>>>>>> Example:
>>>>>>>       echo "1G" 200 > memory.reclaim (only reclaim anon)
>>>>>>>         echo "1G" 0  > memory.reclaim (only reclaim file)
>>>>>>>         echo "1G" 1  > memory.reclaim (only reclaim file)
>>>>>>>
>>>>>>> Note that when performing unbalanced reclamation, the cgroup swappiness
>>>>>>> will be temporarily adjusted dynamically to the input value. Therefore,
>>>>>>> if the cgroup swappiness is further modified during runtime, there may
>>>>>>> be some errors.
>>>>>> If cgroup swappiness will be adjusted temporarily, why not just change
>>>>>> it via a script before/after proactive reclaiming?
>>>>> IMO, this unbalance reclaim only takes effect for a single command,
>>>>> so if it is pre-set using a script, the judgment of the reclamation tendency
>>>>> may become complicated.
>>>> If swappiness == 0, then we will only reclaim file pages.  If swappiness
>>>> == 200, then we may still reclaim file pages.  So you need a way to
>>>> reclaim only anon pages?
>>>>
>>>> If so, can we use some special swappiness value to specify that?  I
>>>> don't know whether use 200 will cause regression.  If so, we may need
>>>> some other value, e.g. >= 65536.
>>> I don't think swappiness is the answer here. This has been discussed a
>>> while back, please see my response. As you mentioned, swappiness may
>>> be ignored by the kernel in some cases, and its behavior has
>>> historically changed before.
>> For type base, reclaim can have direct tendencies as well. It's good.
>> But, what if
>> we only want to make small adjustments to the reclamation ratio?
>> Of course, sometimes swappiness may become ineffective.
>>
> Is there a real use case for this? I think it's difficult to reason
> about swappiness and make small adjustments to the file/anon ratio
> based on it. I'd prefer a more concrete implementation.

For example, swappiness=170 to try hard reclaim anon, a little pressure to
reclaim file(expect reclaim clean file). In theory, this method can help 
reduce
memory pressure.
Or else, reclaim 80% anon and trim 5% code file control is good when it is
detected that an application has been frozen for a period of time.


