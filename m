Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA168CAAB
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 00:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBFXlH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 18:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFXlG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 18:41:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA6124125;
        Mon,  6 Feb 2023 15:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZm4gBcCfiUn3dDI+dJ+yCh+QAePziiW9hSqCoi2RvQWY1zJy5uZMAe7XSnyfQgzHwxf7JE+aIk+Rx+8rWdm05LGV736Z5ZAhKj+LuYSHjMyGSicKXMHT7s0rzbmukSYEhZ29F73s2aPhyFR87+zIkVLOYOpsWugZqf4dyn5DpV0qlb38xHobOrXGATroC8VodJ7ESpqHbo8KRt03tEeeWQ+Oc3P9DQnqmaAikgqp8hC2xXiOMoJE2PUdPYkgYLzWiEjUVkFxY8c6u6H2qaibrq38KaWLyKSE0ciWKKI2+jy/LeqnKz0ZCr5LjCjhuJJKKKhqUed9xvI5HfsgI/Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=756dhXWezEIp93so5vb4qTkpfkbSmgRWyY2aYv2uiKA=;
 b=a0WjQF35X/8VQ+DjYD8+dp9ix7sZdYu0UPhxeXRDdz7XOembwaQEbZqlPHJKTrLds17nTBFjWPMdCSaGiZEY435WsjnUaoRKKouFZw6dnCqAnVx8EDc3FV6Pvo3DG6Fu1EcNgh71jSxhbvhDbSBCPZasWKe08vVtcokd6UJa6h2xT65wMHWBAD82H+1PF6oTw6XF284O0++NG35NfPTpA/hCzCstQnoVZr1iCDqijc2aJiyIHS95E5m9rTlnNhSgJKu2ObZ0dKmyjO2gIvBhmd1nxMDJSmYmhsH+7eq3fEXsRtVpVjQx0+CSh+clG7t7k+W1WdLFNBnaiImonGodPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=756dhXWezEIp93so5vb4qTkpfkbSmgRWyY2aYv2uiKA=;
 b=XlZIX+anh1ducJnI/itZxDFh5fsJx4hV2lN79AiDGPOZL5r/4UgBcCnKYA5/p2HXP9TK0RFxkugLr5lxNqw+Df98XEilMbA0M2uTPMH46QHMHf6GzXQ3JEiYFJRdp56L5qE9OddrlmV6vQVuJIPR0JiUIQ2TeTabveQfzz6w0iD6wz5l+1pfvV/vWZs3ztidNVULNcf3bYNauXGsys9+D/CLM/XLDR5nJUr77vQmT+h5LWaICorztAuD2K841XYsbNtRep7jhDGpQGB4KZIUftYVe/gq4hjcs4/Fy+CFhjZ0SjkDSild0IV6jYtAcyELw9+SJD31TqKRB24BrtY53A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 23:40:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 23:40:56 +0000
