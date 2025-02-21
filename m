Return-Path: <cgroups+bounces-6634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845BA3F38C
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 12:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C619C1CDC
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FE209F3C;
	Fri, 21 Feb 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyAt2KYn"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDE1FC0FC;
	Fri, 21 Feb 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138991; cv=fail; b=YtcZJ/Fs0bHBpCMWVy2ak/0xcWeblb2FChZmqltjfiaxML2fcMRc6+gzMOjyQln2Q5IFsmPyWTL/YGXWJmhOCdjIVLaXcVyq1mpFfas30j2DBKILonfKSVki+pWZl5S2wdr8uWeHqGKwMXOAMzi6nc7c/llDF5+XZVRLDnL+Xz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138991; c=relaxed/simple;
	bh=BoE3l4kWn4hNCKN+ycT3Y9O6Do6h0FadcP3EpFsTbFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLdDJZ9xw1La0pVB+S0CzJliYPHrROelFrKjNvMDjIkiRlO2TXykvwqk9803A+m2wuorbC0Br3+ujYG9/gc9YFNug9p2TjtqYTGdlbukR6PF7grsO+p60vgyI+WwkdIHmE/zPECDDqoENqGhspMQrWzsFe7/NhIDwDwYgldrtr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyAt2KYn; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLGrZlX/fozHytEf3J5wkcKCNgamv7Kvtj1hoOCogZ1N+ok9rtTZkA140qeI1tPntJerWt4/XtDFk5t30lhA9YrskmhW1xzjcNQ3CWh8RSiRwKEjtTD6HL6GrjKlf68erKffATkcc6O1D7bRp09b94dG5AKJmqH8wg71qjIj07xN+1W7PpT8ADke+ghleNMsbh3K+M489f9Xr/fFEkFfG7sswpnvIUuyu0ZzLaL/Q4Nv9UGzS2bplMw4+uQLnv4t/GMZQhQnKt93rj0n2FanKw3LOCvHni7LV3kvrfanmcmtSms7vkPW5uRez5YvDQFz5hmKqy9CxZZYWZr992gAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo3KKATzDjkABnhNDxut7CMjD0J8MQVWTXcVboY6nuQ=;
 b=WD7+5QE/vHVXKrsD/l5eKqd5cMcnqmyMbuQco/QRobMKE1MwFnCh19WylNaSPglhJW7/uF94qLdaqx0HLEvyr1VkEOvv2MYDji7Bm6GpkvTp+WVVZnACZV130zLRQd6O26vo31ws9k2jdGPU2bZvTT1ofnIxLN3/LoC2+vvv1aNlW5kpYycVdGalG1jGqVLfpe1hpchjJcUFJtgVUgNzB+ZHD5GiMFDa/kEqyjSkvwUaxVO5v1a3Cjj2GwoEJ7yOn7MuujAatj/xf29uCMpz2hhwaDh6e1Gsl/IwhCUIYpfkiPg57zkxxqeysRB6uI4Q8Oh0dCd7TNQq2Oqd1Vsl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo3KKATzDjkABnhNDxut7CMjD0J8MQVWTXcVboY6nuQ=;
 b=eyAt2KYnJ9lF3+D1vw9F6gjl5OSNUYGrbyn1QsfCkzAiYaVFnXvDTy5EnSLqVtNbQAsPTCaxVte0Wlww9HKKsuhcymXpbyHk9miJfR+NEUypZSNUk+Y+il7D//WVPSLdHV+jHYfc5jhmjKYBoJOAepSyGW0Y+U+AgyWwwxbjFDkg2I7s7Wg5xxS1jrOMxgKYeUrlL1Zrp9E87nCeyAiIFW9Y1SWFgiv2cP8f0kLmTrp83CsJbSF9zhgCrVsUwNh2odPv3POolr5jI6boKOwllLiBQBZBbkpoxe15bUBjzoIuPpDyh6724qcpRjJsea5I56N1aORTEsWR5OcbAH0IwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 11:56:22 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 11:56:22 +0000
