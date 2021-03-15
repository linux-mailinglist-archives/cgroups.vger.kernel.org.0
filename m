Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59D33B280
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCOMXn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:23:43 -0400
Received: from mail-eopbgr150111.outbound.protection.outlook.com ([40.107.15.111]:1955
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229624AbhCOMXa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1frHk8OZqhJe5YUGEDtxynofrxeU8cDACAAd/+6CiHjUc12hwAeBpBkqVMekSW24FGp7LHFla5IRA0efiNihPDMjdIudmt+3wMaAVOB8tybZEvWUKjZ5qZk0Wj/LA2vv694uSLMeR5I61qMpaQ+j5yGphbeVFsddFIhj1rgrH5kU/GmLil4x0cqo6iq57USy0ARxgekTjNCGCQ2oNpW/TKDmcEQLFCWydkn6ItzV0Mfb89xl5BmeMfKRUpSmw9GAVCWzA145qxS9aXa5zbc1NUR4CRKM32Y68hEsYOcKbwSDhUMYcZCF5UwwuEndklfzGL7WGYCFBf++ZVHa7iiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmVSc1JQ16uHPYaiXfSZZKx4U3Y2AU19uV6TsDNV5So=;
 b=oQ73AiHwlPAMti7c1sR0ck3JRwSJqg/UOlG0olp8ABS2zor5ZBXVMjH5AmDin9t4Sew/ArHmObEZvETgYGzymQ0phrFfOgzcXqsgurKKJw3ag8pHhe/IVJLQT7PxzwfsWmQjw3HB9km2faex/3VXC2Uk9pmcx2NVt3Ky6HLZOEFB9yYBCsb6xTgpe9cvx/3gWU8leupti9P8xw1SrR90QeX3OUjvmWykrO51PeiP9HcrcuNkUyquqCy8CFgQQvZ3WbwQwPcFVh8ovl/3RpUiyEPnb1sP/qOAGWOEa8eW6MZPKO4HMwUJVXynBDbYMX1i0nFetPxHpq0z+mMrX5BqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmVSc1JQ16uHPYaiXfSZZKx4U3Y2AU19uV6TsDNV5So=;
 b=HNEjhJgi4nQJLQW6MDOYgtnIaG/mUTXttm0x6KlC+I+/Ww3Uh/HGaM3/jfDSSJBHuvwRv3fnKay+u3MWDFeSiId7MJXwt/RMgUw/+WJ3hzvacUvhBXOyFMHBgLWFgNl+3nLanHos2yMwbhjyAE/OL+YfGuMieriSASybwLnXqEI=
Authentication-Results: linux-ipv6.org; dkim=none (message not signed)
 header.d=none;linux-ipv6.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB5518.eurprd08.prod.outlook.com
 (2603:10a6:803:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:23:28 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:28 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 4/8] memcg: accounting for ip_fib caches
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <d569bf43-b30a-02af-f7ad-ccc794a50589@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0076.eurprd07.prod.outlook.com
 (2603:10a6:207:4::34) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:207:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Mon, 15 Mar 2021 12:23:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f752ac6-9266-4c97-bbc2-08d8e7ad2358
X-MS-TrafficTypeDiagnostic: VI1PR08MB5518:
X-Microsoft-Antispam-PRVS: <VI1PR08MB5518016B56FA665B60AF4909AA6C9@VI1PR08MB5518.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6H+gKlYaHZcdlHowXhpFy7oJcIllXUj403L9XLNiMw8Phy/I49ikcZdQif8lrR7cUEsrcQ++YHN+0cpIW5si8T0vM0/I837v/YG2gTlgER1AUlgO4nwB0/uSyT/dMsex/LCqVH7sKW+vbhj0eKBD6MlUTzAflicOotxeo67xKlwYT02j1HtEbW9pgSLRCIMOL7Ga98DV/KcTBMd0Qe7NiH7fJYGSnSzeZFPPDPEVbTEopyQGcJ0byJdKcnYIQqLIfSevX2a/rdyLHw3LBTcJajcmRv5VCh3hptEewKCohIGnGkkJkTIUamAKOMF0nmceHfiwJjH7QGlnsJGqwvr/Yk0IXNPd2cm6YXpoS+YZibTlczGBOEBsXq1r8ZQ++YO4pgtvemyX8kkKzi7aq8EFoNI95s72Wk34y6TIhbG97Z4uNqKdwONKDsF19ZFc4bkP0k+adc4h2qgBsN9cMIwywhhNPP3w25hj9qwrRGAJnTYCeoWdVJsh0pnkViv5vAhlwYPytHnhKJIbRWr0gQkGua+MOq+YfLkRqlsO5/2NWw/34TSuLiegnG8q/ZrpE34Z6Yu2rA3/EUiFd5gzupehakk3q1xf+Gg/opO+VUtCucn84bPLwDH8zqfvlWjBYZ/4gOJv1teh3OaLQKhI2IFbqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39840400004)(54906003)(8936002)(86362001)(31696002)(5660300002)(7416002)(316002)(6916009)(16576012)(66476007)(8676002)(4326008)(66556008)(4744005)(66946007)(26005)(2616005)(478600001)(83380400001)(6486002)(15650500001)(956004)(52116002)(36756003)(186003)(31686004)(2906002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cktGaTZ3TEZaaDBlbTY4c21FcWQ1UWlzdDBmUmJtRnpCeWp5NHhCVTFZSDVt?=
 =?utf-8?B?d2hzWWw3am44ZHE4RFJ4Rnc2TkNjS3VhbTRZdEorLzRaV2dML0QvZlB3VVZL?=
 =?utf-8?B?UC85Z3hrL1M2UlNObzJ2cDN5Z29kMHpqR0taSFJ4c1ZKdndOKzkydzFTYTJr?=
 =?utf-8?B?cWQ5RWh5S0tFMnlldURrUTlHWEg3NStjM0NwZ254bm9KbGJwNGF2R2N6Y0t6?=
 =?utf-8?B?dGVSMUtEcDd6K1FWandBYkErdE9KRHk5Z3pYdkdCN0pSOEx4TGJqZVpkbFg2?=
 =?utf-8?B?Qm9KbjdvSnJ5K2krOStlRGg5bHF0NnFZalp2UmRrUHZPL2dwMDdXcXZlQkpq?=
 =?utf-8?B?TlRYbkQvQ0lJeCtBQUdzWVBQZGpXa3BlMTFTVkVUeWRhMUNLZytYQzNjVnk3?=
 =?utf-8?B?Z0Q3aUVVc2VmTDVhL0Y4ZkpXdG0rOW1EYWJJdEUyMEpGQ0JwU2RGU0MvOUI2?=
 =?utf-8?B?TlNFd2MrSU1PTWdySUJmYzVacnhDRXJHSktKbjFKelRyNFhKZFIyaUthSzN6?=
 =?utf-8?B?SUtZa3hWenIxc1RUYVBxNUhKMUhacWVYZEU4VnVQZEJDNFdrTDgvNW0xVFNo?=
 =?utf-8?B?bnBSZHZFZUx1UXh1bDY3SWQrL0Z3M0UvdTd4MGZ0cSt1NHR3VThWSVhhTjZ3?=
 =?utf-8?B?eHMrc1dzcElJRzVpTWh6RnRSdEtlVGJzWGdwbmZQYm5EWUJ2UW5KZCtPWGQ3?=
 =?utf-8?B?T0hRa1hLTFFBUTh6dTBLb3lsUm16aUc5dDF0ZWhRNUpDci8ra1lCZm5IcGZI?=
 =?utf-8?B?bEVZd1Z0Qnc2RGJBM0czQXh0SVFNbmVXUWlVejhob1NCUDFiOUIvNHdyY21j?=
 =?utf-8?B?bjV5eTlkVTZNSUNBK0V1bDhyb0RhUVhMZUdsLzQ2cXpqK1YwQWViUDkyVWxu?=
 =?utf-8?B?Rk9CSmVjRm0xMngvR1ZmWHZmVE1pc3dUSk9VcHcydUVRNmJwVnkybWZMWWMx?=
 =?utf-8?B?TEd6VXpKY3RVMUFJZmFWRlFoL05uUkY4VG5jc2tMY0FxUVRDOXFJOHNsWm0v?=
 =?utf-8?B?bElobE92R1l0a05YSFJqUmhydlFZdXNSdmRWelVzdHZlNEsyNU0vK2F2eUg1?=
 =?utf-8?B?UGVxUW1PcUdtLzBvODdaRFNSTnpPV3ZPVExlcFFyM08xQllPNkx2VllqYzN1?=
 =?utf-8?B?SnZFdDdkMWwvaUplVXZ0NFdhd2NnTjV3T2I2cWdQa3cwMzlYWFRmbkgzNitF?=
 =?utf-8?B?S1V0dElJZ2dpUGdBYldFTzB5dEhneDZzUFUzeTJXdld5YjdWRE5UdmszSmQ4?=
 =?utf-8?B?UzhlUVhqL2dYTnkxYVZVQ1NnSlN1MFVMTzV6bVhibzdab09KclZWQjk1MGYy?=
 =?utf-8?B?VnRROXhtK0lJVzkyY0lGN1BCcUFPZHJjZmNmRTlFRFVwcEdmVW5pTTJWNW4y?=
 =?utf-8?B?NHRxd0p2WkxCMmRDaFRhUkN6ZHgwUnhJUjA2WlBiOEFVaG91NWV3THVqWGVv?=
 =?utf-8?B?djBwejhjVTBwUGxXVTlyMFZqQmZuVFgwRmNnUVNJNUhVTDVOZXAvRGtkYlpl?=
 =?utf-8?B?ZEZQK2Erb2hNSGVXZ2FBcHlhWm44VXUrTTZjeXU2b3QyVVgrTElIc1JqUFNG?=
 =?utf-8?B?dVJ6SUUzUFRNU0QybXlKNDN4R0N5d1l1L2RZSnl6Qmwyc1NJTFliN3hzZG55?=
 =?utf-8?B?R05tc0R0YkRZVmVRMkc1QnRLWkFTUm16bkpJd24wbzlDZHI3dmRQQzN6MWhZ?=
 =?utf-8?B?KzBhbE1DREpoaERHTnJiSWNDZG8vQ1lvQTJlQjY5Nm9vSzViZ052cjc2V2Ur?=
 =?utf-8?Q?uF4kin1x4JJ6YQGUv6gaUTxE3cDPKrN/fvHXkYM?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f752ac6-9266-4c97-bbc2-08d8e7ad2358
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:28.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPjJVTnJ6XlU0RvNz0JteZ6UiHzsk/NbRgAXoIYf8/JAEkapRJHo8og9eVHfoFN6wZJQsLr/qPB5MnOKSNVgPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5518
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

An untrusted netadmin inside a memcg-limited container can create a
huge number of routing entries. Currently, allocated kernel objects
are not accounted to proper memcg, so this can lead to global memory
shortage on the host and cause lot of OOM kiils.

This patch enables accounting for ip_fib_alias and ip_fib_trie caches
---
 net/ipv4/fib_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 25cf387..8060524 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2380,11 +2380,11 @@ void __init fib_trie_init(void)
 {
 	fn_alias_kmem = kmem_cache_create("ip_fib_alias",
 					  sizeof(struct fib_alias),
-					  0, SLAB_PANIC, NULL);
+					  0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	trie_leaf_kmem = kmem_cache_create("ip_fib_trie",
 					   LEAF_SIZE,
-					   0, SLAB_PANIC, NULL);
+					   0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
 }
 
 struct fib_table *fib_trie_table(u32 id, struct fib_table *alias)
-- 
1.8.3.1

