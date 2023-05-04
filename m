Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2021C6F6A9E
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjEDL7y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 May 2023 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjEDL7t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 May 2023 07:59:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A947618B
        for <cgroups@vger.kernel.org>; Thu,  4 May 2023 04:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqpCquwP7QqzZ53RtDFPHfVrN6o6yexP1gd0JbUavhQ7v65UWvljindmBtlw/b9tZjvbq3IqCqPhtJxa7R/brAoegHzGVr6Fn3GU8jnX8/dqDzKghBp7XlvsyGSbFSXBZ/GZlwMMHnBlrXXFohtI0X0yKNxq1fcDjrStQL8JGgkNsrVAgWSbI5DObpirh+mwgqaHHQi7MtApPcbU6NJ4G0k+VVYJWWDmWK6Q4PR8/tTUmxf5ENzq3F12pNDFjx+U+2WjDbZWWyS6XnA+8Z674zDRTrrep1c1jscMA7agVQJgoQvzBjBWxKjiBIdKEfcf81f2dIv/rVypw3hbkAaoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5szf8TwFuAsz9A0LEeXgJT6P+vT32Z4m/UJu+0Anuc=;
 b=Slw2Ytg4WXOadXtNVqTGFJ8lRLQuyAEdo8hfj3oOODnmToU0oKOGWJ8mKOgNNM9l6v5QrdsE+7zO191yWO7NI1xNXT8mAohZ/JNPr3Tr8IBPcFKwBBJPn7jJhQm3kjEHVwNX5HZowb7lT3vq4t4iF4G9y00tXEEb/83yY3mSPE0pv2hlql2A4gAre1fIHHj2MTr87nEKXF0a27ZO6UF+inLE2PvOWcqZtJsFVoB98kXnzzZBKY7BC7fPbtvg6u+lxwbgjy/sO+6LQ/0N6ylHOQH1BdvSKw/HHzfqysOXwfVCCE0hH12E5fKhBLxl0MouHivUZqHZqIBeSa+1//R6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5szf8TwFuAsz9A0LEeXgJT6P+vT32Z4m/UJu+0Anuc=;
 b=QgGD0nxqIFar0Uf+siJYdSZOsB3OAYx+WQ2OSYwJ4jJU0BEtt1aYEyTQodAzKU742vVFfynZ8+u+UZKEM/4wRWhKxivkXpmBMnk6GPIDE3xnvK01Yv+n8f0BYMG6bPD1psypbW01AFba/1aGP7yVR2ALOWzeG3SNXgGI2vyLxVQgUdiBWmWZzP3rPbH4/gq/NGNzaBIPaenM/kTzt0AySwBCgoRwS2ifdj1qwmIK9C+K3zBQeFWK6Ak/oBPXsAxUSCKxLxEoD2++FP9+EHPnohHwGC4vb2OboRbFJdanNtaXriI1vgEGvUJ3ypnDT7VmdiO/n/kSiJb1GGo6Se3IMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 11:59:40 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::ec36:a1bf:b279:6539]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::ec36:a1bf:b279:6539%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 11:59:40 +0000
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
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
Date:   Thu, 04 May 2023 21:58:56 +1000
In-reply-to: <ZFLdDyHoIdJSXJt+@google.com>
Message-ID: <874josz4rd.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f4d0b7-9626-4ce5-a29c-08db4c970a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZVqLmv4iz5L1t9uIkvWLBMFWWSX0CPXAFL6j8GUtOwWKrYFs3K+d8Iy0f/SO/fU3Uqc2ROVg7NxV4R+xNbN9a3dCR974i3xFWoyJd5rFy4oyHU028iC287QQoHhjwYw4B99zAc3T6aXl3RqZRGxLjsfRG7RuoqEdY2rxu3DBapitepnrQtoXlsLfg1HF9a3jRDWB3kOXhSVHIEVtuPzBv7dd2c26w9h6XKXBzcCEmSKWCRtNsilBaHoimjzRQIPd8Rh6dLSWjcvaGN74OFYG4E6iHCukyPzodMPBiSASVWWjjW8uay7/lSY4+EgG69lmblvpPX9bSlIvpzjWGwVtbqgzLlybT99Va6UbqqgaWB4MeozBKVuXOvu9tgp2MOE8nEfCocJrYhY3NrjUsQCHeqS8mEQHxAGXC81eRa3J/0D4sT+KjKJeE71otL0ekjGhuqxKxvZHTjJKtNqtHMhBwIGgVhJnmpnLyZoQaMxOltvV/cbNG8jU3hacX8dtK0yhY2Ato5TOjxebXWRIfIyjijjvlc9rT0eYZyJ2znIXgHpSZHRscVhJpncm7lTl4R5X7FT4+6urKdCPP/+zXMXlIymUp/biGFMDaxDPrAYSR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(38100700002)(8936002)(8676002)(7416002)(5660300002)(83380400001)(2906002)(36756003)(316002)(6916009)(4326008)(66556008)(26005)(66476007)(6506007)(6512007)(66946007)(2616005)(6666004)(54906003)(966005)(6486002)(41300700001)(186003)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJXTk96YnpIdVpXSUZkVjl1REZRa1Z1K0N5N2lDSFc1RktUdVJEZ2NXSjl2?=
 =?utf-8?B?TCs0Y0VLZzRqMUpYdDZ6eWthN21MSlV3cExFTGZXM05OOEtiY2RkZGlncE5l?=
 =?utf-8?B?eTFTQlZ2YUhrT2Q0amp0dmpRTVpESEczK1YwelU5TkJncGowSmhmL1Z0Szk0?=
 =?utf-8?B?eWVpTW9tNDJKZnFRcWQ0NkxpRzRxeUVSU25lVnRaUTRZQm5sY1FLcDZHNkUr?=
 =?utf-8?B?TE5HeXNDNzNXcXFpeWVuaHlVOVh3a1hpQVZvcTNpeERkTXdtUXZWSmk3dzRn?=
 =?utf-8?B?RWJET21RU1NYanBYcFV2U0dnNFh6UzdDZnUvcDBaNHo1TzJKbmQvMnhsY2tv?=
 =?utf-8?B?QSsxaldqVVRBODQ5MnpnYnlDWGZYRm1yNHhhSlltQzAxdENoanluUGdCTkxh?=
 =?utf-8?B?UHVCRWczT2FYNWRsMGo3UXltdnFIK2Nja2VBekFTbi9WSDhhS01vd3hhTTVa?=
 =?utf-8?B?YmxlbmluWDA5YVU2aFpISVVQNk5YV1ovdGFBQVhHU3BqSXoxZG9UcThuUDlL?=
 =?utf-8?B?disyQlFBL1d1blVOREFxVkhWaWxGNytEdEU4OXRMMXBRNWZqRFY0L2tRcVRU?=
 =?utf-8?B?UE5JMDhtRHJDSEhRaHJZMjNOeTdLcyt3Uy8yTE5YK0gxVXNxazllUWoyd25H?=
 =?utf-8?B?NmEzMkhFZzRiOXdsWjNHME15NW95QzFjbVRINEVwa3lBMGFodXRBaGNYemZG?=
 =?utf-8?B?RHNkcmFlalQybWhDSnlBNHo4VHFZVnBCSGJ2WVhwSzF0U1dNeFVYRXR1YWpV?=
 =?utf-8?B?amRpeTdTZHdMejJTZ2VaZk13QWZqSEREaERaRkJjRkROdnlCTm9FK3RPbmIy?=
 =?utf-8?B?Q2M3SXNiSWxyTnViL0NyaEIzVUNOZHY5V0JaYThzTE9MSEJIQWlLWmNOdGpv?=
 =?utf-8?B?TDdKeDU5eUYydHRsdmJvUEozMDBBUEZDOERWMGtBTGR6WmdKMkJPb1Y3cTdv?=
 =?utf-8?B?eW00dWZYRUtUTUZ3dC83bHQ2cDQ3S0lieUdDQ0h0TFkraXc4bWM4cDJheUk0?=
 =?utf-8?B?VnptSklTLzM1M3BOcTU1VDV1QkFxZENvbS85eTVIMXluR2trejAwaWhaMW1W?=
 =?utf-8?B?RnhZQW9GTWIrL3B3Z05XYThaei9kWEJOQ1ljSjMvRisrY2JNTzF1eWJxaGYx?=
 =?utf-8?B?bFlnelkyV09COXcvVi9QV09ycHRvNU5hSERpWWVNU1BlV0UvQUlTZmtiMktx?=
 =?utf-8?B?K3RNNVZXZ0xJOHFJK0hRcW9GVGd4OU51THJ4RWJkdDlURWhVd3pJR3owNHNY?=
 =?utf-8?B?S1pjcVlBc1M5bHVOK0xuRE9SYlVXY3FBQWRnVkZZaWY5S04rOWVXQ0VwcTg1?=
 =?utf-8?B?cVJURVVzcUdyM0k5UlQ5cjBqdXVWTWd3MCtPSVV4RFNjR0J1MDdnQjBMbmpz?=
 =?utf-8?B?ZG4ySUZWd29EZy9xYVJWb09DaENZTGJrQjNpclpveXpsM1dHS1dGdEtKUmY4?=
 =?utf-8?B?cUhFN0hZckJQNXVnTm5PenRXVmp3Tzcza0xUVTJXeTE5TkFueFpoNmtjU2JD?=
 =?utf-8?B?NVFVd0dTU3YwcnI0T0JpcWZZOUpPMkpvclJCTVNhU25WdUdPbE8wSGsxaDNH?=
 =?utf-8?B?QUFVMkxLaXRYV0ZsQWJzblhNb3E0ZHgzS2pxWWdLemZrc3F6NEFSYldHWEhJ?=
 =?utf-8?B?MGg4SlRhcUtERHp5VnBJbVY2QklqcWg1ZkV4bEIwdXNJMUdmUUJSKzdrbDJP?=
 =?utf-8?B?RzBqelB5WWVjanJwTjMxTEpJbGdQMGZyaCt5SzJBbzB5VFVNbm5RbENlZENt?=
 =?utf-8?B?b3Y2d0lCcGN3dGk2eTk0UVN4Q1JJRDczZzFwMlNVV0lpL1VzMEJvalBQQTda?=
 =?utf-8?B?aGRhQnk2RW4wWFRuYndpMzRDNExQTTU3UUdzZHNCSnIxMkJUY1NNT2g3Z0Jv?=
 =?utf-8?B?cHZ0Ymt1ckRIWEVsMUhTRDZudEc4Vkw3aDRZM2libFk5NDBPNXlCbStyM1Nr?=
 =?utf-8?B?c2JCaWdPM0k4TU8zaUxaNEZMSEs0Umk3QjkxRnZOQzduczNPYXRaNWp5b0tE?=
 =?utf-8?B?NUQzaUVzNGFEYTA3MEVIdXViaFZLNWpaWmRreEY3WDlNclB3QWQ4MFdjdFAw?=
 =?utf-8?B?NEhlc3VialYrQ0E1MkN3bVloV0NjaXNYK005bktZTEdFbk52WlBycW44Njlx?=
 =?utf-8?Q?C5O6yx096OtdUpwbYnDPAT183?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f4d0b7-9626-4ce5-a29c-08db4c970a15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:59:40.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpdWSgXfbBR41TaKjway3XtasCRLWzWOoM7+y6kNTl+HsHSbDMuBJvipfld3VTn9QPMIbIsKdC7c+NQnmJF9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Chris Li <chrisl@kernel.org> writes:

