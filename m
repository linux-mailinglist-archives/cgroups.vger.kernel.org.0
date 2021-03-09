Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14238332037
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCIIEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:04:49 -0500
Received: from mail-eopbgr10116.outbound.protection.outlook.com ([40.107.1.116]:12928
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbhCIIEf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:04:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfMDCP2bd3MCDIQ8Yez5702uqV2KtOfifqeC8sDxboYg7dZCc8efCqoe0KkVyP+MoTKrJC9Rw2331YMDZFrtG6fpgUY6crEwNcgaQZ+uj76H6rOatBeyXpTp9Am8lU6dI5T5PZu+GP0Nz3/L5W1ME0HFF96xpBQLZhYhYzr07go92vouzqq9zpriLPCDzrtoImUeR4FReJ8xE0sc8Yrwe0vb67B9W5Lzw8F6qHwFLZBv+BcLswK9LmLDlmM8JO58K6TjuA3utPbCH6JPj16VKIK6/f7lts0bdV5CvgKSNZg2//qAdsjbeGqIOCfE9vNxV8g76peYc49O/dW5U4BiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAPlJ23nmyUC/3g97olMrSpPlXIx1ZJBbDYNe6ym1cE=;
 b=U6wW1jDr5NEsvSqw66PNgou18+eDyMDCHQHTGPcoeKHVaMAQFXkA1NGQfVxtK887v+wDBLTiAjahy39Bgfj10aFHSZeKn/9BJSY+UwqXUhI6cWnpVU88Vwu/04pWK3uE0ZZh6bizyhzAuj7vBa2TOcua4DGJj0TeWScv/236v8UKRWEneRrQjhw5hDTXSriJYioVFRYO1ejMIQIccArkfrglliF3QYDk019QjHRRBbbHzBDwjDuZhZu6OhJjZK85Q9uB27NAJjOa8NC6+XoCVbAoRYpwk+T6tFYcCdFmheHSS4SWJn17FD60RQMjhkN0BUEP4bj1TukoCVMGD1ZVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAPlJ23nmyUC/3g97olMrSpPlXIx1ZJBbDYNe6ym1cE=;
 b=j8VAwy80Uqb5L95Fd9+7SCOODVdHayijarY5FJ8bJaKZTc7LyWwpn2kJAI/ZCjdCsNGK96zTzTqqb29v2NvOrOOijhnPqL2sugNzAvHjVNt6RZAuaklMnRx46/38BxiZ1BT+L7Ies70fNSuGagZlJLmtQETW3HC7/IQfLeNIV6A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5789.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 08:04:32 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:32 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 6/9] memcg: accounting for fasync_cache
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <b9d9c222-558d-a3c8-eed3-ad174bc0c32f@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::43) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:208:3e::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 08:04:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e8bace2-bed3-4092-de69-08d8e2d1f866
X-MS-TrafficTypeDiagnostic: VE1PR08MB5789:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5789C5118B6BEB33418B5481AA929@VE1PR08MB5789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muijSe248Fa9Yt/qA0Vz8U9HmXerToIGe+MXdNSK0u+iqs0WphLaPd6vfpC65+bEaH2NADSjjB0VMHthJ7VN3LQnpRxlkK6tDzWi5lsRohm4k89OaJkfK35Qn8nBzleEr8FVYKBzmLSZAdLzdAa5OBFZDX83dxgLwDhONFkGVZAlgZXFyanKvLoqBjlZ/xyT0D4VHX+P+gIXZX8uurqsGpTGiIYV8R9jTKOucylBxX2/pq2zXbUBspUF8HtGKifPWSAVBcEVSSiGyWQQ/lb7mCNlOz30G5QM9KzXjuQ8Uu7wVLa8EpXb9vyJ08ao1pchLO/mjSzSrkJITNVJsw47vZalT+3G2F8LmQibQrM1S1FPcQKSMNv0xW+Zyy4woYGXjXLDCqNZRcCLUwGRqmsE1ii+kXLAIudIhlRTabYVOwDufnSXPnJa3h9NPG6AROtzAvpjSRHml2DuYxwRe0rAmJ4Mu66zfnFGkW5SPY/7S5WHqTI4dDdFM7CXXz0EbU/xWbUkOzEzgNmhR0eeYU2Ue9hx5bIw9hNIPVAkYAWnBOe2fYuxwtRm8M9Qtxo0FTrTJAmsp73jscyY7L2XJ4LvOnyri9kPuFqbQtawHXClVmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39840400004)(376002)(26005)(54906003)(31696002)(66556008)(66476007)(66946007)(36756003)(4744005)(186003)(4326008)(83380400001)(86362001)(478600001)(8676002)(2616005)(5660300002)(6486002)(16526019)(2906002)(8936002)(31686004)(16576012)(316002)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmZ4UktoamVCeGROSk5oVGhjTnNtQ3hpQmlhOW91WFJyQ2d5QTdWbmxoT2VQ?=
 =?utf-8?B?QnJkUkxhRVMyZDYwdnVZY1BDeUo5SU93S05nNE4xU0VFeTRaR2ZvblFRQkhQ?=
 =?utf-8?B?dVI4TU9UQVB2RllaNjJuVzFYSEJNWWFLVVNNbTZUZkhxcjRGVzlCM2tacVl4?=
 =?utf-8?B?dlYydkg4RmNjQi81RUpsSytJbDQ2ajlaWUNpNG1WdWFmcC9kMnlWOWwrdkw4?=
 =?utf-8?B?V1RJNzh0WEhLRXNnN3doWGE0Q0RqRVJhTnJNNGthZldWOTJwWXZ2S2o3dVhj?=
 =?utf-8?B?SmVBakF0UWlYSVpMWFI5WVNUTEtCZkNiODZ1QnVYSmZFQ1V0Uzk4QUFxdUg5?=
 =?utf-8?B?a2ZIb095Tmg4UGtTTW9RaXlVOEdtb1htQU1tNnFBSSsyVi9jcWdOZEN3QkJE?=
 =?utf-8?B?ZEJYZG1oT2oxVFZvaFZIdFhSOTViSERlWEp4aGxVc3drcFZQb3dtc1Znc0JB?=
 =?utf-8?B?QzVWQVd5VG1UbUlvUU5FOWdaQW9GbTZIUkpneWc1QzdDWUMxMkF1OXFpRmxK?=
 =?utf-8?B?Q0FSM0NzeTZGSHBXaVdFemk1TWFMQ1pIN09hTnF3WGRTeU1UMmhZUklselVT?=
 =?utf-8?B?RTlhYk92RzlPSWVDRy8wWFdGSEh0Mk82MHhQdU9DYjkybVVHbHduZmx1MVR0?=
 =?utf-8?B?cGlkSVdEb3BMb3l1dndtRzFVWlQzSmg5N3Z4cFA4b1RaVGR4ZC9YUE8zcFdX?=
 =?utf-8?B?VTFoVHVCaFBPb1Z4TTY2VEViT1lOWUtiWFg5NHZJSmFRck1JYzhDTTFLZEh2?=
 =?utf-8?B?VWxSQzJISzZGcmp6dGlaOHFkMDVVQnFvclEwMTFiN05yRlFmN0JNVGtxQ0U4?=
 =?utf-8?B?Z3pGTEp1VVJrd0JYampYay9GV3FVN1IxWFNHYTRESHlsT1ArT0NiRXVmYWtK?=
 =?utf-8?B?eWE4K01qVFQwZWY2YlRPczJ0RW45dG1yZzU5YlRURnRDUzJsY1A4THMrV0pi?=
 =?utf-8?B?RDZSVS85anFjUWxMWjhOZG81NHg0S3ErK2V2UnE0RUR4NmorZTk0TVpTVDhS?=
 =?utf-8?B?dHBVaWdRT0VtdThRQXV3SE41djZPTDRaMkovR2N4NlFhNnMzVXRTTzJBd0xG?=
 =?utf-8?B?M245TXBqb29JOWFPVmVCcDFlRUpqaDl5Q3JBSmpVT3ZXeEFPMzlhdWErOUov?=
 =?utf-8?B?SUswOXRRcmVoQUh3aURHOGFCSFpjUUllQllBVzRlNlhIeUVkbXlVcVgyQW9n?=
 =?utf-8?B?SHFGcHhUZzdkK1BWeDcvVmZ1NjNjRnBKZVh0STl6WFRVZjZYbmxLNGpYRXpU?=
 =?utf-8?B?NTFIN1ljaGI3bXkrOGhCVmQ5SWVseEpjK0tnallQQjdRWEljYkJyM3R0NFJ4?=
 =?utf-8?B?aVh5TnBhL09UR1pjZ0twNGxjRVBueTl6OG5qZ2VjdXBYc3Y0S2ZDT2htYXY3?=
 =?utf-8?B?bmQzYyt2aHFFT05tS1BoSm40QkEyWUh2YlZoYTBzcncyQlNlbEpwVGswZGlU?=
 =?utf-8?B?YjFHbXFVSmxXUnpTenYrV1lOeHRUejJlYThmTnVMMTViemNFelB3NnZUR0lT?=
 =?utf-8?B?RzQ3YnU1RVhiWTBoRnhZR1VRbDdROWpIRjdjS1Jzd0JqbG9GVWFkdXNiRDJK?=
 =?utf-8?B?Z2lGbENOcGV6eTBEUmdmNGgzU0RSY0VuaW1RV2hwTzVJRzQrbU5tUWtidlpB?=
 =?utf-8?B?UmhuZ0NoOUlMNitXcEpxSDB1SDdsNUhlSzQ5ODh3cGlDckx6elRGSDZKWFE1?=
 =?utf-8?B?aWpObG9FbklOTWw3SzAvRWNxK3I1QkNocUtzL1dSb3NwelBVYXNPQ0gwTjJi?=
 =?utf-8?Q?k1E73bj8TG04vX0vOqSo6GgGLbraZMlHmPhUIU0?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8bace2-bed3-4092-de69-08d8e2d1f866
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:31.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkDc5DsoLp9Qe+CWuIGIT9NofGE5j+0P4jaN0AwpJZWpSihFGljlrQZpvpYqoulob5zN25cVrs+RnOGcf0ny7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5789
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fcntl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index dfc72f1..7941559 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1049,7 +1049,8 @@ static int __init fcntl_init(void)
 			__FMODE_EXEC | __FMODE_NONOTIFY));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
-		sizeof(struct fasync_struct), 0, SLAB_PANIC, NULL);
+					 sizeof(struct fasync_struct), 0,
+					 SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	return 0;
 }
 
-- 
1.8.3.1

