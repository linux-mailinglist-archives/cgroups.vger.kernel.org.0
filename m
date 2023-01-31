Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45622682EE5
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 15:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjAaOKt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 09:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaOKs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 09:10:48 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC836FFC;
        Tue, 31 Jan 2023 06:10:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuFSJtg3yPO8iZ1JO5/IxT+0ln06tbVkdNqDVm/eN2ux4aLZ1tOJGP0B4pvvJjdK92901W5RJJZV30CjznHblHDQ8AmvVkkkIUxBicSchNzFPKHm74USE5MK+icZhHMD4XjCJ7q2QGI+Yz5E0+2Jtwcd+yBeWdfuYEbhNfao/r6I35KcuV3eP37fPKa+sNoYEqdhbY0KIXQqat3xOStQpCNIO28OpJq1/SOxArExlfcoV9Up4mlU7rYWmzYC1jJ0CqABO8MV2zEq/Pk73t4C1yzKTJpOY7O0Z4EijbUUF8W2wua7v83FZoyTuAN6KsW8Q+myg7p3KHuDPC4RRK9jpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4dQjDouL0ik531YeVhjffr/FbCf56b4ymKwny6WKUE=;
 b=mSerfCj+Gl3WpepTwg4TKUH3uAIBELXsLuhzuYtRAwrhidOMG7iHy/m3boIRAYoTI30f8wk+7/qwyuOtWjlUaETwag/3CConRqHDvMBS4WLo9VOl2AyZMqGqx4SWMvAldFXHg4QuNpr5A/695XZUAWIcj8a+v5hRYdKrknth/4pV7A+FEXnYtKK7zUcgApmNs3A2u9Q/DqudYoDdJDV8gsEr4mW6PrGtkpguD8zoJqzUZP9a0xrRvQ+I24MVYdhbGrXuHEYDq2QvOE8DOFvpKQU/sz3glJmzB021KKl+FcBcu0FtCBeGkS7D1Hbg8b3L11wAMjC6O2GfcO7CE1U5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4dQjDouL0ik531YeVhjffr/FbCf56b4ymKwny6WKUE=;
 b=EEGWhNH/YhZhqUqbyJOvo73sPBIirkCiazU3p7h/V4IwmewGhJQwbyiVlMjSiB+7B9/vFX8QAnkkfd42AErGGLNVoK2bE1S4+RZ2CcuSY2Ku3l4Dz6EXJfXlun90LgzGkG36H8YJ5HAr9Rl4bkuxyUcvi70epUTk3Xqn32IO7qfANkIeITstqVIHSHZK325ma7TpEJamA9LyOSNPw63RUqgYe71kKH2Gk2VEv1oa8fzJqggfrufCvX92VCqoji4ShpwfcBxOyXzbeW5DPOUj3H8lP4pWNAdE5ZZDAGm9WA36ZTkfnTf/iSxn4ooFjpxX64TfFvI3YhaHBEcKN6/VIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 14:10:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:10:45 +0000
