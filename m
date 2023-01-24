Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0204C67A3A4
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjAXUMH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 15:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAXUMG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 15:12:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73848A05;
        Tue, 24 Jan 2023 12:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMUIm2wImMDbwE2ZkJrsVdEcEsr/59V5BqQOVwdqNPxryF1wKayLDYz300fXOOx8mbth3E7vEKxBFz6mrBigx2eGpNNB4DJgabKWJG6n0sT8x2R4XwhBPmymLVOS3STC53SqhMZ8e5NR6cw7TSCHl7nBdQneI55Gw3xtUpenZFjvzKLGvOX5JDSoKp9pcgyH2zjbD11d18f/OkeQzJn5kbTe+/Vi1lIzL7QgE2cvBQb4/2k+V2k/1yB+zq3ilunGymfg7HuikALVUeKzBeIoorwKUT5VDT1EWzzT8uAYnYZHpqx8nbPjRq2/XYWsDS7/CrzAfZ4BRx2W2UJlEVH37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfSdJyyULtrOpfbSVhYDUgYUP+Kcr0i4zzjub7Vqyzg=;
 b=W8s/IWVLQ1hvbEI62XxroxTqt88rYRP0tXxxeYjmbvfIprlDztw4+aWB4384Jqww2VT+6eibzNsnnLq4VfGF58v4d2ybmGL2So62TNCwkfKRG2UggV9axQUchS8HcxMOw0j3gNoAO3Qc3oyW+9fr+RGjYBEWLXO3i0pJ4DHR/O09/zom2763IU/obc3y2y/EoC0Uib+nHNqT/pR3J/+w3MOYU0suvT41fcKzXEfLNpboWNca5e0N4961lOWIABqSG0SCc2val/OmLLkT/z1hlGrlmnJDnnr9sISqBf8W6+bAQeqmGW6sCIuspnZKkg6Jgk4+huJAUR1sSAwrlkGWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfSdJyyULtrOpfbSVhYDUgYUP+Kcr0i4zzjub7Vqyzg=;
 b=jCc/4Xi3cG4QC8+cTl98C0JhhPrXgsiOQ+vFDcUm8/oFr5jXi3ji/4NLcUe+52qT5O0bl6kWepfKanv6k5OTE35UIbcReoK3RqdzJ7u2PmflmMfE8aIUVUFNLWUGrhtpJJzxdl1EArKxIkCPP386KKW3pJ4+2HcXwsPADZCiqUoB/wgGDciI2esHZTmOfYSez7prE/qMq8rccA5fXVDsrd5rLw8d7o+eokxRdukW+rZZ6ffPJqmp3roIY3QUBD4SSYPgHGl/aojC8jCefyOQYGI40pW6UulFbxnlAkBHed5zZBEY6i0cMijI3p7KnrSXE0IuW/D1cdtprEM9JwTORA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 20:12:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 20:12:02 +0000
Date:   Tue, 24 Jan 2023 16:12:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch
Subject: Re: [RFC PATCH 00/19] mm: Introduce a cgroup to limit the amount of
 locked and pinned memory