> Hi T.J.,
>
> On Tue, Apr 11, 2023 at 04:36:37PM -0700, T.J. Mercier wrote:
>> When a memcg is removed by userspace it gets offlined by the kernel.
>> Offline memcgs are hidden from user space, but they still live in the
>> kernel until their reference count drops to 0. New allocations cannot
>> be charged to offline memcgs, but existing allocations charged to
>> offline memcgs remain charged, and hold a reference to the memcg.
>>=20
>> As such, an offline memcg can remain in the kernel indefinitely,
>> becoming a zombie memcg. The accumulation of a large number of zombie
>> memcgs lead to increased system overhead (mainly percpu data in struct
>> mem_cgroup). It also causes some kernel operations that scale with the
>> number of memcgs to become less efficient (e.g. reclaim).
>>=20
>> There are currently out-of-tree solutions which attempt to
>> periodically clean up zombie memcgs by reclaiming from them. However
>> that is not effective for non-reclaimable memory, which it would be
>> better to reparent or recharge to an online cgroup. There are also
>> proposed changes that would benefit from recharging for shared
>> resources like pinned pages, or DMA buffer pages.
>
> I am also interested in this topic. T.J. and I have some offline
> discussion about this. We have some proposals to solve this
> problem.
>
> I will share the write up here for the up coming LSF/MM discussion.

