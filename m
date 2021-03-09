Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65FC33203C
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 09:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCIIFU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 03:05:20 -0500
Received: from mail-eopbgr70133.outbound.protection.outlook.com ([40.107.7.133]:48385
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229767AbhCIIFJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 03:05:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfn9HUyO0797SZOLr9eZPUj8VIJuy3dHFysJo8GIg2jAaWYpDP+sqjJp/c18slEuYQyuzX11DNKwdHUFpg9fdE+ReumNWX2BTqMnUQFPuxTlIhN7BF/CDeoKQTRHFqj9JXjCRDD16jRKVACQjrQo0kuERNi4cXfXSmAxs+iFCaBJKYpMdMHUvdSfDgapz8MQIqL95MWGsj7afslcGWTSqpsu3g1FoUn6nZnSZMfcTJtcbsDPvNeS9QTJh3fDYxChSla8NnRtl4M0gVVYynlHRHe/8n0eyvR7Ahl1yfJc1hLFCw2VwGf/iD2vXcpQRBt2s4j/F8htIu2Oi86p1r1XzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DETAgUIoY/Yh+88xtrJ0p4ub3J39q3mROrB0pV7+7iY=;
 b=XtEYBmV3dSl7P42kwK/ipnoyUZDc5M5mZcWy1CEPKBOJzZZXTk3XqeyL7jcCBhJsmpxOkaknscF8UzHc3NLXx8LuhRsIOIgkicvvVruOjpsNAqRNaeS8c+PF6Hp2Ub8QpcaAMgaj4v37esuXaLK/WJChIeHkwrBE6fqJhXTkUnr/mCQ/vTY9aMZcbmPyX/sU5dq3SfZDJ4jzR0i6ekBR0q9QQMd5ngXUUc2W3+qkUCgSHf7J7lv+2R/+egez0+Ri0zJhb9Af8/IVdAhIWWH+VYCUWnZc2+xEa3nLnTRdcBBQt8nvk4LIk1ewgUdRj95ASiyYGMkoJfdV/BgA/+aArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DETAgUIoY/Yh+88xtrJ0p4ub3J39q3mROrB0pV7+7iY=;
 b=s1VeK+kL/60lgVPBobVfRF82ESE/ZrQt6G7tL6f0LBe3D+HFVMTQU6ILix5Gf/uZWUi+lQDaluVNyWxT2qFCLctf8EqjgL47nG/6eBAOi58InqTwljsuG4JiZBg4eLf5OvcLW7HzQ6NtliUXsI1QlCTcq/Yf50HgWzw+AdY/cNY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5789.eurprd08.prod.outlook.com
 (2603:10a6:800:1b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 08:04:58 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 08:04:58 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 9/9] memcg: accounting for ldt_struct objects
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Message-ID: <05c448c7-d992-8d80-b423-b80bf5446d7c@virtuozzo.com>
Date:   Tue, 9 Mar 2021 11:04:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::29) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:04:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3af80f-71a7-40ce-eac1-08d8e2d20815
X-MS-TrafficTypeDiagnostic: VE1PR08MB5789:
X-Microsoft-Antispam-PRVS: <VE1PR08MB57895AEC15A0AE02369C3E36AA929@VE1PR08MB5789.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wz4CtwHx1MUT8YX9OB2Xwo7jEpC7AZMVaf4LSNVU2LrEFMEzmFFqcbmh/AcaqDfhoaYIYQtGfXKM1n7PE/sS+SV4misZG8NmPn1AGbU3R/qzuJRYbHBZ6BJsEsusdw5QnMaXWT+c0Af/H9yldaxEpAKMY52U436G/1m30bFcPLXXLptUYU5qZihELSS6pCEmZuL2w0askVOGCAQOvaPhDQkaQ7ZZZARmR6BR9IyD32N+Uh6DG99aho/0EzlexZRfGPUNZtNug4AENpOwIfaePsAGxsR+RjiL5g/PTOFNTs/dUL+t2ZODnFi4ZeYqL+J8YxUsFVHFjLzUtYJdi+45A0PweMl1vjOcnunsQYUJph1zEbwNxe9KVt0ofcfxzllv0m47GzuGU9NyRh4u/lImZ1e2u/XUUfuzgPrBchs/0hz15xMfMrVJwfZUDufXk+AP9qbXX/fuyGSgyCJnXLPmIHqZ2vi0oqiWUN+VEHqgKC0lC+IWTppfqI6khtTTechfVjg5CfmQ2OiWTDBCkmY6+U99pnYZT3ND2rTT3XuZib/wMkqBlDIp77gX9AnzhEJE9ivMqSrpO2kVqNknQdc+sNvHDrTWipt6ESbqw01+cY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39840400004)(376002)(26005)(54906003)(31696002)(66556008)(66476007)(66946007)(36756003)(186003)(4326008)(83380400001)(86362001)(478600001)(8676002)(2616005)(5660300002)(6486002)(16526019)(2906002)(8936002)(31686004)(16576012)(316002)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OThRdFAxTkdqRUszbDlwRzFrTWtjbUczL290dFJGbE92RmRoclJ5RVhoTDBl?=
 =?utf-8?B?aWw1SHdWc1JvSEN4Ukpic25JUWphWnhGdTBERm9ueDlkVFRCZUpLNU1CMGMy?=
 =?utf-8?B?eFlNampObFhXQkJaSWFvY3ExS0Y5QXBzRU45dVVqL2xOZW1NNGpQV1FLR2l3?=
 =?utf-8?B?dWFTNHptWThWWU9xd094dzZZdmVJZHlqOC9IbzV0b2VaS0QzRUxyMjhIUGRQ?=
 =?utf-8?B?UC9QdTVHZ0V6aFVveXlGNm5KYjh2OVR6QVdQaTMxcmN3YVk1eDhndytYY1h2?=
 =?utf-8?B?WVlpTFlFdnpJeXpaOGIzVkJHOTladkVaY2cyeVk3Q3NZL2k3U0ltQVhGS2wx?=
 =?utf-8?B?Q3I2Q0ZKTkE5Y25VYk5ialdVbEd4NzVFa3ZnOUpKZVRkTnQxcUIvaVVuc25X?=
 =?utf-8?B?RktpZ2FoRjRsWmZqWmFrYXpmbjBqeGpZcjhtOW9qN3VMK3B2d3o2V1hLYnBk?=
 =?utf-8?B?SFBGSGRSaWVXeUI0bStLeWVxR2NPcWdxVmt6TzhEL3d1ZUV1N2x4VmlJb1B2?=
 =?utf-8?B?RVJ1TldrbzA0Q1Vhb2dka3o4QXBmQ21mcS9xQVF2UVdyTjNYclJ5QllhTFZU?=
 =?utf-8?B?aGRZbEljb3dWZzllSVQxTi84dTlqL1UvUld5MGlZMExvNFBFVlUvRTVObkdC?=
 =?utf-8?B?YU50eTNhMFdWMlNlb2txZWpIb3N3aFV6NmpEbnFaMGcxYzBhSmtacTJSbzhS?=
 =?utf-8?B?MjlxeUdmVGdRQStJeXg4T3E0cStWWm5WN0lpVkZ3SGVrbDA5M3lBbkdkcGVC?=
 =?utf-8?B?UXNHbDhVYnZucDBTTXJwczlobXlmNmNlVktWdEU0UUtpQmJwRDB1djJOK2I5?=
 =?utf-8?B?L2J5WUI1bzZmYVVHTWdjU3hxa3Ywd3VZaXlKSklGN2VkZDVlcjR6ZnFqdmky?=
 =?utf-8?B?SEk2UWgxS2JjbWhTYnhEeXMxR3cwa3M4S3BVdkxRZlYycnFKQ0ErTU9rRW1O?=
 =?utf-8?B?VkZMZWQ2QlRFWm1mYXdlV3hWaUdBYTFvbHkzUFduVHlwZ2FYOTZPUCttZEh5?=
 =?utf-8?B?N014NFdDOTdueU01TDhCME1zemExSTZSdHJxT3FnamVDd21EVTJ1SXJKVnE4?=
 =?utf-8?B?YnBUNDV1dkJPc2lwcHl2Z0tYcFdtOGlTSDl3NFpUU2N2bXdsRHV0MCtyQTk1?=
 =?utf-8?B?c2lrNHVZWHVwVDBWd2VGUC8xaEVPNnBRTFI2Z09pRDFnKzNNRGZqbWg2bUJM?=
 =?utf-8?B?azc3QTY1R2RJVGd4SjRsaTN5d1ZUS2ZvazZadXBwT0krQUdlOFJUbHRuRS8z?=
 =?utf-8?B?ZjhjOFowNHFXVDJBZ201Q0ZTdTB4aCtXV2Vpd2VudngrSzlWYTJNejBBTzY2?=
 =?utf-8?B?VHBrSmhLOFdMelVBS3lFcGhnMEZJeS9mR2VYTXlhUjZUMmNxcU5YUWdsSVFv?=
 =?utf-8?B?bDZ4d3lyZXdBRitpU2NZcWFkVVQwWTJWekpVS3R4cjBNb0VNYkt2dWtOaWov?=
 =?utf-8?B?VTJpTHZGcG00TlhNeElSZzVoUVpIRENZZzYwRjVXSXZxMU82cE9aYjhncjVR?=
 =?utf-8?B?dnJFbk94QkFjTDdsb2Y0MmhibUpsNlVzSFV2cCtvdEtaUEhZb0xqdzlVUEE0?=
 =?utf-8?B?bFhMMk1SRVdhS0tnZC9mK1BiVXMwNWE4dit5RDI4UkNITlk4b1lxU21pYnlp?=
 =?utf-8?B?OThRN2E2aS9UZGI2WHcvaXJiVFEwbWtweHR1YlFqd0Z5elhMOXBtdm5qUmdO?=
 =?utf-8?B?Z2UwTE1UNjlOSDBNSnlFS3BGbURNRDVvOVNtZnRaOWQ3VndMV1ZoU0RlL0Jj?=
 =?utf-8?Q?p0ECqr4NxEXzgUG6CDu4mZuw1EE+IcG6Zol9nAJ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3af80f-71a7-40ce-eac1-08d8e2d20815
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:04:58.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlmVPULP6W+42BzgND7cArqD4SaS2ZDhjHBj8SaSum4XBlbPHf3DXdMKyrAFvBUtIEam/4FFMEdsX+514xXARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5789
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Objects can be created from memcg-limited tasks
but its misuse may lead to host OOM.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 arch/x86/kernel/ldt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index aa15132..a1889a0 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -154,7 +154,7 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	if (num_entries > LDT_ENTRIES)
 		return NULL;
 
-	new_ldt = kmalloc(sizeof(struct ldt_struct), GFP_KERNEL);
+	new_ldt = kmalloc(sizeof(struct ldt_struct), GFP_KERNEL_ACCOUNT);
 	if (!new_ldt)
 		return NULL;
 
@@ -168,9 +168,10 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	 * than PAGE_SIZE.
 	 */
 	if (alloc_size > PAGE_SIZE)
-		new_ldt->entries = vzalloc(alloc_size);
+		new_ldt->entries = __vmalloc(alloc_size,
+					     GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	else
-		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL);
+		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 
 	if (!new_ldt->entries) {
 		kfree(new_ldt);
-- 
1.8.3.1

