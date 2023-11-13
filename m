Return-Path: <cgroups+bounces-350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD77E97A0
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 09:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E3E1C208C2
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5F15AE3;
	Mon, 13 Nov 2023 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FcrBDDGD"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB20125DE;
	Mon, 13 Nov 2023 08:26:14 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425CA10F0;
	Mon, 13 Nov 2023 00:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYLZCEVGxIdtb8s1S5JJNmmWXa7ErpUfGGnWZpgJW3nLmqRpDG4y0IfOrfwjdI7uaCsKwgQy4NfE4yPy7ia2SZqXGcxhTmIcXJzJYg4yelcloW8ZtV20sn3v9nHTyWJKhhSsGwovJMt8gh7XZ/o5xGAoWUea9Q2j6Gf4iUN0sq6Zk8JRisb0YKE6y65152cwL378/yVDut/6Vcpto83TW8mEfMXMND6xXPy5KEhMo3zhAE88CBGV8OI4PvHIjTYBAAuFD4Fc7GFMPOPJdQ+QNwP/D0C42s55qHQENweOZib+oaAOGP5qM4KtO+rNYVLkErBoMBdcZFQyApTLmhR9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+ocdH2h34/lEJQHaQ6iBb11BLAxuWRG/Cb2ORL93FQ=;
 b=YyF/ymAihCua8FLeHTXi7pE+YMQ/7Xhx+9vclBIVYCPyMJTzptAGH/xFR96yc0PqGj3IaHMKiVF6uXmsFyKPZPaA8Cy0wM5GF5JKnPHUECKZvsRtwM9b/9Z0wLPvBi1y1uD9n2BJ1E9ls6L2pTRxQbkQAT0+yUfRhxJBUgsPvAmRFnr2krO6uzFzz+6bpYdsYg4xVxb9LEwWe4rISsv4PpsTkDlHHdfzG3zX3n+gi3GiTuE+jFXdEZYRRc83JCh/LmKpOW/zYzrAKsM7cTbuydW+7XNS1aDGW7LCcgHpzyJxN3T8mqF/HXmagSMlkunRVPkfifibDmKoQfv9zg1xwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+ocdH2h34/lEJQHaQ6iBb11BLAxuWRG/Cb2ORL93FQ=;
 b=FcrBDDGDRbfoEg3xLQKciiAMcADVrvDeyELaCYnIH4C9D+j+j7qtnzt9ynl5kLtdh5pAT0RJfUttxpppnaJ+Fb38Ps3A87nOmruSSZNIiscQ4Wtb5bCB414RKJMvVbwaYjnADKR008giMLeR9KuJnUK9gwV5Fcv4wR3VcOV4FIbp/lYNCNObw9tOdCxbE/lEIKbIOszLer5YmD91/pFyNvqslmLizsCBWMLrx5jkur/SevOVQjZcvRepdPgZ9dUVK6FA0hYKSB3BQ3Xi2g6k8Q9xnU5BGcWVPjD1IbyKW8QECCKDjzKMKB7FLCtVe0NruHngQiQwD7O1RltsaEThQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 13 Nov
 2023 08:26:07 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 08:26:07 +0000
