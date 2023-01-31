Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E60682F0E
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjAaOVN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 09:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAaOVN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 09:21:13 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFEF227BE;
        Tue, 31 Jan 2023 06:21:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG/iYU60l8/AjzF31i1E3J82jWzw8Ew+RmhMRPxRtN/CQTIrO93sdIO6XjhdFFh0P6Nn2CsZibZsg4+UEMMGVZV+++dyVu5UqTkSZDayGaAX735CgeyaMGzrbesOdotc1UxaADlwk80EHWk66qpShNfkxjDRnwugZkR4o4tFh9+CKJXDT0egZDsCkPTey4CCOewxGNWtoz6TAvn7pqYmP1bq0mmIPfHgqgZ6XIAB59f0sOEI3leA9NQHp+6BAjz+GemLL2UbzW+lkbHdZ+RwtCZGR5CUY5H3/3z77nD51388Wee8nSy/Zif7yUjSNZcTNxQ6wyHQX2WSx6i26sZn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci0s1FunZu7mXxKw9DuoTYbsCMkB0qkkoGkfq62lsoc=;
 b=aFqUa/W8rVwGu/niTeApYdwQhheHzH0FXi/odRkdrWEw0LWQCQkLL1JCy27uIyJP4hTejmUyrCQ9noFOEPy53zfA+1H2OsEDmlXig4JavddcG3Si29+Ivkh64fo4cICZySKWuXk+AjyTAA5EspWzcVD0WCJrQ1T821i2j5T/yRbzI53FditMgpalEPEI52MFFF59Y8D+77eboPTr60/BSJaMnyHDJJaYC+vno8xsI6uA6ifMKjjzN6PPQuCrM3Ou4bNH267vj30uSxSkzzCpVH5/JyHRyXh2AGk/gTqQRJ48zt3+/NR9lUeIJo4wGWMZkjmLKEeq+pdvB88fgaQJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci0s1FunZu7mXxKw9DuoTYbsCMkB0qkkoGkfq62lsoc=;
 b=q4qV0ry/odvW59GeefDHzSibRO/gEzD89jj6HfGblJuTLkb2mOUnbPohTGYBTfHVUsNZa8zuigydrJVe/WDyChA5Oul/ch1RNkb3SD89EkHZFRGDQpKlGzCPucZ7ZQZ3ja9/X+mav8LBnisYtVRSeUBpMl7YRjhEkATT28fhQ7FqYgOGusYXIrdKdMitSmXYXQZL1fjEd8ukxp9ZC4PtHhP0SilVN8FcseGxZpPm0AdqNIkJJBZ1jJu1vRnCVYduqO3seFnhPJVgmRM/X787wl5G6NC9gJLfBB543mUhV44/bs1g0Uwnr4q04kkgiuY2FxZq3c7eIyZ9rB5Y645X0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 14:21:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:21:10 +0000
