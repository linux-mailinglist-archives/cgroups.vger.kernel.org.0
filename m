Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E077332035
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIIES (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:18 -0500
Received: from mail-eopbgr140093.outbound.protection.outlook.com ([40.107.14.93]:30179
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229599AbhCIIEI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVw8+SuGMOP0WcSfTcRwrae0LPyxq2R7Qm327Fy9cezf31xEBSagOT7J4RmeZG607a1P9Gj6x0Pv6GTQHDU6MlSEXDaVC/mLMwrXjAePXtB3qk81x6oKyllUTMBzuIxBDjChVuMHC5rwnV+j/wCTvrfhifHOFsmMc04sh6EgCm8Wli7kELWlnMhmYbLeUBx9qlHnqSuiHVdGnunZ1uru/RC6sG8Pa3kc1hC/hJZLq/AhHpTlqVUN+kn01lC8u9K7SipUFI3l2o/sL8ReQHrkiG/l4Hpv7e//f9GW8JmzXdjkc9KQvVgaVsbNY+yuLH3SdOYy33RI72oWnn+0sJ24CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ2iE90uFKsfL0YSrlpqtiN1MHH88JEy6xn+wb4EZUw=;
 b=C7W6VSsoMj1S0Vp7N2GNO4/tJaVhuY1H8GHHj8yaEM2qrtTpLrH7/8eVzlvsT4QcPjMiAtYgccVBGOto3Ya9Ftx5cUpNeL1XaRJhAlQYaTHKa5eKBoumFBeZZ5/wURrPz3KfTlIefbP0QBE8sKOa/APH6QejfwUg683VqO34cw6h5hZ8OOulT5jC/3JppDUn7biAQTRz+K0hyj8Bf73Zq5njv0xcE38PfFIPXR5HYOSSjPL1y5w2eUG20NplLi/fk+SVLpr9UzpghEVCrvehVmEQuS23dh64PShY8P8hq6I6j0u4yJU62f+zgx3ZT+PA8ycUT23/Gx8fdlBzSTwjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ2iE90uFKsfL0YSrlpqtiN1MHH88JEy6xn+wb4EZUw=;
 b=B4dDQJ6GD48Ju+gX+6I19PxEniXVL0kBNwZLBRj9NBBxtcxXCQu+3fWVyt2e6JvCHy+PJlsPhrnPw+bEOnVj3ofn5SFCSyMUowyzGuisPIOW2zxMDBNz6UBsSoGJO8oBOambjr2mLuvSYXS6knvEb/neyFXtsPzQDaYyWEp2fQs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0802MB2511.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 08:04:06 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:06 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 3/9] memcg: accounting for ip6_dst_cache
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <6a9a651a-b609-01fb-56c4-01e134c9d534@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:208:3e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:04:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a77bd19-8695-4034-8fe9-08d8e2d1e93f
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2511:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2511FA21E0229C2B30942BDBAA929@VI1PR0802MB2511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFj+eAGJgvuREaL0J4T9erxYiV1va5qs2bHJBe5j+90RotPHtcnt70LhJYbRdtckXmY+K/ZXrA3QMMTmEB/1mvFqwdH+3M8t55Q7wPBFQZL1EPYNPdUfCl9A0mmHznIEHb9yN39vjzJpytvge79Cd3oKs2uvsYWvcf3/copPwZ605GSzxBchQCR2NX6amOLGVXq7Y6OyMvPiuujVeolBS4v7YKiy5msmTgTNraDVTiwB06DAw6nUdDDZ5/1QlAn24ryclyKV4Uf9R8Na6bmRc1Hbs3Pf4QuEmMvxZ0qJzC1Sg5hZgXnubJpbF8cozIwyl167/JLcHQraf9LLryYNygAZNb/4UNN+VMlDKwiF36wm2BVIGl/WkYXDt+2MlddRbGX44Ei944pdHw4fpMtq7CjO0skqN/rQ5IL4wbe4uWsC8pAcy9v63UCXc0qxYEypX2mrB/YOVI+27C0QS1jbRBXbGlYt0OQNsNShr9lTPxQ5KFzkVKd5/MF+mI+m8GEfvOvSln0VE4FIndBk4KZqMnwEjqA8XRJwwhywzsQqJFESG7RwrqDD/hvmMZSpT7VBbALdfCgFOUsILI58xZ+P+uDaUdrpboOni8sgNh++7dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(16526019)(66556008)(86362001)(6486002)(2616005)(8936002)(66476007)(5660300002)(478600001)(956004)(4326008)(316002)(26005)(83380400001)(66946007)(4744005)(2906002)(31696002)(8676002)(186003)(31686004)(54906003)(16576012)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tk43OVoyM3lOSkpXTUtCTkErQ2VwTVNLY242YzBKYXp4YkRGTy9hZkFKNkpP?=
 =?utf-8?B?K2xYYnpFMnZteG5vUUJ3ek55L2kwOGZIS0dDOUN6QWFYU01QM0lTaWt3Z3BW?=
 =?utf-8?B?cWNaY2NmalJjRk1KQmVFWHloekg3VDVmbk9mcVZhcG5rV3dHVTc0VFBFZFgz?=
 =?utf-8?B?S05FNGhGQWJZdWxuWTUzUldwTFRIRldmeDRFdlNzNHFLRVluSWZpZFpyMHpS?=
 =?utf-8?B?dUl0cTRVSWh0WVBYaktEdU9kb0tacHVjN2cxaEs5RWE2RnlmMTJrZjYrOVBz?=
 =?utf-8?B?dlc0M2pxT0VVb3hKUFY5TGI2cUZMSEptMi9wSkpuOUlLcFB1N1doUWFlS1Ax?=
 =?utf-8?B?OWUwRmZxaWZWeWQ5Z0RvTEYyT3ZLY2liSDJ6VG5qL1ZCeTVDTEZRQkhkcVlz?=
 =?utf-8?B?Z1lqZ3EzUmVjaElZY201VDVMWFp2UWJsUHdIN0x1dzgrTUZYZnh1Y2xlNlF1?=
 =?utf-8?B?OWl4dFROOEUzakhMUlpkdml6dS9JcThTNjUvTVdnNlZSUVNrbFdCOVkxVTBl?=
 =?utf-8?B?M0c3MkI4QWFRdTEvUTEyYVp1cW9FZVNTMFNnSXRkNGxiR0liSGpsSTkzR3dq?=
 =?utf-8?B?VTBzREYvMzBzM2g4RDM0TXNvOUFtdlB3RTA0S1Nkd2JqSGszekRFbmcxN0Jo?=
 =?utf-8?B?NGhnZkM5VVF0ZUU4WFY1cjFEU3dGLzNzRG1FbkI3V1JNZE1IOUxaOFJQNjhZ?=
 =?utf-8?B?L09PNGlRQkpTb0ZtRlRMbE0zSWNoWkRwRmZlTVc0U09IVWZKZUZuVXBXY1k0?=
 =?utf-8?B?RVBWYkVWRUpLQUR3R3Rzc1RiNWloUkhoald0azljV2pzUjgvY0pjYnVJblZo?=
 =?utf-8?B?SHVNQlM2bFllVy9tZUlvaGhzUENSWmpnZHdmVVhGaUZlYzIvbU5KTEQxUmFI?=
 =?utf-8?B?Wm1MOWREMXMyUnJKdzVtOWwyalM4MWhMNUR4c0Vkckh1a1VUam80akwxVllP?=
 =?utf-8?B?TmlxVzl6YmxiRU9RSjg4b1pPQmJ5YWF0UVZyN0NUdXJaOVdSSnBYYlZ0bXBB?=
 =?utf-8?B?aEZEdm01WExzOWVVaTV4SE54Q05wTVlMendKbWpPd0R6aCtXNm5ha00zckw0?=
 =?utf-8?B?cUl3dUtVUEtuOW11VlQwaDJCZnRTVzNvVkxaSExmeXhDQ0JKNUVlYjdxc0lm?=
 =?utf-8?B?cEVzT0dBTUQxakNJS0RiaTBWSHIyS08ySHhGOUdTWE05azJOR0JlZkx5akRT?=
 =?utf-8?B?ZUtIZDBXNFZKWldkRFEvMFBHeFhVRE5Dc0pvZE9VWlZ3Vnpld0oxbExoTHlO?=
 =?utf-8?B?and5a09iaWU4QWpISWJsWGUwREhKVzc4S0ExNzIwTWR1YTMrcWhFc2dTZG54?=
 =?utf-8?B?TzRnS0R3UDJQV2h2V3ord2swQjhDZktuUUtPYlFCZFI4SFBKNys2T0JQc2F5?=
 =?utf-8?B?ODVKNU8rNU5kN3hSU09yN3YvRlFWVzYrcWJhNTk0NndtWTM4Q1NLRnJJaWpY?=
 =?utf-8?B?OTVFYmE4WjZzZkJhT3g5QjJteTJaOENrVTlLRGtMZ0gxU3lEeEM3MGFSQkF4?=
 =?utf-8?B?MTYrZ1VzeVZ5alJSWTdHT1RTNmxiUXN5K00xcEJlelpXd1lQdlAxYzNEUlh3?=
 =?utf-8?B?KzRBNi9wMWJLM3Q0eG9aZnREV2FnajVLRTEwM0ZDMEtieTBMZVFNRmltTnlx?=
 =?utf-8?B?bzZxcGQrNUhmaEFtSFgzdnhXTUpCbEdZczkxT1J6OFV1bUJGSzE1U21UUWhQ?=
 =?utf-8?B?S3Exd2J4L1ArVkt5TUdsU3YzdXcrazNpU2tid3IvS0YvUHc5SFMzWkMyN0hQ?=
 =?utf-8?Q?NsZcDYrYufMqlJN1TbHDpGxMzXkA7JVAcRV0GYK?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a77bd19-8695-4034-8fe9-08d8e2d1e93f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:06.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkKQB4HX8Wpda18qt6yuB+VIZWdSBgC+ZneYqPTLUwkwkNSnE4vVfsjB2z5MH1HbaxVOy/wv2azs3oxJRF7pJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2511
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
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

