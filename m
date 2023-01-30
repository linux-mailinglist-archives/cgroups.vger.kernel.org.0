Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89C680EAB
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjA3NUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3NUq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 08:20:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F782DE6B;
        Mon, 30 Jan 2023 05:20:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbrVvO0aLJr5PYwELFXcje3V+qtd0Xl3rtxut3QVAtMLanLMGT7EGNHfiz6LOpWUhY+OAHzMIXbPdRcObV97mN3DRa21UzAquEObaN+VqGGjgoDryC1N9eO+5GgoFhWITkvz+KWwb5RZX1LjjRcVE6dtA3lyAg2qOXZed1/AsbBfE2BXaSPkWAmlFHjKSj39GjgxT8nwVgYyKOdydbCMWhrm9C3MzpdVXacL6VbtqCAdfKoltlEOCz/Y+RUi+3RWdJe2emHK+Sc11M7gGVVfTWXjvTNzlnzkxs7+uz2X8oo7HpzNnT3RZvOF5VjWkSruFeFVcZizg3VaLUYwr5iQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwyiM/7B2+SHU43XMWs9J8BzG/ABfrNrQW3lGga4pEg=;
 b=GFqm28lFRFaSXJccgRjDoLBaAhU23XM3vyzK//bR6L7WhTxB7ae72/48p9mtMEYWLEasqE3EExvxPqPAyHFERk1mVgOYLWR6XQjTg6oOY1aHYoZU3q1OVdZTVin/sgYsDIinty/Fzk6KCelOQRg7q4A1oKGem58l7Uid7NN0CjnRL4D3IsftUQz+9h78uq5mYx5C/I4OYmWvQG7LQD0voBhstWLDPx8YuG2XubRlp3Gdf9HYvdIIeZJMPniMQSTOQEeVCjBMO8LboIOYOB4pvITDtjWGIUjxURayOOp/8LpOMRR+mxIylUOVdqebcc2kOag/LttbjGEc5f9x6bir5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwyiM/7B2+SHU43XMWs9J8BzG/ABfrNrQW3lGga4pEg=;
 b=E8kVImaomP0YB58nSm2C2vU7XQXds3bJ5ojEKT2kncJIYnuIoYSjsOOEIoB5v8vhJehbYSI+chfB1bPv3aexXhYZaNHNpTA7jFWLRlGk41NIqGDBgNIG5G/U5l+xMg5e8YE4hAQXQIHHhcBy68v2RBRa2OpwGXHcsMpKzoKrAAoDFQTPvY7fR/dBxbiJe/Vr5hJBXKVUx8+Lk7O9J+9oeGgm36gZH26wHfBeI5q3/6lCgBOqNEF0Eso9RFU3+kpVDNejXvLxsGqE0dcanYONBkKGfFtu+huWBTeCqbRCZQJjVDXYM81ulI7G9b/8KlGDi3H1xlswd6jw8i/NFkE3ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:20:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 13:20:42 +0000
Date:   Mon, 30 Jan 2023 09:20:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "libvir-list@redhat.com" <libvir-list@redhat.com>,
        Laine Stump <laine@redhat.com>
