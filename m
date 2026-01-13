Return-Path: <cgroups+bounces-13152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AFED1909E
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0743041A62
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347B38FF1B;
	Tue, 13 Jan 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qflYXA+C";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qflYXA+C"
X-Original-To: cgroups@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AD38FF04;
	Tue, 13 Jan 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309757; cv=fail; b=D2yQCfjT21Z4zjtpGl1VTdwGoJFs3LDhoInbAFveURZ7qir/YYgcYwMQbRC7DXHoj3EJG4aVQv9VLvvFuVEz9SrSQFJIgILPO1+R53IWOoz3ZNqyXsBQEE/aB6ebduQyY4NLSGJG8hdcHxtNgEBnTc7en4/xL/aft9wBHwHsGWc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309757; c=relaxed/simple;
	bh=cRWNX3c3KHo1tStmND4z7F3yi54WrP+ZMfb6Hk4qv+o=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfb96OybJN/907vgM2yVElzR9IInKMdeeSl5NNe0Ztw4K2YFDxgzwrBc+W4UA2AgKOD9dXxSgMSz1fjeeGq192sHak22Qg7z9L8wEmcqqERdbrRnLd8s8Iv1CS1+EiBpQA3fLlM3ki17N1/AZhHemrcS/lgUVJbff3rwaGr4pNU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qflYXA+C; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qflYXA+C; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WhimkM5hN51/V0Q/InEeUYI9GqpA/rcI0w+js8SQ1TdIDFEt8DVVQ8UpaETE/aLvQE4ndSwqvIOce/qyF34sFIkwnrHwgPVFOV4LOBQBSbIimh7WDH+hSux7fLzHUS8cQkBLaSUHYTEb83cSUkaOtT80FgA0uz2wdQQTVZCxuD5ZQh1qbx2188eIiQP90012wZhNFaJWkjYIc490igX896hL0sF0dNYeg/qGBxNFk5nejUaX6wMzsN/ersjosIDw0PvyTBIGWQoIELqFnDxrFcOGCpN2hEiPYHgRvy8E6+Pt3CqyuzBKvhfToaPqeM00qnnzTjnassGOSa/+zL85Pw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=O//pLsGhD4hrHvu50F65E0hawpMNAKleWjVW7WZTFHxnPgec9qsRQkhdS0Ck55F43yXH8Dg8hgMWoolkScMmNqgVxhEONPGXUNQWV/J5DAlvIhz0aPR6Cypb4kn0fieSdzINyPb//NXckAtxGQ4qm2ne7OjcY60BxCBfbgjajuyIuWIaOxORQtNQtJuo06BJpo0IMypRXnC8/BUgG4AIp3AHXz8syfiIayvQO+kv184mcg7uazjbF34PJZR4tgdAsnLNSgW5yxjfui6+zhzMHdWl/tKPIPsbJizk1UUE1qIagbH2ftct9foZrD02Lmdcpo7C6aTFdr4fOBsCGYKdEg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=qflYXA+CWiOpeuuSY/HFu7rQdFukrLSV+IdOUphrtwniV14c66Sd4tPln/Qi/9xStL7lnpsiwlRg6GDWXMENJJ34UpoU0C/jkVKdBNE060tOWbEAKFYCd6gRLgCRGgAajvb4OxYGpqpukQi0BLsFtXq1ICX3rCfUnAJZGZy3jt8=