Date:   Mon, 6 Feb 2023 19:40:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+GQB9I6MFN6BOFw@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5548afa8-aaab-4a60-d32a-08db089b9803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9u8viY322RiClcJ0uLMnqj9Ra4oRVuAYmIVKJcMKaR+2p9gR1wq3of+7d5vMj5+aeL5Jrtgokn20VKXsm6cMK7y0bnXygRS5F/umNV1KwiEXE0D3G6HHYSWOSlzEy7OySXy/qJeJm/G9xBSh8Y+It5MofR2tRO6e44YOg78xu1qJJEvl+s4igRcIsq9FIKF2qc86kdtu/hQk7OR50l3mL7Xk/mvsSBeK08BLJoSb67Is66/PpBoj6VOhwrryjU33eJ+JJVFdYrn703g6CzDq12eBp+t7r4eTP+XEeNUt41T2yfhK+WS6tDMWY5ohrgxq0Qe6w11QDXnDwcoJWwJvdwg5CDJV0Nqk31XGJXsk7Cm2gXy9ykj8wWLrXgge5LESpSNB0vKkBUJOCySfNXhGknkCEu0dLn5wNKGcMP8OjjXpxV7qDAUlt/fPspk4Gocz7LCzJgG3PhLPHQLJq2goHMa7YXvW6yOgfmgV4CrNAvcmsjSTevbxYwC0r3vmTEfSDIR5SPDC89+RXbuqbuyK/qPnvEiYub6el8ToB+b/iWqK5Z3RSLx4HbWDr2uMDR7uQuhQymwYK0xkfYrZbLHkIrZQItDbmeOw02FFInb0DPSapUuVvJKXrsJwDaAgED9qVM6G/ymMOT4sgv6Ngo4omucVxiuZzQwEr9xy2ANxrGTatKQDLp/ecMwL/1IFL+Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(6916009)(6506007)(2616005)(478600001)(53546011)(6486002)(8676002)(186003)(26005)(6512007)(4326008)(66556008)(316002)(66476007)(66946007)(54906003)(36756003)(86362001)(38100700002)(83380400001)(5660300002)(7416002)(41300700001)(8936002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jsYlNdVbcRE5uZ2DC+dUtFm8PDc+wvWzBS2n4Gj/27ZGTHhpf3Igh9eApX6?=
 =?us-ascii?Q?8GRhZd85+i2HKt5AzM6qlpiPQpVvZaA7x6jL4E+r9hMBDr5WaPWK1qg01ze4?=
 =?us-ascii?Q?DalykhLwllA3YPQnGMeYXGcCq58S3tLPLBfVxkCXHjkMQubpdNOHpYZgg9Pn?=
 =?us-ascii?Q?NqW2P5ps5VFCHpudKG+Xpjj78yN1DhXT6GJbU+QZmbQsL4sXU1tGy97KMU/k?=
 =?us-ascii?Q?cXUTlrCwVfTasT33MiJIf0+vtdvjOif0j/MYBp+camPHKLhub+5VTc1Ozry1?=
 =?us-ascii?Q?vlaSkHYlPdYBr4Y/sxdorgTkb+WNnNjnqrvJj4TO6S0kD7wkcTK285FRIzAE?=
 =?us-ascii?Q?qaP1F7STcCkj1lc29BKJ2MpqC6EhSn0Z1emJywJagnnAdf39BdEPjyCk3u9W?=
 =?us-ascii?Q?+dYLeKt2iXu7b0ZKqYS88Q5zyaUewnE/l3LhvMYAL3mwZwG4z42NdX+VC1+1?=
 =?us-ascii?Q?HJbvhP4C6O1HQNFYWUos5ai9g5qmaBr5+cAwYm6poxoi9yetlxImlJpzO/ZX?=
 =?us-ascii?Q?hXDBFOTJL6C1wfdaPXKGw/VUVZaBv6TJVuEbqKI7Lg56HUMIX6X7N4IRzOjT?=
 =?us-ascii?Q?1DHOgeqSR9JwidqAjpyXLZn0xZTJQpEaosv15KeYcN9IaXHdsfYWK03y2GsB?=
 =?us-ascii?Q?7gKMpGM57VlASy+tnjaSRBGTPhQkcSagFvioHx+2vLKEJwbr4fjpfvGIWY9p?=
 =?us-ascii?Q?AzST2MpoFW8uzyDu1sZS3GwQqCyCy8kJTzp0mCUSamUM3LrXIFo6dFP0wojW?=
 =?us-ascii?Q?2ABt/wxPWtDdsIpOq/TvNs5nbLkZGxHCYPg1zvt0qkzasGGsZK6lSA5mCg+p?=
 =?us-ascii?Q?fjErFIQtgY7UgQXjSLqAUMuUXNwoN81e3UXfnSkM6VSaW7TYPJCyW9ROwQsv?=
 =?us-ascii?Q?Nc81OHJ4YeyGOCWlZXh6i1S2bRUqJKWlD1WpyGodglGTSx66xud4jGp/nfzL?=
 =?us-ascii?Q?9yGhXmyMmGc1pwjoefnqOs3By6vKOmCxt/Agnr97HBPxNNOUbp+D+Jn8koTM?=
 =?us-ascii?Q?qLxOyxyt0RfHRvlEgg2oZmzONDJFWsBPyXDZV/hnQxRFA4X8C1r5QUiH2ltd?=
 =?us-ascii?Q?TprN25C6/CrWDR2NvT//fKfR3vEdYwq+m0jWYPaYp7SkWCcRgvnYfLfXCaaq?=
 =?us-ascii?Q?vn6vVhIaF754QX86DBDrim2fzmOIkyfbD9/9XbU2+SbeJOIhA/Gb4s2oCO7Z?=
 =?us-ascii?Q?di5UmIO3QoWExblTg6ZUseRNVtnrSEEDdc6x818f1x0E097rluNMb/s+GxIN?=
 =?us-ascii?Q?JNb63dW1Q1Ol2DM+bR4ahpIvlbI05vlrVyU9NWtagZSVDD+KXDcGzdqNKRJC?=
 =?us-ascii?Q?FY0cFBo+/M9SH3nwUQorkoQd6vI3xFPkUmw88q7yQ4laPdjHbrjgiiPN+s25?=
 =?us-ascii?Q?9Rm1WDOZZbARYPr3/h0SBbL/6m51lecQ4StQ3Y0P1UBG9ht4TecMn/bNlEPk?=
 =?us-ascii?Q?x5ytmnh5T545vgjk9bmE1sn2xupvRe9iPpiCdPWCU6weKG9Ko7oQ5NMIGo1I?=
 =?us-ascii?Q?GofcmsNgZfKJreZ1y9iUeaUCyvU4IdpZFPh0ymtcjxVYmULJ00k6yPx81OVn?=
 =?us-ascii?Q?ZvMiwQyOGZBqK1ZGHgTNip9qZJY04tgsQv3B928C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5548afa8-aaab-4a60-d32a-08db089b9803
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 23:40:56.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95JhqMh0hf0ReOY/+41eTd4fYV39uARGiOK1tL847gQw7mFtoyhL/Tr37i3IWQSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 01:25:33PM -1000, Tejun Heo wrote:
> On Mon, Feb 06, 2023 at 02:39:17PM -0800, Yosry Ahmed wrote:
> > On Mon, Feb 6, 2023 at 2:36 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
> > > > I guess it boils down to which we want:
> > > > (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
> > > > (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
> > > >
> > > > The proposal is doing (a), I suppose if this was part of memcg it
> > > > would be (b), right?
> > > >
> > > > I am not saying it should be one or the other, I am just making sure
> > > > my understanding is clear.
> > >
> > > I don't quite understand what the distinction would mean in practice. It's
> > > just odd to put locked memory in a separate controller from interface POV.
> > 
> > Assume we have 2 cgroups, A and B. A process in cgroup A creates a
> > tmpfs file and writes to it, so the memory is now charged to cgroup A.
> > Now imagine a process in cgroup B tries to lock this memory.
> > - With (a) the amount of locked memory will count toward's cgroup A's
> > limit, because cgroup A is charged for the memory.
> > - With (b) the amount of locked memory will count toward's cgroup B's
> > limit, because a process in cgroup B is locking the memory.
> > 
> > I agree that it is confusing from an interface POV.
> 
> Oh yeah, that's confusing. I'd go with (a) for consistency with the rest of
> memcg - locked memory should fit inside e.g. memory.max. The problem with
> shared memory accounting exists for non-locked memory as well and prolly
> best to handle the same way rather than handling differently.

(a) kind of destroys the point of this as a sandboxing tool

It is not so harmful to use memory that someone else has been charged
with allocating.

But it is harmful to pin memory if someone else is charged for the
pin. It means it is unpredictable how much memory a sandbox can
actually lock down.

Plus we have the double accounting problem, if 1000 processes in
different cgroups open the tmpfs and all pin the memory then cgroup A
will be charged 1000x for the memory and hit its limit, possibly
creating a DOS from less priv to more priv

Jason
