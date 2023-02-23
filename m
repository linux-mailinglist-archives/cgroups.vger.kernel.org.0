Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6D6A00E4
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjBWByD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 20:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjBWByC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 20:54:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44AFCDE3;
        Wed, 22 Feb 2023 17:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYLK4W+k3lHg0TVv/f6uc8XzEaxeGpoxrHN3l9nFa15OEM3gOSaWmNbTF0wpoVTMDsF+qXazy67u9xN3VxA/0neR8/gG8wNP775ioJMv9PdNcoIDbm67aD17DoXpKLOXOJioYIaplRmyUzDnpKi6r432kHazqoGdDbYxXOjTbkmVknbhF8IlIJiF6+q2fJ+mSE8UqmG/BpEmrM+w5EHt+HM0eUUwkVUuJ+OkKrRS7WMLa48ZyQsM7izsWxpkPrb1M2xBv2VBcFtgWLDm0ImDstVpwYFTqvFvVf7PU1k2I4xZvz+h1z71qFc+1yMwtYYQysmznio6HpFhEd6bGGd6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VSvVJDLYm3I4TVhgPviimt37DwUtMl1cULco1UlQLk=;
 b=FrCkk0UoO69sbLjPQgOS6F3by+QSH66Y4wtM/QGfPNisozk15VZCfpKibSd8SDA5XoglcBOXoBw1qI7fWT/FXcYSYuXVS4II+RA0KzkDjkFJFWpALunBe0mWU5JKfRv9ibymqcSyvdHZEPGowbmyUlY9rcGWeRRmxKDyD5xXu6a+PXAOe5hr2zd88Xb3ritlKasVDFTmp8sdnJEXo9StQ7hGVp4uCcyJqF613ibJlq6K6bWbuMOInDHSjGYrw/ve7NsvXt2+gMOblcGeRV5i6qnQWXM5/bXhylR7PUL1mympSvT0idftF+Y3Q843O2dF6t1AlvDLswgxE8VqCGIi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VSvVJDLYm3I4TVhgPviimt37DwUtMl1cULco1UlQLk=;
 b=bOpQo3Od3xaxzT3jCmjSOW/RN+6DFEuTM3Ci9nqjb1X/7uqP5NZ5Hk3wJqWoFefnFXgzPl1VaK5ywKXgi74Org5nDJctbCjKAT2ZEMV0ohWoPYHSHP2HA76wKJevWlrbwLprTkoX/4vkukRnGfmq1Z0cOH+ciYdwNSweQ1Fb9YZfsYiAgug4cocqZESYjt6pRzaid3w6/ETaSg8vWeMFW9HNf5MuXSLVQ9PZCHa4a3rG26s1QNlbbbr7n2cRvKQlP8azVXzJatOJqO4Uh3Wg6+CP4zCncGi4svAWH7Uo5XZULbu3c/SelWXoitcsLYaww056uk170umjF9b9cM+1lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 01:53:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 01:53:58 +0000