Unfortunately I won't be attending LSF/MM in person this year but I am
interested in this topic as well from the point of view of limiting
pinned pages with cgroups. I am hoping to revive this patch series soon:

https://lore.kernel.org/linux-mm/cover.c238416f0e82377b449846dbb2459ae9d703=
0c8e.1675669136.git-series.apopple@nvidia.com/

The main problem with this series was getting agreement on whether to
add pinning as a separate cgroup (which is what the series currently
does) or whether it should be part of a per-page memcg limit.

The issue with per-page memcg limits is what to do for shared
mappings. The below suggestion sounds promising because the pins for
shared pages could be charged to the smemcg. However I'm not sure how it
would solve the problem of a process in cgroup A being able to raise the
pin count of cgroup B when pinning a smemcg page which was one of the
reason I introduced a new cgroup controller.

> Shared Memory Cgroup Controllers
>
> =3D Introduction
>
> The current memory cgroup controller does not support shared memory
> objects. For the memory that is shared between different processes, it
> is not obvious which process should get charged. Google has some
> internal tmpfs =E2=80=9Cmemcg=3D=E2=80=9D mount option to charge tmpfs da=
ta to a
> specific memcg that=E2=80=99s often different from where charging process=
es
> run. However it faces some difficulties when the charged memcg exits
> and the charged memcg becomes a zombie memcg.
> Other approaches include =E2=80=9Cre-parenting=E2=80=9D the memcg charge =
to the parent
> memcg. Which has its own problem. If the charge is huge, iteration of
> the reparenting can be costly.
>
> =3D Proposed Solution
>
> The proposed solution is to add a new type of memory controller for
> shared memory usage. E.g. tmpfs, hugetlb, file system mmap and
> dma_buf. This shared memory cgroup controller object will have the
> same life cycle of the underlying shared memory.
>
> Processes can not be added to the shared memory cgroup. Instead the
> shared memory cgroup can be added to the memcg using a =E2=80=9Csmemcg=E2=
=80=9D API
> file, similar to adding a process into the =E2=80=9Ctasks=E2=80=9D API fi=
le.
> When a smemcg is added to the memcg, the amount of memory that has
> been shared in the memcg process will be accounted for as the part of
> the memcg =E2=80=9Cmemory.current=E2=80=9D.The memory.current of the memc=
g is make up
> of two parts, 1) the processes anonymous memory and 2) the memory
> shared from smemcg.
>
> When the memcg =E2=80=9Cmemory.current=E2=80=9D is raised to the limit. T=
he kernel
> will active try to reclaim for the memcg to make =E2=80=9Csmemcg memory +
> process anonymous memory=E2=80=9D within the limit.

