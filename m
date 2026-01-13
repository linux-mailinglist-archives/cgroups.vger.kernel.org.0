Return-Path: <cgroups+bounces-13153-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A19D190E9
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99A83013EDE
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676572610;
	Tue, 13 Jan 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TlQ8HRDK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TlQ8HRDK"
X-Original-To: cgroups@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410A38FEFD;
	Tue, 13 Jan 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309884; cv=fail; b=o0wGVRbFThcYwzzbYt0jY5famwX1S/YeWQkE/JDqeLcsntF0kb55Z1GWe2jopq0ik2YT7h9DYWrwBWNYybSwbjHS+ysr0UMuqfwC7cLFm88tZGf3WuN/FuTtIIp1bWAx8ZbTBR5/6VQPo55+5GsW2oQtYVTVx0DLZCGaoXnyDEM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309884; c=relaxed/simple;
	bh=cRWNX3c3KHo1tStmND4z7F3yi54WrP+ZMfb6Hk4qv+o=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtAi84U6xAkL4Vco3Se7INiQCHURb5H88gNkuiFjsLXS9S6JkPTpKB7gWkyV7YYH9MPxpAluXvFtmx64AYsm8mKhpBxfYCz0T5CfbyWUudSKhc6XoK222bg9Dxu1gPDraWH4F1YpB/rkZcaCR4faU/9pARBRNdzipxH88qWX3xQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TlQ8HRDK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TlQ8HRDK; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NM5o3T9Vu6HLdRV/cWFii4Kn1fV66rMloZZOnk1Bj7hgQzlbngH7S8Jis5nNJfdhvrr+8MFWVJBUlvvtBPmjBmlpqkdMuCNlgBWnL6DsHA2vpf+S2STGihQUMdpZiyKAQGtmOh9pA2Z/Bw6QgjUjWHUfkRSKoDXUK3cyuD0aRaRh+6By1jd9DvGw1yNvZ6J8+uuKYPdgfGx7bp5LqXOgGa83tEbwmEnsWm5Vkw2F5alZgbwG+GifefKQ0oqzFiiKLmab/RS2Yo3d37W6EyelXWZQTCcuD9gSCaJZMfe3ABXZ3uDA3SwfySCoJAyCAG65NuGZUGMl+MDDJmfEW0wVoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=NLP2/DL0kr1HkCHmr9hQtbIpe37+xM5dQyHXglUviO4HngNM3FIRkKGyvd9t/H4jNLjHeoXgzoJL59swo+H4sjKPdea3hog+qxrZqRsjJVlsGpSae6GQ18NkVH9pCKhEVSWcbKdJX41qxKHJILwSfFfS+t45z7qi+V2DNiEg5BAhp83RRvDHk4lbBCmnQhr7GsvLlevJ1djMTl2SNpPRWtx/VzfgF780Z6EHiarI9gDOS/vxVPHxchnoDP7nk/3qo/P/2ys7BfAOT+YzLEcIAmXX4lJwtMNjgUTP6u5ziA+ouIY0GHDmjHoYrnangltb1FAF1F+Cn2Hx2NdxbpFWhQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=TlQ8HRDKIp/yw+FaK+dbPSheL+bO2UYkfcDc257ofeDnqR6Yyiu4y0WCkhYwhIufdAPcI2s+dRvz8ffyXcvMYbk5yil4HyAQTfiya7UDZ8VTtIEHiSO0D/V/tZrsYe6on9dLbfsSmzWdLAWQIbDl7vS5wK4EFE0ZFg4y5/QP2JY=
