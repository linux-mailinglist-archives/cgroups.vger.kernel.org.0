Return-Path: <cgroups+bounces-13099-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9ED154EC
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D36E3015952
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFA280324;
	Mon, 12 Jan 2026 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NSJfwf3B";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NSJfwf3B"
X-Original-To: cgroups@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF892772D;
	Mon, 12 Jan 2026 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250733; cv=fail; b=Hyu/RyRXxJlBDAhdwxI9oTrv8YnuZp5nm5wKPiO6a1eFQQk2C/0jnQFeDWb1obihRkQh8Pio3pYx0MN6ttbURjx069mgFt6LF4P4B89a07B2iSRGgcdi1d50tV9bd5tn+3HvPAuJQeUQNIGVW3nRd+DLAppiKQ4GOnBBri0gLr8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250733; c=relaxed/simple;
	bh=sPLShxyoL0wpzu7B9hUWfpunnaCrVBT6vSlX7XGqF+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3DTYsph+F5Q1CI//lcd5MEGTguz+/V4eII+5qQdmMPxfHE5+fJOerGwXqNMtt3ZGNC4/2bdJ8qvo6RcdXvxXvf/oSHYXCW86M+sVqaUyHu0buufUdgnoY8SvXTj2TXad9MnO8+p3LtHGoO0v2PeIIAaoMt+ekZnZQszT67C9bY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NSJfwf3B; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NSJfwf3B; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YlXt1afkUri+KUCcSFx9uCHR9r7v80DzrGWKdYnnH6LpRx8AavDqMnj3ZOc053DI/R2tKEZX9FaU33/Dp6zV5waOtfq966CUTwzkdKp36POv7klb/swY0ECsr7Tg0SwzyMwCB+DEBs9Hm3h3us5Sz/M4ZBxMB/SvgqRbO1qHSIGwf2PdN85NnjiYAxzRvNrHoGhJMCYzfRLhdRXFPhkoJA052yhhaAELOuIUkiT9HC7BaQrByPVHhKuu3b67pDD6+dIfkd9Xy2K13UmZl36h9fdeQSuER0W/FqVgDx8Fvq3DHSn0INkqCilrYECDgkBtyTKDngGQyfuTocRFbOynRA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcRdWJosaZ0/oDTmFW5qhBqnuMWiLDSqu4ljC4Jq3ic=;
 b=hcayiSc3AT8maudbbe0L9PKORRFbiTPPJvxnfluA6kLGFaGFuI3S2nDBXULCG+ccz2SZEpn41hZ2x3yn+dSg7z5N3tChE9O3v62vwPrLAOW0+JFuONAY24Cw7lKhcNFWyqvK7Eg8tkt87OhE7sMbsdGnLCLB/U6uFdHavvoExN3Esdhp67e+NYZkwfFyho8AaPU4prFKeJneFXCTZbsFYx60clih5jOs/8LXhmnPHvcTKQfufza5JGEzXpna39NfhcRsAqXGaXfds4D5nSQwM+h+L75SqPkD3sApFRf8BnOIqPtwLNZbCy056qb4Prww6VxhrVLWt+j6fMJtCdiNvA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcRdWJosaZ0/oDTmFW5qhBqnuMWiLDSqu4ljC4Jq3ic=;
 b=NSJfwf3BTp8tAN+uuIr2XR883aSK80O3aoDW5Hza023jHMxah8QQOf/mReqUOChBAw+9yOeSQ1QkhtXbtNHRmS95/EWj8UPQgUTKzXQULmvEjwbSeZlECiVGsbgtvNyu4hSP5J1VLp8KQy7tycWDmM6Bqtlz8IMd/jDUNsgMkvQ=