Message-ID: <97a3dbb3-9e73-4dcc-877d-f491ff47363b@vivo.com>
Date: Mon, 13 Nov 2023 16:26:00 +0800
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
 <a09e21a6-6a1e-44ec-9187-600a0a969a45@vivo.com>
 <87a5rif58s.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <87a5rif58s.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYUPR06MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7806f315-3d06-41de-5fc2-08dbe4222e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fWvy8nLttpu1N2wPfmCyLD01++XJ0FXelCiBygeMPmBAuKaOLxY0fS5SToTE9iFjrj2KP8Lc+OveLT3T69/egMZUb7U97Jb7b2B82YMtsHu4CMSXFQ1fkAgL4mWMKuG6auT9On1kTY49gj5jSLHm/mtKDnn2L7jlNhLjVKA+NdDgXLiJwn0nxFnLFcSv1WDm/by4TKz4fdCB2O6apmlze9G8B8lp/7fnSaDfP1b2sX28RtXLV/BHewWqwvOIQpxn9VtaSsulZ3LO/6UwyejhGbUZf9rdAxKlKzBEY75ekYiNLFBaUUOT0hdThOUv4ZqX59I+bEdVUKfC2NzsxYsgAy/oZgqqyakCg45K2eqoXAetOwXLNeQspbAXvy7tSReAPKth3jVivSyrzDrBkBgXczFuQGw4kzOeyJykb5a6jRRKrdsBH3u8IE0T88laq5GJOpNm5Ivh1p6SVsCya4X7sT25YzMbClp4+ERJIc29Pj9AmqZFXtHFIqlzBr6tMHTjrLZQO+XksqiFPG0sbpzBxLOhQpUCjw9y0REFqzC5uoPlncTZbWYXyoOs9bKm82SgwCIDdySjZvon563ATD2zZ4WFo/oJ/AgcSj4VhUcqsOG4bZ0Wa2eKLskXlHqQtJ/giiaqGlyd9ruthW9mmV6FxTPGpSUUL/cbG+0RTGnsg5J9l7S0y1sN7hEn74Z6vcx9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(5660300002)(7416002)(38100700002)(8676002)(4326008)(8936002)(31696002)(86362001)(41300700001)(2906002)(107886003)(6506007)(6512007)(52116002)(6666004)(83380400001)(26005)(31686004)(38350700005)(36756003)(2616005)(54906003)(316002)(66476007)(66556008)(6916009)(478600001)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellrTENpYVB2MFFTelZOWVNkK0ZZbjlUbFRrMWhZM2Q4bEZXZEpUREdhVUVi?=
 =?utf-8?B?N1JDdUdLTnJWODltQ0RPRytaZktlcDM0dHdZa2ZyQjVudnBUSys5bVJValV6?=
 =?utf-8?B?Z0UvaUpCaHVCTUJ2RURNcTlzM2xwYU5uTkJtMHpRbUNncVRSZjUwZFVvdFlv?=
 =?utf-8?B?VzQwdjhIUnQxdndzSm11UEU5ZWg3TXFpRVBUZlVSWURWdUhHYjNIRlNJRmxQ?=
 =?utf-8?B?MlJQczBKb2FuM2o3c096aURFWkxLdjczNUhpVjVCalZqN29QV0V5V29oenhh?=
 =?utf-8?B?TTZRc2o0WVhjSUJVWkVhSHZQeFI5d3pnQW5sS1R5U09uQUZhSTNEMXNuRUlj?=
 =?utf-8?B?TU5qOHdmVEJmV0pTSEowVjBRMDYzMGNjLzBlc0FpMkZna1pTVXJCMWJYczND?=
 =?utf-8?B?UjhnWUgxU0ZBU0dxNTRMTzc3eXhSRjl1QmFDOWhUaDhPczdVZ1VXd1IwajdW?=
 =?utf-8?B?RU5kTFk2QVR2NnlzeEdnSU82ZGdOcnhqRTcyamtGc1YzWXozRjRkc1NFZkJp?=
 =?utf-8?B?dWRpaWRKRG9ZUTJJaHdkdDFWK2ZuTlRYdDg5bkEycEs2L1NEbU5jMFYwK1Va?=
 =?utf-8?B?QkI0ZnduR2RYNklncmJpZWtUQnJhWmZ4MWhaRW91WG5FUzIweEQrTGpFOUpx?=
 =?utf-8?B?cnJ6V1h5Tmd5blBiakRnTHZTaisvZWorbjcwUnFoOHI1aDFEUHcwOHkyOVVr?=
 =?utf-8?B?amVQamJRRm4xNFlTb3pGVGtXSFUzanJ1a1BxVmJJOTlmbEtYQXk2SEtyRnh5?=
 =?utf-8?B?TFZvSVZHL1NCZlVoK05ZSWpiL1cyb2M1V3J4M09WQmNQRGJXaGhoMFE5eGhj?=
 =?utf-8?B?a1BPS20yb2J1RGxSaGVIcVhYS1VHeDVHV0hhUlQ3R1ptMHJvT1JLWHJBaFFE?=
 =?utf-8?B?Q3dGcEpmSU5PWXhnbUloY25jazM2cW9sWjdkZDJWcEhnZDVwM0owMWVtcUVP?=
 =?utf-8?B?SDE3alpBTzhuN2lEbjhXVWRtZmQ1NkRiN0gxVGFvYVZHZGVKNWFPSlFvcmNC?=
 =?utf-8?B?QlMxeGpZVE56b3NmYjQ5M01qMm1tTmRoSUJrTEVOd2oxanRCRG9RM0ZIcThi?=
 =?utf-8?B?S205TXJLenkvVXJ6ekpDVlRVUlcvY013S2NZTDdNdGNPRjF2U3FBMXZ2anVa?=
 =?utf-8?B?RFFuNVdLWFVCNTBubFlmc2Z6UURSSGxndkJsYW83cXlTUVREWWdHY01zbGFU?=
 =?utf-8?B?Z0t5ZVF3dUxMdDNhekdOZkVDc3lkZWhiSDYxb0c5UXZDdHBXQWRnaDNUY0hN?=
 =?utf-8?B?Nyt3RGYrYXQ5cUF0Z1hDRnNaYjJ6RmgrRmZXVFgrWG45WUxTOUp6MTdJU1lW?=
 =?utf-8?B?TWJoNHUrZmQyb05GaHM4WFlKSWZBaGlaWjRhbXQ4emNidVZiS3JrZkE1d2ht?=
 =?utf-8?B?em85d2xvL3RDTXBVd05QeEdHMmJ1SnM4QXBwbWZHOGYrSTNxUlhsMVBtay9C?=
 =?utf-8?B?STVpUkhMaldHNWJ2MG1ZV3M2aUNCNCtta29OVlpkN1BSYVAvVUhJamFuTHhx?=
 =?utf-8?B?VjhJTk14TFhralZBRklmWXpDOUtWLzh3eHZRdGtmS3QvSjhOenoyTVF4amFn?=
 =?utf-8?B?emppdDg4OEhQRktrbTI0L05iOEpHWnRvbjZxdzJ5RFVMQ2RuNjMxWHBhMzcz?=
 =?utf-8?B?SXRHRnVHclpmeVN6bTFjd01MaHRvTFBPZWU5UkpnOVIxdnVJSEtoTVRPd09w?=
 =?utf-8?B?N2lEMFRKM0tpUFl2Mlp4SlhqVk55b0h4ajk3bkswalRuM0QyclZWc2JDaXVK?=
 =?utf-8?B?Q3BQUUNsSFVoNWMwKzBGYjZhaWpFamhBUmJYTEk1cThoRWNGUExyaTh6R2Ny?=
 =?utf-8?B?UDJDVHZSb3VnN2FOMnFLUk52ekxQSE9VYWNUK3N0azhmS2RhNVBsdmpESnFa?=
 =?utf-8?B?aTBoT21ub041b21CSkkvTWZIOFZJUjJpdXVNamtUMGFWTUpZTVNIM0MwUFMy?=
 =?utf-8?B?aGR0R3ovZStVbU1lOVJiZ3ByT1lJRWhGbXcyV0pXUUQxWVNyQWVqNjN0RkFM?=
 =?utf-8?B?ZGJwd2Z2U1Z0VldoUGhxemtib3kwOENrYnV0blZmT0w5amUvUSt2R1J2enpX?=
 =?utf-8?B?emxNcm1XR1dPYlZCdWxXUVVDeGJxTWZ5MXB0dU1hOHJPQy9HVmFMU0M2bEh5?=
 =?utf-8?Q?mXaTKPi7VpytO92VbjChNYKED?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7806f315-3d06-41de-5fc2-08dbe4222e9e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 08:26:06.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BufY2CvpG5ttSllCKUW433OfUfZ768iqtExa0F59RWj+rZcJmkOTprd3zNXqtUFuhXC0lk/yon4zzVxXNUoWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6217


