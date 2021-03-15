Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B633B27F
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhCOMXn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:23:43 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com ([40.107.21.100]:27617
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230186AbhCOMXi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW8nvVuJKvdKnkjwjWcgFSdV/eejPfFnyQV0sAU+/vYU6j5FbhEzWHP48+7LgBBMLrJSrhc5UAQtTVNOy12nutERpdkByRz37yt7gTWDIXnkdQNuUBmHTNCTwKm+9u871MYxKa/1jXhUIHy+5x00Eix4uhpCAofreN5HLhF3qZoSiSlS434euRHX6qrx1nBCtYw48Sb9zRyZBg8PonzrzBYUcaBE8IrIBnb17wvYJ67sjKssmfxf4UQ5LzvF7xCfR26AwisCe4VLOZXE3I+YCkXVdvsTAiO4E2SctLN9A2M8ygFtik2bDC4AP2Wc08roiMkCw5LuuENyne8j3Du62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okllHbx6+ZsTES5H52bKAiWF8wQKsmsU0hqDpnVlNuo=;
 b=gqdj/JYcmQ74/TfriJWNL3AsULOwNKlcg0wXXXdzxrsUuC8qjvKPpsd3BEg+p86662K/owKqaHTlOptnccvjBowQCRYSOx+vD3qSS4I/fsqm3//pWLGAhbNPqG7y8rqpn9W7rf9Lywq2jvgIfpv7wyqiK2mxrgExtPrYl6n0jHRg/4ivuKst3pz3NWlKi6LQUl2m4xhKVB3MrTUFsKnSj1xLusccawwalQUnn44styETSX6afWAIuhkmTPmdNyUITorzNOD/iyp1raR4aMhpDTeMKGqqdcv+uspUk0Th7FJxMHwq0mbWFZnhw7WiFbeW+D0dkkFRhvrwnt7R44I2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okllHbx6+ZsTES5H52bKAiWF8wQKsmsU0hqDpnVlNuo=;
 b=m/2apD/UPAXRGYDi9kqkQxX303BU3aMu0ZlhcSLLYZTwwhPhUcHFwk5k7uiXDSsQKmfncXuNtR+dPZJWOuTUixNmyBdoiNtSEMM7uaQ5fez1r4ADSwOLYWd7WWA51T0YJANvgcRrtdRAi8+aq1GUTymbaCaLdu6jNME9xGDBRRo=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB2959.eurprd08.prod.outlook.com
 (2603:10a6:803:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 12:23:36 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:36 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 5/8] memcg: accounting for fasync_cache
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <4eb97c88-b87c-6f6e-3960-b1a61b46d380@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0064.eurprd07.prod.outlook.com
 (2603:10a6:207:4::22) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0064.eurprd07.prod.outlook.com (2603:10a6:207:4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Mon, 15 Mar 2021 12:23:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4856d2d9-0a36-4ccd-7150-08d8e7ad282a
X-MS-TrafficTypeDiagnostic: VI1PR08MB2959:
X-Microsoft-Antispam-PRVS: <VI1PR08MB2959D14FADA18703C0C0479CAA6C9@VI1PR08MB2959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xV1P3dBPcUMkHuin791oBiawishY7vdjeGuHcNXnhIIpUYWvb+O1w/XcFZNtfCHw7vdck8q016r96IXys2TaFRTKG0lb2s9Gtv+QoZThxALo9n0jFO6srnxwqyWQwI1TOPDlkzZCpwkggjaM72CjRIjoUww4PnyL4nUNd13vLLXae3EPGymXFs21KNQ8VhKcp+PRHMbcTQ5PSF3duHT3WJO6k14gV8S9j34kq5CAZx95068kPAicT9p5pJjIwEfYHFmMA/3QsG86Dm7jyg3WWVt7C7wXtcBehnFQHQa+Wht0GmCGpmxTBO8RJEvpmsUjX2G58yp3sHpor58p7+oMAWyJd7qTAfMAfmmK0qsBetoaXuDu1LvHiK7zseNbSDfdrSbWsoFMmIOYbQv6t4meCEeySah0aWiGGSdHm5YP3d5Wtml+LvaR6g+zwM2q9lv1Yeh1udpR66ghyBgPMytsjOEqjcXwvEMgbMDYoyvfTdfD0nOfxmAfzSuaUfL7r9Mr5ueWbdkLkll+rC6hP981PbxGDvhSqED/JMIPf75/eGwJAHU2CMnODuaz/H5KSld6b/srhwTL3oroPcaB+b8e+XRBhBGqhPOX7e0U/vvxjH9oafeYWAQOB0DFSjvUp4ymcNsk6/1SOdtWFZYkrWe0Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39840400004)(136003)(54906003)(956004)(8936002)(2616005)(5660300002)(31686004)(66946007)(16576012)(16526019)(4744005)(52116002)(6486002)(316002)(6916009)(8676002)(36756003)(26005)(66476007)(66556008)(31696002)(478600001)(4326008)(86362001)(2906002)(186003)(83380400001)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnpjMFBDSThFY2lBTFpXZVpJK08wUFFGWWJFazVabG9UaXkxVml3Tm1YWUcr?=
 =?utf-8?B?VUVZZXpOWVNwQjNCZ0JYSHd0NGhuS1hlckZPMkZmMHlCMW1pNFQwenVva3Ar?=
 =?utf-8?B?eUdJZnV4N1lDWlkzWDNkSWZVWjhkR0pZMmVWWjB1QkozWTNTcVpkRlNWN0k0?=
 =?utf-8?B?NUtUOFRqRmxxV1M4Qit2YVlSSGRjUHo2eC8ybkJGZkJVWjRiSkJzNjN0a2t0?=
 =?utf-8?B?K2gyaEJYcWd2U3BrTUNMV05LWkRBZzIrOXhUaWRpRGRlUjV4R3pDblN2dmth?=
 =?utf-8?B?RE0wWnZPWUVWeFV3UmhFbVR1b0ZBNDZJYUNqQVF6SGI0MkZuZEIxVWI1ZUJp?=
 =?utf-8?B?Ykt2RTZtODdZSThJVFh0Sm5xbWR5amZqTytuSmZwNEthazMyMlh6amdUZVow?=
 =?utf-8?B?eE9KaGwwd3JOTFAzbnZtcE9mV3BvM0c5OHRoeEZZVTQwdXhVZmpJb1BXMVRL?=
 =?utf-8?B?YTZWcktUSkVCalVsb3pzd08zMi9hRHZyb2RuSklvN09ENEhWOFNuRjVnanVL?=
 =?utf-8?B?dVFjc2VISEtrRCt1bDJpZ3ZTbEU2ekZ5VkQwY0laUm1FUGxIbXJ2OEdjcVUx?=
 =?utf-8?B?MXFZbXQ5bmdDckpKNFI5OTdZdStaYVJCTGt2ekN5OWNobkZKUDQ1T3pQeFdK?=
 =?utf-8?B?UXpLakdyNUdPSCt6MkRDOWRzNEV2L2RrcTEzbERCMmV3enJMWW5qTHBkRC9t?=
 =?utf-8?B?dVVhZGtybXVWWHd2eTdBWm5rdjZCNTR2R2VualV2VGZ5R3lqRVNrQnRkUUw1?=
 =?utf-8?B?Y2VlbEZoNjdOclprMkNxdVIxcFlJKzRXSU9BY0FrcXdCalhRUzRaVTNrMVdS?=
 =?utf-8?B?UHUvRzZ3Y1VYd1k4WnV3d291NTU5ZnhTZzFaOEFsenpObGZremFXNEJhWmdx?=
 =?utf-8?B?NmtVWGVSSU51c3RxRDBRaFBERUpQb1JqMGlQY0V4KzRGU3NrL0FyMmNVb2pi?=
 =?utf-8?B?VFo5ZDM0WldzZmgxT2JXV0R4OWplR25aUXVVMGp0ZllUc09YalRuRHE3VTZ6?=
 =?utf-8?B?RWc2MmZRaGMyaVNrNlBtL3BWaE9ZUWl2YisrNTNmOW9sTDhmeGpzaldYcGxZ?=
 =?utf-8?B?QTBmZmlQaG5CK0RzSmc2UEIyZlppUnpMdXh0NktyaCtvbGtIRlE3QVVQc0pK?=
 =?utf-8?B?Z080WWU3eWlGY1JvL0Nkdk8zTlIzS3pSNUdLanpHY2RMUFRkU2crc3RCSnV3?=
 =?utf-8?B?VFhveVMzcTNzOWRrekRjTDNqcys4RGZ4MUhKRVVpMml0Qm1laHhyTXlsekg1?=
 =?utf-8?B?R0MzVnR4T2hRY1RGMUhVUDhRWk1HZVpMSDF4QVF4SFlrK0wvazJmWTA0N3Rh?=
 =?utf-8?B?ZDZEOXg1M0Fqb0hlcDFvTm8vWDN6M2QvMVVoRjZMQmdLVUN2ZksxTlVsY0Q4?=
 =?utf-8?B?L0pQRmVkYk9tSTJGNU1EeSs5ckZLZmcxaVJyV2dCTysrWTkzWU4xUEJFdkkz?=
 =?utf-8?B?SFpmNGRWMnlkTlhadW90OWdhMkJiVTN3VGxubWpQdUZxWlpFUDlhbnJ6MU1Z?=
 =?utf-8?B?K1NWc3RIdmplb1hlRVBOaVVwZkdMV2plMWF2WFEveU9ZSXV6WFoySlQvU01B?=
 =?utf-8?B?bkQ1NkRiTDJHaUNoNytPV2tVYis4WXhwQWZOYnlrWmFmQzBZUkJsZ0NMM1hG?=
 =?utf-8?B?Q1I1MU9odm1CRE9SM1c0Y2lEZ2kwQ2pmTGJ0MjlTb1AxbDQrTGxzOHMxUkxn?=
 =?utf-8?B?NU5ZUkFNSlRGZVU2RnlQRGZHRFpHVWFsTTdEdnVlZDBHbGVNeDJFeDFFRkdE?=
 =?utf-8?Q?6uSU4ql20ltGT6eJ5xHCxnkoACvcdU2dxWGa1gV?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4856d2d9-0a36-4ccd-7150-08d8e7ad282a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:36.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+cjWOV59zZH8NC/V1q20rP6iE9Z5HCHxDZUY7UXLGLBn1xhdfQc+b3b0W3fweUsFgD4QbaNLsmg+MZaCSK8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2959
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

unprivileged user inside memcg-limited container can trigger
creation of huge number of non-accounted fasync_struct objects
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

