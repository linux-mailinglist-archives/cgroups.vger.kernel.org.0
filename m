Return-Path: <cgroups+bounces-15891-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CFeLuBpBGprIQIAu9opvQ
	(envelope-from <cgroups+bounces-15891-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:09:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 025FE532C5C
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFDAD3053D3D
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3763FE37E;
	Wed, 13 May 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="yGNgAUH2"
X-Original-To: cgroups@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020097.outbound.protection.outlook.com [52.101.84.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD363F7A86;
	Wed, 13 May 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674142; cv=fail; b=MOiM8nUpgAh0/8V+zvGUPcBGY90ipvzhTrrSBzXLri0b2mqgUH3j5gmDPqXW25LLJ9c834L9tBrGygLpy9kwPwFKYMHz3/wXH99SJ0NysoMvN+Hj+rHmyWvj3CX0TIBLvoOy7Xkq4Lf8N03yS4sk6CxuB1dhXMM6/2fd+x0Xr1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674142; c=relaxed/simple;
	bh=CRkhJnopFc74Qn8tGUAy4+AehBYmkZmH7SrzdrTObZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jKnoLESljazscDhdqYdJKQDh5fng+kybX/WdTh/dRxXZ35wLAFYSYQ3nlyrzW8heBH3VWyo5FCc/23kp2BwrurqMwKHbnLvryuSxwG7DjQCfvRbzkV5GykNvn6Yb5V7xonGmDOSPBJO22e0EWqsFIWVilpHzWUXxSRZ2XgmtX4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=yGNgAUH2; arc=fail smtp.client-ip=52.101.84.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMmgY6ZhMRquWw11cc+i6Ni1m/0I1zfPgiwix8LJXr/FRlkrBSYbnUznqYn8YinFSbRHvgYFD+H6c8I5wLmEY+OzkpEb6APC1W4HCY96lcTNiSP2JKty99ihEjg9ziNG5ycv1h+AEjzVJ0anSAM7P4RG3NABY653Wdt9ivi8IRCanF1BjGPIeTITOoHJgYy8XPqyJHSR+JPQXOSwmMbNuk970T5T9FBx0qriU8053xpNv7uoXBjIdnnE+50HuHMd/8HlYg40JxAOWgrkCjBHT6m192v2/H8wGKEiWZrNgjLKUCGmu+EkUJ5MKzYuS1mzorgBc1LhP35Ah880L1UYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHQ6O7sWCTdBB5BWZx0TMYg/1VRHJBJxaZO0C7jOse8=;
 b=q7JqCDvOGYpPhXC7bHOMUk6WbCURMI0Ga2DANV5GkgE00sr6EjZ79ACCuRlUXkgTO8DL40/STceYX5ja6h3E3xk3iA+lWDs+HPu2BTkjgMoGjPqOHaIXexp/cZ2hULA/w2NQT+hGDFxj/MLACGPGz8dgnWa7q9Bq88kahZnjfQPVlDZgiRen6l6g0D9dXkqJi86PpgT6t+j8XjnAP/MVrQiy1UUxkFlM/SSaunQDD4PBLTdu1Sa2f+j7rEoGaq/T/Va2qpBsbTHmGtKVnam7WgiVzFrAljarRxG85fd4e1M6Gl8rAD2rUEY9O0/gNOObe1005z8v22Oxk5RTZrzvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHQ6O7sWCTdBB5BWZx0TMYg/1VRHJBJxaZO0C7jOse8=;
 b=yGNgAUH24Zjr3OHIKQB/WGmalE5GlnO3hQmkjbrAKyD49okiu7rPLd+0fSGkysoULeBYzwbabK5gcGQa14HwNd6yu7fuaXb+jb3vJSAlQTmz3dJRFU/mdL9sJWJ/IBOb3BawTEsI8+GZtcxdRlwwZLeDXwA/+TGbUsbx1QEJujs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com (2603:10a6:10:52b::6)
 by AM9PR03MB7363.eurprd03.prod.outlook.com (2603:10a6:20b:26c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 12:08:54 +0000
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9]) by DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9%2]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 12:08:54 +0000
Message-ID: <0d3336a7-ae42-4359-bfe7-48a7d6796d06@santannapisa.it>
Date: Wed, 13 May 2026 14:08:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
To: Tejun Heo <tj@kernel.org>
Cc: luca abeni <luca.abeni@santannapisa.it>,
 Peter Zijlstra <peterz@infradead.org>, Yuri Andriaccio
 <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org> <20260507163058.2c435922@nowhere>
 <agIfvZuvXEtK45em@slm.duckdns.org>
 <c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
 <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
 <agNvghphiv9sCJrq@slm.duckdns.org>
