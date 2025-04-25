Return-Path: <cgroups+bounces-7822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EEA9BC85
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A385A7ACA
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1354763;
	Fri, 25 Apr 2025 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lHa/ERUU"
X-Original-To: cgroups@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013052.outbound.protection.outlook.com [40.107.44.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF62AF12;
	Fri, 25 Apr 2025 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745546119; cv=fail; b=Ad2nJNcMM9DaAebAR7d2rR2BKWL7PGYGn8tRcz1A6zwJloxi8YcnMMui/zgrQiBduhdBm52KDb80T16el3+chLPbwINIepVzEqkyURy5D9qxeqDZ5fepucSxrXMZeCAZ0BFmNXoKEG+9qCtCQWG8zutLTkd6/bwHOa/bIYZEzqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745546119; c=relaxed/simple;
	bh=kCWl3CW2hU9C8W9efotxTCTEF8qrKwewJOJZHU9CgRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bm5k33T7//HiONEbpEZFploLJLfHtXORlexocIawBCaju/WTTbC8pUb+60knvu+SXYES/TO663Uz8WEqtr+Qa1ibDnIPqpLakQfvY9aGCgQQWF48ph5I8NtNl85DmittnpVS7vISf0i7MUPfNu4ZLxG8z2JyvUWuFdIkaIUzRKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lHa/ERUU; arc=fail smtp.client-ip=40.107.44.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enSe69n+tZ8vRmxIKGJhcq1k1bo3HHaLLxysfZoxLYDbsC5z4g8etb9sP9ozbhuXA68v2f31F/Yh7vrxQ+MVS8HxG0ajWXbSgWzqALHAeXkTipE3Fis1oynkT/pKW7XlSh6YhQTc4x7X3mHPrhypsOZwZVgftUWfPige5hmFK8DgPnkCIM75Jrf8AsCExeFGLF8W0OrSlT2T6ngKwYDwJ+Jtpit8LZFtkt6qQO671lxsSWtbQW+doecYOfggpDdMLn85fM9c/PUtjNtsIHM3xlQVcWOzLx8ZvvStpyRRow9u/sv+H7LpVv7y6w3iK6dZaLTa/J5HR1xEK2054uBxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCWl3CW2hU9C8W9efotxTCTEF8qrKwewJOJZHU9CgRs=;
 b=yMZtvZJfB6GZokaaBoLxz2t489sFDiFe457rFEg/GFO/ZuGU+BWCu2L8v2VghD1LlbAW/gXB81ERC2cPcnQX6RkrJdia9YfKCnPGBWjj+tkDhPH49zwshQCZr7IJ7PUZxxDwa6Djdhn1BJFUYSNmsCWrR6o8BPlDTcZEP60rdkJElZmSJyeRhNZeWRKqIkaEHr1Vn6CSsVOZ8RQ+w4Z3piFnbX+73KM34HiMX1kb3pcD9xWmwjgW9/T1kkfrkXOoXkAqqygTBMGpBfLbnrVHG0uOwMVx/qnKLU/K2COZXy/E05vcW4f4nG3Wp2OwZvcj1Z9oOCopBV/SDcw3Z8evzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCWl3CW2hU9C8W9efotxTCTEF8qrKwewJOJZHU9CgRs=;
 b=lHa/ERUU41x4v1ztAqSppXxfrRbSKYe3EDuUQkFdhVIGOR2cQ5qzOfSzB24aC++Ny2aqcp12lDuWnCsTt+UDfaegOwRWQFWelVGr7RE2LNU0MvczFiN8hZZxVqf48Djz1zXUrkBw9LFtnvHNvpmsEraZWD5JWzeEgLKQQQsINebwXdSz+F1eJF2orhDQ3iM/oKLPdDhAQ66I5zjGxtpXSa1Th8VqGe62AZpuygFE/O8/lQEOCsqJIGyEm1VWW3HDhP8HBOXkRyaZSZbdsFolf6mrgCGBnc08xa27NeXB6mWSqTYcYR8SCyv7/+hX00Xv/EFBSvR4sffa4zyW342+lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6345.apcprd06.prod.outlook.com (2603:1096:820:cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 01:55:12 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 01:55:12 +0000
Message-ID: <9ed6e01f-1cce-4a1d-b3f0-9ac152308105@vivo.com>
Date: Fri, 25 Apr 2025 09:55:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Francesco Valla <francesco@valla.it>,
 Huang Shijie <shijie@os.amperecomputing.com>, KP Singh <kpsingh@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 Raul E Rangel <rrangel@chromium.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Paul Moore <paul@paul-moore.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, opensource.kernel@vivo.com
References: <20250424120937.96164-1-link@vivo.com>
 <20250424120937.96164-4-link@vivo.com>
 <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
 <lkumupd7gkzcui2wzssz4tzrw3cchta67onxnykxjldssmfnei@54mlc5fn3brk>
 <1166b629-92a0-47d5-8cba-01aafd928e25@vivo.com>
 <xp52maa4uvkgfurxpfbu2bxcajqvlmu4xk7bj7qpiipjtx7sha@vqc6r7lzmley>
From: Huan Yang <link@vivo.com>
In-Reply-To: <xp52maa4uvkgfurxpfbu2bxcajqvlmu4xk7bj7qpiipjtx7sha@vqc6r7lzmley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0267.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e367024-cc8f-4469-218e-08dd839c36eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNhaitLZ092dk1DZ09jVzZVYktuSzYydmFEc1ZJZ0w5MllWL0tKVUJmNjBQ?=
 =?utf-8?B?MXJoclM4R3dLSUlLREUrQ3VKQllrai9mZlduN0NTR3p1dkdhVG16M29GTnA4?=
 =?utf-8?B?czJ0eWNYTmd6WGhyZTBMUEtRQTdMUTJwcWZKOTk4TjN5TUUwa05RWEtJM1FC?=
 =?utf-8?B?Rm4zK3hIMzJua0haVUZqaE00SmNiWDVqRHJmOTdzclMrNU04SStEcXpSeE80?=
 =?utf-8?B?eFlnTmE3amx3bXRwRkxrRzlseUYwa3E2ZkdyY1hEYjBYekxPeFY3TldDamY4?=
 =?utf-8?B?M0EvN1l6RHNoZTVsYmlLckg1eWF2WXo4RStvWHRPTk9MVTltRGlMRjB3QkU4?=
 =?utf-8?B?bkVnaWlXNE0wTWJKSzMva3RTSExDREdiTG5ZaW1WVzEwSC84bTZZalBtcTBa?=
 =?utf-8?B?dUQySXBjNkhrTmRIelhQZDVpemx4djJ1WHJHc1pQTzhldXEzY0pSM09QVVhB?=
 =?utf-8?B?RGdKdXlqME82S1crcGEyT1hEd1d1bDFEK2xwMkJqUjhtVmRxZlZTZ1JuQ3Zy?=
 =?utf-8?B?cml4M3g3OFErbDBDZkUvWDlKNE5XT1FLMHZDNHhhUGxvOUdhTzc4aXkrYW1W?=
 =?utf-8?B?RURSaUNWN0psSGtNRjJJQWQ1OEpLSGEwNENnWFFBdTFCZUFnVUhOZGtYRUJ1?=
 =?utf-8?B?VkdkMkVLNFZZdnlEWGw2Z3M1NGwzcTBUUE5zK2dGbjNqQUdUTW8wVUxKVVUy?=
 =?utf-8?B?ODc1WElIYS9lUkt2cExZVVVUUnU1MjJzZ2FIekphMUdheUZyeGtlMnFrcGVl?=
 =?utf-8?B?N2R3U1hCclFKYlVqeFNIaVIzNUlsRDkreW1pRVVsSW9xbFU4UVFKQjJjdG5L?=
 =?utf-8?B?ZFpvejRSQVBpL0FPVFJnNkkvaWFkV29NYnJLdENEbzhHN3p3NmJnTXBLeE5N?=
 =?utf-8?B?OHVTdFJRN2tZZ2d3S1oySVVqamIzZytaY21QVENlYlF2eXBodGlpY2NKSjdm?=
 =?utf-8?B?dXFXWHBmNDFLN01kdDFZZDRnc1RDYmQ1YzhEd21MMExubEt3WkN3Sk16ckVR?=
 =?utf-8?B?d211WlVPd1JhaTI4d3B6MURaNndDMFdEUTk0QlEvaHdSUk1iRHRUNXJHU3Mw?=
 =?utf-8?B?Rzh2S2M1ZUpKQVpsRWMyL2Y3QVdNWHpLVUhPbEl5L2VwcGVqaWI3c29hVWhP?=
 =?utf-8?B?aERwYldjREREejJKdFRCdm93T29GOUs4bjdDLzE0ZnlLK0w1S0pvMERqZXhK?=
 =?utf-8?B?UEJqRFdHb2NDejVEL2NvbmJhNk9xaGZjUllabWNUVlhITHBObmU4M2tOTmZ6?=
 =?utf-8?B?Y2xNRWhuRk0vVzZpVDBZZC9IS1VVbzhPYXFKa3F3MU9JOXRXQkVCQzdLM0U4?=
 =?utf-8?B?bDRCRkhyZFNxWTJtbEtKVWFEai8xVlpjQUdxVFVHV21TRTVBRE5yQmRYazZj?=
 =?utf-8?B?OUJMeHVJNHFOa2JDT0JWVTVFMHRkTjJSZXBzbHJ2V1kzMlFoZjloMGxFVkxj?=
 =?utf-8?B?T2cwbWJUMnlDd1AvKzJ6Y0NXVnp3a1MrWEp5VmxFUCtEZkI3ZWVQamlkUm1T?=
 =?utf-8?B?bHlNYmdEZmJYYWYyVS9sN1NJSVJPaVoxY0F6SWNEM1V5ZG9IWHBFdjVSaE1G?=
 =?utf-8?B?ZE9ZVmJiN0JLWDFIR2xmRFBHTHRoVWs5S20wTkZzY2ZkdVNLWUd5RkVaRVNi?=
 =?utf-8?B?YndTaVF5MzU4dDZLTEpjZGZVSUMyd2FNdG43Zm9QOGg0RHVhRTlnZ1J4QVlw?=
 =?utf-8?B?czBva0pSOHVvMWhSOGxwUEd6dGZBV3ZJQzJwcklRMGZVWXRyV0J5YkVqNWZw?=
 =?utf-8?B?MzRLOWIvOUZXN0hrdjNiVmVJaDZqYjMzTnNuVkJ1VlU0ZTdnM3BKNUlsQTBs?=
 =?utf-8?B?WnlqTE0zYWVSTEQ4YkgwaTEyc3VlQnRMb0xGQWVkTnIwZ00wQi9jL1VVN3ZW?=
 =?utf-8?B?TFBIQ1ZzenArU2dkaWtYdkRvbWdCclNCdXAvd2YveHNQNHJSaDZWUWFkbHpX?=
 =?utf-8?B?NkgwQUJhZkRTMkh6VGVtOTl0M05UZWpqbFIxdS9OSElmUEJMM2xHWFkxcm1x?=
 =?utf-8?B?aS9qMHVTNjdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHVTT1Q5WnNSbW5GWTNicWtpRFRPakw4cFF1UnpGTnRja1FlWHpVK294Y0I3?=
 =?utf-8?B?OXFPNG41ZFlTcERqWlVPK1dhTmNWbnJDeWowTDFRT0I5bjk2by9xVm84eUYv?=
 =?utf-8?B?RmY0MkpsaC9Cc1lxeVNmNTI1N3gvcEtkcEk0d2ttVkRaQmt3dkJ5Q1ZqTEtQ?=
 =?utf-8?B?RGpyWmJ5Q2ZUQUtySzBNYlNCSXBISURBVXRINEFPQktHY2Q2SGhvc2xrSE9q?=
 =?utf-8?B?czJpYUJIZERDbnBZMkZWQU9kc2hZT0l6SVRFUUhIblJ6d3FCYnhEeDhpRVBi?=
 =?utf-8?B?eVpTOEUyeUh1Y3hveHVDRGlhOExPWXg0WGo3Qk15aW02MWN0VzEvTG5vd0Jx?=
 =?utf-8?B?Tjc5RVU2OElPTEhZMGJmeGRGbFp6ZXpJVjBpaXh5ekdTN0F6OExIdTVpWklO?=
 =?utf-8?B?ckhZL1FiZm1EMnVjbDdBYU5ZVUxDbm5WU0IvMUFQV0ViU3Ivb3R0UWxpMmJ2?=
 =?utf-8?B?UjJzWmpmWUpLZEl4R2dsMFlzN0NNSWEvK1hEM2VGTlQ5M1lhQytCNDlJZVFM?=
 =?utf-8?B?Q2Q3SlFDRmdha2pLZXNHNDZUWjVES1VvUU00WU1ZNVJlUnJEWktuaHpiSFZE?=
 =?utf-8?B?WlZCSk9xSFQzekxBUGRTNXRNMXpYbWtHMjc5TkVqalBGSXY2Y1BqT0czZGNG?=
 =?utf-8?B?NEE5NTZVT1VxOHYxZllWWC9LaHQ2U0NxdFloQTMxbU91RHU2dXZaT1kwY0No?=
 =?utf-8?B?Z3hhRG41cFRVTy95ajJFVndacHIrQ3NCazRXU1BBWU5FQkhYSFhRVXd2dFBR?=
 =?utf-8?B?dmVHdnk3QWxoYUpEelBOdWtrb25LVmxuYUwyN0FNOFYzN3UyTytlVi9OVW82?=
 =?utf-8?B?M0NMSjJPRUhjL0lkVTlSbGhHeDRVUmtWb3pCNlI1MTBjMjRYbkoxNHQ3d0Q0?=
 =?utf-8?B?MGY3cmcyMENMYVdLTzhDUW82dlo5RlRTbkE2MzgwNDB4NW5JSFFhNVNWbXJB?=
 =?utf-8?B?dGpGRzlLQk9zcko1M2dkd2hMWm5IY29aNkh6a1FWS2N5MkRxNFZ4Y00vZkRl?=
 =?utf-8?B?cGEweFVBOWhOS24vUlBzZ2hmeW5CbVl5UkZHaGFOSFRyajY4SDRWc28vM24w?=
 =?utf-8?B?bXRIOG9KaEJTU3M5RWpzMEFSanM1NEdqM2F2MFYrZXVSTXBmR2N6TTdlRGNN?=
 =?utf-8?B?TU9KZ1p0RWJzSFlNazlhcldZWVZxN2FMeElPUURRV0ZFem5rNjFKQlVCWVVH?=
 =?utf-8?B?OExLWWNlY2kzUGNHcFdmZisxL3NNQ0VXamc1QkV6NlNuK3BUUEVsNDBuNDRu?=
 =?utf-8?B?OVhQM0txMzFIZDRDSlFOL0V2UkxCVEdFNWtSWExKRFRLbktqdHdteWdxOWRk?=
 =?utf-8?B?WG1NcmQ2UnRiamFXT2VZdHZsemxEMlRzVVUyVis0bGtpcnZDYWJ2Q0NZSDVW?=
 =?utf-8?B?eDB5b2U1SDR4ZWQwck5FR0s3SERSNmtKdFE3NFNmeThkU21XVjB2VG8xdTBm?=
 =?utf-8?B?K09TSzI2UGhoTnhPckR2L3plOHB3Z09vMjRFM3V1aktsTDdqS012RHliOWo4?=
 =?utf-8?B?M3RhNWo4UHFmNFhLeSszVUE3cGxFNlUvdmN1UkxodnNjM25ucHVRRHIwcGhC?=
 =?utf-8?B?N1ZGWnRWaVgvc0tvbGRpSlcxK0ZuZjd2c1NSc2hYRzUzZHVvWGpLQWF4UzRO?=
 =?utf-8?B?YmFhczVYQVVTcmV1dW05ckN0WFpJU253NnJScmpuWHhLUU5wdk5XLzZlQ2VK?=
 =?utf-8?B?RW56dUg5cEErR3VDeXNUNTBoZzBoUjJhYkhseWdYV0xhRUIwWnYxVEt0NTNE?=
 =?utf-8?B?RTFRa0lyNGdJZldCZjI4cGdyWW9wMXllZ3ArVitSV2dQK2VXeVMrdmJZYnZS?=
 =?utf-8?B?OEF4eTdUWnh4TzlybVp0cHFjOVMraWNKbzRReTFzNDVWRHRmVk1OeVA0clRt?=
 =?utf-8?B?VzMyc1kyelNZRVZBTGJ3eHR0MG5Jd0JhUGhzZjVpU0VEK21kbGJYZ3NwSzcv?=
 =?utf-8?B?eFg5OW0zaUlMeDdRUkhsR21EYmZ3aHFvTlRjN21ySUNrbHhFZDBXYXZRMnRs?=
 =?utf-8?B?SGVsejVFamJQaW9rUXZHYjZ1cGczNm5wQms1SGhNQUoyZnZpMzZiOFk2M2xp?=
 =?utf-8?B?Vld4QkZwYTExODFIVm5hZEJCMGlUOGU2ZlhLTm92V211eGJydjJadDZHNjJm?=
 =?utf-8?Q?IqdRhfUKHx4XT7ANe7r8iW6P4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e367024-cc8f-4469-218e-08dd839c36eb
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 01:55:11.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbrhhWs5xIQbwRQ6mrO6hm3NJ2e6yePtmxW8vmGJ2fOEI0ivL34oLpL0CTXjUCQAzcS6qd8qZ5y1fKdFQYHryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6345


在 2025/4/25 09:30, Shakeel Butt 写道:
> On Fri, Apr 25, 2025 at 09:11:01AM +0800, Huan Yang wrote:
>> Hi Shakeel
>>
>> 在 2025/4/25 07:00, Shakeel Butt 写道:
>>> On Thu, Apr 24, 2025 at 09:00:01AM -0700, Shakeel Butt wrote:
>>>> On Thu, Apr 24, 2025 at 08:09:29PM +0800, Huan Yang wrote:
>>>>> When cgroup_init() creates root_mem_cgroup through css_online callback,
>>>>> some critical resources might not be fully initialized, forcing later
>>>>> operations to perform conditional checks for resource availability.
>>>>>
>>>>> This patch introduces mem_cgroup_early_init() to address the init order,
>>>>> it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
>>>>> by initcall, mem_cgroup_early_init can use to prepare some key resources
>>>>> before root_mem_cgroup alloc.
>>>>>
>>>>> Signed-off-by: Huan Yang <link@vivo.com>
>>>>> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>> Please move this patch as the first patch of the series and also remove
>>>> the "early" from the function name as it has a different meaning in the
>>>> context of cgroup init. Something like either memcg_init() or
>>>> memcg_kmem_caches_init().
>>> BTW I think just putting this kmem cache creation in mem_cgroup_init()
>>> and explicitly calling it before cgroup_init() would be fine. In that
>>> case there would be a single memcg init function.
>> Maybe someone also need init something after cgroup init done?
>>
>> Currently no, but for furture may need?
> If that is needed in future then that can be done in future. I would say
Yes, that's right.
> simply call mem_cgroup_init() before cgroup_init() for now.

OK, I'll do it.

Thanks.