Message-ID: <Y9A7kDjm3ZFAttRR@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac5b171-42c8-4290-8ead-08dafe47416a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fH4lbLYzFM8njS9g+qWFlzjJRQlVCo5Ex+/uXG+OFKNeEgR7kCdB2s4sdD/7BwN3CrBShmKBLX1T/vx+8dhaJNVgQrG+hSQGea2sJsACXSIJOuXM8hG8EEkjH42j8Uk9iQKjrakRYxdiFNG022WLYG2dVCAnuKy2lSbQCE59VzeORXgk+AW2C+emM2Nm3JR0N+qkb4Hd1/b0OfYycXZICEfbOB9afsNhO5JMjCfnHIN8ypnawsWUv7PVmPDNQLbFCs875AbJdpTk0BKNCekVNxLEtEWijQETHfEOWzXITbUHWxrw0JjWDCTTgbMgIyZFbB6ZqQmkswADr3AaYK/+l5Wl8NVISA8EqzG6f4gKEVjYuoLi1pInbqexnrf44tIDrJKMgVS7cMpz/51+AdBZH1IVIkHXrsZL0fWE2CfybNzbMRyPtuw4RbIQ3L0WD4GOxpQvDQ8IzvIiS6GUdyzQgGnVzwLcqo/SR5ABLbSlP6BvNuYIXtBdxkjnAGy3LDiwxUmQ2dzTtQGQ6Hsm0fIrAQUXdcSZE73U17w4eb72fKuWxipYsQiF6iOpUporc6diQSW+QzVfN+Dq8msjzZn8PIY/xQKK6wq48LYuBOT6lFONOzM/ftj5IcKFc0vO3QZFBKvxPGoY9GfG0YJTuG0DWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(83380400001)(38100700002)(316002)(2616005)(66946007)(86362001)(66556008)(478600001)(6506007)(66476007)(6486002)(36756003)(37006003)(6636002)(41300700001)(2906002)(5660300002)(8676002)(26005)(186003)(6512007)(4326008)(6862004)(8936002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBbpAhYJw5HFSmKuJaThlDeNMJ6oPhugiKHsvaOV8tB3dUCBLQNvEfBU9u6q?=
 =?us-ascii?Q?YVmj6ukVBIp87EP8g0pYsbEH0X69zKHkYgz1gOvbGcCd5iyGFzT5zQjwLgEn?=
 =?us-ascii?Q?ANJDF3KZKFTzu00ylgXqSlJASSvIBWushYa+dhqpI1fKnzSyC5t8vqGmfxeC?=
 =?us-ascii?Q?iNj8xpSTd8uqsHvC99HK37jW9Q/EkmPq//WD183g90JL3JMcuCxE/ILLtahy?=
 =?us-ascii?Q?U+jBkOed+g9Qbu7Ype6yULJdIK2MFey7ANKShMfm9nGtAT4wL/CII9sOD++A?=
 =?us-ascii?Q?XFP9ZZV0mIq2AwgHtuOQolcrAfUrEvtB/1uZ7mLqlrip8ex+pWWZlrfSZSiY?=
 =?us-ascii?Q?RZHP6ArB3X19+8+ls/mIZva6aizy2ITshCbqk3XgMNrj/n4R8uVdjAFG9696?=
 =?us-ascii?Q?1eRcxMZhE0qW1nmRGXY/pnEqgf4KN2zLjhWrg3HIbV7fUzcuytOzQyK1BGvd?=
 =?us-ascii?Q?5Xio4SCQ9qN+SA+kNYWd/hnBAA1MA/TAn72yXdCq8Q9vz02R9TOfa1WGW/L3?=
 =?us-ascii?Q?yaShsdCSy1qb2GvfWyAZRJ/JB+8O+jSa/u+9XDmG3kpztDs77/k5y4kEgaxY?=
 =?us-ascii?Q?HgHb40EzRtpgefy2k/uQQLVOknKZGvGmPB/PwSRVRRdub3q/3Yrb0yP++krU?=
 =?us-ascii?Q?Z8q2S+1RuU+iDttEzBdH1TkpFuCN5XePQ70pmjRx6gu7AtQQ41Raa4JIYpfN?=
 =?us-ascii?Q?gRkBh9zv/vDcZVza820AC3KKgEknyEsZScGW0ylLVN97hPtQupXE3lrm3enV?=
 =?us-ascii?Q?5H72SyAnmYfzH0L/3nmc5Se8yvh0Bg7vZNmSSdkB/cpY2g2eT0mJLV8UCfT/?=
 =?us-ascii?Q?eXPSGpEZpuN5emarbbnLqQvTUHrt1L9w7wn443hAp2tySie9Kz5qezx4Nu5U?=
 =?us-ascii?Q?l/k28e7sPOyREP9ybRaevyttrZO1OvUCgovE9YcqTNY1dOgZXjWwdBgdNSxZ?=
 =?us-ascii?Q?ExqpFb4m9ZK7r8/01SEAcZSLc6LhE8+l3wzYckqq3VEwkBl2qz/5vqcqxeho?=
 =?us-ascii?Q?eh2L2tKEvkFeXxsDS/2FjTNuIE+CS8hRQW6eKx9NuNt8z805O9gptZfs1QEr?=
 =?us-ascii?Q?xoFOGJ8u1oH0VhWAdp7TEUUdsAw460LLSXFqMOxmrE5LAGFc4o5Quxi21zEj?=
 =?us-ascii?Q?D/ZhLxbJUkLqIlgjvfjQ3+aSByY5pwtFxgYhKkO3dFpL3VqiBlmdUUw7GEaG?=
 =?us-ascii?Q?f7KwesIPD8zoQ0Gsoz7+uVCKgmFyHhjulVnB/6zK+u98H+Kr0UFk4Q69bMf7?=
 =?us-ascii?Q?eZZF4DTdgfypODbCVoHzkb18tDrnoX2aqmpR0i+0EB0Fj5kaeHzunBOQlne+?=
 =?us-ascii?Q?MAZAZGJYeFLIiRmZesfYWsucEYyxwAh519FUPxAecbQs2HDVmWX5xAgFEi9U?=
 =?us-ascii?Q?+0ALW7WB/MojHoDeFoKHFDgj1XL/sFNyj/mNbNt578kOTlify/G4rXPTQh0/?=
 =?us-ascii?Q?M43HUS/4qhw7tkVtrgrk94YU4mOxGqSC1qDByI+w3Uuk9UOEBvkIEztZLmED?=
 =?us-ascii?Q?rLeeLLRGD0D6d+AyvYuOwVBSAl74ro1/e0B8goyQwzV486KYReNnKBkRSojI?=
 =?us-ascii?Q?6ITKvKQuIcwGwCETl2vNMQTQBz3Cf+Hni6TDYTmb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac5b171-42c8-4290-8ead-08dafe47416a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:12:02.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WaHRsTIxHhYDAj2WHwcVLfJuDjjwu5T1AIz1JO43TXAT0GNoo5HxxuK/GmO09zT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 04:42:29PM +1100, Alistair Popple wrote:
> Having large amounts of unmovable or unreclaimable memory in a system
> can lead to system instability due to increasing the likelihood of
> encountering out-of-memory conditions. Therefore it is desirable to
> limit the amount of memory users can lock or pin.
> 
> From userspace such limits can be enforced by setting
> RLIMIT_MEMLOCK. However there is no standard method that drivers and
> other in-kernel users can use to check and enforce this limit.
> 
> This has lead to a large number of inconsistencies in how limits are
> enforced. For example some drivers will use mm->locked_mm while others
> will use mm->pinned_mm or user->locked_mm. It is therefore possible to
> have up to three times RLIMIT_MEMLOCKED pinned.
> 
> Having pinned memory limited per-task also makes it easy for users to
> exceed the limit. For example drivers that pin memory with
> pin_user_pages() it tends to remain pinned after fork. To deal with
> this and other issues this series introduces a cgroup for tracking and
> limiting the number of pages pinned or locked by tasks in the group.
> 
> However the existing behaviour with regards to the rlimit needs to be
> maintained. Therefore the lesser of the two limits is
> enforced. Furthermore having CAP_IPC_LOCK usually bypasses the rlimit,
> but this bypass is not allowed for the cgroup.
> 
> The first part of this series converts existing drivers which
> open-code the use of locked_mm/pinned_mm over to a common interface
> which manages the refcounts of the associated task/mm/user
> structs. This ensures accounting of pages is consistent and makes it
> easier to add charging of the cgroup.
> 
> The second part of the series adds the cgroup and converts core mm
> code such as mlock over to charging the cgroup before finally
> introducing some selftests.
>
> As I don't have access to systems with all the various devices I
> haven't been able to test all driver changes. Any help there would be
> appreciated.

I'm excited by this series, thanks for making it.

The pin accounting has been a long standing problem and cgroups will
really help!

Jason
