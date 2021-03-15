Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A9B33B27C
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhCOMXl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:23:41 -0400
Received: from mail-eopbgr150092.outbound.protection.outlook.com ([40.107.15.92]:9702
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229873AbhCOMXN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFdn1dqJg0l42R9f6Yh5LaL4GXaPoT1XbYH62R5iIpbvs56b1r8n+NLTlgDdg/LwKKBgCR3GJ91vmaQkjCPVbwfDjPTxaOPx5jr6Yfnkt5bEnJ0sQs3VhacQG9lmQG6ENDiSeSlfsLVM8z/J3xBF7HKc/uEucAEu4SJ6h6Q9Mr4IScPtzUSYuRcAMK0dkzGiFopFNgfnjMuEGDJeoNs5AXB+AW07gQuxlPyVp5ORwOndwhzIgvVkGfVwpPf8zTuka/9Dkyg54yON5AZzjqy0ZDD+uE1OAyN+EQhvFhhX/xkuVofO0GL0aKZXIB6YQJ+tMFeoSwXQi5zy+Q5+jZPs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/7TzPxZL+BSxMV4OSMz0uuVRjCbejTr7FbJogY4760=;
 b=dF1E0RLwOTtPI8zzofLQnZ5SXP1fF8DEGZ/KdrwSIwx//gE+b544ZIsvMmUlRiYKP6LdHsi3OIsZVNQYpzwh3z7tkNfiyTHueqVTcqH7tNCsD+x+UiZ8yRee3BtwK5O0DMqfqnniiL3UumZnXHpedlewXAF5JU52PoztyWUSqJKpjaeE1lha9BT6f7wyPpHT2VTXLbXI81jgCYHrJc1Q9Rt1uXLCSRO8T5fjoKli5cFyKgzb0KZIJBiT7gDNSsatokn4Lc8xqXehM8KrFpWD90iHCnR5JkXlJYZeZIbBNYHYNLjEUUZJQwVNN2QHBQA1/JXm2TpaBdds0XGGXwdSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/7TzPxZL+BSxMV4OSMz0uuVRjCbejTr7FbJogY4760=;
 b=CnNukf3/nISHyDI02EDWemSP8axhCQjNhvipVhkqiUSr3ddp3xOZ5qTP+Faw4vQgD1rPnMZWCzvMBJ6tDfqqFyPo+hbLKuOIp7qwQgsQwgtLO6HaRPZkOthoxGIUzJGD5iM5PIgp1nFMuXYA09+dUoxOM/2SS9yVrJFbL5GjvGU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB5518.eurprd08.prod.outlook.com
 (2603:10a6:803:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:23:11 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:11 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 2/8] memcg: accounting for ip6_dst_cache
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <8196f732-718e-0465-a39c-62668cc12c2b@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0070.eurprd07.prod.outlook.com
 (2603:10a6:207:4::28) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0070.eurprd07.prod.outlook.com (2603:10a6:207:4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Mon, 15 Mar 2021 12:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 024f0764-4459-4871-17d9-08d8e7ad195c
X-MS-TrafficTypeDiagnostic: VI1PR08MB5518:
X-Microsoft-Antispam-PRVS: <VI1PR08MB5518117EF98D1825EB596764AA6C9@VI1PR08MB5518.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fR2SnPrDloZL3Ba1mVI+9Em+s2YyPzbk+9ch/4rWOnPPNMT1Z73SYYj5rJFgf9tzlZWgLofEOhHjT0ydiEw957wShiMXxBxRTRMvprgVTH9qTRxp8JwafDEjm27o/Vcw3i8CapSxqI6T7HY5HH1OYiMd5twsrGlmr3ij1D2C9eOzgCZk3OE0JCo05XUAhK2QIiG7vD7/FYjtVfnjXA2RnAcrq33a5fkJo9Z4tdJRQ3h9GNrsdjWIbOePepy1oSHiPrwr34Ttt4GQL2WIqG5wJscNmJT95REcBseXOOiTgfMbUI5qu/vEQ45GOMtJTmlErt8tgRgQ/ck8eoKhzIemaMNFTVrUC+Hn7jgsVFo3xgCuyraqgG+c0TTgKc4n2dy3mXsWVeCW2y4pqRLKDX9Xw18TZ14hi7eEsETm8eIpapgsVWJhBv8ElOBu5UpIwdYvHFVwN6F81k1ZMannx0pS8RXpMITY+bj5ariQ9gP+HI1Ru7nHQfZU+rBeCIroqcajCi9vR6sFpSk1A1Bb62PlNTLG5W2jrmF6vmEAkWahjUF7jUcafsz3FYRihLFHkXq7bdy4M+uNtn5CxWvVkl8y7wDQly3G8ULkZ6K3/shPOqdbagmnvulOTUx4LtS/WWFxHk3ldbvCBUpLR7Da1/QqhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39840400004)(54906003)(8936002)(86362001)(31696002)(5660300002)(7416002)(316002)(6916009)(16576012)(66476007)(8676002)(4326008)(66556008)(4744005)(66946007)(26005)(2616005)(478600001)(83380400001)(6486002)(15650500001)(956004)(52116002)(36756003)(186003)(31686004)(2906002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZFJtSVlZajJCNk5ZTytBMXdkbHJKeGJQNENrRHU2VDl3TGFYZDhDd3cydTh1?=
 =?utf-8?B?QUNWK2VmSDg2bXVPTjhqM2NmZklVeEVLeUU3RXkyQ2tTUERaQ09jWFZrNVQv?=
 =?utf-8?B?N1V1TUQwZWJ6enZZN1pEOEJKWWJhcXpURzFlRlE1SUQvNFM3bDZKMHdLaENN?=
 =?utf-8?B?N3RoTnRKbmF5RjRUekhmNGJNNTRpckg1ajFGOWVzeThvd21tNzE4MmY4bXl6?=
 =?utf-8?B?RFkyekF0amtJUThmMjhNVzZLaFFBRy9QNkk1OXFYK0hvV2ZDaitWN254dTNQ?=
 =?utf-8?B?ZXMyTEE0RGhiS1NySWNiWk9nTnZ3TEVQZXlGek5SRHI2cUJjQzkySlh1UnVL?=
 =?utf-8?B?ZEdwVVN5WTFnRHJmZlVxMmYzN2Zna01xSHFiSUplc291cEQxK2ZYNFQyd0Zh?=
 =?utf-8?B?N3dKaWRzNTNvcnRLS2VlbGhENnRZVW0wbjM0elpFM0JQY3RLQS9QTXRGUnYr?=
 =?utf-8?B?Qjhkb1RDeWxFTm1Edk1ibTA4OFphbTJueXhDUnVLT2wzcGRjSmpKKzZyOWRp?=
 =?utf-8?B?bVYzcEVuZmw1SE92a00xU0daNzVUamxwTlJseUtYRmU2ZU9nbTE3ZWtJc3F0?=
 =?utf-8?B?aU44RThqRGdBaG9PZkRRUTFwSm4wQW90Mk5RRVJWOVI5RVJTSHM3OGNGUmhz?=
 =?utf-8?B?cGI4Sisvdm5VdmlIeEVNaGIyaExITUVCT2pOZzR6ZWFXQ0RGa2IyS29wT1J5?=
 =?utf-8?B?OXhmZEIwc3BNU0VQNVREc29BVkxsRlFvZ3VtaGFiM0NHRzBCNTdBU3VxZVYw?=
 =?utf-8?B?azRnSjVyeTIzWXBxRzRGQi9rdnNZYUZjVTEzMlk1bG15V3gxSHh0OW1Ld3pr?=
 =?utf-8?B?ZHVpS2RNQVM5dmVaWXloU3lnYzdtaWdOWmU1QjYzcEhYQ3N0MzZHSUdma2NT?=
 =?utf-8?B?VGpBUGp2R2RENlFTRVRxZjNhUHQzZnJJcEQ4SVIzdU1VMVI1U2tpZk1XRVlp?=
 =?utf-8?B?UithYTAzYmJEQkg4ZmxDN1JjcmlOWHNBd0FWZEczeXgzLzRVZTJtK25oeENW?=
 =?utf-8?B?NCtVRXBlREJ3emtpYnAxQ2hCZVRQM3R1YUtRcHB6WDZpaFlqN09oVjdzUHVT?=
 =?utf-8?B?bkNKekxCdFFYTmhCNTd3MnVITlVGOVdMeGJzWkgzNHUxK3I4T090a08yWHpa?=
 =?utf-8?B?dVpIcEcyR1owdG95RlVWd1BSckZnZEE3M2xPUzdLU011WHllYVJ4eXhDSmU2?=
 =?utf-8?B?TE5uQnAvMTZJY01uUjI3RWNXV2RFR2U0TnhiWkNid0grdldKN2NxZnppQlhV?=
 =?utf-8?B?Z3JURDF5SkJzY2x1QlUvZktKL1ZCYlRqT2MwZGtBSkdWeDlqMlRwVE5CMEdT?=
 =?utf-8?B?Vzh3SW0zNTZ2enpjaTBLOFAxb3FFVis1Y1A1Z3JnaVVWYXdSMWdHdEloaVhj?=
 =?utf-8?B?Zld4eFc0cDJrc3ZoOEZKclZBRm92a1JxajhFczY1NWNkeTRhQ3FzZUNKODhB?=
 =?utf-8?B?K0xuK1JscEZQZktCZHQ2Vlk4OTRmQmtQZzllN2pLdU1PVzh1aHRJbkNDYitZ?=
 =?utf-8?B?eEVTZEVSTTk0Y0NtOWFHOFJMZzNZeGRyeXJGVDV1Z1NJU29xdE1DWFFLbHI3?=
 =?utf-8?B?WnRGQVJreFBJUEVvTC9oc29SQU4yYzNpeGRmRnRaYktsNzdYWVNoTVdXSDVj?=
 =?utf-8?B?RUROdlM3SzdmcGJnTVBMcHl6Z1ZmbXlqQ2V2VE5yMW1KTTRpRDBoaVdQTUw4?=
 =?utf-8?B?bGF0WVJlNlBEM1Z3ekQvS3R4SS81MmtQNSsray9aUDlBbzR3ZTFJMEhiSFFB?=
 =?utf-8?Q?G8de5smhYYEuK69cnqqkWCL+N/IbCwWWAZg2VRX?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024f0764-4459-4871-17d9-08d8e7ad195c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:11.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVs8sUIA63IxzweeJCCeLA3KoBtS2VrYx0SoJW/6daatzGYF/1VXFx1ovHBrkvYM04LeB4XPWqDY1LAv8qmuew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5518
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

An untrusted netadmin inside a memcg-limited container can create a
huge number of routing entries. Currently, allocated kernel objects
are not accounted to proper memcg, so this can lead to global memory
shortage on the host and cause lot of OOM kiils.

This patches enables accounting for 'struct rt6_info' allocations.
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1536f49..d1d7cdf 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6526,7 +6526,7 @@ int __init ip6_route_init(void)
 	ret = -ENOMEM;
 	ip6_dst_ops_template.kmem_cachep =
 		kmem_cache_create("ip6_dst_cache", sizeof(struct rt6_info), 0,
-				  SLAB_HWCACHE_ALIGN, NULL);
+				  SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, NULL);
 	if (!ip6_dst_ops_template.kmem_cachep)
 		goto out;
 
-- 
1.8.3.1

