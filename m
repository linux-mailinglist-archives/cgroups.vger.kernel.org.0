Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD06FA214
	for <lists+cgroups@lfdr.de>; Mon,  8 May 2023 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjEHIXQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjEHIWr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 04:22:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278321A130
        for <cgroups@vger.kernel.org>; Mon,  8 May 2023 01:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guoSoHukMZh3/9vGPeMUhDDrKKMfuIGopeRqvfiLKBMqvpq9i3ZI27sP90y4tpg0i8vUrV6ZwLdxN5yDxUL5TbpbjEoGvXkwiBWcllvzXzHWTPWYxIXwn9G7rPIv9vLwREDDgUQIqmyiGb5vPS+pGLPBXuHZQKLh2B06+NWpjVj6fXW81leTGYRnkspgrJfvJuZivhDz9mNsqPvK/YR48wV2iYStplq51gYP5R6b+Spu3UbCcWZNlAZp0d13CbcC1xFr+SBSa5Cp03E5tnqgjiZ4Zk2JiiB7dTV7A6pGr5Uc2Kw79hkyR7jbyNY/6M/w3kn4jl49Q4Cc4OBmGeAZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZYqlWBIOQb7Beaw5luDQ+ZrBuPRiMyUf1eS0TLTTRw=;
 b=NgQMoZxZ5IaDOhIdPOGYhvIr0XBmMLnRZ3epT49yfGBqwgj/5uqAbiEyYTIZ6sc1wqwMsQ8JpoBHUaOm60mo3RuZBC4/VqaLy11wT0lRqwn3RU1LcPTCoxLXoM2Xg7xrPAgfjypKe2XTegwycT2VzDeseuAFvg8n0UiPB483intxV24ImkRdWFWP9UXUTGgEfTZa/1r5X43re8PAKgIpDtIX+15hHHvArsYNZkpiYLEJSXO1+D2SGL8CRnUyP3VNs6oaAA8hvXRRCxGRgjtnVsBtB39JyDDMVOrJQ8YSshedDfVhAqfsiK3GftpTLO2IFZhdv3QKYF0xKpIWL35+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZYqlWBIOQb7Beaw5luDQ+ZrBuPRiMyUf1eS0TLTTRw=;
 b=r+sGJHCToRJzvlvaZ6AWgm++v7ASryxXJa8WnMDg3qVoUaKK6QCIdCBr9C+vLDeYW6WTJxF3RSuBExKeeTIj6SzbkNsfplB11HcWwn/Qfvn1wFz7WK73+RGcZARnj4eDi/h0eJu6+4DqR8JPlHJX20nPTNQvK/SU5h0PTTgcUwjhTQQaluueSP5Y1xQWofSJcPxwGjLTf0QkqH24C3Yp4MxH5JlSi2kUJ8m4HWEB8U3al4Vxf6G6QwFbV/tw4YDeNk0hXn2zJgPesQD0tj63Yo5y93ZjiH1pzgc18nS1h7BW4L8Os3lG4mUBYVSw7gZqNeHM7DC30kuLpdsanDHenQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:22:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9%5]) with mapi id 15.20.6363.026; Mon, 8 May 2023
 08:22:42 +0000
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com> <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com> <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
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
Date:   Mon, 08 May 2023 18:17:04 +1000
In-reply-to: <ZFbZZPkSpsKMe8iR@google.com>
Message-ID: <87ttwnkzap.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6b8d7f-d215-4b19-3c6d-08db4f9d6473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xV+fIU0nBlPx903olEVhzMUy5fz3nzOabkLYMhEMvzq8zlrBSMkDvlHn0Kpv11tGnMry4FX1jFUb10KgYI5dPMWWZeouD+UP7DnMsOMZlGTFG7UBrKF8o5uWtXnQs24vMCElGvZXpWCjblkcdFuJOlbj4Gy/iL+cmA4OzrVSvZYiuPeIg4oPyihJoOqKljkXwsPC26eCYZhL79TjbQ+2fwRNVvQEm0WorIDQi7WG2zo9rf/G8U1iQBMyMBlk5eq3CaswO7YCDZW3xBYvtDWpjmGV8Z8FR9bRgjy87+AR94GdAAO0bgcj49WXnnr4UqrtWu08obR1HqBX+7Y1GQeXfyck5TEcsUeMTtGskkPYNBnTipCrd6dpW+P6qy0K7OcOoVM06xyqTJtp2V29tdEHUdtk4+JHAS63cz1TN5DQB9WMncbjz3b7HHh75jU4XT6ZkNSqDAfA3+12szNhh6vN3L+o2NqpMJPvbcNVH6yAOjCdG7bRo9twY18uUZroIe0Nj80fr+xDxIMOG3vgbG9hb5RgdnPiHNzwiZUYTrxEiWMG+Ql8A1CmKsG2A5Uux7a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(5660300002)(7416002)(54906003)(6486002)(41300700001)(6666004)(8936002)(8676002)(316002)(26005)(6512007)(6506007)(30864003)(66476007)(478600001)(66556008)(66946007)(4326008)(6916009)(66899021)(83380400001)(2616005)(186003)(2906002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHhSZDc3SVNmdkRxd2toc2pEMU5sRitORld0NlFuRUkyc1NJNThhKysyeDYr?=
 =?utf-8?B?TjM0WHJUb2xNK0J0V2RRM3UzNDJ5SVRKbW1vZExjMVhRQXErVlg0Y1YrMGdO?=
 =?utf-8?B?c1NodFFCM3lUeVpKby9DM21ZNU5UY09STVJMZXVCZmY5eTRnRGxvYWFuR3dH?=
 =?utf-8?B?TDF6M01tWTM1V3JpS2h3UmxUR3lCQjhHWEo5ZStaZGFlU0Vtek9TL25ROGYz?=
 =?utf-8?B?cFMwOTNwaEt2bXdlVy9ndXFiL1ZyUzNwTXEwNnBjOWhZcjY4QkhEWE93bFl0?=
 =?utf-8?B?RHYyMVA4WlJEUnZSOWVINEdLNGYyN0JUZ2pnRnpOSWFSMnRwVm95c2kveDRS?=
 =?utf-8?B?bG16NEEvazZMMFlUSlN6ckF2Y05Jd2I2cThYaXpRcU9xSFJRYkxuS0lxY1Zn?=
 =?utf-8?B?cm9jRU51WTAvUjFwOVJDbXY3TWR3MmR1UVBNVDNqNDRoZmJDOUpLSGZjQ3p1?=
 =?utf-8?B?UEVXWGdPaEthL0tQV1dCZWwwaS9HaWlMNG5PaXFVSDBYRXlPYStwWjA1eWY1?=
 =?utf-8?B?MURxZVhodGlHcW9GZ3BEcVhwQ21wOHBISVB6dmhFYm5aRDVTTTRyUk1wWUx5?=
 =?utf-8?B?QTZMbHJENnlINXlsWU5ieVg1TktsOS9acTF5RG44OXg2cGN4UG5ZemRBQlFW?=
 =?utf-8?B?L2hKbFJ2OVJpbkJ6TnBpbFBBTkdwaXd5TnRmN2lSOG5VenJFbTBZeEZ4NWRh?=
 =?utf-8?B?VVdMUW1CSTJENmZSWTR5R3A2ZlZTbWw3Q0hNbWVzeDdvWTNFSk41L1piR3Vq?=
 =?utf-8?B?TmtpcmFIRzFOY2F6bDB4QXB5bmQraFNPMHZMV3RMSmc2K2JUVURHQWdvUU5R?=
 =?utf-8?B?UGcrVkJrSVpmcEw3Vm5iT2NCYzdPUFlUN2dEUU9kaGo5R2oxSjVxRDY1WGZ6?=
 =?utf-8?B?aHB0L1M1VXJoay9wNFpoeEM5cGhWTVpKSHZiVzYya2RFWlFXNEEwcU5hMyt5?=
 =?utf-8?B?MWRtd3I1cW13TERWeVdKSUwva0JRR2R3RkdDQkRkWVVLVDEzVDdWZXR6RXZC?=
 =?utf-8?B?TG1KdTZVb2pMUkd6cU1NMzhpRmdXY0U1TU13dmYvK2VKRjNoY0k3UzNzeTU4?=
 =?utf-8?B?aTVnTW4rajlOdGo0OTNZd0FSK1pXcHkyc2Vra3FhNFRES2ozMTJuN3FHTVE0?=
 =?utf-8?B?RDJZNFRuQml3V2Z0dllKZTlEdk0zU0w0bUJyckludmlxWllhMTlzblNrZkcw?=
 =?utf-8?B?K3dFYXNPemY0bHYvUm53UEF4UUJlRzJra2tsRjNiY1RUc283R1k5QVQ4clZr?=
 =?utf-8?B?MXJHNVN2cDRRRXM2b0c3WjEyNHY4c0l3SzlIUEtWeGsxcVpQMjVXZjkwTDNs?=
 =?utf-8?B?NlpHRitHcUZoQ2tncytpNFkrU3lnc08zYVRmbjQwRm9FUTlWaS9oRjlWRFgx?=
 =?utf-8?B?bVl3MStiKzNmNU9JakJ4TGhFRTBIV2YrelR3M1FvSzFTWlo2T2hxaW1VU1hh?=
 =?utf-8?B?QWxORG1pSTRmakVJZmxCNW9OckF2K0tOQlBYTEF2V0JiOTQwYTloZEdIL3RW?=
 =?utf-8?B?VWtnczIrb2ZzZy81MlN5OUhGQS9oN0U2RXhJY21aUU9ITThkKzVlRjVWcE92?=
 =?utf-8?B?cXQ1TWEzNWR5d0NjM3dkOTJna3JZVEszaG5KcXdqUEFzTkdFQkcvQlpISWIx?=
 =?utf-8?B?bGVIWk5ETUcvK292OUUreHQ3YlcxRW9tc2JiUzg1OHFmRmNDdHZjQ1haUnhv?=
 =?utf-8?B?NHIxejVkMmVwRjVvbEpDVndlTkZLMWhiSUpuS3NnYnVXME9PdVhNRExJTHgz?=
 =?utf-8?B?RkEwU2dZeHBGVnc0dmFUYTRTNi8xaGtwTGpMY0tIQXNjdW5sYWVLazROQ1Ax?=
 =?utf-8?B?S1dhTjRyMlFtcDB6ZjI2MFpCcFlkUUo4cEIvbmJINGhRZ3JleVRneGVIN1dN?=
 =?utf-8?B?RlpIRmxlUzM1U2dVenRGOTJ6V3ZtTFMzNTJnSEFYcjNSbm9pSkowZzVRUFZ0?=
 =?utf-8?B?YWk4RE1ISndmZVZVaWk4WGQvZTF1ajlFRzE1SU5pU1ptaElYNVFKL3ZZVEhn?=
 =?utf-8?B?alhvUHc3VkFEMitRZ2RnL1hoNlJ4czUySjExZXd4VExRTlJ2NW93UUZseDhp?=
 =?utf-8?B?MXgyVC9Sa21weHpmaExuUFcwUCtUWDZpbWMyYVk1dXhvb2g3VnBqd1paWUJw?=
 =?utf-8?Q?XJNcrgQpjerasRK4VJXme6OZL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6b8d7f-d215-4b19-3c6d-08db4f9d6473
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 08:22:41.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz9hFqME70aC3ZVLUP1LgOOSSA2jPYtRFgjX+QlVO1ZstoihReU0wlY5uS7qNal72UVLNETQnrz+WvOSxQBV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Chris Li <chrisl@kernel.org> writes:

> On Fri, May 05, 2023 at 11:53:24PM +1000, Alistair Popple wrote:
>>=20
>> >> Unfortunately I won't be attending LSF/MM in person this year but I a=
m
>> >
>> > Will you be able to join virtually?
>>=20
>> I should be able to join afternoon sessions virtually.
>
> Great.

Actually I don't have an invite so might not make it. However I believe
Jason Gunthorpe is there and he has been helping with this as well so he
might be able to attend the session. Or we could discuss it in one of
the Linux MM biweeklies. (TBH I've been busy on other work and am only
just getting back up to speed on this myself).

>> >> The issue with per-page memcg limits is what to do for shared
>> >> mappings. The below suggestion sounds promising because the pins for
>> >> shared pages could be charged to the smemcg. However I'm not sure how=
 it
>> >> would solve the problem of a process in cgroup A being able to raise =
the
>> >> pin count of cgroup B when pinning a smemcg page which was one of the
>> >> reason I introduced a new cgroup controller.
>> >
>> > Now that I think of it, I can see the pin count memcg as a subtype of
>> > smemcg.
>> >
>> > The smemcg can have a limit as well, when it add to a memcg, the opera=
tion
>> > raise the pin count smemcg charge over the smemcg limit will fail.
>>=20
>> I'm not sure that works for the pinned scenario. If a smemcg already has
>> pinned pages adding it to another memcg shouldn't raise the pin count of
>> the memcg it's being added to. The pin counts should only be raised in
>> memcg's of processes actually requesting the page be pinned. See below
>> though, the idea of borrowing seems helpful.
>
> I am very interested in letting smemcg=C2=A0support your pin usage case.
> I read your patch thread a bit but I still feel a bit fuzzy about
> the pin usage workflow.

Thanks!

> If you have some more detailed write up of the usage case, with a sequenc=
e
> of interaction and desired outcome that would help me understand. Links t=
o
> the previous threads work too.

Unfortunately I don't (yet) have a detailed write up. But the primary
use case we had in mind was sandboxing of containers and qemu instances
to be able to limit the total amount of memory they can pin.

This is just like the existing RLIMIT, just with the limit assigned via
a cgroup instead of a per-process or per-user limit as they can easily
be subverted, particularly the per-process limit.

The sandboxing requirement is what drove us to not use the existing
per-page memcg. For private mappings it would be fine because the page
would only ever be mapped by a process in a single cgroup (ie. a single
memcg).

However for shared mappings it isn't - processes in different cgroups
could be mapping the same page but the accounting should happen to the
cgroup the process is in, not the cgroup that happens to "own" the page.

It is also possible that the page might not be mapped at all. For
example a driver may be pinning a page with pin_user_pages(), but the
userspace process may have munmap()ped it.

For drivers pinned memory is generally associated with some operation on
a file-descriptor. So the desired interaction/outcome is:

1. Process in cgroup A opens file-descriptor
2. Calls an ioctl() on the FD to pin memory.
3. Driver charges the memory to a counter and checks it's under the
   limit.
4. If over limit the ioctl() will fail.

This is effectively how the vm_pinned/locked RLIMIT works today. Even if
a shared page is already pinned the process should still be "punished"
for pinning the page. Hence the interest in the total <smemcg, memcg>
limit.

Pinned memory may also outlive the process that created it - drivers
associate it via a file-descriptor not a process and even if the FD is
closed there's nothing say a driver has to unpin the memory then
(although most do).

> We can set up some meetings to discuss it as well.
>
>> So for pinning at least I don't see a per smemcg limit being useful.
>
> That is fine.  I see you are interested in the <smemcg, memcg> limit.

Right, because it sounds like it will allow pinning the same struct page
multiple times to result in multiple charges. With the current memcg
implementation this isn't possible because a page can only be associated
with a single memcg.

A limit on just smemcg doesn't seem useful from a sandboxing perspective
because processes from other cgroups can use up the limit.

>> > For the detail tracking of shared/unshared behavior, the smemcg can mo=
del it
>> > as a step 2 feature.
>> >
>> > There are four different kind of operation can perform on a smemcg:
>> >
>> > 1) allocate/charge memory. The charge will add on the per smemcg charg=
e
>> > counter, check against the per smemcg limit. ENOMEM if it is over the =
limit.
>> >
>> > 2) free/uncharge memory. Similar to above just subtract the counter.
>> >
>> > 3) share/mmap already charged memory. This will not change the smemcg =
charge
>> > count, it will add to a per <smemcg, memcg> borrow counter. It is poss=
ible to
>> > put a limit on that counter as well, even though I haven't given too m=
uch thought
>> > of how useful it is. That will limit how much memory can mapped from t=
he smemcg.
>>=20
>> I would like to see the idea of a borrow counter fleshed out some more
>> but this sounds like it could work for the pinning scenario.
>>=20
>> Pinning could be charged to the per <smemcg, memcg> borrow counter and
>> the pin limit would be enforced against that plus the anonymous pins.
>>=20
>> Implementation wise we'd need a way to lookup both the smemcg of the
>> struct page and the memcg that the pinning task belongs to.
>
> The page->memcg_data points to the pin smemcg. I am hoping pinning API or
> the current memcg can get to the pinning memcg.

