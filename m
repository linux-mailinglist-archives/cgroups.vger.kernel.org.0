Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1A6F8468
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjEEN6n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 May 2023 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjEEN6m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 May 2023 09:58:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887C160A6
        for <cgroups@vger.kernel.org>; Fri,  5 May 2023 06:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeGnDcgJKttH29hD0xE22OPYZVC4TAoYuaLy+k99Ug13iU3L7M/9VD7E6uZTzL9yiSUxYECiNZZ35+wBzht6h/SXzoSK86rcQqryiBaTDlLRt2Cm+7T4vERkwEAtcV6O/txJXhzTcRMTOWLuEq79mBB1I3rFSZL2oEjtEZPo2uYCP0h1xhnWnHVCIuUQv4+aeWgO/yiAHyzOu/JX6+gk/8y+efJbz9ie6cJ1mTo3/V3a5Ve1ZAg46q9AEXAKPmksgE6YTKJqAzPNqYh6aRiYIiwLoRjgsugGl81dvj0OTHblJIcJUlfgs2wt87t6znA30eSZOvco3V+bcerJyE1pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFzTmHoD0YW+y+JyJp63tu3++Ylp2gWaHOWpJbm059w=;
 b=GYnkWCQjRZaGbeN5ezmS/wwszAUQT/l92M3i+ILSgP1h41d1FkJwlF7AP0WUSwxRhfLRi1Hils+nXIi0R0/Z38o6MvM6qeGVAd+cXNOx15SZwfcevFzhWUrYXHQgXCz0gkMIdwdL1+lwBFb8uJqU0DOQ+70IcFDXVU9kb8SfkZJ7Ff1kyafxd9VHFywpSWlQg5UCb4NfBLAgpD/tAW3b4xXA4kN3eUVhW2AkVdDZDT3Jgn63/YcY3Po2hNQrwVVkbiiKh1RtxYDZdEX120oJBDKcqkcXSqO/k6KMd/Gesgs56xacuJu7s5YC6uONjQIRThbcirR7zJWmjN05nZts6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFzTmHoD0YW+y+JyJp63tu3++Ylp2gWaHOWpJbm059w=;
 b=sA8OzQ6MUTpAebtpHyYbws/2Rq253+ioTTJIb6ocEIwLzsL6/2M85FEQIxEQaQbYBqL2XfKWzbFKek0CxoO7JcZknfqD6BSxGrrN23mNL1e8pwVuX4fRpbwmrYM6KqGrMjWXKUptoX7gD4VcqWj6gin9l22w3a8wY3Czq63Djxo/mUo9VO3MHYCQxzFBMSaVCMmSl1D6YqJUmXKMIBDtvJYO1BNx+9hjOGKpRcxf3TO8/hQ2SjU8+nhwjIEoRYejaU3IFe4zLX6em8h1xdLyubdCn1m9/JW8kmMRqkF8rx4HMsc4//rwZEO67+M6aKGa8qmAOn4UOfluTU5dgSHu5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 13:58:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 13:58:37 +0000
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com> <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Chris Li <chrisl@kernel.org>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Date:   Fri, 05 May 2023 23:53:24 +1000
In-reply-to: <ZFPP71czDDxMPLQK@google.com>
 -text follows this line--