Received: from CWLP265CA0360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::36)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:45:25 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::70) by CWLP265CA0360.outlook.office365.com
 (2603:10a6:401:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 20:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 12 Jan 2026 20:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvzoPy2TpUnOP4rK1FvI6TN+ndjgVd54ZJ2C8eAcbNWJ2EEbPzLQxDKpL0ROny1SaaXLY4IhNZ4siyvOFBd0Mqza3rTlihKzC41fznDu3OXTPyMhG05vBKRsSImh1G3oqIyl6bZAXc+GyifhleJguv7FQzYJeI8o3LEri6SJK2/V0aSnj4xywjrXs0uLQVYxR38aqYTP0x/rHr/MxRzyyxNOeuje0Er5GAU5IqVkqu5DXJ1Sys/96XIRQPzXXqlG9VuZrhObvk9p1+0v3zK1NXBmQr4YAwnpr3ibpV85MBEXKPqfE6Tf2/oXLQ5uYk11beGDpRkAavAyHjzYBKrO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcRdWJosaZ0/oDTmFW5qhBqnuMWiLDSqu4ljC4Jq3ic=;
 b=lNy8oEaevemOSCT49+codfI5PHxizbP0SsdmUoA4SPcoNLR4XdXqjj4E5KaPPcXvlUADHyCI2wTRf3zOb+qdI/9DEv2eNPzk7+5zjvt+gG1JulYdQuw8geColquIhlPS3wQascGy5ybhey9QTAKICkWr07NzNaFCPFMCY4xe2tlEZ+7d/gWsQnshRHwEZNbt19IGz0dfF1MxC7qOq/9mELQG4+Y2EyO2XmjE7m6zPi+co890Tg4/8rux4lcAYQqtnHHYzaxr43jW9//FKM15X+3QlfHeS5/Dm+0vxzgLqG9XbJYB/NBImvfYTKgOH6WUgXaaH7XXUtvL5gF8BmllVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcRdWJosaZ0/oDTmFW5qhBqnuMWiLDSqu4ljC4Jq3ic=;
 b=NSJfwf3BTp8tAN+uuIr2XR883aSK80O3aoDW5Hza023jHMxah8QQOf/mReqUOChBAw+9yOeSQ1QkhtXbtNHRmS95/EWj8UPQgUTKzXQULmvEjwbSeZlECiVGsbgtvNyu4hSP5J1VLp8KQy7tycWDmM6Bqtlz8IMd/jDUNsgMkvQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAXPR08MB6336.eurprd08.prod.outlook.com (2603:10a6:102:158::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Mon, 12 Jan
 2026 20:44:21 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 20:44:20 +0000
Message-ID: <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
Date: Mon, 12 Jan 2026 21:44:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de, Christian Loehle <christian.loehle@arm.com>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20251006104527.083607521@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::9) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAXPR08MB6336:EE_|AMS0EPF000001A6:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 262cfeda-43b1-4c74-c4dd-08de521b8246
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TUhzc2tSMzRFdzBhT2o2cVUvdjhDL3JYRDljdDJYTmt0OEI0QXpHNjkrU2Fk?=
 =?utf-8?B?dDNSSERxTlplSTZHS2d0QXA5WW9tOUJlSExmVk1BdXR1VFF3d3lJakxBY2lQ?=
 =?utf-8?B?cVR5djFhQnZ0SmEvVnNoeFV3d2ZoMk1YNmNHTzBQQnhpOTZKMWpvSTcrR2JZ?=
 =?utf-8?B?NytveDFrWTRQRUlrb0R5c09pK3ZTejgxZHNYUXNhc2EzSXRmbW5PUTBCWkQ1?=
 =?utf-8?B?WTBkRkpRWmJ2cDEzcnc2ZC9XMHZtaDBrVGhCQXZSRURmWVFxSzRqczJHM2wr?=
 =?utf-8?B?Vi9XTXR1R01qVXVwTk1UZ1lERFdia1JCTGFMdzJUQUlXdXNxek9SaE0wRklm?=
 =?utf-8?B?OTJkQ0dxbXppdm1lc29Kb1JlVDJ0ZnZ6OUdhSFZKU2Myc0kxTzRyd0JWWlZw?=
 =?utf-8?B?Z0k1eUczaWYvTW81RE0xS2tPVUVTWU5jY0VEUG5IR0o0b2RNOUpDYllmUUFP?=
 =?utf-8?B?MHFkQlZEdHVlRGtiN0RlZmNvV0NiRmd5ZVlWTnVkVXNkVlZnd016TjFGVlFO?=
 =?utf-8?B?TW9BRktnblNGcWpmY0NVWXBkMjdoVE1FTFNqMVJKKzN3KzlreFF2L1l5UXNs?=
 =?utf-8?B?QmVIa1lDYi9JUlNqVDRFR0xNUExvWC9EOWtUSUZ3dm9PVFduYmlud2pyZllV?=
 =?utf-8?B?Mjk0bFNFK052cDRSSVF2U3BrQ3hqVHZEc0dYenRmWnpZdUorOFF0MlQwMDdU?=
 =?utf-8?B?WlN5NnpZV2xDQ3RlSCtwb0tha0ZxcmpEazB1cVF6S00wVktldHVTTXdwdnYr?=
 =?utf-8?B?QVJoc1R4SUp1N0dvaWZ1OHdpRDhBNDIwNmVBWElCUUREMzVOLzB6c04vdW1i?=
 =?utf-8?B?Rk85ZTM2UExWNXRETGZlU2x5TWlQcDhOWXNUWFd1ZG5DRVExTUJqdWhQZmpi?=
 =?utf-8?B?cW9ObW9DZEVFY0prMURUZm9SVTVJeFA4UE82a21sd2YwTzN4dHE1WjNrRS9I?=
 =?utf-8?B?eGNJLzhnUThxNTFFS2RVdWRHK1dyd1c2LzFSdWtWa1kzbm92WTZPVkR2VzBo?=
 =?utf-8?B?ZDMvZHdjYUhPUnhCaFhkMXh2emtNTHc0VG5mQVp6QllnWC84Wi9mWG5iZGVS?=
 =?utf-8?B?S0lqQmcyQW82R0FhM1hxQjRDTzVvaUErMGlaVVd4bEZTYW1wNkl1MlhuVGI4?=
 =?utf-8?B?NDdJSFFNYWdsV2h1c1lRUFR6akVZL1RzZVVsZ0NpaEFtMU5RZkg1TDFmQzVw?=
 =?utf-8?B?Rkt4WFdBVHpRR1EvczZpQ2lWUnlYb1Z6ZFZPa0cxbVIrcWtpSkpweDRQL1BO?=
 =?utf-8?B?azhiV1BrMFAxMWJzUnRGUWJmS2RwSzg3NU1tSGpKQ2Jya2U5eXZFSFBjRmxq?=
 =?utf-8?B?M3hHSU9ubWQ3d1VvTHQ2UzY3YnM1UGtxSWR1Rnl5Nlk2Q29XeHZHRk9MWEpP?=
 =?utf-8?B?T0hJOFg1VmFiQjRaNjNVVE9TeUxybGdSUC9uaFhPdk03cTkrNGEyRGlPc3NJ?=
 =?utf-8?B?TUJkMjh2VDhHQWZqS0hCcFR1U0FNY2xUMzhQQ0Jaa2lrRkhzSFU3RkpXUkZr?=
 =?utf-8?B?UlZJYUN3TjNLeUsxZGs0c2hha1pCcEpBNVIwWEhYMTFpd1ZTbVdxdnYyTEN4?=
 =?utf-8?B?OGN1OU8vYnJlNkxVclZOc2VnR1JKdFliODIxeXpwK3JNNTN1NFlwVHdpZTJW?=
 =?utf-8?B?bVdnY2V4SmRrZnZNZDduMmR2alVZTS9URG1GSTdRQ1JhWGFsR05BRGtZNGNa?=
 =?utf-8?B?c0UvVkNZMG5ZSkh5WUE4Vk02U1VPM2piNit6akZCOUN1NTUySmN1bnN5T2Y4?=
 =?utf-8?B?Y29Ga2JDSDJwZzdDY25iT2RSU1lmRy9xRnU2N0kxSWVBUTJNK2ZTY3NWQ202?=
 =?utf-8?B?Y3oxaDJZdWRnTjlNbTNnWWlybys0MnRuTG9MczQyQlVhM1pKOFU0bXdBalE1?=
 =?utf-8?B?OGlCQjMyZzRPR3FqVFNhU2NNMnF4Uk1yWUg3bXZZa1FhV2hMY1dMbjU1Zldk?=
 =?utf-8?Q?69cOyTBfUCAcN/OGis55MeJLEmMNFyac?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6336
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5436aa4c-328e-4edc-af34-08de521b5cb0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|1800799024|36860700013|14060799003|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUZ0MEJYSW1qZVhrOFExcjZaZ3dwTUF1VHMzNFprV1FTbDFzSHNYdnJlTG14?=
 =?utf-8?B?SHZFYTZ6TmNOL2xKYUhnRVhuMWZpYXQ2NTBSeXJlNkxvTHZGSy9vWm0xU0s0?=
 =?utf-8?B?bG1OVTlHRnYwZThvT295ZWVYSGdMVEZhTUdMcUl4R2k2T3VDeEh3WlB4VnFa?=
 =?utf-8?B?K0RsY0RyZkV4UEJBM0ZhUXhmSGxNc0ttVkxQV2l5VWJVU3I4eU4xZ0dUNmQr?=
 =?utf-8?B?MGhiNWtscVM1T1R0cnA2ZUhuZlJTRjMxYmdpVWRXd1hWY052YkwxaUhqTS9Y?=
 =?utf-8?B?eDBvSVVLcElwbTRpb2JOTWd1bjN4WTVUOGVHVm5UNWNIdVhKRkJVSktzV1hT?=
 =?utf-8?B?OU96TnlQMTF1b1FCejFIS21tMnhOOSs1NzdJSVhxUFR1Tm1rNXlnY0c3ZS9n?=
 =?utf-8?B?MkZLTmFOSWFVZk1vU3hscE9lVWtoa1lwYkRqUC94cE1FaDIxN3V4S2dRRm5G?=
 =?utf-8?B?TVpmQ3dvMEJNWHU2enY4eDF2c1FmUmdnbE1BbzY5WkFZSENvQVhXMHljV2Qr?=
 =?utf-8?B?VFVsMzB2VWJVak9TdGtzaUo2QWpoVURNRWVBMUhPOTUzdjltMWY0MTJNRElx?=
 =?utf-8?B?N1lycjZNamh1d1Bhc1gvaVRlVENBdFlnNmtEWFFVenZ5NXdnWlVyUGIxa3g2?=
 =?utf-8?B?YVFqdnJFL3N3dFFObUxabFFXNXhhY0JldjhyZHVJeXBMZXVrbGNoSm8zSGFj?=
 =?utf-8?B?MUx1bEFQcThKTFpDcVAwaVI1QUdwd0pWQmVZUm1wSXZrcTdHT0NJK1ZYTjIy?=
 =?utf-8?B?RHMrZTF4ZS9kczI0RGZ3aFY4Sm5lYzVIdm1ZbExjMk1FK0J0SGRmZkhaUW8y?=
 =?utf-8?B?eHFmWlBRVS9FL2p5YnNhQlFnMmkyazZDY1VmVHpOWVN2R05iZEhSdkZzZkVW?=
 =?utf-8?B?VVZvczNjbFJmT3k5eEdkUzZBTVpRT1owSXE2RjZZdHJMWWFwQ3lxR3duek54?=
 =?utf-8?B?Y3lNRXZHU0FEV3UrcmhObmRlaldNaGdjV2xWWFJwdjBxU1FFd1BZZG01S1J4?=
 =?utf-8?B?KzlhWFR4b05JT2tGUnhIZWVEN2JHT29jQVNQbTUwbEpWZmY2QzNpUi95YVlw?=
 =?utf-8?B?aU5Jb3duZi8wMFQ5THNCUG5mUWMvai9XTWx4MStqUDdjcCt1dHBiZ3pmaTc4?=
 =?utf-8?B?d2NVU1k3bnRPaUY0SncvUXJmYmRwQkNLcG11RU8rL29uSXBnRkw5cHQ1OVRq?=
 =?utf-8?B?c0h6M3pEei9WMmdIVmJIOWcySnFmWmpaUEJZUHluYTBEOGN4c1Z0U2E2Y2VI?=
 =?utf-8?B?ZmRGVFpCZi95eHBIajlaTzFsZEowMVl2cEc1TmRRKzB5VHhMNTUyai9lY0pS?=
 =?utf-8?B?bHgyVWtFS1VRZlRUcVlTVU9PLzhLKzczMmpURU93OWJlNXFlb1NRd2djN1ZD?=
 =?utf-8?B?OU1YampUaDc2WWJtajdtK0kxT1F2QTF0dlIwNTJVTDFFY0NSeU5YbGRCZjZ5?=
 =?utf-8?B?OXoyWXZUUFJzTEh4NTZqbEN0dXhMODZLTDVoYWsrU0tJdWVzR2Y3eXNZMUEr?=
 =?utf-8?B?cFVPbzVTUHZZL25KRWVVOTRXTUF6UGxza0FZbDVBbzQ1eTRWZjcvSndYMjhX?=
 =?utf-8?B?YS84ZHdsYWROd20yV0hadHEydkk1R1VlSWx2RDc5RDEwTVhoVHJTdGlpMlox?=
 =?utf-8?B?RFo1R0dTVHhTa08wTXdaKzRtN083dHhOOCtYeW03TDR5K2Z1R0huRkxjTUNP?=
 =?utf-8?B?dHg5Y2Q0R2M5QkJRR3h3M2RSaFRCQ2kyWSsxeVNOQmY3Y0JocHZNMC9VajBu?=
 =?utf-8?B?MVJFbk50SHBGK0JOeW9xbXA2aGhJMFo0WFErWU5YeW9oRytqNzdnSDhjQUxr?=
 =?utf-8?B?Y0xXSE5udG5oblJ2OE92RW1rR2hNaWhLVmI4SFg4RmZNemFBYWswRlhlVGlu?=
 =?utf-8?B?MDNyVi9TTm0zaG5IaXpTaHArNVVJZmtSTHoySEl5ZEJ5ZERZV3VUOFR3S2Jp?=
 =?utf-8?B?UmYxcDlObUpMbDFxbFpMVFUxSDgrcTRGUTZMOEFTNUszVERWQjRzTjJtY2lN?=
 =?utf-8?B?a0h4MXd1Ym1vVExZclluaU9hUzhmV0lIK3Y5OFk5UmExcUl4VlNDdmJVZlZB?=
 =?utf-8?B?aUNnM2VabitPdFUvOU9RT1VmcXRSSU05c1BpWW5tMHpnNFdkVTAveXhxOTNY?=
 =?utf-8?Q?I/vI=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(1800799024)(36860700013)(14060799003)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:45:23.5526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262cfeda-43b1-4c74-c4dd-08de521b8246
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562

Hello Peter,

It seems this patch:
6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change 
pattern")
is triggering the following warning:
rq_pin_lock()
\-WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != 
&balance_push_callback);

