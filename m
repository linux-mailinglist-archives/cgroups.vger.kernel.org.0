Return-Path: <cgroups+bounces-17814-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qVgSAnTgVmomCQEAu9opvQ
	(envelope-from <cgroups+bounces-17814-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:20:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C8759DA3
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=msOHyUWQ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17814-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17814-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755E430F7C25
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA191372B5E;
	Wed, 15 Jul 2026 01:19:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1B373BF4;
	Wed, 15 Jul 2026 01:19:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078390; cv=fail; b=SJ7q/q7l+gdKVoAXPdrFkB8GaJHoyaAcyuh3GXOWSGNM2QoFq2CewSVh5ll+s+LZHKvpmkrBI34Oz004WcFsh/WRH/usmCSyeBNzNvmT73HEyVrTeTTuKkOpawaM0y77Nky9Zis/aSHO+mTcE5BVhg81YvmQfG+xDYlmjWkzY24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078390; c=relaxed/simple;
	bh=eJUVseiVBfkYhNLBC/9ZzxtJ6o27Im+HCm65V3NzXgs=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=MMC753pxcyuJp8ETL91FzhBMriR5s4mwFgZ9iXG2R5/3WXc7bOv7K0hOXQ9cI4LWx0fpYdINES2ZEuHluf77jZq7VevxRhODWkOxF9ma2en3BpHMo8AGYSTH8LrrqvtwlpF5+3qpWs9GpH88MVMCptuty5jWNAA2Rr4MOAIch4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=msOHyUWQ; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je/hKNHTBpLHnsOx6S+oJV8lQvHOLLwwc2N4WUFfIJIbHwIdm/3bVfH9PndAqxhqpu3rDMzgIxh8lsyNbLfmu1jxavLTaTk7LFW0B5qGQ08DUk+PUgJJN/C9aCQcTisFSqGOQvW9BAsVnlUVd8kiJX3AZfhzEIfHE2Pf70U0Gy3EVLGI4hJKKyPsjpz2oIlQzIam1I8LPU//f1oIg76pmy9Zfh//GlarD0ZGVjGiKNOSzmZ3tevAWBU6GnMIJ0Ysn1SX4TPbKH0BZZwp+L6Cfby4ZmQnBpaImG31do/TCP2hmkX34TpDW3KlBmrzhLUc8epS3+RJnjEd0JMB1jRQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7kv0C9arQX3Xqpz/8MXasR/eKOw414MGN/BpW70eMo=;
 b=Zwz8MambdEZmvgUaT20Lhw7jpk6xK7wBcrFwTVvwB3YlpZqLJB1gfFW6Htgf9ZmTElo7sDgYrV4B6ayMsJPY8WQ7SbuHHmt8oVUsWygaDGqw9N3IXmzqZq10NX5947cx58p73l2j2MwPnL8270yvqM1fTKGFRQwcXmo2Ug5dTMm4ADfodld0Kn1+31e3Vemh56KPj8zWgq4PESgIFtm8m/sJ6FZk1bkQE7Pq9sMvTTjtX+pmK+kvQJs427Jp3g0u1FEfffxAV0zjUDtPt9NnpfI2QjgpWxCfmjUVT7EO1a3nPGYjNSw9w61YCiVYzxuVmrBQyCtOC6mU80vYlIImhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7kv0C9arQX3Xqpz/8MXasR/eKOw414MGN/BpW70eMo=;
 b=msOHyUWQqUyj4oYy8XuWXSPW4+MGdxaFKNJBEak53pXylmiMM2v8bBB0aQq5e5iEe66WU86kfmx8VzDpeuz3H+jm3fWhOlsDScZpFDvvXXMHmoGXAfXvPCvuiwYqENljUZKDJG40kTPhtkubpjUQU3nHCPhqyNM/JF1kRx+7fRXOyd8J75FE0skuJZOMi94upnKvZlpyWAtyb2NL25W4hujW00z9vyuTj8DHROwPWfZslGf5Q6qhWtTck77MiCFCCxX+S1oxPysKP3RqsscgS9vwokv68XUDu3AHcdhO6v0rK7z5o8rnNIMnm4Ng8Uxy8n+iQauBzYgm95oYFI6/ug==
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Wed, 15 Jul
 2026 01:19:46 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:19:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:19:45 -0400
Message-Id: <DJYR07PU34ZE.SHSPHMKZRBBZ@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2 4/4] mm/page_alloc: remove a VM_BUG_ON()
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <cgroups@vger.kernel.org>
To: "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Waiman Long" <longman@redhat.com>, "Ridong
 Chen" <ridong.chen@linux.dev>, "Tejun Heo" <tj@kernel.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: aerc 0.21.0
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
 <20260714-spin-trylock-followup-v2-4-3c20ed032b14@google.com>
