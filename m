Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635EA332039
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCIIEs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:48 -0500
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:21671
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229652AbhCIIE1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOtSuKSheq1f1uud7BzmYy+HuWxlfbIrnr34sWPqKu4igh/5deInT0O8k9L08bLUajgrOKyBwDQsPSL5dbj9Tr5rgBVfkZ8dh7fzSYXxICKAk3mrvB0FKNr0mb4Fq5V8O1hpKTobwkXunZNV28Il0YNsTVvSgORIvLINhp0cWLguq9ktT8gCDseoUbld3GUD1udVGTsDeH6jajKnAQ8PMACRtSJtkK+aop3c13R7jcOvBVYdHx0S9Bu3qeZLqP5AZbu/aant7nej5MJppL95wGVSntw+vKCAJjC4FEkRw3VzLt0alnFnciwGr0z8t9ATVW7Q/B5akqdFqDZLS5AQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOmah3Ttr9Ux8KuZu/qKnk0qr3VbDotJHjS20FoIgVc=;
 b=iX7XJCDRNvvtd3ncUfVyVWkCHCGNq0vyXEk2qRNJWEDSTr8VOSDjQ1E/1gbpxGyikGd/EGicTTQ5Fgi26Hglgac3z2KMK7JZgmJkF5bWyWYNEQZ2eeKP29UEDwbUlHkecRFPDSnOTtoQHrvzFwkKQNv+BKxqBrTKgSbZTLRrCfFOZAdhCS7M/2JEEmIQIAbiWhn58rQF8utFPHttc28/qqlpJV69SscvPes2IcpR3rTSTZhPPgYv8+VeEe9TKhvJgDRxehSGxJZem+Zp30gSJzsDwr+W3xej1uUqXhRDHBxigccviJiAK4jvijVfTbRXwP0h6tuTbtqmKhyEBSp/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOmah3Ttr9Ux8KuZu/qKnk0qr3VbDotJHjS20FoIgVc=;
 b=RQSuWtKu7YNKRzV4JUL3gFPUTNYuL+FCxfgShJ08jNC3cze6gXt9sznoQnve4759qYUFlj8UQ+ce5Q2Eksio7FGqzP0fK2SYc6u6BnJkiFzETOxTb1zNq4w0dsaARVD1KayMbFK/SIj275w+QxOObiQiysFbxzWTaG12JXcrNM8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5789.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 08:04:24 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:24 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 5/9] memcg: accounting for ip_fib caches
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <6f182357-0a06-7f27-8684-22198725ac5d@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::31) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:208:3e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 08:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6ebc230-2eb8-4563-55fa-08d8e2d1f3f2
X-MS-TrafficTypeDiagnostic: VE1PR08MB5789:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5789C5083D892E73BF2DC60BAA929@VE1PR08MB5789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbdpcCATu+3+RtliJHYVsM4gbtw9a5bD00AbDawPLzbSxuuGLptCTMJXpkuR03tk355IwrxBuDJKDh7ayXCK/Ul258tZqvSzPu8GVP1o3RgUtqr6fI6Ej04AhW1vrbCMcWxVFjLu0NTlCIg4H2OSOHP5NynuYok1AR+1kGPkhjsYzaI4iA/1HlQG9bulw0A/iI3EtguzGVJCsXLPXhWfFJ/ggFIhSxTFFECyS14hYQM+KiU9kaKjIZcekro5PYmghEL8zObyPlG16ErzoOT5LvL/xQx2pln5zxffmgU7ytxsNvNu8a+nreB7TdiVzeQCmcv6gN7TpvBjH0lNEw7rO2DA0so/JmStQ8IGhJssFYbVHYZiUifHdTR8riZn+MU0frfIFDezY1qy45pvXs+DvDepJJ5sTQ/lCBJiwGWtI5pCfYusxDn1Y9NV6SMMeINutatX/MulzjIzyB/zh1fywFfAVOFLtF3NzjGOOxfjMZPK6cn/dM9hQAAYeRzPgQoE4zKoqeog6R8bu/l6aPI95XNyO+jC6JnQpy28j8Rdi7d//H2Qbl6niFi/94aybKb/Rvq2BLG7urJmca8b2GxaPCs5R9Jvlila5KebJGSdWwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39840400004)(376002)(26005)(54906003)(31696002)(66556008)(66476007)(66946007)(36756003)(4744005)(186003)(4326008)(83380400001)(86362001)(478600001)(8676002)(2616005)(5660300002)(6486002)(16526019)(2906002)(8936002)(31686004)(16576012)(316002)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlNocUNySTJ0dmRTbGttRzJjb2pKT2VzVytpQUFrSFU0VWwzdGRhUUdmdVJy?=
 =?utf-8?B?SlV1N3Y1N3dzVnVIVUdDcW5HdG9MMTJtQTE2RWNJYWxWTGdaalN6SjVmTG8x?=
 =?utf-8?B?dU5GK093Q29qT2RQdnEzdllCSU0wKzJOWVZBdEFJM3QxMmtwSXBwNFNzWjZv?=
 =?utf-8?B?TldRZUVibFN3a0htQlNoMUg5MkcyZUhrNE84eVFoRWZnRVBKYTlOODROSmhI?=
 =?utf-8?B?a1lKQ1VuTDgrdDVKVENEWE5oYkRabzl1NjFWbjlSMDJ5T3V4ZjZnNGZkSU9F?=
 =?utf-8?B?dVB2b3ZucDdMeFl1ZnJBUkdnazFFSTc1aTBtdEZyeTRIcklGZHE1eXZqYlJj?=
 =?utf-8?B?Z3c0eFpmT0xFNUVSTUtJcXdrU2d5QnpDbkUwTXlyWDd5WVFqN1A0YzRkUkNx?=
 =?utf-8?B?MDBpRUJvMkU5cHpsM2xrUWpCK0lKU2FiWmdPUWduQ1ZPZ0g1alV6amNRWllK?=
 =?utf-8?B?MUNtV1cvTnFWdks4VlNEVzNNMmx4cEZhWnJ3YUZHSE13cHE4WndROU1jTEVW?=
 =?utf-8?B?SVBBSjB0Y1k3K001YzRPd2dZLzV6QlNmVzhQSHhJenBMNkhxSEdkL2x3NkVN?=
 =?utf-8?B?K0dMU1o2L0hMQlg1bHZOUnIwUW5GOUgyLzhzclFYcVFraVN4TTd5WXIySklG?=
 =?utf-8?B?R1VBVTdoWlNDRDFYZU5Kd2xuTHhVQk9YSzIxVEhzN1dmQnh2b0NXT203UjJz?=
 =?utf-8?B?R2pkaDMzZm1JZzhoVmJQK1R5OFoybFhuSS81UlZsNVBmeisycEU5dlU2a1Yv?=
 =?utf-8?B?QWVLSU9SZnozdE9DK3FwYnlyWEFQUm1OVmJmeFpQK3plVWMzQVlkQXdkcko1?=
 =?utf-8?B?ODB5RlFsbzBsVDkvQmdxN1lHWUF5MzdJeFZXa0Rkc1hzQnFpdXlaeVFVSzdV?=
 =?utf-8?B?SnRYWlo4QXJtNnNXMDZkQmZFR0lPZDlIWHlsbEJlcmVmY1RtdnhXZ2hYS0w4?=
 =?utf-8?B?K0FvSkZLZHcwaWtDbktra2JlVDZaUEEvTzg2Q3N1RGJtK292dmNWMDgzSTBt?=
 =?utf-8?B?MUl0ZzR6RnpLWlJwMjRSTzc4VkFuSXlWN0crc0FXWk5MSWhHYzFQdHpVRlpM?=
 =?utf-8?B?Qzk0NE1CYlQ3blBKVFFrbWRJYkpNTHJZNUZLM1VyQ3BaY0RSUExhZVJhTEEw?=
 =?utf-8?B?MFNiQXZBV3MwRU5QWGl4Smg4cldqeDJMNGtNQ3JCRWROSW1jZE5YZGY3SGo1?=
 =?utf-8?B?eXhndER0QTFkSkw3R0hNZjRaTnpocGhqVEhSb284VWxTTC9pUzBCTlRqbWor?=
 =?utf-8?B?OGpqRFZhMk51eHV4U0FaU21uUDU2RnVxMU5uWmZsZm9EWlEvaGt3MHkvYU9L?=
 =?utf-8?B?YU5qNXZYdEt6eTBsNmQvU0sxS3VSaGJuSThlNXlyWXZnL08wN1BlY1RNSlhw?=
 =?utf-8?B?R1dXd1ZEdjRiODFwcFZFaGZyeXBWalphcng5SW1oTEdUZXF5VkF1dlNYL3Fw?=
 =?utf-8?B?VjEzSFRqYmhRdXh4NkhVWDFWRGxvYnBYU0FYLzFMMm1JNUYzaWRXcUdZUWdm?=
 =?utf-8?B?dlRwWTZXRG5SbG5PMUl0VFpOYkNHN3psL3BSRWQ5MlBxc3ppeldoUDExb0V4?=
 =?utf-8?B?NGFoUDY3TlFWYWNoZERzK3NKOTRqYmRKRE83NmNXdFdHek9CYUk5eEtheEJs?=
 =?utf-8?B?bUF6QjZqZVBIc2lnNkRlbTZHbkpYa1FXRUpudFNzOExjQUVxWEV1eFkvUFNs?=
 =?utf-8?B?ZDVVYnQ3Z0xEVWJnejdvQVBiYUJJeUMvMHZNWjREQ0cwZi9iM1ZCQkZsd1di?=
 =?utf-8?Q?DknTPxPPSaYZg+F4gdbXuJDYIHJJ+sbfgotpQEv?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ebc230-2eb8-4563-55fa-08d8e2d1f3f2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:24.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJRsHSm9k904wpiROI/htbiAdKwGjtqDhwGukWklR8vVLuHXhqHV6HiyuEH54k+sa7z9NwwBA1/qkQ1uk/ni5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5789
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
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

