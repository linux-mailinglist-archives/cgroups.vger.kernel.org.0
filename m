Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAD682EB5
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjAaODU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjAaODQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 09:03:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259283DE;
        Tue, 31 Jan 2023 06:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbFMhWSGFuNwLioCygu8vzNDlbh2xFxxq3MfKscA8COkHDFXe/5gHaWZIW7xv6E2OvWttXfeq9kIeHBuHoP+kuZMtCxEgj56RzbG5VLCKjS3hhvj3k8Acb0taTJWEqlkc0Y2Luu9njRLex9A7E33sjVZ0Y2HfAqZbTiBq5hgLsSZaFucIWHSLLk9gmSSyFEdRLIRbPZF3fnLujA9KiTXS4MED3u+j65Sjqxwgnv3LyYRyfncgbp8qXvnrj/t+DV0JTfzgm03Izom10/sX6cj/0YCtk7xIBjyaI5SY+UzL82wHaZHDR2tCoEHO8jcxGG2RzzrdFm6VWqHQ/OKmrfv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aW5CjZCKEWPOM6s1Er0FBASkHjiq7mAYmv2yOpE9ts=;
 b=O6ta/qk9yvFC+D9pbB8CGuhRS72iG428urVulJ2w1IGmMGLiarjhCMEbohqFPEXDq1EIzNdFpKIFmA/2S5xWumyQv91XYpu+4ChMbpBBFrz5jip75y/4Pt8tluF+smvS3CTL9JSy9YmPhdr4Lmx8tRpH5oYQXyZQNUFJioeTQaJ96oJPYyk099/Hv67ZPP7uLj1BI/xpI1RSaf2Tm+YMryiZK/0CcN1sMyioxtfVkmXsIm92+271yoHeT+jC3GgOAhZeLOXjJbLDiv+Rc2KUXTmuVyXhGuaHCT6fVDCHCwhkQiXvbGpdQoDu+dRqbQYjY1xedAFF6VwoKFZJkUaAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aW5CjZCKEWPOM6s1Er0FBASkHjiq7mAYmv2yOpE9ts=;
 b=QgI7MtzolMUfMjKEcSx7V23hVVbZ0h9tjIglCxYu1iQUVpgZHm/DxL8uNmQfIGwqH6zsVpn7XT9BzKQhWi6qnNf/JotK2rpUYQEx1LSH0ZxZzRFVLy0lLz0Al4mj9IOT+QjwA0TxbIMA4pnCvDdkeL/DvrFO7X422JcFxLD2GCKz+2QI+akECiOu43sjbMWHaNHSR4DpLKDGaZ4Sx2oj1bRhmOea8286cZtRRPyYnOCZUm+D4y5O+m4jtBDVmiWcdmecrn/HoWeuZHKotyvNf14YzR4x6OU6c/lCjmcapO0LYRpvTglxZO5yDMyKTrylV9XKuc1l8s6NoGXYVnJLPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 14:03:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:03:14 +0000
