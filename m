Return-Path: <cgroups+bounces-7847-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95494A9E634
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 04:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F4E170AF1
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123D7DA9C;
	Mon, 28 Apr 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lP8Ki22o"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011033.outbound.protection.outlook.com [52.101.129.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B9A930;
	Mon, 28 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806796; cv=fail; b=PDw0RwmTaacK3+xcz3dsUzSO8VhO/RYpJDGoYdaKtG43f95XQ6svxGmNJO6oUULauKDaXAJM9dmsTJJTuFJz4P0ztYgvs5HgQWsFLfkvrbvpoCWeRb/I1Wca6TY5fpspd+B9vuOaK0RrDyjDWayopZISSoHBZSCK5Qf5olv3fGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806796; c=relaxed/simple;
	bh=BlPxZhhlTAPUO2VykJo/yq9k8kuKOeU+bOTg6Q+AtTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJ2WF/UtBLLfjWs8i1MWmULEAdQCRwnKyRgdHe0rWAG0wUVu+VF8rQHPba8KSaSUWwr8RYgitRt5IUCv0LBPqF3muJUZiiKPK7fikhO//iPJ5tqX2g6DCayZKAAMkKVmGifkZAiHnj0M8NEyJjaceSkB/+82Z3BdRN5Of+94mVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lP8Ki22o; arc=fail smtp.client-ip=52.101.129.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIFuZqYGc/fZ9MdjbpLPBTBLAAzd6Egb0VJHBH9y9NQkmqXRZ2mFxGl338ObtjVIVgA94OVatoHgyIPIpXFpeUkotsA0BF1OR270JFvap3SeSbT3Fxfe01OX389r66aJ85EKYTFzBYro+rObvqw5iCjFrz8MwAUpsIH5SiREcGSQlb+qYq+/6VUTrVWC0N11dvwIn6AG9GmkoB8+mnhokB4tSWoJlN0MqOLqHMz3HODfOsqDVeCSTPOuxxNa7ZQRd2HsDrUhe2oRn7QKKLNmwzKfBrDyLJ4Bw6P8ozoMxC69dptHw3064PcV7sVu70aCxUoZjWYMPhCvcyuj99X5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvpNTy6e/Nk/+Fc7XM3DodJGBOUrufKQmhaoEYh1P+Y=;
 b=cNA6gwrgYZ0BCVAKGtn7WWP/ycmncZrLw9rpRnFik3eOMhexkbbX2HKxwNk/GCa+upfzTrjKYYWKXzAlilmKCzbT4kZ+o00HRLee+uqxAB7YuJ4eT6UJonGk8NgYtpX0+XmxD2Ik8n7KLt8ZzSeUVMhYmJZwxE0jAhGf0okmSmP5c+hIANt6K0ziPfGxdtNf4H4PS2KdabZ5hbdIbN2P0JxhnLfYkl/HJKKQo2ppX8kEC4iSPq0YOWh4uzdB/+yDsqjUxcXaIxE0pNfQgq9EyaSiAF05ClgLEMtXUke9cJT9bV6xOCi2PjJRk08YFtWuzeOfS4XMC0Mvu2qkK5oazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvpNTy6e/Nk/+Fc7XM3DodJGBOUrufKQmhaoEYh1P+Y=;
 b=lP8Ki22oXaSDBZRxQ1+DuqYR69nkgqMN8cxbAQ+L+03D2aXjKGmDH+Fim2AbO3fbmMfKFLJwEZUkrNcUvJGRsrFsZxCxoVuHMtRrXeIv3ZI2CpSw3U2W2S/bkZK9Be7p8ySB7b1xCwW2Of0sDncwc32n/1wK6kKnDYLkxGfm56v/xc5CSyRaQfPTiuE2D/e6NO8NUrAp2+SA3Z+CycMq2kUXpE04GqYM5Vq8AT0dUwYf+aD6MU2TGU/+ytJv8QPFqVZunvPINJOaQgQe/D4wk96zGoLjkIzvLawcSGWff3wt4p4Iti3/RcKKGL5FKuWJwtO4queG87xQAcAWOsr8bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYSPR06MB6607.apcprd06.prod.outlook.com (2603:1096:400:474::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Mon, 28 Apr
 2025 02:19:50 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 02:19:49 +0000
Message-ID: <6fe7bb8c-9c04-4c3f-aea8-2d938de123ed@vivo.com>
Date: Mon, 28 Apr 2025 10:19:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Use kmem_cache for memcg alloc
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Francesco Valla <francesco@valla.it>,
 Raul E Rangel <rrangel@chromium.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Huang Shijie <shijie@os.amperecomputing.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, KP Singh <kpsingh@kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250425031935.76411-1-link@vivo.com>
 <aAsRCj-niMMTtmK8@casper.infradead.org>
From: Huan Yang <link@vivo.com>
In-Reply-To: <aAsRCj-niMMTtmK8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYSPR06MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 548c8ae2-2e9d-4017-3cf5-08dd85fb270b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzVscVVxY1EyVWU4ZmJXTktwVlpVNG5IVzEvWlNqSGlsT3Nlckc3KzYwWERG?=
 =?utf-8?B?THIrS2JiNzVUZGtLSzMyS0htNDF1bGRseWdjY21BU2I0YWJUK05JRHFIRmln?=
 =?utf-8?B?cVNCOGtTZEk0R3NvalNaeExaQXBzME1TYSs3OGxla3dvaGxiQ3NkeitXajhz?=
 =?utf-8?B?QmN6ZExISzhla0hQd1NYT1RwM0ZVL0h5L2lwOGVFVFRrbkttZDJFcDlJdVUy?=
 =?utf-8?B?SlV6ZjFmNkk1TjN5U3NRZnhmcjVCWkllTDNwVEozWjU1OHZ6bHdHZnF6cjda?=
 =?utf-8?B?M1pEeVI0VWorWmFmNVgvWjF5ekdrQUxybXNGSDY4QWhpNFI4aS84M1RLZ01Q?=
 =?utf-8?B?N2U1eC95T3ZOeVNkUUZHNlBvc040NDNNUUJCQm5hUE5Pd0phYXN3Uk10Y1Jy?=
 =?utf-8?B?TjhweklnL2p1ZFFES3hWczh0cWsyNEVGQzVaanBXSk1Za1prMk94V0o0REpr?=
 =?utf-8?B?M2FTVUFkbnVNSnZySVNwV2hiNVgzK082Mit1OEk5OFRRTmZQUER6YnZEeHk2?=
 =?utf-8?B?RmVrYzlRcDRoZHhpSHcwQ2lROFRwQzIvQmdzb0N1MGNlbjRUWk1peStEUUJk?=
 =?utf-8?B?V3ZxNzBsOHNlWTk2OUNsWnRhYlBMQ05uZ3ZncUNSczN6Rm80U1NTQ1kwWE1s?=
 =?utf-8?B?RnZIWVBxN21rMUtBUEQ4aTB5SHVnOUZhRnoxTW9tNEZTQVZwOEh2a3RsNUE1?=
 =?utf-8?B?TGwrbG5hcnJKSDlsSVFpckFnOUhLbGl3R3YvTEJyL2hPMFA0Mys3Q3IrbzF2?=
 =?utf-8?B?bHBFampsUWJ2QjNXT0xQdGlGenR1b1JVejhDTFo5eEpOUFNKQW5qYTBNYXZX?=
 =?utf-8?B?RWlERWNhQ0tEMzdudFRYSjd0MktHay9CZ2lPWXU0VHh0VHorMXJkbjZDUWdK?=
 =?utf-8?B?c3IvbUZwWHhNOEh6dC9tRTcrVlFqTlJoQ1phamRIL2dBNUNQTEFZOFZnTTR6?=
 =?utf-8?B?ekhZeDJUbUpiMUVMaEx3ZWVUYmZ2Wm1RNVJvQTdmS2wvWkN3c0lRSHJMOXQv?=
 =?utf-8?B?VWc4cklVZzBGWTZ2aUJUeWFxakdYdmMybVRGbnlnMUZ2NmhiYm03dkxlV3Vy?=
 =?utf-8?B?dHpWS3c0dk1yNHVIRzZJWnFhUVgwdmJXc1FBZG1EZUNjV09UM1FKaDFBckFw?=
 =?utf-8?B?YTN4dHlsZTF4YU1xd3hSMFJqTEE3UEd0bEVyKzJJa0Y2ODQ0VWd1N0pvVzVI?=
 =?utf-8?B?Qm5VcmRYbVJZanNRTFdlTmJra0lGejRCTk8zalF3WmVSaGtOYlRqQ29mMWJO?=
 =?utf-8?B?MDVNQ2J0ZDVaT0JQSWx2YUo3bllMVEZaUGhXL25WMkVHN3c4MjFWTENkZ21i?=
 =?utf-8?B?Wkd5TytuTGdKYm1YN0VuUUhCMGxKV0lUTDdlWmlRaUtkc0luYkhkaHNpQ1hO?=
 =?utf-8?B?ZytveE5COU9PTHpGdlRuSTJiTUluNWkzOFkwUThGQityMmRKallIT3JaaTNP?=
 =?utf-8?B?WGhDNjRJVVVhc2tUaTVBS3NSVHRrR280QVlMUXRWREFvd0RRWjRweDlLcENF?=
 =?utf-8?B?NU9VazJpcUZIc2w3NHVBejlOK2Nna3JXaU1Jc1dhekc2dXhueVAwZGljdUJR?=
 =?utf-8?B?d25aTTZrelBDTVJDTG80RkJTRldnWWFTSHJwSnFXdk9HVGw4anIyWWdENkNi?=
 =?utf-8?B?OTc2SkFYbEhXcjRXSnVqeUh1NXZMSy9lWFRzNEo1R2toMFJROHZvV1JZZEVs?=
 =?utf-8?B?c3RaWnl0Q0NZdXN0dGVpZnpMYXY1ZUZ4bHB2TTN0ejcySkNCemIrNHk1ejUy?=
 =?utf-8?B?T0MwV1dUZmxVcjNPY3BrTGtFR04xR2JTZ3FyVXNyb3Rub09CREVzUS9zNElZ?=
 =?utf-8?B?SCs1UzBCa3lHZyt3amFXV2ROckNkUEc3aE9TVjdnMHlJbjhEYVFlMjJQdlU3?=
 =?utf-8?B?VjdoZnF0SGdIOGErcCtDUnhKaGkxa2o1aHNJNHhibXlCY0IydTIrRXZobmpw?=
 =?utf-8?B?amVUaDNYcFNZN0FYTitMVXFZV1Rnb0o0T01uVndoY2J4Yks5NGIrRWROeDQ0?=
 =?utf-8?B?VlkyNzUyNFBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3o2eVZ4WnR1dXY2N0dCVTJtbEI0bUFnc0d6NWEzYjd1NVhjbXFTNVpwd084?=
 =?utf-8?B?a1QxWHJHQXJUSnF6dnhSNEtRS0tCRkV6eFhXVURORUxFOU4yKzRNUXA4Z1E4?=
 =?utf-8?B?T2JuTFFwS2tsdVdMT1B2OE43b0pIRXVDWjNzMGtreTB1ZlFMSVlpQURSWE00?=
 =?utf-8?B?VzdlbVdvNlkzSXQ3TEZnZmNRbUxuWDErei9IaHBnV0c1UURhWXpGU1IxYllu?=
 =?utf-8?B?QUFvU2dvdG5BdC9wc3l4ZFVuYXpITURKcTNQUHR6dlJ3QitYRjlCUVFJT1Vp?=
 =?utf-8?B?RFFHRkMyTDZWUkF5NFkxRlJSaU8xRGJEUzk1VGwzSHg3MzlwbytaU2FVb0xV?=
 =?utf-8?B?b0hkUy9aMDVmOHN0YkxoTG5wREJKYXE3ZUJDclROT1FodWRxVDdXQkViZit4?=
 =?utf-8?B?NlRRSzBhVzd6QXhpRzhUODdPRXBkOEt6ZXE0OGovRDhIN3VSaDVOOEEzSFRX?=
 =?utf-8?B?TmI0eWRtL21tbmNaSTZxRlhYNU5TTmpZQmU2YThCN0NLUUt0bHlVZUxOVmIy?=
 =?utf-8?B?MGk0eU9ZT3llOVdPNUdrUzE5cE5xK05GTVJQNzAwU3pWTi8yMU9rSHc2aVUx?=
 =?utf-8?B?clNjUU84YmVFcXY5c3NhdWhDQjRXS2V4aCttSHpRMFVEVWh2M0RHUXl5RmVR?=
 =?utf-8?B?MzFHQi9iQWhmYUg3b2NlaFRxN0FHcWk5YTY5NjlYV1VwVjlXclI5TU1XZ0FZ?=
 =?utf-8?B?cWk0VmZ6bVZESS9zUnFaR3k4MTFGK01GRXd5Mk95QzNwTkY5ZU5UMWxRNi9r?=
 =?utf-8?B?L25RdW1HSFVCSHdWOGdSWktQUStDcEl5MjJwbFlNR056dSthSEwxZWFNYlpX?=
 =?utf-8?B?a0pUNXo4NlFGRHpDbURENzdkb29yL0JLSEdyQ0NnRGZnbk9GVUxXa3NYN1c5?=
 =?utf-8?B?bUNmNVV4cSs3cjd1cU1qSStaaUdQRDVMcmNMc3FCV0NGSEROL2Q4Q2tWU0ZU?=
 =?utf-8?B?cnNZZ1IyMERZYVFSR0hoaWRRdjZoR3lXbVlZYTAyV3dNdHpXZXRpcVFzWExo?=
 =?utf-8?B?bWUvU1NKOUFrTk5GdjB3Q3hTTWd2L3lvSHhRN1JmcHM0T0JjMlZramN4UWNv?=
 =?utf-8?B?VjJjelRQeWIxWlVtcGlhYWhzZ2ttUnNackgvSWErOThZMmZuSWR2TzQwcVk1?=
 =?utf-8?B?Ri9SQkZoeXprWVVqUm5WUHFRaWUvcUZwUmVoSko0cTgyTnhsblFyVW0rK2Fv?=
 =?utf-8?B?eHBkMkhRKzEyL2MvZ2hRQkJFM1o4QnpSeS9LODZMbW1NVlhRa0N0YnhicUhw?=
 =?utf-8?B?R1pCNFZCSkxSZFlJbHEybHUxbEwrMVBmZHA0aG9IYTdZdU5TUXdCNjVWNWo1?=
 =?utf-8?B?dmRyWG52SGMvdXRFRzRoU2lzR1kxSVNzMEhqcy9xa2srNWFpaGNyZE1vd0dj?=
 =?utf-8?B?czhuK0JLaEJEdlRFMVU5akdSTFFGTVRkQzhJRlg3MWQxVElrR0hDVW9NN1JG?=
 =?utf-8?B?SnlBbjh4QXFOUi9naXFreW9rTXpldlJTMmd4ek9uQnhrR09DTWE2Y21FV2JH?=
 =?utf-8?B?ZlFrOWJyTkk1c2Evc09TVDFCQmQxOGk0bldUTVJZOXZuZHpjNjl1L00xc1N0?=
 =?utf-8?B?eUVVKzRsVUZvcEFLMy9BMWFadER4ZkNHSkJjZm9aVUhkdWlqejhGQkVKRVBD?=
 =?utf-8?B?V1hCU3p0eFFJeGJqYWhpQzRqTXgvTHhsVVBzT0xkd0VGZTQ2YzBJMHdKaDkv?=
 =?utf-8?B?VEtTcXcxR3o5UE1VaWdoVkxMdzFTeGtFYzY0SmhKbkJKcDhmM2V2ekVnN1J6?=
 =?utf-8?B?NU5TNDVUcDQyRWY1bkVIR3JmK3lBTEovc3FXekk1M0FrSUNUT1FkR3pYTEJK?=
 =?utf-8?B?MVh2dWRaRWRtMGpmbTI2RE1mWGNoaTcyN0pBa0FjdTRDdE5LS3JpYTA1NWRX?=
 =?utf-8?B?N1FCdlRRdTgrV0tzbU5KTkZhZWJNaXZNYVZUeGFLUllNeXNJSEFSTUlMV3d2?=
 =?utf-8?B?TDRPb0x6R1RKOXBMS3JpaTdiZk91RW9OMkRabkJyTHBPYmJJbzgwR3RkN3Bz?=
 =?utf-8?B?Y0RkVE1yekVmdlNCMVI1WnFsbUFabWc1L3ovajczZWorN2JpYWdDdkJKeTdm?=
 =?utf-8?B?S0pBSHl5QWFhZjF4QXZHOG96V0VIVGc5c1oybVhzRXljOENoV0wrS242VU9w?=
 =?utf-8?Q?P3gG//RwkYYxGmBtjSx8sX2en?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548c8ae2-2e9d-4017-3cf5-08dd85fb270b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 02:19:49.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bLGRw4tbPKTqs0vZ/coY3JCBkRjYv77EIkanBEQru+ZpyXxgvPDApoV2wtWvKB3X5JPOHRN7YszjHGiGzOUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6607

Hi Matthew,

在 2025/4/25 12:35, Matthew Wilcox 写道:
> On Fri, Apr 25, 2025 at 11:19:22AM +0800, Huan Yang wrote:
>> Key Observations:
>>    1. Both structures use kmalloc with requested sizes between 2KB-4KB
>>    2. Allocation alignment forces 4KB slab usage due to pre-defined sizes
>>       (64B, 128B,..., 2KB, 4KB, 8KB)
>>    3. Memory waste per memcg instance:
>>        Base struct: 4096 - 2312 = 1784 bytes
>>        Per-node struct: 4096 - 2896 = 1200 bytes
>>        Total waste: 2984 bytes (1-node system)
>>        NUMA scaling: (1200 + 8) * nr_node_ids bytes
>> So, it's a little waste.
> [...]
>
>> This indicates that the `mem_cgroup` struct now requests 2312 bytes
>> and is allocated 2368 bytes, while `mem_cgroup_per_node` requests 2896 bytes
>> and is allocated 2944 bytes.
>> The slight increase in allocated size is due to `SLAB_HWCACHE_ALIGN` in the
>> `kmem_cache`.
>>
>> Without `SLAB_HWCACHE_ALIGN`, the allocation might appear as:
>>
>>    # mem_cgroup struct allocation
>>    sh-9269     [003] .....    80.396366: kmem_cache_alloc:
>>      call_site=mem_cgroup_css_alloc+0xbc/0x5d4 ptr=000000005b12b475
>>      bytes_req=2312 bytes_alloc=2312 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
>>      accounted=false
>>
>>    # mem_cgroup_per_node allocation
>>    sh-9269     [003] .....    80.396411: kmem_cache_alloc:
>>      call_site=mem_cgroup_css_alloc+0x1b8/0x5d4 ptr=00000000f347adc6
>>      bytes_req=2896 bytes_alloc=2896 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
>>      accounted=false
>>
>> While the `bytes_alloc` now matches the `bytes_req`, this patchset defaults
>> to using `SLAB_HWCACHE_ALIGN` as it is generally considered more beneficial
>> for performance. Please let me know if there are any issues or if I've
>> misunderstood anything.
> This isn't really the right way to think about this.  Memory is ultimately
> allocated from the page allocator.  So what you want to know is how many
> objects you get per page.  Before, it's one per page (since both objects
> are between 2k and 4k and rounded up to 4k).  After, slab will create
> slabs of a certain order to minimise waste, but also not inflate the
> allocation order too high.  Let's assume it goes all the way to order 3
> (like kmalloc-4k does), so you want to know how many objects fit in a
> 32KiB allocation.
>
> With HWCACHE_ALIGN, you get floor(32768/2368) = 13 and
> floor(32768/2944) = 11.
>
> Without HWCACHE_ALIGN( you get floor(32768/2312) = 14 and
> floor(32768/2896) = 11.

Yes, thanks. And, this can easily observe with the following command:

   # show mem_cgroup slab's order, it's 3.
   cat /sys/kernel/slab/mem_cgroup/order
   # show mem_cgroup slab's objs per slab, it's 13
   cat /sys/kernel/slab/mem_cgroup/objs_per_slab

And we can quickly calculate the Page order obtained by the slab allocation and the number of objs it can store:

# mem_cgroup,2368 size

| ORDER | SIZE | NUM_OBJS | ORIGIN |
| ----------- | ------- | ---------------- | ---------- |
| 3            | 32KB | 13                | 8           |
| 2            | 16KB | 6                  | 4           |
| 1            | 8KB   | 3                  | 2           |
| 0            | 4KB   | 1                  | 1           |

# mem_cgroup_per_node,2944 size

| ORDER | SIZE | NUM_OBJS | ORIGIN |
| ----------- | ------- | ---------------- | ----------  |
| 3            | 32KB | 11                | 8            |
| 2            | 16KB | 5                  | 4            |
| 1            | 8KB   | 2                  | 2            |
| 0            | 4KB   | 1                  | 1            |

So, for mem_cgroup, if page order > 1, then have optimize; while mem_cgroup_per_node needs order 2. :)

>
> So there is a packing advantage to turning off HWCACHE_ALIGN (for the
> first slab; no difference for the second).  BUT!  Now you have cacheline
> aliasing between two objects, and that's probably bad.  It's the kind
> of performance problem that's really hard to see.

Yes, And I would like to learn, in what situations do you think HWCACHE UNALIGN might cause issues?

Could it be direct memory reclaim by multiple processes? Or multiple processes charging memory simultaneously?

>
> Anyway, you've gone from allocating 8 objects per 32KiB to allocating
> 13 objects per 32KiB, a 62% improvement in memory consumption.

Thanks, that's more clearer.

Huan