Subject: Re: [RFC PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y9fEKfdlL+hCiWpz@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <183372b80aac73e640d9f5ac3c742d505fc6c1f2.1674538665.git-series.apopple@nvidia.com>
 <Y9RFs+90TyzVMs83@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9RFs+90TyzVMs83@slm.duckdns.org>
X-ClientProxiedBy: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc8978f-06c7-43d8-1347-08db02c4c98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t98HT0VlBKwnAg9ub+nw1bW6gT5y7z9WheG5m47NX155jkijreiHHjl2JCGwkgZpSV+btJn2cM6uvg92qlooSifGMSWNEtwbs7YYBCLI6j2G8bLdr9/35RG2zbHIz5HaMDGfrP9gqlVdBS59kXF03K368u2zmXEByRhoZ9K0/0jiFpTLKnu3b2TqXEn/TSLLQ1Oc0a/vyvhUCGeez0HoHNPDK2F+lZWNG3BdiFmEU6jrTq6nrV3RVal/JHRAc2s6wh3wOnI9uroWn+f6n+LXp288MJEJIp2zUA7xXO6YmJKq0p7t2CsiMGLHtC4yH3dZp3jfviNNm5zhVvNxBQ3A4XbE+vUk6nA1YNUTnelc5XgOtkh62KIecBzennwn+cOJO8i9ggfSPuNTRSQ8ZVd2lKae9bvitjFLJbsuIIK5SJp7OpEhEWsFE4nAUCEbfBBqP3xDi5aLP1IPr3gtsX49eoO2DdboPwK7rbwE/06PhSRFZgw4sD7nv4b+/hwYLzogXnC91IBfOyM70EvVbB1EL8nXyKTXNFC7qQ6Ro6nnc7yDCBPc/L5h3tUKWprZUHQMyFRSk4jqjasF8WlZ/ApWb07vyp7bw7JssoLzndMsEf1dbWKYf0aI1lgu4RjEf9KXpUUlTWfr0gEBbEMKZEUq8YtkBIU3MIcJS8IJVxYjQbYhcvTNdIexiEwLrPtDPaDi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199018)(8936002)(41300700001)(86362001)(5660300002)(7416002)(83380400001)(2616005)(110136005)(54906003)(316002)(66556008)(66476007)(66946007)(38100700002)(4326008)(8676002)(6512007)(26005)(186003)(6506007)(36756003)(6486002)(478600001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0B6AcIKgj37S/hSkjtTjqQ/ObqsxPAOt0kzUfCyxtdHwiOeI859IiwLM8i5v?=
 =?us-ascii?Q?P4UyeN5lmiJiQjYuXh21JeLcbZI0H9kSNEyUXM3mO6XYObapupSKxzl8gRfQ?=
 =?us-ascii?Q?6/5fbUw0gcOxMFHPdWWmttu4MEVFjnw98yNLVFYfTaIDYMi+UN97On6+nhea?=
 =?us-ascii?Q?nNP3eKDkcV/6Zsz6mNiViS2ZNHqJln5M3sbHCFGOk9uMlW5l0wUlw9tffsMQ?=
 =?us-ascii?Q?2+IpQw3WlPRhOKl2GIkajicQT69UeIXP3GfWlZcz23v61iXG9Ga2F2FO8OW2?=
 =?us-ascii?Q?GQme0zezTn+A1J28A6dajidc8ENB/jkYaDTSwBr62J5X2LVaKFpnZ1Q6lpYH?=
 =?us-ascii?Q?79tKDGZdtjV4GDBlb0mVCzUoY2/q96WJbMQUACjWgx9wf19VIikf3DVw7opw?=
 =?us-ascii?Q?iY/uudCbUxl2G9qlPuVzDn9Ohq7d15dKrRFEtQei2FBX1qN/5HXV/uHcaI9n?=
 =?us-ascii?Q?w5mw62lUWlWf9DM505R3wVa17sKtzSzOMkgbUcVenK0zT5mREme8crS+LB6r?=
 =?us-ascii?Q?CghAFzDiRLAOMeTl2NoLloBGKEroxOPIbY/h1hF3KW5R1vpjIXPIJH6xHAk+?=
 =?us-ascii?Q?FZm5J5yhKPPY50ZaefVpoPfhUL7l5/VrgMu+4CbEQhJ+SOwlFU5jrpPjvy/7?=
 =?us-ascii?Q?m6o0e4SqvugC2chARi/PwP8vyygMP8ynBdUqKlySzDggdFLCk1BmCKCYjWQE?=
 =?us-ascii?Q?gsZo3l4ElkRX1CEwBYFpjTzTQuFlEPp/ONyAMf8bIb9SyGz+tZ6eCacB5ZH8?=
 =?us-ascii?Q?UobXEXHirPgldeMl6DQ49JANedNPXgpLwsk0ZinPFzVDxpn2SVmvzT27DOGr?=
 =?us-ascii?Q?gQQZsHmMP5sNvsj/KL6jOQfR8mZFBHbCOw4myS3WY1PJ07iqx0G/EjnZBqpg?=
 =?us-ascii?Q?Htqjr4fWyrPTndED1Gb2umMK4sezr+7sBWx5gj/pTNUocaPgnptp62TrAYu4?=
 =?us-ascii?Q?2el3qDWUT2rvK5/tJAYEU981DClSLdsVotqbLqZh52PG+QvS9lavjsgjkJn+?=
 =?us-ascii?Q?NpBUuPw7gQwt8YhPMYZN6FSebZETffR7AH66xjI23a3dJY7Kt26f7m3IM99m?=
 =?us-ascii?Q?UIIsADCPcEG6TFoeG4j+AkHICsIEj7hSuP0mPlEJqmRJWceKu8vJwT6qb5Dl?=
 =?us-ascii?Q?RqMMDcqVrUyjOVK4MmyGzqBLa2MhSlw/Z1K41yIyHRAgIDxaJhmsU9sZ4F/F?=
 =?us-ascii?Q?3qNoQixC6Sp9b4Tp7F+QXR3VZLwgIq+N6KD57nXh45FLsA+ApkAk3SuIZ4Ui?=
 =?us-ascii?Q?oLV3GuKmdgz5k1LcFbcgwvBNoucVWPm3LxanmSBshjRDJT5ddydz7dp0pYp2?=
 =?us-ascii?Q?fYG2xUp8NuqocHGh1mwlySntB7gHQZ85y0NbAo7PIUikVMZHEdav+gfVs7gH?=
 =?us-ascii?Q?AbOFCYOmIJLQm4vAv/9aOue/r1lGzOq9sZf9gNak7YGyAMWTlRPdd7QUm24q?=
 =?us-ascii?Q?X8nZY7saRVZn/PFTbACTWxciE78ZrWwSA16ALFqutxlGykvxeWMvpKx2enCZ?=
 =?us-ascii?Q?KmcMd8+d5rqr9yrhlABd5olA6QyH7/z0MG6uKWd1rqmsW4Lookl7TePHxejb?=
 =?us-ascii?Q?JAxqPGb8/pDLqbp/iWnLomd2JWQrXMub9EMLD2Hp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc8978f-06c7-43d8-1347-08db02c4c98b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:20:42.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAPUbRrKUzMTHz3zHcwuLTVaw5U2wShSkTyvQZOlJ1aJFdeeHzSMdPxmoN7gHwNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 11:44:19AM -1000, Tejun Heo wrote:
> On Tue, Jan 24, 2023 at 04:42:43PM +1100, Alistair Popple wrote:
> > If too much memory in a system is pinned or locked it can lead to
> > problems such as performance degredation or in the worst case
> > out-of-memory errors as such memory cannot be moved or paged out.
> > 
> > In order to prevent users without CAP_IPC_LOCK from causing these
> > issues the amount of memory that can be pinned is typically limited by
> > RLIMIT_MEMLOCK. However this is inflexible as limits can't be shared
> > between tasks and the enforcement of these limits is inconsistent
> > between in-kernel users of pinned memory such as mlock() and device
> > drivers which may also pin pages with pin_user_pages().
> > 
> > To allow for a single limit to be set introduce a cgroup controller
> > which can be used to limit the number of pages being pinned by all
> > tasks in the cgroup.
> 
> The use case makes some sense to me but I wonder whether this'd fit a lot
> better in memcg rather than being its own controller.

As long as the pinned limitation has its own bucket it is probably
fine? The underlying memory allocations should have already been
charged to the memcg - so we don't want to double account.

Alex and Daniel were looking at this from the qemu/libvirt
perspective, perhaps they have some insight what they would like to
see?

Thanks,
Jason