Date:   Wed, 22 Feb 2023 21:53:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/bHNO7A8T3QQ5T+@nvidia.com>
References: <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k009nvnr.fsf@nvidia.com>
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: b63d4094-47df-4f5f-17ca-08db1540d3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVRVIMlPaItfaJPWiKT3CncKvsYqLixUAZ/oq1zhiEsD1VsZtMB6YeNMocvr8Cppf0cDeTRW+NXL5xh4fRrCHW2VuafoxsX8meZ2Wjwg9ynw6/OhYURz2kK6CA4Fv8/s5RwU0x2uI9Hpq9ZhDvO6+Oa5KoUkjShZLMmcSM4zAjy+B45Hx/BbxPkfE9fSPwnBksW0ce0ywMIfsOjILp3G0pAGuDWGi3gUP7B7K0mMFFzJpIMlUVpIlonCiBpiXeb344warp8dYNV4weCv1LHybcVUQ5/3WetRI1G0QJdQ1DZcw3KwhlvQityJCxtf3bf8Go56lZGQZzOtXLo88YiJdKKjAZ7335hXdfwXUlg2o7fIl7CnEa08LbmdMbcEfzupv0G5IYyn9vjyvOZJWatwjouWOyUfglSea8Twl04aQz+Z40+DsQk3r2MdDkIcZ/16W1VaTrFbtywdsChIDAczT0oWPmz6m6WGBZ68C6bgeNw8KRwcBEsjkEfHu/Vs1eVreLzr4E6pSE78qEbTGMaSWON++4/oEqBqK3qa9k+DvKOApcBndGLbcKvrZg9K4wuczpJcZz+bH8tXTgV6Z3NtB8oJiyw3bf8ZaNPu5ywQHfOY8KhaX2z2JjTxYka25kGbENoc8u/07AXQLq96wZRdcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(66946007)(6636002)(54906003)(83380400001)(316002)(37006003)(6506007)(478600001)(4326008)(186003)(41300700001)(26005)(2616005)(6512007)(5660300002)(86362001)(8936002)(2906002)(7416002)(6862004)(66556008)(66476007)(6486002)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?58vWHRxx/J5K5EnV6Au/F9xn9ZHc3dy7B/ZEw6UaWYjdkd9IUNuai0qvkcOC?=
 =?us-ascii?Q?+BOfJWRryF1Iw16MEbQX6mjP65cep51p8zsWL8TMuvRahXt8h/vT7GLK/a+K?=
 =?us-ascii?Q?ew/xWb2W8JNnt8B62m+9baa74P90wlZe3F/c27IjteELTtjW/zmcV9JEDqjq?=
 =?us-ascii?Q?Gr3sTYpzMZLXpUCgo1VxIdYzOHx2M2Zrb3XtS+DK6M92q2VdP7sJCY0xJwF2?=
 =?us-ascii?Q?hh84Fg9mqdsKurwT6SMG1Ww8Uwvmu7vUQI2L6XT3k7uRx/0z5XxyBXv/sk/W?=
 =?us-ascii?Q?qT7BxsE4SHThQZZu7/oGRjiV8kXrrFUmOWpNJQvv8wzAnLrSTTAiB9yrSqM9?=
 =?us-ascii?Q?UhQjUbC9svYt08nJ8H2iN2abvPFdJyEhnXwm02VrOVfyqqUc0aT+4UeppGMn?=
 =?us-ascii?Q?w1dMsAUwRPLjZuAoNxKaMmg5ITHd8LWUWAsMdwHmEyKLSnho0f+h4wCvZ8Du?=
 =?us-ascii?Q?rV7nLsGXMIvQI6srzoObmA0P3S0FcD57I2J6IRXlMuju7y/JDzj5q/D8W/Ep?=
 =?us-ascii?Q?7SAkz8/CN4TjSU2iCEjPshyZhho/Q4IDD9aCH8qqa3k/HrXIic6K4iYzl0Jq?=
 =?us-ascii?Q?KV5k5nrUf6ynZfgk5IK9ZFVGKNtx+O7Uw6n7XCIZYUXBHbAuRenJJVEr/s6x?=
 =?us-ascii?Q?X7atA4ycY4qnF49GQ7bcfMe6W7w+cuQvQ8M7yFK6UZXPuLAFVu4ERJGFrfqq?=
 =?us-ascii?Q?WioY4IYUQlOQxFldndei/QxdPC3Ry8jRH/7d/y/ObjKRJmA7a4fb1jPrMegt?=
 =?us-ascii?Q?IcfglwFO09tatAzhzSkomu0QnI3uXGh8Yt3DAiQ/M3jW5oT/IPq1wSVGGAWg?=
 =?us-ascii?Q?ZH7RItbP3JombDx7G4Vwrq2jt+mh9l1pxggXdZ6CXFkk6McsB+o28Gnj7gIF?=
 =?us-ascii?Q?MXHJIxJMdlT91JotbnQAihVxpbEiQjBc7ET7QkuHIx8Z6PB5D6+Yzj70Q1eQ?=
 =?us-ascii?Q?xZtXOH2b/M2XxwRl2JnEPHYkdyH6dPh9xB+0x09T7cvI/50yCWwHpmVbKnMp?=
 =?us-ascii?Q?qXn3+upZpkOdfcfAf8b13GzifyY08kRDqek2GDi4W7DwgqBlzlVimhWyzPPn?=
 =?us-ascii?Q?wYDoxpI9lzJMwHtU6CLRrZ4lTXk62GvhRa7e8Rq2FiarP2dHWMS4PhXLf2XK?=
 =?us-ascii?Q?sYciAsExdfT+eoo2hDZ2j6fgfbfAuoF0urwI0W7hB38od2qinSzVePya/8O5?=
 =?us-ascii?Q?QDh/kRsesAB3IMjJYoe+LNJ1bVn72VfdAEwylI+Sb5hkvdDAWz9XF6Pm8tLW?=
 =?us-ascii?Q?IPbpI+dq6S7KTcnmsUmznFcxiTeA/GsNWbOZufweYO6CIqbA1GtT2f68XeXt?=
 =?us-ascii?Q?bpHleXW8M54WOzeyMAbXY64LdMCGn2ZPUXtro/fXlE0J4RjjxOSSrMs1XDfr?=
 =?us-ascii?Q?rrMQNwwImPQe0q83BQJVG8nBji4xiVyPSPVUcakoeoDAnl3IR6T2fxA7T98B?=
 =?us-ascii?Q?daxD7MPegFzrpN+NSSeYTlL1dEMrbGtr+2idiMgXezq+YnacABWXZ72LkvFM?=
 =?us-ascii?Q?c2YU1rsojDbDdmSBVtFz2wXGcuux2yLOJGrqYkdTis6ycKTaqpmC0AWGf21U?=
 =?us-ascii?Q?ugUydk2r5GpDt9dhVmYf8qsXj2fI0RYKs9hWiuVc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d4094-47df-4f5f-17ca-08db1540d3c3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 01:53:57.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56I4QJdC8L1YDG6Hzkz+a/7yjDkLVs40jIukv0SxHe2fzYr6t9Usou9OdaHe7yPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 09:59:35AM +1100, Alistair Popple wrote:
> 
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Wed, Feb 22, 2023 at 10:38:25PM +1100, Alistair Popple wrote:
> >> When a driver unpins a page we scan the pinners list and assign
> >> ownership to the next driver pinning the page by updating memcg_data and
> >> removing the vm_account from the list.
> >
> > I don't see how this works with just the data structure you outlined??
> > Every unique page needs its own list_head in the vm_account, it is
> > doable just incredibly costly.
> 
> The idea was every driver already needs to allocate a pages array to
> pass to pin_user_pages(), and by necessity drivers have to keep a
> reference to the contents of that in one form or another. So
> conceptually the equivalent of:
> 
> struct vm_account {
>        struct list_head possible_pinners;
>        struct mem_cgroup *memcg;
>        struct pages **pages;
>        [...]
> };
> 
> Unpinnig involves finding a new owner by traversing the list of
> page->memcg_data->possible_pinners and iterating over *pages[] to figure
> out if that vm_account actually has this page pinned or not and could
> own it.

Oh, you are focusing on Tejun's DOS scenario. 

The DOS problem is to prevent a pin users in cgroup A from keeping
memory charged to cgroup B that it isn't using any more.

cgroup B doesn't need to be pinning the memory, it could just be
normal VMAs and "isn't using anymore" means it has unmapped all the
VMAs.

Solving that problem means figuring out when every cgroup stops using
the memory - pinning or not. That seems to be very costly.

AFAIK this problem also already exists today as the memcg of a page
doesn't change while it is pinned. So maybe we don't need to address
it.

Arguably the pins are not the problem. If we want to treat the pin
like allocation then we simply charge the non-owning memcg's for the
pin as though it was an allocation. Eg go over every page and if the
owning memcg is not the current memcg then charge the current memcg
for an allocation of the MAP_SHARED memory. Undoing this is trivial
enoug.

This doesn't fix the DOS problem but it does sort of harmonize the pin
accounting with the memcg by multi-accounting every pin of a
MAP_SHARED page.

The other drawback is that this isn't the same thing as the current
rlimit. The rlimit is largely restricting the creation of unmovable
memory.

Though, AFAICT memcg seems to bundle unmovable memory (eg GFP_KERNEL)
along with movable user pages so it would be self-consistent.

I'm unclear if this is OK for libvirt..

> Agree this is costly though. And I don't think all drivers keep the
> array around so "iterating over *pages[]" may need to be a callback.

I think searching lists of pages is not reasonable. Things like VFIO &
KVM use cases effectively pin 90% of all system memory, that is
potentially TB of page lists that might need linear searching!

Jason