Received: from DU2PR04CA0052.eurprd04.prod.outlook.com (2603:10a6:10:234::27)
 by AS8PR08MB8567.eurprd08.prod.outlook.com (2603:10a6:20b:566::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 13:09:04 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::39) by DU2PR04CA0052.outlook.office365.com
 (2603:10a6:10:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 13:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Tue, 13 Jan 2026 13:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7kVyQJI0cLQ+lJSQnqsf0NGzBRszbOIJbR58G1Z0mZ23pa4KwoxyK//mw75YHTgIE+DcWRCH5TdcqTXRgc9HRaqJMySuz6i1NeS/wrfSw4JBc/aNCx6imz/DUjjqIQYubvaFekSEM1c4wiFe8jjLsyrcGhzMzuReTGhBgafYEsvfR3a8mUoFM20nmCAmzpNqRaO+mgHRJagBC4GoSk8C5UfFqb/nAaNYjbfvrRn7TWFE8B+zxSvab1YtKE7ZDZsD2Ota+m2jYvjxDo86DzcT+nc5dAnjymPhFCQ7BNZQfQHFKuJCf1xypnKrYP65yeWXZ+I/2kwpArnFYG4qYRQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=iH2oi+RfnWQ/gLmZfpq7rUTOeNNNnE7IGcKa2y3yLlK6Fr1AFQQg+fCDAHMg6gFGBYPVY5ShormV0wQ2qg1QGxtUWjJbMNM2msOUykt5TQQQB5+0XmXwU3ZGSy8tmG1meUrE3vtBzPHt9oX1jqIyZkxgRpcGKydqlKeeiuHMOEiyv2w7D1Kvg1DEeIlFrD5xj2degzwXTd6rn2mUWMcJwOxf8NAXP5AAg0C5mEDzpp7aQNzKXch4r1DEvMQls5YJn+rsgDW4ifDNbNDlIT24BGBrPBFQWFIm7nUDvAx8sgbwx86wNsbankFU7tkmwxgX7DOwD2twl6oPKOnSS4aHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=qflYXA+CWiOpeuuSY/HFu7rQdFukrLSV+IdOUphrtwniV14c66Sd4tPln/Qi/9xStL7lnpsiwlRg6GDWXMENJJ34UpoU0C/jkVKdBNE060tOWbEAKFYCd6gRLgCRGgAajvb4OxYGpqpukQi0BLsFtXq1ICX3rCfUnAJZGZy3jt8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 13:08:00 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:08:00 +0000
Message-ID: <80a7cf2e-8c21-4c7d-9165-08608c569eab@arm.com>
Date: Tue, 13 Jan 2026 14:07:26 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
 mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 liuwenfang@honor.com, tglx@linutronix.de,
 Christian Loehle <christian.loehle@arm.com>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <ef8d8e46-06eb-46c1-9402-d292c2eb51f9@amd.com>
 <20260113115309.GB831050@noisy.programming.kicks-ass.net>
 <20260113115622.GA831285@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20260113115622.GA831285@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::13) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GVXPR08MB10762:EE_|DU6PEPF0000B620:EE_|AS8PR08MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: e93edb2b-d847-40d2-2ed2-08de52a4ecfe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dXMvcEJVbGtKR1V2OVQxeFlSTVFJUzNFZnhCOGg2cVlIaWxZNnI3RGlKajNR?=
 =?utf-8?B?N25nZVNUcE80UmQ2Y2cwZ2VwY2s0T0JUK1A1NFkybmlqOWhaZytLLzI4dytU?=
 =?utf-8?B?VWlxcEUvSXdYN2R3RHpXSDdnY0RSdFZMVGdvYlBjeFRaRE5CYmtyYkpXYSs5?=
 =?utf-8?B?R0FpampXb1FPNlNNajZzdlhNQ1UzWDZmdWkwdHZGZ0x1b1RsTU5WdnA3Vjlq?=
 =?utf-8?B?UXRkRzBzS25HdEpFUFh4RHk2YmpNNXFFdkZreWRmaEFOZkZvR0VXU21yUm5n?=
 =?utf-8?B?eC94YXNPakY5dWVRdWJmd2FxMFB3SWMxeXN0NktHUDlnakxETUg5WGpKM05J?=
 =?utf-8?B?NWsrdEdia2Z3WFl2d1pXbTRlSWtlYUxMOWsxaDRRSXdTeUVzNUMvNVArZ3BY?=
 =?utf-8?B?R1ZUQXQxM2hNR2pJZm1IRGJ1K0lzSFpTQ1I3Uy9sTGFaTkNrdWlHWVU4L00y?=
 =?utf-8?B?VE9hM1htTXJacGFpRU9iK2ZvbmFCSUM0VmxyNU8vNVAxNmFrTlhucTJoMXhm?=
 =?utf-8?B?OTZ6TXhSdFIwOXJ4dGFZM0JKK0tNamY0Zlh2K2ZmTHZvMGs0ajZuWXNqVjNZ?=
 =?utf-8?B?OFYwTVRVWG92WEZkVjI3TnoveThHNDJKeTkzMS9mLzIwSy9tZm5vTStmd2F0?=
 =?utf-8?B?U1YrcEl6bWFDaTBUUFVnUWs2UXlUSGVQbVBZeXdJUzVsOVZJeG56REZTQ3BU?=
 =?utf-8?B?QWZMUVBrRjAvWnAzVTZyYmsxR0FJVmpCamFWd2U1Sk1WL1pCZG9WZWVoMlE5?=
 =?utf-8?B?WnNFSUZlS2VabUJRdXVUUGlVamVSLzYvSWc5Z0dEMEhiRGwvWjdoaDQva3Zz?=
 =?utf-8?B?MEdvblF0bHV4dGlGZlZuTDhVN2c3NjBkWkpNN293WkF3WjB2R1M2dDFuMzBS?=
 =?utf-8?B?U0MrTmV2WUE0UHp5VGIyN012SnBPQnhhdDdsRkdZY3ViRS8xbVg5eEtHOG1X?=
 =?utf-8?B?S3NOSW82TWI5NGU5RURwZlBoWGIzcEpEZU9YV0c2TUE1clFEUDAwUzErL2xt?=
 =?utf-8?B?T2lJY3hYRkxGWnYzVlhKWDBydHlNeDNnQ2J2Qnl6RWFGYUhsR284RnV4aTF4?=
 =?utf-8?B?cVRQQnRjRG16TzhEVHhoRWdmN0UybDY2WWxpS3RVSXdwYWI0ZlhlQ3pET2xq?=
 =?utf-8?B?eE8vdG9GYWdya3NMQmdDVXhPWlN1R05DMXZ1a2t1YjlCTzE3RzBobm5iS1Vq?=
 =?utf-8?B?enlPWmFhQzVHTHYrajFDWDNYUTJnSGpNSXpxQjVKS2dLQ3orOG50TGhPN2tn?=
 =?utf-8?B?VjRjdEt2VHlWWmUyUFlSRVNHVEh3V1BVMGordkdrVDFTdEdOa09uUXhOc3JS?=
 =?utf-8?B?TThNVnh0NC8zUHN4M0V4UC8yTGsyc0VzYjJuUnYvQlNOeEpaM3VvMXJXR1JV?=
 =?utf-8?B?a0dvc0FTY0d3ZkMvMEpISTcyWnBaUnJoMDludWJHTm1FOHpLaHFPVzFmbCtN?=
 =?utf-8?B?cE1BZEQzVU1GbitHOUlacnJ1Y2hSWTN3cW1HRWxXS2MycnhHZW44dDRCc2dH?=
 =?utf-8?B?SERiN2x0NS85WVFuRTYyMk05SUhBUW0wck9JcSsrOXJpeGY0NVJXeUZxMmhJ?=
 =?utf-8?B?Z3VLL3ZDZWY5U2F0bk1yYkpwcy9oM2FGbGltVzRzMjlKL3BIMWU5NTNJaGxa?=
 =?utf-8?B?RmFWelJRT0k1eVRPMmpqVUpaL0o5SjlWQzB1NlhmZCtXM3lhWUo0TlRWV2hk?=
 =?utf-8?B?czk3NWhrVEdpZUpaeVlhdGlvWmFZSy9NYzhySnVYQjBPdDFWNFpqZElFM252?=
 =?utf-8?B?L3NxNURqbDJBbnFPbzB4ejBvU3lSVHpHQ1BzeTB0QmMwK1gyTjdTWG0xcGF5?=
 =?utf-8?B?Ykt1c1pkUEprSzM5SmNKWGlTd0wwQituS2NtRVVpbGhnZlg1MlNUSmlpaFZz?=
 =?utf-8?B?cCtTSGs5MERXclRxNlZBaWtsWktJa3ZTNnl2YnNxZE1OOTJzbGx5TXBNY1B5?=
 =?utf-8?Q?a76XNAyH4MHMt2qK1OIG5wAXR6oF8av4?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f863a8e7-9346-4d81-8436-08de52a4c6ae
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|14060799003|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHo5S3lQcVBlaVMrbmV4Z3pBMzZmbUZDQkxnN2hPbkFQd1ZGNFhLSUhjelg3?=
 =?utf-8?B?TEJGY25kTmtBNzhwV29ZWnNrOWFvR2Q5Q3FuMUdHYXZqRTUxd2RVL3IrcUh1?=
 =?utf-8?B?a2grM0FiNjBoSXlQREdUMFJhSEpJY2RWZTRtdkc3WFo1YjBNSzM2STc3aVNY?=
 =?utf-8?B?ZmdnR0hPMUt2QW5sbVl6ZU9QZ2VMdHVYY0JpckFkQ1FGZDlZT3NtdlhRbFo2?=
 =?utf-8?B?cFdZNTBmWm92ZUduZEU5K0tlZ3VYbnloZ3gzK3J0ajNtSXJqSThBZzJSNzRw?=
 =?utf-8?B?MDdqM0hKT3IwV0lLNFZ1SThhRGVsRkpCSFdNRHZxSWNiQk1HN294UjBmdXo1?=
 =?utf-8?B?WEF4UGVVVjZmdm9pL3JxSTRzdnVzQ00xMEM1ek5HMHo3STNUZUcwZXJXbnhK?=
 =?utf-8?B?VzYwUGJ4Zm5Mc0hpQmJ1aVpvUGRuWWJFM3NJS2FLZHc3YzluTnJaM01Zcjkx?=
 =?utf-8?B?QUVtNUVMZWhGY1R6Y2tlUFdEY2hiQ0dENXY5UTRnRHZ3WmlQdGtiaDZjR1hK?=
 =?utf-8?B?RVVvaklOdlYxSElEdFVBd2s3T0NJYThFdGpPZWd6RHlDWVliNTRIZG5ma0Iy?=
 =?utf-8?B?WTFiUWtPZTBQQ25naHZvb1NvNDBFVnNaSTg5NUJPanJ4S0R2ZEREcGJUWTg2?=
 =?utf-8?B?cDVrM2FvZVZhVzh1N2VzWXY1QWlEcWdMcXdVWjRZYVFHYTBoaE9jbnJKL29i?=
 =?utf-8?B?TitzZ0g3Z29UUXVWYnRiT1hMVWhjN0I1cy9ZQjZvNTQ0WUxpenJLUHhHK0cr?=
 =?utf-8?B?Ly9sQzFSNmYrbm5heGVJOWNHVmVoQ0FMcHNMLy9TOTAwWkU0dWs0SlZiRWF1?=
 =?utf-8?B?Q21lR28wZXVsajhUdi9naXU2U0t2eVFrZERrL3E0TUJ1V1lNWTZWU05NYmwy?=
 =?utf-8?B?M1R0QzJHY3FOMjExQWdsVjJvejNVWnhjZksrTkYrWEVJN0NhN0R6bzFubXU1?=
 =?utf-8?B?cVQ0ZUx5L2FVQlV5clZCc2pVeDk0MFpRYVA0MzVld3pjVmNXaEJ1UllKb29P?=
 =?utf-8?B?UXhDaHcrN1AyZktwN3ExeXZ1cEdGeGpLY2xyNVg5bTRuZi8rOXNOeFpMK0l5?=
 =?utf-8?B?QjZnZTh2ZGF0cG9LUHVabnBaTDZFdWk3YStCN2dwQm1lQXlZTE93OE95bkx6?=
 =?utf-8?B?ckpvQmVlRXV5di9sU3dJdWJaNFRQcGFjZkZ4MUdhMEN6Zmx4eGpJRzB2TW9S?=
 =?utf-8?B?YU52K1JsS0VqRmd6eWtVSGNjTW9tUUJ5aUU1UTVPeUtvYy9NdHk3ekNCQXFq?=
 =?utf-8?B?dU1LcGtwMDlQTGNyMjhWWGZWS2piODNSdjRiSGFCc0tQWmp3SXlQZ1dJejBy?=
 =?utf-8?B?bXFoU3hYQWhkM01COVdlN2x3UDZoUHdqLzl5aHA5czUzZlhPUjdvNUJ0V0Ji?=
 =?utf-8?B?VHNFUGh1SWJFZm0rYzVRZndaRUxmemdrcE41dlZicHQ1dmRaUVFQRkpFdmtT?=
 =?utf-8?B?K0QzVCtYUFVteXBLWWpXVk01SUxFY1ZNSGVoN1dSSlZZSEZVSWJCL1JFazZG?=
 =?utf-8?B?MXNJV2o3UndUbmFVaktzSlZ4WFJKUXpCaHpPRHY3cnFDZEhjalBhc1k4b3FY?=
 =?utf-8?B?ZnJaUGpwbWlXMjJXUnM0MUNUUFVqWHlHMlNyd2FoenNVWGRvUlJPTWExWFl2?=
 =?utf-8?B?Z1hnaWQyM0pvR2ZpRVBCa1MzVFJoeUJXUEFDeXdzaWpUdDlGeGhJV0dXR2dn?=
 =?utf-8?B?a05lQURjMmYzeFVoZko3ak1nYk85U2tMRzFyU2U4T0h2M0hGcFBtSHdNNkp2?=
 =?utf-8?B?UWFOYU5WejdYL0QybGFQS0Z4S1hFK2U2NjkvQVZzUno5NkNaNGpLQVUxaWVO?=
 =?utf-8?B?NUlMaHJubm5aUC9aVklpcWpHb3BzdzlpS1JRa2dEaG1HUjRLUXdLQjlyc3hw?=
 =?utf-8?B?dHVSU0pDZzNuS04xakJIMlJZTVZmN1RaVWVKVENUQTdkZ3YwQit2TDN5NlBW?=
 =?utf-8?B?WlNINk56Q1ZiWSttM2VvUkp1QlNYYUZ2dDc0dFNxWEZHcnJTeENCMm9MQ2Z4?=
 =?utf-8?B?Q21IdVNmMEhxRWlhakRJUFhhWnB4b0dLdmVseXhDeXVjNzY1eWVqOXZIRElZ?=
 =?utf-8?B?SWhjWmRJOXhTWUE2UFVwV29SY1NOb0xZN3RSSWRyek94cDN1MFFUbUp5bWNu?=
 =?utf-8?Q?zsIY=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(14060799003)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:09:03.6361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93edb2b-d847-40d2-2ed2-08de52a4ecfe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8567


On 1/13/26 12:56, Peter Zijlstra wrote:
> On Tue, Jan 13, 2026 at 12:53:09PM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 13, 2026 at 04:35:02PM +0530, K Prateek Nayak wrote:
>>
>>> Does enabling WARN_DOUBLE_CLOCK warn of a double clock update before
>>> hitting this warning?
>> setup_new_dl_entity() -> update_rq_clock() seems like it will trip that
>> in this case.
> Something like so to fix: 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
>
>
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -752,8 +752,6 @@ static inline void setup_new_dl_entity(s
>   	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>   	struct rq *rq = rq_of_dl_rq(dl_rq);
>   
> -	update_rq_clock(rq);
> -
>   	WARN_ON(is_dl_boosted(dl_se));
>   	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
>   
> @@ -1834,6 +1832,7 @@ void sched_init_dl_servers(void)
>   		rq = cpu_rq(cpu);
>   
>   		guard(rq_lock_irq)(rq);
> +		update_rq_clock(rq);
>   
>   		dl_se = &rq->fair_server;
>   
Yes right, enabling WARN_DOUBLE_CLOCK detects the double clock update 
and this fixes it.

