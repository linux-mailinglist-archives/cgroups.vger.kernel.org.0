Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0B69E5EF
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjBUR0l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjBUR0W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:26:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D0222EC;
        Tue, 21 Feb 2023 09:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8vpXrgm8KpnAuQ5qzP7FfUtxMEnldyXTG/Grdcl4q0LXGLrs0VFVwc+vWrOO7baAbO1SF3Ji5Z/4kljyq2X+zF65ga3ipTYzBqWV1mCY9/UjJOAwrMMNnoOjbLpT6svXLMXF/n2MkCmJdNAvJyhCYnECNFOW9TvLgLhQgZihJ0ZgqJRup+E6JcRrMGXmqtp7Emb7guqRuEwrr9u3zo2brfE/Sd3oBqAhGodMqdzbgTrplNOSEQ6ZRa5T3nZAxcXXaY5ohyBOcp1dWso7bQUWrti+28OXk678N2RrWoTxEYWAewTrz/2bHeU4SHZ5XFGoJviFedsEJMAN2dE4lHLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u21dPGAbr4FZY8ULU33FW37RRHqX2D336jNdYJyMEGU=;
 b=fur/1rEwVHR//711TV+M93umG2Ee0tQzS9OPSsNe7nkQJIBKKUloxD0QfNPajNLDzNPQB2s/HlTvQ9ycc9BaWimgH9+J9S2OSjj60CohXU4I3656ZVeAbSB3/ziAzmi0lz3r03PieODngtQ7jntLe3jWmywJYyQjBA5V/tuZ/vzO6Wg2iygALAXRFCfnUuqyCMW3tVqEwkk34E75j0F1ouWaK+vMYe9745gbELDuyhRuzcN+6K1gr0qlVJnQneQFS43bZrFLOzAN4cVoYsYj2f0fwS4lVoWxTrlq2viw9Gh6B1A9lg94c/Q3tUfE3K4QTTcTIKz9xzBAkmK9RaOdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u21dPGAbr4FZY8ULU33FW37RRHqX2D336jNdYJyMEGU=;
 b=CHoM6+4y8fE5A6zIiGgWag/qgOHuGQEneMEUkh0/59Neh1lJm559dg/06YtIPti5LW+hliggr0Lu1Vnq0VX9yajkTGRVjmbN/fDNyk100TYLDMhgG5obYf03llM4d+Y0e5IkNWt4sKlx5+jRnTotjceO6AF0v1BSHRj3zmvL65j6pvnuXi/IXRG4XDg5rl4TIUGqfRZWzTaed26DNLhXcZZ1aBrYdSm4bHKYuWfLBGy1xDNxGyeMS7usDaX24bQQkHlHybIHg5Qy4vbLpjgn3JxoFemjoQbcMcJbcX6P3jsxlI2zjLFFpir+FhNqaTAv9sLfUH7xcxCn0gkUlc7h0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 17:26:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 17:26:00 +0000