Message-ID: <877ctm518f.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY6PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7192489c-420a-4123-1439-08db4d70d247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0f6puqqMJleJ1oerd180MeMQhQK5e1wxL5SsJLyqXYVzPo3Gx8/DT6HUW4MIv6v6JqGur86K11TCKN3MvoPa01y8IgcTzgTCj5LthzIeYBGAITpjetgw2AXgnUuIU15jaeWf6YdMhd9Yq575mwfoexI9qid+RczSOxSJAf8znXnfGicinpT9101TdDHKQQwmVluS/XqS/XhEUWPdeGA602+GxIu15wysJzOim7/fNCFdHlhuzTHUZIoUCMCBIpbnhp9czFm3iVAUszxh4HtIARv4N8Vtf9jyEwH9WUw3SZVR0/1jMQcYr4zih08XbHadwX41bTQz8rGNfReVyb2Rj8nHi34KScGIzXbPe85MWObpZsIZAGYwja/rWqqI44AuuWPuicByQKhyp7/mPi69ZuyHn7s4mhqCwJyOEsMX4FwKDowmDhcqgKAJausbOQ0EagU5w52hBt1uWS8UmocClgwjKuQftQrMWAzrCXlLEHhY247um7TS9feJi9VndyqAdci8r/bf/ybDrRatGWx4ftcNwqiR3p9hwZtU1vjP0+aerwnA8ouz4MhyscESm1cPW4NrMZjpvFiobvGzIVHawaQpouXx1BiYb/pBSN+TjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(5660300002)(7416002)(8676002)(8936002)(66556008)(66946007)(66476007)(2616005)(26005)(6512007)(6506007)(186003)(86362001)(41300700001)(83380400001)(54906003)(478600001)(6666004)(36756003)(316002)(966005)(6486002)(38100700002)(6916009)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNIK21yYWppU08vMGZnOEh2ZW15a250UEpSWG5udXpRQWErRHlLVVpNTDFV?=
 =?utf-8?B?Q3ZXRGpybnVIdVRNQzN0RXY2aTRZQk9NU3RvU093VjNBRUJMQ3FjT2kxUEhK?=
 =?utf-8?B?QUhqb0oxcFNBR0htY29uU2tGL0RMcUUvb2M4U1M3MTJsbUhiNXlrTWtWRUtv?=
 =?utf-8?B?QTgzTXFOZnZkNENEZjZYV2FzSERYWjJSU1BzWU5oZjc2Sk5uNjVQWWd6Tlox?=
 =?utf-8?B?TkZyUEFlVUMwalZkUG5sbzlZVnpEUkc5UytyU2lvVWJ1V01VMGsxSUpDRDRB?=
 =?utf-8?B?VkNMd2VtclFhYlhVZEFhVWVDMU93dHJHQml6YjIxOElsTEhsNW5ONHhHbDY1?=
 =?utf-8?B?Q1h2VTgvOWZNWTVmNmpaaHROR1FudVVYWUxyOUFhNW9jSnNnYmpSbFRmQmpY?=
 =?utf-8?B?eGlCQ2ljRGtYN2dDc3JpWlF0Rm5Gdk42OFE0MHorMU90aEpIZ095VHE4Vjh2?=
 =?utf-8?B?d25sUnVwK3lMUVpKcjk2TTFwMHExOGRhMnl4dWJFSHZuZ1pMb1AzNzNkRFIy?=
 =?utf-8?B?YXpOVXZnaGhnL2NyNVg0TTRVdmtielZjb0lKeE4zTTZRZ3JvaVZKYitid0ww?=
 =?utf-8?B?WGdIZk42SndIM25iTVp3bmpEZklzeGZPM2ZhQ1h2UkdPdGlUU0JpbHVHbWU3?=
 =?utf-8?B?VUcwVmVJaGhkQnRqL2w0SEs2U2pVOWFIekN1aENNbGFkTUYzZlRSV2ZibXkz?=
 =?utf-8?B?NzFxOHl3eldCNnVlSmFabmhGUEVxdHBEOGl4U1NNUFBsNjFBa290VVhQRy9Z?=
 =?utf-8?B?MW1KUTZMbzRPcE9qMG1HWGdQMGxFS05ZeW5FaENxZE1kbFIvWHpvSWxBWno5?=
 =?utf-8?B?WWN4eFZseEsrUmRtWldnaG9nMU5RdGIvVmxVRkQ2bUVSRkF0OGZqWU13ZHgy?=
 =?utf-8?B?TnphR0kvdFBxRHpnRjB5UUt1aDRsdGlkQ0pYcmptRTQza1NpNTEzdWpOZ2VI?=
 =?utf-8?B?VFlZVUlzUmZqc2tVMnFpeDJPK3R0YnovWHQyM04yaEsreWlyOUQyOVFmak1o?=
 =?utf-8?B?dHIxbUJOVyt2NUpUYXJoZHZlK2dlQVFKdjJJU1ZnL2hvZksvZ3R0NStabjBO?=
 =?utf-8?B?cmx6am1WVjhXMzlwZjk5WmVmMXdEUDdRdEM4MFJyMXZ0WkxaS2g4TnZWR2x4?=
 =?utf-8?B?bkdIKzB2UmlOYkthL0dOc1pXWHgzR3NkQnJrSVI2QlI3YTczVmE3cXRObzg0?=
 =?utf-8?B?ZUh4c3kxTkNtY3dsNE9kOFQvRVlKcHpxZDE2czRRc1Zyb3VsckdWWGpMSWNy?=
 =?utf-8?B?eUc5SXEzeWVlQXZDYmZnalFYOVRha2l5KzluV2NnM0tBU3pQWm9YSjNjUDVP?=
 =?utf-8?B?ZGRIRlJkckVkNDBqWWZicWtxZzIrS1VHNWpHT0s1OU1QdndCR1BycXJ5d3pk?=
 =?utf-8?B?Y3FBZFI4N2RIejVtNnBqTnd4UzBlNlpNcHdsQ1hrWEZ2RnVqS2VVczZnTkJq?=
 =?utf-8?B?WklkVU9oYW9EbEtmMk0waGt0RFJRTlJwaXJoZ3NKdjVPTlJWd2dDUmNoUm5w?=
 =?utf-8?B?WVUraTh3UDBHOHhtU003bFNEWWtKUktscHQ1eG9oZ290eDlMbjY3b3JoclJF?=
 =?utf-8?B?blcwZU44YUtUQWNPd01EYXowOGZ0UVM4Q0cxWUJXQ3JENTZXV3lhdEpNTWtj?=
 =?utf-8?B?V2g5emxrMUVyRkd1ZzFObDVhTmZHV0g2MWR4KzRPdjk2cmJuR0xUWklsTjFm?=
 =?utf-8?B?ZXlwbC94YU1YR25uVmhmWnh2UWNZVWt0MTRYRnc4V21QRUZiNXBtaDJ3QXJU?=
 =?utf-8?B?b1hVMjBDZE1sRXoxa2J2aXRjaC9XQ2R4UDlXd1pMRW54d1BrUEdwVWd2L3Jr?=
 =?utf-8?B?c0Z2YUJaaWV2ZDM5bkY5YVdVcmlTMmwxQTFMNE1VK2JOQ1d4ZzlJVkpuODZR?=
 =?utf-8?B?MkV4QTJqOG81VEl3ZkFlSWF4OE9DZUpxZytwOEdEVERvTHdTbjBzOXBkRG1R?=
 =?utf-8?B?UUNGRWNNTjhPekZuSUc5Q01NRlFZakloQW1OUGxySTgrbXF3cWl1d2E1WlJk?=
 =?utf-8?B?SHYxNGVaT1lINWhYUkVGdGhRR0lFMTBuWlgzdmdKeXBqU2toWTVoNGFQZlkz?=
 =?utf-8?B?c1ozRkRKcW5OTFZTMDlDY01sYzJyNE82ZnVvRXBjV0IrMkQ3cnBudWozNnQ5?=
 =?utf-8?Q?aIgT1RV47sSrL67PE0MbKlD8w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7192489c-420a-4123-1439-08db4d70d247
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 13:58:36.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX3r+KvdrgZuU0fMilOHjudQ3+kX3YY5Foo7arGVq5Rgnk5dkUF1CYs9bq7kjN7dFkFioYta8NiaLH04GOsVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Chris Li <chrisl@kernel.org> writes:

