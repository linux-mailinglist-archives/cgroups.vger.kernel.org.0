Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03E433203A
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCIIFT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:05:19 -0500
Received: from mail-eopbgr10112.outbound.protection.outlook.com ([40.107.1.112]:33259
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229726AbhCIIEv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5fcqg6x48afdt/MwTDf4vGqfqJxhvaL/72BQi+B9Z64HS0/T/dXjfLtABQf5Obpg33KjT/5y1UOy2ps32waJ7Z5ymgXmy7speIKcS7dcpLTq408PTFDwoiyOniZBYNDufU0VliX2lrUpQD1emq4Bw/WVocZ6DwPSeTR5lKHbQ4Uqz16yV7jCpbgZGImHqpui9f0rQHLyvr7suBfVJQTWAO/tIwJtw61qjDVDnp5rx6AgHqUWf4c4/mCMQhjGXxCBip4Eopl5Oj3QTxMnyptizmNEW7A+7vuqrgU35mk2dIq34W/QYyKJ7hCHx9gAChUiWanD89m6U3ydPnBNQjE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvOGfhU67Ne0x55U1mi/eYx3RQi6tluzUKRhpEayLOQ=;
 b=htqVM9LoYTJdiML2nqRENLcuRAVcfaMGYZf3CGnwep16SGlqM48PYRyeH88u8ls2so4jYVWf2IZhlCSdLnhBtseP7SGEq/KE5uHY0B7/kOdDK7ArYP6JXNJfJyGCmeg3N6c436FryVUl5V9G5jAT4Q4q3pA7KCFUDEXSk8ZBE3DdGS8KgTGJJ7/0U8fmPUvlXJOYxv+v1GzfNcHTmJ1UoEp2IEA9Kdyk3gKcHOCVsWm2ct8JupU4o5Egw3TMoAUTE7uld8tbLe0YTBPB1vwy+BIqaGYnPblmRVkvj6iFviDVLF1H+wOBNa2WjwlmWcyjJewD9WlZdEdMZnLErMTPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvOGfhU67Ne0x55U1mi/eYx3RQi6tluzUKRhpEayLOQ=;
 b=DoOD/d2xRXZgq6ijyDzejbWsDTKzgy+BN6kj4WqlAqakaRvL6hjpP/ysI0/aIQCTA4qqCsmJrYCGEQle/STjhDD1D5iXQB7Kz8H+frxGHtEbY84YIkVZFYjRlDhastTkGPPJZncc2PcnrR75dwidXtX+1VPaMKeK63H1sVqu8gs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5789.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 08:04:50 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:49 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 8/9] memcg: accounting for tty_struct objects
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <d205d15f-7694-7940-a534-66743f452833@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Tue, 9 Mar 2021 08:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf97c14f-3276-4124-25c7-08d8e2d2032f
X-MS-TrafficTypeDiagnostic: VE1PR08MB5789:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5789979737E087657C69E7D4AA929@VE1PR08MB5789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJpJ+0JYzbfC7J0ifI+cV3c3JabegO/vNmwXzQqEvCjFdn0iHTjk1e9FmuZbAH88JKGgkVb21GbWm3tF+iTOgb10sYh5jBtFF2A9LKys2iBNHGXFOnTpOUsK+l5EtUXGMicO9H+wLW4EXVu6FwNKfYkzrTclkUemSayhSSM83NrPuddmY5vuBv1ZmhsAJnogXQaHa4NbGK9Zhr9Lx7KjVrAPffYuAjGjGJVPUMnucw4PIKefNGZA56FkhwTj25JexByKxg8LBu/T57FZA1QR5kaJnsCc1ds7ncK96kGDeRhcI3LiPdCCPxI5QoqsepFqbgPmnlTVrqRblvsY5+OFg/teuQgElWvvr62hRd5Q2uht1915E6o7L9c+1NIX4jRMaqjQsfz/qkdmlxWZn1tmQPe58hk6mfIag+LdzA/SsEO6FQCg+6JFD9p8CIZRNh0WOa+MxIO+rgejmyowNe5EkeMy5Wu6qNDKEvN0MuDeM8X2P1XOkc19UWyTOIf5nZ4lEN/j8CE9BkN7ShCTkjH1joAUVfPzwYyNcJzCrf+M5DNb4ik39AHC0Ac7ew2pVicKM/wD1fyr1jflBAp8Ee5B2Utlf0Xb/eTp5dnnNgVa7wU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39840400004)(376002)(26005)(54906003)(31696002)(66556008)(66476007)(66946007)(36756003)(4744005)(186003)(4326008)(83380400001)(86362001)(478600001)(8676002)(2616005)(5660300002)(6486002)(16526019)(2906002)(8936002)(31686004)(16576012)(316002)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0FVcDViVVFhY2ZTWnJSN21vM1dRb1RHNW9VS2MwMkdPUUYxS1IyRTNLL0NL?=
 =?utf-8?B?QmVUdk1Jc3VIczNnOVc0cVhzUXlmVUpzdHY3ZEIrNE5EMTNsTGIrT1RheGVN?=
 =?utf-8?B?d1VUQjJRbjREU3BjMUxPeXcwWlZJcjBhWEJjdmpNQ0RMOVQ3QzZ0RmxhVnp3?=
 =?utf-8?B?eEFWUmxxZklEdzBqV0k1blhZbE9KS0ZrRDF2TktqZy9ZOHBweWJ2YjRVNGVY?=
 =?utf-8?B?empZcHVtV2Z2Q3ZYN1ZqaHQzVnAyYkRXTCtsZUdic0NrYjc1LzJuczlPUUxD?=
 =?utf-8?B?dG9LYlZXQUlTY3BkOVhMQ09mOE8rYTl4S1Rjd2d6QzM3ZXppS3RKZWMwYVFo?=
 =?utf-8?B?Qld6a1gvZWQyaWdTMHlCb1dhU2g4RmZhaVBudG9RZzhtcjF2VWJpcUhxbDN5?=
 =?utf-8?B?M3liS1JYb3BINmpGaE5zU055VkRBcWs5WHg5QXhDMURKeWZ1cndrRU9FWDRw?=
 =?utf-8?B?WlRVSlNOMVFSbW5LbzdoL1BsTnNoaGdOck05WTZ5aVdDUHFaN1ZydHNtQlZo?=
 =?utf-8?B?Y3ZBKzc3amcyeHBuZWJyTDF6bGhvQkNvSUNyb2llUUt4OFY2K0NHd3FpRlNw?=
 =?utf-8?B?N2ZJcGUwZDhtWThSMlU1ZW9SWjM1azA1dk1BRDU4U0pSc0dnY0Jwa2YrMTc4?=
 =?utf-8?B?ZU4vYVhQOUxCSEQvNlh2RnpsL3FocDJ2TmJiQlhrZWtVOUVkdndsVjd4L09X?=
 =?utf-8?B?TEJIVHdvSEhnREd4VGtsNFhXZGNrVVRWRnZGUm9QL0FuSytFY1E5YWlrak85?=
 =?utf-8?B?ak1aZ3BwSHhsWGdYTU11YnhXWll3bU8vRllqaFBxRzl2b3A5YlhyclljMUJH?=
 =?utf-8?B?bEFkMDNEQkVYVE1sZTBXVzQ4aFBBNlhUdDg0TDIxQndIZ3AwbUZKby84eDVT?=
 =?utf-8?B?dllnWS9rb1RURjZjUFJtTXBaTFdVVUZ1WEpXRmwwUk5xVk9TaXp4NEJ6a29U?=
 =?utf-8?B?ZWNSdjE4emhKNW01WWFsbkVjQloxcDBLOVBvWXZsdTAwZnlaQVdhb1FOcXky?=
 =?utf-8?B?NnN3K3d5K3U3cTBhNGQ1aGRLZkkwcVJ4d2UrV21YK3E1TkVRWmRGdFRPNzRO?=
 =?utf-8?B?YTBlQTZOL2dHQ1FVclhCbXRSOU0rcGFyZWRHdmUrMFdaRFRJbDdSdG5DQ3Iz?=
 =?utf-8?B?b3JFd1VCd3VzMmZvQkNMR0N0cXE4V25PNzFNSGJrY2VyQzQ2ZFM0N3cxbksr?=
 =?utf-8?B?dkkyNVV2ZkNiVkVYWnhnUmNURXJHZmQ2Z0JVbFJWU0NwQ3lBbHhsVW50TUI3?=
 =?utf-8?B?dTJvU2YzYk5vZDdlVGtqazdJOXp3S3pzQzZIeTZvOS85ZjFXVm5BWDMzVEht?=
 =?utf-8?B?aUs4d2Q0dmxaeHQ4Q3pxdUNzd1ovZVlEYWFqT0Uxb0pTZXFUSmNEa3k0UHE0?=
 =?utf-8?B?L0h5cTIvdVVSM0ViQVJHdE5ZYldrMDBkaEdQTlRoVFBTZ1czQTFiS2ZNYW5i?=
 =?utf-8?B?d2JpTnJtTnBnNC95N0huYnlGc3N4RE8yek5jMGg0K0xuN3UraTJQOTdWaFhL?=
 =?utf-8?B?a0l4YzBidzlhRVN5RVRPTnFSQmFOZmx1TzY3bkZjQnVHcGlTaVJPaWxzRGRo?=
 =?utf-8?B?Y1lQN2RlMTVRQURKZXZiTTlvT3hEVjlDRjhYbm1SNC92UTkxZ0tIcElCSDhB?=
 =?utf-8?B?UlByc2NrWFBDMDNuUTJuQlc2YjRIa2ZVWk9vRUF5UUVJcjR1REpFSk9Xb04w?=
 =?utf-8?B?NFpyQ1ZGOWE5c05QS1BjYTlxK0sxclBwRHpqeXl6eTJwcTlLK0NYSzE3cFlm?=
 =?utf-8?Q?7uSkr4s98Mr2f5UFWsw1uKUp64nn2bAXoVDpbUE?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf97c14f-3276-4124-25c7-08d8e2d2032f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:49.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJcBd532SwBQ/BQYMPtdZZpEBpniAhObyXJvN0+1onZxrVM210Ee+ZkCHaF2lD7d2hOppXt77YPvC2di4c3WOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5789
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 74733ec..a3b881b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1503,7 +1503,7 @@ void tty_save_termios(struct tty_struct *tty)
 	/* Stash the termios data */
 	tp = tty->driver->termios[idx];
 	if (tp == NULL) {
-		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
+		tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);
 		if (tp == NULL)
 			return;
 		tty->driver->termios[idx] = tp;
@@ -3128,7 +3128,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
 
-	tty = kzalloc(sizeof(*tty), GFP_KERNEL);
+	tty = kzalloc(sizeof(*tty), GFP_KERNEL_ACCOUNT);
 	if (!tty)
 		return NULL;
 
-- 
1.8.3.1