On an arm64 Juno, it can be reproduced by creating and killing a
deadline task:
chrt -d -T 1000000 -P 1000000 0 yes > /dev/null

[   49.518832] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Jul 11 2025
[   49.518838] Call trace:
[   49.518842]  show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
[   49.518864]  dump_stack_lvl (lib/dump_stack.c:122)
[   49.518878]  dump_stack (lib/dump_stack.c:130)
[   49.518889]  prio_changed_dl (kernel/sched/deadline.c:0 
kernel/sched/deadline.c:3343)
[   49.518903]  sched_change_end (kernel/sched/core.c:0)
[   49.518916]  sched_move_task (kernel/sched/core.c:9167)
[   49.518927]  sched_autogroup_exit_task (kernel/sched/autogroup.c:157)
[   49.518940]  do_exit (kernel/exit.c:975)
[   49.518950]  do_group_exit (kernel/exit.c:0)
[   49.518960]  get_signal (kernel/signal.c:0)
[   49.518970]  arch_do_signal_or_restart (arch/arm64/kernel/signal.c:1619)
[   49.518983]  exit_to_user_mode_loop (kernel/entry/common.c:43 
kernel/entry/common.c:75)
[   49.518994]  el0_svc (./include/linux/irq-entry-common.h:0 
./include/linux/irq-entry-common.h:242 
arch/arm64/kernel/entry-common.c:81 arch/arm64/kernel/entry-common.c:725)
[   49.519009]  el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
[   49.519023]  el0t_64_sync (arch/arm64/kernel/entry.S:596)
[   49.519119] ------------[ cut here ]------------
[   49.519124] WARNING: kernel/sched/sched.h:1829 at 
__schedule+0x404/0xf78, CPU#1: yes/326
[   49.612674] Modules linked in:
[   49.615737] CPU: 1 UID: 0 PID: 326 Comm: yes Not tainted 
6.19.0-rc4-next-20260109-g8be7ad74b7e4 #261 PREEMPT
[   49.625670] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Jul 11 2025
[   49.636470] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   49.643443] pc : __schedule (kernel/sched/core.c:0 
kernel/sched/sched.h:1907 kernel/sched/core.c:6798)
[   49.647287] lr : __schedule (kernel/sched/sched.h:1827 
kernel/sched/sched.h:1907 kernel/sched/core.c:6798)
[   49.651130] sp : ffff800081d739e0
[   49.654445] x29: ffff800081d73a40 x28: ffff000809548908 x27: 
ffffddc6d7c532e8
[   49.661604] x26: ffff000809548000 x25: 00000000400004d8 x24: 
0000000000000009
[   49.668762] x23: 0000000000000001 x22: ffffddc6d7bf8500 x21: 
ffffddc6d5b9bdb0
[   49.675919] x20: ffff00097681c500 x19: ffff000809548000 x18: 
ffff800081d735b8
[   49.683076] x17: 0000000000000063 x16: 0000000000000000 x15: 
0000000000000004
[   49.690233] x14: ffff000809548aa0 x13: 000000000dc48bda x12: 
000000002edb68e5
[   49.697391] x11: 0000000000000000 x10: 0000000000000001 x9 : 
ffffddc6d7c7b388
[   49.704548] x8 : ffff000976636420 x7 : ffffddc6d5b9ae64 x6 : 
0000000000000000
[   49.711704] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 
0000000000000000
[   49.718861] x2 : 0000000000000008 x1 : ffff00097681c518 x0 : 
0000000000008629
[   49.726017] Call trace:
[   49.728462]  __schedule (kernel/sched/core.c:0 
kernel/sched/sched.h:1907 kernel/sched/core.c:6798) (P)
[   49.732308]  preempt_schedule_common 
(./arch/arm64/include/asm/preempt.h:53 kernel/sched/core.c:7080)
[   49.736762]  preempt_schedule (kernel/sched/core.c:0)
[   49.740606]  _raw_spin_unlock_irqrestore 
(./include/linux/spinlock_api_smp.h:0 kernel/locking/spinlock.c:194)
[   49.745410]  sched_move_task (kernel/sched/sched.h:0)
[   49.749341]  sched_autogroup_exit_task (kernel/sched/autogroup.c:157)
[   49.753969]  do_exit (kernel/exit.c:975)
[   49.757202]  do_group_exit (kernel/exit.c:0)
[   49.760782]  get_signal (kernel/signal.c:0)
[   49.764277]  arch_do_signal_or_restart (arch/arm64/kernel/signal.c:1619)
[   49.769078]  exit_to_user_mode_loop (kernel/entry/common.c:43 
kernel/entry/common.c:75)
[   49.773530]  el0_svc (./include/linux/irq-entry-common.h:0 
./include/linux/irq-entry-common.h:242 
arch/arm64/kernel/entry-common.c:81 arch/arm64/kernel/entry-common.c:725)
[   49.776767]  el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
[   49.781048]  el0t_64_sync (arch/arm64/kernel/entry.S:596)
[   49.784716] irq event stamp: 80194
[   49.788118] hardirqs last  enabled at (80193): irqentry_exit 
(kernel/entry/common.c:0)
[   49.796575] hardirqs last disabled at (80194): __schedule 
(kernel/sched/core.c:6755)
[   49.804858] softirqs last  enabled at (77126): handle_softirqs 
(./arch/arm64/include/asm/preempt.h:12 kernel/softirq.c:469 
kernel/softirq.c:654)
[   49.813575] softirqs last disabled at (77121): __do_softirq 
(kernel/softirq.c:661)
[   49.821856] ---[ end trace 0000000000000000 ]---