So the memcg to charge would come from the process doing the
pin_user_pages() rather than say page->memcg_data? Seems reasonable.

>> > 4) unshare/unmmap already charged memory. That will reduce the per <sm=
emcg, memcg>
>> > borrow counter.
>>=20
>> Actually this is where things might get a bit tricky for pinning. We'd
>> have to reduce the pin charge when a driver calls put_page(). But that
>> implies looking up the borrow counter / <smemcg, memcg> pair a driver
>> charged the page to.
>
> Does the pin page share between different memcg or just one memcg?

In general it can share between different memcg. Consider a shared
mapping shared with processes in two different cgroups (A and B). There
is nothing stopping each process opening a file-descriptor and calling
an ioctl() to pin the shared page.

Each should be punished for pinning the page in the sense that the pin
count for their respective cgroups must go up.

Drivers pinning shared pages is I think relatively rare, but it's
theorectically possible and if we're going down the path of adding
limits for pinning to memcg it's something we need to deal with to make
sandboxing effective.

> If it is shared, can the put_page() API indicate it is performing in beha=
lf
> of which memcg?

I think so - although it varies by driver.

Drivers have to store the array of pages pinned so should be able to
track the memcg with that as well. My series added a struct vm_account
which would be the obvious place to keep that reference. Each set of pin
operations on a FD would need a new memcg reference though so it would
add overhead for drivers that only pin a small number of pages at a
time.