Date:   Tue, 31 Jan 2023 10:10:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Message-ID: <Y9khYwunmC/xdXT9@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <Y9A7kDjm3ZFAttRR@nvidia.com>
 <6369225e-3522-341b-cd20-d95b1f11ea71@redhat.com>
 <Y9kfn4YX59PIxj7+@nvidia.com>
 <2e78d261-9ae9-d203-446e-eaa3c652ca6e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e78d261-9ae9-d203-446e-eaa3c652ca6e@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: e1244321-73e9-4e80-1bb7-08db0394f213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZytUfFV/BZ2IJpw3onXMWjmWGrhxXnL4tnlBOVzRYQqwxN4wdtUAkMKi29skELEgopTDIQ4H1PsruLYrnF6dp04ySuDo8x0DjPx8xwAHeFAxba8iLLafZIq3Q5MPE+txn9MVBXpSUD3dtp5Pq59OPKF4hxi3YBbfqi8sn5E9paNfPToDDCDqdYNlP7q+uORwejJQuKzjF12tLMMIcJPnrFuDnSPS7xwB/PGQw0gmM+DNH3KIKU/WHQQGbTdmoYZN5L98CS020uN8j+BhjR8EMM9Y9VxOtHKM/tzWjI8PESGY0U3R8w8LlUAmSr4ISqjE1a/VOaN1LtCiqfjffPU28TjgBrUddxYPRBCxWlpmIBIsjfKB/WDbWZq9hHfoBEDwuSHD79g5VNXzZWfCX1Xw7ob3UEks66Cy+CoqbK/kIE3tq0fdBW8AcEK+s5u93LFsrnNEt2Lqeu53vNJFRWu32zm29DnZqdJI5rr2hUwWLldg3idc7LkhBq+mLgGeTvwWUwVH7veu+JzTsuD4iUXnXd9bmW3/1uU4bm+ZkMwvT+lf+95K8reUUgvqgouSJId4cz0EYnmyRsJFsDK3qobJ9LqG5Beqh96jvsPmFwoddYTpwjCT9YZE53YHakdnvWVXFGedIb+lIysnMxWhScyzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(316002)(478600001)(83380400001)(41300700001)(8936002)(66946007)(4326008)(66476007)(66556008)(8676002)(6916009)(53546011)(186003)(26005)(2616005)(6512007)(6486002)(6506007)(5660300002)(36756003)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rO9ac3FG7kAGlS+9xSZbdPpHaRAW+lwzxlqmdBYByjtXSw2zYI2NXz6rqu90?=
 =?us-ascii?Q?KhS9pYcLBavDbAS7fVJo6svqKEb4XIwwI82tPATrcgYHc2YIbtK2cmdoxySK?=
 =?us-ascii?Q?J3DG9FhE05D9EiGhFpz6blpjaIjhEO4/QBzHvNnSSkY3Rhw3u5lvSpFjwojr?=
 =?us-ascii?Q?mQtnunNBOERrY/Si3AsbHIfXkE6xaMRTUzy69u8noyf47Mb9TqZCJysyM81i?=
 =?us-ascii?Q?PedrjIPdj4Or3MCqzrEkcL4uWguyMg2h/GCqhK/mq/3EgGKmxXTgatN56ebA?=
 =?us-ascii?Q?YcH1yX82156Uly7BXqnxMrwpmfNcjGJ2L5NeCrs/AD0VyyEfGIZga/E79Dzt?=
 =?us-ascii?Q?BiuPhsNQzxRhSEgWpA3UjHCquYPkwJqCttqKCC3H7crtTGJPJGKFBt1Aqu97?=
 =?us-ascii?Q?Fva6hPCK+mjBitfp+z0H2LMnVMgIX5NQJ6dmdYUzoJMJVV9Gygr/do2X4nvy?=
 =?us-ascii?Q?zR4NjWIj/i0s4SxScZpcAxNVIjYdxwq/DqbNC5yPpY1Ngk8W6Rvp+z8xKtUu?=
 =?us-ascii?Q?YpM5SGeINiLuebrkbmMcu5qntFPeH82gNUARhuRBbOK3gCDs/74Ibh3W+hvC?=
 =?us-ascii?Q?ZGJfEuP7gRpFeY5dmRGYgZ+82p8ntFvIs8xNYbNjKrJvgDZxFaQfx2KxG5Bl?=
 =?us-ascii?Q?CZaRJ3xCtSLVwcO8KTMm80OllyL3VIFktk2a58sgQySTJC9+NyhPnaty90xt?=
 =?us-ascii?Q?KheOvo8ptQkxacOrfppk8RcwMwrQefHxz/W7mh5wld7nDVtYcMIum5ErUh6b?=
 =?us-ascii?Q?omMhRK69EuvyrWvlU8cs6VpV0tjTg6eeLF9NN5Wfu44hfYE4Tn1mkNZAHHK4?=
 =?us-ascii?Q?gES3PWapKF/QeVE7efT7cC1eRigGO8CPhn4zkjvkriN3ebAl5IwAQFvb3bSv?=
 =?us-ascii?Q?3VFqAQwc86lhZie/7O9YnEWjZA87UixuJ+UkjdxJV2M2kMPkoalavTzQdjRL?=
 =?us-ascii?Q?LD3U/V+XdFFVLp3B1+N2UA1ab3275pER7Lj8fMkYCwJI++NhU24bHDJSYXnR?=
 =?us-ascii?Q?AAkQPD5OruB4R0prrPVN/x6ucMlCE+vtnVdSJr2q5TsKWA5dl2o8q2ampurh?=
 =?us-ascii?Q?DbjeXNAeYUW4QyKSOI/cUKTLgUAEtjA7CD0v3bwP7sv/IwwBCJ2KYlCTYkY6?=
 =?us-ascii?Q?T7rrNZl2iHOtWxYmJa/nC2AK4vcQ7Eidz6ndrxqHABmt9ZAHx5Ie4n8vrt9E?=
 =?us-ascii?Q?BRI/aEj+CDOMiZr+S79nri+RYxyjTpNYk7e3zsAOTT2q30TzjgofaCCVKexF?=
 =?us-ascii?Q?dq4WHPjL/9DcLe5Dwq/CpY6aDm2ltEODJ40qVc4O88JumE3THayRDCNx56sV?=
 =?us-ascii?Q?ZoZGV4xxz2tRhXnD0Sa/HY5zDegm+hkdG2T+Ea4AAgzXHJKhDfvKbi75w9WD?=
 =?us-ascii?Q?8mCklPteJ4ioU5NMU2CfoKxvW8PHd9a2wlJeK94anziPeSYB3WviXNpAqWV2?=
 =?us-ascii?Q?DRtpnXetj+crh88CdfEdoSYB6V8ThWH2rBZKVzNMzQNo3gJItwLcPhMsZfrr?=
 =?us-ascii?Q?6bqpKhz3vVLJ3zu0H56RbrktsIlc4sEG2APFoR+lstzXLgL8hsoH3CvTUvDg?=
 =?us-ascii?Q?bEHTuHJOaiST5/G4Z1k1qv4sn3eSxw0Ct/8bi71b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1244321-73e9-4e80-1bb7-08db0394f213
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:10:45.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zVxTBTmQAIJIx6mHaUae1oRumsfcK2cNud4rVaecXwv14cWfuYXgyIGGxj1hSjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 03:06:10PM +0100, David Hildenbrand wrote:
> On 31.01.23 15:03, Jason Gunthorpe wrote:
> > On Tue, Jan 31, 2023 at 02:57:20PM +0100, David Hildenbrand wrote:
> > 
> > > > I'm excited by this series, thanks for making it.
> > > > 
> > > > The pin accounting has been a long standing problem and cgroups will
> > > > really help!
> > > 
> > > Indeed. I'm curious how GUP-fast, pinning the same page multiple times, and
> > > pinning subpages of larger folios are handled :)
> > 
> > The same as today. The pinning is done based on the result from GUP,
> > and we charge every returned struct page.
> > 
> > So duplicates are counted multiple times, folios are ignored.
> > 
> > Removing duplicate charges would be costly, it would require storage
> > to keep track of how many times individual pages have been charged to
> > each cgroup (eg an xarray indexed by PFN of integers in each cgroup).
> > 
> > It doesn't seem worth the cost, IMHO.
> > 
> > We've made alot of investment now with iommufd to remove the most
> > annoying sources of duplicated pins so it is much less of a problem in
> > the qemu context at least.
> 
> Wasn't there the discussion regarding using vfio+io_uring+rdma+$whatever on
> a VM and requiring multiple times the VM size as memlock limit?

Yes, but iommufd gives us some more options to mitigate this.

eg it makes some of logical sense to point RDMA at the iommufd page
table that is already pinned when trying to DMA from guest memory, in
this case it could ride on the existing pin.

> Would it be the same now, just that we need multiple times the pin
> limit?

Yes

Jason