Date:   Tue, 21 Feb 2023 13:25:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/T+pw25oGmKqz1k@nvidia.com>
References: <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 44de364d-8a6e-4e57-e863-08db1430b330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3suMPp9bzIdHdKf35JT6/flKFrtPKOL6WILGNADGzfajZ5KNMoAcbkhkeWefNPeQvNT1OSAUKFeR4FUZMC1AbVArRk4wnFKkZ3mRe49TpYkCngiEddLOBINMSrxAnyxS+6vrT/L+gQ/CmRX4bg4pgJYimW1JDO9wKp0k+LlsMzKjf3pBPUU/vtvXMEmWhpE3l2MikU7jzBSobhjSqcpistcTrSWyqA7mNrHaf/JhIyivgaYZ52xJRri0uqnO3kv3rbF9FWPO2egRG+fHIUTM0SnKO+9BUXjBc4itI/aPsIsQ3VZgZuMl1ZrFB9VgaxOoUYJgN8SrQ1RD+s253a0ybYxzkydPt8s49sjzAaXSX41VIg7arUPFWeXlcyCrdD5rFehDER2Zz1blek36vyY8lhqPvolv/sRAsPLUXrltd9riC+E7ubMUDhHFui5QyzEXAD6D4jU9oer9wYhVr7cKDRyv5zTMk08SnBDHZhYdfENF+eBhlLyyu8OE7kD/CKCKy8TS84TYka1tcxPjHkzHKZ273yanjlu/d5Tm0tpHqBGE7Zk/GeOqJ34zsgBtRsQxtGpyrumQCy0Qb/WFBav804saPxNkO9gwRgayj3xdum0gmnoWO/MsqTVhXuUlXhkr/fp81UwyNMLlDcdxP7y8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(8936002)(5660300002)(41300700001)(7416002)(86362001)(558084003)(6486002)(8676002)(186003)(26005)(6506007)(4326008)(66946007)(66556008)(6916009)(2906002)(66476007)(2616005)(316002)(54906003)(478600001)(6512007)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdDSJ3RKxcFAaJVcgF5NNMf1jzjzJJh0UAtUyfY//qad2j9XyMvyb7Z6HiMM?=
 =?us-ascii?Q?DZTHODuWi4annGgvubVOjhOOAtwUyIGKowPsX3Qse+FiAJdviI2qXNecvDBL?=
 =?us-ascii?Q?DRVoSS3quCU+ura9dtKtk8FFza6ZiHbP7pnybemlKXzIck8kXlDJxaAOm+At?=
 =?us-ascii?Q?plG3DAtWlhrMWRLZ8ymN5VVNhGtqb+Rg67Ff4+Xnx0TgoR/7q9gyrYjHyGgl?=
 =?us-ascii?Q?dP8pvAH++sHk6Me1u9fWmuuw1oqjEB50QGKv0i0rM1Wl4QzFXSiprGEGZgPj?=
 =?us-ascii?Q?1t5WqB0ZsJ1eTfs3IUN/INL1pyJyEYWezybrNvwL3lj47UrKn4gwoL/h8OXJ?=
 =?us-ascii?Q?S3lp18JBczcBMEaWE0RyAhUr1FKybsT1AHtvELB8bdkJfgWYB24T29pQuenT?=
 =?us-ascii?Q?K9Ouv6VyBqRqzUgUhKboSSJ9PH/6U0b5FK7gYjsBrHZ3yK6QTWFm3+x9IANe?=
 =?us-ascii?Q?DrjAUGOyyCt8Yv1+sko4kY2rL8vAR22qK1pwuTuRDL9ECvCYRNFPtoCDarYZ?=
 =?us-ascii?Q?y8M1UXqdAANiL3FnUMiNJet95nPJL4NIhbqGdaDhNdq7cetdlPVu2CHV/Shp?=
 =?us-ascii?Q?/H3u3fP09So2oLueEMvR6wlVPoh9in8HtFAHKRR1XVzEaug0wVlI+scEV1ju?=
 =?us-ascii?Q?DzscWR4FPPzQOcnO1HTeCuBJnScuKnSBLO6SQlccFZL6slj7XypJ00BVKBaL?=
 =?us-ascii?Q?jbo9BCCN21B/L95mr6cVzGnJn0rU/aFj9lqitGcq3D9c2MhtWlZ2iw+qrVJ8?=
 =?us-ascii?Q?C9fpJN1+z35bz7W+2LnFU1FmwNBQgQOa7C4ejZ3Fk8uppTHjfWz6FTgu96WK?=
 =?us-ascii?Q?5OzMIS5fIdV+dU36MBxB1yCys5WJEW/x3CtaiNRB3INNiWuWFUia64iCOVWv?=
 =?us-ascii?Q?nVTN9aWRkAV+4JJ8mz+V80bMd+Z3tXzGMp/AoiSnfuWkIRSCMy933HymHlCj?=
 =?us-ascii?Q?kNskwEq9FxmTh9wAqrOclJLbI73scTXc4gQJrLDnTyFlkUXttlS9ymMpDXg+?=
 =?us-ascii?Q?3ZOve1vqd8r2bxJzUyVBo6ijO42G5cTveCXprSTYdKNwbhcGKuT3wYhywsb9?=
 =?us-ascii?Q?AoP5KCWIHiHkaqtmLeWOx7lgYCFpMAx31LOM313zZWLog/O1wc7DXWlatnAo?=
 =?us-ascii?Q?Af9qIAwW09dTq9tcIxQkF9TszWRCUnt250ndYiBiJhgED7sxN3JrblDjIDvD?=
 =?us-ascii?Q?DJu2MRpdYusz6qQx+Qb03wrZi/OosHqpHPlcJ54Yh5xQg+AFvkD+VXTOTU8p?=
 =?us-ascii?Q?1nu8UaJKWcgQXMRR5q1KvL8yjX8yF/Iw+9gYrYTamNdbxsRnpvmUxIUnsu2z?=
 =?us-ascii?Q?ZBubgYirPrmnV4y4VTp57btigCak4Bu+A3gPhjKu+pXXenXK3eIb7QN0Ooue?=
 =?us-ascii?Q?J5JpD1R06lzW9hZkQO0836uWquZvc+nPfc9A3RFpzVfN7hnug6nESmLImCNI?=
 =?us-ascii?Q?lgEUMjJYs7CjrZGHeUdW4Wd6zbGm6UCR66u9A7nDv+tqdPPDLZLxgYbS65wp?=
 =?us-ascii?Q?H1ZMZgTpUOqnD2CzbScFEBQgfmJzOOiQgLYMxtjoOnbolHCqxCodGmQ9mv8m?=
 =?us-ascii?Q?7bjkbcyG80EPp46s/pO5xk43K12rT/soAQGONQn0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44de364d-8a6e-4e57-e863-08db1430b330
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 17:26:00.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwoywGwEFB+BzpICZDJ3HuasODsA27LNSagbcxmc6AHqrd6zUAYEiXAb2K2LqyCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 06:51:48AM -1000, Tejun Heo wrote:
> cgroup, right? It makes little sense to me to separate the owner of the
> memory page and the pinner of it. They should be one and the same.

The owner and pinner are not always the same entity or we could just
use the page's cgroup.

Jason