Content-Language: en-US
From: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
In-Reply-To: <agNvghphiv9sCJrq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To DBBPR03MB10258.eurprd03.prod.outlook.com
 (2603:10a6:10:52b::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB10258:EE_|AM9PR03MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: b81fedab-fd47-4a45-fbdb-08deb0e86744
X-LD-Processed: d97360e3-138d-4b5f-956f-a646c364a01e,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|7416014|376014|1800799024|366016|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8szAIumkLkMA9TPCQJUNLezzu071Map9n0HWJJZ7Io2axDgZerScbcnZZACix9wiorZjThcX9M8FIZtD2ssmk3y7FCdYorsGyRqWVK57Fv4iEvu0J2S1ZQK1+b5QjHmLjB5i80YhRb5JzchUxY1BwTf0tTnfjGnN7DTMgaRSwfy4BFtGXA3VnjuSspM8lVNR9UkGibXQTniW0Yl972On09O9DeAjmAQ5Cmni4dW3A3G2ZKDUtv5rTAXpkLVb0aqxkjPXaHFITQe2JzjWVpBm1Qag78tGxxCPX3GubWitJOnssjXdZvUkwQJ69OUjE6u5SdPFCmbsGvQW4kRst1Ljao7CTDt4ns05DkBaA/HQ59o0PeX/07/F/Qb7PPjTvZalwE2Mk/BYwwEeHOFCINzcwd+C+stiPcjAvngMmmfhMQUYIE8qsSFfQufn7xiH5NJdTl6gXZBBgpgjbODC0TNkblvFuQf0CCU+78mZSXxVpYqiU9RA03jks55pWFjSwfiE8UahHOHdWAdwa8+5o/kozngSuHlHP+E6Li+h2Vw+wzIoG8FM1pQBY6hGGnGVt6k0DTCakynImWwFaL0eZ3BfRU01D9yQCORsbX7JsL8XR/W1mo6hEAixiWbJuRfccFuHf7mnMV7ibkS5dV7kBnXEUJKDIOljr7iJXmdfsBby85aBc+iiIi+soH7ih6tNiN6R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR03MB10258.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(7416014)(376014)(1800799024)(366016)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlQvLzkwZGQ3VG83T3NOWmZIb1NLSjE5NG1oQUhKTGQrM2svQW9BaWNUVHg4?=
 =?utf-8?B?ejNhZThiKzBZbWtRczZxN3lvcUszU3hvcEt2UjZlR2Z4WHJqa1NIZjFXeVB3?=
 =?utf-8?B?Ri9IemFDMkkwU2UvR21FTnRtejhtN3FtSG94RlA0dC82RE12RkRTMEtKc0xy?=
 =?utf-8?B?b2V5cDQ2TUl6Zk5kQW9kZlFpNEwva2ZyWHVYdzdOa1Y5VmVoZ1UxOU9iZlRG?=
 =?utf-8?B?ZElBbFRnUlVSNmxYZUpuMEhtc2xKOTV6WFl2ajVNMlRscVhHWkp0c2htajdv?=
 =?utf-8?B?TFBWTldDL09CNG80RHVIVG4rUVAxc3ROMTdmQmpFRnBlRWNxR2l2YmFPazdF?=
 =?utf-8?B?cUJZRzFjc1E2UjB2OHl1K29EcER4ak0zZ1kyakk1amNmV016VmFvRzVCUVN6?=
 =?utf-8?B?dHlzT1U3VDIrK1lKVG1oSTlBT216USt1OE41dThwU2lwS3cwc0tMcUdUZ1lX?=
 =?utf-8?B?Y1FURXBjb3lwZy8vUC8yNWtUWVVJeW1aRXRRajZ6R3paY2NYYUZjaE5FcGla?=
 =?utf-8?B?ZHVRZ1JBb2M5SE44cmNFWDRuS0QxZ1BEZ0EzV0RyYzBCNVdPaVIyL0pzQUxV?=
 =?utf-8?B?LzE0YWRQb1c5MUFoWjYrWWIwN3ZnWHlMUDdsUmNySjF2aUdKSXByK3k0N3ZN?=
 =?utf-8?B?OWoyRkJycE9qcmdod0syY21XbXg1cUt1L2twdDU5THZjU1duczIvTU1sQit5?=
 =?utf-8?B?bUpsdjllRXRhQ0pJUlo1dXRvMlNQZ1dwajJxbytBdnZ6MGZ1U3d1d0VsOGMz?=
 =?utf-8?B?aWVaUlhqWXJPWVliaHQ5dXNoUHc2YU1ZVHNubUlLRjlxTC9LWDlmTTBzM0lq?=
 =?utf-8?B?T1JERjFxRkQwdi9HUHU3MFRzemd1dk93RmV5UTQ2ZGFEMmFDUU41UnBWM011?=
 =?utf-8?B?U09QMzJoSVdyb3M0MDl1dmRYOFlZNGtCWUMyYXhwdmhwZjdCeUt6V2R1U2c2?=
 =?utf-8?B?eTg0RjFDaEtibkduS1RKUGdsQkNmdHd0TnRuSWtIOG9KZ25nQmRkNUhjL0l5?=
 =?utf-8?B?SjhPcXVLaDl2dHREMEVMNWFMbm16a29Td1h3cWNrVnhBZGRaSmxCUmFXeWNm?=
 =?utf-8?B?T0FYaVRMclorMHNaemdmdGl0ZnNBWnB1K3BBd2dvV3Yyb1AzM1VVVjVmdXZM?=
 =?utf-8?B?elFIYzU5SFQxditPWEVRSnJKMUk3VjZPRlhIVytObVNhNytXWGJCNHlMTW82?=
 =?utf-8?B?K3FWaE83cS9pc3JCdEJ2bTNxZUpWYnQ4cEkvd04rVVZSUmFJbCt3emJmNEV4?=
 =?utf-8?B?SHlRRTVzM1NCMERrbXdBQVhQT3hiamtQcktra2RneW00d0hZY2dHWCtUK0hQ?=
 =?utf-8?B?WXhReEI1bENVdDYveGY4NnpUMnE4YTMrcGh2ZUVaTytCRE1CQVRnOXJZUk9t?=
 =?utf-8?B?cUxPdXhrU3YvcHc1aFVhRDhpVFc3RXZnMGM3TUJrczFiaTh1K0htbkFaS0dT?=
 =?utf-8?B?WFRoRWdvSlNzcWF6ZXRrVHdNbG5nVVBmY0hmaDRxQ0tIL2pkWXplcVRoK2Nm?=
 =?utf-8?B?U2xDZ0NHbHdwQURPOGpjM0V0aUw3a3VNUEtkNHZ6azNOSk9UU1g1dW5Ocnhn?=
 =?utf-8?B?UnJVbnh6bHE0SDRzblkvL1BIZXR1aTNBMmxVSWZXSXVFQjc3NVdteGxvQW1o?=
 =?utf-8?B?ekRJeld2V1dTRjdDSUE0Ylh2eUVSeEJYNGQ3bzNOTk1xNS9DbDhUaFA2S00v?=
 =?utf-8?B?MHl6MFV1U3A0L2Fva3Bha3BvS2JDVGQ5VStZOEFxU0xpZWl0WkUxTFVPQzYv?=
 =?utf-8?B?ZUtuYzNCVW15c3FiY01Ccy9BTlZZakpnMEJpQk9rOGlNN2M4WTlESW1uakFX?=
 =?utf-8?B?RnhXd202SHc1WkhqYWR3bENSVTYySWpUbFpzQWtWV1E5b0t0bUtsWEpsV1N6?=
 =?utf-8?B?NFNXUklRajFvUHRSN0cySTNjQ2FqaG9ZSXZudE8vUWx0aHU4Nkp6ZnZzak5u?=
 =?utf-8?B?L2JZNDNsckVMM0Fzb3hrbnJFRjZRUFhKTVdpNnhlM2RwWERpVktScG9zWWxS?=
 =?utf-8?B?ZUcyT1h4azJZUXdqWXFmWUlsdWVNNjF2ZFQyTTlzVkY4VGZ0MDVLc3lOZWdR?=
 =?utf-8?B?ZzFRVVJBRnhUQkFVNTY5UVFpNmlCOGZZNFVGajZGQXZ4RnhQWktNd1pPdTFD?=
 =?utf-8?B?MFo2Yi9sdmNXMUN3Q1NTUUNlMmhuRTFHakZsTkxoQnVZWWNEZ2thRU4waGtE?=
 =?utf-8?B?d2J4ZlNMMUtENW1wOUVTL0VFWVVyaWhwL1ZhTXVmU1JBQmxreEZUVlRad2dZ?=
 =?utf-8?B?M05pbFBjWVVEc0VxTVQrcjVBKzdCK0ZXa2dvblVld3NlMk1peThqL2krbDZ5?=
 =?utf-8?B?T2RXNS9wM2ZMeDgrYU42a2JpT0JjZjR5R1VsK0VZR3JkdHFvcC83SkpVN0Fu?=
 =?utf-8?Q?RwH2qehG3M7ZM2sw=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: b81fedab-fd47-4a45-fbdb-08deb0e86744
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB10258.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:08:54.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZrYRSNg0R2UCVO2768iYU+31IfKL6CFOssXvXC29eUg3DsLM9QOc8+k5OZuyh5u/awS7LGcW1FAmW7u7PrVDtcEYguW3uIDk1fny2VVbzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7363
X-Rspamd-Queue-Id: 025FE532C5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-15891-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuri.andriaccio@santannapisa.it,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

 > How is a delegated subtree prevented from setting cpu.rt.min = 'root' and
 > escaping its ancestors' cpu.rt.max budget?

Is it strictly required that a child cgroup must have 'less runtime' 
than its parent? To be more precise I mean scheduling tasks on the root 
runqueue instead of using dl-servers. Small note: given that HCBS 
cgroups use dl-servers, and thus run at higher priority than FIFO/RR 
scheduled on the root runqueue, if a cgroup rt.min is 'root' would yes 
escape its ancestor budget but it may also possibly get starved because 
of the priority levels.

If we require that child cgroups cannot escape their parent's bandwidth, 
even when using 'root', then the cpu.rt.max file must be disallowed in 
the root cgroup (removing the possibility to reserve bandwidth for HCBS, 
and so doing the admission test similarly to when SCHED_DEADLINE tasks 
are executed), and cpu.rt.max would use either 'root' if the whole 
subtree must be scheduled onto the root runqueue or a <runtime> <period> 
combination to reserve bandwidth for the whole subtree. The cpu.rt.min 
would then only be used to reserve internal bandwidth for the cgroup 
itself. This also means that a whole subtree either uses HCBS everywhere 
or the root runqueue everywhere.

 > If the users on the system already started using rt, how do you 
enable the
 > controller from the top down with budgets already being used down in the
 > hierarchy?

In my original idea rt tasks would only interfere with their own cgroup 
configuration, but not with the subtree or their parents. When 
cpu.rt.min = 'root', you are free to change cpu.rt.max values to 
whatever you like in any place of the hierarchy, and tasks inside the 
rt.min = 'root' cgroup would not be affected as they are run in the root 
runqueue.

If you want to switch a cgroup from/to 'root' and HCBS, you'd have to 
either move all the RT tasks out of the cgroup, set rt.min, and then 
move them back in, or change temporarily their scheduling policy to 
non-rt (SCHED_OTHER, SCHED_DEADLINE, whatever) and then back.

Hopefully I've answered your questions. Which solution do you think 
makes the most sense?

Yuri