Date:   Tue, 31 Jan 2023 10:03:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Message-ID: <Y9kfn4YX59PIxj7+@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <Y9A7kDjm3ZFAttRR@nvidia.com>
 <6369225e-3522-341b-cd20-d95b1f11ea71@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6369225e-3522-341b-cd20-d95b1f11ea71@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9135c0-8aa8-4abe-e15e-08db0393e515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+Y4l9EgP9qvEu5GRhh2k0hUQCWXUVx1vkTuCQQFf6kcjqy1bcyIW+CGdyuRy8r8YBjiwsfrRHK93pesV6JpfG8Ag+LspLTrpj3F1LxwC1041vrJeEnd5aC1sBzhM+ELMIPMUBwfCBHWPIH3+0Kuh9uX5kMASdjS/9jU8tyhCOGwR2IjP3kmOkNinN5ud3DN86PKcEmgFC0y080Vxn3vssuk4QUvzZIFG4IxjCn2CjeAFfOzFseuLA6r6csc3R/nlJxh1o6P2Z8QfH5GX8caUNmssvHM6v/cY2IQSYPS0jcBJWyrpsIGNeYGdrr0z803bwpQ1o/ZonN82uwr0jPN1nlkiABc8o6ak47HW2b+wdoGNql6/3EOywrrdR+22sSfGqCIVuz+hVMLmJ7b7ATCZbMkO15wYfYCTMTpkaIxi+QIADrij9Adavq0sHAeqxeWQJMgv6dO4x3PB4BWdMml/kOScv2BlEihu1OkHdjKRRERiDSAimdv88uRIetah2TUN5xhe9lD3KlkrVPGbRChqOLGtlvezmRLxmapdpXv9L4BhGiMAJDXqBqtf7Od51ZE1BmOCDk9sDHib3ljXgJgdasbcuLqSTK3YzjOyyf3b+JnSHXCTUpquZs/e21bA8ZPJ/AI3immsTkqoDGCp9nM/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(66946007)(316002)(8936002)(66476007)(4326008)(6916009)(66556008)(36756003)(5660300002)(38100700002)(8676002)(86362001)(6666004)(6512007)(186003)(6506007)(26005)(41300700001)(478600001)(2906002)(4744005)(6486002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYskne+lnU4UNMf43ZkDxG2Z6zWO/6G8icMVk+Zhu/s1o2ue9z+Y//FQIQry?=
 =?us-ascii?Q?vWk+/2jdwJzYJxoqwfMHiu9cnNzyCmT/JZkAzsoRM6lQ3EBShgeKLv9DTb+U?=
 =?us-ascii?Q?Id8UXn+X7wi341aGijW/oS8AaLXy1dgbVdR6jmVhQOQXgCnYBeyBSbUU6cZ2?=
 =?us-ascii?Q?L9KlQ6sA8Dh98BHGTkOqMHiWpzcKnVp5wD/a4P9RRCNKbJj0XxVgffTtCFJ8?=
 =?us-ascii?Q?zpTOZ4c/0PMVcwCIiisJ5NAzdWi08xghZ08B1LCSB4ZxNPnFQUO1qq/Heks/?=
 =?us-ascii?Q?y0uXoc2MdqqVtVCDyZCdF4pVKDLNuONrnMZlDZyC4ADQN/m7Qj/BpB7/2PfW?=
 =?us-ascii?Q?FLyokSl/U9QJfJA/1hcxKRsEeBw5hTxmtqHbwfZDLrn1XU5PRblmwwmaiRDo?=
 =?us-ascii?Q?ccBHkOqU9h068XA7GPraSK1jQk2uvJcdOPJhNNzfWZ15ZTxdWZnWOdBeEPqc?=
 =?us-ascii?Q?p/YiWHoCdMrtJEEeNSvmQk0WvIu18/zsslqz0hMvnxd+hPvaH1XCfj8NCiYe?=
 =?us-ascii?Q?Gt4Vmy11DFnDHr/kO4HVZkNkUVc0A1ej+ioB7CucbN3rbkLDDgrqRpYGc5Do?=
 =?us-ascii?Q?dwtUUVQUiS1ymKqy5szsK5TZzqkr9mObHQkl9GucOb24H0CCKTq1Ire99w2M?=
 =?us-ascii?Q?hnxEYLYZI2Qqd0PTHIyQNie/PEgaRTwBbpmammnG82MKaCBFbXGPQVkinBfD?=
 =?us-ascii?Q?OL1HF2gmOooBFL+YtUi5/T8uu1myDW4I974KP6oGGVqSk+WpBU72s9JIkhcn?=
 =?us-ascii?Q?OmFMMwvqUiCxcrCHLWiyd2067V/XcF9OHoPAMb2FiVwHqUs+4QbfghN2UIKk?=
 =?us-ascii?Q?uqO12AzYa7HzNZDke3LmPYzdcFWwrNhcKOBy7bfHMMzg0Hc0cbTnyXDFREZO?=
 =?us-ascii?Q?in6DrA0F0XvJg6QGR3lGhpZp1WBumKzF3hkLBI9/DgxrvqP49CXCoVYZ1GgZ?=
 =?us-ascii?Q?RKY+Le1i/k2bJ29lxriGkzHvEfeQVMlOw/puNPA3pSPb3DrgWgnCRy9tdFeu?=
 =?us-ascii?Q?/C1rsjzijQPO2RT9ezuuIIpy/W2pVR+4VWkJE17YWP8Jdd0JprUiE7IgSQX0?=
 =?us-ascii?Q?JlarPwBAd07tIyAWwyX+CtIQnU9YtW2EXO+KFHJPmOMNOrzVOiY83GOEuOzR?=
 =?us-ascii?Q?l3KCgV9RbQ2IF8wp3TAHWxOFcdDOxNxBkjTKiyboRnGCu5j6UVpzkQB5yfkn?=
 =?us-ascii?Q?pUQbAnZGD1gwef0bR0a7niP+6UjaBnDd+BPKR9sxDjwmj89S3hEMX/14sxtQ?=
 =?us-ascii?Q?pHWdjUidTJTdsXZpHUfQF87RkU8VEdAW7YtSuKQhVEdAxiuoBg8bUq5gELBP?=
 =?us-ascii?Q?dxo9E+IW/y+B2Kq3RlkZjCNZMtylqZPJ26JCzPYpP3OHcttpNOK4+QImSBZ9?=
 =?us-ascii?Q?aXNSB9W2TuORKQsqhcsyiLxrYBU4BsmwfKsrEiHTwHYu11yi/rBCb5kMCkqJ?=
 =?us-ascii?Q?ier+VNWyie65MjB9ovQIWFXeh7n8v+xu4cjT8JnPzahYZV1n48Qyn8VSeCtZ?=
 =?us-ascii?Q?8cSYYbxyRU3wzHxtl0t5VyOhbv8iDeQNCWtaorzA0VOYkZQ9y1SzI/XzLh3C?=
 =?us-ascii?Q?x6Aww4gLgPtyqblwcUBgW7XAmyvEfLhTpsvgT8dI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9135c0-8aa8-4abe-e15e-08db0393e515
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:03:14.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i26dADBBgN0f7TlEkTb9+R3aFSrnz8yiAEJwe37KnPJn4vGpw3vQTzyjDil1rJ+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 02:57:20PM +0100, David Hildenbrand wrote:

> > I'm excited by this series, thanks for making it.
> > 
> > The pin accounting has been a long standing problem and cgroups will
> > really help!
> 
> Indeed. I'm curious how GUP-fast, pinning the same page multiple times, and
> pinning subpages of larger folios are handled :)

The same as today. The pinning is done based on the result from GUP,
and we charge every returned struct page.

So duplicates are counted multiple times, folios are ignored.

Removing duplicate charges would be costly, it would require storage
to keep track of how many times individual pages have been charged to
each cgroup (eg an xarray indexed by PFN of integers in each cgroup).

It doesn't seem worth the cost, IMHO.

We've made alot of investment now with iommufd to remove the most
annoying sources of duplicated pins so it is much less of a problem in
the qemu context at least.

Jason
