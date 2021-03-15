Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677BB33B27D
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCOMXm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:23:42 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:20964
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230123AbhCOMXX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUleOkGwOf4L+7IGnWdtxzgQqz/Sjtx/mkKRNMkkKr/oOjgtnVTDRbY9viEOeVAv609/VuOgyc8C9P/AyBymuELKbsI2f2Fk+uqBTH4WqW/N55yykuB5EK90VtnOouGZuaznlCkzopjASmMUvKzP/d8N3yrjLisbYsC2Q5jTA4IELTNX+7R2ZzOjxkXCoG1ZJYBdEeKiYRIOL+GdqE11cZVdxMK13UAGTmQ05vJdCxTR+PtRxM/z2X00wCN+hVCz8i9CrbtQy/d9PCLjuGn/gqt0wfpToFVP4ee6Nnl4SH2SUZ3ZrrKEQcDA3KMRzX01t+znUpiPslCPhMXLwYt00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIVQCrfepn7+LB5Z6PL1HL1FmD16vJnT5AAbfB1IpTk=;
 b=Su0yxIwUKptOOn8yHcHgb9ig+KN7hz1P8ktSe+0J3t6RXUQCr7+mYkaOTCkhfGv5Y1kJ8TFxIrSOsEnSZNKEjGBj7LoVoLRWYQ6dZjGUHhguL23O3vQ1C7z1eS9trxZG19TA3+/eP7oumil1FwtRzu3CGcUOYdjAegPoHfNwW1OulABI4bFFactn0hCRyYJPdvFH5+EemqrMRFpGBS/3vlHOo7hezTAYZq5JfXFeBYCrM9LaJYi/OTCI0OZklZRIIsjOK16yc8K3Yf4cbaVLyyXjpOKV2nbjhO0cR43530QP42LqVMYGS/GXmh2bGsDpNpp9xb0Ej/D1l4BBmsD83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIVQCrfepn7+LB5Z6PL1HL1FmD16vJnT5AAbfB1IpTk=;
 b=Erd0aYFk2Lmb/uOJYRODKBQJEi2s8kVv7+TZvuCgLWMXEm9lU9wqtSM67qU9XQkqfiS+e7hzoyCf+Eh1m4n7cFJOdM+e1kOko6HndiDaZZMkCH/B7pNVaEQk4EVi/s5IK3pAV5BBWREtrz0QEvEO7H/Vr7ecygNerKGQ86Cn118=
