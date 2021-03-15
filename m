Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80733B28B
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCOMYQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:24:16 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com ([40.107.14.93]:4417
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229518AbhCOMYG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI+QvIHOV5Uqmy3M57rYHj5iG30BP9QwQO/52wybjO5Mn6FQVhcE2yUdeZLCuRR7NjxxEVE3+zuGcsN0YkM9o4DOBTXx0MuyVUOwxvUgLL76xrX4M4fZCMLyylLiVex3zzCLZ1b+goBG/OBQGkQ4P73BgKqTzpmLUroo5KVoLsFuU/E6Bioe6FZxOKTNV3sirVtP5fWR0bI8NDyjSV41OLJGYvOySS+10BnRBn9aId72iOnwFTn/vgaKYEE7D7W3y8bUy5Z0vGJJWDM5EK40d08IYR4ERLeSSqVMRNAMK1hWepxkJrcUWpx197mWKDAVevEqzAQWslov+GlJ6rl9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE6wYXc6jGWrFCi8xC+rTtGZDFQ6Sn++28m6c2Yf870=;
 b=RgP4XTA2pbh3Y7AbUzVZP9kPRLa/jkjVhgfirYh7/nSzZBSM52qY+8TzuPyL/VfntHdJFnNJP4yKtYEq2lNn2EnJZAPCW1XgmOulx8/FUx+/ZsyUc0j1ZAuVonbf8PpkRwddg/6ICBofhOWqlkqBTQu5vPf+BrljJaaGjSl/P8PbddBVxgAXrHPhUg7rLiSVwUKAzJFXuHIbQF3bYnskKmCleSeO8Tm87hJdZ0Z9JJSHwhkyJi5QdoztspD6W9zl/GSXA4vMyqqWyFb+/gq84XzADL5px75lR1uEhPdSoWBFGYeJ4YWWPeIJzCYVnU1u2horQu79/wOUZ+7pmIhycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE6wYXc6jGWrFCi8xC+rTtGZDFQ6Sn++28m6c2Yf870=;
 b=VghCuqd/0qXfvtjtbdGpWsaS0K/C9PB8TPl6LaR5ZHPv5BLs/rpk0cozuwN8v39wSCHrkiKIsvYRlOJ6MVrk0bSVSlD00M2ay6gyLNKI2vDtBfAWaRTM0lvoYQTkXOWQJeQxcVFv4jDd5MQ3368g2wgB46s+tYdPgfBLBSUjjUk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VE1PR08MB5038.eurprd08.prod.outlook.com
 (2603:10a6:803:116::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 12:24:04 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:24:03 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 8/8] memcg: accounting for ldt_struct objects
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <360b4c94-8713-f621-1049-6bc0865c1867@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:24:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::25) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR08CA0012.eurprd08.prod.outlook.com (2603:10a6:208:d2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 12:24:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e92a66-89a8-44e2-197e-08d8e7ad3886
X-MS-TrafficTypeDiagnostic: VE1PR08MB5038:
X-Microsoft-Antispam-PRVS: <VE1PR08MB50380A33D0617FF238267B4DAA6C9@VE1PR08MB5038.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcidaY+YN9yJh2IaFypxZfCb1lB8TeK3by3eFwikzef03j+eoOUROciSIO+KudPB3Vn2w3LsxK0rePcHjeR63AbGunFZIaqJ/lPT6LSw6y11oO8S+h7/8xgodGL/fM21b0nNLFGPfYqDJiRrkU6OzbaLNpbj0D6ofQMPHW0t2BPWlSUTQe7UlFMq3ZcT2rdG+vi9n3nH60mFfSTmrNnoyvlqdGXx9/H+BR42hr4H9ka1DOGKuHgPfOCCko4e+TraOesgTxrcf08Ah+okqcmxt7VqMeTovp0y0/4OgZEp29hUvxarpRHe+NRq0nKV/qXPNNXIv0xoLZ5Qc4+IhOsykbXYDozzjvGsYiLKy0GTLqh1CxiBjhu//uYknwEICdoow3sfE8hyxKK8BkU3aLzy1NkK7E1Rigc/tlrrVHtRHJxiEkeZWno1ikDt5cA1YbL09djbavhSQmhNS70LmrfyWmyPDWQJX9KAir5J42lXGR9yBtVQl5oEXsPKaMJ35pWj1uMMWuqiQGiixk2uy1bAQbe1OW4zykDXSuwnNAjKh6/YV4sXbZvYXfa/nzDxZ5eWAVd4fLyAu0Goo+ITJHZhymIp8HC2UCcDdFTx15cVp23C02P7J7koVOkHrnQTLYnZUiSY2N7WYQ177c2Mh7cytA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39840400004)(346002)(366004)(86362001)(8936002)(5660300002)(478600001)(6916009)(6486002)(66556008)(66476007)(66946007)(316002)(15650500001)(8676002)(16576012)(4326008)(186003)(26005)(2616005)(956004)(7416002)(31686004)(36756003)(83380400001)(16526019)(52116002)(2906002)(31696002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YjdkOGRocWE3bVRSbitGUUdlaytwMG9UaTV4TTAwZk1JSUlPMlU0SndJTlBS?=
 =?utf-8?B?WnBiamUvYkROUEVvV0I5WUxKUGw2ZnRNd0FHZ09PSVJuMlh1ZUJqUDhXUUdZ?=
 =?utf-8?B?bVViNUVFRjk0RzExdXpmeEhNL285SWdBckZBclJ5aVFYUW5TM2hKd0c5SHNK?=
 =?utf-8?B?cWYrU05EQTlONDhMZGI5MG9zVGZtQXY1SmpFb2lhcVQxTDJMOGhMWVJBS3ky?=
 =?utf-8?B?QkJQOEhuUkMyYjJtM3BoaXgrelFyRUVURjlnaUlQb1NDTE12S1NNakYzd2Ux?=
 =?utf-8?B?TmI0UTZnOXVJSmRld2FSaVZaS1YwRm9UaWF3RVJiVnQvU0VSNlNVeE5kVjl3?=
 =?utf-8?B?MzZQK3Z2WWMzcjIrWDRkcGp0WkhxeWQzaE9Ed2twTUFyMHJkNTE0NVpLazM4?=
 =?utf-8?B?UTVLVVAyT0gzV21rM2tpTUtwcVdFMTJVbmxZellnclRlVWRIM0E0c3gwdXRR?=
 =?utf-8?B?L0hUL1p6emlBeVZJcTdvUHFtREkyNnpoVEJTbjRjVlIvem00YjdIaHROVWZ2?=
 =?utf-8?B?QUFWN2ZxYlo0ODM5dkZOeTVqRVpCNkhPRzRxKy9yaE80dHFSUjNkZFZnV3Nr?=
 =?utf-8?B?OWw2MUoxWmN1YndVa1A1UzljTDdoZXNEcjZFdWpCa0Q0TUt2dURzUHFvMFlE?=
 =?utf-8?B?UmJjQnJCTE5Jc0xoNzVHU3RBOUJaYitEVFZHbWVHSEZha2t6RGdWbk9Kbk42?=
 =?utf-8?B?dTFLL25JRitMMlNTNmZUTzVzOVBOL1EyMXdCYWprRUZvWWs5ZEt3STJWQzgv?=
 =?utf-8?B?RzFZeUEyeVBJUDBGTjVGOERLS1dObmV1RER1dTJEeUN0YnpZZ3htS0Q2QWg2?=
 =?utf-8?B?WlRTWTZ1ZzdVOGdLRXVOcUxCMVM1TkNjVEtxYjJON1EyNVd3dTFBT0UzdWNo?=
 =?utf-8?B?QkV2aDQ1SjFaZUlJT2Z3YjdPeFBEUUZ2eHo3WGFRUE9vWUlDaWVtbi8xdEp3?=
 =?utf-8?B?OGJKVmZLTE1uU1Exb1dwVmphdzlCZjJFRDJFUy9mWnowNldsTVIxSzBBYmVs?=
 =?utf-8?B?SklaQldJQ0R6WUpEYXE1YkxrUGtEN0N0eDFRMW95djBmcXJPcktya0t0Q1Bq?=
 =?utf-8?B?MVVMcVA0WjZ4ZERqeXFkWUpxbHVpRXNnUWRWTHVJcGNCRWJLMXo2V2c1VTgw?=
 =?utf-8?B?MlduM2FRdExzNGtmWEhvc1hHWm9GKzdPdGgrZmVqY1U5cVRNMEw3Q29TUHEy?=
 =?utf-8?B?Y1dFRjdocm1QL3p1dnJramNRVGh3V3hjS0FuVzd6WXFrYnIreE9lcUV3RzRS?=
 =?utf-8?B?VENFWFcycDZsQWZQYkdaUnl1b0krYlhZUVBGSFFsQWlDWUw0NWZ5N2pFMFg5?=
 =?utf-8?B?U25KaWw3ZXFkYTdnb0VqWUdLLzRraDZvK21WNEFEVTlMcklTN3B4UnVuUnVt?=
 =?utf-8?B?WVBON0JYaUlCRHdWSzdaUU5aUWRZYVhudXlEdk9pQ2o4MWpzVkFwZDNLR2p2?=
 =?utf-8?B?WERTdWFKNHA0c2hWdFZyZ2J3UWpMdGx4MWdrdHVWS2JLYjRxY0dGandzaitF?=
 =?utf-8?B?U2pxcjdsVWJRUDJvVjh6OXU3c1pwZGFrZzhCc3BrRFRvd21tUXB4MWtMRWxl?=
 =?utf-8?B?TWxHMTBKaFFtUkdnQW1EVlRrSXJ3VFFmdlA0QXQ2OW1NbkFKaVM3UFMwYWMz?=
 =?utf-8?B?a2luUFVsbFVuL0FBd0hNNDVHQ01lUUdWbVNnUG0zTWJMVUk1WTcvTXUyUjND?=
 =?utf-8?B?SVN1cS9BSE4zeEp2M1BUVEc3ZlhqZExWTlZpc1R3Z0l3TzZ3emkyY3ZiOTIr?=
 =?utf-8?Q?a/zvSYqA982yLiUPs/A3IrSPT2Wt3399shqPBoQ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e92a66-89a8-44e2-197e-08d8e7ad3886
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:24:03.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m65B5mK6WS75ftqzMdiiPf+7tXRneP3a/dCaxsZZtGK9X5+Apu+bAqk5NeTWGJWiIjetN3X1/Us/qmld2Nw6sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5038
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Unprivileged user inside memcg-limited container can create
non-accounted multi-page per-thread kernel objects for LDT
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