That means a process in one cgroup could force reclaim of smemcg memory
in use by a process in another cgroup right? I guess that's no different
to the current situation though.

> Further memory allocation
> within those memcg processes will fail if the limit can not be
> followed. If many reclaim attempts fail to bring the memcg
> =E2=80=9Cmemory.current=E2=80=9D within the limit, the process in this me=
mcg will get
> OOM killed.

How would this work if say a charge for cgroup A to a smemcg in both
cgroup A and B would cause cgroup B to go over its memory limit and not
enough memory could be reclaimed from cgroup B? OOM killing a process in
cgroup B due to a charge from cgroup A doesn't sound like a good idea.

> =3D Benefits
>
> The benefits of this solution include:
> * No zombie memcg. The life cycle of the smemcg match the share memory fi=
le system or dma_buf.

If we added pinning it could get a bit messier, as it would have to hang
around until the driver unpinned the pages. But I don't think that's a
problem.

> * No reparenting. The shared memory only charge once to the smemcg
> object. A memcg can include a smemcg to as part of the memcg memory
> usage. When process exit and memcg get deleted, the charge remain to
> the smemcg object.
> * Much cleaner mental model of the smemcg, each share memory page is char=
ge to one smemcg only once.
> * Notice the same smemcg can add to more than one memcg. It can better
> describe the shared memory relation.
>
> Chris
>
>
>
>> Suggested attendees:
>> Yosry Ahmed <yosryahmed@google.com>
>> Yu Zhao <yuzhao@google.com>
>> T.J. Mercier <tjmercier@google.com>
>> Tejun Heo <tj@kernel.org>
>> Shakeel Butt <shakeelb@google.com>
>> Muchun Song <muchun.song@linux.dev>
>> Johannes Weiner <hannes@cmpxchg.org>
>> Roman Gushchin <roman.gushchin@linux.dev>
>> Alistair Popple <apopple@nvidia.com>
>> Jason Gunthorpe <jgg@nvidia.com>
>> Kalesh Singh <kaleshsingh@google.com>
>>=20

