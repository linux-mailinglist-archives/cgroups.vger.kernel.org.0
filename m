Return-Path: <cgroups+bounces-13249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91001D24B1C
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 14:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1AC4301EA34
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0A39E6F7;
	Thu, 15 Jan 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f53DZxzf";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f53DZxzf"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053D39E6DD;
	Thu, 15 Jan 2026 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482899; cv=fail; b=S7SAwE/j4EbJasfawjqDxOesUnV0rvOX99LrCy1R623TtgLEAG3+PnksSpH46sTz0SO4yePwpJYmjWOYdQPxvfVMXo+1dE3U++2e28SixfveB57ZA3GyqKvDnrWGmb+bMnX/GrnkWx+WTEaSnWfTVnnL88+TWcOrRfDPVFrkEzo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482899; c=relaxed/simple;
	bh=eQjZoLLq5yQCun5dXH07/q12CV9igEGleQ3K4cZEVPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jqXllUsa4V4SA0tLtb96xEKoLstoHF6VPFGbCaA0njOOmSNS+TmwAFr7vavz+rAhqPSbcWY2o5YeBAqb8G2ly5uDL3pTjBDIPe+5rLpPC1Cosgm+GAM80YgFMKUSgMNQXVbRc0xsCzgBRM8MWDhiyXCzLPr67nLMX/G9cwGwZMM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f53DZxzf; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f53DZxzf; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=U8WHFKFKY5k3jlnMJugBiRieGyTaNUOu8VMYK683I7XzzWbjgnNRMfEMwIFzhG0rgG4R/klEptfZUkmZZNJGi2ylT91Ag/+khTdyqd238hmvoXzRE5de9ffqbANkn0VN2pKiml9cn+b86SY+C+nOrEvzweMNVPdbasY35Ir5ip037ld0nDFtuoH+GaEMvdDf/7XU+lc4jnZlIBGFP3G4GvVqSJIRJN++fLJ0kkMmCB1J5TkCMTHAUZUqjr20DGs7s1ys+tXNUqPbZhJyDZV9QlKTBQnAv1fegqcbjBPmls+RTYzcO4mPankVe/FwwlACeT5DhLtZkzrv3yUShtHdBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5HiCIGJBMxl8eGqOHz3NFBoMfTwAkfxew02EELiBoY=;
 b=MwjrxchAVfio3Z6zgeeE+PlXd+DgmIEoB0hr9kFDCcjS/h1xlkgsouBN+Cxa7iAnYOFdobEMgb0zaLUWWzu3bIKV+/O/VFlIcCmol5ESmf7wDjGK4hYuJR/NIZai6rwXHwrs4kmPDQbSuVHVjvcLKrJdoSjjEH3gX8eKHAqo4nMu5nekmTF6+3JgSCUwqZrwhSDnRkzDnEmc41wIbI15BV2VMKlgMahGofD1kZ9ObSmiBn3kxpqEtlloB/sLjV6L4X25MSWNYsD8DcM9LWRPKJVNRhOFePk0URpLrG1xRq3E+/3Ox0yyBxH7nzXYTgzt/JYSgzE/xZaml8/jcQnxEw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5HiCIGJBMxl8eGqOHz3NFBoMfTwAkfxew02EELiBoY=;
 b=f53DZxzfwRP6AkoAs5e0vmSg9gCfTAy8LzEfY3wIcWg2uw33JwsNPbscfWO7LgYG8gsZYcgdg9DH3rROpymlSTKBfLuC2zPEBzn1Mu0lSWsz11cRBCsYYQmpNegx9sc7kQhl0BNZqehAQaMGPFClftaAfMc8qsawASp+tTZnoYE=
Received: from AM9P193CA0020.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::25)
 by DB4PR08MB8104.eurprd08.prod.outlook.com (2603:10a6:10:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 13:14:47 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::a3) by AM9P193CA0020.outlook.office365.com
 (2603:10a6:20b:21e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 13:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 13:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REVViBvXolORanxPB69Sbnm8EHLCWtvg4Mvp5shBByWoxtwjyeeZZRaRjDrWGEwPdV0X1jmVj5ibrmFpoTnRmxKwcxLHMM6tvjlDMaPcY8JaZeV8TBbajgfqBpLW17ln03WsoLi+hKVIDSExe6KKXiwdr9Njfcvu4kjZBzmwRoNZryV2rjcJdbatJIb56KgBsi2iO9EXE2lTI4vHRYAXu/zejDwYTsM1XE+ffejyRysHSlY1xxVENREBa5nKoTmt7/Eo8N5t/BZbpvhckRBC7yZv0N2aLZ9dBVK2wH2rxOv4iGYcUVnROdhIicDOxoGsTjsR9qSYtQdivD8WdGsCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5HiCIGJBMxl8eGqOHz3NFBoMfTwAkfxew02EELiBoY=;
 b=QJWhrM8fMbe2VLPg6jR+a7AV+7e7amT9B1N6eCarA+SzTzUwxMuEx6zGW3fuVL19b+DWC1eHtwCGhKb/atNQxKJfQbsnELS3h29c+L1dfBUz/OSDLT4+0fcyMk7VOgLBU8F89oWACcmehybQv3FNQ08IL05jX7jt+EsXLF4WQ7wPRxt7GaFzVBpeEWvprTAjB9FEXL/5PGJRAibTktrcpv1RiYruytmO9w3uktb1sQZidKY8rRZQEgfuLqlfVz6ff4kRBzfq4jTwsddcqPooZs6ct2VP/EQpzjmmbXc5NvXfMD8YQOadLbOuAg1QXnc9LhIxVErdn+vfJnE4jgBEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5HiCIGJBMxl8eGqOHz3NFBoMfTwAkfxew02EELiBoY=;
 b=f53DZxzfwRP6AkoAs5e0vmSg9gCfTAy8LzEfY3wIcWg2uw33JwsNPbscfWO7LgYG8gsZYcgdg9DH3rROpymlSTKBfLuC2zPEBzn1Mu0lSWsz11cRBCsYYQmpNegx9sc7kQhl0BNZqehAQaMGPFClftaAfMc8qsawASp+tTZnoYE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GV1PR08MB8331.eurprd08.prod.outlook.com (2603:10a6:150:86::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 13:13:42 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 13:13:41 +0000
Message-ID: <21da68c5-e6ec-4ffd-81eb-e1fda13dd7af@arm.com>
Date: Thu, 15 Jan 2026 14:13:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, tj@kernel.org,
 linux-kernel@vger.kernel.org, mingo@kernel.org, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
 hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 liuwenfang@honor.com, tglx@linutronix.de,
 Christian Loehle <christian.loehle@arm.com>, luca.abeni@santannapisa.it
References: <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
 <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
 <20260115082431.GE830755@noisy.programming.kicks-ass.net>
 <20260115090557.GC831285@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260115090557.GC831285@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::23) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GV1PR08MB8331:EE_|AM2PEPF0001C70F:EE_|DB4PR08MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e86e47-1856-457d-cf88-08de54380e8f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U1hMNEIvSmtwck56TDZyVW1yMkRBSHJPcmY1TGZUSDJ5dHFJL0VRMS9kWHQr?=
 =?utf-8?B?S0hjUEJJeFlDR1FYQ3hQZ0dGME9yU3QrVGpLSm9LcXhSZGpSZ1pyUnRpbFFp?=
 =?utf-8?B?NWtVdUoxUVErWGUvYWhOUTNyK3dXUkt1WFVPbDQySkpGYW1seXNKOWo3VlRi?=
 =?utf-8?B?UitQWVdGYThsZk9VeTJISHpIYU1LcE5ONjhoTWw5NWxndUhIdWt3ck15dVBs?=
 =?utf-8?B?SEJ6S1lITC84bUZ3NlVnWnY2YzMyK09uYmVOci9LS1N6T0grVWFQd0VnN0tB?=
 =?utf-8?B?cmtXR3ZJbjQxc1o2eU8vS0dhZUlYcVBuTjZoUXRJTy9JN0tMSXNERDFhVXJr?=
 =?utf-8?B?QjlEZHZYcFhJRkY1WkVleTFyVWhMdEtKQThFKzVUeFp0ejNuVERMNUhGZjFU?=
 =?utf-8?B?RXcvb2J1a3hHUkpiWnAwdndXZlpiQkNoUHpXNDRpRXFsMVJ5aTY4SGVoMTJq?=
 =?utf-8?B?bkVqd1gyZlpCVnpzMHpBOC9WU0VyZHJpNkFSM1AybENFeGdNK1gwRUV6cmlT?=
 =?utf-8?B?UjNqdGNVUXp1VmpoRlFoL0pyZ014NENlT00rYVJkbklBWCtzakhRcWdxY3ZU?=
 =?utf-8?B?dGZWVkxrdlhZa2l1bEpNOFhORHd2ckRaYVgyOVROanIvYXB0cGc4ODlDTWVk?=
 =?utf-8?B?UEhOYWlZT1JpczBXNkdTUkRuU0xlZGc2ZVEwbFlMS00xU21lMG5EaGVSRjhR?=
 =?utf-8?B?eEhWazdxT2hYYjhLRXZ0SVJwRmtjQkd4bllvbHRvYjBFeXI4b1RQVTRBUnJY?=
 =?utf-8?B?bHMxeXR0WkhiV0VWQlJPTUJCbmVzOUpSN2xrRjV3MndsU3NZRFlha1l4QnY2?=
 =?utf-8?B?cEtxS0szMHl1OHFyMHIwMDdUdkNXUnN0d0lZbDJLRXhsQVZXMXFXeC9scEFq?=
 =?utf-8?B?Tk1DVjlKS2pyK01oUUFySTRHT1BUbGpSNFdTTnZQSWxXVEZRSElqNUJRT3ZO?=
 =?utf-8?B?VThqTlVrUnJVWG0vb2FEalBDQ1RyY3d2aW9yOGMrUHVBVHpSWkIzRkhkZ0RM?=
 =?utf-8?B?bFNxK0VtSjFWYkE3citGUWREVTVYRHlZY1dtdTF4MElaZ0NaV2hSQnFEUkFF?=
 =?utf-8?B?R1pZNlc3UXpFUkFJVzk4YUozYWg2b01Kek5GQnplWktiOThMWXA0UWthSU5N?=
 =?utf-8?B?cHN4NUViVGRGT2Vkbk1yL3FmeUNJMVJvVU16SHkwTFduUXZNcW1WOU41cXZ2?=
 =?utf-8?B?MnBlNTRrMFVUaDVkVzJxZFN4ZWxBdDdjQW1rdUZmekllVWhQcmZDWHVSeXpR?=
 =?utf-8?B?eVJQdE0rMmZrZmQ4N3ZzMG55L3FpWE5QYk85QTZGcVp6bHFLU2YzY1pZQS9J?=
 =?utf-8?B?QzcreDdKeGxleUl6b1Jkcm0vNVlpMC9yYjdReDNqYkVkK1Qza3ZVNWw4Z2Rz?=
 =?utf-8?B?WE1FZkJMR3ZJazQyenBOWStLNFhjN2tDb0c5b0s4ZVVuK29BMTl5RXN1c2JV?=
 =?utf-8?B?Y2ZQTHlYTW5CNlMzMkdkd2FHRVQ0STgxMXAzMW1oMndkeXMybEFEZFZHdXF5?=
 =?utf-8?B?MVJpOVlkZFdXdnU1Qmd4Z1FRejFDWlVZUFhwbHFsdjBrQzVmMSthVE5iRHFI?=
 =?utf-8?B?OVowOTFuazFZTXdUakVQKzdvUFJiV0I1MlZORFREQXFRM3ZMUEhXSmJqNUo2?=
 =?utf-8?B?L3dMalJOcHd1MFlxRUh2WTE3eWl1VHFoeVZzdTRjWXpFSVkzaG1iYlN0bVg1?=
 =?utf-8?B?TTFFVUNNSjhtN3NkUHZ5OUtwenB5R3hvYWJNbUNpdDg0VEVnNTIwTlNtMWpu?=
 =?utf-8?B?Q2pMWDJzb0ZyTU5nRmE4NmJtbHhXTHV1NVluWHBwaTAvUWJtNHVNcVZHbEhz?=
 =?utf-8?B?Skl3bXdreitKTXg2dlRYa1BNS3ZCK1YyV3dnODM4NjBEZDRDdnIrWWJ3Z3B2?=
 =?utf-8?B?eit4VkJiSndkTnNtZkR5ZGhUMStOS3l2NHJJVHNFWlJXV1AyVVh1WmZnemo4?=
 =?utf-8?B?d0dXcEdIQzRSYktIUXVJbHd2dDVjb0IvbjFlMUpKdGU5bzBVbEFDNlh5S04y?=
 =?utf-8?B?RzRJUjhRTGxKdW0wMmtnQnF0OE9xRFBVS3A4ZnozUFprZTdudnQ3MGFtR0ZP?=
 =?utf-8?B?QllWMy9tVmQxbXgwQlo5UXY1c0dlWmZoejYzNUxiVjNDcjh6dW5xMjE2WVhl?=
 =?utf-8?Q?+ZMcF4oYBOEbt67xN/2pfSmX/?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8331
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	878df8b1-cb33-4620-bda6-08de5437e76a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|376014|7416014|14060799003|36860700013|1800799024|30052699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE5vTGs1OUh1TnFWR3NsbXZ2Qkp1RkNrV0FFZFZ6ckZ1cHdNM0FBYjI0K2Jx?=
 =?utf-8?B?U2p2NGtDWTR4dXhPRjV5eFBFWWxmZ3Z0bTd5UWhva21SeHFQRXFPaDVqSWJT?=
 =?utf-8?B?NnVqMnIzaS9zN1R4U1JQSXdIRnFDV3E3N1Nsbi96NFk2NllWcEx2QXZPNWpv?=
 =?utf-8?B?dmpqUUx6a1BzY0ZFN1JEaDFXQzNONHBEUVQyd2dkc3BaakszOTlaL1I2RGNr?=
 =?utf-8?B?WDlhQXowN0I2WHgrT3ZTajlTSVgvZXV5WjgzRmkzamF6S3JUZlBtZGZONW5i?=
 =?utf-8?B?d000UlM1NFMwdElvdEp0cERtU2F1Q3IzM2JWeENoNkZ4RS9GajF0Si9vdzFC?=
 =?utf-8?B?OGdEaVNYUGtCMzBMTWZpUzY1b1dnSEx1WnYyUXpXb3k3Tmc1Y0JvaVdLaVlD?=
 =?utf-8?B?MEFFdTZnTyswQ0dLZlA1c0RLR2E0VGJRSVdsdjgwTThPME9TcFlCeEpva3lM?=
 =?utf-8?B?ckV3WlZBWXpuSjRFSUhmUHl6USt6R0FGZmd0eWIzeUpxaHhGZ2xGcFY3UjY5?=
 =?utf-8?B?V2NXQ3JwM0JmU1ZzVmRBdGd6RFRxZW1YdnZSTFVicmY3a0VSMjRXVzZpaHJa?=
 =?utf-8?B?R1E0a3l1Y3FFNDAxZWdNU09FSkNVcWNBb3NveUxsbHJ3T2ltUG0ycEtMUlZW?=
 =?utf-8?B?MjExUTdTRGplOXlIT091cSttV0JWSFFHTnZvdXRuUkMvNmRZR1VLVTdRM1Qz?=
 =?utf-8?B?aktoTFdmc1RzSHdNNnhQUzZOcHBLV0E2SHQyTlFjN0lrb0lEQ3pka2U5eWtn?=
 =?utf-8?B?RldhQzNycUlIUk9rLzBIOE1IWHhpYlEvbXlTdWQ0ckhraytwZDluaEpFMmFs?=
 =?utf-8?B?bTB4UEQweXVseVd2TEJmMTNzSVEyNlR2REt4bHRCSHk3bmRndEZSYXdYVUZm?=
 =?utf-8?B?UVhYcmhsV2U4cDRzNnJhN05nSm9RUHJhSmZyU3JOa1VtN3NXclVDdkhXYzRC?=
 =?utf-8?B?bTFDVnJRYncwNHJROVVmempkeXhESkZlSjN1T0gxM3c2c3JvVmw4WEdpUVpO?=
 =?utf-8?B?ZlY3UU83bllhMEZhN0RZaHJiRkl6alRIcGlTQXlvUnN0Y1NDTlpGSWpTSWI3?=
 =?utf-8?B?cG16RW95M2tNbGpaYkl2ZVF2SjF0ZlJKenJvY1N3RnFVcUc5RnJsTlN2WnFz?=
 =?utf-8?B?VFJJNk5sTEkwaVBSb2wySEc1cWN1dm1obkwxc3BnRVJaZG0yRmFLUkJwOWEw?=
 =?utf-8?B?Z1ZMMnhaQlJYakFWS3AzUmxLVmdRd2lOaXZYZnN5MGt3Y0pWcnB0Zk0zUGV0?=
 =?utf-8?B?Q2twdEZZK3ZmZk5lSXQ3WnpZQ0sydjVWTSthNHllMXFhQzA3eUhZNGFJSWlQ?=
 =?utf-8?B?YTlJcjEzeENnS2VGSXhwVnZCbTYzWGxFV1laSDU2c0JMbVlOZm5nQjVZa2V1?=
 =?utf-8?B?cG5NbUNnTUZ6ZmlKcWhkWUlWdWRxUFVnamEzSm1MdmFKZk5ubDNwd2N0bzIw?=
 =?utf-8?B?V1FMVFJmTThOTzNvMnVmUHpzYmVVajV4TWdnc3pwMGN2KzFRZWdmbm80emF4?=
 =?utf-8?B?N2Vub2k3WFNwVnNNZnJ0bk52RlNEUGFVaHZFZXA5aFVab2dQNkMwRllRWVlU?=
 =?utf-8?B?dlpWTTlUa09KT3N4SGFKT2w4VGlsSDRiVStmQTYyRy81cWpCUGlKQllGOGZz?=
 =?utf-8?B?OEtaVXdzbjl6dTdFUFF6WEhYR1l4bzQrd2d6RTZ0Mkw2OUhJaUNTTEQzS2g0?=
 =?utf-8?B?RWJCOGhzSzhXR0UrVEhOVkRMazkxZlhEQlRhVnBxajhneElaWGxWVWxheFZN?=
 =?utf-8?B?MzZZT0tDUGNLRnJFa3FmeWRoeVJKbFFBUzF5MEpyOFB4QWZHUXBqdHhZL2kv?=
 =?utf-8?B?T0hYVVRCNTc2VG9EQkR3bmpzcEw1ZmRLWkpiYzA1aitXbndDV3hhQktRKy8w?=
 =?utf-8?B?dW40aDNnOEw5VUNodXFLOFVDRUhjaVNhVlFoSFpQT1hSMVUwY2p3L09tK2oz?=
 =?utf-8?B?WjYyRG9HYlF5MmhWZVJUY3QwL0YzcnlUYXlNQ0E1RmttYnk0ZXlCdkN1VEVU?=
 =?utf-8?B?aC8wTk5vVkFaanBoRHg0bDdNcGVMcWZCbVgrcWJKM3FiVnd4T2dyVCtTQm9R?=
 =?utf-8?B?ZVVBbDJRdzdMUlVLb3NkMXN4eXY4M2NtZXRVYmpMam1kejVLYkF3cWhsd2Rw?=
 =?utf-8?B?cG5wM2JwZ2JPaXJjdTQrMzZtZkNpRDFWeS92T21vRk5pZzNtWkNQRVg2Q3kr?=
 =?utf-8?B?WE51dXkwai9ER29nZ0h1TU95NVl5T2t2aUxCd1dZQ0oycnNoZUZXb09KUXY3?=
 =?utf-8?B?a1JUYlh5Q244ZnovVG5FMGo0VFRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(376014)(7416014)(14060799003)(36860700013)(1800799024)(30052699003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:14:47.1514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e86e47-1856-457d-cf88-08de54380e8f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8104

Hello Peter,

On 1/15/26 10:05, Peter Zijlstra wrote:
> On Thu, Jan 15, 2026 at 09:24:31AM +0100, Peter Zijlstra wrote:
>> On Wed, Jan 14, 2026 at 03:20:48PM +0100, Juri Lelli wrote:
>>
>>>> --- a/kernel/sched/syscalls.c
>>>> +++ b/kernel/sched/syscalls.c
>>>> @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
>>>>   		 * itself.
>>>>   		 */
>>>>   		newprio = rt_effective_prio(p, newprio);
>>>> -		if (newprio == oldprio)
>>>> +		if (newprio == oldprio && !dl_prio(newprio))
>>>>   			queue_flags &= ~DEQUEUE_MOVE;
>>>>   	}
>>> We have been using (improperly?) ENQUEUE_SAVE also to know when a new
>>> entity gets setscheduled to DEADLINE (or its parameters are changed) and
>>> it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
>>> quick first look, it does sound good to me.
>> If this is strictly about tasks coming into SCHED_DEADLINE there are a
>> number of alternative options:
>>
>>   - there are the sched_class::switch{ing,ed}_to() callbacks;
>>   - there is (the fairly recent) ENQUEUE_CLASS.
>>
>> Anyway, let me break up this one patch into individual bits and write
>> changelogs. I'll stick them in queue/sched/urgent for now; hopefully
>> Pierre can given them a spin and report back if it all sorts his
>> problem).
> Now live at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/urgent
>
> Please test.
I don't see the balance_callback or the double clock update warnings 
anymore.

Thanks for the branch,
Regards,
Pierre


