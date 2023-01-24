Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609AD679C06
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 15:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjAXOfb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 09:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjAXOfa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 09:35:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540C3AAA;
        Tue, 24 Jan 2023 06:35:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/tZ7eWk+PRLzX1/AqyFsxXdiuM184U7d9tKd8Lkb1g/Xg+cbFigX8mPnFt2exFmhZtaUnkQIkC/4uXxRDu65iwAsoZvONkRKsxk/OnMhuSyjbthgUWhin1+9X37/xEAocCXoIWkPA7NvAWWe5AyJd45qAPSrFOmR2/6JU/oIWtMY70b/pW85p+v3Ib8/6BSmb78PAtA69tVPQv8Snr3JLE5sCYOq7umq3yfQDn+XSOkp4H3ExhpVITMtH3/GGXxIcT6V8lOS7Gi/bHrZEZf3hy9RJ7iz9UYH6mZ+HVScRMMLmJGwixy8qf9FzQTscMxZoI1/Qqmdydk94XX1r617g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUHgQxTr7xl07KNqhlFX5ZY6CeT1FVDbvzOWKgAF2hE=;
 b=oJhGA+Vd1EyzAblAdyQGKoD16etVUyQLBKJBV+r9VgHQR8Ddn+ul1GNcxB+IHhOIBtOLb5ya/Q4sTpKdCk6KGsfuiQa8v+jcwZpg+c/E7zIHnQ9jyM1BCh2xx9JVm4bBouyStDtwNw4Krs29dfilsOeWqRB0T3+iMMpB/DNOAP/C80IRwhdggI1YevOeCUglmz1dQ511g3P0XyH6zofcFGo6gg5j/8TAvAomGhNQ0c5oPhrt6FKAjB+EJoGtD3LZBNKRj4olOY4PZCu72hy6ALw28uvKZUKkL6EkKld4UedHi+d2yNHf0nmdzRlnteUgtuJXLFJ9u8b0crBKpgbuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUHgQxTr7xl07KNqhlFX5ZY6CeT1FVDbvzOWKgAF2hE=;
 b=fkjM3q73RLaTXaxImm1j505ZKO2zK1hvY+cW3vqrgccwtO7Sg4Lo5DBa1KCRjD84JsoGLGFFB5kzr7ArUj0DS8GeZ2JOkmnU/m90sKUIzM3I4jfTjbZLwqIuDXuhBOIaWYE3pWB8kcqpEFe909fB0UUKghZYKzEnR9ObEK2rcT0eeLhORzrRLcUX3eGXohsIdMVrD3N2NCPAJcGTlAlMGwFWnRXL6kciJbbZyafMiwJy5SLLBVOnHFKXB3y47B8rm5KCtd4MHn0TspPj7iaV9bi5ovlbFXOMhyEL09rNQOEhDgbfOUV61wf5N+DRn3OVMp/dkPaDtrTsgxH1S8r9XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:35:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:35:28 +0000
Date:   Tue, 24 Jan 2023 10:35:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 03/19] drivers/vdpa: Convert vdpa to use the new
 vm_structure
