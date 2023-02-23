Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD36A0F53
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBWSRX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBWSRW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 13:17:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6354568;
        Thu, 23 Feb 2023 10:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9uPCjsxPZi15dY72F/V58Q0mr4rwPBU/Wh4bEue6il6dkx58fZNeiPhT+ZubU462wxoDIMQ4+uLG5ncVoIn4xVHKi2sYY2kvT+1lR7usITykOD9axPDT38S3Jlc5Dx5nGr1QKTEJp6Tzl5no7J7cwknw50yg2NKgkBiBqOzDfN4kxHR5nfMZ4uwBN6/x+RbB5ZEuyullgMylPB0Qc6OCYWTFxHQlcNK6/YU7esUlzHrNBfulPr+sg8C7oQJztmacaY3IaSffMFA//xlwfWPC4aE+NuF3jvUlHxhQi3IJzK0VCFSaBE8S6eZ2aNN7yI1G4ckjtddwr95ckfCssHGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efqBFXFYB3TD5OXzbuQQGRR8J7gFjiqrmSMRmH8gpCg=;
 b=WZUZbf7NeOEpJM3fqMZ0bU+m+CCOvRVEK7QX9SR/65ge5OFhcekIOjFT/qu+x1fdGS+Ym6Srhmc1IC5pJZoiWcsTQvdVBi1/WGnkzihVFHZd6QAvBFh6hUft+d31Dqx0peEsIwNsAAD6OkdK9pY9C7mndGyWXmAbD3qo/qOYsLWNHmabpaRraJF6y1dZAveg3uB2kDTDB7tmy9LLT8GnaZWgLzXr314kVSTmzJ39GASdkNtkxSWlCuM1NYG7vEV8MOF5OQRlDeU4tnZHn0GIlE+/5H8MAGvsTysgjV6wpBtVI1HZcsGlYCVegfDbyw34VcjdMTnTn/UtAh03u00DEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efqBFXFYB3TD5OXzbuQQGRR8J7gFjiqrmSMRmH8gpCg=;
 b=VM0d1iVhndA5EMWwMhsSM2OSyY3n8vKE3pkdCEEoCmXdd5ud3A+aXX/Xf5ONANZSdgPytPHoihp+1/CHSq2C3MoPPEJPaX+5MEhXDUsv5zib/pVZnDCJO5s1k7AxG+s0E4ekRKZk4L5b+mrE5qPvr8gqz6hrmBtKa3wRyUvuAhcfBacCmDd039UG4L9oR0Sksheddzo7cjdcOkm2X6BEwznOx7pWXlIBZGMsE1vJBB0/NjJ7AAdvYYCRVbyy/5a5ReMSFM9wRlqHck7935OQcd5WgY0SR0q9EImKVKbRiehUtx2r7CJjGAmSYYUpPxfxXZN5lNy1QsD01HPfLKDD6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 18:17:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 18:17:19 +0000
Date:   Thu, 23 Feb 2023 14:17:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/etrtvyaiwRIo6f@nvidia.com>
References: <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
 <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
 <Y/eiLBo88pgr2IUm@nvidia.com>
 <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
 <Y/esMBOyTaJnv5CW@nvidia.com>
 <Y/etNfwxHv8XO3iC@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/etNfwxHv8XO3iC@slm.duckdns.org>