在 2023/11/13 16:05, Huang, Ying 写道:
> Huan Yang <link@vivo.com> writes:
>
>> 在 2023/11/13 14:10, Huang, Ying 写道:
>>> Huan Yang <link@vivo.com> writes:
>>>
>>>> 在 2023/11/10 20:24, Michal Hocko 写道:
>>>>> On Fri 10-11-23 11:48:49, Huan Yang wrote:
>>>>> [...]
>>>>>> Also, When the application enters the foreground, the startup speed
>>>>>> may be slower. Also trace show that here are a lot of block I/O.
>>>>>> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
>>>>>> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
>>>>>> 995.109MB/s), usually, it is faster than random disk reads.(read:
>>>>>> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
>>>>>> little to test UFS.
>>>>>>
>>>>>> Therefore, if the proactive reclamation encounters many file pages,
>>>>>> the application may become slow when it is opened.
>>>>> OK, this is an interesting information. From the above it seems that
>>>>> storage based IO refaults are order of magnitude more expensive than
>>>>> swap (zram in this case). That means that the memory reclaim should
>>>>> _in general_ prefer anonymous memory reclaim over refaulted page cache,
>>>>> right? Or is there any reason why "frozen" applications are any
>>>>> different in this case?
>>>> Frozen applications mean that the application process is no longer active,
>>>> so once its private anonymous page data is swapped out, the anonymous
>>>> pages will not be refaulted until the application becomes active again.
>>>>
>>>> On the contrary, page caches are usually shared. Even if the
>>>> application that
>>>> first read the file is no longer active, other processes may still
>>>> read the file.
>>>> Therefore, it is not reasonable to use the proactive reclamation
>>>> interface to
>>>> reclaim page caches without considering memory pressure.
>>> No.  Not all page caches are shared.  For example, the page caches used
>>> for use-once streaming IO.  And, they should be reclaimed firstly.
>> Yes, but this part is done very well in MGLRU and does not require our
>> intervention.
>> Moreover, the reclaim speed of clean files is very fast, but compared to it,
>> the reclaim speed of anonymous pages is a bit slower.
>>> So, your solution may work good for your specific use cases, but it's
>> Yes, this approach is not universal.
>>> not a general solution.  Per my understanding, you want to reclaim only
>>> private pages to avoid impact the performance of other applications.
>>> Privately mapped anonymous pages is easy to be identified (And I suggest
>>> that you can find a way to avoid reclaim shared mapped anonymous pages).
>> Yes, it is not good to reclaim shared anonymous pages, and it needs to be
>> identified. In the future, we will consider how to filter them.
>> Thanks.
>>> There's some heuristics to identify use-once page caches in reclaiming
>>> code.  Why doesn't it work for your situation?
>> As mentioned above, the default reclaim algorithm is suitable for recycling
>> file pages, but we do not need to intervene in it.
>> Direct reclaim or kswapd of these use-once file pages is very fast and will
>> not cause lag or other effects.
>> Our overall goal is to actively and reasonably compress unused anonymous
>> pages based on certain strategies, in order to increase available memory to
>> a certain extent, avoid lag, and prevent applications from being killed.
>> Therefore, using the proactive reclaim interface, combined with LRU
>> algorithm
>> and reclaim tendencies, is a good way to achieve our goal.
> If so, why can't you just use the proactive reclaim with some large
> enough swappiness?  That will reclaim use-once page caches and compress
This works very well for proactive memory reclaim that is only executed 
once.
However, considering that we need to perform proactive reclaim in batches,
suppose that only 5% of the use-once page cache in this memcg can be 
reclaimed,
but we need to call proactive memory reclaim step by step, such as 5%, 
10%, 15% ... 100%.
Then, the page cache may be reclaimed due to the balancing adjustment of 
reclamation,
even if the 5% of use-once pages are reclaimed. We may still touch on 
shared file pages.
(If I misunderstood anything, please correct me.)

We previously used the two values of modifying swappiness to 200 and 0 
to adjust reclaim
tendencies. However, the debug interface showed that some file pages 
were reclaimed,
and after being actively reclaimed, some applications and the reopened 
applications that were
reclaimed had some block IO and startup lag.

This way of having incomplete control over the process maybe is not 
suitable for proactive memory
reclaim. Instead, with an proactive reclaim interface with tendencies, 
we can issue a
5% page cache trim once and then gradually reclaim anonymous pages.
> anonymous pages.  So, more applications can be kept in memory before
> passive reclaiming or killing background applications?
>
> --
> Best Regards,
> Huang, Ying

-- 
Thanks,
Huan Yang


