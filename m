Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC76A0EBF
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBWRbx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 12:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBWRbv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 12:31:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA7A580E4;
        Thu, 23 Feb 2023 09:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwmNsMdV7f8C6/bin6Pa7F8LyS694ZndVVM7JcrPku7r/M8X0j3g6ZiFh8NqCHsKDFU4iI4uq4+NSLb3xU5LAvbolVXRhstJixBXiCElV42xzrhozpuwQLnF80dssNxVhEAdaL1s5PfcPN1KXedaSXUJkR6ldPRL/siEhO7s7NYCEwVgJXokFu2qCAJcGxbq/KrEs2HIKNqhhpRWF/aKLUB3OFKvenp8zn2HmZn6q8HR5xXHfjqr80zqTfrT0A/hQ8BuNM2Sj6y8MoCN+bArLNIiOumIAmb2f7TQue1y/1xNss1Nzw3n6tLuwfnKTXO91BYZTSibpD3rqMFJcD7hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wji/GRjWBVE1P0YGFUl7ByKFVOA8jASXwOT45H07NyI=;
 b=FBpqZJc3keHgm8YHK4BOCw41qR5hr7jJKVBSAZftABYiR+CJS+mVfc3QUUA/uH/Yz73UElKzZ+SX+39qotLzHyCC7GnehPi381JVUUAH0ZnInRR08s16ffKwroKRlTEQWfijmsgD/2E4o0zg6qf7XgYFAWIV+jxMUEsqM0NAiXgN/mnX7mwQU4A/mTlBhz6hLwCE/2tfHqhJEVHpBhllG+B0r6++q18Xz6D2GB8NqNl1MymvnIijqSitUuWfTlTw9QmcYWq7YM8lLFJGmKEozzulXAJzyvUfIYdM0ow9WrW2LJj5Sx3MgaXkbB46Kxq8wn+Gk3cp/T/PclBPQDVhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wji/GRjWBVE1P0YGFUl7ByKFVOA8jASXwOT45H07NyI=;
 b=YoHCS7+LQOpFToa7nA2ttQfew2SmTsIwjdk5SiZfTyliOW+mm0BcEd6zqlFoKKN+PhCFvJ5K1JoVnJnkA39WlASHJEoQckYRC8zb+tLsGyBFJ1FSzmAqSIZ7m0jb2XdJMOuaE+RzmnK5Rh2549RWKvhrHytZIyLKaxGy1Zoycf4BtZ5JM99Y5xBHoQeWRKnLFMUrOFcucJerY0XORl9LlVPMBLRiiCIBq7ve44FKk/XzUbKZBBMHlyfsQWBXmYmD6R0kiyuW4Vbvw8gCzIb7Z0t/3ZmDXaFyUHgTuLRakMidQIzTCUQDC/9+6Cka2PKbjp3Njoej6v75CvikpuM8gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 17:31:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 17:31:46 +0000
