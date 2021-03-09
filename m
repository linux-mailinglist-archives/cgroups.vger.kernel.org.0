Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65F6332033
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhCIIEQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:16 -0500
Received: from mail-eopbgr130090.outbound.protection.outlook.com ([40.107.13.90]:37543
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhCIIEA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaYUwQXsDJ40La1ZKDyRUpO9ur7Ge+cnsG8FJdA6/PDf/mRHYGk9MTELmLnVZAU/+H/FPDHMPvvyaPqckCluUfvWaPxryZZFrIAB4MyPokCXlmYHzV6pyAcvXqujL8nBKTMjT1gPII5O3BJTLuODfy8mgUwV64tvCjp/+E8ZeSQiWBZodLXHsY3+bJy3AC5hwwOwvjG2N0qI4PqDopVFq5HWNbZ9toKbynf/z7dmgiBdc/pFW/tMR9ypeGoGbwXzaOnAGQVl7QaL1K4g7+Z3FJ7uIPZnFCM6aEgvzuquh1bH8fiTghD9TRYjXt/w9+sbT6GXdr2+4ULD3c/ko+n70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv57v9wwkEkRFk3quNioC72lkLY1VHt10WJve0iQRuY=;
 b=igHhA65iVcKq88wXiKF6R4/hMAlJK+I/LCz4whRKMWPkYSrOgiT272+11rQs/BlB0ZqxIZbDSkVxT9/PhgX6CIrOQ+lXCohvM1HGE1d1KeAwtJifXfB71u+SSKRPzmoOmQIaohXJfbpqIOpD+lNyPcXMqsFwaET/IJjeFafOqTuZmPp2u6Oqhum2Kn3ldPIen8u+5Eo8jfC6pjLHZR0YoI43PVx6xOkgfR++sIOkeIMcstzqTD9u4/Gue9h6Ir7yMftHGoy8E9du9EgASnUV6lLsj36c8qu1RimVhDUTZUpv5d0mH//a+yBQDC5cg69EpwO2uGdx5PdOa91rmfS7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv57v9wwkEkRFk3quNioC72lkLY1VHt10WJve0iQRuY=;
 b=SUj6B/84e5vnSMKxM46a+k4e2HS1OaDa7AZBrUPRiMnFuiuDCwCKYkMXItyH5uYi9rK/NO6XGWrZTJDpabXJ2f57QRrA0erJzRTXDFHW5DeF+31LZordwKwnWysSxfA/KWd3ePSIGU9BHqtHU5s1IJ3W8vxTDAIvZ16R4g7amuw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0802MB2511.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 08:03:58 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:03:58 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/9] memcg: accounting for fib6_nodes cache
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <f105248d-bd21-8e6f-bdac-4f2c4792fc4b@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:03:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::21) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:208:3e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:03:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3116cd4-d334-4e04-576f-08d8e2d1e49e
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2511:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2511A935A7F04C968B5A5FE5AA929@VI1PR0802MB2511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQpclr4eVqmBpkYhv0Hkht6TGNjjCUQvOmqO9ms6cGRVmpl5PvQ9fK8cknZLY0S/TMS6l97H0p4O6mnvfNKcz2EiVR/iH7Gdt89ZpcA7XXHRto39dWBPji4SJlwLBBN312A5SUQyXBTMaSkjfaE7kZjkkTtjI/0neOrYtw/Ggg6yvBkj3h08Ut7XP/4D/V8b9+TTfgpzCi7uLXgGybvpJUiGlDQzrPIo7GPWapKwUSAHTED9tqmYidVk9grh65JTe49YgH4spCSdBjeXqSLUpJfK/FSklrsKvzffAzlJvy82Hnc7qmFVq4s07RwNRC5DG+r+nrRecKlSlXsE2c9cLS7ATsuCgjC+R6rgYcTVwep8ak6hfwQq76l9Fy4DPHgzq0bh5WGNcUV3ZPCbqIb/NPzEVMjbaxJizYsICegFuZyGVl/gWAdDgdYLIaSDcjWL9WPANMtQ4ZM2UThuBpBIX7z1lzNXuJVkg5duI4A34wDw01mfBF3rmBtA/4kKQlUl0TX4oVi2Ea3e429MkSj8tj70WtPmHVd5KRmiSVF1QAVGjuISXOyc6Lr0Dm9oh2dDMpx50yFpe7D11dR+yzJAAwH/b+uOfK53ny5ckj7ZAoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(16526019)(66556008)(86362001)(6486002)(2616005)(8936002)(66476007)(5660300002)(478600001)(956004)(4326008)(316002)(26005)(83380400001)(66946007)(4744005)(2906002)(31696002)(8676002)(186003)(31686004)(54906003)(16576012)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2xSY1hma0ppZWd0M2d3WHowN1pNVjRvZmlRSEJvVk9ZN2RRdklHTHZJbzk5?=
 =?utf-8?B?WTBHcitsbzFSbjRCQ1BYZDkzWlhicTFyQUF0eklhS0MzOUFya1V1WjRHU0RY?=
 =?utf-8?B?MmthZUtrVGg0OGRNQVVTMGRrL2F4UGozd2NXeVQxbzA2V0t1TDhUUUFnekVX?=
 =?utf-8?B?T1NULzRUOWQzT2VrT050ajRtNklQYmxrUDJDa0l3a0xXazNqRFNmN3ZCTGRw?=
 =?utf-8?B?cmlVSU9jU3RXNXczdTY3RGNKUEIxR01PQlp6T09aMXk2amM3K05VQnFhWjZX?=
 =?utf-8?B?RmdnMU5TeEpHamVLa08zMGQ5VWVXN1pnSW9MQnF6WUdsQXJaL09KTjZNQ0pq?=
 =?utf-8?B?S2Y0cFRqZTE5ckR2L0NUVXNBdlZKQkhCdHYxY29maUt1MUtmVGNLUWhXRHVm?=
 =?utf-8?B?STB3MHZBWWloOE1Va0ZrMkZVNENYdU1taEEyODQwSjNVUE1mK3o3SVkzdmJB?=
 =?utf-8?B?bWVQb29CTDVKaS9qdXVKbGI5QnRwVkJvb0NTMlR4UEFXN1cyRThQSGlhaW1a?=
 =?utf-8?B?SFdYSldiRzI1MXVXc1UwN0d2ZFJpK2VXYTBxNkY0ZmlPZDliandGYjlYTFg1?=
 =?utf-8?B?ZktRbms3eDhidzk1VjNJUXlybXdURG4yWU5qQ1ZFZTd1STk1WmxNaWFOK2hS?=
 =?utf-8?B?c3hIdFFDYjBiRThSdVNxNGFtRDRuOWVpeXdOdFFzVGx5MHJHcGdrWm5LWXc2?=
 =?utf-8?B?WCtJL083enRjayt2b05HTnBvbWFZOGRPS1RUVTlzbUlhWVBQMkdvRGJYblZp?=
 =?utf-8?B?V2s1SUEwWnFxMzdWbWVFZVNTU2JiTG9rTm9lckdJVk8zTzliYTNSbysxdUh0?=
 =?utf-8?B?OWpnUG93b056azlyUEd2bVVTK1hDcHFQTkhReEhtdWFPVWFkTXVrQ3RyVFF4?=
 =?utf-8?B?aUVFVVBBcHdXRFdGTXVtdkR3VGY1a2hDWGV1NU1kV0lPMzJDVmQ2cHo0RUhZ?=
 =?utf-8?B?VDdjSWVXR0gvZEJCUFBia2J6T05xb0IyVHFqeU5TOFcrVFJyZGhqdjFNNEtj?=
 =?utf-8?B?MUpWL3BTQnViSC9TRmt3WVgvQkR2QnBDamt6YndkN1YxUnhUM0pLK2ZiQ2Yx?=
 =?utf-8?B?a2FIa1Jod1A0VHJtclh5cmYwQ1h4VlpCRGhjd09URHlYOFl3RXFjQ0FzU2hu?=
 =?utf-8?B?ME8vakViaXBGd1hBeDlGNEFyYWg0Qndjbm1zMDdtbTg2QmFGRUhBSFdPVTJs?=
 =?utf-8?B?K2V6Umpwa2RIMFhlNC96blBOSktwVVVNYzgvYmRYN2tnRWpDMCs4L3BBTmgw?=
 =?utf-8?B?SUJqSno2ZVl5MXJBa000MDk3am9ScVY2dnpCOXpkV2JBMDByci9WYjZCc28r?=
 =?utf-8?B?V0w0cmx3d2doMU4rSVlMR2hkanpnR25QMjRaQ0Q5NGJVc0RqUGFnQlQvZDJS?=
 =?utf-8?B?WnJhTkQxbjRKT2hSZnpsY3JodFkySUd3ODZiczl6YVVkbFg3TFNxcXlQWmdL?=
 =?utf-8?B?RGRndGtzS1h1MllZdzYyWnp3bE1QbUNpQ0ZRYktOTExhQnZuME5VeHUzZ0VJ?=
 =?utf-8?B?em5aaitFMmhMVHQvZXNyUEVOQ0FQM1lrZmRtQ3JaNUl5YU5BZ2Y0YU5mWHBJ?=
 =?utf-8?B?dnpPa2RLZjhYd1huNncvL3pQNngzUGhiYkxxSUdJQkpOc01WOVBDZVpSL1pV?=
 =?utf-8?B?T1lRL0hySDNVZTd0ajJqNXNSMG56T3hIbzFHNitJRWducGx0RTg4VHVGemNy?=
 =?utf-8?B?eGwxTG0wY1J6L3g5aWRoUXp2RjRxZGlNaVNYWTNacWxSbTlCR1lyMG0yQjJa?=
 =?utf-8?Q?jfLfLVvSP0wUl8MvjWH5hBJihuWZJIXjlXwD/7H?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3116cd4-d334-4e04-576f-08d8e2d1e49e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:03:58.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5LbmpPtdY09VbgDWswd+CcEFuQZIsK+XyXNMqHuo8Eu6o0t1C+Hh7cbtzURCxaYQZGOG2XgDFZdvwK3oqf8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2511
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 net/ipv6/ip6_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index ef9d022..fa92ed1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2445,7 +2445,7 @@ int __init fib6_init(void)
 
 	fib6_node_kmem = kmem_cache_create("fib6_nodes",
 					   sizeof(struct fib6_node),
-					   0, SLAB_HWCACHE_ALIGN,
+					   0, SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT,
 					   NULL);
 	if (!fib6_node_kmem)
 		goto out;
-- 
1.8.3.1