Message-ID: <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
Date: Fri, 21 Feb 2025 11:56:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: dff02036-4e84-4bee-e481-08dd526ec28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmM1cHJGZmNXbjlkN3FTdnQ3Y0tYOU5LQUg0bFcxajY0K0pjTTRvc2dXSUE1?=
 =?utf-8?B?QjFHT3h0SWFoalNpNS8wcW5UUERPbWRGSHoxQVRXaUxOWVF3OEpsN2xCRTJF?=
 =?utf-8?B?S3BSN1dYdEFFS2pod00yQ1hIRXBDdmlubTREeC9QWlNoMko1SGZDRFV6QmZo?=
 =?utf-8?B?YTBDUUpZWkJKTGUyTzBRQ3JDRTJnR3Nub280NC82NlRTbTdJbmhUY2xhcFp2?=
 =?utf-8?B?LzVLSjV0RUpESFFkTlpyUFA4ZjZDRjI1SEp1NW5XRmUrUzZsTDkyc21DL2dT?=
 =?utf-8?B?MDhrOW1UeTdtNVB1NUhCbEFvaFVNbGlLZzk4aUFucDgzS01vbjlBUnUwcFY2?=
 =?utf-8?B?MkljbWkyaXN4Rld3VFdBekxUOGwwMTY5RCt6ZUFmbE9PRy9FVHU1ZlVoUGcr?=
 =?utf-8?B?UUV2YTBZalZXb0F0RUNxYnRCRTBtZVYrL0Ixd1BQSzBOQ01OTkdDNEN6d2RG?=
 =?utf-8?B?bGNDU1l0Yjk3ZThMOENhT1F2RnhmenYzU0Iwb2FPWDVJb2dQWk5iTmRLaVE0?=
 =?utf-8?B?NkkwVVpPWVNMN2F3am5rVW5YNHZwQVZCemZsYVhvM1FUWHU3VGl3Qm9ubWpG?=
 =?utf-8?B?eGpaZkUxd1RxSm0xZ1IzNm45OXZtOTFRcmErNURjTnhWSWVYRkxlTUZJMHl3?=
 =?utf-8?B?ak5yV1h0d3pOY25mYmtxN1Q2RHB5QStQQmZNRWtvSzd1dW5mUUxnM3JJZndZ?=
 =?utf-8?B?UXZMNGw3Y2dQalliSVVpY09MUlZlOVRUN0NVRzlxVExiczZmTWNySDFzUk9n?=
 =?utf-8?B?Y3NwNlZjcWVDbVJWOHpsd1VKTEF3NmJBS0tKbUJ6aFA5bnhEWFVSTVZiQmYv?=
 =?utf-8?B?QldZeDdCZWN2K280VHhURU9Qc3hqeU85cC96TU9IYnExblp3WGRrTk1HeGp0?=
 =?utf-8?B?VTd0eGlSQ1lHM3h3RXVaY09ORS95ejNGbkZlWklVaVF5c0JmNG5HSkxHalZk?=
 =?utf-8?B?aklEVmJRU29BQmJBZ3FyL1lhSzZEOHJuZkhzZ3RiaHRDcE1nT0MxckJuaXNB?=
 =?utf-8?B?VW04SlFqdHUzcFBjSldXemhzbS9LMTh4OHB4eXh2Kzl1VUhmUUVDTEw5NkhP?=
 =?utf-8?B?MXZBQWlKS1hEYnZEZmRDeklyQ2l2LzJtUEJMSlltcmVZYk5kbDlhcjJHck9P?=
 =?utf-8?B?ZDNvc0xDNmJBVklkeVdSWUNxaVlyN0tBakVzVnhuK0tBbERSM1RpSjBwMWtC?=
 =?utf-8?B?dmhjUERvWkZHK1VXTFRZU1QwYytLenU4UDA2eFFHODdKN1llSjVzcGxHaXFJ?=
 =?utf-8?B?MXJQenN0a09lTSsrYy83cU1STVFPQkVSd0tGUVU3bW4xNFF0VWtEL2ErRGhS?=
 =?utf-8?B?NklIQ0tDeVdxUkg4OU95bnNTQVFCcS9UVXEvQ3MwdktBd0V4azBIaTIwZnlJ?=
 =?utf-8?B?azhjMWhYUzYwUmRqemhsbEY1SjM5QUNaODFHSjhDTExhajYySk5pMWNSZ1JI?=
 =?utf-8?B?cjlXUmQrakxYaUEyTERSUVZ0dDNsOVdlNy9nd2pQY3ZHazFrSktpSEloSGYx?=
 =?utf-8?B?SFg2WmIwR0lYVXRJRFpiOVlYdVlWNnM5c015Znd5cEtsQlBTU24vYnNWM0U0?=
 =?utf-8?B?dExoK2hhWFM5WXZuL0huZUdNT3VpK09lTkdOVkt4Qld6eUhUSHYvK04waDNS?=
 =?utf-8?B?SGpuWldTdjVYWTMxN25EamhJNjNtVmQyT3l1ZlJDVWRxeGswZHNIUTJlQ1J5?=
 =?utf-8?B?b3BXNndRbkRYT252bHdMa2JPY041dG5xWVZMTzZqL00xa3lybXdjVUJMUFlz?=
 =?utf-8?B?LzY0WmVCQldGSnMrTmF4aHZ5WWdPSEpCN0F5SkpOc2hIUVhQVWZ1N05EZEFh?=
 =?utf-8?B?TnZzR2s0anhVMFFmT09sNHNuU3BjT3dmckFlb1J3aEZWajRSREpuMm0xaGgx?=
 =?utf-8?Q?oQnKpL1FMnucM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N29KSkJzQmpMZ1FENGRYSTY4NHNjTUhCUjRLQ3V3Tm4rcER6TVdYRzYzUEY4?=
 =?utf-8?B?Y1ZmeUdvQUdOUHpnTFYxL2ZoNTZ5ZkF2bjVCY2puL0l6QmFLTmJmNTQveU9H?=
 =?utf-8?B?ZUR0SWk2NUJua2NRcG04anZmbVhVUWdxaXh5ZDhKN1l6MjRVZC9tUzRjd3V1?=
 =?utf-8?B?NWZ2U0lNSzFabVo4Yko3dzRqb0F0Z3QxZFFpdUhXOUhSSm9Ia0dPZXJhTUdi?=
 =?utf-8?B?T2Rab0tlLzc5b3o4NXVsRFVkcC8ybmhmVHM1WXgvZE1zMTZrZEZUMlB6YkI2?=
 =?utf-8?B?STRiZDY4d1M1eVNXclpmdE1qY3VUWWdONno2UE0rSGRYVUJOOWtzWG03bVlC?=
 =?utf-8?B?ZU9COTRtd2NMbXBSOW9IWEQvdXp6bWF0Yy9KeEtYNzJyeXJVa2RhRkRNcWIr?=
 =?utf-8?B?SVdCZzREWEJxOXAwUE0wMElwK0ZYV3VrOFUrN3BDK1NzREYzdHozT2srQUpG?=
 =?utf-8?B?dUlET3FXdERsb09DOEtnRloxZ3lJOXRqNzNTMkVDWUZqV2lwdjU3djRaLy9v?=
 =?utf-8?B?cGtreklnUjZ5SUhmb3EwajB3dDhDOExWdFlFOUkrSzAzeGhJZGdxSXpDNTlp?=
 =?utf-8?B?eGx0UTVJZTVPVDlIbVI2c3NKZHhySDNZZWN4MTNzdW1rN1gzdkRCUWRHMDhh?=
 =?utf-8?B?cU80TGlmTThaNGZWbzV6bXg4Skx3L2xaeUNhRHRlV1pzTSs0MVNEcC9ORXRo?=
 =?utf-8?B?NXlWRkwxNXlER2R3d2g1Ty85bk1SMUlORjBkc1dWOElzVWR2c3JmZ1N3WWRi?=
 =?utf-8?B?d3pqSVdrOVlubWRjZ1lqcWdOdmgvRnlJcnhEbTJDalBsZ0lpUjVxenpQNmN1?=
 =?utf-8?B?VzZrTjJZVU5XdTVjb3d6d295S3BwQ0txcDRaZGdtUjRtV2l3cHRSOHBVQUJR?=
 =?utf-8?B?cTlSbHhPdFIyNXNBYlNWTEdEM0RvMkhHb1ptaTliRWtmK1o5R1pQSVBKQUxL?=
 =?utf-8?B?V24wWWZQKzhkZzN5TVpyd3lSVDY5M0VGSmw0VFNZWEJhdmV4ckphSDJDOGJF?=
 =?utf-8?B?RTJDVlVKU3JtK3Vwc0xKZ1RBMTgyR3VINEtLWmZCdTBDOXBoMEFpbnljMzlm?=
 =?utf-8?B?RmpSTU9BUllicCs3cjkyaFpIRHpyZUZkSGd5bEEySlZtMmcrbFdzU1JFNEZo?=
 =?utf-8?B?c0ZMLzVDS2xVODdzQjdWU2xHSVRSWHkxR1lrVlZYb0dHdmtoWDIyeUt2b0o3?=
 =?utf-8?B?RDFpUlJpajRJSCtUS3dRVmtnVGVWNjJUdzBYMWQ3eGFSSlNIajUyT0pOWno0?=
 =?utf-8?B?TFM1Q1hONzJGSkFHcVQwNFQ4MEhTK0d2YkJZa3dzczN0SEJOaldDbUxBcW9x?=
 =?utf-8?B?emE4dlo1N0M4ZVg4eDVqZVBmOFBVUHZVN25jYXpobXRxWnJZK2dHVmplMGVl?=
 =?utf-8?B?ZFh6TUxhSHZRM21wbm12c2JDUVV3ZjdCOEVWZWV4aWhuK3RML0psY3A0a3VK?=
 =?utf-8?B?V1kvT3B2Q3NGT203bUp2NU5CZndKNFk4YStTcmJyTTY4a24rRURGNTNWY3NP?=
 =?utf-8?B?M3duaGdCUFlYMnRmR0hIbGloWlM4RkVwZzBHRTRGbXdRaVVpYmN6OUh1WGlT?=
 =?utf-8?B?M3JMM0lhOHJOdi96L1h4bWJEdXdBUzhMOE9YZHpDVklyQ1A1VmtIMWlnc1Zm?=
 =?utf-8?B?T1dZM3hOVHNrbXBJdUxmU1FOUnByTWdoa2M4MkZJSTR6YnJxU2g1RERIRVZ2?=
 =?utf-8?B?ckpxSkVjVmZ2eW9Temx1bjJRaFNOTjNBZDlXY0ZTUUFkQ0lrdVVNQW04YURP?=
 =?utf-8?B?RWlRamJEWTk5cWwrMnZ2UDlwYjl5SkR5aUFFeGpaUjBZUG9yWGdmZzd6Tksw?=
 =?utf-8?B?OHRyUDA1SWtGQ29GTG12WlRQZnpQQnZXeUlPVGlmN0VzZGw0a1pRWmVQbUJ3?=
 =?utf-8?B?VnpxaTRNbnlGNEZXd2FGMFZBVVZtK2NodSt6ejBvRTBhMVVnVUJCTFpkMmRB?=
 =?utf-8?B?UVphY0NEeWpOSUd3OHpaL0JabGtOK01qK1ZITldmazM0YU1pUjVUSk1hTHo4?=
 =?utf-8?B?WkJUZ2lqZVhTOGtqM2tCOTdiNEtDdjZoeElkKzBpQ2xSNExCV0x2MkxRNzVk?=
 =?utf-8?B?Q1NCNHNOcEFGTk1nTjN6Y0NkRjNtWFFwaGN0ek1zRHk3L3BwUlBXMW9zWm16?=
 =?utf-8?Q?pt02Wtxk9xpCPffOtQS/IqURK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff02036-4e84-4bee-e481-08dd526ec28f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:56:22.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URXE9RjIgpEAH2o2Y7mxeMENiIr263zxiXS4D+0KwCbD8Di8vWASFKWSF8fRZGHz6N/Rpm1E5jJd6hYzvSmdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456