Date:   Tue, 31 Jan 2023 10:21:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Message-ID: <Y9kj04z/jLcUesaL@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <Y9A7kDjm3ZFAttRR@nvidia.com>
 <6369225e-3522-341b-cd20-d95b1f11ea71@redhat.com>
 <Y9kfn4YX59PIxj7+@nvidia.com>
 <2e78d261-9ae9-d203-446e-eaa3c652ca6e@redhat.com>
 <Y9khYwunmC/xdXT9@nvidia.com>
 <1a2417bc-f3ac-3e63-a930-bdefaab2578e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2417bc-f3ac-3e63-a930-bdefaab2578e@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 9633edbb-1abc-4b83-c7e8-08db0396667e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdB8n01xyH1x+pTRjX3lM8jhBW0DfyG4iIEKNvC8ps7Ui5+I+SL+Tst93gkv7UEx3XqMEvv9pU2AIG6PIeg6x0fTKRe6iU+AR7gxhdB2UUEqIoVysSYRKkXUzrLEh6kWR/qzR7izJGSsTgNd0hKP1Vx23M9vXFPgh8XtM6/lPew3YlOP/uDjXidQZKotwxbqiGFY2rm8JGo1BTpBXK4/mgrRDgRsQEskd76G9MH+1ZHntGWGXAq9WkKNcjuDH80ZpuGyFVtv66XOOxNYGU/54HBP1jWQIKSjX7FKWwWUgYVKHkGvvRR7L/8Eb0KjuQ37gH0sxUFJ4hhJR4CVuPYrAn27ye8gJGijr5bgIRZJXpGlCP2ezwpMcrCCBXzEkOz8lFjmFtvzvbfpLjXlmDUFapcqZdt9bHvGyBAFjSQ6MjFviZeIlgvhiJGeODR+0jeTS4vFtPwJDIn6CK3DiOojBQvGrS9pVccuRWDUmB+QTpqFfiRJJQL1EOQQwpag0vhJcYY3c6u+YN83+42IyGXSdjqAfwV+A9rdkZEXqO9mZwQvDaYxv48NdmSyvk0/a/KfykC9rn31iwAN0Uvr0CX9gReQxqSLRz6Fs5xzDAwdZ9E7Qlss1tgVo9dsyfThKmEiYggOR7W93MBDK5zUAp1Pig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(36756003)(41300700001)(6916009)(66556008)(66946007)(66476007)(316002)(8676002)(4326008)(5660300002)(8936002)(38100700002)(86362001)(6506007)(6666004)(53546011)(186003)(6512007)(26005)(83380400001)(2906002)(478600001)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ic7wd7/11mntVXeWpc3cunhLKGwHT4qGyXEFcry9zA8XnyGK6aLBVoxVO6Wo?=
 =?us-ascii?Q?WBkRmG8JXViJJgVko9XqfFUXCqFGDyOiVJcttIBjUS5nkZoQoPwjLIUUyjyE?=
 =?us-ascii?Q?4f4NV2ljABGmTfF6gAz2tww3HJSMlkUUjiO9+JwcgitxMh1xT34HBV1AuX5s?=
 =?us-ascii?Q?wssnrrX79pevKkmHCvN8QagG2MWD0WTODJ06pziB1kKxIAW8rZFrktCtvgF4?=
 =?us-ascii?Q?J5b7UhHGFjO1MOmB9/aFokV3pU7RhRISIY/G8EZ2h5bCcCsJkm9Y+ukBd2Pm?=
 =?us-ascii?Q?A3pxlCL87jyYF8pZ+Re/a6LwOVPZaWJM4PzawVQdyy/CwfcJ0j2KfsPZ6YMi?=
 =?us-ascii?Q?9+/msGbDbLl8FsHCiwGpUAdx8SiqeR0lTSb7VV/TL+0lqb+lvPM1ktmTAST5?=
 =?us-ascii?Q?2XZoIR+8Czk5JXwedgnwEXqyoCpkDwoPBKKTE8A31ZGuTY0zec2snyVfR+1A?=
 =?us-ascii?Q?ZRmRc7yPAQ3D1QjodaBm1lSz/fugHGgkzEswfQyn0OZgnpoTHSeppGtDrOFp?=
 =?us-ascii?Q?uoIOi3+HaXjocrYAsSkcneHqVTXNFKvBwOmcehfPR8x3CfSuVx0XGpTPx9ys?=
 =?us-ascii?Q?tq77Z/6EqFYV3SQu5kwJOzkF0dPcSdeQVxzfEYrmCoiLgpeXhhYXrjk+ELa9?=
 =?us-ascii?Q?S6j4Jhlsz8yWJqN95BBtvM9+Q2pMiK+LGaP09yzAys1jLGsQCPqgYMKDQV92?=
 =?us-ascii?Q?Xez795+jNreugxinIb9XV+UHFeSRD9i+M+RFHyyVHX53+Jp6ydcqpkWM26em?=
 =?us-ascii?Q?Q25RASBR0p5aAnObzq51PyQi2GeHh2UGTHG9lz4dr6Fj/7qVe6QlP+TyRRlu?=
 =?us-ascii?Q?sFuRpuHY2oVcaVTaNDFKWZ9iZsKakpM93xjKJOIBdMjwE4keSJRLoOlV6yvx?=
 =?us-ascii?Q?mdsSbRQuVxm2zrhqUpNI/24uUNzT2qXNaEWgzjbXCAhfw5NZTa2dGmw2O0ul?=
 =?us-ascii?Q?uObnRkHBAJR24iIrEzS75yaViODaLvbgMK+Ma3vBfxFM0l0e0y3mYCM4iMNq?=
 =?us-ascii?Q?FFs3lqO8GITEJhCZ3Mu95QCndMegwRYKnCSFIycMeJG3jQC/ycUhE7mJGOP2?=
 =?us-ascii?Q?gsUGa+ovnxyvnICXehqPpP8Maer+wmuBxseMl4gKt3/8SjlaeAhakqnThrIi?=
 =?us-ascii?Q?cpFzKz3OJyWqJMon4kPYjxZociByZaqMB3PY0EQiuy+rBBLnHJTjm1Wj90VV?=
 =?us-ascii?Q?G8zWl4aRuBuaHleKVEOJ9sDwvqPitTjCBDppE2R8xe7fZnJnqQKIZoCXX2Ql?=
 =?us-ascii?Q?KKhGyqlN8WZmQSIDmoCck2bP8Xh9MZgo8jQEPz1XA9JPEguUDF+WftEZSQNe?=
 =?us-ascii?Q?YqbNfnJqYEh90L5ShlXA9VqvPLCNj3dEe74SWnZbj7z4+DOkdnpTA3il0/yh?=
 =?us-ascii?Q?sY4i32dzXZqlcB/zWK7r9xuVNCgOJN1ehpVC6Znat2Kq4pdMr1+UWuMkEP1T?=
 =?us-ascii?Q?KtP2pB/1bnvhodz3FLGVPPyYkmUE0f8lNmncVjWpHYeCcytcTSXw7J0p7F6E?=
 =?us-ascii?Q?9vMclo79E8WYGFbrTlyXdIkIQR78qsO9MqyWgK+/DRr9uKFwpuqw7xhPwji9?=
 =?us-ascii?Q?ch9t4T44NkaVODBbv4Xw0bD4J5KLz7JQ6EJFrENX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9633edbb-1abc-4b83-c7e8-08db0396667e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:21:10.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+gVVslvAsTVMBY18fXOJDfyYwpWU0bnmfK1vzyXie4ciBYPE4YS4WWF6ME7DM9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 03:15:49PM +0100, David Hildenbrand wrote:
