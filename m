Return-Path: <cgroups+bounces-753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B2800178
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A781C20DDF
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4517D9;
	Fri,  1 Dec 2023 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ic6YaAEH"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3E112;
	Thu, 30 Nov 2023 18:14:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8eyqaLDqoLAuruXvTpTgd2qSu8HiQOMTJm8iAdtvQ7ehZZAubjj0L32rF+u0g2PfCUFiQl/DxU9+cQ8H6MEWDAONoWDPdAfsgo5tSpd1E5700Qd6sNiApLyHi6QLUIzuaiOVXvt4boOKXmuyxtTxopwqD2z0E27wN3gKHLL8bmrPh1GsSOWni8d5tPRTgLCl4CUdyjDZUc29CA5tMgPlY+Rzt4vCm1uUNb/SCb1RqOwfE7AL28nwQDG1NvbXOur4fp9Wr3NET7MkHsAEs2HMxuXa7aWx/JoOYGs+772oNfnCuQC2dT4Qimf8T2JrgONZ6IMWhuxTWPO31OQOqnhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvY2NvlvqTAames2zA9gKuIi5NWGpocv4rnlEWye6+c=;
 b=KWmkdOTJ+sjhYrdKfkVf7J9WjEM6LvZP2Bj5q4rCBekalRIlnKf4dlbh6bpjBbFFRgX5B0NAzZNA54QIn4txqrle+N3DUkwngaNgp6/qUNiP+CtRzxbIpt+Wn7vg/hRmZDrEaA608W2KLLc7P+DuxKAaF8IxB8wGKf5XDfcjr1ELUaY8s62sN+EKZ/tyZZBV91bh+pwRGOzxVvH6gJdq3I3rY/AfqyUvmVBRBce9bmpsg7PxYaSNQAI7O01Pqj+RAlLrL2xmqBx7+xZIupEFKBL7SO/5T2pS1Ks86eJQYez24Y0q65BDHN5NL80Ajr9X+WXNNgxjbpSKYCv36JfxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvY2NvlvqTAames2zA9gKuIi5NWGpocv4rnlEWye6+c=;
 b=ic6YaAEHEnLkh3eT8cqqa76KDXpbwJsxeV2Tny1pUEaobxs5F7eXYQRK5SEu56nk/iRPgqUF64PclSgK1bLUjuDWgzdaa/h7k2uiuMKJwtIP765OibIOcp7OQodrXDTJmiSDRhpnLDO1JKeucdf8rXyNgNSCQlQenO9cdCNVE0e/msmBdpKzUI6240h9SqcOxF5yFNve33M9OKrmS1eE8wBLPx+4nxv0od5Z8V7FlZOm0KMy/CklznwJjpwiJS6yriz9g2WlAjVPKtjj/7DwF1o/EvwMYCfyqFygYen6DhyWHulqJVavzaaHd2K0f4dYpZf7Xw7PxPbLFF+kvJX9hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB4609.apcprd06.prod.outlook.com (2603:1096:4:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 02:13:56 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%7]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 02:13:56 +0000