Received: from DU6P191CA0055.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::26)
 by GVXPR08MB11610.eurprd08.prod.outlook.com (2603:10a6:150:326::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 13 Jan
 2026 13:11:13 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::f1) by DU6P191CA0055.outlook.office365.com
 (2603:10a6:10:53e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 13:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Tue, 13 Jan 2026 13:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUdppNR8do7pAG7P1zrFnf1neUyXkArrh0+oqNUHfzcVQWXslJY8KRVEXyEh+Ak8ZoKb78iHZWCQRxsDb0cQFnc8cqKYVqeyVP+0ZflBPyoGYlG1hSChQquB1RUAcS90DzdWr+fYy4mZFAUJRANtuc6273cB787L3R/EdnufF54fq00YmTYV1VTinCOd/vxsQEMfX+ctGsUu4WlOPoOUWcY8dVS2styE9HbTqRZVoROuZNCpwzG78HTIFskqNmHdWSBiGxT9sbufLRIZifh4z+jkoe6RwoKwk5OdtwZrwTJNhlpvu7+FvxIrJhq/WwrAHVFALzOvMVQJtdz2V3XPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=mGwQ/Ch0SJIJIE8OhL+2gYGdxyIwak8Pc2eblp7VKf72dxDacl/6XAsEWkoKt2pPl6j7f796E3GD4NnEIiDsmxDoKWy8jKLeyMjmxQzVhXCywhMgoprSXhR9tNZNudNfkYgmqSbcLUxZf3gHHOar+otaQKIliHjY5zuz1RJHUM58GTgGTyloXPGwJiF5//fVi+7U1O90NzMV8RvvwE91UahGJLZlp59T18qO3JeD185vjCMvcJvh3jlG+YwRmZ9DM9l30cercSdJf7bRiRUGngpVk3NcxzYs7a+AYm7xVs6/jUDhcqXfOo4WjltT2HgdzcanD+iK2yXbqVlNqPr43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPbFgyEvgpNtLP+MHPEuqyT2xMOCGQJrWajT2Sj9BvU=;
 b=TlQ8HRDKIp/yw+FaK+dbPSheL+bO2UYkfcDc257ofeDnqR6Yyiu4y0WCkhYwhIufdAPcI2s+dRvz8ffyXcvMYbk5yil4HyAQTfiya7UDZ8VTtIEHiSO0D/V/tZrsYe6on9dLbfsSmzWdLAWQIbDl7vS5wK4EFE0ZFg4y5/QP2JY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 13:10:11 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:10:11 +0000
Message-ID: <5f3223ad-42f0-4175-8f09-596b5edda00a@arm.com>
Date: Tue, 13 Jan 2026 14:10:07 +0100
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
X-ClientProxiedBy: PR3P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::16) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GVXPR08MB10762:EE_|DU2PEPF00028D0C:EE_|GVXPR08MB11610:EE_
X-MS-Office365-Filtering-Correlation-Id: 05158c35-0afe-49b8-e1e5-08de52a53a34
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MEpjM1hYU1ZxUytBTnVCa3ZMUC9wN3U0M0JOaGNHMTR6TUIvRG5SblZrOVpE?=
 =?utf-8?B?aVBoNUIraGp2eldrT2FzSEwxZG83RjMySjk2ZnlOMzg2R0JOWStrRDB0WUV4?=
 =?utf-8?B?UWdzdmIxSHk5QkhYTGhvcWFEaVBTMU0wdGdIUXJoMnBJdm9WQ1l5aUFwai9B?=
 =?utf-8?B?L29NbUwyQUpTYmcvMzZIT2Q5TlhMZnRCd2hJQ0NjNDlpQXdMQkNueFNmM2dM?=
 =?utf-8?B?azYyN0F1OGROelRieDVxUnVWOW5EdmJQVkJZT2xwcEY4amY0bDlLcFAvMkRh?=
 =?utf-8?B?d2l0Wjd5dm1NaENkcEFhN0UzZlRVdW44MVRiWmJDeUdLMFJEdnpqU1c2WFhw?=
 =?utf-8?B?QmtYekQwcWRtcTJ6QlJiRmF1Vi8xT2d2QWs4SlhNbFN4K3R2SUFhczRnbEVw?=
 =?utf-8?B?eCtqenNGTkhGR1BueFZxVzNiTE5pUkZBbzFhNFpBR2N5Ymp0ZWUzZjlIUVQ3?=
 =?utf-8?B?Qms1K1h3ZS94czk3S3o2ZGZqRFRXN2Z1akc0MGpIdTkxdzZ5eGZVOUtOREpK?=
 =?utf-8?B?TlJZd2QrRTU1Vnptd3BrNk9KMlBMRW5IS3EybmtVSitCVXJkc2FoMTBvYUQ5?=
 =?utf-8?B?NWZiaSttbUdaeHJuQVlCZ1hJTjlSRTdkQ2VKTklsOTYzWGxLKy9hL21ZUFgy?=
 =?utf-8?B?ZlZyR0RHWlFjNlRidkZ6Sk5ScjBwdDBNTTBCVWhraXZzYzRrWS9XT3N1VGE4?=
 =?utf-8?B?ajJXdjFkUXQvOVVPR1VmSFUxdnF1VVN3TlQxZjN6cWNzNmhtajBoOU9GY2t3?=
 =?utf-8?B?aVFQVTdWSUsrMlM1NTE3YUxzMExMRGlubFdjSExtYU9zaE0xL0NIMnNVN1Ur?=
 =?utf-8?B?VXB1bTJBNXF2cERwSVBlT3BYQklaeGFvY21IbGM1YnZkeXlnM241eEVBb012?=
 =?utf-8?B?U2pEUUlBOXE5eS92YUd2ZlFyT3I2Q1FBSm5kYjE0SlFFQ0N1R0tIb0hsVWxX?=
 =?utf-8?B?bjdkWC9kb29BL0dzRVF1bk9UZ0hwelRwRktEYk5EYkVYZkw4Qm5qRktubXBo?=
 =?utf-8?B?dUVvNFcvS0JDUnFFaW1YeDNGYVZFUUEyV0xuVUYyUk9ETTMwVVgxYy9oT1hZ?=
 =?utf-8?B?eWI1RE1vQk1ua25yY3o3WEsxS3F4aHpnT1R3b3pHZzYvQTRaYkdraHdLcGNJ?=
 =?utf-8?B?anpQd0xSalR1ei82Yy8zaFpCK01mdEdGeDNsV3RBN3IwM2FETkhRR1daZDN0?=
 =?utf-8?B?aGhOSUkyV0tJS0JxL05YUXE3VjZEVkZvY1VJMmRrc1lQTmNxNDVteFBJTlcx?=
 =?utf-8?B?anBxMWFsWExPZjBOZGMvOEgvNkdDSXp2S0lIaTVuRlYwNkdTVnBSSDArMEdu?=
 =?utf-8?B?ZGl1KzlhRWRsWHdRQTdja1BFdGh4STl3c21VNDNjZWRlaS9JczV5Vks1cEtE?=
 =?utf-8?B?UUJ2SkRGQXhsa0F5QWpCeUozNGpNRHRDcjFKSytmL25LTytCK05nQ1ZLWldq?=
 =?utf-8?B?UmpEUG1KMGVpd3RHMzhGUTh6YXFvVjV4cm5ZdGFObzZmeXJsOG0yRWxtY0dD?=
 =?utf-8?B?RUlyWFdTN0tScnM4cTZTUXVQSXQ0Q0VweHFPUWFaUlc2b1IwN1JlbkVHNWxk?=
 =?utf-8?B?eWxWdGh0Q2N2cFdIcW9md1BIc1FtWHJPUkFFeE9RaVhtK0xITEcxZjduK2hT?=
 =?utf-8?B?K1dBVm95cmNtVlAvb2pVMXFjQ1NZMlV0b2cxajJ5Rnpab1dscGJRYUY2bkxt?=
 =?utf-8?B?YklMR1ZiWWREcFNzakczK1ZmYlVBVlBmU1ZydDIvOUJxeml6TmFxRXEya3BC?=
 =?utf-8?B?bXJ5YVhiNkpUc0lVV25Mdm9YVGdKaGlUMlVyTkZVd05VSzB0YU5YRklYS1Np?=
 =?utf-8?B?d2hCM1lnZHpXRWdNT3h2dlVyYWpKWkZFeWc2eTN1ZlJqVzlHZ25PUmZtdVYy?=
 =?utf-8?B?bkNKN2tHcHIvY1AwMFhob1kxcFZoM1cydnlVVjlmVzZIK0hqcC9lVHM5cmdU?=
 =?utf-8?Q?52QQBinbRxrS7vFWH/NdkP0tgrLv7VfC?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1d55f53f-9341-466f-aad3-08de52a51428
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700013|35042699022|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXFPWTVCbWg0Zk9VcXV1NCtmdlVCL3VtcktlaFAzR2ovZWhOWnBkUGJlM3NY?=
 =?utf-8?B?YnpGNzlhdnRGcU9TN0FvT3l0WkJoVzRXbDhncHU3WHFhMi95bFdwbjZPSnVH?=
 =?utf-8?B?TGY2bTl2Nk1yKzBwd1ZLTmV0S0xYNTloYUowdjlaK2tWTW0zRDF4LzYzN0NK?=
 =?utf-8?B?VGNROVQrQmV2cEd6NEp1TTlwT2Fub1VleGFSbjJnL2cxREJ6SDRqZTRWdzZz?=
 =?utf-8?B?NHBuYUQ3MXdPQ3g0U3huUHN6b201WGFsUkU1c1BGemhTTXFRYVlXUzZqN1F2?=
 =?utf-8?B?WnZ4VkpJM216eWhrTUJod2hlRE5LZkFOL1IyMEdMak0yK2Q1UVVWdmZQTWpp?=
 =?utf-8?B?WCtBMEdkbnJUOXRUK01XQk1uQUdKL2dmU1dHL25wZGtDdlRSc1A4MVE1dHN1?=
 =?utf-8?B?QnlDSlJqVVBpMlJCOG1OMmc0TlUwbURXUURvMnRWUnQ2MDU2NGhmV09zOW1S?=
 =?utf-8?B?ekNqMndYNnc4TkZaS3V2NVVrUTFMSHMvQVdhdHRJeTBhRXJId2prUjJKbG8v?=
 =?utf-8?B?T284Tm9Cek4yK3JpUk5EdmppZ1E5TzA0Slp5NUxtcUlHczhKRnRlcGh4dWtu?=
 =?utf-8?B?NmpHWHR2QXBEY3BVdkdXNDJ6SHl4ZXVxeFc4WWdaMUN6ZzlNUW9reTdRVWFi?=
 =?utf-8?B?eTloOThIazRPTEdhbVhXeFhZRzlXbmJMbDNvTkpDc0xYUWZnRFRwWnVwenU3?=
 =?utf-8?B?V2xCZ29Rb3hXb0lYNzdnMk1pd1lkQ0FaMUtGUkIrWi9Pc2s5bnlCQTRQdm5Z?=
 =?utf-8?B?VG9CVi8xTkFOSGZQTlQ0QUtxV3ZGNnVsUnk1ajkxZmw0VkE1dVlNV0VnZG5S?=
 =?utf-8?B?blFOdUVTWDZMR0VqLyswSUpnUEx1aUEvVFg5ZTV5UnVyb3U0Q1NnS2o2VTh4?=
 =?utf-8?B?aFhOTGtWK1VOMEZMQ0JDU2I2ZVBFcEE2UStuVUFJSkp3YlhEUFdxc2pLQVBY?=
 =?utf-8?B?NHNWMVkvdVNWNVMrdzlCdUZQSFRFS25CdVJDR2hlc05yTlVZM2xkUG8ybzU5?=
 =?utf-8?B?TFYramJTT2p3bXd2dFZtWFNSa2FXMEhCejdwTnd5V2laeUQwK0xsR0JzZ1Iw?=
 =?utf-8?B?RG0ydFF6OWF2TklTZ3RhQTBhd0JVQmQ3ZG43cFFEZTZYY3VHdndpVzJVQjBB?=
 =?utf-8?B?VjRrSnA4YlNtYXlZd25oc004aVlvdmtMVS80bjIzTUlYdU4vZTlJdDJsYVhV?=
 =?utf-8?B?UFlSdjFCclBMVWgxdlA3ZlA3d3lEYjNMUCt4RFJxdFRSNHFIclkxdEw0aGxO?=
 =?utf-8?B?VHA5b09rbWVsZTVvV0tYUlpBVnN1VlNVdVB5bGJCQmY1dk4yT0tab2FwSnlq?=
 =?utf-8?B?NmFrRDNHa2tYZVJLQW9aK0ZNUU1MeDJhZ0xpbDZ4amw2SnRBQ0x3ZE45cTBU?=
 =?utf-8?B?aDVYb2N5UEJBa3dPa01oUGViMHhUamZ2cm44YjV4ZGowWm1wYy9hTDc1MTNT?=
 =?utf-8?B?VmpLZ3ZyV1llOU8yU1c5eFVmMkxleWp6ZU5EaGx3QzhrcFRWUHFRNFUyTHdC?=
 =?utf-8?B?MCtUMTBCdHpxMEs3ZjVka0dCaHVDNEluRE9UK0VxYWdCcXJ3NzVQU0ZYaFdS?=
 =?utf-8?B?RlpJenNGZGZVbWxjcTVxL21VMmtQZ2VVK0QyVkxrSTFkSkdxYTZ2UHNnY2hR?=
 =?utf-8?B?ODVMTlpwbGY3bkYzNmd0OEkwb09XamFYRGFENTl4QUh2VnFoN0xKaUJxdVBj?=
 =?utf-8?B?Vm5sMXZReXc4VU9PejlKam9JRzRoTjg2TDB2UVdYdTVDRHlPcitZazV6blhn?=
 =?utf-8?B?a05HM3l2cjFENmwvOGZWV08zcWZBcy9hQmRsdTBVUk1IckUwUHpYc2x4WU1Q?=
 =?utf-8?B?TTNYTDM3azJ1Y2VhRnFTT0l2cmJRNVRQeHB0UUM4bEg2VUc2V0dHWTFBT2Vp?=
 =?utf-8?B?Q1dzcmZ5ZXgxRCtUYWZUV1BNWFBOdDBzR1hmVUlwSU5zOEJJTm0zdEo3NXl0?=
 =?utf-8?B?MXZsSmcxcGlpZXV6Qnh6TmMzQ1dJTWFvT2t0NFpuSUZSL0ZRVVRqd05oZW9z?=
 =?utf-8?B?ek9wbUJNSU8xNzRVcTdGbjZ1Y2ExQXpDdnZaOGZZblo1UWZWQzN0andreVVl?=
 =?utf-8?B?K3NnNUgxbERaVmFmZE5NcHA2SldvQmNVc0JCbnAveUQ5RGxNZDFaQW5BVnNJ?=
 =?utf-8?Q?AiKw=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700013)(35042699022)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:11:13.1730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05158c35-0afe-49b8-e1e5-08de52a53a34
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11610


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