Non-driver users such as the mlock() syscall don't keep a pinned pages
array around but they should be able to use the current memcg during
munlock().

>> I will have to give this idea some more tought though. Most drivers
>> don't store anything other than the struct page pointers, but my series
>> added an accounting struct which I think could reference the borrow
>> counter.
>
> Ack.
>
>>=20
>> > Will that work for your pin memory usage?
>>=20
>> I think it could help. I will give it some thought.
>
> Ack.
>>=20
>> >>=20
>> >> > Shared Memory Cgroup Controllers
>> >> >
>> >> > =3D Introduction
>> >> >
>> >> > The current memory cgroup controller does not support shared memory
>> >> > objects. For the memory that is shared between different processes,=
 it
>> >> > is not obvious which process should get charged. Google has some
>> >> > internal tmpfs =E2=80=9Cmemcg=3D=E2=80=9D mount option to charge tm=
pfs data to a
>> >> > specific memcg that=E2=80=99s often different from where charging p=
rocesses
>> >> > run. However it faces some difficulties when the charged memcg exit=
s
>> >> > and the charged memcg becomes a zombie memcg.
>> >> > Other approaches include =E2=80=9Cre-parenting=E2=80=9D the memcg c=
harge to the parent
>> >> > memcg. Which has its own problem. If the charge is huge, iteration =
of
>> >> > the reparenting can be costly.
>> >> >
>> >> > =3D Proposed Solution
>> >> >
>> >> > The proposed solution is to add a new type of memory controller for
>> >> > shared memory usage. E.g. tmpfs, hugetlb, file system mmap and
>> >> > dma_buf. This shared memory cgroup controller object will have the
>> >> > same life cycle of the underlying shared memory.
>> >> >
>> >> > Processes can not be added to the shared memory cgroup. Instead the
>> >> > shared memory cgroup can be added to the memcg using a =E2=80=9Csme=
mcg=E2=80=9D API
>> >> > file, similar to adding a process into the =E2=80=9Ctasks=E2=80=9D =
API file.
>> >> > When a smemcg is added to the memcg, the amount of memory that has
>> >> > been shared in the memcg process will be accounted for as the part =
of
>> >> > the memcg =E2=80=9Cmemory.current=E2=80=9D.The memory.current of th=
e memcg is make up
>> >> > of two parts, 1) the processes anonymous memory and 2) the memory
>> >> > shared from smemcg.
>> >> >
>> >> > When the memcg =E2=80=9Cmemory.current=E2=80=9D is raised to the li=
mit. The kernel
>> >> > will active try to reclaim for the memcg to make =E2=80=9Csmemcg me=
mory +
>> >> > process anonymous memory=E2=80=9D within the limit.
>> >>=20
>> >> That means a process in one cgroup could force reclaim of smemcg memo=
ry
>> >> in use by a process in another cgroup right? I guess that's no differ=
ent
>> >> to the current situation though.
>> >>=20
>> >> > Further memory allocation
>> >> > within those memcg processes will fail if the limit can not be
>> >> > followed. If many reclaim attempts fail to bring the memcg
>> >> > =E2=80=9Cmemory.current=E2=80=9D within the limit, the process in t=
his memcg will get
>> >> > OOM killed.
>> >>=20
>> >> How would this work if say a charge for cgroup A to a smemcg in both
>> >> cgroup A and B would cause cgroup B to go over its memory limit and n=
ot
>> >> enough memory could be reclaimed from cgroup B? OOM killing a process=
 in