Message-ID: <Y8/sr4SfnuoXxApR@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <f2e4696380f6678527a14e885556cb1bbd314737.1674538665.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e4696380f6678527a14e885556cb1bbd314737.1674538665.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BL0PR01CA0025.prod.exchangelabs.com (2603:10b6:208:71::38)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: d81e21c0-c0d9-4ca6-703c-08dafe183cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtiiQZjBCmB8RVj2VYhaCu68ep1Ad1qJaYzADHbQTB3PudR5xfj4Gc7U1ctVLIYN7eh6xPzXuGlybaUeF4W5LmDEH8bq5KCtq0anHh+4zo6vXdv1R95cmuK5/nj2+t+EJboICWZ6lVFZiwHPqLOweRTq5jM5WrqABy/yjKUU721LBG0l0QucBBQG5nY0PWqv3OzFnVobYo3UcCmw4dAE4X5bR9EJ4bK7EwMqOLxywqjj4ZzAnfYmBQXs0fA+ExczsHUPWCR2Qb0sVtZS9iQFEseTENVzAFyZup/ngWdEexm2ysQeeF9oA5PP87TQtzeb+GZZOEOb/qY1HVbjHMliC7mM8o68s0dhH2XN6+vmXpbqdVvt+Y/NWRFxnop6rG4HKaomWVE6VNDhr9VZGLzjWHRpSOBTQIl8OGL3upbWFleZ3NB5R4F2OKOR8kMxxK7CXbUBjK3FuGlkjccN+HWQJq4T8HcM45X/mFkX79ii26omr6aTCCiS4AIi2kzgDmCDvx3dC/B0qNP0eTpIClGw6tQvjAVNFwhGXWxGZdfpnvb5uBQG2jSFZ9+KGgHmOuOjIzhkXLW2U+5vJalMBar7IzBRalzvzGJh/1O0JWj4+I7dTjf93cPH20zUSBMSKhe/WxLirSk3F4dPw8Dxf75MEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(36756003)(41300700001)(86362001)(7416002)(8936002)(5660300002)(4326008)(6862004)(4744005)(2906002)(38100700002)(83380400001)(6486002)(478600001)(66946007)(6512007)(26005)(6506007)(186003)(8676002)(316002)(37006003)(54906003)(2616005)(6636002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2EdSM65jXaaekFHhCIFUeLgqALllv/Kokegdt/a3MqyGW1V9nJJfDt6VK6/I?=
 =?us-ascii?Q?t/FOFsKbeeUChVEIdu4riARSPMHPj+Q3E0bv5Tjg1P+zWOaQCsWZ7o+rZlhv?=
 =?us-ascii?Q?7K0J6+VPSMDX9cUh1QYLAE1YBZ9ccF7TmHTgNfhOs3UaIJ+ifh2AL8DoS7a/?=
 =?us-ascii?Q?WawFmJp22QDz3tDvZ2KdRguf+I3jpcNAAiqV03Kr8pFIBIMKPqikzCHtFghn?=
 =?us-ascii?Q?ahlvnsYS/CkVX227MntUB4qLoSEmc1JiMNUnEFCzjq7LA5p8r/D8a/+Li+jV?=
 =?us-ascii?Q?I7Xub6sHyLhDvjNiBWYycTZBqpTP0rI2aRxwCaTZkwRqu6A6+ujDUxZ16xNX?=
 =?us-ascii?Q?OeuPWnqO0+mTiriJ7UcDKxgOp7NsarcfkCizE4M609nuh3VO/1u+gh94jset?=
 =?us-ascii?Q?1OKYdX7TcM53MFM/1td4H5Ivkfi2drEUIJ6cjklS1dDi3gpYmJ9lu3Pp6dUK?=
 =?us-ascii?Q?CArKyCBtC3b5z4ue5dkgziyxlHSv7EQApr1KbnLYLKfJu7hxvNsBacsCCmF/?=
 =?us-ascii?Q?DJs9Xhl4Ys5guTz3af3Ww/PeepzNxSSLNePAR09J75ATNghvE/kG6FmVtsPv?=
 =?us-ascii?Q?NkYhovSwlwQR0xGl9+37A6VHyUmO2ZZoexK8N69TSKZJ9Pb5pVlq0mpOWkhQ?=
 =?us-ascii?Q?l5QHrih80e4ALRjoz07DYXTbgegFJZ99gV1Ai9kHiIlx6qmqiVclG9zr+3rG?=
 =?us-ascii?Q?iOQJ156nraIlZHHvv5f2l+6gPgBIjtFs60TMk8wM/X4xhNkcEq5evMxT34Q6?=
 =?us-ascii?Q?WB91PVC21JdoPy2BdyWlAJLTNbiXRubPQEIg7ZM7REFZKffPWuOnsfCP4Ltb?=
 =?us-ascii?Q?qZ3pcZLGzyCH4gdNxYt4qU/1uuSL3oW+AeODzpn41QaWjuscRzwDwDCBF976?=
 =?us-ascii?Q?xFpv7zoXicbgCfzp+v+wYmgQxc9XfOdaRbluEd1FSKjqlb/xKsDqJ8fUXLpJ?=
 =?us-ascii?Q?PteoAHm4I9nN3zCKacCwgLEafrSRQpNbbCHkl3oVhbgRWriVMkZHzHM/HsNa?=
 =?us-ascii?Q?b3/FJ79OeYaKjszKUZo2DPNPgPW+sLhowSpnlAIesycDlb7Ipom7hRD04jaF?=
 =?us-ascii?Q?Qm1Sl+kONtc1/yw1irSyOFCJmDnn5fj0ZtoZ/UkuvL5bXkJcreuu2g8wcD3K?=
 =?us-ascii?Q?udszz2saI5xMvbqPL5jBPsBridmMEdWloLYaTIYV7t3JwdznpBHhlV2W/dza?=
 =?us-ascii?Q?yri7UZ7kLBF/ePvZcjMxL740EJx4ERievVyC2vI+Z76zGrdf25xBj91++PLK?=
 =?us-ascii?Q?BvsIMnSKmfZcb6r29fyq44JMMgfsSw4VHyF3XTH3qPk4CSx2OQSW5ixDM+i2?=
 =?us-ascii?Q?1PRbMxC2LzcO4rdL8Y4dfyMAXmBb81jIb1RCSuV+dLoaIYiPJN2UfNsTTVpP?=
 =?us-ascii?Q?E0CtQ5cXeFVCcKJi5WtglcZxskId4UmwcnCYILMdSxu0t181xT3RnY7IGy6d?=
 =?us-ascii?Q?3bXnRrNtjWfhqK79f6uQj8oy3Efbe/i4ZsNHr6z+dxZqK6yshdc0NsLxZTzI?=
 =?us-ascii?Q?J8FU/ugY0xXu8XQ1Am8QPzfxz7G7W+3+G5dCgXtSfw7EbSPXBMnxDjS6LHSe?=
 =?us-ascii?Q?gTuDAuB8QmYoIiuHoTTqjATbieOk/uzueKKz3YnG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81e21c0-c0d9-4ca6-703c-08dafe183cd6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:35:28.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoL7hfvWtX+kOhpQZLb9WWSnEYMrw3JqedYzQk4xxu2WIYB4rOClU2Y7nt5LJvI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 04:42:32PM +1100, Alistair Popple wrote:
> @@ -990,8 +989,8 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>  
>  	mmap_read_lock(current->mm);
>  
> -	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> -	if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> +	vm_account_init_current(&umem->vm_account);
> +	if (vm_account_pinned(&umem->vm_account, npages))
>  		goto out;
>  
>  	pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> @@ -1006,22 +1005,21 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>  	if (ret)
>  		goto out;
>  
> -	atomic64_add(npages, &current->mm->pinned_vm);

Mention in the commit message that this fixes a bug where vdpa would
race the update of mm->pinned_vm and might go past the limit.

Jason