Date:   Thu, 23 Feb 2023 13:31:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/ejAKU7l8DFrkR8@nvidia.com>
References: <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
 <Y/ct88JBeQuSmCuj@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/ct88JBeQuSmCuj@redhat.com>
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: c78b3368-3cb6-4c23-3e45-08db15c3d67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiuxeQDW/kLc25XQDpk4r8daCcpgjrzjjFWBQHgdXpagIB+iQyY0sOoAvTeWPrVl11OTIGXunEd8NtDCPShe29NV5joz3ZxJsl59Tnmxu5W33PXOKXLvZFgdzCCUR/A4mwjYMTMqMqefxLsg1lA9LgEQOIe5IR+MinsvLl6CMIlByCz03WAknVarf7pCj77WuNxxzUqoOFwL1PbGoQNPFBOvm3T3sUm5QCk384IJ1u9Pq1EFSa58DAmS2ib2KWxe1Dq+Qg3TUytWpXBKCUGkegYNXb/JE+Oj+IeNzBqa1JJ0lwA6Fwdvm3aaFVtSWWWz+sPniz4cud9z6xd2aSoGS3f7Nj8OCzXEhmbw8tY5LiPTmOmCBx3E7vdS7jNoNb4PnEYTZeEscD+LRZz4eI4ruPqB7usSjORQMAcsOBF51tNsexvwzzisHnhYnsdgrxF7G27MYoetfHBGmJC0euJRm1hyF3JiKpFj46oK83L95SjR9ChQuzZ80Dsbtq/p4esdvLtZMCEnzArVBWxJr06HVPH2cUQf5ObVpDPL8HrhnyU+nTa3zNtaxO9IRpW3Mwzbia0BJZaY+F7mC5y65WWIhBrtMUT4WC27PFXS/lG8x+yr/yebRQ9funljBjO871kyTXaOR2gJQp5aIhxMpvhS5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(83380400001)(8936002)(7416002)(2906002)(4744005)(5660300002)(41300700001)(6486002)(316002)(54906003)(38100700002)(66476007)(66946007)(86362001)(2616005)(8676002)(36756003)(4326008)(6916009)(66556008)(26005)(186003)(6512007)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekVZdE5ySkcwN2VxQzhxVFJPYXlDemx4NS9TRVNxcFJMbEtEbDZmdUZqc1RC?=
 =?utf-8?B?eHIwVFJmU2xJbWtadzUyL3VreGZFcko4ZlN3dEZWaWtaVTF5SHVVV1RyeTNO?=
 =?utf-8?B?SFo2Z2prZkN1Q3FKQjhhUXFMUTNQVnZGTlVEYWtQWGlKUll0TkNnQnJMZEU2?=
 =?utf-8?B?RFNLNVhETVhoRnc1TjI5Ti9lMG5IdkhDQk5kYnFJMnZaYzIvN2RsOE5jT0xw?=
 =?utf-8?B?MFRMdVpQdTdFUkllMWxmZXJFK09hZmpRVHc3NmRCZzA2OGdQdUl2RTRlOG5O?=
 =?utf-8?B?ZXYzZlhiTUs5cjE2ZVlrYVk2WVprYzJkTGpiRTkzK2w1UW9jYzBBWWMzZjRP?=
 =?utf-8?B?SkdPYnpjL3VmQU5NSzdNeWthd2xJK1pvRk1pMk5SVFM5SHlmdTdWZWFiYXgx?=
 =?utf-8?B?Qys2ckxrUW4rdVNFK21rUHZlTE1mSWluekdPOVE4cWtXVlJzNnBGQXFJVDho?=
 =?utf-8?B?NnFBekdZVklkUXNSR2JPcGZ5OXYrR0dYTDZCWHhtLzRCRU5GTEhkeUI0Qlpx?=
 =?utf-8?B?YnVZZXczZDA1TEM1U1JsazUrQ1F0VHBadzFiQzJERHRsQlRSUDRmUVdlUHBK?=
 =?utf-8?B?c096Y2FRWGFGczNHWnVrc3QxaGxZWWJhTXp4Sy9RQ1lJZzVicUFLME9DbDFX?=
 =?utf-8?B?WFg2RHlLZ3VBeFFiWXNQUk9yRCtUNkhkZ2ZhTWFiM3owMXhiOXpvV1ptRU1G?=
 =?utf-8?B?bGhESGhvdlVEbkI0UVpHSVJ3UUxKMlN4bEZqRTNkaElWd1BHVHYyaExJb3pn?=
 =?utf-8?B?MHFVWlk5V25sVDh4d1Y3U0NOVmYxci9SazBqOWlpVS9aQk9jNGxRTlJwdDFz?=
 =?utf-8?B?NlU5WEVBRFprYmduZTFobEpScTdiYVJ2Q3MwMVVRbko0R29yR2tUZER2VU1M?=
 =?utf-8?B?UmIrYTd3VmVQM2JJNFFKU2hUY1Z5U01qMGUwZEdkY3FKb1RFNmc4QXY2ZWE3?=
 =?utf-8?B?SnhTRFR3N0R1TVBKLzZPQlF0dzQvZ09nUzZPMitDWlhyZU1ZOEl6YUZPeTlZ?=
 =?utf-8?B?MFhoNDJEdlluQk9wcFNQbnhSdk5ob2cxREc0ZnhNN0xuMlJQa3FYdTRqWmNI?=
 =?utf-8?B?TFFTMFpkMllBQWdNVFUxK0FJWjk1aW43RlFhUVp5djltdWx3cHdnelI3REZr?=
 =?utf-8?B?dGhZeXpQdFlLcTJHd3c5dnV1QW1kQ0czdW5aZ0g4R1dldkZoaVFwWi9QN2Mv?=
 =?utf-8?B?YzhteEFLRjIweDI0R1h6amdSTVJFMXdSdWJTMDhMcEowU0tocjI4aTdRNmNG?=
 =?utf-8?B?STJQL29jREdlYXhFOGFEUldGcjV4aVAvcTd5RDJoUWRZSkpyZHMyTkVSYUlC?=
 =?utf-8?B?TXF6V2NLK3poRUNBamUrRFVKM0J0ZGpOV1BLVW9iS1Y0dm5mdGVVLzlBeWRL?=
 =?utf-8?B?VDhVT0Y3eksvb0lmTWduUmI2NnNORHJtaTlzaHFmRDc2Tnhsa2FySi9UMTUr?=
 =?utf-8?B?blovTTVaMGhZTU5tNnNDckVRczNJTmhlTHIzU3Y2MVpIQ3BIazlTbHZLVzRY?=
 =?utf-8?B?Sm52dGRyNGhSUUQ2aEppK2NCenpwbkdYUVMxSWUzbUwvSkhzeUt4RzJscER1?=
 =?utf-8?B?c0g1RUhoWHFOZVJMQ3krd05XNjZvV0RqVk1UNmFxVHRoaGNLRityeitJajQz?=
 =?utf-8?B?WXpyb2dqT0JPK1l3SVZxcVJkcnNQb2YxTHo1a1pnNWxmZEZRZi9YYjlDdWxP?=
 =?utf-8?B?VGs5bnRsMFVhclJXWTNiUnJUODRMQlF6T2NzQXpCSXJPQ1JkMW4zNS9RYzBF?=
 =?utf-8?B?MEthakRIeXpsZVZ1UXVjcUkvZmcvd3B3ZmdzZDhSNlhlekxRK2ExMndTSmd2?=
 =?utf-8?B?dGZaVUxWV05OVkFUY3pUNzZHL0Q1SzRVLzNVMlBwYUNQOXlKcHg5WkxqTG5r?=
 =?utf-8?B?NlFhT0xzcy9lUFhyRGFyTVBLdEdPajV6dGNHSEpjM0hJMnpOaTE0NktjSWZk?=
 =?utf-8?B?cjhWVFhFZnkyY0RhTCtxN1pXNGQ2cExaZ1VDUUU4bTJrZ0hJakQxUFdNYlUr?=
 =?utf-8?B?Yjl6UGpoQkJtWTU2V2ZaZjkzenZKTDBEQ0VVRmovbTBSVzh5NW5yUlk5dVp6?=
 =?utf-8?B?RUhNTFdzbkNBZEJBdTNreHVnQ1RYYmtoak1EZDJvdURUUFh0NVJ5WDVCREtT?=
 =?utf-8?Q?vQUSCjdUZ8q4l2/WhgW/egqJf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78b3368-3cb6-4c23-3e45-08db15c3d67b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:31:46.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suIID+pjHBI6M1n5cHQGCCiMPWYHG/rLN5n2ckEezgpmhggv7trQ7uWVVdfG/v4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 09:12:19AM +0000, Daniel P. Berrangé wrote:

> The memory limits we can set on VMs are somewhat limited. In general
> we prefer to avoid setting any hard per-VM memory cap by default.

So if you don't use hard limits on the memcg..

But to do this with a hard limit:
 
> We do still have to apply some tuning for VFIO, around what amount
> of memory it is allowed to lock, but that is not so bad as we just
> need to allow it to lock guest RAM which is known + an finite extra
> amount, so don't need to take account of all of QEMU's memory
> allocations in general.

Will need its own controller, right?

Jason
