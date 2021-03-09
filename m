Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9B332038
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhCIIEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:49 -0500
Received: from mail-eopbgr10098.outbound.protection.outlook.com ([40.107.1.98]:32821
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229851AbhCIIEm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j30trE3Gx3jX4N+6Fsir22+p7RUNllwpJeLjOu60oSpYLFW0/oiRvJgCjLB1BxJL/h5nDOWCtKwG52Sb2VwucScsIdQJLmqDjIwxfMxM8W3pNzWTFhJ+rMOKDA57L4eMRxZt1ENpOW015Fa9gzOEINF6eLc1jdZsLWGj8nX7CX0ieeyRh6LEo9JSW0tGW1hdr3g8IRrAjD2ItpTDdrP37+8feztq+xp4an8kvu6ig7O1GgfHJQoNLsYBgBFBv/QAt60vihjARvx/0Uv2rArKfNhrDrfZBXJMnJYUHwCMcs3IRWLp/M1z6n818IQDJYAGkBD2vs3/SFP2B58xpdSRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAP5eGj196itQT+6h6oG7CKJMncsxWZSup9LhBVScPQ=;
 b=BaDsCd2lhEh5e73r4JAZB1CzghXh6ZoB/ibYjOsbo/inegg7Q4YQeH5CsKRN7IfvXC0tRtn1xLxs5/pUoSOhclblPVtsYReJTvmHzJ4kXqwdQtIWZdu4Gs63gG8Y6pdyKDKUEnj3mM57iZF8cdHVCmZG3c68cVqKDkpuvTl5qBrTIYreTyQDcYyVyHbaymP+RjJx5YHshJqz8C73tJgmOJIU8WRNZaaATwBI8SlyDcZwPpo3YcPLghGS+pmDe/9jL3bYk5UoqYU+QmCV7Doq3RIOw/C8LkhwiK5m7ltOK7xxKPQODLLNYkPodd4jo5shHKV5EpNEAKHZGeCFgECZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAP5eGj196itQT+6h6oG7CKJMncsxWZSup9LhBVScPQ=;
 b=iKSI0MPDk7yTjfzZlHbD2wKDxRX+/WxqCg+TBlcnl40IsfcyXCNAdgVqzBQXL90OSKszyft7y1DJP5eNn3qwmpl0tpaBzlv7HjLayIt3zNLu4OVP9O3GUk68eQMNbjIRYFkcVHwY/LkwUR0mM5jtwvAzYW7p/mop1M9DdaEeFTw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5789.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 08:04:41 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:41 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 7/9] memcg: accounting for mnt_cache entries
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <a8495a6e-3f9a-c4ac-8692-97a4479e2faa@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::26) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0013.eurprd02.prod.outlook.com (2603:10a6:208:3e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 08:04:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7fd6177-658f-4782-c37f-08d8e2d1fdf8
X-MS-TrafficTypeDiagnostic: VE1PR08MB5789:
X-Microsoft-Antispam-PRVS: <VE1PR08MB57893CBD0197EF86A03CD7FAAA929@VE1PR08MB5789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5F8og98Vu33Wgc4OvuV3SoRrFEUNmhfyBDxKzos/xgVBcyx43TWkGyua4yC6gaxd+faSxu8qKF7ToTN+WnlK7P1ggKoRUPElg2VtomxJrwlZOp9BMHf/ApwXK3s4FK2q6QLwP6rojFfVYFS/TdjS9sSSbjQ+zhzxiVi74UdWNspOos6Bjh1ns3G9lZDLWz45r60ZT0rYDL39hXJMCgJJTYf9oo9R6JUIYXcZcgFzb02a58j+gqZfYXiIA5FYZ1SAUdYMxO1L0EB5G5AuEM4rs5hEbuE17wZu59Uc3rv21eGNbCyAp2x+hK/C4rN7ZUrX4ZP3d/Gb7UJoDr4hlz4xcXXt7KVfTqO+FazXqLwmfmNVz66HUXfXVvy2aDu3Rz9QpWEdUezzSUHPmn3SAGd/lhRGhmglvQusNmfWRllmKq3KrY/PoRDnV/xOVO6hGr+juIXAUdNtyKpVrDHEcZz/vFCXiH+L8Ko0M4B3H1aKA/3nhSpGo1ACPPyzKYx1ErjMO6D2s6RQlBqp8RVFBY00YAocwmmbZfwHAWl8izaPRElpSSmgpABKR9n04oiz22bHdKOzpcUZj3spc+aLMFoHUapm/RFs48tyKm7KvbkaWI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39840400004)(376002)(26005)(54906003)(31696002)(66556008)(66476007)(66946007)(36756003)(4744005)(186003)(4326008)(83380400001)(86362001)(478600001)(8676002)(2616005)(5660300002)(6486002)(16526019)(2906002)(8936002)(31686004)(16576012)(316002)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V0o3dVdsZUtJZnhVWkpXWENUQlMrVXFYOHhJZCswWCt1WUQ0T2QvcUNvMGRL?=
 =?utf-8?B?a1dHQW5DZ1h6ZktmZ2dnaDc5NkFpSGxDU29lYmxJWThHVnRQRXI2WTBPUEJj?=
 =?utf-8?B?c3pWck5KSUJZbElZUTJsZzlGUUVLMk5lY29lV0I3ZkxFMHdiT2ZPSHljUXZu?=
 =?utf-8?B?VDdINWRpT0RJN283UW5qRW9hOVBPbC9FUG1WRlQwN2x2NDJVRktHaTBiMndJ?=
 =?utf-8?B?b2VUNnBjZWlOYzZRUG9tc3lRNENqVmZ6MTVnZVBZK2xFOElkMWJuZ2xIS0x3?=
 =?utf-8?B?eCtOSHcwbzhRR0l0enhzL2UwUFk5L09INXNoWkgxSmkxQkZ6c0gyclJSendW?=
 =?utf-8?B?WDRpbHBzRXFTWVVsdnNwUGgxTmE2QWlxUGh4dzJLTUJUVzUzZmwwdnBpSnVQ?=
 =?utf-8?B?ZUFXNFBRSjVtdlc3dTJ1cDI5dlhJdkJnMGdZLzgrR2dNaER3ZzBRcTk3dElj?=
 =?utf-8?B?ckhNZ2V5akdGWnl6NDNoUUwrNTh2Y0FxVTZxZGVCOGRpemNsT0V2Z0RNc1F1?=
 =?utf-8?B?clJ1MFlRdi8vakE3cUQrdlMrbWkwV3gzdHpwbEU0Z251dmdwRXFhUzBXS3FW?=
 =?utf-8?B?cmloVDdmcWF6U0ZXbzJwZFJ4aU9LZEVKMjcvalZmM0Z3SkcrbDY0eUpYc1ds?=
 =?utf-8?B?NGl3cTliaGd1WSszUVh1cjdSWm5QTjhxVGx4NWM5TmVuT0pYaGFTcW9Cbi9j?=
 =?utf-8?B?Si9CTFVGNWV0SDFWUTYxaWRVN01hbXpQcXFZeGRUV3M3eHRneU1ONzVNMFhE?=
 =?utf-8?B?UE45OVpadVNSWGhDYnpQQ3I5QklqYVF5dlQ5SnF3akUvUjFTWTdMYzFjVFN6?=
 =?utf-8?B?RENuN2p0TGt2cldyYllzSmJPRzU3aVZZMnlRNENrd0FOYjVocGo0c0lYaDVz?=
 =?utf-8?B?dU9ZS3lIcUdnQnFGSGtJZ3FJWVZTTXNJOFNDQWpTS2dORXY0RGNyYU9jZ0Vi?=
 =?utf-8?B?NFpqd0YvbU15djNOWVJTaTh6UVNGamxYd1JuOWlYM0UwdHJxREd6Z1F1QTJz?=
 =?utf-8?B?aHlJdGZHSzZ6TjlvUnRPNzVoemRybGtFa2V6VkZqeFl3S0owYjUwbk9iSVJW?=
 =?utf-8?B?Skl6TXdkakR1c3ZxK1JMdnpJck0ralhab1lneERCZWdXcFdJN2N5c05UOFp3?=
 =?utf-8?B?NGdicERyWTJKMnBRMzdEem5HMEFHQVhPOXpYSUdvQ3FKR2RGVjFxRjV0Mkpo?=
 =?utf-8?B?VGlPQzRLQ3p4Z3NXUjVVMmdPYm8raU9lZi9LSXRGcUhrZ3NrMmllTUIwT3B2?=
 =?utf-8?B?OXJseGpLRFRQSmRNb3RKSWhQSkZDQU1Ma1hPOHk2cXlLbkk3aDlXWmxHelZJ?=
 =?utf-8?B?czZLNEQwZkEvOEZEVWVyYThHL0Z3VHQzQjRNUzJwYnJYZXBmQWNlZ2gyS3hO?=
 =?utf-8?B?ZmNRUm5mTHRGN1BaZTZySDhKV2lPVU5hWmx0aFpGYnZyWGhoV1R1WXczYVBq?=
 =?utf-8?B?b0tmdEk1MVRtaTRvL0RTNmUwek84OUdzemcrRWQ3YzN0ZmZmNFMxTWNid21z?=
 =?utf-8?B?QXFmbFVvNlJheDV2KzRTMzhvL1ZvQW42V1gyZzJFM2RORmtkYng5MnVESHlH?=
 =?utf-8?B?OFl5bCtCdi81UjRZT2R0N1BWa1lIT0VwUmJFZkx4K05MTHcvTmpTNnNwUGRm?=
 =?utf-8?B?R2FvNldLZ3FxbmxmSWZJR3A3RTRjTVVCVUk1Ry9NRnQrdndvTlNiWVBhYW13?=
 =?utf-8?B?SEwwL1JOYjFuK3RvM2JWZWR4cDVkbzRGMlRSVmpRdHViVTVIeDBURW1TWGdP?=
 =?utf-8?Q?xswEKyaBrXBsZhy5W2q4AbdVr97eayphqSkMvPc?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fd6177-658f-4782-c37f-08d8e2d1fdf8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:41.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4PW4pEP5EDmOrTOG+uC+r1kYKoXkHO18awIoXGFiQGb/epDScnWut1vR4kOcnRqrbY32qVKM2bwH6/qeRXrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5789
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 56bb5a5..d550c2a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -203,7 +203,8 @@ static struct mount *alloc_vfsmnt(const char *name)
 			goto out_free_cache;
 
 		if (name) {
-			mnt->mnt_devname = kstrdup_const(name, GFP_KERNEL);
+			mnt->mnt_devname = kstrdup_const(name,
+							 GFP_KERNEL_ACCOUNT);
 			if (!mnt->mnt_devname)
 				goto out_free_id;
 		}
@@ -4213,7 +4214,7 @@ void __init mnt_init(void)
 	int err;
 
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
-			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
 	mount_hashtable = alloc_large_system_hash("Mount-cache",
 				sizeof(struct hlist_head),
-- 
1.8.3.1