In-Reply-To: <20260714-spin-trylock-followup-v2-4-3c20ed032b14@google.com>
X-ClientProxiedBy: BLAPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:208:329::18) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6c049d-a8dc-42a4-be82-08dee20f285a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	PS3RIIF0n8YrPVJFi1vbUZS2xAuoJsaFqTocTKdERiHWwHO6tl8Djd5a+H49+t+b6RXHySR+C0tbhplc9ini74LSSTHYpQJqPIe1Y6v0+sr8T32sLzSiInJOR8FLu8lK5MZoftVpEoLDTbwWuGI0jva22Qr/6YQlvgwe2f9/9NLWqmZvPcWwd+qY60qooqfzjz4Q4KGKqqzb4boTtHBqTjNTkJvBQ1SAdSXarhJgH4Fb4PivTnEQmOp/4pqEV/d9ActssIye/ylM9Bzr9i3YwpWIMS4JYlF7quOd2oaRfCkvT0XUkQWo7nSU8qXOE7/X+J5rzQFYk00pTjXfYs0/l8saLywY6rnoH0tgPINy/Ljr6jgswzYS7KrdiNJI9cAvCuFFkt3XR9uBrZt0tj1Wz8pMqPoELtMqXFtuAvibx6LR7sKxzdkXgVhlnO+vkZ819Fyx1QtNty66LkpBGCWAaQWt/d1SyzeymOjnDyBmEklMgeCbkaIBJYseOrNYUd4kZAzfRSwW+Zorb6+c8thUgwvx5wCWmRyols+aDyar35I8z+8QfEAM8sD0DOg6no1sN1AjpvP64O+FyBip06tvmwTeaNXQw2YCf356aI1fA4eOT/dSe60bbuPQjGAjCtxerDJte+fHSE23v4lyK4opCB99kcaVSI+Oe0ZDdpgT59J9SH+bQfrXELeZ7MJYbg9lK/ktomaRm6wB7PvqQhTfWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEhZU2c3TWliTTNKVTFZNzNuemp0VzRkS0NjMkZJZ21QNkF3U2hPbmpmM1JW?=
 =?utf-8?B?ZzZzUURmZXpBdmtrRTJrVzZOeVdscUFsaEoxOUhHQWVhYlFLMnBRb004Ymgv?=
 =?utf-8?B?OFdOTTNlZTZaV0szYktxRllwbStGcWdMWUE3R0RjUWxwYTFBdHZqNjRlekpW?=
 =?utf-8?B?YVZkTjRBTjZXRTF4dUpGOVh2N1VodnFqeFYyNHE1c3dEVTRRY3lSTkVaWkNG?=
 =?utf-8?B?YnduazZzT1NPNHAwUnhSYXJwSDB6WWRrRTMvcXVCNjl2NVNVNXZUZVQ3VSt4?=
 =?utf-8?B?MHVSYzRjd24yRy9aS0FEeVFYMDh2SHlxWDFUV3ZEcllWZEUrZE4rNmtpaU5E?=
 =?utf-8?B?dU14Q0dXbG5id3VNb3dNRWlxNHFUTGhSRkhkd2l3NTl5OG9LVkovejlDa1FU?=
 =?utf-8?B?YS9wcG1uMTQwVTI3U1VMaU5DaSszVE5pUmM1Rk5SWTBjeDlHWk8vdVJNOXpL?=
 =?utf-8?B?c2VUOWRheTR2TnptWDJITE0rcDRHbkpEZkVBdW9RWlhpaHB2NDNPMWMxMUZj?=
 =?utf-8?B?RlFkVTk4WXlrbUFSV0poRjFFS2k1SjRNUUtOUzltSGd2MTRTRUFLbk1ydC9T?=
 =?utf-8?B?aGNZQzVmeTdtZXhCVDlxU1JaVDhWU2xXRGhTYW03aC9GQ3VDT1I1TjR3KzI4?=
 =?utf-8?B?bHRjdHh3c2NBTGQ1YVNsTC9NT3V3aDRkUDNkZzdOZWRMTGkvUmNaeGM4REFC?=
 =?utf-8?B?UW9leVlwY0xnVXYrQktVZXM1VDFqdGxBblZlM2J5MHdoL0xjMDA3OC9MYW54?=
 =?utf-8?B?em1KbWdHb1ZMYmcyRUJzRUcvVFpOYTJaU1JmYUg2L1NWU1NyVk1OL0VObGJ0?=
 =?utf-8?B?NDJyeUFwOGU5cmVUWGFCMFNSREpEN3Y5eG1OU2NWVkxQKzhHelFicG9CY1Fa?=
 =?utf-8?B?MTVFN3Mvc0NsRHpTcjFOV0gxc0xjc0luNG0zN2Q5UkZKQlVBUlZlYlJ3SE1P?=
 =?utf-8?B?aUp0UEdEL0ZRSUdYWDRyWCtnUzVFenUxSGdjL1R2RVErYmFpSTlHcTBRNnF5?=
 =?utf-8?B?dHhsR3B2cE1rRjNPRC8xenIyN0FnU29aYkZzMlJkUkhLY3VwbTVrMGFiOXFR?=
 =?utf-8?B?VDFzbkh1anpWbk9LaWFEQ2oxb2NJZC9oOUNHZVlnSTBFQmtvenJuWWpPcGpY?=
 =?utf-8?B?SXZtU2FBcUk5YXVRb1g4TDFXUkNpMG9Ca25ycXBoRHl3RWtoeUp0UFVNNzZ1?=
 =?utf-8?B?NVFzL0xoalliVVVhYk9FZXZjSnFGYjMraFZDbVdCdXRjZjBjMGRHaVZ1K3Fz?=
 =?utf-8?B?WmxpSFpUb0krdzlPb3ZHSHU1ekJ6N2xmR3hFM0xScStTK2d0clVyazRjLzFy?=
 =?utf-8?B?U2s1b0RLZ0pNT2dXRjc2VGZaN3VQeEdQM20vTStyUS96blpXMHhDRU5CNGZ1?=
 =?utf-8?B?bnRKREFLazMreVJGeE83TWZqUFBSU2UzanBqcm9FM1BPcjFZT0p2Y1pneVBT?=
 =?utf-8?B?Ymc1bHZJQ2J4bU1BQjZpWXMzN2ZZaXVuMExDUFRXQkZPbEVnYWw2YlRmcFFS?=
 =?utf-8?B?dlIrL3Nydk5lOG1PZGYyWVRQOWZ2Z1lab3lyVENRbHFaaktCekI4bGFGOHdq?=
 =?utf-8?B?TkYxM2huZ1MwbFR2SC9HbkR5WmJtME9qUmNiSFlYaGh1ejJNUWhFbzVNYmZD?=
 =?utf-8?B?M1AzSU42N2dGYnQwanQ3Qjh6U2FPc0hiMDNnZUtsbnBLNUxzQmhvWnZuV2JZ?=
 =?utf-8?B?RW0wUnN6RFlPZ0Y3bkl4eDZONk5lUnh6L21lYmNDSndGNzZDemZmcjN4OHEw?=
 =?utf-8?B?RXQ0Vjc3RHVTSmtyK3FvNisrS2h2Vm9NN05ucXBOcXRiOGxCcEJWajEvbStF?=
 =?utf-8?B?QUpiNnExYWRjMFVaQXdjT2ZyaEhtLzNaWUIya0QxZml6K3hSTW9hU1h5RTkv?=
 =?utf-8?B?RGVUbnpMNkZNTW9xeVpSRHJ6N2V1OFZkYWtVOTBaMlZkbkJzME5zeW1Nb1hZ?=
 =?utf-8?B?SStEYXdFbk1NVU5scGVXY01RMjNtRzBEY2ZJVmI0U0xTV3ZSTCtYN2FibENp?=
 =?utf-8?B?SWI1alMyWU5pWXd6VUY1RWdzak01b1N6K2h6NTZJajNkdGpybHcyWUdWQmhY?=
 =?utf-8?B?OHlQdktEM3dBMy9uekd5Q1Jnbkl2ZENKd0Z2blNaTzFqL1I3STRGbFZ6R2Z4?=
 =?utf-8?B?cVRobGFnclQrclYyZG9XNFVqMHFXUS9YZ3BIZW1pOHMyUWszU25XRk5VaVVV?=
 =?utf-8?B?eDRKNzFzQ2xIUUEzVTVxdWoydFNhbkR0VWtqUE0xY1JDTVhqUHF1NEJocWdn?=
 =?utf-8?B?UVhhN0ZZYUZseVNLY05xMlFnVlo1clFqYW5URTB4SjZjUWJXcEVOQjJGazhI?=
 =?utf-8?Q?diHHfQAS5OiStxP3HG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6c049d-a8dc-42a4-be82-08dee20f285a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:19:46.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfJB9P+WpAITUgbm33wT/6OiOKTFBIgbPkZHTodWc07otopnRJ2tulm/NkZwtV9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17814-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 569C8759DA3

On Tue Jul 14, 2026 at 5:32 AM EDT, Brendan Jackman wrote:
> VM_BUG_ON() is out of favour and on the way to removal, since I recently
> touched this code I am removing this invocation. If this precondition is
> violated, the system will soon crash anyway.
>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Link: https://lore.kernel.org/all/7F866265-3F2E-4765-B9D4-9AB898A9C4AC@nv=
idia.com/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 1 -
>  1 file changed, 1 deletion(-)
>
LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi


