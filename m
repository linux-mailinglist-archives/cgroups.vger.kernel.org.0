Return-Path: <cgroups+bounces-3536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F33926D9A
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 04:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3F41F23202
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E1117993;
	Thu,  4 Jul 2024 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wqhs0lNE"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B239FD6;
	Thu,  4 Jul 2024 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061396; cv=fail; b=s6ZIz1dQFV5Ak4qTrPn6b6pra+MTb4g+0zaQAmaNTJYQmyABCCjxZIY31EC0WRbAP/NWNwDWcmRLSt/1P/o5ZxkXPDMHzTRtUNcIBF8AhLU7Jqwz+UecWUS8vb/WuZ3uLVARzYaFV70ca11OGlgY7EX0rh7goiL9PdXIYwjEnoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061396; c=relaxed/simple;
	bh=IDpq9s47WJDqPwfb4/oEItiFV0eJFtgJ04UTu2reBuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bqR5j1A1zr6ONog9mQrvX46+GSXaDLTQhihxlfUY50YJzuXHZF5HN4CCaGe4FEZ4skkJPe75WNegw7gSxlVjbEE4kd5vvGwPcVgPzUxfWIYzjDfR2QUN8UdP9o6tPlKdQHEHZ0W/mCvfLV+s8n8ukn/wzz3fWpx3QpLK/MzU1wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wqhs0lNE; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfN0OuvITbpNmZCPMhXtFH4OCmim//gLrsXjbc4b7bilOcgpwPvAf3FWDx3+E3IDmY51HV5BikDg7TyoMqa0s2v9O7QYUfBz0OKwQJ5v72b/27UCXy+HLerFCS6qry4VMUrM7v3JalTgWNrdLcuVQdAQjDc7t11DCeI0UVbjet08GfiMYkzdiLbBJPb86qjtv5YFfDZBzWKUA4SkIaQA6MP8bYi5jEPq3b5hH4uuiaMWGkGJhEBOZJGhLZ9Pfms1SokbaoczajOr/OCHx6a0BtCe2LnicxwRC0qsd2nAFU2JQQG7kKxLddHzhK+Jb0YzVosDCEkbQFLafHyh8HpVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM6ANRY0vwn0I+zlQN6GJY9r4xktuYBi9SazvCpXtoA=;
 b=fGaqxQQrZ6QDCg6eEkyMER0d+uv0VVq65qfLuOqu6JbPeloBYfiovciczcc7JscOTEI5E4ru9Q6kctuVYdYLegkMtVYBH/7P/2pCW1tqm6+uIXea+Lt0cn/cv8DY8Z7eiibhqZfVoTEYWDBhA82uRa9nSzjFzOMn4597vOd0diTW1L9Bg4/oFmjkTPOmvKkf7Fq1+94oFlT/fuAIjRc94AWEnRog5zgNTtPjk8+Z1fNFaELH9DvNt/x8j8QG9bs7M+OIbepofhLD64JgXTyF6833YX8yNGTlcprkNR7SswVAMpAmZUnqvNj8Z/MiARMaqBouiKzom+AmINzX7q/gWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM6ANRY0vwn0I+zlQN6GJY9r4xktuYBi9SazvCpXtoA=;
 b=Wqhs0lNES/sZ9ZBW0YQmaZN9LG/hBPhgcXrfWZIm2D7nJ2zzWLFV7vzAuHLSxV2mj/hOt8UmFFbTOoc7opYPhBAof7BHpJokPffZXGPlwkcj8/mr7Lg14DGGC0fIMtdKe3YIR6LWqchQFoFpaYWiO4C7Hp6Ma2BC0pTspLbDdSZVc3nmMlZKXlt0UOVse2dSTykgynX7/U40PDRhShUMcpeloVBveD31KSdko8QkL6Kyh7HUtGPHF/b4BN0xgg0rvmStadjyhA+vnac3bd2fYFanuhBaymmjvC1l3KmjvQa8bQ/p+x5QLyHhf3464L6yxpxp2mZ1ujKbuSjJic+VRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6711.apcprd06.prod.outlook.com (2603:1096:820:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 02:49:50 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 02:49:50 +0000
Message-ID: <ee87cc64-d602-4ee5-8545-dd19407241c3@vivo.com>
Date: Thu, 4 Jul 2024 10:49:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Chris Li <chrisl@kernel.org>, Dan Schatzberg <schatzberg.dan@gmail.com>,
 Kairui Song <kasong@tencent.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com
References: <20240702084423.1717904-1-link@vivo.com>
 <ZoRUukQUNqGHn_x1@google.com> <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
 <tlnxo4rawxryyzlpiqhjaum667q2arecgp2u4rz2s3gcsxyaqo@qeffvy5ezufc>
From: Huan Yang <link@vivo.com>
In-Reply-To: <tlnxo4rawxryyzlpiqhjaum667q2arecgp2u4rz2s3gcsxyaqo@qeffvy5ezufc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e6e6a0-cb98-4a3e-bfe9-08dc9bd3f8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU5uMlhqVjhzZVl6Q20wZ3Vsam95MFlCbng3VVl3dDg3ZmVlZUUyVmczSk05?=
 =?utf-8?B?dkptL282SXZlRUcyYnFEeEMwVDJqcHlPWnNMOFdNSHVwa2paSFEyL29vVFdL?=
 =?utf-8?B?VjdLU3ppUmh2bEtGYkgvT1Y4ZWtTZkJhb0Nya2kxLzMzZmhXMUc0aW42RWsz?=
 =?utf-8?B?Sncwb0pnNGpyYStTa3haZUw4UFVYU2pNTkhET0ZmcFdMTXpTNC84eU5GdlRC?=
 =?utf-8?B?aE9VQjFQTE9jUlhsMWIwNVRiWGd0VG95MHVVVit5cWoyQXhjSTVyNjQvTldj?=
 =?utf-8?B?c2Z3WEtIUE9hZzRpQjVFZDZ4UytaZEJ0VEMrL0pwY1c3N1k4QSs0a0N3Y05S?=
 =?utf-8?B?MzBrNWUxYUNZcDFMK1c1RityRGRnVFNESFgwN3NIV3NhTjdyUUVjRlpHOEJV?=
 =?utf-8?B?YmJBdXJrZ2UwMjg0MFF2UnJBenVscXYzTFFUUXZnL2RaS09uY2VkRHZ4MVFT?=
 =?utf-8?B?OVhNMVoybjVFNnFoWHBEcDZqWSt1MHIzWHdWb1hLOUVkMDVCeDJTUElmMDJu?=
 =?utf-8?B?N2JBVHlCcEFhZ2hxRlQ3NVBFektyWFdLa0RaODVldnNNa1RTcSswTmE0K2VZ?=
 =?utf-8?B?MTg0VkZmY2c4WHhIS0ZTRUFQcUNTZGJBVE9hVEx1cHZBRm1OSWluNW5OQVhP?=
 =?utf-8?B?Y2ZReW9UMStVZ3dFYjM5OW8rTStmM0w2SWxDT0VLK2p5eVRFVTNmNnJGTDh5?=
 =?utf-8?B?RjdDRnFDQnYzem9ZL2tWQ1lGdFZZTWVxV29YNVhQK2FRQWpEeHUrbDNUU1dS?=
 =?utf-8?B?MDlCcDhlTjYzQkppQUkrY1BqTVROWU9sdTQzZzRUSytyc3Q0VGZ2clVONDNC?=
 =?utf-8?B?ZC9NUERUQldiN3BIcFZYS3RrN2c5MFpVdnN3UmRXSzZNZlhkL0YxcFFkU2Zr?=
 =?utf-8?B?dy83MGRJVkltektzNFlNQnR4c3R6ZkJOdFJ6T3hwd0k0cUZXUXl2R0paWElw?=
 =?utf-8?B?UXF6bU01aTlmUVBia1l6Nzc5ZVhBcEJEMkxZdkIzaS9KazV2NzVtdEdEcm5u?=
 =?utf-8?B?UGhIV1VNWWpSUE4xZThwUE1SVnZZbldyVWpoSjhVRXZpY1Z4QzM5QVZHUnda?=
 =?utf-8?B?WUlBRFJjbkEwVGlBNklGMFE2UVB5YXZRMVFqdUtyU1hycXlpQ1hzc09jWkgy?=
 =?utf-8?B?ajFPNmJ5b2xiaTdobS9TQ2hLbHN5SjNQcGRBSzc3L3JmdVRqd0p3SzI1TVBs?=
 =?utf-8?B?TURaeUxvUTRCM3RBUDVvZmFEcllvYmJ3YlNNWFNzK0R0TWdUWGRUK0drK25l?=
 =?utf-8?B?S2p6Z3l6TmI0TDU5Z1hYWmpkQ3hTcXMyZ05CdHV2R1gwVEs1SVk4RGtCOVZy?=
 =?utf-8?B?SjVFNkh2MGJvSlNuVVRCMXRjOU01SWExTVROd1p1K0FDTnBDRGdnSkFkNDBP?=
 =?utf-8?B?czVJS2VuK1Z4QWFxNi9YZHYvZVpoQ05sRzFCc3RJNzQ5ZkRmazdvcml5dWg5?=
 =?utf-8?B?a2RBZnpDVFBTWkJNSFJOWXhpTnR6aWx2TDdYa1BaZVQ2NGorakY1TjRiSms0?=
 =?utf-8?B?TFBaWXhWa0s1a2k4ZE5qVnJQZzV3aGR4Z3ZSbFhzbzVyWG52SEZMMk9jT09V?=
 =?utf-8?B?ZGJsaXAvZlI1WFo4dDU5eE9hWWt6dmJIZ1dkWDdsSW1MblU2NStBN0U4UUpQ?=
 =?utf-8?B?YzJ1d2trK2xDcEhqcWxoSFBrVmZiT2paOUpWZHRHdzBTbTl2T09KZmVwNXRs?=
 =?utf-8?B?M2trcll6SzZPMUd5dU5Dcml6M3N6Tkh0ckRNREphZnVoaWltblJnekNXNks2?=
 =?utf-8?B?NDYrbkhYMnVnNUVOWW4wbjNTRmNnZXVDZHMzOWdLQXpzb093SVJCdkVVdWx1?=
 =?utf-8?B?VnpnbXZGZkI2WXlHQU9DVUZ1cUtJMVluQVJEUzFDclZxOEJhcTlUV1NMNStY?=
 =?utf-8?B?aTh3VnFQdytZY0N1bmEzcWRsakhXZkloTEhnMzkzeVdSSWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG54WTdsYW51TlNGQWxpcnYwWE4yQXZNeHZ2aFhLeVBzcElHdjVDZHROdjkw?=
 =?utf-8?B?dm9aVzU4UkRqcFJ1UlplcVNaa1M0T2h5b0pGd2dmWGkyelYrZTRaSzZzUTZl?=
 =?utf-8?B?bktEOXhubklPQ2RVM1lKQ2NhdDEzK0M2MXBUUU9IM0JleEF4dE1zeEV0Slg0?=
 =?utf-8?B?VnhsNCtiOWFDMWJDMjhXaUxQTGEvQ3UzUmhyWkJRM3F2Qit6ZEswVHR2WXVF?=
 =?utf-8?B?SXJ0ditncDR6TjZkbUlWbVArREY0c08wMHRkb21wQkxSL1cvOENiZzJ0Qm9J?=
 =?utf-8?B?OEdQZVo3YkZLUE1NanFDSU8wTlhYVFZ3blJ4ZTNMWGVZMWFjMFZ2UnpzRnk5?=
 =?utf-8?B?SDBSTkxocmpDdmlzSndNaVR1OWgvcCtSWmZWRkNFTnUzV1ZHWDRuZnB1aFlr?=
 =?utf-8?B?MFBoNml4OUJvZGpIdE1lTi9VbmVZZnVpa0dNVCtFT3o4WllUN2xMazk1bGJ0?=
 =?utf-8?B?TWJxdmpLUVFZMXRSUUVTZ2FQNGF0ZFNRcDFFNkpZTHUwbnUvclJiaTk0NVds?=
 =?utf-8?B?OWZNdjYxNk9rdURtQXc2eC9NOHo4RU1ONEdJSFpOU3lJQ3VOVmFDanlzR25C?=
 =?utf-8?B?ZkhOdGFZejh3YUtwSWtGem9DOEFMT3U0N0dmOStEY0JxN25JRWxzd2ttb1cz?=
 =?utf-8?B?WExzaWhCd0IxcHhRazlSd1lCakM5dys0OGF0dE5IcHpycTFNVUt3S2dsYWZo?=
 =?utf-8?B?V1BCcnVsaHA1QnVpR0xraHZEV1lmdmsvZkNnTkY0YmR1dEZQVWRmOGFROGZl?=
 =?utf-8?B?V21xODRHdktVOG1LL08vU3orNXN6Y2JGUG9qU3pyemlyT1lKL2JBbTFsVHo2?=
 =?utf-8?B?TVI0WFFERDhzejlJakRNMS9FbHVTc1pBTW9vTW9BVUR1ZHdoN0x0OUtaZEpu?=
 =?utf-8?B?WVFqcEpFT1hUTjZaU2MzVG5YV1E4SVNKbEJ2L3kydEpGTlFaMXV3UGRERmZh?=
 =?utf-8?B?SDV6OFdtRU51WjA4NkVVazd3dUxHSEt1Ri9Dck44SitkL2ZxaUIzNklVY054?=
 =?utf-8?B?V0c0OHYrYzJTK1ZsUDA3QXpwNW91b2dHbzNJOGRkOFlYd0pldzMxYTVPV09q?=
 =?utf-8?B?Rk9HRGhIb1czRTFuWk5DZiszaytPdkJ0SXREQ2xNejRORzBjdC83OTJTMnQr?=
 =?utf-8?B?WGEyRnA2cXNURVRUWThKWkxUMTJPTWJDWmpVYWIzT2tjK0xNK1RMUXpLL0Iy?=
 =?utf-8?B?YUkxNHdVQUhTaW52eWNtU1BsblFJOFJ3MnpLd3ZJVDBRQTU3YjVsaFpObzUw?=
 =?utf-8?B?YmprUHBtMnVPZFRiaEpUdFFQTFk0aFhaamppNWVpcXdRZkh1enlDeFhra2R6?=
 =?utf-8?B?dFlCYlZ3cExDS1ZxYWhraTRLU3duRkhETndQQjJkOFBMT1pQakZMZ01VaHov?=
 =?utf-8?B?SHNXNW9aRHU4MGg3dUFQTGtFY1FVQ3JvNVQ2cUxZSWZUNHRLK2FYMkdiK1lk?=
 =?utf-8?B?TXhCeTlPMUJpalV5U00wUWNFT2t5T2xwa2JnZC96cW9qNjQ5SVlPS00rdG1S?=
 =?utf-8?B?NjNzaXFDa3hZcTlyNWhuWU5ET0x6cGd1MGpzd3lBcENDU2ZXYzAreEJDZ1JW?=
 =?utf-8?B?MFF4Z3F4eEtzd0pyTDFuN1FJdmYwbHdVQkNTd2cxT1B2UDBJL05OWW9vc3ox?=
 =?utf-8?B?ejQ5YW1PVEU5eFpidWdwT2RqTVJEYTRJWlRPZGxTUWJRdG1JalFLbVN4UHFR?=
 =?utf-8?B?dmJkVEVqTXJYVVZzZU41OWV3T2lqRDQ5QVdKeXVyWXRwdmU3a3luV2Vpcndr?=
 =?utf-8?B?Ym1UMHVidWNCckgzeVBmZ2xuWU1CN2ZLbi9hU3ZqQndtbldKSGRRR21JMDVC?=
 =?utf-8?B?bnVSMlhoTDhKSUhRT21TWUJ1dCtabzVLQW9zZ0ZsL01vdWtOTEVLZUErRzdE?=
 =?utf-8?B?NUE3N3pPYlN4Mi9iM291TEVzVXRwVzdhd3hWVUNpWlJJZWtjUkE0bXRBT0FD?=
 =?utf-8?B?OUpydGRONHNCUVMyV21EZ1IzQWNGU0Jjc3JmT2dmSElWVnpMaGJ3aWNraU9C?=
 =?utf-8?B?MEt3STl3cmFzTE8zbkpKb2gzZ3ZSVjFZV0xORGNCbG0yN2xWRm5pcTBLdTEz?=
 =?utf-8?B?cW5aMUJEcjAwT29hbEdyMDRQeWYyQzdlaWZXQ0JTQm82RGNuTzVEYS9rS0E3?=
 =?utf-8?Q?aSfdLLw+mCZY/rvbbDZHfuQqe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e6e6a0-cb98-4a3e-bfe9-08dc9bd3f8ec
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:49:49.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aqc8EgTzJ+d6w/OqAoybP7G28FHsDNgnvBqB/vn3PftWiXVbRNnDDTfR5MrV8hd8zxShFa5VBo+K69GqzPaKiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6711


在 2024/7/4 1:27, Shakeel Butt 写道:
> On Wed, Jul 03, 2024 at 10:23:35AM GMT, Huan Yang wrote:
>> 在 2024/7/3 3:27, Roman Gushchin 写道:
> [...]
>>> Hello Huan,
>>>
>>> thank you for sharing your work.
>> thanks
>>> Some high-level thoughts:
>>> 1) Naming is hard, but it took me quite a while to realize that you're talking
>> Haha, sorry for my pool english
>>> about free memory. Cache is obviously an overloaded term, but per-memcg-cache
>>> can mean absolutely anything (pagecache? cpu cache? ...), so maybe it's not
>> Currently, my idea is that all memory released by processes under memcg will
>> go into the `cache`,
>>
>> and the original attributes will be ignored, and can be freely requested by
>> processes under memcg.
>>
>> (so, dma-buf\page cache\heap\driver, so on). Maybe named PMP more friendly?
>> :)
>>
>>> the best choice.
>>> 2) Overall an idea to have a per-memcg free memory pool makes sense to me,
>>> especially if we talk 2MB or 1GB pages (or order > 0 in general).
>> I like it too :)
>>> 3) You absolutely have to integrate the reclaim mechanism with a generic
>>> memory reclaim mechanism, which is driven by the memory pressure.
>> Yes, I all think about it.
>>> 4) You claim a ~50% performance win in your workload, which is a lot. It's not
>>> clear to me where it's coming from. It's hard to believe the page allocation/release
>>> paths are taking 50% of the cpu time. Please, clarify.
>> Let me describe it more specifically. In our test scenario, we have 8GB of
>> RAM, and our camera application
>>
>> has a complex set of algorithms, with a peak memory requirement of up to
>> 3GB.
>>
>> Therefore, in a multi-application background scenario, starting the camera
>> and taking photos will create a
>>
>> very high memory pressure. In this scenario, any released memory will be
>> quickly used by other processes (such as file pages).
>>
>> So, during the process of switching from camera capture to preview, DMA-BUF
>> memory will be released,
>>
>> while the memory used for the preview algorithm will be simultaneously
>> requested.
>>
>> We need to take a lot of slow path routes to obtain enough memory for the
>> preview algorithm, and it seems that the
>>
>> just released DMA-BUF memory does not provide much help.
>>
>> But using PMC (let's call it that for now), we are able to quickly meet the
>> memory needs of the subsequent preview process
>>
>> with the just released DMA-BUF memory, without having to go through the slow
>> path, resulting in a significant performance improvement.
>>
>> (of course, break migrate type may not good.)
>>
> Please correct me if I am wrong, IIUC you have applcations with
> different latency or performance requirements, running on the same
> system but the system is memory constraint. You want applications with
> stringent performance requirement to go less in the allocation slowpath
> and want the lower priority (or no perf requirement) applications to do
> more slowpath work (reclaim/compaction) for themselves as well as for
> the high priority applications.
Yes, The PMC does have the idea of priority control.
In the smartphone, the most strongly perceived aspect by users is the 
foreground app.
In the scenario I described, the camera application should have absolute 
priority for memory,
and its internal memory usage should be given priority to meet its 
needs.(Especially when we
set the PMC's allocation after the buddy free.)
>
> What about the allocations from the softirqs or non-memcg-aware kernel
> allocations?

Sorry softirqs I can't explain. But, many kernel thread also set into 
root memcg.

In our scenario, we set all processes related to the camera application 
to the same memcg.(both user
and kernel thread)

>
> An alternative approach would be something similar to the watermark
> based approach. Low priority applications (or kswapds) doing
> reclaim/compaction at a higher newly defined watermark and the higher
> priority applications are protected through the usual memcg protection.

Also, Please correct me if I am wrong.

I understand that even with boost, water level control cannot finely 
control which
applications or processes should be recycled with a high water level.
Application grouping and selection need to be re-implemented.

Through PMC, we can proactively group the processes required by the 
application,
only opening them when they enter the foreground and closing them when 
in the background.

>
> I can see another use-case for whatever the solution we comeup with and
> that is userspace reliable oom-killer.
Yes, LMKD is helpfull.
That's unfortunate, but our product also has other dimensions of 
assessment, including application persistence.
This means that when the camera is launched, we can only kill 
unnecessary applications to free up a small amount

of memory to meet its startup requirements. However, when it requests 
memory for taking a photo,

the memory allocation is relatively lazy during the kill-check phase.

And one more thing, the memory released by killing applications may not 
necessarily meet the
instantaneous memory requirements.(Many zram compress page, not too fast)

Thanks,

HY

>
> Shakeel
>

