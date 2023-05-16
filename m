Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F201704DAC
	for <lists+cgroups@lfdr.de>; Tue, 16 May 2023 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjEPMYc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 May 2023 08:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjEPMYb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 May 2023 08:24:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B21FE7
        for <cgroups@vger.kernel.org>; Tue, 16 May 2023 05:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUU83Su0GvfmLi2q+v4iJNI16HKSR3e7yrFHAeKWWDDVFgSRYH78bQTHguFFikbvwz7OzA6DGXIpPTLXdsqeCZKldII1+S5w0mixRWJL4kLgNd+2IAw3BNmE1uvRCETHU2skxBOzatGgWt2V+nmRn6F1csq9cBDdnkV6oA5MwoZG3z7MyGec2fpMshM3yq4zqjtFQMClTXURhr709T58oQG/gCBVSItg5u0Ni/ZOLpYursdG0OwiH6GbNXuFBuvFYOlPMI/zN6ExNZCfjUd1QKpXJhPKD9Ly9ruHqOw2kfks9IyAX2qUnKR6eF59H3uxK6lEbxQ8X9Th6Q/ZcjT6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzcjHcXWoVQ9GLNTnd73sPk1oCZehBHl2lJh8tWwizI=;
 b=LO8drDNJODe7nxni7f1dvUFvtBIEdutyUbvKgBS+7qz8KAAeFPYgGPyBlHo0B4CcjJ5uQaKrsc0hDNuwxzKTpBhTz80UgPO+4uw2pXnFaPxFwolHlDE7X6FzJOQ5Nb0rXXHGFNvqWhwCwUtZ/ecreGButAz1nvTyMEyTNYFYNowJtiDPhY1VdQiBkKDjgzLtknMl8iu57X9exL/tiHcjQ+/2fMyi6a2xjqk5WQoZGONchrU9NMm/Ux8K+ek2VSl1nnTq3dT9y+gb68LykzxkSZJQEZlNkqtS984ga1Q6NF2D8YcHzorN9oCveIlKKcYn4ZPHzIST4UDT28yAEmDgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzcjHcXWoVQ9GLNTnd73sPk1oCZehBHl2lJh8tWwizI=;
 b=lA1ZEmsHCWucaqf46VPtbG1zVcANVfgFiM/r3FVhqk4KUSwab2J6jN4WlVcn7n5XMEl5ozBa05jokKvsMhpYCuz+XwfbSu5FtNM3/zA4rweKJek+iu9Mo3WUY+H9XJyBprGOitFRKOx1UQaSqRGiJ1yVOgU09f7hQ3Slt9PtoePR4kmnE5WbQKZNwTtvWqInjYqxjMNIEbWtZvwvEOHef0ewAzdLt8hFrGXJtAlKr8tD4qfjWV+S4BGhACiGuSr4bHAv9Ppdf1qOgbzLu7TLAUWHUAdy/CeOMu7mU89XYn5MOz+pVLAwDU4qRqMYJDzQou2RJWLTtHrz/gPqgZzmkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 12:24:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2%4]) with mapi id 15.20.6387.029; Tue, 16 May 2023
 12:24:26 +0000
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com> <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com> <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com> <87ttwnkzap.fsf@nvidia.com>
 <ZFuvhP5qGPivokc0@google.com> <87jzxe9baj.fsf@nvidia.com>
 <ZF6rACJzilA06oe+@nvidia.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Chris Li <chrisl@kernel.org>,
        "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Date:   Tue, 16 May 2023 22:21:10 +1000
