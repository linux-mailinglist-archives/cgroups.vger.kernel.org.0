Return-Path: <cgroups+bounces-13139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9689D18250
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6028830155A0
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459D349AF8;
	Tue, 13 Jan 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkP6KH26";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkP6KH26"
X-Original-To: cgroups@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CD2F49FD;
	Tue, 13 Jan 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301231; cv=fail; b=Nv7k+pkTrW+1sjrS4mgzRabQDeuCCfqcU5Zo6/xx2D8qZo7sEcih1l+Yi/QqFXoHMOFBkRORaApblEnh4HJe5abbbWtMmzU9DAZ8slJSdVLahD2F5BAnX01JPh1nLkBcDa1aww7VwakmttOUFFOGVbW0yAmCM0VhjqXQcdv8cLY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301231; c=relaxed/simple;
	bh=vMRXd6a7WcdZcCIlZAne3ePpHLK05n6oUWsTJyQEs5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mVfzGpLG/iCMa2eUySrrwhqRvSdOFevTE8U8EKqwAsDg4zHkVPLn18ZG3lVSeeY7Y8ZE7S2X3Vyvcx8WgkkK9Wmpjpo8Y9tU1Dj+K6vMT9N3rkVdF99Beg7H6BJBrZRP2b4Jai482S/sC7DIrBSUh1ONmsxycLbUZTwnAtJuAPs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkP6KH26; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkP6KH26; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=k7ozOcNxgcw/KbOh0Pa6hsPDfQgLSBAy6D5szMe/VnHODgPHRR7E/4BXb5+KdT4C1u5s4pQgxqwMND1ZETY/EJLx4NzG7BayzR/wnuhoY+FHZ9051XmzSj3guIa5GCHIK1E+hEAlZ7SbwvzD4PVUsZ8b/xIyM7NmhSIHuerzaQaCJQ6T89qQCsbi4Uc9tPi9++67/iEp0EyGrngQK/Z8F9TMbMSo6rdHyJkA1qrfOQNpit8j+EEnCPFNPpHrnorWgHJSVf+dLquugAtrkRhlvTPr9hAAAf7Z1Mk0dhatpo/WnomHaGKBZ+mgxvnGz5AtD+eWp/YZxNDFj5mLYTYuyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWwyosQXqMrst+8V2VVQlqcjxgJzUKMkTk1yJ39qUc0=;
 b=G49f+QRpoegzt6bsNGPZVZ6dFmGT3FfXD6H6ba097rKSQrjSkdXgdat4l/JsI2V60PHFmc26DwImev1aJ1iOiWsKUfaoyA/LAtqPKs3pUicQL/Z90uqOJuy2WRdlP+tICMtKjNuzVN1ZD3os6nMWzEFfohYUKMRglCaBad0W8aZ7UR9rmrdztY5aRu/PMQ3QDzJMq9CT7lLklSMqFQJXNpixApJqc3wRTKecjhn0ynuqwlaG51OnymQ5Eq37yhd1B0rWPSGiaDomrF7nSMO0T9CMiJQZmfgW1Z2eQHcbzgYXAtW7qwVn1jdymX9K7Iws8DhPgcdsHDS5hZJmXs418Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWwyosQXqMrst+8V2VVQlqcjxgJzUKMkTk1yJ39qUc0=;
 b=fkP6KH26DvQSf5s8PR8/nTkyYB5EsNId2dU5S+F6LlgBle2+qNOlnD7oCV0bQ8j1dVC9MUVjavxtLnp0OKL7AiyRUmqBkRfLvRf5DArr+EE2kjSwhoUVdC3x+7Bd1c+o8A5qqYjEABCu3beBVY8QYpsaHoqSQ/K1QW10ueB/T7g=
