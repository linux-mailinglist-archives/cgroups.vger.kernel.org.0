Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCB332034
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCIIEQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:16 -0500
Received: from mail-eopbgr130137.outbound.protection.outlook.com ([40.107.13.137]:46136
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229900AbhCIIDx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:03:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS1uw8sBdvqHppO3a8O/2popHhBiOIcrPCd/2xh91elFqkAy7dtDKGR7fNXdA1LhJEsTjuM3P9ro16XD2/9i4XzISnr45b1gclE3lYsA9F9FAZY8S6BzTwkTvDnJ+qdUyKjOEQzYQIX8GezdRctenI9jv4sSml/iMN9i9yE75pAehYhsQwb+VvMm9ViIOKXABqoHfbQCf5qFP0xp4dc8RJV6TTDL7xsVOEB+JTScd9aVGe+7/NgrIoHbWxV87b1ADAXa5hqBC4yXg23VYww6JiObeP9djdZX+Q+6kF02azFFkXL8OM6l9ppJ5F7I/BufaCnjHPGiRH38f6I28hLZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5o8mkc1Zj8mwSqxNhwynoe0HUtQdQ5ByM2Mvj+TwRE=;
 b=RTtWSzCa0OPCPXil+Znl4aUP3rs6hXYE4Za8r9EKlF/VG29q9FMyV6JH+UMsEKW63wKoZ5+bpCVN8d5KcENYLaL2NIEqLDAB/mHoxrQnzsBsF0YiVkrj8swK9cXTLifOlIvg7CpE6eEsrPETP5H5pTVvbOy68OMbitXXMheyymPUNa0Agss4zQtKSPi+/Vdu6IgymXC7ycd3RIHKaLfrHcXzXTGuSXULuZ3y2hE+YpcxnH13X24NupM8Gxzo8szVa8muyh4SL3A9q7wSLMw77Q1IA32SORbI7QoZpxH5gu4+nKOqrmHy74/6g5ViRGNWXseOj03l5e0yv8iN7LZYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5o8mkc1Zj8mwSqxNhwynoe0HUtQdQ5ByM2Mvj+TwRE=;
 b=DkMpIobrjefjSXZtSghiTKUWp4uff6vm9fpRtU1WBWcV1PYzM+ewJM1bLR3an8Bq2tdAd6P0h4wLKoIvzr3EYp2erx8PYrHBLGK802XcrZ3TyukFkBavAB8AhbZOTsAmil+ZhSLg58hC7gnvPvpY0Csrusg+Ao6IYplNsdq0ikE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR0802MB2511.eurprd08.prod.outlook.com
 (2603:10a6:800:b1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 08:03:51 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:03:51 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/9] memcg: accounting for allocations called with disabled BH
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:03:48 +0300
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
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0013.eurprd02.prod.outlook.com (2603:10a6:208:3e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 08:03:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c8acce-eec0-476b-aa27-08d8e2d1dff3
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2511:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB251126075044659AF42E5141AA929@VI1PR0802MB2511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKQ6Ut/YpwJBbutVJs3eyP4VSYIBHGj05XeqlVAmkXhT5pzweQ1JeaUsEmrFCUngYeHDYhUZOCqm+iSyApwG1hZaRondVbjD4x2V9irNOuWvtqecAbQwqBP47nU0mih9hIURrXqzGtGNdc1o9cd6k99yei5gwKDksloLaJXzNpUVj9Wngoou5k33dU6IHsc9V49y3pbQ/stOYo4GUEctKeE14pF8ktCTFvqD8Aq+ZscgtmCOQ2wmwDKZbb0cTSGQ4MfBUoOrenN7rWXgI9MgehBvDptgG8UFwTsWfVSQGLEM17It3xTAX6jtgwmuZH3e3hlKxuWrFCyVqUWiH7qF6+tboQ/hxcFd/21zE7SPh33/XzDr4n9cRx+C8MRZGxeIx+FEH3QE/sTvq2L7gUy7wVreFBRHbjPTdOCduIuiSmVrqCnz1v9qE2kQqYYuYI4RhKUPCiJdn91UzcV9Pei1HdjTmlg4fYoTLcGLw9MgEKIA2wlJmZRQXpc+hTltOrMnHwiBEPgR6Uiahw4AJPLasM187otYsNRBjCswf4Ez1z35C0rgWWm4T3A2lNTVgG/Efey66XpPrpBjuFlZUHIgxXFHMkGknOop+3A8j/D4Lfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(16526019)(66556008)(15650500001)(86362001)(6486002)(2616005)(8936002)(66476007)(5660300002)(478600001)(956004)(4326008)(316002)(26005)(83380400001)(66946007)(4744005)(2906002)(31696002)(8676002)(186003)(31686004)(54906003)(16576012)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cTViSGJrMFhxNCtQeGQvcHU4YWVkWHlQMlNPdE50NUx5REF6ZEprb2E5eXQ2?=
 =?utf-8?B?L1RSQ2FMYkc0Y2QyVmhSdzBMc2FuT3ZwQ3E5Q011REpvN3FtVHpLWnJhbGti?=
 =?utf-8?B?L0wzbW0vc3oycmhGeCtCY3RGSklaZm9xVk5rcnVNMVZJSktBb3lzLytpL25w?=
 =?utf-8?B?RW5rbnNZcWFWY3JxL0txNG5TMW8vdEMyNzk2QkczTzNzL0Jyem9SSEtRU1pr?=
 =?utf-8?B?dWZycitpRUR4OVBUVHUyY2d3TENPQzRNMmdTVWVMWnkrWUxyekFhTVdPb0h2?=
 =?utf-8?B?SHhlS1FydHF4RUNJWWhaWXNvZmhTVHZxOG1mV3lDT2ZROG5BNzF4SHJMNTkv?=
 =?utf-8?B?VHhSeXNSNXNPaDBpQjhSTXRlK2FzU01sdHB5MGdhQlY1eWlyV0EycFYvRGor?=
 =?utf-8?B?MUZpV054UEhTdGIzem1ZQjhVaFNRbjVoVEhmVmFnUm5ianFzNC85Y21ZVklm?=
 =?utf-8?B?YzlrRzRSU0RyUDRETW1ZcGU0ckNRZ054MkFEWDhXTS91V1NMeDczdkVGZGh1?=
 =?utf-8?B?Wm0zTzJXd2F3bk1BYVpYYTczWUpXNDB5c0NYQitBdXpFUitNWW5ic1dacFJq?=
 =?utf-8?B?SXdEYVcvY3lrSG1ZU3NIWkhDaUF1bGY4NU14aks4ZnBJMkhaU0dVdnkvdTBr?=
 =?utf-8?B?Zjh2VW5HSjJrK1R1dFR5alVpcjFLV0pSUGN5cmUrNSszcG1JZTd0a01HeDRU?=
 =?utf-8?B?eFJKdGJ5dUNNNnBSYzlCeXQ3NzM1Q0VpWlNZV0MySE1zaEJqb2YzdkNUV0hJ?=
 =?utf-8?B?RVZhVFVvUXVvTW1qYS9zRU1jeFhLT0t5RG1xcU8rZ1ZYMWh1RXlPb1NjelFF?=
 =?utf-8?B?OWhBd2k4c24zRnNxN05JcEVUT09OZEU5UXhxQnEvZWV3UVRHYVBVTlhrc3V6?=
 =?utf-8?B?ZjBuRWlaR1ZiZFN4dlRpUDV6MEZVTjZSZUJOWU4wcS9PUjVFTFJ1RWtTbWpm?=
 =?utf-8?B?Yi83SUkxMzNNMjJKYTBJSFk4SkxFc1JFT01SMzJVUWNCTnJNcXBZdjNFRTQv?=
 =?utf-8?B?MG1vZzJ4eDlVRklnNGZLUENyZEZHdmMwNWtjZHIvU2RvOHZEQ01rdzIzMHky?=
 =?utf-8?B?MWFBOFVLbE5vMTVISWk3aWw5WWdQa0w3NTFMYnNuTkdvamZFKzdWVC9lWmV4?=
 =?utf-8?B?MVAxZUdpMjJRWG4rcUxsLzczWEFjV0xHMXBSbzE0dGxTTFV3RGVGUmtuaW1S?=
 =?utf-8?B?N28rWG1QOEhCNGUzT2JZYzBuWDByR1A3SmFCLzNpanJTMS9NZEgrM09BbHg3?=
 =?utf-8?B?dDZVZTBTMWVpbmY5Q3c0WFVtZ0NZZWRTNkFaSEdyNnp3QXoxZlVqUFVOZTY5?=
 =?utf-8?B?SXQzYlpQSVZKU2JUb1o3ZGlqM3lIUmg1ekUvb0NGS21BK2RFYXVCbVZVRU1h?=
 =?utf-8?B?VnNNUmJhVElvZVpyazQvbkcrTld5Yk5SRzBPU3JjcnpZalJxZS9VbUVqWGpx?=
 =?utf-8?B?UHB5NHZHdjVIeklHRnQzM3poMzJ6ZVFtSTFHVVJXaXA0cmtDcUkyQXkwQVFM?=
 =?utf-8?B?NWhwdmgrUVFKeWN3RUdndXhGblljYm14cXZFSWlmdmpRSXdLbnJLb2R5SUk1?=
 =?utf-8?B?UkJVWjJxMTZXbkNTamZ6MHBOTmV4S21xaHR5dUFBTzhLT3FJM1VoeEp0Q3RY?=
 =?utf-8?B?L2t0eC9SaDllR2Z1S2N6YlByN201ZGtMVVp2cFVNTGpKTXYxWktvRWNLVkpa?=
 =?utf-8?B?L1ltdEQxckZscDliWnRrN3V6bEhTQnp3SjFMUXA2ZW1rSnVGdXl4bmg0ZWNn?=
 =?utf-8?Q?/Ys2aDjjhGqgEjveZryEge8lcVxnGvqiyyalXZC?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c8acce-eec0-476b-aa27-08d8e2d1dff3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:03:50.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp0i88TSW7l96J/t9JQRTUWcJc54gBAh3PbRCAYgBaLo+otAMc8AmOMoeGzhVKMnnE6JP8RADvCzwyYdbNSxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2511
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

in_interrupt() check in memcg_kmem_bypass() is incorrect because
it does not allow to account memory allocation called from task context
with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 845eec0..568f2cb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
 		return false;
 
 	/* Memcg to charge can't be determined. */
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
 		return true;
 
 	return false;
-- 
1.8.3.1