In-reply-to: <ZF6rACJzilA06oe+@nvidia.com>
Message-ID: <87y1lo8nwp.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: df60946f-5fde-42cb-ff4e-08db56087d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YYWiVtE8Q8SM+5WbIdAPDejoAJBCWMohgA95Jlk7p0AVGl5JdgXRhcBfTG+I0xmpsD65ji/p5GgUVtUNYdD/7I4Ofo1oXzbElAo6pR6aWZOrDVPLfwVm2gsdbRZVr/LPKiXdk1TlUk10o3j1Kgylr46XygHXfWMV8EN0vcVS5EHgBVoQNdsXjY1z0XqHnyC5aHI0rKE2ip5/V27lrCd7eUDyfPCzLdE+A9W0R2RFiZTRqHhJZ1t7Mx9r2q9wXsHNWuvCvzXMBA1deu7Gt+1k+r4iOP4Vfvimlu+otSvpElkvJhEfVsHEETc4WZBpZsZSW21rIb4+XmOPXEisVplVXLGBbCgBl1Vg74NSJ+TK7dFyQF4kr47OYZbUjisHBEai3x2zut0nHhwDPvrFWlZask3EZH/MMotcAjYiZBqG8PDmIcCQ7GowMZZs8OQEBgWD0wvh2PoXKrr+wHy+AfahbREEqAH2gQtI8S0Zd8GtmRLyjniBcKBNv03KmWSphSirRVlR3KGg369I/cXhAQa0jQmCpcSSwY7G4fYcH3IY/IoGcgyeoXK2t/ijbWc0eID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(6636002)(4326008)(36756003)(2906002)(66899021)(8936002)(5660300002)(6862004)(8676002)(7416002)(41300700001)(66476007)(86362001)(316002)(66556008)(66946007)(478600001)(54906003)(37006003)(6666004)(6486002)(186003)(26005)(6512007)(6506007)(83380400001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eU9Lz8qylC7BvINFkU3jos896C+f8DqUlhzNNYCFZWdseIZJNs2lNTLrVkWH?=
 =?us-ascii?Q?e9I+zfP0KBrTHuB/AhK8sFDKVw9zJLH/4Yg1cXfu1UMEhUC6wJbtpwXJVaEe?=
 =?us-ascii?Q?gh2+9nbj6MEjJW8IpatCWiYdhwk9LKTACWnR8wtMOYwaFI9jS48zKafLJK+N?=
 =?us-ascii?Q?OutlW0ueIjvaUx0C8dvcUuKe7sf4+nm9M3oE3bi9X7HCkqu+fo2B22Ai5oYe?=
 =?us-ascii?Q?UCTrBdjsG57CGxOlwTSHA/tYbtHFp0QwWg0b7t7491AcILWAKynTiBa1sL5d?=
 =?us-ascii?Q?Xef3TH7/0ZuSz+WsLpUFVWijnPvbyXevO+5L0I8QcSWsrH2KBgmqLMbiE9uV?=
 =?us-ascii?Q?T21q05RHCrR0EIFCdxhtWh9WgK6ELzv9A/Xa8ZcNEqBTH8VaZ/JbXlu/dGE3?=
 =?us-ascii?Q?s7EUrtZwcx2A4e7K5wLQ6s8uFhkpQRoWq5pQvWOpBRDtivhW3DmDCaF2oags?=
 =?us-ascii?Q?Ewu6qsaIPHemz9DWIh/6Kq4EHSDrpi2C63W+jXI2AXeAxF9vzxApEctoyapY?=
 =?us-ascii?Q?Umbs4sJzTTrzJWzmkS7hSy0uSvgRUjyzuwbw8fo/trtbWaeK+hCKaxHJ0IpB?=
 =?us-ascii?Q?PvuvWRLgdcaW4lXdEEq1SDYxZfzZgpwpRW1OlR0RkYLOj178fxzmBlKq5IFH?=
 =?us-ascii?Q?c8xWFZr50rJLv0abSFPpL4/T0q0arCK7/rnO/ME9fS+RU1OXjO3EMoTA9+4H?=
 =?us-ascii?Q?9j84YkNU+Jhbpm8AGAOTRrkdT77P/6NHzsX2brvd9Wjwan46pymm6S1qbO9x?=
 =?us-ascii?Q?05ie+Z6//pjLjscchKWfjPdW0MNpVakxyI/p5i2R1336/r2C6+qzDYUf0KAD?=
 =?us-ascii?Q?9p+LNtcHa18T9jdbpvpMuJqI8n3dvqTrMz1jYAxc21Rcc5VOx/dpgobBhrT/?=
 =?us-ascii?Q?qCGX9XoZWsHUwllkRzhORmNjaGXGqPh3aAZZOBC9KiNLl1hPTTrzGODhEqJx?=
 =?us-ascii?Q?mQoZShIqf5ZjNot8K/zC1CcuHXyGO93dRRYDVG6RvSR48UAXriFMnWtgmU8y?=
 =?us-ascii?Q?VD0dJ72skrgNu1tn59MZL9oHiEj63SX+5C4DfVc/avJGMTOy1dtdFMaEdp+i?=
 =?us-ascii?Q?9PiPvzDi3lzYF5bdfpgBUWqgu+Nq1ErgbQICeAUu4jsLzk69Vfz+lZ2Lo/T/?=
 =?us-ascii?Q?ypQ4wbv/LrRcjduPOjjIw/0xbECNwLHC6axJ29p/7ywFefMxFD8UPWzQNn/r?=
 =?us-ascii?Q?TiUquXNepNNRi09JgNKUCYY2BqUqBi624QlCEzm673ISOylPjZupZw6xOSrU?=
 =?us-ascii?Q?lPN0Fx4FkmCbsrEkSOEm/RIwJVhKSdVf8KUWjfWfpYo/4kqi9rv2BtnD7lLe?=
 =?us-ascii?Q?wQp9U29nNGc89HZbD/JrrJ7e/020SDivRMGHmATpuns8K5Ww8zvqom+wq7yV?=
 =?us-ascii?Q?QAnSHfqagtOSOvs3yQFobpHlkxHImLUwzp2z1KjLzepc7JPmVQm4YwG4W0eJ?=
 =?us-ascii?Q?qQlggoNqQLL/tAwmPpdvdWVaOxCf3apYhk36s6Bps0e1gEa2/RXv6iKCnNaX?=
 =?us-ascii?Q?xxZwDZq1e0UilGpy7VSpB374FL1K4mlxDLmdA5sjLfayTRdHtiPqixQkdn9s?=
 =?us-ascii?Q?7qPVUZ7NcISY5eVEyMRslEWfc/rr/j0KMx0lpslH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df60946f-5fde-42cb-ff4e-08db56087d32
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 12:24:26.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC6Bzj5wZjanjKFof8aSnlPc+oG+E8kfp/4Gaibr/UOQ8PkfAcZngvNquOojyxCXdKKgox+zqKv1eTEGNS/YQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, May 12, 2023 at 06:45:13PM +1000, Alistair Popple wrote:
>
>> However review comments suggested it needed to be added as part of
>> memcg. As soon as we do that we have to address how we deal with shared
>> memory. If we stick with the original RLIMIT proposal this discussion
>> goes away, but based on feedback I think I need to at least investigate
>> integrating it into memcg to get anything merged.
>
> Personally I don't see how we can effectively solve the per-page
> problem without also tracking all the owning memcgs for every
> page. This means giving each struct page an array of memcgs
>
> I suspect this will be too expensive to be realistically
> implementable.

Yep, agree with that. Tracking the list of memcgs was the main problem
that prevented this.

> If it is done then we may not even need a pin controller on its own as
> the main memcg should capture most of it. (althought it doesn't
> distinguish between movable/swappable and non-swappable memory)
>
> But this is all being done for the libvirt people, so it would be good
> to involve them

Do you know of anyone specifically there that is interested in this?
I've rebased my series on latest upstream and am about to resend it so
would be good to get some feedback from them.

Thanks.

> Jason