On 20/02/2025 15:25, Juri Lelli wrote:
> On 20/02/25 11:40, Juri Lelli wrote:
>> On 19/02/25 19:14, Dietmar Eggemann wrote:
> 
> ...
> 
>> OK. CPU3 + CPU4 (CPU5 offline).
>>
>>> [  171.003085] __dl_update() (3) cpu=2 rq->dl.extra_bw=1122848
>>> [  171.003091] __dl_update() (3) cpu=3 rq->dl.extra_bw=1022361
>>> [  171.003096] __dl_update() (3) cpu=4 rq->dl.extra_bw=1035468
>>> [  171.003103] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DYN
>>> [  171.003113] __dl_server_attach_root() called cpu=2
>>> [  171.003118] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DYN
>>> [  171.003127] __dl_add() tsk_bw=52428 dl_b->total_bw=157284 type=DYN rd->span=0-2
>>> [  171.003136] __dl_update() (3) cpu=0 rq->dl.extra_bw=477111
>>> [  171.003141] __dl_update() (3) cpu=1 rq->dl.extra_bw=851970
>>> [  171.003147] __dl_update() (3) cpu=2 rq->dl.extra_bw=1105372
>>> [  171.003188] root domain span: 0-2
>>> [  171.003194] default domain span: 3-5
>>> [  171.003220] rd 0-2: Checking EAS, schedutil is mandatory
>>> [  171.005840] psci: CPU5 killed (polled 0 ms)
>>
>> OK. DYN has (CPU0,1,2) 157284 and DEF (CPU3,4) 104856.
>>
>> CPU4 going offline (it's isolated on DEF).
>>
>>> [  171.006436] dl_bw_deactivate() called cpu=4
>>> [  171.006446] __dl_bw_capacity() mask=3-5 cap=892
>>> [  171.006454] dl_bw_cpus() cpu=4 rd->span=3-5 cpu_active_mask=0-4 cpus=2 type=DEF
>>> [  171.006464] dl_bw_manage: cpu=4 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DEF span=3-5
>>> [  171.006475] dl_bw_cpus() cpu=4 rd->span=3-5 cpu_active_mask=0-4 cpus=2 type=DEF
>>> [  171.006485] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
>>> [  171.006495] Hardware name: ARM Juno development board (r0) (DT)
>>> [  171.006499] Call trace:
>>> [  171.006502]  show_stack+0x18/0x24 (C)
>>> [  171.006514]  dump_stack_lvl+0x74/0x8c
>>> [  171.006528]  dump_stack+0x18/0x24
>>> [  171.006541]  dl_bw_manage+0x3a0/0x500
>>> [  171.006554]  dl_bw_deactivate+0x40/0x50
>>> [  171.006564]  sched_cpu_deactivate+0x34/0x24c
>>> [  171.006579]  cpuhp_invoke_callback+0x138/0x694
>>> [  171.006591]  cpuhp_thread_fun+0xb0/0x198
>>> [  171.006604]  smpboot_thread_fn+0x200/0x224
>>> [  171.006616]  kthread+0x12c/0x204
>>> [  171.006627]  ret_from_fork+0x10/0x20
>>> [  171.006639] __dl_overflow() dl_b->bw=996147 cap=446 cap_scale(dl_b->bw, cap)=433868 dl_b->total_bw=104856 old_bw=52428 new_bw=0 type=DEF rd->span=3-5
>>> [  171.006652] dl_bw_manage() cpu=4 cap=446 overflow=0 req=0 return=0 type=DEF
>>> [  171.006706] partition_sched_domains() called
>>> [  171.006713] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
>>> [  171.006722] Hardware name: ARM Juno development board (r0) (DT)
>>> [  171.006727] Call trace:
>>> [  171.006730]  show_stack+0x18/0x24 (C)
>>> [  171.006740]  dump_stack_lvl+0x74/0x8c
>>> [  171.006754]  dump_stack+0x18/0x24
>>> [  171.006767]  partition_sched_domains+0x48/0x7c
>>> [  171.006778]  sched_cpu_deactivate+0x1a8/0x24c
>>> [  171.006792]  cpuhp_invoke_callback+0x138/0x694
>>> [  171.006805]  cpuhp_thread_fun+0xb0/0x198
>>> [  171.006817]  smpboot_thread_fn+0x200/0x224
>>> [  171.006829]  kthread+0x12c/0x204
>>> [  171.006840]  ret_from_fork+0x10/0x20
>>> [  171.006852] partition_sched_domains_locked() ndoms_new=1
>>> [  171.006861] partition_sched_domains_locked() goto match2
>>> [  171.006867] rd 0-2: Checking EAS, schedutil is mandatory
>>> [  171.007774] psci: CPU4 killed (polled 4 ms)
>>
>> As I guess you were saying above, CPU4 contribution is not removed from
>> DEF.
>>
>>> [  171.007971] dl_bw_deactivate() called cpu=3
>>> [  171.007981] __dl_bw_capacity() mask=3-5 cap=446
>>> [  171.007989] dl_bw_cpus() cpu=3 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
>>> [  171.007999] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
>>                                                                            ^^^^
>> And this is now wrong. :/
> 
> So, CPU4 was still on DEF and we don't go through any of the accouting
> functions. I wonder if we could simplify this by always re-doing the
> accounting after root domains are stable (also for partition_
> sched_domain()). So, please take a look at what below. It can definitely
> be better encapsulated (also more cleanups are needed) and maybe it's
> just useless/stupid (hard to say here because I always see 'pass'
> whatever I try to change), but anyway. Also pushed to the usual branch.
> 
> ---
>   include/linux/sched/deadline.h |  4 ++++
>   kernel/cgroup/cpuset.c         | 13 ++++++++-----
>   kernel/sched/deadline.c        | 11 ++++++++---
>   kernel/sched/topology.c        |  1 +
>   4 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 3a912ab42bb5..8fc4918c6f3f 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
>   struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
>   extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain_cpu(int cpu);
> +
> +extern u64 dl_generation;
> +extern bool dl_bw_visited(int cpu, u64 gen);
>   
>   #endif /* CONFIG_SMP */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973..52243dcc61ab 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -958,6 +958,8 @@ static void dl_rebuild_rd_accounting(void)
>   {
>   	struct cpuset *cs = NULL;
>   	struct cgroup_subsys_state *pos_css;
> +	int cpu;
> +	u64 gen = ++dl_generation;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	lockdep_assert_cpus_held();
> @@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
>   
>   	rcu_read_lock();
>   
> -	/*
> -	 * Clear default root domain DL accounting, it will be computed again
> -	 * if a task belongs to it.
> -	 */
> -	dl_clear_root_domain(&def_root_domain);
> +	for_each_possible_cpu(cpu) {
> +		if (dl_bw_visited(cpu, gen))
> +			continue;
> +		
> +		dl_clear_root_domain_cpu(cpu);
> +	}
>   
>   	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>   
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8f7420e0c9d6..a6723ed84e68 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	}
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 gen)
> +bool dl_bw_visited(int cpu, u64 gen)
>   {
>   	struct root_domain *rd = cpu_rq(cpu)->rd;
>   
> @@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	return SCHED_CAPACITY_SCALE;
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 gen)
> +bool dl_bw_visited(int cpu, u64 gen)
>   {
>   	return false;
>   }
> @@ -3037,6 +3037,11 @@ void dl_clear_root_domain(struct root_domain *rd)
>   	}
>   }
>   
> +void dl_clear_root_domain_cpu(int cpu) {
> +	printk_deferred("%s: cpu=%d\n", __func__, cpu);
> +	dl_clear_root_domain(cpu_rq(cpu)->rd);
> +}
> +
>   #endif /* CONFIG_SMP */
>   
>   static void switched_from_dl(struct rq *rq, struct task_struct *p)
> @@ -3216,7 +3221,7 @@ DEFINE_SCHED_CLASS(dl) = {
>   };
>   
>   /* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
> -static u64 dl_generation;
> +u64 dl_generation;
>   
>   int sched_dl_global_validate(void)
>   {
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c6a140d8d851..9892e6fa3e57 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2814,5 +2814,6 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   {
>   	mutex_lock(&sched_domains_mutex);
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> +	dl_rebuild_rd_accounting();
>   	mutex_unlock(&sched_domains_mutex);
>   }
> 


Latest branch is not building for me ...

   CC      kernel/time/hrtimer.o
In file included from kernel/sched/build_utility.c:88:
kernel/sched/topology.c: In function ‘partition_sched_domains’:
kernel/sched/topology.c:2817:9: error: implicit declaration of function ‘dl_rebuild_rd_accounting’ [-Werror=implicit-function-declaration]
  2817 |         dl_rebuild_rd_accounting();
       |         ^~~~~~~~~~~~~~~~~~~~~~~~


Looks like we are missing a prototype.

Jon

-- 
nvpublic