Message-ID: <abc73ea8-f172-422e-bc58-7424e47636b8@vivo.com>
Date: Fri, 1 Dec 2023 10:13:50 +0800
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
From: Huan Yang <11133793@vivo.com>
In-Reply-To: <CAJD7tkY-npqRXmwJU6kH1srG0c+suiDfffsoc44ngP4x9H0kLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7aa811-c018-4375-352c-08dbf2132bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	02asBQPUeTYmKv7MChC9iiXZjeVVo+/fpV88hYREV94AYzVW/OEkhBDJCPwc2V4F5n+XwssSnOtGccgawtY0sZ9zLpPaN2lcxSnRDW5wtGJzQsL7hAoiKS+mtWhMVNpAdv2RzXAu55IYN5ZLlvYxz9/CUOGBvCTx1PFW2PnLibVGvjncIltw21N2eAxwTvwD1loiCGMN+3wi3wu2WO/k/2qhdFA95jmaKIS6/mN/htkdIeAYVmw2e61s38JxiGrZHWcrtO69lbFJOEmLDMQh0Y0I4/oW91p0NBAU+W5hvsvn/ch/wAfgFCEFFH1IdWhmWjd/GZV7mp+/m7Jp4DxxXQKVbp7jpwM7CpIqKwVHo+3rOM2ygsiy7x87eUsLZ1ST32OnMqqbt0GZjpFxFc3yGJYrINCpRe0mpucWcJKz5urUWujmaTl+UrRUnWxg6Eu6F8yEsYKOd9wVFzetQxeq/C8sw4ss6a8rlzglKhkZpPEs+HoZK99ApXKFYF+aNe4n6E1KKuIGFtpRgiXQSBcXaAe/V7GL1gNbmp2ocBduDtmhP+O+Jm71jZvH9uaIVOSLEliXZsRv7/oYX6wCV1dSq0ysK64Twm+1BxoELKsPU+NRHJZ+6oUvIb1OpP2oc0kBDM9AWL7blvU7Mi5Z2pxqaf3fFj497/c+tO7RSYUaaWhWYMrxHT9QNgStPg6JPUrh9KopCtbipm3ptp2NsXNPiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(66476007)(66556008)(66946007)(6916009)(54906003)(6486002)(478600001)(6666004)(5660300002)(7416002)(38350700005)(41300700001)(36756003)(38100700002)(2906002)(31696002)(4326008)(8676002)(8936002)(2616005)(31686004)(26005)(6506007)(52116002)(6512007)(83380400001)(81742002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtZOXZ0VUtKaDRESkZFU2l3WHhoZ251K3l2NEJhZlczejRGeDlEYlhhUkNQ?=
 =?utf-8?B?YzBvazNOeGhNRWJYTmY5L0lLMEJ0c3ZhOHdiV2RMa1dvdzE3d2ZCMzZlZ1Vl?=
 =?utf-8?B?YWxST1pFTUVGdlJCajA1dDEwa096aVZlUUppeUlRbEJkTmZDWnlGWnRYR0JW?=
 =?utf-8?B?TlprOWxRYnFSbkNILzJTWUo2YkZPSVBob2xoREpBOVRCR1Zoa2o2ZjlnazZU?=
 =?utf-8?B?WndUZFJoTVZDQmh4ZWVJL3JreEJvbVpVTFJ2bG1ab0dTMTNWMXpsNlovMTZ6?=
 =?utf-8?B?bmJjb01yblZ5cjFzdTJ5RDVuOVFaYk1qU0E0SnpnUXNuUFFRWG55TnAxZ3Ft?=
 =?utf-8?B?cEI2QW84bHZLdjVqWUJWcE53dXl1TG5lblJaRUEvMlozYnZHTVJ5Sk91TGE3?=
 =?utf-8?B?S3RaREFRb1Z2ZWJOLzBZUHNEUFlxRUJiNkJjYU9CRjB4QXZqWEJoYWVBQVpy?=
 =?utf-8?B?QXRzdUJtMlN2MzZCV0xRUGdWampXblhrR2hqeUlLM1hQUXUvOUtWMy85OEZL?=
 =?utf-8?B?b0pickFFaElnMkkzSXFyK2NFaVBhRlBJOXMwZXUrMllReFpwamdKajZsQU9n?=
 =?utf-8?B?bFJ2QUxLOExLYXRydExaQTE5Q05vSnhCRzQ4amJJdDgvejFFdDRCUVJuakZK?=
 =?utf-8?B?NEczeHZPMllNTGVRTUUvZW1ZSVFsVjBrVkg5aUp2QzFoY01CY0xybGFMTFNn?=
 =?utf-8?B?TUQ3blBBb3JOTjFFcU1pVkthZWQyZXJKZmJuRUlMdlRXNktOVFphQlA2SG1P?=
 =?utf-8?B?ZUM2amN1b0xkOWw5YlpLajM3NFpzOVk1S2o5Y21URnVId011TU1yQW0wY2Rq?=
 =?utf-8?B?dmgyVEgrenhnSU9KNFBPVFN3dzlTSXlRQVh5QzBPZlc4NDRpZkFNemgvNUY1?=
 =?utf-8?B?TCt4ZGNhVXNqTzVSdDBXZk9MUTQ1L0pNL3kwRHhKRXNaM3VLc1Qxblk5aUhS?=
 =?utf-8?B?NFlQQmRybXVyYThmWGVCRnJkNU9ZWlJoVkV5ZzVtWHZNY3BKdnNZelJRcXl5?=
 =?utf-8?B?c3BoN1RVTHJDaGxWcjQvSEhqY2l4bVdVT3NxbnhvZmhHRWE1UXE2a1hnRFph?=
 =?utf-8?B?eVVLRlRwQ3M2Z2VnZWFyMEJIRTdVQlFBN1VRd003VUJaK0ExeTRrNjZKOG9H?=
 =?utf-8?B?dittNm1kTXhvQmtKeWJtUzdIZjYvVm8wc1B3cUZxS1Z4aUtQYURGMzR3aXBQ?=
 =?utf-8?B?THg0VEMzNStxd3lta3dOdTFTVnNFVWlYZVl4enR4dENpemhZSG41aCtBdnFL?=
 =?utf-8?B?MHBqUHN4OExkS0JKUElKRHhsOXZTVzNsb0pBa25kL3M0aC9nd1VxWnhWNTZK?=
 =?utf-8?B?RWJOTlp4N0ZJbUFReEFWSEZrL0pQS0MrMG9TZzlPaHZldm03UkY4dTlLUVFL?=
 =?utf-8?B?VTRnSXhwaVhGTlpuM0k2V0gyTFBkUjdqNWdPZHI4ZmcxMFRrT0x0TWJlR0pk?=
 =?utf-8?B?NCtldks2OHdidkJnK2hWT1FTS1UzL0J3TWlOaC9RRzdpNVpsRDVDdElTU3o5?=
 =?utf-8?B?WVVKUFRhamZveUdqUTZYTEUrZTlRcTc3dktBblQzK04yZyswbDR2NjcyN3pv?=
 =?utf-8?B?bkdobWF2Ylh3V2xndDNhb0h5YUpvMHQrRVRkUU9ENTVFcEpWKzlmdnp5bXcz?=
 =?utf-8?B?TVhWT3MrQy8yZll2VFZPOGl0RWsxOUtha1FDeGFWbDh2bzVEZTJQRk5wazlJ?=
 =?utf-8?B?Q0NrcXN3ZVZGY1hYTTFxNlZZekkzc2tBUDcwWk9WRHhITDZaR0lQZlh2WmJY?=
 =?utf-8?B?Z3pUaEQ4SFFuMmgvaEZqanRXYnh2YVJySGc4S0wrd3ZlRzNoRGdiUTVOYnE2?=
 =?utf-8?B?NjdpQ0RuSWFtbm9YS1AvRVV3TktlYlBsbjI5S1MwczVPN0dYK2FBd2pqVlNR?=
 =?utf-8?B?dDQzOGhLWGl1M1BCY1ovcFZmK0xweDNHQTdYZkVRcXJrRzV4WFdjcVVaVGdn?=
 =?utf-8?B?T0VSNmhyUGVCTWFkdTNpYWlSMWwzbTRrNjhXbUN2NWVMbXdiTitLRnpmYVhr?=
 =?utf-8?B?bSt6NjliLy9UK1liL1AyUkFMRkdQYlVKVkRvaFIxTDRUVCtZY0dlYUNpK1F1?=
 =?utf-8?B?UTNRNUJYWmUxc2h6L2ttUFBTYTJ5N2FkVWhpWkoveGdkNEFsZDRJNTllc3Bj?=
 =?utf-8?Q?qdqvsbBY7Bc2bK9fJruRmKqI6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7aa811-c018-4375-352c-08dbf2132bba
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:13:55.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPFklL2qL54FWxO6CWlt/+O+y3ms7nrQoF9+kedEZO8XKI7ZktZzoQFJNHriI11Wa2OOc5OwVYVxAH2xFzkEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4609


在 2023/12/1 10:05, Yosry Ahmed 写道:
>> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>>          struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>          struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>          unsigned long anon_cost, file_cost, total_cost;
>> -       int swappiness = mem_cgroup_swappiness(memcg);
>> +       int swappiness = sc->swappiness ?
>> +               *sc->swappiness : mem_cgroup_swappiness(memcg);
>>
>> Should we use "unlikely" here to indicate that sc->swappiness is an unexpected behavior?
>> Due to current use case only apply in proactive reclaim.
> On a system that is not under memory pressure, the rate of proactive
> reclaim could be higher than reactive reclaim. We should only use
> likely/unlikely when it's obvious a scenario will happen most of the
> time. I don't believe that's the case here.
Not all vendors will use proactive interfaces, and reactive reclaim are 
a normal
system behavior. In this regard, I think it is appropriate to add 
"unlikely".
>
>>          u64 fraction[ANON_AND_FILE];
>>          u64 denominator = 0;    /* gcc */
>>          enum scan_balance scan_balance;
>> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
>>              mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>>                  return 0;
>>
>> +       if (sc->swappiness)
>> +               return *sc->swappiness;
>>
>> Also there.
>>
>> +
>>          return mem_cgroup_swappiness(memcg);
>>   }
>>
>> @@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>>   unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>                                             unsigned long nr_pages,
>>                                             gfp_t gfp_mask,
>> -                                          unsigned int reclaim_options)
>> +                                          unsigned int reclaim_options,
>> +                                          int *swappiness)
>>   {
>>          unsigned long nr_reclaimed;
>>          unsigned int noreclaim_flag;
>> @@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>                  .may_unmap = 1,
>>                  .may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>>                  .proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>> +               .swappiness = swappiness,
>>          };
>>          /*
>>           * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
>> --
>> 2.34.1
>>
>> My previous patch attempted to ensure fully deterministic semantics under extreme swappiness.
>> For example, when swappiness is set to 200, only anonymous pages will be reclaimed.
>> Due to code in MGLRU isolate_folios will try scan anon if no scanned, will try other type.(We do not want
>> it to attempt this behavior.)
>> How do you think about extreme swappiness scenarios?
> I think having different semantics between swappiness passed to
> proactive reclaim and global swappiness can be confusing. If it's
> needed to have a swappiness value that says "anon only no matter
> what", perhaps we should introduce such a new value and make it
> supported by both global and proactive reclaim swappiness? We could
> support writing "max" or something similar instead of a special value
> to mean that.

Yes, use other hint more suitable for this scenario.

However, from this patch, it seems that this feature is not supported.
Do you have a demand for this scenario?

>
> Writing such value to global swappiness may cause problems and
> premature OOMs IIUC, but that would be misconfiguration. If we think
> that's dangerous, we can introduce this new value but make it valid
> only for proactive reclaim for now.

