Return-Path: <cgroups+bounces-13140-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2938D1834C
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87CA4307B39A
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4C349B19;
	Tue, 13 Jan 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkP6KH26";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkP6KH26"
X-Original-To: cgroups@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8691EB5FD;
	Tue, 13 Jan 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301239; cv=fail; b=WX+/Vs3UwxKhAGv9XtWL2mML9fDsni3p1FbW3Y4wVSM8JSOoFL7HK35jkT6WJBda8ScjwdK0thrS5TOvTSDYqjrGxumXBt0r3irrmtq7BA9PpxTJd5/1VUOYjMPOmAJkaKCkStTfPQ3KRggjyi4MBKcjAZL6XnUMtaNc+AGRnm0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301239; c=relaxed/simple;
	bh=vMRXd6a7WcdZcCIlZAne3ePpHLK05n6oUWsTJyQEs5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9x4X6Bl9HV3QSPZNOGgHVM8Czdx3BrSLg04U+13TgrfgBLxFLEn1/KcFJkh/XaIXyRLdOfleB2PNSskoV6Rn8t2SjfJyl0QMLe9izlJuZQzPRB2prYdeoptQb3JEmXMzHn75RibVXPlu2QYHMkvIbOH1DdCGDCIMzGNh/ofABQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkP6KH26; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkP6KH26; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BQuJAmpUGmIst0w/gbwpUeuSArBP+FADUqz9JuokD/BnE1vPjSCk+5AmEulrWHCcQ1IHNiNcO6ycC90j5X1ZZI0jBhuwUPU8VCMg6uY1v6Vegz96puAyujW61SLWEv24lrQDM/yiCxx2Q98tJd94Gyl5VoZvM3T6R/NL33IZ0JT/TnNQ0t6AvizRVhpvEO91Fwd2pfmS0DiNPxI00p8vV5kgZzbp2MZd0j0oQIFIJsPJ4iF4GtkDqgXVa3KtbNkLrmZLRgOu0Qo5NKLj9R5zZ4DjkElBm1oGrv6X/a2vtCBfgpHYM5+KKpUT4mRGbN+wemFbmSxzlhLLOEdTwpEAxQ==
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
Received: from AM0PR02CA0171.eurprd02.prod.outlook.com (2603:10a6:20b:28e::8)
 by AS2PR08MB10056.eurprd08.prod.outlook.com (2603:10a6:20b:642::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Tue, 13 Jan
 2026 10:47:08 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::83) by AM0PR02CA0171.outlook.office365.com
 (2603:10a6:20b:28e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 10:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Tue, 13 Jan 2026 10:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHK8yxi5g9zM0RVjap1sWdbUihuQX5TSAP74BRtHRVHHgudxi1gh8xwH44CZPzy86fI5b6lVhf1d9thmS28U1vjQI6D4A1HuDJUssx8qXqZ6fzNaR6hkD1u3TDSIHbgsll7u8rjLc6+MAsTYcFjFzbI0Lcs1Pia5SGFNyJWLWDM1Xu/QqJkPz0pytWc+HiFoIqrB5aWRGwoa3ICommO1fyBW5pozUThfIQQILTgATVpKMV8l9L/qxUZOvx64y6jznpGyPpotqvIand3zFFeuuW59CkLyti7mhMHcrkB2mR0pOSDUdnqdbD0opSNTVzGqNdGpLm11NCZSluvhEsE3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWwyosQXqMrst+8V2VVQlqcjxgJzUKMkTk1yJ39qUc0=;
 b=I1Yxu/aZTq/9cHCaU8rvbyD18XJDk5X+enxXJ6G+X7G1VWNWTn2yDBZDpHa3k9/HklRuG/nxoPz+bqGl7OhyMQZgDon2Bz2BYNnrrLwCfJEkozAg235Uz1jIptU0cXTjRTaul4MGJiM/892jdoxZemUgiXyy5q7p5MHVRxdcqZF76A/v64O8dhteOV2IhHh+Zg8L6pQbFLV+5Yc6bSucTJpwNAbnk05dViUxhTv63Ws+5MKsvTsxCYd7iuuo2KMF0mM0NW87UhriVzw4bJrynIOq4RtNQJdu+CS0b7qh0wQqF90LJjkV8ciFmhi4Y5rsTnWyFF9dwn8xdtahxzz2Bw==
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
 2026 10:46:03 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 10:46:03 +0000
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
	VI0PR08MB10391:EE_|AS8PR08MB5989:EE_|AMS0EPF000001B1:EE_|AS2PR08MB10056:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f57109-31bb-4368-b1d0-08de529118b5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bVFhMy9tWFZzOEtqUmxyNXN5dlNTWERtNThhRldCK1VpM1FrUmZKRmdqcTdF?=
 =?utf-8?B?TFk1dFBUOU1lTUlmN1o3UE1xNFlvMzZBTWdHQXltNWowMU9BbnRoNlRLMTVp?=
 =?utf-8?B?a1VBVkMyN3FPS2pCT1FrRTZ5bk5VbkU2VUc5dGRkMENnTlVrbFlVNk5NYW1r?=
 =?utf-8?B?TjN6YU9UaXJMK0hrNVdnSVkya09XRk9ZeXJ5YVpUb1h2SEJqTEV1WkJJRXQ4?=
 =?utf-8?B?MHBaVmxIOXJuZC9DcjlVSUlLK09lT29aNlNvQmxRMUt6dWtvNVA0N2kyNVpY?=
 =?utf-8?B?Y0xQRlkzZTVjdlFEWkovMEthOUtmNjE1a2VGeHhHVEt3T0tqOHVycnN0ZUFE?=
 =?utf-8?B?Ym1vbWxzQ1ZHMXlJS0FCM2U2YmZSaHpGZlFKTjVxakxoSFJONVhJd00yOGlL?=
 =?utf-8?B?bndyUVJsM1RQaW9HMUQxdndWWS9RTnY3dkZ5OWRQTGVockJub0NaT3kwZGtQ?=
 =?utf-8?B?UXd5ZDFvZVF3VjVTc2ZxK2lHUjFLRjZDalNjd3pvRG8vOHRQRUp0RGgrSUN0?=
 =?utf-8?B?QXhWSG11Y29vSUkzVkZIdlJWRm5qZXZJQjN6b1BuRy9UOURDVkdadDNtV0ZV?=
 =?utf-8?B?RWlVN1Qzd213Q1JaYmxwZS96c0NRZVZqc0ZNWmxqZ3o5UXJleXNYU2ZKb3RY?=
 =?utf-8?B?cVlHTks3dllUc3hNRSt2b083QjBndURwbURKVzFFbDNiOXUrM1MzMlV3WTNX?=
 =?utf-8?B?eFFBOU1KNzQxMjlweVYwb0w0RzJEbTc0UDJvMmR6K1J4MC8yWmJTREwxOWtQ?=
 =?utf-8?B?TkNYMW80amVrRG8vMUtFNmtoNmhpZEVaYlkxNXB1NHFRSTJvVmk4U29TaDNy?=
 =?utf-8?B?K05UQVBiTDVDWnNxSW5vUEJMWHlLZEJGVEZZNHBIWUpVNzJQajFJOVVlNUli?=
 =?utf-8?B?RG1lbjF5akRvUFA2eGN3R2llYWJGMDJWL0Rwb1VKbzJFUkdaN2NzYkt4Zzgy?=
 =?utf-8?B?WWpITHJGbjF2enZ5TUEzSytEdWJKKzFZdXZ0VzRhck81V0NjclZYa1FWcFFO?=
 =?utf-8?B?THJRRlI5dEhLemVDVEFVV0orVnduVW1acGdKSmVyK3JYRGFISEV1QnV3NEtN?=
 =?utf-8?B?TGpNV05NN2JLS2dkZFBYVUJiRENYbmtjMWR3eTVOQXd4dm93L0dya2cxK3BR?=
 =?utf-8?B?b0xBMWtYZ1gzeHZIZ3owN2VyUkFrbzBLTXEyNmw5cDloUFhyQzNjWVdvZzNu?=
 =?utf-8?B?UWJubnVhOUdmS3JEWVNsRW5hc1djSXhHcnRJUjJJdC9aakNua1N4ejN5WXpG?=
 =?utf-8?B?aDQ1d0tXaFBFVXJqb2N6WWlKVUtWdXhSU3NQYUZuZUxBVlBjR01UZU9SdFBy?=
 =?utf-8?B?dGl6VElrSFZqbGU3S3ZPTFBJMDl2MG1xdDlTdERQa3AvTkozUi9UM1lzdVFW?=
 =?utf-8?B?TC8rb1hIa1FxN0J3VmtKcTV4TWRmbXNyaldBUVU3NThCQmorQ1F6bTE0ZWJi?=
 =?utf-8?B?emQzTGZSWlp6QXFLaDVLM3hkVGo3WTFYMlpWQ3VtZjhuNWxqUlM1aWdEempm?=
 =?utf-8?B?cEZ3Zk80ckFUQ0NtQmVzVFluV2xubDgrR0t0YURRMDNrUEkzRTNOZmlqY3Uw?=
 =?utf-8?B?QXFGVkJMUm84c0NSd09RNWVYZ3hhQVRVNk1veUJqeHdoT0l4OS91c0M0QXdy?=
 =?utf-8?B?ZVhmN1NIdEgvUGhhRnNoR2pvbmU1Q1FydkFVYUFOSmNTcVdUdXdwbkdLSktJ?=
 =?utf-8?B?anBJaExxUWVxWC9yQVUrV09YS2N3Tm1rZ2I4VFdUODVRT0d4YVVyY0xzSkwx?=
 =?utf-8?B?YWhLa0JLTkdpcHp1dTl5M1FZZ0t6UlNXYkVOK1VOOE8vallVNVJxVG1FV2hQ?=
 =?utf-8?B?VnpDVGM0Q3QxZHJ1aWdTS3YyNWpVZnN1VFhXamsra2ZYTHdwbmd0MGNCTFo1?=
 =?utf-8?B?RzZwbDk2aHR3b0NBUE55K3MzZys2OG5CZEtxbmVvWGxOUExzV2RHcGtaOTRC?=
 =?utf-8?Q?63yug3wtICqtIZEHGkerHV7mhIW31Yk9?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5989
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6b86af00-696c-41c8-3fc5-08de5290f2c1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|14060799003|82310400026|35042699022|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXZRaDA1Um1jeDdQZXhtMFBhb29LNTlGSU4rTFFib0RIQ1Y2RkJPNE0rdS9E?=
 =?utf-8?B?Szh3alBsZlZrRUtmNk5NUFhwdDBxd3kwdzJaeUo3WlIyUHZyN3pHZnVBMXBB?=
 =?utf-8?B?WFhjZzVDYmxRMGR0SnlaQy9QM3d1Y2E2c3pLZ1BEZnJNZFhIc28yM0lScGN4?=
 =?utf-8?B?eTlzMWxNa0ZiOFBNZUhnRVZxQmdIcXdvcDBCbGM4Q0E1MWJZNVN1RUJqMnI0?=
 =?utf-8?B?Ry9uUkNMNTRlbzNZT25menUwWDlEZjJDMis1YW14R1ArcU5pVHcva1IrY1o0?=
 =?utf-8?B?MmZrQlYwNFNCYnZ4WWZodUZMdFYrQVZSSGhRU2hhcEttSVlhalkvbW50S0c4?=
 =?utf-8?B?dHJPbFVQb1BNT0JjSGhlM0JmUVAxV0dzQThScEZRMUNRcnNYMGdnVklPblkv?=
 =?utf-8?B?U3ZYaUhxRmlBVzNPK3MwbkpuOXpqSTNONWdDTldER3Zaa3dCa2E0TElacDFE?=
 =?utf-8?B?aExzTE1TbFNhVVBnZHR4ODR3ZnJ1TW9vU0ZzSGIyeWZmM3JWb3dGNXJmZVZ1?=
 =?utf-8?B?cjQyTDZOWThmMVV4RXRBUFpKL0ZtZ2RrUFRTMTRzQnpwaEF4cXZLdjV2cHY5?=
 =?utf-8?B?bFJhUGwra3RUT1Q1WnpHbUJRWmg1VEVvMlc5a3VhT3JCaFpYak5WcWRjVlBD?=
 =?utf-8?B?aVcwRU5NclJHZ0FrbGkwNEc5eHdUaFZzbDZWZGxrL2xVS09oenA3dHU2TVNC?=
 =?utf-8?B?Y1FkbzFYUGsxU2JGSXNLckZsTVZGelAySkszR3hsa3FnU1BieFBUK1IxeGR3?=
 =?utf-8?B?bVUvS0RXNFYrQlZhS2dDRUw2MlZPYXZtU3NqZzNjS0RIR0tCcFp0N0dHOFds?=
 =?utf-8?B?QUoraVJIUFZTbW14ZWFiQ0MwaGFITmtUWW5OZUkxRHRuTWx0YTNITkFXZDhX?=
 =?utf-8?B?cERENm52bWw4OGpGblZEUzBHSW1CdVVkM0NBemRDZTZ6R2U1aXliSWlOTFpp?=
 =?utf-8?B?YzNuaTJaVHhOUUVYRzVrQ3NkeXphSE1tc0tPY01iZUI4ZnFESHdoYXRFV2gw?=
 =?utf-8?B?dHpaYzBlMWpSbHgxRWNEaGhkWnVUVk84UlZvNDhVeU1WVm1UZEYrNFhpZnVi?=
 =?utf-8?B?V3kxNEtTNEVYT3JXa0JkRXFPYzJveUEwY1hZUnJGbzB6TW54MDljRnNwbzdR?=
 =?utf-8?B?VVYydGM2SHlUc1g3b0xQNEl3a1lldGR6d0h3Yjk1TFZQN1lLOWlFL1hUUDgw?=
 =?utf-8?B?RnhNUTBaMnZrdXVvbVJhNWRtUUkwd0hMd1Y5VFFYaS80Tmx3dlpnSDNIZE9S?=
 =?utf-8?B?NUhFMEF0dXVaSmtqZ0hWZW5LU1J4WXJaTTdmT29mdDZhMkxhaVcwdWRSMDh2?=
 =?utf-8?B?bGthZVYrWWVveHRsWmVhcUY1elRVYWdjaVFEY2thM24zdngwMTB2VDI1TXZW?=
 =?utf-8?B?TGFkQzlLVUwvVU9ldytNVE9SZUlQamtJLzNNOGVTNEJyQ2ZqaUx2eHhTRHJy?=
 =?utf-8?B?M1ZQY1BncVFncjNTNWdESWFySmc4R1Z3QVovazAvem5WbExRTE1ObzE4Q2VV?=
 =?utf-8?B?TUpJdlpSRURuZjlHbUNBWlhpWTB6YnI4QlJ0bXI4bUE3SHp5UmJrd2praHA5?=
 =?utf-8?B?MkNmaUc4cHBYNlVFMWNveVVsTk8rY1VwMmNpK3p4dExkeSt0MmZjaXZ2VkZz?=
 =?utf-8?B?U1AxK2lPK0l4b1F5Y29VV0hsWElsU1Qrd2NaT09ZdXpXOGJtTGVZM3d0eVJG?=
 =?utf-8?B?MWxRaWJmejI5VmZFalZKVWJ0ODZwVUIzYnpPd2lLTWtScEt5b3JaTzlqR1ZL?=
 =?utf-8?B?ZDN5eWdKVkdGdVU3T01TUUc2SGlmUzZZRG1qeW1lTGJ3enhJYVY1V1ZJUXRR?=
 =?utf-8?B?Skt6RENOTEFxQ2FhOG1pZWkvRE5XV1QvSVE0MlF3YUlwRTQ1L3lJM3lRaERm?=
 =?utf-8?B?cjRXQm4zN0xqaE9JbTVFcVNQUlpFRjdIcVFlcUJQeVBJWE1EcEhjVTdGdFY5?=
 =?utf-8?B?MTRqcFBGOWd6OXJmTmoyaXpIMTR5d0oyYTBPRlhCeVRrRlFkeDgza2hCQnMr?=
 =?utf-8?B?T0d1bzN0bDhxR3orbkdVeEhlaWVxM0ZuUDhFM0N1YkYySkQ2WTQxa0ZJWnV6?=
 =?utf-8?B?KzRZR1ZXTkQ3RkkxVmR4dGRnYkhtZ0xON2J6MGxQQmovM2VwNUh6Q3dNSnFH?=
 =?utf-8?Q?nDaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(14060799003)(82310400026)(35042699022)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:47:07.0560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f57109-31bb-4368-b1d0-08de529118b5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10056

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


