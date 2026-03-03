Return-Path: <cgroups+bounces-14565-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNxzAND7pmk7bgAAu9opvQ
	(envelope-from <cgroups+bounces-14565-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 16:18:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D006A1F260A
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4076D300B583
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632D481ABA;
	Tue,  3 Mar 2026 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0ZejM7g"
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E63CA4BF;
	Tue,  3 Mar 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551115; cv=fail; b=qqBQMyW6IKn9QH2WwyLhKh3lYLh7Q1AyyPXfWr/ij6jWaf0hyUZu5s/bMjsoY8UIyarkz9dhzym9wcwoJPOR9PppPK8sq2nIqUgjTBLtLNuK/e5z8Zh63kknjZerO0ymg3gNOc3rWjDudAJgPO6wy7eUuf8gXTkQPTQSXJQKHjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551115; c=relaxed/simple;
	bh=VcGUH1vgkXNEVGc2OpWGxJmrARRKQ0vP2h6/1SEXyOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iCX09mDDhmqW+kSJ0XTR58SgGwia7Lo3AqwlTJb4LA+Qrb9+GExi+TwLsqV4B/rTF+jsgNrkU6hfPXHLf3LessRUGjOvBFCLid+NFzzobySAM3x6dC1BHc7SbvYh1zP2c2BpF5SI00iH5itSg7cpuEIhPLirGiFbIVOhx7Dpm8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0ZejM7g; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1SaxzMgxSjknGHKFUt5wes5Uc3WyDhSaRjo9FjGAAZDwQKECv/eprGiQq6zY7K5A06hWxYjWo0D7UMIf5ShZT2pNDelDb9QcF+w3O2sjO/9hRBMgkclYOH6gVEZE+Yi5N68x01jPkKltaaRoxcCv+fBqNWrR73UYH+BlTTzWtOfRJG2ShQv+Lqr9XpeFnSSYqqR6HczmLlVhHv+XEK3jNVNlzX+QZ4/h37tqWl4soEhSr/xkGeCjlboi1+KeKAoHHSDy0W2yDP5vZWS+YsZL5n+NplxVNRuxrAzTVwW3T36jZrti5Rlh+aYVvu2kMEXmKQPrR0EkwWCZIfp3mdQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO2YaJcqZoKCdrO6i5ZW3v0x/wWnJirffOB/rQZKW7Q=;
 b=ora9V+0YO56saNPgtDkR3MOg8Ui3wxhnIqBi6ayV+kD7PT97pDWfDK+kKpPrcprm/+nftOdsNIR5VvG5Y4esnljcz19ikiFp3A7IMTQcpdbv1lF4M31jOBMu+6tvb+hcBAMXZcUJwpZPXw1VyHyLeqDpiiSA1mH9gSzTxMIuMU9oThIBOkLLnrO+4R1bIgcJ91FfbkgKY2I1oVUqNEWKxu/wK4koZ5uGITBfy8qMt5sw+P3ue9aOTokv/lByas0XhyNrjLqyF7HvvYLcpSpbfXPv4DxjwL0nD3mCJ0BI4IDqqqjWJiBjQ4IMA5QOAXOz4WQb5EXM0zF3IGEvylotTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO2YaJcqZoKCdrO6i5ZW3v0x/wWnJirffOB/rQZKW7Q=;
 b=r0ZejM7gSHkGUwMQxlo4ygnKpKjDY6zUMgwkJZMINKdtAyB6NlX6KXmG2Y6gDkqjyHXyQA47ahjefjd5bq0LIeBYoDgGizLDluacNjrEuPBofOd+TUu16loQbp50hcesywvdh657pXYmHrpn8n18K4d3nCkRaIc74iq9PnMOTzTS9EaOFA+qC+kyegUZTE+sHGjOqhOsJ7gm0rynYUbSVkMiGTLtqNnYzGtrsH5qSOd00YUqJx247NXpkkphNu8WJUHt4lwrAYZmIWJnBQInX2VAbyvGCklGWEnEsjkk32RTYmLK+PHLZ2uCB6SwuS9oKa1jd1nOb1zpmdZkeMqQYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:18:22 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:18:22 +0000
Message-ID: <1a89aceb-48db-4edd-a730-b445e41221fe@nvidia.com>
Date: Tue, 3 Mar 2026 15:18:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260221185418.29319-8-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a45b6e-80b9-4dc2-f990-08de79381ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	rpOB7Ik9v0HuuBOfVvdOXSRawzHjyDtfqHx6JxZBYfqfWphcy+d8PeUzS7LbB181NXsIxWqiK3JTMsV6cwKx42qaXOS27ERFDSy8bRa03O5mqZPTPY+0plEiwdNV1AVKhsJHqEiMauESu0KR5DO62c00cO6io6CyiHzzC5TG3PM/uOhlUao4G953zhOFF/LLKP6l1TyF8pmRxc17tAT0FZKoxYd2Bc57sY63Acc//y6vDvqpjHyEhG+DzC3nLxAQJoViEgHy38GFSY8O+jDkNjyqqsDGdqnRIQ2yEndSjzbaca8EUqrRyD2YTv6/vbc5hw4FD8KukhMUBf5EkPM3I8+J2RQyuhuS7iYkNPGaNkAWJ8CZGFufgnUVaOy1xstlyMecwrK5qhU7TVdHF96b3+3L2ocwf+tC6Ac6RPt8QrI672lGOQ2XPLx9SlM4EAD1jkDZ0fi382Xp8O98QJB4gbCUz+63oYMBMwHRPPVN4s7tu4mQ7qgkoxRytNSw8smLBopUuT2F69NVn4lj3kMdme2ROZLSgkEHVP2y/uDdAkZukLbKgA5GjB57Y5qQrILIlc8yLcB6qYJI16GKGhgG66Hq6g8hO3Mwgyz4GF2EdBoTrEfaLYNUzLtUoqRmwSJ6cfDHCWx7d/E2h567HRz1vabOVboMmrPg7Ct9EbVc3ZX2wJvpbRZONrQLz2yWI8OchxqWig5G4+qXuXFG1HaVbf+6Qb7ocp6bgZq7s5nDNhatAcq8StGX2S8oBmkjrxuEzRgAUuO2LOhssGc7FmXDBpJqQ9Z8d7mfpA1H7RKXcPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXlhQkVjV215QXJXSDlpSG5MMEs0LytsaHlJZGtseGRURThHWjRublVFNDFR?=
 =?utf-8?B?bXpwRFcrb1ROcGJ3S3R1blFNUnpscC9tYk4yOU9CMjFZTzkvd3pVdVFoampt?=
 =?utf-8?B?Z0tmcnZNZ1huWmFyOFdvYnJZbUs5dytRMlV3ZWl6VU10SjcrVjQ1Zkhjb1Uw?=
 =?utf-8?B?aWN6YTV6QnRwb1YyVUcvVlEvRG81M3ZVL3RrbHAvRW5xRXBQald2UkF1cldl?=
 =?utf-8?B?WXNYQUNtUU45OWpMNUtjbjI1Vm5pTWUyeXBWMFVMYXJxUEpFYmZqQSt0SWtY?=
 =?utf-8?B?ckZvbEdxSXRycStoanVZbDVnN2t2Sk9ySFVoaFA5UWtNYld5VHFFZnAraWh5?=
 =?utf-8?B?U3lqZGxFYjlaSjB6OTVFTEs0VTBuY1ZxTmtqUUJPMWpsMXcyWWFWWmtIYjlC?=
 =?utf-8?B?eXE4b2NBNnJpR1FVN3MzRVIrTFA1dUR0cy92Wi9uRHk2VnZ5VUlRT1RUY2E4?=
 =?utf-8?B?OU80UitNcUZpalQyL0p3bDVoZFZ5cjF2SGJiR2F3d2RCZDBxK3dUNkhJbjho?=
 =?utf-8?B?d3ovMGFVRUoyQTBYTWJjd3MxU0UzMGp3cW1DUGtpM1Jnd3p2OUkyeGlNdXda?=
 =?utf-8?B?ZFFFRHRlNDZXVm1nRmJnalhyUEFGdG85M1AwVXlXUmZWN0lrYXRDeHZDWHBK?=
 =?utf-8?B?MzVxekxNT2NLa2x0aWtYY3NRVDRYQlZjY0l5SDlTNTA4aGhrTjdwcmZCZTBB?=
 =?utf-8?B?OWxISXo2VDZCMUFnYUxDZTFYTlJ1YzJCNnQxS3JFMENQak0xWi9pRGRSUVZ5?=
 =?utf-8?B?RTdiSW41VWY3SkV5d2sxNWdGSXUrQ3RnOXdIUUF3TFJBVGtHRmVrbis5NWRh?=
 =?utf-8?B?elBuMi82QlVtMWs5d1B5Y0wwMklPVExwQzNNU1BrS2hjT1hIaDBNdUpKemR1?=
 =?utf-8?B?MnhGZVpMZ2JRczR5eDlDNmtZMXBDV2FQY3c5aEFVa09aOFBkTU1qYzZxWDcr?=
 =?utf-8?B?M3YyNmQ1VHZxZ2ZNbzJFdm1OUGM3WkJmYmNPWjMvYlZ5Q3c3Z1NnYVRySW1B?=
 =?utf-8?B?bXF6VEc5Q2U2d2dCWEkvKzJjQS8wWnFYWjhSb1dubzdCL0Mwd28yWEJsSXB0?=
 =?utf-8?B?Q0F1OUxJRkJkb0hFMlZtVzJTdW1ZMk93UENrWGloa0ZFUEpxak0xc2VRQmhG?=
 =?utf-8?B?byt4Mk1JV0hnQkMyTkhOdHJJYVFQeHROYXJSSmhLWFBDSnMrSXVxWWM2U2Vk?=
 =?utf-8?B?d2ZydzdaOXdOSTh3OTh0U24xZ3BacDFScm9lTVBJdlFKbXdyb0YvaEVIVitk?=
 =?utf-8?B?VmVJckxud0NwVXMweHlKRG11RWxIYjZMRmFNc2Y5aDk0YWhzWVBmbDdQV3pD?=
 =?utf-8?B?bjZBNkpXalFUUTVEWFFkUFdmcTZ0MVNjek1yVGkzbWZIaUpDamRiNm9LcVdQ?=
 =?utf-8?B?L0hIaVZueUxMZmF1L0o3bkpHaFRqcUdITVpLNnB4QzFZR2FWZnV2NUJHQmNI?=
 =?utf-8?B?cFJOejFCOXM0LzM0alZVM2IyanlFUFZ5Qk5zNVZUSER0dEdCSUJLRGxaTDJ0?=
 =?utf-8?B?aUkwK3MrbFMyNU5xbXpQbjVuYnNDQzNrSm9KRmpZb25ieDRuMnhuQ0lQREFS?=
 =?utf-8?B?U0hNOFZpNEFlTTV1Y2IrSFU5TkUySE8zVmRZbGxJd1h3MkZBbDIveDYrUkxP?=
 =?utf-8?B?Tkt2UG9HMXhkdGRSU1JSS0F1ZU1yZkV2TWpCaWlLckp6UmVnaWtEY2drVG85?=
 =?utf-8?B?QTNjWm1WeUQyaG1jSGFadkd1OHZoMmY1NmgySGlQc1luWmU4bG1CYUxrNFU4?=
 =?utf-8?B?MER6OEZtNWJ0dnhHZVJQUjRUN0Exa292b1FRZGhBanNOSGlYZXpqY3pHMGcr?=
 =?utf-8?B?Zy91R0VVdDJLYWxicUpNUmNxTUVhM2tvTnBMS1hhbnhzRlo1YkduSTA4S0xr?=
 =?utf-8?B?TjhVUzNZZm5hR1BvR0VjdWd5cllqKzJGWHQrQzRvRm8zRk9FU2lscHNZa0h4?=
 =?utf-8?B?bnNHanV5QTIxOEsyZ0l4aDVBNlZDNzR0SkN5K0xZZXBpSlF5NE11SmtHSEtp?=
 =?utf-8?B?bGEvT3hXckxlazNOaS9peWtVRktmZzd3TU00bEFXTm4ycDVPb0lad3hLU3gr?=
 =?utf-8?B?TEdCRE5QKys4c1UwY2ZaaFlZUnpZQStXd0h2K1NibTRjNWRORnJ6Z3lkTUMz?=
 =?utf-8?B?WElGL3BxblRaVkcwa0tZUnlNSi9UeVIva1I4OHh4Q3A4Ly9Pald5bW5VM2Nq?=
 =?utf-8?B?UHBEbGhLK0lEOUdVdmk2c0RzY1JCdS9VTzRYaXRKN0dwWi9SeVFxQzNNbDFH?=
 =?utf-8?B?dVBrUFdnVkRMYk9EdHI0c1F1NlpEbm03K2pHRVAvT1RzVGVyT2pQVjdCekVM?=
 =?utf-8?B?ZnB5Ly9FUm1SaW5sUlY1RjJCVlRCdVVramhyNUdoeDFLaFpsMVBBTWliamVO?=
 =?utf-8?Q?yGjeycCR64rFfE0IvowPcRuQvB4UciyZUyQvpAKueJjYp?=
X-MS-Exchange-AntiSpam-MessageData-1: seRspblkphMi6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a45b6e-80b9-4dc2-f990-08de79381ba5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:18:22.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DI0mjiz2fk+CNdJ71zDlS8TTg+AXXAM6OeHLyMrMKL92HvbYO+9ILJ3zPc0ZyHjCkaHNb0qRdLQ4TkbbvfawcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
X-Rspamd-Queue-Id: D006A1F260A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14565-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,self.online:url,nvidia.com:mid]
X-Rspamd-Action: no action

Hi Waiman,

On 21/02/2026 18:54, Waiman Long wrote:
> The cpuset_handle_hotplug() may need to invoke housekeeping_update(),
> for instance, when an isolated partition is invalidated because its
> last active CPU has been put offline.
> 
> As we are going to enable dynamic update to the nozh_full housekeeping
> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
> allowing the CPU hotplug path to call into housekeeping_update() directly
> from update_isolation_cpumasks() will likely cause deadlock. So we
> have to defer any call to housekeeping_update() after the CPU hotplug
> operation has finished. This is now done via the workqueue where
> the update_hk_sched_domains() function will be invoked via the
> hk_sd_workfn().
> 
> An concurrent cpuset control file write may have executed the required
> update_hk_sched_domains() function before the work function is called. So
> the work function call may become a no-op when it is invoked.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c                        | 31 ++++++++++++++++---
>   .../selftests/cgroup/test_cpuset_prs.sh       | 11 ++++++-
>   2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3d0d18bf182f..2c80bfc30bbc 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1323,6 +1323,16 @@ static void update_hk_sched_domains(void)
>   		rebuild_sched_domains_locked();
>   }
>   
> +/*
> + * Work function to invoke update_hk_sched_domains()
> + */
> +static void hk_sd_workfn(struct work_struct *work)
> +{
> +	cpuset_full_lock();
> +	update_hk_sched_domains();
> +	cpuset_full_unlock();
> +}
> +
>   /**
>    * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
>    * @parent: Parent cpuset containing all siblings
> @@ -3795,6 +3805,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>    */
>   static void cpuset_handle_hotplug(void)
>   {
> +	static DECLARE_WORK(hk_sd_work, hk_sd_workfn);
>   	static cpumask_t new_cpus;
>   	static nodemask_t new_mems;
>   	bool cpus_updated, mems_updated;
> @@ -3877,11 +3888,21 @@ static void cpuset_handle_hotplug(void)
>   	}
>   
>   
> -	if (update_housekeeping || force_sd_rebuild) {
> -		mutex_lock(&cpuset_mutex);
> -		update_hk_sched_domains();
> -		mutex_unlock(&cpuset_mutex);
> -	}
> +	/*
> +	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
> +	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
> +	 * cpumask can correctly reflect what is in isolated_cpus.
> +	 *
> +	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
> +	 * is still pending. Before the pending bit is cleared, the work data
> +	 * is copied out and work item dequeued. So it is possible to queue
> +	 * the work again before the hk_sd_workfn() is invoked to process the
> +	 * previously queued work. Since hk_sd_workfn() doesn't use the work
> +	 * item at all, this is not a problem.
> +	 */
> +	if (update_housekeeping || force_sd_rebuild)
> +		queue_work(system_unbound_wq, &hk_sd_work);
> +
>   	free_tmpmasks(ptmp);
>   }
>   
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 0c5db118f2d1..dc2dff361ec6 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -246,6 +246,9 @@ TEST_MATRIX=(
>   	"  C2-3:P1  C3:P1   .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
>   	"  C2-3:P1  C3:P1   .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
>   	"  C2-3:P1  C3:P1   .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
> +	"  C2-3:P1  C3:P2   .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-2"
> +	"  C1-3:P1  C3:P2   .      .      .    T:O3=0   .      .     0 A1:1-2|A2:1-2 A1:P1|A2:P-2 3|"
> +	"  C1-3:P1  C3:P2   .      .      .    T:O3=0  O3=1    .     0 A1:1-2|A2:3 A1:P1|A2:P2  3"
>   	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
>   	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
>   	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
> @@ -762,7 +765,7 @@ check_cgroup_states()
>   # only CPUs in isolated partitions as well as those that are isolated at
>   # boot time.
>   #
> -# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
> +# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
>   # <isolcpus1> - expected sched/domains value
>   # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
>   #
> @@ -771,6 +774,7 @@ check_isolcpus()
>   	EXPECTED_ISOLCPUS=$1
>   	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
>   	ISOLCPUS=$(cat $ISCPUS)
> +	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
>   	LASTISOLCPU=
>   	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
>   	if [[ $EXPECTED_ISOLCPUS = . ]]
> @@ -808,6 +812,11 @@ check_isolcpus()
>   	ISOLCPUS=
>   	EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
>   
> +	#
> +	# The inverse of HK_TYPE_DOMAIN cpumask in $HKICPUS should match $ISOLCPUS
> +	#
> +	[[ "$ISOLCPUS" != "$HKICPUS" ]] && return 1
> +
>   	#
>   	# Use the sched domain in debugfs to check isolated CPUs, if available
>   	#

We have a CPU hotplug test that cycles through all CPUs off-lining them 
and on-lining them in different combinations. Since this change was 
added to -next, this test is failing on our Tegra210 boards. Bisecting 
the issue, it pointed to this commit and reverting this on top of -next 
fixes the issue.

The test is quite simple and part of Thierry's tegra-test suite [0].

$ ./tegra-tests/tests/cpu.py --verbose hotplug
cpu: hotplug: CPU#0: mask: 1
cpu: hotplug: CPU#1: mask: 2
cpu: hotplug: CPU#2: mask: 4
cpu: hotplug: CPU#3: mask: 8
cpu: hotplug: applying mask 0xf
cpu: hotplug: applying mask 0xe
cpu: hotplug: applying mask 0xd
cpu: hotplug: applying mask 0xc
cpu: hotplug: applying mask 0xb
cpu: hotplug: applying mask 0xa
...
cpu: hotplug: applying mask 0x1
Traceback (most recent call last):
   File "./tegra-tests/tests/cpu.py", line 159, in <module>
     runner.standalone(module)
   File "./tegra-tests/tests/runner.py", line 147, in standalone
     log.test(log = log, args = args)
   File "./tegra-tests/tests/cpu.py", line 29, in __call__
     cpus.apply_mask(mask)
   File "./tegra-tests/linux/system.py", line 149, in apply_mask
     cpu.set_online(False)
   File "./tegra-tests/linux/system.py", line 45, in set_online
     self.online = online
OSError: [Errno 16] Device or resource busy

 From looking at different runs it appears to fail at different places.

Let me know if you have any thoughts.

Thanks
Jon

[0] https://github.com/thierryreding/tegra-tests/blob/master/tests/cpu.py

-- 
nvpublic


