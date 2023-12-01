Return-Path: <cgroups+bounces-755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC280018B
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 03:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF4B1C20D55
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA21C3D;
	Fri,  1 Dec 2023 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XxdwcsaE"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852A115;
	Thu, 30 Nov 2023 18:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQeyKqXS7H1O9HGAsIjaYYVHJT6n2y4dhrtNLQPrmYX7M/RePWxo6xmyF8nUMWOcWfF50e0tkx3Qbf/gQZMekYSUMNbWGuymRWL5gL8vOPsKmL4CljDPk/tRd8JOLhDLjyt19BkYJ70LAY4JngHWUGEDVP3kvYhepan1a7X2hMNjxVBxpbUW7dG884rVEygHiuZAVOsllgF6lfQijGrlCGkfaa8YurhDPEgogVp3zvPFLCkZeFdwsxrJyqDmtCywK+XDBErUmRKLIFKcflyY2pKBfFO+K/bJahnfHwDAeK2NiBiioYknj2Qc+pMYg9NXuvSlClc8nsUQ1GQ9kO8M1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWJ7xAO3+0dD+0sMIHRGKOvzKUeGm8oJyXiudKV0OXw=;
 b=An0lIygazgz/5jlScZwt0NeHXfahC83Nd9ElhaA20GIk3JngN0NxM8YaTcvbi/wDM6HYPDTX5qObQl1D1iVkZiysQnptN6hJFWTXa3G46lJmemaChPe/ckv5ithfQIKXHOcfWWi21oNrL0x3Xhmwqy7FDhXZJpuEgPrW4XK9v+kky9evDuEVDdh6PVzlBo9RAVgqiM4wc3HcxkknQY4+HzrH8sfedgCleVdJY20/qiPVK9Ux+qI7clnz1ugsIxsO3aPbt/uyrj7cdHmIKH0kcwEEtsmnpag5gJkTWAseF1I5qgq8d6tpdzBbSH0JsBw8MeMkS0w9K7PA1PYwfySgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWJ7xAO3+0dD+0sMIHRGKOvzKUeGm8oJyXiudKV0OXw=;
 b=XxdwcsaEXEh2y5ass9ljwqoWGcEFLCXonJRFIjKirTUaCzft/QFri+Hg4hgzfV4MCxa/zF/pf3LpqdxFFiC84eHmJjFJzdQf2NqakhYSdoACg6vQ4Y1e7OAxgGAdrmReLhv3JvumEV3+kfI0fwxVcK+iFixBL5EiOhWh7iYhcwZYdvY+xsIbqBsAZnV1/L+iAJ2jtAa1BlLdwXAxQx3fYSzQDnqR/zQjsShcM5olvfzfX1s5wQE+O+XNR71vM3NpVGB76+SOkxW6m2JXauzHYTjmdti1u4xAlBeRUJnMtYXy8SEjQvpGNBt9aBtyNSDgs3hiCrpTqE0f8orKWPm6sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by OS8PR06MB7324.apcprd06.prod.outlook.com (2603:1096:604:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 02:24:09 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%7]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 02:24:09 +0000
Message-ID: <f69c6d14-7b04-4bf6-91a4-e042f2ebc413@vivo.com>
Date: Fri, 1 Dec 2023 10:24:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Huan Yang <link@vivo.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>,
 Hugh Dickins <hughd@google.com>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130153658.527556-2-schatzberg.dan@gmail.com>
 <ec8abbff-8e17-43b3-a210-fa615e71217d@vivo.com>
 <CAJD7tkY-npqRXmwJU6kH1srG0c+suiDfffsoc44ngP4x9H0kLA@mail.gmail.com>
 <abc73ea8-f172-422e-bc58-7424e47636b8@vivo.com>
 <CAJD7tkaXUsvCEkenaoBOGYaSjCW5yQNCuFiWJEDJOtKXLaYeeg@mail.gmail.com>
