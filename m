Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA563332036
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhCIIEs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:48 -0500
Received: from mail-eopbgr130091.outbound.protection.outlook.com ([40.107.13.91]:65506
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229607AbhCIIET (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOB/2mwndAlyH6KzB0QLhaMBSxgYmVbBC+IWnxLwGlG9yi4vnuUBtCjX32sAmXevrfP11WicnbPj8m2LiTiTuYLZ+KXwEJjtEJoFJOTyc0KS2QiWiDSKgGBoiU//Grp5JkJSTTZV+1rX6PHW/hqIEX7xa0cuWBO6PkrIZbzHCX3ro14O/fnK45zZky0vfS2lErjHwg6V+TbF2EFVt5SEUgLflEmutEsUW/Rlb+IA7nZEi/g20Opyplaf71cNIFzmXLMc+nwZZ0IpYhx+cq6bwnqclsj+vHdUTqObKRQ9WUj4giEZttJmU93J4pX7AWfcT0HX9a82bQYay4T+8zc9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYB3aQq5E5HSxpjVSG+RHcLXuDkNoT5fOy83l0MSG1Q=;
 b=BjhxwbXL5yuC9LIZ6WYapUN7J457+ySFg3q8PQXGYnXZBJ2ptm5geenr8Isqx2UMFHwylI83Fe8DlKbcXLjPcvr4BBbglIUnAppGVRKrh+0QzELKiOQzC71cQ4OykKxvqf0w56Dj7eKZtgs2rxe8O0oZpG81px64flsv0/to/BHYyJ8f8MHu9+nuqeG0MvGKazNlYQdgpD2X2rB5xLJoh07/261SVAT554zW7kDH4Ex2ut/7rwtbA72g9dTomjfjiVFRyTVKxYic5DA5+2dBOatYPbp0sFNcdCgIGGEFKHf3CGoUtuODf8cp6NK1kILcaZLlTG9vOtb1Bs+OiHbOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYB3aQq5E5HSxpjVSG+RHcLXuDkNoT5fOy83l0MSG1Q=;
 b=k9S/36PajArzsIo02GjKwQZKxmP52OEds/5ZnENgAWXME1kSyNJnxaYOf2qaR7QWMd5BWy0jViliduedeeS/Xup9xuUMzvTvcmSb/Mw/M7Ru/D17i5ozCl3O3bijo0+HFreYaY50VqkP5d3yo0IQLez651yR0KMVFOWHxMF51Yw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0802MB2511.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 08:04:16 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:16 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 4/9] memcg: accounting for fib_rules
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <b0147a6c-ccf3-a7c1-0336-63304b811962@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::17) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:208:3e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:04:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5daca13a-0ad6-4586-647f-08d8e2d1ef28
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2511:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB251181DBD609C350A94FE0F6AA929@VI1PR0802MB2511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQsP0HD960peReqG8hvynQS3s3uC4sDuEDRNHkrbrRdFoXu4j6gn/2SBkjb9XErO/FkejlgVtJH8Ev7zqKwv67xZ0DApiVmiVQB9AghCzqhUxsUQoArlf9e++i5aCpdTgtZvsjK2u6n+tqshlK2j6Wh08yQCd73w89wwYdIao5qCQmKbudyB9XYaEnTs2DTIWcnT05JUIYxSpJthyEw+Y7q1tUz+OANFZLQL3IIgr+uNMZwbCXLCUg5IhHIWQ0okdoMdYUEhPTvIQOpYeTf+ba3ZfKSdSnLxYNO/nqXFnYkgf6yHuMrSyDYQhW8tQtP7YDxrmrSGrxrn+XPNXVwU7JLX9g7tn/oZxsQhn19DinkHi+T/SHNFBhkkGVPp4DjaZ6hWomtPdbuF8SDkxo2mIe2gPo5IHgbCrYf4IL6FS3xPbzUuyEhhmDQPPssk4Tb0LgaSWNuSYoILD8XzzVqGSdHe7JMBZ+y5S+RTAr3OzCUBKnmAfFHbVdLLeg2JNhIP4fxd8xjkPMhWSXWpZ9cfOXJSfEZNGP5/G+8e0kZIYXe+9SGWKv3elHNT4RjB6Ayx/dOfqGf/GjzJc6lrDgxBpGNzfVmIWySNhPNQ11ZDZSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(16526019)(66556008)(86362001)(6486002)(2616005)(8936002)(66476007)(5660300002)(478600001)(956004)(4326008)(316002)(26005)(83380400001)(66946007)(4744005)(2906002)(31696002)(8676002)(186003)(31686004)(54906003)(16576012)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3NIcTZSRFJ4UklWcUdBVWs5a05HbmlKakd5ZjdKeXQ2cDdRTGxrUC9zVEdh?=
 =?utf-8?B?aDhrL2lVdHRPYzlib0hsdTdlMVV5d3B5YkI2dVA2S0VZMEU4cmUrQ3MrWGRK?=
 =?utf-8?B?dUJyV0ZxcXI4dGpyWmx3OUdCRnJCM2xRTC85bXU0R3IxMUFJRUJmRHpqQkxx?=
 =?utf-8?B?ZFpleUVMTVpvUFFGMXVQTjlDbWNNU3V6c1BiREpmRzRHQVVYMG9VT2JTTlNR?=
 =?utf-8?B?VFRXZWV4N1ZqeHE3MFdTZXRZTnd6M0UzNlkvOU82ZEsyeVFpWXFYRzlDQmdu?=
 =?utf-8?B?cjV3cXpueGpZbmFjU1hjZ29ZTVlNZHBsOGZXbFFIUTdpRGpXUkZaVnBsU01m?=
 =?utf-8?B?dytuMDkrelFNQW82eStkdVNxbVEyN1B6eWRHMW85Uklhb1YwZXdCWWp2SUtU?=
 =?utf-8?B?OEtCaW9tUHFWQnhSUGQrOG1kaUJNMW02YXhDQk1DODN2eUl2U0RzaG01VGM4?=
 =?utf-8?B?eVN2ZTdPL2l0SmY2dEhUQTBnNXRyQksrcUh6V0F1Rm1SUjJTb1NlTjdJMEha?=
 =?utf-8?B?T1FKSnJPT0hzcDRUWXdmRWdJU1VIYzdOdzVvUFkrRVlOUW9Nb25zYUhtN0Fo?=
 =?utf-8?B?RlRybHJoY2I4aE9JaGc4QUNxcVF4RWJZejgyNU94MzRNaGdrVDBoVFpMRVZx?=
 =?utf-8?B?bmdkYnhIN3lESWJWOFQrdU40UFg5TitTZ3pFQ2xqQlA0TVVqK1lOUnRJZjFw?=
 =?utf-8?B?ZlJFWHljNDBjN25ickowd0ZRY0IzRm0xTmswRy9PL01KSU02KzBxMEV6eHJJ?=
 =?utf-8?B?NTdtRTJIbkFTQlZSNXQyWEE5SGJhTVNYd0gzOFNSQnhEVUdJTGI5S3Nvbkxk?=
 =?utf-8?B?UjNzck9tVnNWTHhrZmVqQklNMkpGSHgwZkRxMEdGaTdEeGxRWHIvaGtoTWRB?=
 =?utf-8?B?SERxcktKVHdrYmlrRnpod1k0T1pZYnFkUUdjN1g5SGl5YklvZ3RZM0NDRFY1?=
 =?utf-8?B?WnpzWDVOeTQzU0xEcTU5Z3RDNWxoY0E2aE1OeUU2bktjNmRmeDFzTUZPMGhR?=
 =?utf-8?B?OVdDUWJqUzUxNkZjUVE3SUlxWWF6YVdYZWxBNEplZ3JicC9nd3Eyd1VuZmVM?=
 =?utf-8?B?djEzUnZtNHQ4WmdYaWlLdzdMUGU3dGNsdUMxUk4zMFFQNEUrQVUxcWhpSkdi?=
 =?utf-8?B?ZWFRdE5iaXZRemE3RkNTOWRiK1dlL29XQmluTi9ueW9wRVNnWFlFd1ZYQ1Bt?=
 =?utf-8?B?WWtYeUJoZFVxdkI4c3RlcTY4WDFLanhrUGs1M05QRUM2Z0lTSVcxQlZsMG1W?=
 =?utf-8?B?THpieVk5TnVyWXp4MXBZd0g5eUlDY2FhY21tYTM1ODI5Q2FvRHFYU0hnQ04z?=
 =?utf-8?B?dG9GWUJUbVJ1VjJLeGJnWUk2b0xlVU84Z09lTVBhOFdIQTRKOExuaHRuTUww?=
 =?utf-8?B?azhLd2M2bW5obHlyTUlHSSs0UXFPdTBiUU9OMjE4QUVkckFzUnJObWhTUnlE?=
 =?utf-8?B?ekhaNHVEazdiT0wremhrNWFvS3hON2UzTCtSdWNMSk5XZUxEWVVnQUFkdC9p?=
 =?utf-8?B?NEM3cnhCeHgzTTVsT2phcGhuME92SmRPM0Y0bXkwNVVnRWV4UEdmQ08zdHVW?=
 =?utf-8?B?ZmtFZ3FrUGtQZ3gxMXB3cjNPTWgwZUxJMk1uY2FCZC84MFU1akhvUmtNeW4w?=
 =?utf-8?B?VFpsZnBoQ1BZdVBMRVhNSDN1cVBiM3pJS3NPcDIvbHgybGJ1c21kdWJrQjBW?=
 =?utf-8?B?Vm5CeFVsMXR5S1RVRjE5Qng5RllMaHRaQXdUUGhwWitpblN3TUpjK2FhM2Fq?=
 =?utf-8?Q?Fa5ROCwi3G7CaVajbt532fXmhIH1DLzTool29yl?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daca13a-0ad6-4586-647f-08d8e2d1ef28
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:16.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ninxQwVCvzpSjxluAV+petqXUNI1tlV7mv7X2Xbm+qfXnByWUedmCCZIvS7YruvHx6YKjCBys9el78FHM14cjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2511
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
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