X-ClientProxiedBy: BL1PR13CA0400.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1908783c-f79c-4d64-6123-08db15ca337a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNUqa1+He/EII+O5WzHRCgYIi0wg9LdoqRPSu5qUjzuNe4B5oc+ciPkZpcABy+V/a5Lbe0pgjytyq7AxOuXjxJAxicf0QupQ+5ruCWmMtKVpx8akSY7NJKYxiFAwgLGSrkqs3ZieTwuXYnPh36uQvCE1ffEpsvEAwZ9Izc7pyFdsYojEgLZQPjapo2mzcFS5hrG4jBUyn6EAv7O8t66wWpsv6tFGiYmJi0BHW7OLHmU2uGJiTils56CWoScZNitXHQ1cdOG7QScOCTIGN18x2q9Tp3FkZRMGveecPrOHB88LlVQAhEk6EzYqbBV5KZOwTtKhjDDWl5QSVNg5gTApcDYRhv846HRS3IRSm7Qd6BB1o7LrJszrpVJQB8yIROK+QA0z7BV3Y0U+xInCEXscr25QBor/TrcCVGwlptJzQgVgDDgOnALNW7BhLkqPKLVUFlzs4t3kMWESc6aRUBVZPXFOoFLtDRhXy21mTKlh5zTMzact5x20oxnbMfcHQ4P+FRG7QJszIWflg0bY6u1ia2+ishmk3hYhgW1Rj2lYZK5LYMNZTfU6uBCM3QxwjqZVqwrImsMAFiW83GcHly60/e+W9njaLeOfZJaB6f3mufdVmqjdhNVrlFxpiESwSWmR4Pi3aGBYvdMIw/xaWD7EEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199018)(7416002)(4744005)(86362001)(2906002)(38100700002)(6486002)(478600001)(186003)(26005)(36756003)(66946007)(66556008)(66476007)(54906003)(41300700001)(4326008)(6916009)(6506007)(6512007)(2616005)(8676002)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEmmBT34aQsXoD3KubI6ddxvAIZiu/oKKtENikcR3kW89t5PGCmHWvLBzwtN?=
 =?us-ascii?Q?6ybXubgPRv4ZnjxgIivpo7/d05PkiBCXHsL4OPs7jbgpiIDAdAWT2omJvCOp?=
 =?us-ascii?Q?9jFqE0kVI7Jj1UdN4ojcFEsCgfY7nSuEOAs3apAwnIT9yloQsV+NuI7YuEFS?=
 =?us-ascii?Q?bn/f1WUwNOhqmt7+BxKf+jTWVecr/6aC0kfgxHKWd+fSZMBn1vNmMmgf4oU9?=
 =?us-ascii?Q?4Yuux/SY7kIIrYu9pMnFH0voi89+/IADI15UAl1+RV5v2x2RrHQ7AkcG0QWc?=
 =?us-ascii?Q?goLjXHdfIYZEl1crCUL4ZDGj1yQrwfRqiy2tfsVF6DaGSJpdxGMKLikx7yN5?=
 =?us-ascii?Q?YkNaKhD+tZ1S2/PxJbZ9vPPi5LZfZV9PoP4RMMGOpt9h89Ba21zlTb6eoLYV?=
 =?us-ascii?Q?fScHHb5k+UDPjeVntaYaipfXN/FrLKlf5iEx/l4lnwnlaY5pe5RplgSqRWhS?=
 =?us-ascii?Q?jBSPWcG7qUY+TeyeNbGZmwnNTc56IZ5xnXdLZJ799r0LgqnfSCyfEwXDpIbz?=
 =?us-ascii?Q?aevJFbnl0kiWCuVVQxhcqhZVmBflkAmUuqn4vjuAEf/g+XzQA2bqpdBtdH/5?=
 =?us-ascii?Q?pC8PQTnoo9J3jqrXou1thXT9B+62fEShq+uQ1MmmZEdXRnjGNt1foFvAHo2n?=
 =?us-ascii?Q?EcKtD9p195Qj8bwt/+z64lCZju2M5F/XmXM/up+pU3FcqNUzWU6RlY2lstcv?=
 =?us-ascii?Q?3eL40DD2aI2ylJki1SzXH94sAAd/VmAwCFbTB0ce6HtCrSmPrxqVc2+JR2Ji?=
 =?us-ascii?Q?IdaGPmEpQ+jJAVc51AQMRNygOjdgaFR5bLVBubxRYCmajkSTxmSV6nMKTsIz?=
 =?us-ascii?Q?twuybaPSD8Hb69+wRiW0HHzsL7EY6wS/0IT8fmv1EwgF+H8EiORrNlom/6AU?=
 =?us-ascii?Q?Oh3CGPWViGZjGApJT5KjKAWALETBCKYPKZKa95M+cGC1iwkmRGyQ51tHINiF?=
 =?us-ascii?Q?907A1HBQB1svskiCKn4rqR0hRYNRp8DxH1Ih+rNXbYXJOHOoy0BakBCjLRQR?=
 =?us-ascii?Q?Z7lXk4bHXunLpOltDoCOFcR2ihGTRIBFGo4krFdTdW6O7Cw+hOeYPJ1Jr0ke?=
 =?us-ascii?Q?LaB+JEMyMzP0UF8dZYrSEEl2Drr2QYG+IBhfUVi3PCPlvGkKezfrXGaMaB6y?=
 =?us-ascii?Q?KwEGTGH88oapgeMwSXEzOcFvMIhybZRi2/Ve299BNbAkUiXnx8ZwYvvqwT5d?=
 =?us-ascii?Q?Vo7UEVarchj0YqsNSZE8+dTPTE5fyVgF+jQWeNvZOXSdYSzc1UfpqKp7G7Jl?=
 =?us-ascii?Q?Sd2dsaS6B8jV+A4X9jgDb2ZgQlH6s6h9QJ0snZdAlHmPPfJHqi083mu462LM?=
 =?us-ascii?Q?uao2yIP2TzzzyXwV6S7/KF3rQWsDoNwhuYw0RwKQQ6s9r7K9GzGxrugrVsW0?=
 =?us-ascii?Q?J96QGK+Pj70I5yl18gu9ZbH+VqEqgx+qxxltGt0nGDL6aTv0/cEG8nUFX39T?=
 =?us-ascii?Q?4yf73yQrOAwdO934YaFKakQ7tfxfJg4/Zh41cizNG8YAlQIlboSLzMPRAxSP?=
 =?us-ascii?Q?mEBdG7LxZY2Li4VPLdOQo486wU3caVq0XNk+KPkPHeOs8aOKd/C2pFc+Zs23?=
 =?us-ascii?Q?vyl1hYKQ6lBfDg6eIFQus+bm+dDj+uoh4M26ZxzJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1908783c-f79c-4d64-6123-08db15ca337a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 18:17:19.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRwOmX+7xbjS2UFkWHSZpWuAZU0KU7VTVqyMBPQ07Dg5VtU1qFTwhGUCYEJLVYw7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 08:15:17AM -1000, Tejun Heo wrote:
> On Thu, Feb 23, 2023 at 02:10:56PM -0400, Jason Gunthorpe wrote:
> > > I am not familiar with memfd, but based on
> > > mem_cgroup_swapin_charge_folio() it seems like if cgroup B swapped in
> > > the pages they will remain charged to cgroup A, unless cgroup A is
> > > removed/offlined. Am I missing something?
> > 
> > Ah, I don't know, Tejun said:
> > 
> > "but it can converge when page usage transfers across cgroups
> > if needed."
> > 
> > Which I assumed was swap related but I don't know how convergence
> > works.
> 
> That'd work for pagecache. For swap-backed, I think Yosry is right. Is
> MAP_SHARED | MAP_ANONYMOUS a concern? Such mappings can only be shared
> through forking, so it's not a common thing to be shared across different
> resource domains.

Isn't memfd also in the same boat?

Jason
