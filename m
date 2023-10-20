Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B07D0656
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbjJTB6T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbjJTB6S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 21:58:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487D126;
        Thu, 19 Oct 2023 18:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8OVxa21E9GM9E+t957DOrL0VzQZ3bH3ruDqxjt6D/BiQHbKSPH4+zbQiMMxkQUfwPM8db9S2tcn0+KDHUymCOmwt60cihytD7DbHgGGDfrEjH+11OkWQjxVgJycopkk4dsa+wndZNvRczbSSK76IQyz11JYaMf7km/zWg0VEsgbpDBO6IVTO5u+7I3Apxa2eD8PFdIMf1JHOCUmu3JviKrwJ34e+ovydqWfCnp5csSK1njY88r8jc4GACiCeZWZKcgWgk1YojJEjxeMs0CEgs9ZZwXZQQc7vBRpO4rlkN0Y2ZPpEDkn47OzWCWpC/ZsaaaNXN7piYtDZJenP3W4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN8orXA1XeDJplVAOp2sawZnFxSG/nxZrVqJcoz3O9k=;
 b=hCuP4N2JvoA0AvSdbEYuciybxyoFs9Y32sa76+F2Wis22UprnvKbE9MUoRyttK14U6y3Mp+MhuEhPR6oaqmnnlVCNmICWBtREb9+xDTNLpVAAPsSYql8L+MejOrdq6aPQQWxA0ACgQsicdXXTc+cgw8GWWU2kl+XM2I3HI8mcAozNMtgwaHN6ZQXmYVGyty4xdNWO1z+4b51xUYDJNuJInrDh0NJx7nIi98yj7dwIV29u/6jeXEh5B2wXlCY9D8ybFiSg3Ny02q0U1+YP1jNOownsOBvAnYVxqGgzdYNmvcVL8zeCeeFGWtrnyeDl3LwN1YnRDDlhWh+tdQi4g7S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN8orXA1XeDJplVAOp2sawZnFxSG/nxZrVqJcoz3O9k=;
 b=Q6EMfh3pu57axMyzhN04W1UGP6HAt+mpGVUKyJa/6HvvgKM7oTGjpYdwKdQiHUbg5XKTC8+3XWAq5+1uqlEmwfA964dsILpna8BdL3Mb2oQFVqHJ9hHFTlogLXa+kmPx/3CRp7B1lYQbF38v420vaFtf0+0rxEF1O56DbusoH/7LHENj2dJ6aBn+Kwo+wrDUjJ8AO0VNQm1daQm5u3c9Zny8N5+ljrO6C6lZhmx3YVSF628b7fgoAGbdb9490xMOsy7yLaRSOKBCbbPwVP4BKy/VhLvI6XYbadI4zLyiB21RkBAa1Q3j5EMB4Zf4FshY+7vTVhByHQHYwmtfeM2X0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6197.apcprd06.prod.outlook.com (2603:1096:101:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 01:58:09 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 01:58:09 +0000
Message-ID: <771b551c-9604-4e6d-a0ed-b2ecbc42ea4d@vivo.com>
Date:   Fri, 20 Oct 2023 09:57:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 RESEND] Per memcg lru_gen node stat
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>, opensource.kernel@vivo.com
References: <20231009025726.5982-1-link@vivo.com>
 <CAOUHufaX35Y6MfwKj_XUWXJwdC=9M=g1gXpQpQghBZ2fXrkEAw@mail.gmail.com>
 <CABdmKX0xevnJfcgsDEWsfX9J5T2x0EV7x-p4ommq_Deg98WwYA@mail.gmail.com>
 <d9b31019-9374-4531-8967-d289af3f4f06@vivo.com>
 <CABdmKX21QfTDXJ2o=CbATmeX1OSgB1XnM=escE7xf8gMrvMhGA@mail.gmail.com>
