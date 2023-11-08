Return-Path: <cgroups+bounces-239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C577E51DB
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D1A2813C1
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E039DDD6;
	Wed,  8 Nov 2023 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W1ZuzkrD"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B100DDC2;
	Wed,  8 Nov 2023 08:22:06 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440DD79;
	Wed,  8 Nov 2023 00:22:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf/FVoCSjiCwHGQsPz47zCFyGfGZqiUfTW3TVLTiTYqvNi4dR6zi+InPs7JHJQvU3tbqwlGN84qnVDGGjTx0C83B3//YR1bZuG9xDIKvc2Fm/67/aNv+dR7Oz/0W2WgH2Z2tz90grwQmaFZYVRAZN4J/jHEZEGSjy6hnN9fx/2KAvtC91fgUOG4qluH/SOvnPwDvlAfPqtERj6QtAqeNZyaLh1kH2rWai3fhLFDPW5+CqalmqTHaxTC3rUiQxIkR0pyqAguUV5rszNSMnL4oflCu+Qp5gaFiRSvIadIMAW0Fk08QDpsVi2qLcXtBGIK45sbrDGjoMGS8jEGYti4hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3Q/ht6jRNcXmD3d3BXeyidwy96sb2FTQmpsZasoIAw=;
 b=GShFs/NbXtpd2FRARgETm6aEMv89Q8004xxmH4KfPTZtkHKYS5ggvJjraxsYJc1WZwAqVmUSqKhM4L3Ok/lFtSOH5jiQfAEAkuawyjl1zJbeg5UrsFfWqegUmEaFvEuXTYmOzZDxnZVZzH1ITpeRAXR5B8lnlJq0p8lgZtdJ4s0n3aTTB5StomKxUBUZyGD+dMI7Ur5zyGbdwp31DiYr6I/Kd/RV8D7w7w3Aa/FUHqfoufDgdGP8E/all2lnKGzianydwHJ8jduAnGc74zU0PhrzVZKhW1Dj5Dry5w51gU/JjIcbhgBpOOKaOnioUqFrBmYehMotZzmWJJOEkpuWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3Q/ht6jRNcXmD3d3BXeyidwy96sb2FTQmpsZasoIAw=;
 b=W1ZuzkrDspJUh1aaitTVruNw/MI8h6qiiCd6Op1xoadvy80XkQqsgXEGgU2WRTGYjxuRqHcXDFpRwcFVWGdQX23kU8H+x4FKwQ4VHQbOldEVx2hAsFZbVzuTcU8DweZ/5qbFElO64e/lXIf6CXZKRJ9YENFneknsKkLbYB/g4cBQKquQpjX7w9oX+pQXSrmKEDfRG5XGlPmHjffo/vJD9l36g3aVj7Hcd9xLpd7aCC9dmRUHAWx29AD0g5I44q9gDQrkxGMGmACDsYDUY2HBgS9N4nmsFh4tR3oAL8ZUV51QMiZpp8eoIctv26v+7/QSns2BBD6WJewbAhc74HmeQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6493.apcprd06.prod.outlook.com (2603:1096:101:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 08:21:59 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 08:21:59 +0000
Message-ID: <4db7e55f-c6cb-4be2-89e1-339f6e32b85b@vivo.com>
Date: Wed, 8 Nov 2023 16:21:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
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
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAJD7tkY2iOeaYfzjRp__kVDyYYK5_KycS6PnMTtudUHghTnZLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 9322ff5d-b196-47cd-faa4-08dbe033c71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2+pfR8+yj1QyZiDiaRFCEmEoIr5aVCdQpWgdOCESyB8ShqY/urkbpdIB9gSRs2EO5EvklpJtT73+/vXexf0N5YAH+FPe9YTT/h+Wc27VtHHG8loBBNzyRymP3wNeMxJw6LL79YIL9qODbOxzPnnoXbazSHtTcA2IKHaJK0C+ailNm7dDe3/3EPCYYzInq3BWaaouw9Wwy5IWKw5o3ZoUJT3ymMAIA46alCGX7UR4wrXEUPOHGDkOUd37YYfxZ9qGTIGPDE7Do6gdmFZzcf3uvVxWf/Uexjyu8n+xw1RdpnYY8zgH9LSAv6X3gLJAn911YhcgnQHRL5KfCiYQod0PCYWGLlq8wK3+wCQwq2cWCEG81NCyobNe0wsZVbUfVZfcEj1Ywp5KmSuH4ERJL8tj62Cmnhe3s/qSovnlz2M4alIYKUE+GvFz79egQVlixHqvkTXEC5izqX8MsrjDgZk39mOW/50BtJa/bh8mxKsLYpO+XXEo2ZmCF1pxYnepbvjHzroexc3pw/9nXuqO4wDwU8sSgwJDJVvQkX9VGERUtiGpb1llPR9lVjFnxMeW/kyckvj9kgNmQpXPSj1p8UjyTsbF24TCMlUIJUXpFhAExf+OsVAa7FfjFBRSIl1bCVI3Zw+aZ7CKuzJvDQ3PJZUqOgGv6oEXLPJHsswDZ8TxHA9E1p40IPAjvTLNxWR+i8h0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(41300700001)(4326008)(2906002)(8936002)(8676002)(31696002)(7416002)(5660300002)(38350700005)(86362001)(36756003)(6512007)(2616005)(478600001)(6486002)(31686004)(53546011)(6506007)(6666004)(52116002)(38100700002)(26005)(83380400001)(66556008)(107886003)(316002)(54906003)(66946007)(110136005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEY4Rm1FTW96bTdOVmpZSmhVUFArL1VLZENqNW1NK0hidlpSeTUyYW1GSncy?=
 =?utf-8?B?YmN3ekNocGpoeEVyY01ieTIxaElLMTVpYXhHb3R4QlhmNjhqS2dWUnhIMjdw?=
 =?utf-8?B?d2UwekpCUU9ycG00d3o4eGQxQkdrb0szM3hoOTU3M3g1Q0FxU2tlQmZHQXFh?=
 =?utf-8?B?RGc1Qnh6Snh5cUF1T2lENUV4RzhSdGhZZ1l1QVhHOU43RDBHUnQxYzR1SWZP?=
 =?utf-8?B?aDlCVW9VYS9uR2Ira0hmRlFLTFM3Z0JMU3J1UjBJcENzRmx5OHdFSHB6TmpR?=
 =?utf-8?B?aTJkdFpzV0E0NFhBU0pMSlVOUEd5NW9MWDZEek1IemluUnhwZm4waVcydFpW?=
 =?utf-8?B?eXNKVERnL3ZyRmcxYUVyZXFrN0wrck4zZDZFbnJad08vMTdzNWg2UDQyUTFY?=
 =?utf-8?B?ci9uTEVubXZnSVMweGM1Y044ZzdoVEwrRXdZY3NSQ0pzTlZTOUk0U1o5VlE1?=
 =?utf-8?B?STZBcDdBT0tDT1duUkMvdi84dnR0SWliUVVUNnJ4WUYxQlc2VGtXYWQ4ZktC?=
 =?utf-8?B?L3g5RjdhRWZaMVhhWm5qNE5HZ0t4QlBjeDd2UWt1UE1oeTBlWGNKbEszWUha?=
 =?utf-8?B?dXRlZkt5UU4weGovYStaM3htUGQzenpGQndrSVNXbWZNblVEVFRBV3NJOWJM?=
 =?utf-8?B?YVg5eVdsbnVYa2RDY0hlMEIrc1ZtSFk2b0FLSkFvb2VKdDRZZVZBOGZSQ2Z3?=
 =?utf-8?B?N3ZVUC9zcEdXZmFsK1pMajZ4dHJyK01UUkY1Mk9rUzhzSjA1eU51YllYM0Yr?=
 =?utf-8?B?ejVlZW40T3lkeVkyMUlQaDFza2RPR0hqT2dORFl2bWY2SWUrWFp2Q2lxZVhG?=
 =?utf-8?B?MFFrd3BMRnNHNDFwNEgydkJUWERDeHU2RmxSUjZRa08rSnNPRjA4NzhzemlQ?=
 =?utf-8?B?VzJCZFhXQlpleVNzT1Boak9DemdCSFVIdjVvb2JBN0dSakNqVWplK3h1M1lD?=
 =?utf-8?B?alhFcEl4L255SFV0MjJxRlJtVTRGTzE1OHpGRU93QkNhY2FObHEzRFc3WEFs?=
 =?utf-8?B?SnpjMmp1bnJJZXljbFNZS3lIaWh0TW9HamhneEw4Q2FSNDhCVzV4WkNWU2pi?=
 =?utf-8?B?NzFDNUhVZER5SkVJU1h4ZkMyS3lTcDlZZFcya3FvUnZ2R3dRbG00OThQQnpC?=
 =?utf-8?B?WU8wNE5BNzduY3psOWNrRHFjTVZQTy9zY2tUUHd1SVRXQklYYUJUSnRJSlVa?=
 =?utf-8?B?VFZFcDBrRkFHTUdxOEI1WnpHRGJNTm1ESnlCTUJQQ2Z5TmlEV1JTVmlNZmNt?=
 =?utf-8?B?VXEyZVQ1Ym9UbTFYb3BNeXpmUkR1K3Mrd1JWTG92dnorU0hQN3RGQ1lZdXJr?=
 =?utf-8?B?MURHQnRoMXRmK1pBaURXQmJCdU9oS1gxUjFKbmFrd1RqZFY3R2V1SVhzRzZ0?=
 =?utf-8?B?T1YxMGFoajBFMi84QkVhbmxZcWlxUXhxZW1NdUNVejFnYWswVlI2K0lhU1RX?=
 =?utf-8?B?dWxocE41d0M3dm5BRHBvb282NDBtU1pBWFhnZXA5MzdEVlprZWE1b0F1dHNq?=
 =?utf-8?B?NU1mVllNbWZLZVp6OEUvazY4T2Fnd0V0M0YxZWprRjE2a0tON2tKUjcveUpS?=
 =?utf-8?B?a0srM2k0RWZ0dXNSSDRMMVhlM2o0ODArdGtnZS9jZE8xZmVCemtIV0ZjQlpt?=
 =?utf-8?B?UlpSK3JmK05lNTkzcnVOYTJIWEQ2VVQ1TTBmUi9jVWp5VENPdHArcXBUMjlK?=
 =?utf-8?B?Z3BUU3RuT0ZKRjQ5WnZFQWQ5THJyM01vU3FUbzgvMkY0T0F2ZW5tVVlmYnhN?=
 =?utf-8?B?S1p6QUtBeEhnaG1CbWNFbDltZHIvOG43R2d5SXdvVXJPRGpESlFId0hPbWVZ?=
 =?utf-8?B?dHl4ZGMxVHY3V293allNYktuL0lNOFdTOXBZbDlwclVhZU41R2JPN3kwSkVY?=
 =?utf-8?B?OWM1RGt2V1YwcUdGUG9rckxYNGE1Tk53aW5nY1grQXlvTmtWcXcwVEZ5WWVv?=
 =?utf-8?B?RFAvMVFDVEQwc3pocmNNcGNQbnpMMFBUaHpCN1ZwOTJjb29Jc0FwVHZ0SFQ5?=
 =?utf-8?B?WjRPWU1wSkt4RkIrVjdFWndxUldoWi9qRzFmVlVOSTc0QmxjTld2ekJyOHk0?=
 =?utf-8?B?bkN6VC9wRUVYQ1hyNUpGWnhlS2tQREVTK0w4ZFJ4R3orUnNMRkNkZ1JNaEs2?=
 =?utf-8?Q?r2WaZFMz7znueU8SNIL/wAj8b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9322ff5d-b196-47cd-faa4-08dbe033c71f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:21:59.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfdP7B8sHm5bUYtOlAH1YM9sovk4Mji/9YuKo+l0xC5K20eFtkj+LS2S1Wg80cmTGwDpAJgG62zs6Hzq0t3SqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6493


在 2023/11/8 16:14, Yosry Ahmed 写道:
> On Wed, Nov 8, 2023 at 12:11 AM Huang, Ying <ying.huang@intel.com> wrote:
>> Huan Yang <link@vivo.com> writes:
>>
>>> HI Huang, Ying
>>>
>>> Thanks for reply.
>>>
>>> 在 2023/11/8 15:35, Huang, Ying 写道:
>>>> Huan Yang <link@vivo.com> writes:
>>>>
>>>>> In some cases, we need to selectively reclaim file pages or anonymous
>>>>> pages in an unbalanced manner.
>>>>>
>>>>> For example, when an application is pushed to the background and frozen,
>>>>> it may not be opened for a long time, and we can safely reclaim the
>>>>> application's anonymous pages, but we do not want to touch the file pages.
>>>>>
>>>>> This patchset extends the proactive reclaim interface to achieve
>>>>> unbalanced reclamation. Users can control the reclamation tendency by
>>>>> inputting swappiness under the original interface. Specifically, users
>>>>> can input special values to extremely reclaim specific pages.
>>>>   From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
>>>> swappiness.  So you need to add that firstly?
>>> Sorry for this mistake, we always work on cgroupv1, so, not notice
>>> this commit 4550c4e, thank your for point that.
>>>
>>> I see this commit comment that `that's a different discussion`, but,
>>> to implements this, I will try add.
>>>
>>>>> Example:
>>>>>      echo "1G" 200 > memory.reclaim (only reclaim anon)
>>>>>        echo "1G" 0  > memory.reclaim (only reclaim file)
>>>>>        echo "1G" 1  > memory.reclaim (only reclaim file)
>>>>>
>>>>> Note that when performing unbalanced reclamation, the cgroup swappiness
>>>>> will be temporarily adjusted dynamically to the input value. Therefore,
>>>>> if the cgroup swappiness is further modified during runtime, there may
>>>>> be some errors.
>>>> If cgroup swappiness will be adjusted temporarily, why not just change
>>>> it via a script before/after proactive reclaiming?
>>> IMO, this unbalance reclaim only takes effect for a single command,
>>> so if it is pre-set using a script, the judgment of the reclamation tendency
>>> may become complicated.
>> If swappiness == 0, then we will only reclaim file pages.  If swappiness
>> == 200, then we may still reclaim file pages.  So you need a way to
>> reclaim only anon pages?
>>
>> If so, can we use some special swappiness value to specify that?  I
>> don't know whether use 200 will cause regression.  If so, we may need
>> some other value, e.g. >= 65536.
> I don't think swappiness is the answer here. This has been discussed a
> while back, please see my response. As you mentioned, swappiness may
> be ignored by the kernel in some cases, and its behavior has
> historically changed before.

For type base, reclaim can have direct tendencies as well. It's good. 
But, what if
we only want to make small adjustments to the reclamation ratio?
Of course, sometimes swappiness may become ineffective.