Authentication-Results: linux-ipv6.org; dkim=none (message not signed)
 header.d=none;linux-ipv6.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB5518.eurprd08.prod.outlook.com
 (2603:10a6:803:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:23:21 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:21 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 3/8] memcg: accounting for fib_rules
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <cb893761-cf6e-fa92-3219-712e485259b4@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:207:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Mon, 15 Mar 2021 12:23:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d0339b-2a2b-4df5-f614-08d8e7ad1f35
X-MS-TrafficTypeDiagnostic: VI1PR08MB5518:
X-Microsoft-Antispam-PRVS: <VI1PR08MB55189A6630D9439C130A45BFAA6C9@VI1PR08MB5518.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqJEEABFEbjvuKOi3NIhXpPnvoXLHKbvZpxtfmN1hwCPUpmPg/NLf3joptpBHujizN/frnMaQGmR+HpPEvwj7vtAyyOh+N1bmQRwNno1mCKN/+pM3ET0KIbNkXVDZwlkvaX7IZWXXddX6LbQXQ/cg/YRoWALYNv83KNt7cEhYyjHlRE9oRrqXPjCUDrqTWuGSO78CdlvbfyOA49fVSoIj6BNLkHPKwFwr10pmU4P+kR1OkLEiY+ArwrfvEsvw296aRnlvJv+IOdY2ci+ayXtX0pjZCOm46IpsYHa4pIbRkdMb0OE86fvBAj95oTIcZc2pZP0CWDPJxxCRCiTRHX8br7MoytR2M0r3lTQrjfurlRE0QrAYDk2a7WTpMr8UMqB7Ks3/c3nClNR7A9pk4onYv0YG6p1By+32i4autcE63MtS3J4w69+5hfn3BwvjqHEHsBFXCoiG0M/0jija+/jZI+WDm7V9ocLwhfkPSepsdkyza3NdFuyuLSmLqWdMfW3OE7ThU23WWx03hDiJ1CMB0sOpfc/uUrDICRlrkUshLommpXuWQ0H5nCLOyMoaECz5T41nvEIdyPBuolRz67Td/1RlENg5RVfXtIl7p4PE5rYYratqpiy0ISOxLyGZiiiiTZDlAWLVpSJ4pFk0/shTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39840400004)(54906003)(8936002)(86362001)(31696002)(5660300002)(7416002)(316002)(6916009)(16576012)(66476007)(8676002)(4326008)(66556008)(66946007)(26005)(2616005)(478600001)(83380400001)(6486002)(15650500001)(956004)(52116002)(36756003)(186003)(31686004)(2906002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzJWQUVPa2thckhlQnFKZEJnVEdvbnYwMitDT1QzMG1hMjRRU3B5dGVDSUlE?=
 =?utf-8?B?MGRjL2ZOWWdpTmk2U0NwcFVIdWRVOUFaTzlUSkdMaFkwWTl1am5JY2l4YlBo?=
 =?utf-8?B?alVnbStRNFlITFc0NUdMalEvUHlZaHRNMm52STE1L0ZocVpMOHpBQ2F1Mkdm?=
 =?utf-8?B?UHRlUmVXaWxKMElLaTFqVFdMRzVTeEtSRGlIQTdNU3ZJT2dBRHBXcG9icGli?=
 =?utf-8?B?VDZZVGZMTm1Nb3BvQ0xwejM1N0R0SHg5cUQxOEdET3U2QUZqek5BUEd0SEpC?=
 =?utf-8?B?UzNZY3Uva01yaTc0UEJKeGxIZHhLY3orWkVKQUZzZ2wvWTBUTFdCdWdZK3Fm?=
 =?utf-8?B?dkVHaGt6RWtyUTA4WHRRUHpUbWFqUlBuRkpyYkxVQmJ1MGt4bTk3WkcrbzEx?=
 =?utf-8?B?c1BKSnNYNVlIbFRvTkU3ZW5YUEdKTWpXdUNPVGYzZmdMK2FNRGRpeVlkamw3?=
 =?utf-8?B?NVpmcGtWTHpuZXdTMHVXcjZkc1REVXVpTkhJZ1gvL3ZEUENneGRJUHZyZ05I?=
 =?utf-8?B?bmlUdXp2NlJrdHJjRnFWenpocnFDNW5KYWo5eUU4c1NaenJIUDkzUFpSdHg2?=
 =?utf-8?B?L1d6M0N3YlV4b1A3Wk5hQ1JnSXRsWmo2b053eFNwSWJjL3BjVXdvT2luMTc2?=
 =?utf-8?B?eUFBVFRDakVldHhBaXpwQS82ZDVBbm53UHVHbzdnTDVBeHVMT1pPdHRvakZG?=
 =?utf-8?B?aTZCczdhYTQ1YVdVdjh2cGV2ODZ6OVIyMllyd1hva210MHprVnN2NXpXVkNS?=
 =?utf-8?B?T05wbmNueHFJcW1vNUZUNTJoUmQ0UnU0b1lMTmlCVTdOdFlhZ2FhbFdoWUNO?=
 =?utf-8?B?bkFzeGZ0Q1d5ZTlDbmZkNHoyWW0vUkE3dmRSdWZFYUNhWXdESmhlRXo4QXdq?=
 =?utf-8?B?SnBQT0RxZVZveFQ1WHhoNHloTnF4R3pHZHBTU2FJdXVmZTlOV1hyQmtlR25i?=
 =?utf-8?B?V3JnRG5QNkRSdllFaWVoVmk5Mjk1UzNIUkt3VEl5Rkt1ejRaVndLemp6bUcr?=
 =?utf-8?B?NUNMRndTZk9oU0wxL0JFMDNUemhBNm1LYUpjSVp1azJqRGtScFZmbkhudktL?=
 =?utf-8?B?ZlNGZ2lXSjZjSHcxZDFmcVNZQy9PcWFYaHFYVDRqVWJ1WTdkSURreTZKQzZ1?=
 =?utf-8?B?TUsrUXNRZStOSkorUzRKQk95WXNMYXhCaUhjR3R5bmUwdHBBQTBnaVVuTzRE?=
 =?utf-8?B?REtnbTlkOUgxVWhkUXlBMDhzWVFxWGFST0F2ZlJVK2dGRmUvdWZscW1tRk9I?=
 =?utf-8?B?N2h0WDRQUk9YdFB4QTc1WUVGZkV1OHM0NUJJS2ZKdVJORUZFQkZJQjJYZTUy?=
 =?utf-8?B?cUEyVkthaHI4Q3FwVW9tcjhLRWNSRkJDSzdVMk5vd2hSYUM2RDNpeFE4NHhw?=
 =?utf-8?B?WGY3Tms4MmhWblNJNDc2SFhGS0dBaDVuUEs5OXVnWENHeWVvaXpFZGQxS1o1?=
 =?utf-8?B?Q0ZPZEl1ZFRzNWtHN2psS0VrZWlzMzF2TTNnN2s1TUQrVTRkQlU4UkpBaHBr?=
 =?utf-8?B?OGllS0phc1ppSnFDNUdXOE5PdzVFWUJRaVlOc0o5QUpWN0N1eTJqZEpXQVcz?=
 =?utf-8?B?WmRkN3dYQmpHSDcwL21FaHN2dWRoSlZuaE9yaHg1V0daMHMzRkdZdHB1RmJk?=
 =?utf-8?B?ak8xcmlNZDB2ODNZQ0M2UUN4S2dFdjF6TjN2b294djdNcEFFTWdwVFc1RWtr?=
 =?utf-8?B?N0NZS1lrR3czT0d3a0ZGMm9BbWlQcDBiRzRxcHkwTEY2d0V6eGdTbXpEL0ZM?=
 =?utf-8?Q?nRMz8n7ckkXh4dz/li1ZKHnB3R+10JaOV5LfoIU?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d0339b-2a2b-4df5-f614-08d8e7ad1f35
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:21.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYcs003SMFxVxvTEqBGZXRrrvtXffZFB+gvF13FQ/OCuPpSYqkxyz3O+e5ucTISPFXeZ36BC3EiK0XRzTFNE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5518
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

An untrusted netadmin inside a memcg-limited container can create a
huge number of routing entries. Currently, allocated kernel objects
are not accounted to proper memcg, so this can lead to global memory
shortage on the host and cause lot of OOM kiils.

This patch enables accounting for 'struct fib_rules'
---
 net/core/fib_rules.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index cd80ffe..65d8b1d 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -57,7 +57,7 @@ int fib_default_rule_add(struct fib_rules_ops *ops,
 {
 	struct fib_rule *r;
 
-	r = kzalloc(ops->rule_size, GFP_KERNEL);
+	r = kzalloc(ops->rule_size, GFP_KERNEL_ACCOUNT);
 	if (r == NULL)
 		return -ENOMEM;
 
@@ -541,7 +541,7 @@ static int fib_nl2rule(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto errout;
 	}
 
-	nlrule = kzalloc(ops->rule_size, GFP_KERNEL);
+	nlrule = kzalloc(ops->rule_size, GFP_KERNEL_ACCOUNT);
 	if (!nlrule) {
 		err = -ENOMEM;
 		goto errout;
-- 
1.8.3.1

