Return-Path: <cgroups+bounces-16789-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xrpKIU5AKGovBAMAu9opvQ
	(envelope-from <cgroups+bounces-16789-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 18:33:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E97606626AC
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 18:33:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=santannapisa.it header.s=selector1 header.b=WWiL64ia;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16789-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16789-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=santannapisa.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63E9B308DC6C
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D637DAAC;
	Tue,  9 Jun 2026 16:23:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021096.outbound.protection.outlook.com [40.107.130.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A7377EBA;
	Tue,  9 Jun 2026 16:23:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022227; cv=fail; b=MGiZrxUJ4ITgSHZOHWC7LZYcD1Fzl1otV24ct500myfFyeqT67FmvibBkhVOetCk4zPnbb36rqOPMi79SVy/4dxYsjUsp8QWZ/eywf5jiLfVtuGEJ725A3VSrEQS019d9CGnGEF6g70KoumdADVKZlwbpU9X1N3HVEQCBrQHU4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022227; c=relaxed/simple;
	bh=mkRAEEOmdU8K3DZH1ScaSPsKo2Jm4qjLiUFTsRVywUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GIBwBlvC+8duoQCV8BUlHmnSqY3HraRjz6Lsm8B19JYgoIgiqs4H+hkqTZw8E2jdzgnoceX7wTPjskNauuI1ZcQb5umzRRniM8JZ7LHYKBemCTgDFc7M5WWWYjOeoPSrJmMFToMOkk7v+2E9caRWTQTTRLC6/q7gUPjk9uf3VHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=WWiL64ia; arc=fail smtp.client-ip=40.107.130.96
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1bI3VNzDItd7g9wHvySHeR0t5Mba+n7RSKLY6CzBjL5qDLcyOc1OISNzWMxTAeyQbC2gWB5wENTiO+wXobT2EHBPki69IXgsEqDsqqSzAIzhc4pXsLb4ZCx+mm8VQ22PJDRsuYzETHMf3C+QDUprnzfFimnpsURrRf9nGwIRbaQRTPOJS6eEbq9ctMpw2AVbW7grZnkgTpYNKCzAqgB2KgNDBSnSZaRjHlKEwZeinS8LgZQbq7fQ+JkuVNFVN9O0jx5wyTewZkmLNfs3bN63IRakIDIHfo5njx4UZLSdpSQvI7dOazmcEHcxR9NzUMELX915mUgZ2Dz50MUCJzmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IykR76QfJG0XMGdvn0nTAxArO+io9x3zs4i/JjQHHO4=;
 b=pPjhPRYuTwixDW/LPShQeOzC0pgVZjbiJSOkYknxYd0wupQFzX47Cm1ZKG09HYawkDN+DyESvUXM47aXvi+i/J5EFMuyNmwaYURxncBlZtUT5CVkheGMakIuv1d6veOaGXsdnpvAv/xSDtDFfdg0dLZdy1x1NKbILcvMvojXm6Roo5jPKtXMCFMc/HT39tm/xN4gcl7vWyO61Mtn/VJMmWAIXpnze4A+cLYVnuMG2Q08FJwr7x2TKo4T++76rdwE04pL3SRZGlsnPstl6+6F3UGSm1LnYbMNE1RwS/bLQjhAyKIMiov/prU5SqjFWXn9WpFih/J65KElT0lhiGLybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IykR76QfJG0XMGdvn0nTAxArO+io9x3zs4i/JjQHHO4=;
 b=WWiL64iaImIhOfwtAPjblPsVcM5YDE/qEc+GA0KuInt/cUsy5i7kp0AYnrWK5VPOp658LNsBaxoxEIVdcoz3LX4jipK+d0dPDkTfemB1vLFrJTKgTUOkqBlgeSbC6YIjP/OTuXtHEId7T5czO2iP6SZjmrZ2eAToLpHHCNwdZzc=
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com (2603:10a6:10:52b::6)
 by GV2PR03MB8679.eurprd03.prod.outlook.com (2603:10a6:150:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 16:23:36 +0000
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9]) by DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9%2]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:23:36 +0000
Message-ID: <9c0d3d19-5c14-42e0-b29d-4ea32d9e624f@santannapisa.it>
Date: Tue, 9 Jun 2026 18:23:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Yuri Andriaccio <yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
 <aig1ZGEq0Vr0qLzl@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