Received: from DU2PR04CA0266.eurprd04.prod.outlook.com (2603:10a6:10:28e::31)
 by DU4PR08MB11811.eurprd08.prod.outlook.com (2603:10a6:10:640::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:47:06 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::4d) by DU2PR04CA0266.outlook.office365.com
 (2603:10a6:10:28e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 10:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Tue, 13 Jan 2026 10:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVz2TJ71BwUrQBie7RJp6IxhKvI4XoBv+yaFSmK5kgyLPX+pnyKwDAKm6lwOjcaHipc4LiBJ533XqcnEm6NXR33E+fxSwRdn/w+xU5Bh17mTCCC9vRI6O6ONhDhP5EmVdv9d9WhcB7Ndx/3KZvNrTK7hv/xGxvSnqaGfzoL75D3NFyXx9s+d6xNHHXw6pkiVA5IQk99PG6XW7TD/FfsOkrANnMbw6R38dGlx9rHn0aNQtadx4kxeCaox8EjxEvec6AMNSjDwvkit+zTFMVBHz7czZ3PNEfXUQ/tiY23Js6/c9c0qa6/aZw/sLd4I2emdRPhoqSihRSPiMAaEirm9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWwyosQXqMrst+8V2VVQlqcjxgJzUKMkTk1yJ39qUc0=;
 b=aoRjcwGtpJscAqvaq324BvroV3LD4UzBzEtCVRgU8qAXfskapvi38zlgRjDWPZN8Jk2+6MBZg1h0I6z6RGh1pP9W1g8lWsqljBCSIDuxkLs/qXz2rgzAlI+9JsnXYMLRQEqkqRKfHBhDEUbadzXopZFHKdDEDqqRpACA65dyuWLRYma7htQxlaRu1TuknHNTIKIkHJYk5nl/D9DTg8m6ewFXoorfvjE6K9YUTsMe2K7mfAqU2zalUgTZbzKLz8hf4lH90eDrv8v39RchaSedSziMfsac9H80IhuweoSDJvV2A1/0sdaDFBFSJT3MyRuUsDbItw8d/vMhruQiHVvgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWwyosQXqMrst+8V2VVQlqcjxgJzUKMkTk1yJ39qUc0=;
 b=fkP6KH26DvQSf5s8PR8/nTkyYB5EsNId2dU5S+F6LlgBle2+qNOlnD7oCV0bQ8j1dVC9MUVjavxtLnp0OKL7AiyRUmqBkRfLvRf5DArr+EE2kjSwhoUVdC3x+7Bd1c+o8A5qqYjEABCu3beBVY8QYpsaHoqSQ/K1QW10ueB/T7g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB5989.eurprd08.prod.outlook.com (2603:10a6:20b:297::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:46:02 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 10:46:01 +0000
Message-ID: <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
Date: Tue, 13 Jan 2026 11:45:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de, Christian Loehle <christian.loehle@arm.com>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB5989:EE_|DB5PEPF00014B8A:EE_|DU4PR08MB11811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4380eb62-10c6-43c6-bd87-08de529117fb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UlpRbHRLMnRRU3o0dXlJT0tZQm5vY3E5d3B1MzI3eUttYVhhdEZRWWR5cm9P?=
 =?utf-8?B?b3ozbm81dzFCY1hvVUVpV21pZDZxbjYyZ3RPYld6bDZNaFVXR2VqWTJYUDJD?=
 =?utf-8?B?aFcvMUtidGhQcjV3NmlBUDBXNG1zWVhWY3dMbmRVbG5Wcng1dVhjMmFmR0tU?=
 =?utf-8?B?Q2JjSUNwMjVEdTRXNXF2QldZTnhXM0dhdUU4M3N4c2F3UlFJbEpzb0pTL3Fo?=
 =?utf-8?B?dXI1dUNQRVpGVHBjMEViQkphTy9ZeE9tNTV4MGEya0ZWNjhvaURzWVczanIz?=
 =?utf-8?B?cDUyUVB0VUtxNnhhb25jNHBBL2lGakpLN3h1MURJSzBDRTlaaDFFRVVkbXo2?=
 =?utf-8?B?cXBFenR4blRIOVJQZDJjOXBXQXVTcUovZXdWS3pyWDRUZlFtd2F4MWM5Q3Y3?=
 =?utf-8?B?R3NtZ1lra1ZCQnlnMFBVM2VoTlhmSnpZMDViK2QyQzhZYmZ5cXExQVJkakZv?=
 =?utf-8?B?OEZtNFoxV0ZWMWZSS2c4Z2lZT01OYkhucWRBUFdtb2ZLa2ZvZkxpZHV6UFdD?=
 =?utf-8?B?N1pzamticTdvc1hNNjlxMENPcUpObFJNRGRiRm9nS0wxVHd2L1FhTUhQVk5U?=
 =?utf-8?B?OVROSHB1aU95MzVkaEFoM3F6bzVJaytjSEpyOW1heGhWZTJ6L3EzL1RJbFow?=
 =?utf-8?B?djc1Z3lnaWViaktnY2Q3N0h6bi8zZVVMemY0VWFHYmk3VTJ1TkZqSXB4RzFs?=
 =?utf-8?B?RWFUckt0cnBjU1FUekxDMWxPbGxRVmMzb3pKY2Qxd21KNTRpQ2I0UWZZclVL?=
 =?utf-8?B?a3lMUG1kdFdteENGMnBjMkJ6WWY2ajZPU2haeFpML2lVTDR2WFBHRFB3UWJP?=
 =?utf-8?B?Z08xQzZJS3RnanVzVmhkQlJ4QkVHaGlCQmxQSlVsbFFEVG1QNVY5OWxuSUlj?=
 =?utf-8?B?S2tKVXp2WWFYczVkN2tLYnBZckp1d0V4YjMxTzE5RkMvYVQrWmJTeWdVWWl1?=
 =?utf-8?B?L21pOEplSWFUSU1SR0hPUTBCdmF5aEduQmdDT0VRUjE0aGpybWZnVEQ0TXZx?=
 =?utf-8?B?dUZTNFFoMTk1VEF1OWY5amxCYnBLeTVvVVpidGVQODhsVmdCbE5XOTBDb2Vw?=
 =?utf-8?B?bDhTZTZHamd3c0NHTUw4d1Npamh5Q0h2cVBrMDM2RWpqS0pQODgwampPRWVM?=
 =?utf-8?B?aHBucUVNaEQ2TTJGSVRJY2c2Z3NKQWtiNWtKNWlabWlFTVRHQmlIL1E0TUJ0?=
 =?utf-8?B?WXNFcnNqb2swOWFielhyQjlseVFVSERISlByaWp4U0UvNStqb1VsMjZlY3Jj?=
 =?utf-8?B?RVhLOHpDeHIrTkZtbFh1cjhUbWNOb1ZFUVJlOU5zbHNQS2dJc2VmQXU2S3Iy?=
 =?utf-8?B?R2REMjJtU0pZU2lIQk4zcWJMQW9BeVY2dnE0RTY4OEQwWWFLOTFaQnpESk9z?=
 =?utf-8?B?K3FuM1Z0anRSendYYlhqTVpuNGFkcEQ4WktRUE0wZ0dnTDA5NzZpT1JZVXBY?=
 =?utf-8?B?Yk9nQlB6bnJEQ05iSlFSd1lPV0RwMkl5ZzJMWHVzdTlIWkdQaE9ZL05JVUIz?=
 =?utf-8?B?Z1Y3Q2JIRlJVazJmcks2UG9uWFc0RU1zQTBvUUV4cUJyQlEvblJ2U1hJM09O?=
 =?utf-8?B?eTk5RWsycGNSbW5NTENqRi85L2FtSmpDYks4NlE5SjMwRWxBandCc0tJeGp6?=
 =?utf-8?B?b1NIM2IvQXNSbjZQSWZuMnFQZk1QdjNPcWRWK0JDWmFmVG55UExkOHJFVDho?=
 =?utf-8?B?QzdQV1Q0dGJxcUFsR2F5VGxwOFBWUlJoZGVoTkxaQWplMmU5VGluTGFxdExR?=
 =?utf-8?B?b1lLdjNFeHRnNjU2LzVqbUM5NzNZTTkyWGxrQUcvdjM4VUkyWFhteXoyZ0tR?=
 =?utf-8?B?YlRjRWVMOW1WdUYwMTFiZEsyOE4wazFBWjdjdmZhbjAxVlhJdVU5eHNpVVRB?=
 =?utf-8?B?NXVOOWpJN1ZOLzd3S0NyckcxWTVHWFJWUHBTQkZkTDFFUTVGUzlhNTNneTNt?=
 =?utf-8?Q?BJNEK6KcXfmY3ztgAuqZV3i+M3SjzHRZ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5989
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7abfe057-a679-4c3b-4657-08de5290f16b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|14060799003|35042699022|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHhLd1pEWnVwUGlBazlVbGhSUVhmQ2VlblNTQ1dPT3FVZW82S2liWWFLTFBD?=
 =?utf-8?B?NHVwTEpkSEdnVnZrUElvSFF2RHByckMwR3RSR0xVT2NWRmRhQ2w1MXFKYW9T?=
 =?utf-8?B?bkpvM3dHZTVnMlpXWFF5c1VOd3lhWWVodElwNGxnWHgrenR1OTlRa0pGSHg1?=
 =?utf-8?B?bVc0anIvQ0UyYWtTYmRQajdVV1ZtM21NTWhQd2ZBTmxLa05VMHlzb2JxcUZE?=
 =?utf-8?B?eXpseWYvTkhjQTRtVUNqR0VSZzJlcHdDY2JTOFNZVEdCbG9rbktEZlRLR21s?=
 =?utf-8?B?SDRYaExNYlI2MG9WbUxuWnYreVN5VHI2ME9MZVl3Qmc5RmxLaHg4akdUOTRC?=
 =?utf-8?B?ZDA4RkI2cE1ja0ZxbFlDODN2TmFpRExEU1hoaHRQbGZrYytHR2kyUm9EM0Fk?=
 =?utf-8?B?cVIvRE8vd29FSkFTcnRFc1ROeGI0WDRLaEVlb0NPOVV2U0NXRUlaYUEza09Z?=
 =?utf-8?B?RXNSWEV1UkVEUVNtaDFGWDV0dElSYXhyL2FpYlJpbU1ackpXSUVPSXNZZkZ2?=
 =?utf-8?B?aHhPMTZlZzRYWmk2VDkzZVJRVk8vOWhQNDJ6aVhlKzY1dm43WWNaTUlMV0hC?=
 =?utf-8?B?VCt6N0dEbjJySFE2bUREakd5TnBMd2taWklCOUhGaU5RVTBLdXgxSGNWOGVH?=
 =?utf-8?B?MWNzK2ZsMmpMbFVrWDNaQnpGK3JLcWRIdFl6eldMdDZVdnhIN3o3L0tDNGZU?=
 =?utf-8?B?ekRpaTY0UlYrVEhNUHJaQmhTa2U2eTQvY3lmQnJLcWJWL2lTWDEvYTA2RHR3?=
 =?utf-8?B?a3ZPQndZWGFrOU5wbUJzZWYyV1VWcjUyV0FaZFdRanpPUU1sTVVrTHN2dGFt?=
 =?utf-8?B?S1NtSmEvVnh0emdNTVQ0Z1FCTXBkcTNYVXdwejAxalJyb0p5bGJUSm1aRDFn?=
 =?utf-8?B?aWlXbDBLaGJ1TEUxNkIyYXlGQ216d2t0dG1WRVIvZXBnWWZLYlRGQVFJL3l1?=
 =?utf-8?B?d0tkbVNjTHRTMFY4WjROVjhDVHJ6OGZIaWUyeUtDcm93OElWYkRncnk1a1lp?=
 =?utf-8?B?TTBDdll0K2czcnVaOFZKNjdtTVFRSWgzc1JQRmV0QnlOUEVEWnRJNE9RM0pr?=
 =?utf-8?B?QVo4U1V6ZW5PdUU4T01VMTd3WnpIck12YXpnUGNoOFV3dmR5Ylp0MXJUWkFh?=
 =?utf-8?B?OFpwSkNJTWcybmhJeXcyS3JSbHRKSUR4blhoa1JQTHVXblFkTWRBUGN1dVlD?=
 =?utf-8?B?UzlpdTk0SG96dmdXOHBQeWdqSDFyckR1eWRVcWMvZWNicDlrR3ZlZ1lSMmNR?=
 =?utf-8?B?azNTKzB6Tm1tT1Y3ZTUwK1Zid0drZVRJdUR4YWl3L1ZWcmxZcEpYMUkyemhm?=
 =?utf-8?B?d1RWNFpzNjZzNHZBYUFRMTQzU1Uyd0ZLZHBoNFN5Ym1wZGh5SUQ3ZXcrVHNn?=
 =?utf-8?B?cHBKaHFpZ2MrdXM2WXVHdmJjV2FjdSswSjBSMHNMblFaWURxRlZ4eHR6Y3hs?=
 =?utf-8?B?SUJlMFgrYlFJS052VDI1OVZoSFlPMGlad0dQUHN5dlZTMFVFNG55cGsvTXBE?=
 =?utf-8?B?VUZwbVhqK0dqSDM3eW1tdmtMYnoxSzFFam50U3hUekJBTHUxZlV6K1FwcWY4?=
 =?utf-8?B?YjdPMC8xcmR4b3VWQzVsV3VXaFVYZmx4WXlxVWFXTElzWjIzOUtBS3djbGxY?=
 =?utf-8?B?UWJOWEExOXF0bE90clJKOTgrci9zNXNWVVBzWVZHNnZENGcwZWNwN3p5YitC?=
 =?utf-8?B?aEZ3QVRhenhURFlSSmM4Vzd2T2R0MllKUnhRTmlwUjFuc2pEK3hUKzg2dHFF?=
 =?utf-8?B?NXFpSmhNOWkwZTlRWkc3RjM4b0JyeURQTGZHZ2pSbnEvdGxpaWJsL2pCcWZH?=
 =?utf-8?B?VS9qZUx2MlUxYm1lSE1VQlRaazNzYk5CT3N4L2VWR3IxZkNZR2c1Smcrend3?=
 =?utf-8?B?K2xNcjR5NkR5WFo2KzJueTRrYzg2VGtzcVh5bnhzY3BQK2FRU1FVSUMvUkNJ?=
 =?utf-8?B?WUhuVmc0UWl6a0dmdzlvejV1cjd4UjhlaTdHcjFWMVpGVERvTWZ0OXRvaTJ0?=
 =?utf-8?B?cFBCMnpadGVqZXZpSTZxOHBHWjdKNFdma0xGc3k1cC9jdjZUMVN2UnJ0aWhp?=
 =?utf-8?B?OWxvVW1EemhNOU94ZmlSYWlPK1UwSDJPdVY2TXZINzd5VWQwbFdCOGxxemlX?=
 =?utf-8?Q?DKcw=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:47:05.8309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4380eb62-10c6-43c6-bd87-08de529117fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11811

Hello Prateek,

On 1/13/26 05:12, K Prateek Nayak wrote:
> Hello Pierre,
>
> On 1/13/2026 2:14 AM, Pierre Gondois wrote:
>> Hello Peter,
>>
>> It seems this patch:
>> 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change pattern")
>> is triggering the following warning:
>> rq_pin_lock()
>> \-WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
> Can you check if the following solution helps your case too:
> https://lore.kernel.org/all/20260106104113.GX3707891@noisy.programming.kicks-ass.net/
>
I can still see the issue.
It seems the task deadline is also updated in:
sched_change_end()
\-enqueue_task_dl()
   \-enqueue_dl_entity()
     \-setup_new_dl_entity()
       \-replenish_dl_new_period()
if the task's period finished.

So in sched_change_end(), the task priority (i.e. p->dl.deadline) is 
updated.
This results in having an old_deadline earlier than the new p->dl.deadline.
Thus the rq->balance_callback:

prio_changed_dl() {
...
if (dl_time_before(old_deadline, p->dl.deadline))
   deadline_queue_pull_task(rq);
...
}