The first stack dump comes from this:
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1f94994984038..4647fea76d748 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -632,11 +640,17 @@ static inline void 
deadline_queue_push_tasks(struct rq *rq)
         if (!has_pushable_dl_tasks(rq))
                 return;

+       if (sysctl_sched_debug_local)
+               dump_stack();
+
         queue_balance_callback(rq, &per_cpu(dl_push_head, rq->cpu), 
push_dl_tasks);
  }

  static inline void deadline_queue_pull_task(struct rq *rq)
  {
+       if (sysctl_sched_debug_local)
+               dump_stack();
+
         queue_balance_callback(rq, &per_cpu(dl_pull_head, rq->cpu), 
pull_dl_task);
  }

On 10/6/25 12:44, Peter Zijlstra wrote:
> Move sched_class::prio_changed() into the change pattern.
>
> And while there, extend it with sched_class::get_prio() in order to
> fix the deadline sitation.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   kernel/sched/core.c      |   24 +++++++++++++-----------
>   kernel/sched/deadline.c  |   20 +++++++++++---------
>   kernel/sched/ext.c       |    8 +-------
>   kernel/sched/fair.c      |    8 ++++++--
>   kernel/sched/idle.c      |    5 ++++-
>   kernel/sched/rt.c        |    5 ++++-
>   kernel/sched/sched.h     |    7 ++++---
>   kernel/sched/stop_task.c |    5 ++++-
>   kernel/sched/syscalls.c  |    9 ---------
>   9 files changed, 47 insertions(+), 44 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2169,12 +2169,6 @@ inline int task_curr(const struct task_s
>   	return cpu_curr(task_cpu(p)) == p;
>   }
>   
> -void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio)
> -{
> -	if (oldprio != p->prio || dl_task(p))
> -		p->sched_class->prio_changed(rq, p, oldprio);
> -}
> -
>   void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
>   {
>   	struct task_struct *donor = rq->donor;
> @@ -7402,9 +7396,6 @@ void rt_mutex_setprio(struct task_struct
>   		p->sched_class = next_class;
>   		p->prio = prio;
>   	}
> -
> -	if (!(queue_flag & DEQUEUE_CLASS))
> -		check_prio_changed(rq, p, oldprio);
>   out_unlock:
>   	/* Avoid rq from going away on us: */
>   	preempt_disable();
The cause might be the above. This used to call __balance_callbacks()
while holding the rq lock.

> @@ -10860,6 +10851,13 @@ struct sched_change_ctx *sched_change_be
>   		.running = task_current(rq, p),
>   	};
>   
> +	if (!(flags & DEQUEUE_CLASS)) {
> +		if (p->sched_class->get_prio)
> +			ctx->prio = p->sched_class->get_prio(rq, p);
> +		else
> +			ctx->prio = p->prio;
> +	}
> +
>   	if (ctx->queued)
>   		dequeue_task(rq, p, flags);
>   	if (ctx->running)
> @@ -10886,6 +10884,10 @@ void sched_change_end(struct sched_chang
>   	if (ctx->running)
>   		set_next_task(rq, p);
>   
> -	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
> -		p->sched_class->switched_to(rq, p);
> +	if (ctx->flags & ENQUEUE_CLASS) {
> +		if (p->sched_class->switched_to)
> +			p->sched_class->switched_to(rq, p);
> +	} else {
> +		p->sched_class->prio_changed(rq, p, ctx->prio);
> +	}
Now this is not the case anymore it seems. prio_changed_dl() sets the
balance_callback and rq_pin_lock() is called with a non-NULL value.