> On Thu, May 04, 2023 at 09:58:56PM +1000, Alistair Popple wrote:
>>=20
>> Chris Li <chrisl@kernel.org> writes:
>>=20
>> > Hi T.J.,
>> >
>> > On Tue, Apr 11, 2023 at 04:36:37PM -0700, T.J. Mercier wrote:
>> >> When a memcg is removed by userspace it gets offlined by the kernel.
>> >> Offline memcgs are hidden from user space, but they still live in the
>> >> kernel until their reference count drops to 0. New allocations cannot
>> >> be charged to offline memcgs, but existing allocations charged to
>> >> offline memcgs remain charged, and hold a reference to the memcg.
>> >>=20
>> >> As such, an offline memcg can remain in the kernel indefinitely,
>> >> becoming a zombie memcg. The accumulation of a large number of zombie
>> >> memcgs lead to increased system overhead (mainly percpu data in struc=
t
>> >> mem_cgroup). It also causes some kernel operations that scale with th=
e
>> >> number of memcgs to become less efficient (e.g. reclaim).
>> >>=20
>> >> There are currently out-of-tree solutions which attempt to
>> >> periodically clean up zombie memcgs by reclaiming from them. However
>> >> that is not effective for non-reclaimable memory, which it would be
>> >> better to reparent or recharge to an online cgroup. There are also
>> >> proposed changes that would benefit from recharging for shared
>> >> resources like pinned pages, or DMA buffer pages.
>> >
>> > I am also interested in this topic. T.J. and I have some offline
>> > discussion about this. We have some proposals to solve this
>> > problem.
>> >
>> > I will share the write up here for the up coming LSF/MM discussion.
>>=20
>> Unfortunately I won't be attending LSF/MM in person this year but I am
>
> Will you be able to join virtually?