> On 31.01.23 15:10, Jason Gunthorpe wrote:
> > On Tue, Jan 31, 2023 at 03:06:10PM +0100, David Hildenbrand wrote:
> > > On 31.01.23 15:03, Jason Gunthorpe wrote:
> > > > On Tue, Jan 31, 2023 at 02:57:20PM +0100, David Hildenbrand wrote:
> > > > 
> > > > > > I'm excited by this series, thanks for making it.
> > > > > > 
> > > > > > The pin accounting has been a long standing problem and cgroups will
> > > > > > really help!
> > > > > 
> > > > > Indeed. I'm curious how GUP-fast, pinning the same page multiple times, and
> > > > > pinning subpages of larger folios are handled :)
> > > > 
> > > > The same as today. The pinning is done based on the result from GUP,
> > > > and we charge every returned struct page.
> > > > 
> > > > So duplicates are counted multiple times, folios are ignored.
> > > > 
> > > > Removing duplicate charges would be costly, it would require storage
> > > > to keep track of how many times individual pages have been charged to
> > > > each cgroup (eg an xarray indexed by PFN of integers in each cgroup).
> > > > 
> > > > It doesn't seem worth the cost, IMHO.
> > > > 
> > > > We've made alot of investment now with iommufd to remove the most
> > > > annoying sources of duplicated pins so it is much less of a problem in
> > > > the qemu context at least.
> > > 
> > > Wasn't there the discussion regarding using vfio+io_uring+rdma+$whatever on
> > > a VM and requiring multiple times the VM size as memlock limit?
> > 
> > Yes, but iommufd gives us some more options to mitigate this.
> > 
> > eg it makes some of logical sense to point RDMA at the iommufd page
> > table that is already pinned when trying to DMA from guest memory, in
> > this case it could ride on the existing pin.
> 
> Right, I suspect some issue is that the address space layout for the RDMA
> device might be completely different. But I'm no expert on IOMMUs at all :)

Oh it doesn't matter, it is all virtualized so many times..

> I do understand that at least multiple VFIO containers could benefit by only
> pinning once (IIUC that mgiht have been an issue?).

iommufd has fixed this completely.

> It's all still a big improvement, because I also asked for TDX restrictedmem
> to be accounted somehow as unmovable.

Yeah, it is sort of reasonable to think of the CC "secret memory" as
memory that is no different from memory being DMA'd to. The DMA is
just some other vCPU.

I still don't have a clear idea how all this CC memory is going to
actually work. Eventually it has to get into iommufd as well, somehow.

Jason
