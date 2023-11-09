Return-Path: <cgroups+bounces-273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E523A7E680C
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 11:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DBB1C20BFA
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65B19444;
	Thu,  9 Nov 2023 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hLc2bbOX"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81819440;
	Thu,  9 Nov 2023 10:29:16 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA0211B;
	Thu,  9 Nov 2023 02:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCo2HXlIdwqrnS0lX9N3AjBH/dP0kCCJpX6P5rCSZvyeEv4YJ4eAJfMtMkJLdzzJDQhObWRoYm7zlk6cL9j5WIEROg9H7a4IKPJNYW6BHsCGXt8tuXpYqJIflKA4kdDaZ8K9arzQPyA/m7A13vNkagcb9Yz4Dvsn9SBjx+SkPJdBtd1sbeKOg824Ilwefz/9ee1f1emhYLRLmf/KAdZuyp4i7K8FXcNTiKFlvAUsKFyg+2Au5vLPZR7KWgEuJ3Al/9VpB5KSDRbgyMDXhQW8ttSYX6mjsI+xCDVlR7YvEAMGFZIvSaaC9L3+HqiQDWJpO2IkTdhUi1kblc0xKTlLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSanx7W9mTvVPsLgv8lByKhvIyXI6aZ6s9A1fZYXKBs=;
 b=jFJNyzycmQuntJGwUMxCNPwk7yxPDWfDtDeFGMRT5TSeGv7B8lagwxL9RHjs9ZjrhoJrPadH/WwytZK0jO3Vyr1vTy0PbE1psQz6GYeM4UX+ip9xeqiQq/W7bXflkJk62kI2imKPlUDsczS118O5vK5Ct9xjMTpqHU93N5p+oeXpabEL5SXcUjXUus3rLgWGCuReRn91aBm6lX+cRHvbm2qW2b3zC5qB1XBdcKDDqHbeDVAox0FGok6asZD+2fad0XpMKtWBj6zpMXXJw3LlRpIuUxaXHemhjeoIbaSX9QrhodP6JTt/ybnA7rPT741TxUjhJJwllCeo8+1eXxVAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSanx7W9mTvVPsLgv8lByKhvIyXI6aZ6s9A1fZYXKBs=;
 b=hLc2bbOX7+O6J2JwKAVgh/6xX91Jxp54iLNgKPxFeHqRamQg/OJJ1Dds3wzgBs7PoniAxmIwKy5HBG9OKFiNfPcLI1hQfJx+Nkubbntxf4KKKKOa7EmxrDY3gTzfUZKBm2DL3Mv8CrovomlrkoEBMibo+2EvcD667GrNwlEl2jJBtCPX57rRV5Tft/p9+eUY09FePbtVI2zp3yUcrJW+FIN0CNE39A8pKVvViM5GTLTgUDZCvD5tQBSr8r8Mxy5+lTrdW5VxNmTeoTtxpLPcYpYY1NvFOqxB2MyKgtAghComq3+rzqXMdqP8CalY4ZTnIYGqTyimd6KxGM1jgoNS1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5964.apcprd06.prod.outlook.com (2603:1096:101:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 10:29:11 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 10:29:10 +0000
Message-ID: <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
Date: Thu, 9 Nov 2023 18:29:03 +0800
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
From: Huan Yang <link@vivo.com>
In-Reply-To: <ZUytB5lSwxeKkBW8@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 8597fe95-6a8d-4f5a-b9ea-08dbe10eb5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	24SnC/5Z2AiYy9/sdFDiil0U9AubRyuBN62nTsiMc86RjXrTA4QU76It+ptEGP2kCwzRleXGuUamtOs2IOIhFL9cW4dFF0QKHwK6bDOclVM/IOOLWPLi8msaRQA16bQUPquKGaMuggI4ew/qZfSbeqn+MJPVDoRA3bDGjY6vFL3kCs0RvYrX28sIVQAeVLpbc06xvG8PTEqOimgyJCjsatwtJjtfu1/igmvhN+/4P2fxg5572AqIlUXBMqJNJPXmvITsMLuzX5/S5W9ydbEZPFqFHkTvqVeV4iDOldJTCzs7Zr5a+7WqtWDdF4qQGVdKn9TZDaB2jF7dePn1GKjP/L40SSWDBL69Qpd91FZYV/eFabwAeYZaOLFWSY+C/UHsYEKhqURRMBNCl7TKpX2A/0SxZi1jYzXruB/ayEQgWQ/VK5FSw7V8O5o2NkI8LrFBuDITSTGSRPUogVOWG2+BOsZBOtRmPPmGSG/gWI2qRejVjLzPFiJxfAcyBGLHTtWEuje+Bjfbo9y6hbuREqS74T6fmK9kjIX96undQBurnz8Yeb4HdQVjQRxZfxiLEBWA0ktAaOF0mVBEep/QQi7hHjj21KCarYhr+yZjzN7DUoYJ6NAkyQdlR0DJXYQV60IlcrcsDb5eC5EZ9PMVvba6QnbtZk+DqXTDgsZQLQqgjku9BBvUO+v7Erh0g31XoZMFTAshvuCWOqhXdmPH/KFlQQvNrgK34KMfLklyKS97NUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(6486002)(966005)(6512007)(6506007)(52116002)(478600001)(8676002)(4326008)(8936002)(31686004)(2906002)(7416002)(36756003)(38100700002)(31696002)(86362001)(5660300002)(66946007)(6916009)(66556008)(66476007)(54906003)(316002)(83380400001)(107886003)(38350700005)(26005)(2616005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVdsU01lMFhJUnJFRE1IUndpNlFFQUFoQm5XeHZCNkdLdzJKdUdBeXdYZCto?=
 =?utf-8?B?Mm1nNWp6ai9QTzhtb0hiN1NjWUZmSDJCK1lJSnFiMitTbyt3QXQ5Wlc1Nnlv?=
 =?utf-8?B?dWpaWm41RUlRV0hBSkFXVS9uN1o5MG1XYzFjQ3BxcHNNbXhWdTRQMEdELzdw?=
 =?utf-8?B?cktZTWl2ZW9meUJDcksxWkgzeFEvL1JKRzh1OHFQMnZEMHl6NFhLRnBXa0ZZ?=
 =?utf-8?B?NTBQNkRpcWZZOHhCS3lZMG80Sm1OellVdVk1MjFqMVowcGVwNlNZZzkrM1hV?=
 =?utf-8?B?Qm00NFkvTXE2MU5NZm1lclJ5NEpjbGZnN3JWM1FINGoxSVlQL0xRTC9zY3lG?=
 =?utf-8?B?T1JrODBCZ0JJTW50UlNBZzdURDZ5MjhkNjdIMURXOTVETCtCN1lpelBPZUdO?=
 =?utf-8?B?SkhuZ0tINTNnOGdLdFhwMnNFSmwyc0RTcGMvZlhyUUUyUDdyQWVkVEpxamhm?=
 =?utf-8?B?c0FHSjZwbyt2aGV0clJEdTZvUjhNdnNQVllnOHRpZkt2aG1XcWU2aUdXMGJu?=
 =?utf-8?B?aWg4NitKcVF1bktScm9WY09IaGp6bkhIRmZvMFBJSGlXR05iQmwvUjczckNi?=
 =?utf-8?B?TmpqaldwODVZdE9OVUlKSFRXRU55WlhHc0MzL2FyOXJSeTNyYlo2eTBNbzJm?=
 =?utf-8?B?WWZBSCs2MDROK1IyWEJoZlJ4dzJjdTYrQk5uUC9qQzU4c1pkSjdIK2dkRFR4?=
 =?utf-8?B?U3ZSSGkzb09CYXFwR2ZTUWE3ZUxzRnBTT2pGWFZXRjJycmRYclE3R1pKSjJN?=
 =?utf-8?B?RDU1WEdzMXdkYXd4V3BueGdrYmh4bm9MZzJUYUdiNlpqRDNsS2ZNZUNWbER4?=
 =?utf-8?B?ZmRqNzR1OHdWT1AvMlVtRmN1c1pnaG5LZm00Um1uZmZsN3hqN2ZNT01mLzFI?=
 =?utf-8?B?SHdhNXhhTndJMm15M0Y4MWNaS2xwamR5b09ZTGJWdlpFUTZuY2x1ejB6ckli?=
 =?utf-8?B?R3U5OEFWaUxobnBPR3F5VFFaR3EzVWc1MWx2SStGajRtWXRSWHI2dWFYajZG?=
 =?utf-8?B?dmE2a0NMT1FzMkpNQWFoK1d5NGl2UDh1YWloWHkxbGlVVUExL3BXRWpGK2o4?=
 =?utf-8?B?Zyt2dkROdHgxdnVXVHgyVnlMVVpiZCtZcGxzaWhZaS8yYjZNYTZPOGRqN05G?=
 =?utf-8?B?ZjJkQXFCbE42djA2QkV4c0FXSlpQWEhlMGh1Z0pFN2Jsem4yNXNoYkx5TEFt?=
 =?utf-8?B?TEZBWk5IWkFWaUFyR09RWDhEam4rN1I1bWNid1QrNURTTkhVNGxqMXFnV2ll?=
 =?utf-8?B?MHcyVmpyVGRZeFUvZ3RKVERVcktpOWtuRzY5ZW5WenBMUlZoVFFsbExHQVFX?=
 =?utf-8?B?UURwaWZPWnpkdTFIeTcyZGdEZjY0UTg2eVJ0NzRBSnRCSTVwd2hOam0vNlZw?=
 =?utf-8?B?SjVrdGpEVVp0UGlNTnVERVpRTHNFWDhpQ1NSeUdMUVJUSXk5Mjg2N1FyRWZP?=
 =?utf-8?B?WTd1cnh0cFE3ZS9EUjdMV05GSUJxOFB5c1o0Um5SL21FeVVpVWpwVjUvbG96?=
 =?utf-8?B?MEU4UC9pV1V4NEdGOXJZR2RoRkt5eFdBYklCZkpBVVFuN2lWWXVxT1lXV25D?=
 =?utf-8?B?ZkIyUS80aDNEc01MK2FHRHVPamw4dDBuOG1GcE1ubTIxRDNRMTJpK1B5N2Q0?=
 =?utf-8?B?MWNDcXB6RENqbEV4ZFgxRVFhOHphaUtzS2xEdGRZYWNKSkIyNk9lSEhOTlgy?=
 =?utf-8?B?TVJNNzlDNHVuRnNTd3FQV2pUWlBGeTRJRFZQNEpSb0UwM1EzWG5VTEk4WURs?=
 =?utf-8?B?ckl0LzRuT3NQdGFhVWZrdXBwKzFLOGIyU2VvTTZyOWIvajNMd0pTL0NsdERP?=
 =?utf-8?B?S1BxVXFJNHZ0bVZBcm1lR3F3a0NpbVBqM3R2dUNKU3dpbmNCWFZVUDM2VWht?=
 =?utf-8?B?NWYyMXVnM052S21NUHFtNmFtTVJXYTdIdXZMWUc2MWxoRzYxSm1TSkN4bCs4?=
 =?utf-8?B?anF2TFlkT3IyR3I2Z3g0c3piUnZWczkxM3o3czhiTlFkSHRXcWlycjc1ZXFj?=
 =?utf-8?B?OFJsK1JaRnlXVVErOGpFZ210VUNHYk9zN0s0SWFoWUl1Z2p0MlJSQUNBMHpR?=
 =?utf-8?B?ZFNKV0hDMHRDaDFBTGd6YzRmcXF5dk5WbUc1dTFyNG1WNitLSWNlY0Qva2FJ?=
 =?utf-8?Q?A3YidtHwtNINqGD3ZyAcQOSjg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597fe95-6a8d-4f5a-b9ea-08dbe10eb5fc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 10:29:10.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKxfl+smvP7jSa8puL1O8H2QDdv6rnR0P9QuJAOU2I99JRXuRcQMKyF7wWx5COFVyUoMpjyV+eGs0HDy03bUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5964

HI Michal Hocko,

Thanks for your suggestion.

在 2023/11/9 17:57, Michal Hocko 写道:
> [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu 09-11-23 11:38:56, Huan Yang wrote:
> [...]
>>> If so, is it better only to reclaim private anonymous pages explicitly?
>> Yes, in practice, we only proactively compress anonymous pages and do not
>> want to touch file pages.
> If that is the case and this is mostly application centric (which you
> seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
> instead.
Madvise  may not be applicable in this scenario.(IMO)

This feature is aimed at a core goal, which is to compress the anonymous 
pages
of frozen applications.

How to detect that an application is frozen and determine which pages can be
safely reclaimed is the responsibility of the policy part.

Setting madvise for an application is an active behavior, while the 
above policy
is a passive approach.(If I misunderstood, please let me know if there 
is a better
way to set madvise.)
> --
> Michal Hocko
> SUSE Labs

-- 
Thanks,
Huan Yang