I should be able to join afternoon sessions virtually.

>> interested in this topic as well from the point of view of limiting
>> pinned pages with cgroups. I am hoping to revive this patch series soon:
>
>>=20
>> https://lore.kernel.org/linux-mm/cover.c238416f0e82377b449846dbb2459ae9d=
7030c8e.1675669136.git-series.apopple@nvidia.com/
>>=20
>> The main problem with this series was getting agreement on whether to
>> add pinning as a separate cgroup (which is what the series currently
>> does) or whether it should be part of a per-page memcg limit.
>>=20
>> The issue with per-page memcg limits is what to do for shared
>> mappings. The below suggestion sounds promising because the pins for
>> shared pages could be charged to the smemcg. However I'm not sure how it
>> would solve the problem of a process in cgroup A being able to raise the
>> pin count of cgroup B when pinning a smemcg page which was one of the
>> reason I introduced a new cgroup controller.
>
> Now that I think of it, I can see the pin count memcg as a subtype of
> smemcg.
>
> The smemcg can have a limit as well, when it add to a memcg, the operatio=
n
> raise the pin count smemcg charge over the smemcg limit will fail.

I'm not sure that works for the pinned scenario. If a smemcg already has
pinned pages adding it to another memcg shouldn't raise the pin count of
the memcg it's being added to. The pin counts should only be raised in
memcg's of processes actually requesting the page be pinned. See below
though, the idea of borrowing seems helpful.

So for pinning at least I don't see a per smemcg limit being useful.

> For the detail tracking of shared/unshared behavior, the smemcg can model=
 it
> as a step 2 feature.
>
> There are four different kind of operation can perform on a smemcg:
>
> 1) allocate/charge memory. The charge will add on the per smemcg charge
> counter, check against the per smemcg limit. ENOMEM if it is over the lim=
it.
>
> 2) free/uncharge memory. Similar to above just subtract the counter.
>
> 3) share/mmap already charged memory. This will not change the smemcg cha=
rge
> count, it will add to a per <smemcg, memcg> borrow counter. It is possibl=
e to
> put a limit on that counter as well, even though I haven't given too much=
 thought
> of how useful it is. That will limit how much memory can mapped from the =
smemcg.

I would like to see the idea of a borrow counter fleshed out some more
but this sounds like it could work for the pinning scenario.

Pinning could be charged to the per <smemcg, memcg> borrow counter and
the pin limit would be enforced against that plus the anonymous pins.

Implementation wise we'd need a way to lookup both the smemcg of the
struct page and the memcg that the pinning task belongs to.

> 4) unshare/unmmap already charged memory. That will reduce the per <smemc=
g, memcg>
> borrow counter.

Actually this is where things might get a bit tricky for pinning. We'd
have to reduce the pin charge when a driver calls put_page(). But that
implies looking up the borrow counter / <smemcg, memcg> pair a driver
charged the page to.

I will have to give this idea some more tought though. Most drivers
don't store anything other than the struct page pointers, but my series
added an accounting struct which I think could reference the borrow
counter.

> Will that work for your pin memory usage?

I think it could help. I will give it some thought.

