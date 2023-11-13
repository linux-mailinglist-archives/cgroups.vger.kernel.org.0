Return-Path: <cgroups+bounces-348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C327E96AB
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 07:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B2F280CFD
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF511C9E;
	Mon, 13 Nov 2023 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="puxD+bfO"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA611C9F;
	Mon, 13 Nov 2023 06:28:40 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E75171C;
	Sun, 12 Nov 2023 22:28:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdnEfpTRhkaddEpPaetAt/JnccEkcnQ/+54kuUcwgSdCTI4N6zXNsNybg95Oz5GSSgfHNWL6Mozw6UiUz1G2L/BdfqPFc7/XaPtD7BlWW6Zc3b1DktESYRSjHmHDO/9yCK20YeT1+OmcnE3oQaLCECyBvAEWqfYsWRr5MN0roEH/igAt9YzAf+NqdE1mecsphuYo++7FUgiQSuzvk+BJhO5EpH/kZSuUUtSRGOWPQ/C6Y2t5YcSe40sCVOSoVADGmowQxoSnjhZ3yzsM8hi0RjBUXTETm2ahuEclFEmAsN/m8kM48hPIUzsKoIw1fHUeVM7r0v2FBLzt5tGwqgcalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7QQFe5vrd4ILqiIztf9ZcYbvAhlylWx2x6BBzRKP/E=;
 b=D79c0k8Y0nvRNG4tlRTT1VloP33QZ9uP1FbeGbLQUeoKAb5FRgpiDxKLX3FNIyPP7ChpWgM0UqDrEU+MeOUDLV8Zx9raiuF1+2MJ2Ml69fY/4DELACdEUkEIszirMl9UM4S5culwPhaWlZBI48uQ33L8W1LfLm/U8dpjgkB9sVTxZa17igccMeg4FklDUoWqN9ht7F32lkmD7SFpPedgVDK5dj5ugx9kNdsCoEza9w496ofbpp5Rr4WCQ0aqcQIOEBjYUR0A1pxHeE5Xvm3gQYpCWvne8MyK3CMBUtju4138SDih60Fta+tnr7fG4ZGgcGCm3TIksBzvW4Zpi7i/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7QQFe5vrd4ILqiIztf9ZcYbvAhlylWx2x6BBzRKP/E=;
 b=puxD+bfO5X6fW0WvQF6SRxiA2Yk/KBzjMt64nycD8lV6GmgiyBAsvbQ8uA8dFWYIOAXMZZKj7vMvQtuubuu0fFVKr9h6IGGTa2UdO6ohU94JbK4qAIY69QH/qGpNYCLxnll+BmgQN6B+xXmSDnt5AXLj7l/QO4fpkUNQ8BVY2fDaBvF/s4t3HPrdWhDHl9ZZVF22zC0mzXR/fhDbLEzrL+zUATfKSct/KWUazxqvmGUxRNK21e+s/WjDI1SqpwqUmWaL/mfPdT55pbUO6KgMeF1JMGjMonhFDeVNfh1mYFefZFDFy2r3JDpcnqWr6XAd5ACsIt6eJf+dFTaGD3uKwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6374.apcprd06.prod.outlook.com (2603:1096:101:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.33; Mon, 13 Nov
 2023 06:28:28 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 06:28:27 +0000
Message-ID: <a09e21a6-6a1e-44ec-9187-600a0a969a45@vivo.com>
Date: Mon, 13 Nov 2023 14:28:20 +0800
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
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com> <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com> <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com> <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com> <ZUziy-6QPdTIDJlm@tiehlicka>
 <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com> <ZU4g9XZvi9mRQD27@tiehlicka>
 <b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
 <87edgufakm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <87edgufakm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 9952865d-48b5-4eb5-8daa-08dbe411be83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ojmvWUe3njogcaidmDpFr5PMs4TO2tByCKgFD3URM4+/Mdr6us5vEZM1UZG9lLgMQSFH08kB4qkiRbm2RR1Gbpnyj0ivzGshbjSEIOkDOHJ25eRxtfU9f5XLnLPPK0x88ss6+QGx+/GdMGB5zghYrMeMIXNktQQRvXS8xKvPDQ4Rkt2gzJ3dI3jcGgG+hgYzjRVI9hT4E28mb+W/L38Vur66MP+iu+TPgm9yRpLdp674X4NMKtKqZTEVClKL5WXG334gGdJAYEM6d5AAS/fNnk23zO8VCZUGE+1aRz3SHVx51YrpnUCVL4dv8fuNKJoYCHRELlh5SNAvydZJGosM0f268+8opeZe5vnfR+GZkVqeifY2NEf20Iz8XRR8pqHsSTnwrN9YFNAS5MpjvWsOWsJWin48BZi4D9R5veiTobnpvifN7jwXtm8HHCeO56lpUR21EG7Vp/b/8a2ptKgZW4oz9XTJqXmPtIQfe4/dUYjf8ShbJTc/eakjfZaDGY3S16xQvftusUdOtvLHM+ih06Up/UkHVhXeDL+Mn+0dmFD851BbDEno55hsV1OS18+HjEU9FcGTmjAN8NkaL1O28rs9zNP57GN2TfSMnwBLcR03pJiEuYxoSWwIYF6MgMDLzDS9Kx+xJKIIQRu/rQSfe9WE1S0FhCDK9siALPwGSLuvBPtUWohdokji8ajw4QqZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(36756003)(38350700005)(86362001)(31696002)(2616005)(26005)(2906002)(52116002)(6512007)(6666004)(6506007)(66946007)(66476007)(66556008)(5660300002)(83380400001)(107886003)(7416002)(41300700001)(478600001)(31686004)(6486002)(8936002)(8676002)(4326008)(316002)(54906003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3pOSEFjdGxOaWFGaFBtWWhxblUvY05jVlFaWnBRNldSanl3ZXkvdTRwRjYr?=
 =?utf-8?B?RFMrQy9HM25TZVVFZjNWZ2ZjcUhzSEV1R3llWFdjOVR3SXZyMjJuU2twdkx6?=
 =?utf-8?B?U3BiNjdpbTJaTlN6K0laME1oUUcwL1VVdmlaSjFOclJ2UUI0MW5BTTJjaW02?=
 =?utf-8?B?aVQ0TnNidnd1czYraURBdGRSRndzMEhudmNYOHd1UlVjc2RIcUlSZzZxc0xM?=
 =?utf-8?B?MnRFb0NUVHdndlJNbnk2TnBDN2ZpYUFXZVJRaHk2QTEzdjJpY3hRMTZuWXdS?=
 =?utf-8?B?cmVIcHNObXRreEl4SVJnVGlIWHNLbWxPR2RCZnhpSVNvV2MzYjR6U2FMVTZG?=
 =?utf-8?B?aVU1ZW5uUjhLRzJZS21LekJ6Mlp2Rml5R3o5WXVxYVBrdDZ6UU84S0NFLzd1?=
 =?utf-8?B?ajhjV1A5VzZrZllYTFRVem5OdGd6MzMvdTNhdFRtc2VxL00ycmJBSkU2dkJD?=
 =?utf-8?B?ZU5SeXdHSGU0V2kzamVnREE5aGlWN2NmVnRGSnRzQ3J2NU1ibWtucFVCa21w?=
 =?utf-8?B?OHZXeUM4YS95VEJrMDR1cDJLZnE4NXlZdS9jbzYwdnFKZkZKUlVLWXZiMlJ5?=
 =?utf-8?B?Z1FGazJBYlZ3aXBXL1lvTnNNdFZhOURQQk1uQU1Pdi8yWlliVml4cXRUWE1I?=
 =?utf-8?B?OHlxL1NLRWU2bzMxdmJsVmVvSzNQRXB0UCtYZGdzOTFDRmpJUTh3aUJIOXBV?=
 =?utf-8?B?K0FaNEtkeVpYeWpmeFEvZW9zT2dqa1JYWVFLV2lkUldDdzFndlgzWlRaZmRM?=
 =?utf-8?B?c2ROdFN1bHJocEw4VTVObW9Ma3czNEVaQXJVRUw0WGRBWUJNcUwxOGRKYjFl?=
 =?utf-8?B?WlpYTnp5MDRrOHZKLzA3MU42V0ZOT0dlLy9OUUZ4RE9jdlhaMWxNbHBPZDJz?=
 =?utf-8?B?Q0p2V3NySkhMMGYxelpkVG5td1Z1Mm9BVzRuTThLYThzY25VWm9JbXBoa2ZS?=
 =?utf-8?B?dkMrMTBlL0dVaWxvRHljT2lQQVh4Uk1OeitCT2EvL1JPZC9TdXBiRktobmc0?=
 =?utf-8?B?cVJ4UENaMnl6a0tieFQyS0I4Nkh3MXl5Wkdyc0xUSmtGYnhYOTI5TG9ZVTk4?=
 =?utf-8?B?Tm9UMW81UW13Ym02UDRteFVBZk9rVHNOcDFMdUhMazllNjJNQXlmZlRRVXEz?=
 =?utf-8?B?bzlPTUs5YWJXUUQ0ckNJTy9RUXF0R0ZFZnNJRERLdmsvQW8zeWE2ZUxYeXJR?=
 =?utf-8?B?UjA1TEI3Vjh4eGp2NkJPanR3Uk56RkdBNDVLQ2UrckpsKzBFYTA0N2V6WGpz?=
 =?utf-8?B?RDFtVzdaZE4zMmlKcmlCNWxOVmwzWTdwZFYrSkMwZ21aNFlHY0ZJVFpWWElq?=
 =?utf-8?B?SGZIaFdYdWltd3g1Q2hFaWRCWUovT3NqZldBY0ZzVVF3UjZnVnpMN2tVSEFJ?=
 =?utf-8?B?RHg3TWlXRE90QllrSGxpMkM5bDFNc2RHMFdDRlptcDFzY2JCeFFyQkkxelRE?=
 =?utf-8?B?Z1paSm4zanNMa0h4Q09aTnRncktubHFCN05CZElNR3BNWkNwK3NPeE56R3Yz?=
 =?utf-8?B?ZkJ0bkxLSjBYbVpjUnJIU29ubnI0QjlvNitYN2xNdmN6K2pLTE9BYklRUUt1?=
 =?utf-8?B?SlAvUHRoWkpUQVFEUnFVMUVTL1pNMjhxNFFrczhKU1RUUzZnUEpPYWFpZ3VU?=
 =?utf-8?B?bS93d2pBRmZQOXF0NmRQbHd3N1lPT0NmZHdGMFp1ZDVMV0xVTHlrZWFyZUor?=
 =?utf-8?B?ZFMvNFFIZmgrcG10U0JUVWdTKzBaejhneFlyNW10aVhIRTE1U2xOc0pnRkpQ?=
 =?utf-8?B?Zm9YMEhpRklpWnJUTkw0ZzgxL1I3UnByckVwek1KeEtxSWwxd3BwTnQ5M0h6?=
 =?utf-8?B?a1E4eUMzcU1oV2JOaTRtcWJuTmtBY3loVTc4cXFlZFVKd1BOZ2E4OXZERVBo?=
 =?utf-8?B?NDVMOWt3Z3hrTG91eEFwSFkrRUw5dDY2K29YS1pKaFM3WEFCTVIza0g2c0xY?=
 =?utf-8?B?L0plSkNrLzcyUGlrc0FBaXpBSGU4RE83VTlvNlhTOFFMWTNEclBBN2N1Wk8r?=
 =?utf-8?B?SjVWN2ZzYlhGSHM1aWlJTzZXV2QzdTZOVmZxY3E3dHBkZG45ZmJPN29POHJ2?=
 =?utf-8?B?dm5WTGFhQVVBdVgxZkkyY25VOGlYM2V5STdwNGM2eWFXOExSZ0pscERUd0pl?=
 =?utf-8?Q?ME+XGqEwhNYJLN94mqz0NSwF7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9952865d-48b5-4eb5-8daa-08dbe411be83
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 06:28:26.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5y/l4MShrA0OW58SkQDhj7bFMMBwsUaz0oD62Bc81mypWfeWmYs/uZ/6QaIDGR/Zgo/NCWSKjJFAzJiuAbYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6374


在 2023/11/13 14:10, Huang, Ying 写道:
> Huan Yang <link@vivo.com> writes:
>
>> 在 2023/11/10 20:24, Michal Hocko 写道:
>>> On Fri 10-11-23 11:48:49, Huan Yang wrote:
>>> [...]
>>>> Also, When the application enters the foreground, the startup speed
>>>> may be slower. Also trace show that here are a lot of block I/O.
>>>> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
>>>> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
>>>> 995.109MB/s), usually, it is faster than random disk reads.(read:
>>>> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
>>>> little to test UFS.
>>>>
>>>> Therefore, if the proactive reclamation encounters many file pages,
>>>> the application may become slow when it is opened.
>>> OK, this is an interesting information. From the above it seems that
>>> storage based IO refaults are order of magnitude more expensive than
>>> swap (zram in this case). That means that the memory reclaim should
>>> _in general_ prefer anonymous memory reclaim over refaulted page cache,
>>> right? Or is there any reason why "frozen" applications are any
>>> different in this case?
>> Frozen applications mean that the application process is no longer active,
>> so once its private anonymous page data is swapped out, the anonymous
>> pages will not be refaulted until the application becomes active again.
>>
>> On the contrary, page caches are usually shared. Even if the
>> application that
>> first read the file is no longer active, other processes may still
>> read the file.
>> Therefore, it is not reasonable to use the proactive reclamation
>> interface to
>> reclaim page caches without considering memory pressure.
> No.  Not all page caches are shared.  For example, the page caches used
> for use-once streaming IO.  And, they should be reclaimed firstly.
Yes, but this part is done very well in MGLRU and does not require our 
intervention.
Moreover, the reclaim speed of clean files is very fast, but compared to it,
the reclaim speed of anonymous pages is a bit slower.
>
> So, your solution may work good for your specific use cases, but it's
Yes, this approach is not universal.
> not a general solution.  Per my understanding, you want to reclaim only
> private pages to avoid impact the performance of other applications.
> Privately mapped anonymous pages is easy to be identified (And I suggest
> that you can find a way to avoid reclaim shared mapped anonymous pages).
Yes, it is not good to reclaim shared anonymous pages, and it needs to be
identified. In the future, we will consider how to filter them.
Thanks.
> There's some heuristics to identify use-once page caches in reclaiming
> code.  Why doesn't it work for your situation?
As mentioned above, the default reclaim algorithm is suitable for recycling
file pages, but we do not need to intervene in it.
Direct reclaim or kswapd of these use-once file pages is very fast and will
not cause lag or other effects.
Our overall goal is to actively and reasonably compress unused anonymous
pages based on certain strategies, in order to increase available memory to
a certain extent, avoid lag, and prevent applications from being killed.
Therefore, using the proactive reclaim interface, combined with LRU 
algorithm
and reclaim tendencies, is a good way to achieve our goal.
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

-- 
Thanks,
Huan Yang