From: Huan Yang <11133793@vivo.com>
In-Reply-To: <CAJD7tkaXUsvCEkenaoBOGYaSjCW5yQNCuFiWJEDJOtKXLaYeeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|OS8PR06MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa4b345-f8e8-4335-46b3-08dbf2149965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iNPDxCsJYZUDZoYW4im/JqLj0GDK0sK/vcGWuFnihDV9oG1J+G/nA1xo8ym/37OBjx+RrcRc+cVE07TRjaGfcvOOipL4TK9Bf7PyfL/enZtYdD9M2CVMtjECMxeS3cPTEtKhDt+bWWrF6ZlreL2Tdzd7l2qLbhOYdKTGGSw97j5EF55Y3XpxoTXSEvlr/GbNL6+C/+njgp0LileQlM27x06W3VlgcqXXhIl5ij/GUq382SlFhkwg2ZebLwW1SfInHpCr0ICP3uZjhMPG2+DazG7ZWE68Hw9MsPTpbXkVDuilT4qVt7ucwfuZfcZQfCH8yHlxyaqLO4pxkXk78Af3FUlAN1kmodJ9JwhSazB9cC3gT6fCq+3R0A9ZXphExLrVhnWLy7Vs1HC+huKsRHHuIwpBsVqqaJRwo8NgvsMcBlQvdLBYbZ4/g/pEo1X8+A8quIfL82N9Scs40vyGU4E/sJuxHcjHf8ZjeRfMXWUWkKzSQjmZw5s/+13ylQfBwKLhF9UJvIAypuaDrsyzC+KC8Z0cKldm8SXsiczCoDbHuTUBD9fAF3hKsOyKSOjYNFvydKt5HSB57U82P+GQRlq4PwZdOSoLobpqbpjKPx1pfMxFecHX2u2uQOtc8LrnlRf6dDQrhCyUWu8mAtCWCZeRwHOA4tC/3Gje+m8aUXaBjWku2PEHApfPGbTMhlzEdC17dzfN21euBe4vNIIWqm5jvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31696002)(31686004)(316002)(4326008)(8676002)(6486002)(478600001)(38100700002)(8936002)(36756003)(5660300002)(54906003)(66476007)(66556008)(6916009)(66946007)(7416002)(2906002)(38350700005)(6506007)(53546011)(52116002)(6666004)(41300700001)(6512007)(26005)(2616005)(83380400001)(81742002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVl3N1lXVmNvYkMzMGVTazFmeFpyVGtkMjMrelhhMmt6UTV3TTZGNXhnSWxT?=
 =?utf-8?B?aUpQUUo4ZFpacCtjN2VoSDFRd2dBMnViUlVLQ0dOdUFCMWVHSzRnOWlIZGlM?=
 =?utf-8?B?ZDVvUDE0M2V0enNVRE11K2EzMlYxb2pscyt4NjQwMnZrUnBWa083OU5JWHoy?=
 =?utf-8?B?ZnRUL0R0blBEcWlEdUlpQ043U1E5QVpDSmpSeFN5Z2lEOE5aUkpyNXlUSTdh?=
 =?utf-8?B?ZVhaRFh2dmhpQzFzZnQ0dWIxMTVmOUZZZjJsV28yQnIrdCtjSHkwUVNiQXRH?=
 =?utf-8?B?elYyeHEwUG5tSzRDRjgvUDhFQ1F3S0UycFJUcXlHZWlWcjNpeWx3eHpCb2JR?=
 =?utf-8?B?YjM3OGIvdzl4SkpVYnNUOFRXZjh1NDRTK3pYTkRoWS94bllPTlZPNkNBYWZO?=
 =?utf-8?B?aXVhMi9EZTlrZHZJMlVsMTNuZ2UwdnN5aGQyeDBoSHl2Y1BRc0tXSlZZV28v?=
 =?utf-8?B?OGFSVjBscitlZDJxTytxRmxmaGdDblo0WDZVYlkwbW9BcVhwMVI4UlllUEJt?=
 =?utf-8?B?Qktrek54ZzZ0NnhTRHpwN1BWS0R2UjA3eXdXcEFSVW5RbVVCU3pDRlBpWmRC?=
 =?utf-8?B?RE9EbUNndUo5ZGpWK0xRTTV6L0VtQjhVVmJjUVNkTEp5NUlSWkplOEVTRlU5?=
 =?utf-8?B?cUEwcFc3d1ExbWpxanc4MVBvWWxtUkJ5azVKL1NkeHBYa2Fqd3JPcThqNitF?=
 =?utf-8?B?RE80WVFITloreHBrcTVXcmltSWRvOHBPVzRJNE1oUyt1Z2hORkV5VHYyMVlm?=
 =?utf-8?B?RWNsaUQ4YUdWRm9JNFVMTXZGcVBJM3duV1pBZ3RKcldaNzJESWh1UXRtaER3?=
 =?utf-8?B?MnJ4eHIycHV2eWlWOGQyNXd6VmU4VXU1THhhSHRpZkhaNEVDU2tYeFhhblZl?=
 =?utf-8?B?TnFKcW5BL3ZuV2JUR1NDaUlaQXZ2cUlNQVdsL3J4dnNBYk1Kd0UvV3MvaU8v?=
 =?utf-8?B?bHRMWXBwbUNKZmYvdmEwMFY4WGtsSHZ6cXBFYUtyMVg0WkIwUHY4d3M3OVAy?=
 =?utf-8?B?TUpYWk44UXJwYUdjNm5VSzFTc0Q4Y1VjdUcyZlhrNHEvNGtPK092Z044NG4v?=
 =?utf-8?B?TzhTdld6SU5JRGM3OGxWdHB3MjExaXFlTEhjdkRmWnBFbUwreUp2OUVjWHo3?=
 =?utf-8?B?RitIUFA3emhUaHhLZmJnKzQ3UHJlSk1ObTl3VXhLVnl3SW9yRmI1d3hmQnVh?=
 =?utf-8?B?S05DU1JzQ1AvMXNYWHY2VWgvVWREZG1tQ2RrWThZSlk1b1FxdHVlMlNyU2NZ?=
 =?utf-8?B?Z1puSTBYL1lrWXFyZEwyTlgvdDBRMThCRk8vdERGUHdlSnpxbWUyM2dwMGpx?=
 =?utf-8?B?RFdEcHFWd0hlOTdXWXVwM2l0L2xTWWtRdnQ1aUgyc0pwRmhGZkZTTTFpaTJM?=
 =?utf-8?B?TDFjUTNINEgrckk0M1lvbEkxOG9hWG14Q0dRbjNoSWNuZjlCQm44NWZTRlJr?=
 =?utf-8?B?c0FrajlKa05xSVRBOEN6UWVWL1ZpTFVTM1p3UEtyaVNtRWVEUEhyY3lyajJy?=
 =?utf-8?B?ZUF4eWRsWERvcjYzRVNZK2w2bkJvckcxaU5KZnBVRGtYQVc4anZtWGt0dHI5?=
 =?utf-8?B?bzZVS2lSVFltMDV5VzJ5b0VhSWFLNnJWVVBYa0RJclV4VmdydkhWNGg0Y2FX?=
 =?utf-8?B?TWo2bGpEd3VTRWtOYkxSY2JadHhBblYvOFdWdDJtK29KaTVRaVRkR0VrUnZX?=
 =?utf-8?B?VVNMVGE3THUxSXBZV3BnemRRdU42OVhlQ2piOEtCNlh3YlJjMGZxZmlpaHB1?=
 =?utf-8?B?SkcyTXRhTTJjUWdqZkNuMWVSaTJSRTNOLzdpSTAzaXlUOTlhM0g4TUVYaE1n?=
 =?utf-8?B?SFFnSThEcUdodGNPNkdRZWhrZGpsRDc4eHBGS0d1YWJIM1VtS3I2ZGdPdmJL?=
 =?utf-8?B?RXNWMUQ2a2V5Y2RlRnE4NGVramhtS3ptNHhPTHpTN3dVR2I5MC9Vb3QvVnAy?=
 =?utf-8?B?T0J4aXJoMmRSd2dxWEZYcGIxcnFRSXVIWVZ6OG1oRS85cklPTVVkcFJFd3ZF?=
 =?utf-8?B?YlZobTJoczU0OWFPYmoxN3VUcnJvNDBJMHcyamxyM3J3TjVDSEhBMndaZHE5?=
 =?utf-8?B?MnNMUGdIRllueDVnaXk5dmlvNkRDaityQ3pURVA2dWsxcE5zN3hOM1k4enRF?=
 =?utf-8?Q?70RE6QtMaJ+D6RwdAEDnwVGTo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa4b345-f8e8-4335-46b3-08dbf2149965
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:24:09.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p078xhHm1NnshdxDpYgaURMScd3o6ZMwVJFGV0EZS/uUieqU1mv+P4wVZWEyX/mly1uhqHedFWg0P0sNxxfAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7324


在 2023/12/1 10:17, Yosry Ahmed 写道:
> On Thu, Nov 30, 2023 at 6:14 PM Huan Yang <11133793@vivo.com> wrote:
>>
>> 在 2023/12/1 10:05, Yosry Ahmed 写道:
>>>> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>>>>           struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>>>           struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>>>           unsigned long anon_cost, file_cost, total_cost;
>>>> -       int swappiness = mem_cgroup_swappiness(memcg);
>>>> +       int swappiness = sc->swappiness ?
>>>> +               *sc->swappiness : mem_cgroup_swappiness(memcg);
>>>>
>>>> Should we use "unlikely" here to indicate that sc->swappiness is an unexpected behavior?
>>>> Due to current use case only apply in proactive reclaim.
>>> On a system that is not under memory pressure, the rate of proactive
>>> reclaim could be higher than reactive reclaim. We should only use
>>> likely/unlikely when it's obvious a scenario will happen most of the
>>> time. I don't believe that's the case here.
>> Not all vendors will use proactive interfaces, and reactive reclaim are
>> a normal
>> system behavior. In this regard, I think it is appropriate to add
>> "unlikely".
> The general guidance is not to use likely/unlikely when it's not
> certain, which I believe is the case here. I think the CPU will make
OK, I will remember this part.
> better decisions on its own than if we give it hints that's wrong in
> some situations. Others please correct me if I am wrong.
No, you're right. CPU is good to do this.
>
>>>>           u64 fraction[ANON_AND_FILE];
>>>>           u64 denominator = 0;    /* gcc */
>>>>           enum scan_balance scan_balance;
>>>> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
>>>>               mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>>>>                   return 0;
>>>>
>>>> +       if (sc->swappiness)
>>>> +               return *sc->swappiness;
>>>>
>>>> Also there.
>>>>
>>>> +
>>>>           return mem_cgroup_swappiness(memcg);
>>>>    }
>>>>
>>>> @@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>>>>    unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>>                                              unsigned long nr_pages,
>>>>                                              gfp_t gfp_mask,
>>>> -                                          unsigned int reclaim_options)
>>>> +                                          unsigned int reclaim_options,
>>>> +                                          int *swappiness)
>>>>    {
>>>>           unsigned long nr_reclaimed;
>>>>           unsigned int noreclaim_flag;
>>>> @@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>>                   .may_unmap = 1,
>>>>                   .may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>>>>                   .proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>>>> +               .swappiness = swappiness,
>>>>           };
>>>>           /*
>>>>            * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
>>>> --
>>>> 2.34.1
>>>>
>>>> My previous patch attempted to ensure fully deterministic semantics under extreme swappiness.
>>>> For example, when swappiness is set to 200, only anonymous pages will be reclaimed.
>>>> Due to code in MGLRU isolate_folios will try scan anon if no scanned, will try other type.(We do not want
>>>> it to attempt this behavior.)
>>>> How do you think about extreme swappiness scenarios?
>>> I think having different semantics between swappiness passed to
>>> proactive reclaim and global swappiness can be confusing. If it's
>>> needed to have a swappiness value that says "anon only no matter
>>> what", perhaps we should introduce such a new value and make it
>>> supported by both global and proactive reclaim swappiness? We could
>>> support writing "max" or something similar instead of a special value
>>> to mean that.
>> Yes, use other hint more suitable for this scenario.
>>
>> However, from this patch, it seems that this feature is not supported.
>> Do you have a demand for this scenario?
> We do anonymous-only proactive reclaim in some setups, so it would be
> nice to have. I am not sure if it's absolutely needed vs. just using
> swappiness=200 and living with the possibility of reclaiming some file
> pages.
Right now, the scenario where swappiness=200 is sufficient for us, but 
having the
tendency to only reclaim anonymous pages has a clear semantics that is
suitable for upper-level strategy scenarios, rather than relying solely on
the functionality of swappiness.