In-Reply-To: <aig1ZGEq0Vr0qLzl@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DBBPR03MB10258.eurprd03.prod.outlook.com
 (2603:10a6:10:52b::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB10258:EE_|GV2PR03MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a98447-65bf-4fdc-6fab-08dec6437502
X-LD-Processed: d97360e3-138d-4b5f-956f-a646c364a01e,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|786006|7416014|376014|366016|22082099003|18002099003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	e6CQ8ZfFJ6qxB3A3Vex7kFMSomZW3vIs3magFM+DE4nOXqtyIAyjOM0EBrjZrgRoL4S5KwcnMKtXFjhGSpfrN++y6yIS6R/AqaXFumzfcfZ28bD89bOtSsn/sZaz1iv4HO2zLCwqaOjmDzMNrz5xYIKwfy6rMTC+KNDShZfUt6c6HGT+4yH2/q4HzJAC4Df4JmWbIsxAv5VqjS8tUB5hT74OGLHnrHQdADZCHFPID0iOLUJIs+5ZD5mQVtYWBaA7b2VXSdbZMgi7EQjPPgKXE8OeaUFXRX361NusGfrsQdaxOvczYi5RfQvrbBhHTOyND7zVyggLWRZWmiS9R/g6N4IbgH4VnhKfT9t3nd/v3JJ+xZakj/5GPfexld+miup/2lbImV8Q0ItBbyNnkbHoh5kqgbnbW5q1KRVbOrH3MUApPu4vqAyY/AXOEYOB8f2Utvqc/NYnjW+MYmT1b6mnjQhq9Ev+a/5HUJHj0IDB0ji5TaQ/vHLC5MBmNX9+qK7EgzvVJMo2coHorpJGJN0z38xgKh+ad2aBLQg+I6QLu0SHRMf50os0iM00uUI9ldMr2+lwRQK/IMALpyQXI59l3B4cNVGdSRxVq8lwgp9IhEEn2AF2g1dZf43pe9ZXRxdh9NfiTy9GgGJ6RcvfINTKY23eH7uY2uxvtjtkvas5gd/spYsSkGZb0hMa5Rypz3Ic
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR03MB10258.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(7416014)(376014)(366016)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGY1VFprVEsrcWdBZU1SS3ZPYmFLUXUvT3FmWlFRbFBwc3Zxckw5TmRIeFVr?=
 =?utf-8?B?VU4rdmxjbzVERi9ka0lYcTVhR1A3RllVSTgzdmdEaHl4MzVIaHZXQzRQazlT?=
 =?utf-8?B?WlVYcWpHQ2VRSmU0QUdzSGVNRWc3NGhOTTdST0ZaZkZDNUlNS2I0THo3d0tk?=
 =?utf-8?B?U0t2OXFESDV4dkRYTXJiMU9KS1VsdmJlMllCV0NDcUtYSDRtdUxucm9PTGNJ?=
 =?utf-8?B?Rnd1aDRkN2dlVnZSd2lRa3lxQlU1L05DVDlFL2NnNG5MZmk2eDc5bmZpRXdT?=
 =?utf-8?B?VTZuV0l6QndsSVhwS3JScU9PU212L3o0UFZITG5KUUhtZFN6bS9RWWdFTjFV?=
 =?utf-8?B?eXhiQU5xSXdzblkwMmxYRzFkbG5lUjJMLytTL2lvQWFzWDZTbHN0YnNRUFRv?=
 =?utf-8?B?Uzd2QVVNWGZBT0tpQVM4ZWkyQXFCbkN2ck1ranBrdWF0cEduRWdzRUlVa3pk?=
 =?utf-8?B?OEZrNEdvcnk2Z1JUdkF5UTVXT0tLMENlenlVSERRY0tCay9pMjhia3E3WjJX?=
 =?utf-8?B?QlFIVDZUNHdUSEUySEtjU3VKYXpqaGpsbjRPMytlNVRrQzU4VGlSQ3hXM0dE?=
 =?utf-8?B?Zm9waHcyaGpXQ2w2U2MrVzNJazFPbEZ5L1Z3SG1XVVAweFZkdFJRWGVyM0JQ?=
 =?utf-8?B?WXE5NjZWcXZSa1RHWUhBSmhRRUpTbW80RWFyNFY3MGRjNmh5TjNlaUhtMDVr?=
 =?utf-8?B?ejdqRVBFRzN1dzRDTEpORjUyVjRZZCszZGpEMXdZUTFvZlZCbWZuL0g2QjJi?=
 =?utf-8?B?Ni9vWW11Z25MSzA3VEUwYXl3dmpYS3ltOWV1RUYydXUxcUV4ekd2SThsMWJE?=
 =?utf-8?B?anlzTm95R1kxSUV4bUs3eHl5bVJ2VExLaWR5ZFRheWNqQ0VYZmNHdWpqT3lB?=
 =?utf-8?B?MWMwbWU0U2tMRzlmK2JNSlhuajk4dENCVjFXUXNVd28xQ1JFbys5NVFaNGx4?=
 =?utf-8?B?YXNKY3ZBOElsTmlHQnV1V0N4N3RLWndVVzdBRVRpQ3U3TkJrbjJQUFpCRmF2?=
 =?utf-8?B?SWFTWXBNTE54ajdRQ1VkK1N4dityc0RHMDhEaWFhRitaSU54dGZPeUdWN1NX?=
 =?utf-8?B?TlhBY2EwZnljSmxNdlVVRVZMWTJEbC9lUGM1U3FuVDdlcCtGcnRkT2NyVVdj?=
 =?utf-8?B?ZDkvVXZKdkZiMGhPMmRNNm5neExLMDdvRnFPb3FPNFI0VjhWajBOMzA2S0E3?=
 =?utf-8?B?Q0E3QkFXeFZmR2txNVlKSWhIdU04S2QzL3VtM011eDZsZHlrb05sQTdWZ3ZY?=
 =?utf-8?B?bGNOUitrVTZGZWRJOG9tTG1kaURWTkNTZno2T0JwaXZVdWQ5NlF2QVNuTG9p?=
 =?utf-8?B?b0JOTWRPSDE5ckFITERVZUM4bk1tbUNQSmJiRkZTNjhLS0NKK0NKa1RMWnhp?=
 =?utf-8?B?eHhLekhOT2NGczBNNVJjN2dxMTFKdEV2cEoxOEZyN3VKa1J0QWhLQW5iOTd2?=
 =?utf-8?B?UDdKS25oQzgwUTF0bnlnbkZRekxveFhtWUFZTitPbm9BLzhGTU1TcGRYUndi?=
 =?utf-8?B?VDRLamNrQUNCWGR3cHVzdXIyTzFGRDNMT3B0N2NESzZPSVA2bEtETDZXc0ht?=
 =?utf-8?B?K0ZHWWhSekRLRFRmekVyRHEzeE5vaUZzUElJUWYrMDZ2bDg3RERhY1V1YU9t?=
 =?utf-8?B?b2I3RlhSZ0dVN3hpTm1SdTRDeHIzRGhEWFpuNlJZL3hCeC9XZmgrRjN1UkpD?=
 =?utf-8?B?V1VTWXpuWkwxUm5LVUZlbFROa3Fkc2o5aHVnWmU4cGFDWDViSXY2a1FDV211?=
 =?utf-8?B?RjE1OWNON3l0WXpTY2RYZXBKWnhmTkJ0OUFIV2ZxUTh5OUxRUDNZSWtkRFVG?=
 =?utf-8?B?M3p3TXVYYlFzWXFTdXhHdHg2aldoWDh1b1ZvS0VWbklYUFFBbHgyMlBvZmlP?=
 =?utf-8?B?ZXEwMWhGM21tY3RGOFd6cmhtUlNqT1hZNjkxOFBDTDZ1RThSSklOL1B2T25H?=
 =?utf-8?B?aE9zbk5ScDBHZTNTV2xlcFNSOEJZMURKTkNqRGZEZUpvL2hXSUVOS0RzL3BQ?=
 =?utf-8?B?K2dEMVk2S3Y1NEVhczBBcUl2cjcrYWlHWmwyZVViN1haMDJUNjc4Q3B0NVVh?=
 =?utf-8?B?SzdNcEkxUVRseUZOOVY2WWlmOEdveG5mTmNQVjIwY1ZuWUZZUHJPMkJxZEE3?=
 =?utf-8?B?dnlHUEZrMXUyVS9qNkY0U3VJOVFvLy8xTGhhc2V2cHg0VVRTNGx0T3ZhTDYw?=
 =?utf-8?B?ck11bDEyQmltTENtZ3RkWnZJd1hyeWpuMTVocHdEbC82Vnl1eDcycm93S1BK?=
 =?utf-8?B?Y1JwTjBsUnlUcW9mbGdFQVNXc3hWT0hKVS96ODZIeE1IRnY0K1BNdG1kUVE3?=
 =?utf-8?B?UkE5SW5zdm4yVXg0NGR6Mm9NVDRYaGVPVUovMGRrellVaExqMmRjbDlTcEMr?=
 =?utf-8?Q?+muQWK0SyOr2gWx8=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a98447-65bf-4fdc-6fab-08dec6437502
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB10258.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:23:36.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86P+78aK3Bd8TMa3u3SYOg8IflRny/RfibdHzBoDsW8lgqGTSnPzdMdlxnPJ/zj33w38Z07DRBEyEPDfS8+oauFZ7EO6axNjP/Z5HXsu9I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8679
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16789-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:juri.lelli@redhat.com,m:mingo@redhat.com,m:peterz@infradead.org,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yurand2000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yuri.andriaccio@santannapisa.it,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,santannapisa.it,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuri.andriaccio@santannapisa.it,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E97606626AC

Hi Juri,

Thanks for looking into this.

 > I started playing with the new interface and ended up with the following
 >
 > bash-5.3# cat cpu.rt.max  (root)
 > 10000 100000
 > bash-5.3# cat g1/cpu.rt.max
 > 10000 100000
 > bash-5.3# cat g1/cpu.rt.internal
 > 9999 100000
 >
 > which looks odd to me, as nothing is running on g1 yet and no children
 > groups either. Maybe a rounding error of some kind?

You are right. I should have mentioned that it is just a rounding error 
that occurs when converting from a bandwidth value to a runtime value. 
This happens because the tg_rt_internal_bandwidth() function truncates 
the value when transforming the runtime from nanoseconds to micros. 
Rounding could be used here to report a more accurate value.

This same issue is probably found in the from_ratio() function, which 
has a similar truncation issue when converting from bandwidth to 
runtime, but since it is working in the nanoseconds range it might not 
be that big of a problem. The value from from_ratio() is used for the 
setup of the dl_servers even when the children bw is zero, so maybe it 
is possible to add a special case?

Anyways, as it is right now, the cpu.rt.internal may have only a +1/-1us 
error in reporting the actual used values, while the error for the 
runtime value used internally to setup the dl_servers is in the range of 
tens of nanoseconds.

Thanks,
Yuri