From:   Huan Yang <link@vivo.com>
In-Reply-To: <CABdmKX21QfTDXJ2o=CbATmeX1OSgB1XnM=escE7xf8gMrvMhGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5acc6e-499d-433a-ef13-08dbd11001fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRSscl4tqLr2ZhovVwrBBRwaBY0qLlHL/rJrfmKqXDAS31stJUoVtO+7LMWimxMK7vSh9X/G9pTesWEGJ8Br0NflsIesFsV3t75432G6+JlYmhikWDemfXpYW6AVmR0UXgJ59SpjbOTKojCRxB783IMK99hHvsxQAIwVhtFT+x/mxZKz+pIejhvadeqUuEvREesmoPXk6AZi5CU7E2FvtqCpHNwdUEP5uSsjE8C55daOrrYkQ9d0bfn/DXXdOUC+N42PcPmTgH2RE+xfOVTt7xhX4Q1JqcOkdqqzy9BcGIIN6AeXaUPtWMLBSi21E3/SwJXqmB09owq6EO61kSNIB4N0kGnXYA33iqFui4I2aWGpSDxeGE8oO+LYJsXDtpWdGAinYvcv+QRXrO/U0r7GPCxMAF0iSBUwdp52D6s9RCO7n0GR0rq/1U6S5AEBW0PHkKNQwViPwv9jwpB45+GDzLkgQUY78pwOS17EXF1oflnI44pmNfOUGtIQaTWWZPaxFMfrvp5zR57zjz2rnbo8c5OBjypSbXKtU6dvJtBj2gT3VRlfIxh9ziQ92u6gq8Yq9oVvS+yRTvjJeK/vRZuzvP131QVyXDDVOT1hIj3qxG7BuTISWnKb/rBcvM9/QTaGXQamEvM93snh+kEICwIrYSZRo08HWHE5JhL8oTE9kzS18jS5kRfatAN2wMM7Xyc3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66899024)(66476007)(107886003)(2616005)(6666004)(26005)(8936002)(6512007)(6506007)(83380400001)(52116002)(53546011)(5660300002)(7416002)(8676002)(4326008)(41300700001)(6486002)(2906002)(478600001)(66946007)(966005)(6916009)(66556008)(54906003)(316002)(86362001)(38100700002)(31696002)(36756003)(31686004)(38350700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG11SzhzNGFvV0hMTU5yUUQ3ZWJKbnVGOFh3K3haVjRTemtxbjFEYStXWXdU?=
 =?utf-8?B?eDhFd25uKzZvQ1NXblYxd3hvN2Zob2ttVGI2TEc5bnVwWnZUSm45N1ZNZmZq?=
 =?utf-8?B?c2ZXUDhIK0gwTlNSbllMNFIwYUZJeGtxWnlWdkVoZjVXUi93Mm5zRWNLWmVz?=
 =?utf-8?B?ckxJU3VtaHVTYVNiajE2WGZtaVQ5RTBGVkpudU83ZXZqTWovTmk2ZXhTMWtM?=
 =?utf-8?B?T2N5ckw5V3F1SGV3YlZRU2FWNGlEZk5rTnJLV1lVVHVNSkloUy9tZjlsYUR5?=
 =?utf-8?B?MjEyV3JWc3F4cEZDS2JhOGtKNEFDdVlrR3NrRXZxNVcwSlBOSUd6cDd5c1BQ?=
 =?utf-8?B?Rk9paUJKWmZGMk9kVWRhbDdvL0ZqRjNnekZDNitMM3Z3ZVhHcHk4dHd2Z3pz?=
 =?utf-8?B?UUhuWHd4NXRkNVNoNHJFVnpzUzFFM0ZHY0QyS1dxSGZRZzE5dlV5WE5vZzNR?=
 =?utf-8?B?b2dZQXVBZ3B0SnlkKzlQK1g0QjhlMUVPZHhsK0Q4N1ZjWkFXWDBYNi82SXho?=
 =?utf-8?B?WG5QbEhlSWduNGJhU1hNb3ZLNnE3T1dycDBnZWlNQmppVW1ZYmdhSkUrNHFL?=
 =?utf-8?B?L3kzNjRTTVZsOHBJamNyMTVmcTAxV2V2UFZsV1lxWTdZd2psZUdTTXZhMXJM?=
 =?utf-8?B?Y1lPV21HcDhudXlEalNzOGxBdVI4WXI1QVpqdzNMZE9HamFUd2MyUFFXYWZt?=
 =?utf-8?B?eE1PcU42bFV3T2h5bTd4OGZXaUtFL1lFWDZvN1FPK1dCcTJTbjQ2Q2lHcm1B?=
 =?utf-8?B?Nmd0SUlZT2hCbjBJSHl6V3JDYWNJbENGcVE5SUgrcnNZSEM4bUFuTWN1TmFp?=
 =?utf-8?B?N3VDdDdWK3h6dDdZamxlUFIvaWhycUNORjNlbUpGa1g4QXBacnpuWWkrY29h?=
 =?utf-8?B?NU5YTkZ0UlZMdDBwWU8zTGI5SnoxZ3dLVGxoMngyaWVPWThvYkdFSUpCM2JR?=
 =?utf-8?B?K2QwTjlKUW5DeG4wQ2N4UU9XUm9oS0hyaklqSXBNRDdJNGxlNlA1bnBuUjAr?=
 =?utf-8?B?Z0xXZXVkVVRCUTFPaUViSnN3TlFOYWZhQXZqRGxVNnJGdExGd1FBdFdGYzB2?=
 =?utf-8?B?ZGkrVGxTeVVwTm5FYy83VzFBMm9qN2JFblM4MzJqNWZWV05pYnZTNEp5WitT?=
 =?utf-8?B?anhiZWNYYmIxM0JmcU9ITEpTSFhCQVA2emhUWHA2Unk3bkt2UnVodUhvRndE?=
 =?utf-8?B?WVVFZnZNSVQrN2xSWG95VTNuTVlwN2ppMVkrTHFBRkZOUkdVMG1wWHo0NDhx?=
 =?utf-8?B?cTk3T2pVS0EzZnJZUjJTRzVwOStNbnp2bnZua0V1bUhlR1BnM2MxZWd2NmFq?=
 =?utf-8?B?U0RYV1VOdTRiUnRXZFNhQmhRamdhUmt3RGI1OTBFTXZOSHZidGRqUTZLdlZI?=
 =?utf-8?B?U0hzbWMvWGhwbUJLQVo5UGdOVndVcnNaelJacTBBZE11SjIyZ0RWcEFWeW81?=
 =?utf-8?B?QTdJVkJFN0Q1RW1ka0JzcDE1TWpCKzlVaXJBbVFPRGxRa0trTGpFR2Fzemp5?=
 =?utf-8?B?ajJwSHRTSkV2QllGZjlpNVRKMnlxUUM0cCtweVYvTFlZVnBVc3pxSXBreG1m?=
 =?utf-8?B?R3VKUU5MdDd0bWNLNEF5WW1mNXhxb3dVbHM5eStZTnFMSWFQYWlkYVZTWEIx?=
 =?utf-8?B?cTAySXBrSUtzM2J0TGN3NVNjazNXQzhqQ1RWU1VWK3Y1MXhUSzgyYVhjNUxW?=
 =?utf-8?B?OXVYd2FwcCtOMDRDUndhNnh1UmVrTEJQU3ROM1FDeGJqT0hjbzJVV2tTYllh?=
 =?utf-8?B?eG5nMm03TzNUeVhoTy9tamFrbDBzbC90dGJ2NG5DNXBSVGdtQXA0WFF4cnND?=
 =?utf-8?B?QlFKZHg3YS9TWHBQdFlQdXZTZWJSTzR1VmUzL1BYbDN5OXJwKzBZVGNLMEY2?=
 =?utf-8?B?M083QVBFejZ1VGNHY0Z2NTg2VW1oaVA4K3VRZjFlT0tGNXd0RXlUSXBFZ1Aw?=
 =?utf-8?B?dEoreEdkNWQ4VEp6dnF0WDAxb1p1YjBZUEtmOU9nTkRlL3NpTyswcnJXOUd5?=
 =?utf-8?B?SDljWmM5RFF6M3dLSW9zeGYzT0s3NUZzbEErWVpnRHpTYkhlV0pyanc1d3NY?=
 =?utf-8?B?SXJjbFAyQTR2UGlGSzNwVkMxbGkvMHl2Wk5mTVZJNVFKVWJZbTFsZ3dsRUxN?=
 =?utf-8?Q?i70fRPMku99K1yWhXhVEYUFnX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5acc6e-499d-433a-ef13-08dbd11001fd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 01:58:08.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRcqK56qLEKjhg76eYNu4EOi8ZNzOfmSUYh+zb7ArHLiRKTpy/EmyaVub6FpTG8mWuxBHAab9Ily+h8cFEW7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


在 2023/10/20 0:01, T.J. Mercier 写道:
> [你通常不会收到来自 tjmercier@google.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> On Wed, Oct 18, 2023 at 7:32 PM Huan Yang <link@vivo.com> wrote:
>>> Android can't use debugfs in production, but I
>>> think we'd prefer to use memory.reclaim for eviction anyway because it
>>> respects memcg limits and reclaims from slab.
>> Yes, shrink control this actually can use proactive reclaim.
>>> So maybe it's possible to add just aging functionality specific to
>>> MGLRU? It'd be nice to know how you're going to use the aging, or why
>> Due to debugfs not always mount, if we want to now lrugen's info, maybe
>> nice to offer a memcg's node to show per memcg's lrugen info.
>>> you want this version of eviction instead of what memory.reclaim does.
> I think Yu's inquiry was about whether you will look at the lrugen
Thanks to point that.
> info from the memcg file for a production use case, or just for
> debugging where you don't have debugfs for some reason. Because it's a
Yes, for now use, just collect log from it, not have control logic.
For future use, maybe we need to control a memcg's lru_gen anon seq reclaim.
(just assume)
> long term commitment to add the file.

OK, if I can offer a actually use case, I will send again

Thanks too much.