>> >> cgroup B due to a charge from cgroup A doesn't sound like a good idea=
.
>> >
>> > If we separate out the charge counter with the borrow counter, that pr=
oblem
>> > will be solved. When smemcg is add to memcg A, we can have a policy sp=
ecific
>> > that adding the <smemcg, memcg A> borrow counter into memcg A's "memor=
y.current".
>> >
>> > If B did not map that page, that page will not be part of <smemcg, mem=
cg B>
>> > borrow count. B will not be punished.
>> >
>> > However if B did map that page, The <smemcg, memcg B> need to increase=
 as well.
>> > B will be punished for it.
>> >
>> > Will that work for your example situation?
>>=20
>> I think so, although I have been looking at this more from the point of
>> view of pinning. It sounds like we could treat pinning in much the same
>> way as mapping though.
>
> Ack.
>>=20
>> >> > =3D Benefits
>> >> >
>> >> > The benefits of this solution include:
>> >> > * No zombie memcg. The life cycle of the smemcg match the share mem=
ory file system or dma_buf.
>> >>=20
>> >> If we added pinning it could get a bit messier, as it would have to h=
ang
>> >> around until the driver unpinned the pages. But I don't think that's =
a
>> >> problem.
>> >
>> >
>> > That is exactly the reason pin memory can belong to a pin smemcg. You =
just need
>> > to model the driver holding the pin ref count as one of the share/mmap=
 operation.
>> >
>> > Then the pin smemcg will not go away if there is a pending pin ref cou=
nt on it.
>> >
>> > We have have different policy option on smemcg.
>> > For the simple usage don't care the per memcg borrow counter, it can a=
dd the
>> > smemcg's charge count to "memory.current".
>> >
>> > Only the user who cares about per memcg usage of a smemcg will need to=
 maintain
>> > per <smemcg, memcg> borrow counter, at additional cost.
>>=20
>> Right, I think pinning drivers will always have to care about the borrow
>> counter so will have to track that.
>
> Ack.
>
> Chris