>>=20
>> > Shared Memory Cgroup Controllers
>> >
>> > =3D Introduction
>> >
>> > The current memory cgroup controller does not support shared memory
>> > objects. For the memory that is shared between different processes, it
>> > is not obvious which process should get charged. Google has some
>> > internal tmpfs =E2=80=9Cmemcg=3D=E2=80=9D mount option to charge tmpfs=
 data to a
>> > specific memcg that=E2=80=99s often different from where charging proc=
esses
>> > run. However it faces some difficulties when the charged memcg exits
>> > and the charged memcg becomes a zombie memcg.
>> > Other approaches include =E2=80=9Cre-parenting=E2=80=9D the memcg char=
ge to the parent
>> > memcg. Which has its own problem. If the charge is huge, iteration of
>> > the reparenting can be costly.
>> >
>> > =3D Proposed Solution
>> >
>> > The proposed solution is to add a new type of memory controller for
>> > shared memory usage. E.g. tmpfs, hugetlb, file system mmap and
>> > dma_buf. This shared memory cgroup controller object will have the
>> > same life cycle of the underlying shared memory.
>> >
>> > Processes can not be added to the shared memory cgroup. Instead the
>> > shared memory cgroup can be added to the memcg using a =E2=80=9Csmemcg=
=E2=80=9D API
>> > file, similar to adding a process into the =E2=80=9Ctasks=E2=80=9D API=
 file.
>> > When a smemcg is added to the memcg, the amount of memory that has
>> > been shared in the memcg process will be accounted for as the part of
>> > the memcg =E2=80=9Cmemory.current=E2=80=9D.The memory.current of the m=
emcg is make up
>> > of two parts, 1) the processes anonymous memory and 2) the memory
>> > shared from smemcg.
>> >
>> > When the memcg =E2=80=9Cmemory.current=E2=80=9D is raised to the limit=
. The kernel
>> > will active try to reclaim for the memcg to make =E2=80=9Csmemcg memor=
y +
>> > process anonymous memory=E2=80=9D within the limit.
>>=20
>> That means a process in one cgroup could force reclaim of smemcg memory
>> in use by a process in another cgroup right? I guess that's no different
>> to the current situation though.
>>=20
>> > Further memory allocation
>> > within those memcg processes will fail if the limit can not be
>> > followed. If many reclaim attempts fail to bring the memcg
>> > =E2=80=9Cmemory.current=E2=80=9D within the limit, the process in this=
 memcg will get
>> > OOM killed.
>>=20
>> How would this work if say a charge for cgroup A to a smemcg in both
>> cgroup A and B would cause cgroup B to go over its memory limit and not
>> enough memory could be reclaimed from cgroup B? OOM killing a process in
>> cgroup B due to a charge from cgroup A doesn't sound like a good idea.
>
> If we separate out the charge counter with the borrow counter, that probl=
em
> will be solved. When smemcg is add to memcg A, we can have a policy speci=
fic
> that adding the <smemcg, memcg A> borrow counter into memcg A's "memory.c=
urrent".
>
> If B did not map that page, that page will not be part of <smemcg, memcg =
B>
> borrow count. B will not be punished.
>
> However if B did map that page, The <smemcg, memcg B> need to increase as=
 well.
> B will be punished for it.
>
> Will that work for your example situation?

I think so, although I have been looking at this more from the point of
view of pinning. It sounds like we could treat pinning in much the same
way as mapping though.

>> > =3D Benefits
>> >
>> > The benefits of this solution include:
>> > * No zombie memcg. The life cycle of the smemcg match the share memory=
 file system or dma_buf.
>>=20
>> If we added pinning it could get a bit messier, as it would have to hang
>> around until the driver unpinned the pages. But I don't think that's a
>> problem.
>
>
> That is exactly the reason pin memory can belong to a pin smemcg. You jus=
t need
> to model the driver holding the pin ref count as one of the share/mmap op=
eration.
>
> Then the pin smemcg will not go away if there is a pending pin ref count =
on it.
>
> We have have different policy option on smemcg.
> For the simple usage don't care the per memcg borrow counter, it can add =
the
> smemcg's charge count to "memory.current".
>
> Only the user who cares about per memcg usage of a smemcg will need to ma=
intain
> per <smemcg, memcg> borrow counter, at additional cost.

Right, I think pinning drivers will always have to care about the borrow
counter so will have to track that.

> Chris

