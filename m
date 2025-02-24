Return-Path: <cgroups+bounces-6697-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C1A43106
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9BC167E24
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363820C000;
	Mon, 24 Feb 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrMtsNXj"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02A18E377;
	Mon, 24 Feb 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440362; cv=fail; b=Bg7I4ggflW9sidChWHkaAv9fPTClVMYSizt2Ux52OznXDYuBKpdWyOqIRAhyx8NNZICHeyaAhLqA9MZsfpoSPUTnIqHwirSVALpPTv9Lf5aMC+yMAMOtEV2mLx+VfEIBuf0UVXsHQdFF8eVP8j3/RRUsm0Z2dtbUSW06VGLmE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440362; c=relaxed/simple;
	bh=mvrkF2TNl2j4K4q7nc9VM54x7R4V5TwJ34nva3UBjbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uLFY8+i2si1PhrfuqaWylGGSLf3LtoosyEYKTQL3alnRiHJQKhGQWjLwR1yRqA7k7on7tnlgReC++rHjibt4+zzM0O/sWtm2Ro22BoDTjAc9nOmed17brTx2XKQwmpMsnqimlX82Vr22GT/XUi9VFX0rWMlxRnqbABFndtFdWXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrMtsNXj; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJHvlk9P6vcw3HDyGa863x4LAvj5FJXeHoen92IvqXt0+UlXnbpV2a4gZpxThMSw84gRmbYAnMgGOw9t5F80EDKTvWajEb7iQN3HhOIBpNzhTEmfFCrCtDzAT7xakjgIPQNinK5dULLMYUR9oUcJFIHg9V62PK33pUgtQZWssroDR28YsdMpFvABsLOFlL+pfYZynggu3q9Fh4q+saJAVR9ndBBF2cfZa5yuuzd+Ip/uRQjG1rWx97qag+7bGIyPEV0qTxL6nUUIHoax7NbrDZnLPJYN9pENsNijDfM7KAzkmEbvX93z230I8S9PZAf9wylWsrPsx6wA3vNNoXCm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky9ZzMc8MmVb6DylYaGCpMUOz6ZRVqWjY844501Pggo=;
 b=xtxgjnqj3E8p27PiKrjzHcxfBaBw1crggsAu1LgUd1JaYDYFpGzCR+Pzh40zzlcuE6on6U/3LjGHX4Ti9frN7bGayarfRzqLr/iogb9jzGbrMJIpB7gwaUPMTd9ePRvXFpWqyGbJpwVLwIQBW9ap+3zlDh2wob0DAxT+8TEsPcPw5QjcIH68VlrrEDzjnGGXunMZXRMnmXhR6J9O+QRPBsa8KRnfQuWaT5tJlwEpLYNQRaUlgMQx0a6tYjxA2UBTQMpDHdi53Ds60L4rGgPvYkEPycl25UfRa7ScM1KBTlQ8pzD9qjxcHeIhBOFBy2UF7sQeB+rJn3wDeotnwunAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky9ZzMc8MmVb6DylYaGCpMUOz6ZRVqWjY844501Pggo=;
 b=hrMtsNXj7LNkz+DSnnlfvr2W4rB7YdjJuM/onNdgxFq+q5BLBQou8Lh69hjE+wCI3hKqVuQpZ+yVNx3sp4N5dl5gWcSbC/fJNIous2+snNvG4+WeYnFEHhIxM3bWcibJdm14pJmivea6h/RPYVxeZcwbYtvxO2NciPiTr6rwmDFwORoPM9Z7YoipNirMhaBtqhq85XnjO+6mjPKSnS6HStyMPNwCmC8PxG+NYiCTcqtYzEgkwE0/tFUck1Nuj4Rv0n0zZOLVGzCuPB6p8Y1bOIAkjJbeq7xXlmb86PJoZybJaCX4zAGBpiAKLpCm4UQpoi0usMNAFImiZJI3RivNgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 23:39:13 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 23:39:12 +0000
Message-ID: <4aa1de5c-4817-4117-b944-4b4c8f09ac40@nvidia.com>
Date: Mon, 24 Feb 2025 23:39:03 +0000
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
References: <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
 <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
 <1c75682e-a720-4bd0-8bcc-5443b598457f@nvidia.com>
 <d5162d16-e9fd-408f-9bc5-68748e4b1f87@arm.com>
 <9db07657-0d87-43fc-a927-702ae7fd14c7@arm.com>
 <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z7x8Jnb4eMrnlOa8@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efd183f-7783-462d-c158-08dd552c7147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGNQM3hNYVZJbjByMC9UWG9KVWp6Rm9sbDRCUWFNRDVwTCtET2E5cU4vLy90?=
 =?utf-8?B?MVhxb3R1cTN6NWplMzJ6WmJ6NU9FL0JrRHJZQ1l0bW9WbUZMeEJ4L292emdw?=
 =?utf-8?B?MkYzTk5MbEUwVUY4M1lnc2JTMHZZU2NKK3llUDhaM21NNE5SQmdaYzQxWVJU?=
 =?utf-8?B?NkIyaWpRSTNtYnd5Q1Q4UFNZVDVrM3hoZlA4MXZ0Zkl6ditCdkFxODBiZFRD?=
 =?utf-8?B?YjdqVWo3LzBldkNRZE9yRFJ6ZVdUb0JvSlRFSktya0hjSGF3MlQxYXVxVUQ4?=
 =?utf-8?B?TkdQWmpJSEQ0d1p4Z2ttd3VpdllpRDNyeHhnNW85bVExNTV5SEVYaThzK0p2?=
 =?utf-8?B?Z2laVmdYZEJMeDkzUUtNUElBVmtYaVVmdVBMN0Fldkpmb1FGTWRZeTQ3RFJn?=
 =?utf-8?B?Uk9uYUZXd3Vjd0ZmY2VNN1ZrbEltNHpaZEFBOUhTRzVOMHFRUzRoaG0yV0Y5?=
 =?utf-8?B?Z3diSEl4K2puTUxkT05za3k1QnZyVWtzUW9UZ2tzTnlUaGY2Z01rdmJqdHht?=
 =?utf-8?B?Ky84VTVBMmJMbnVaUXYrVXlCa284aUJNMW9Xek5zL01LUUpYODZqUFJVVmdH?=
 =?utf-8?B?UktwZnJNUGVWenZHb29LMXdHM0piQTc5K0MzZHdkdnUvREhHdld1YVpOVElX?=
 =?utf-8?B?a0VUR3E0eitZK0lGckNOUmdnSkl6VjBjV0JUTVZ5SDVqc2JaZ2hSblhTQmRp?=
 =?utf-8?B?dEhkTDltSW84Qjl2WDJXTDJrM2ozNHRkNEcraENxS2VSZlRwWnhjOWhKemhT?=
 =?utf-8?B?bm8zMkw3VHk1MVM0T3ZvK1lJMkZaOFNKTzNtRUMwU2FlcXJzRVcvWXVWZVdq?=
 =?utf-8?B?dWovYmN6WHJwZVhPbGtRQ2MzR0R4TVlyYzNlZ3ROWE4wMHlHK2dDTUNDUElU?=
 =?utf-8?B?TVVVY2N3Qy9BYndJOHFNRHlYeHF1NHZRWCtYMWtJUUEvcVBRd3pBZm9saGlh?=
 =?utf-8?B?L3ZpL1dtRnYxU0tRTnpRdDMwS1RiYWZYRFVMZ21EenZHTU5xZDdvMVJacWdB?=
 =?utf-8?B?NjY1d2MrMDVBUzNwd0haNlkxenVWM3FRbnd5V2hDR0FYR0JYUkNWMDA1Vk1L?=
 =?utf-8?B?b1Juck93Rk9CTjF2bDFpd3J5U1p2SHFYWFVBc1BoakRNMlplM2Y4bEMwS2dq?=
 =?utf-8?B?NThhSiswWG1ZMkVlTTY1VUt0eDJSTXh0RmxYQlhOUll6Rm5OaDh5UjZ0T29H?=
 =?utf-8?B?eXVWQTlXaVRtcTJJVXo4eHpubDdla3VKV0dlSXNEVWxLQUFnclQzTlF2YUU0?=
 =?utf-8?B?dnZuRlBSalQ5Tnlxa1FheTRxNVhyeE9Ld2R3eWV1cVo4ZDRnY3oyd0h6aWx1?=
 =?utf-8?B?MGV3SHhoWFVzSVBxNlBabnVsZkFiNGozUU5BSlQ1L3RnVmhydUMyK1VNUXFp?=
 =?utf-8?B?MWhOUzZsNCtxL1ROTVRuTUU2U04rbkZ5SEZsQjFSRTAxVncxT2o4U25iem5X?=
 =?utf-8?B?RU5nTURyT3NqOTdlWHdlTUNrWE5IaGlpU2dzdzFMS29FQ3ZtRVJ2clJ6UjBt?=
 =?utf-8?B?ZWJKczhOZi80cEg0Y3lVRmNpSWhmQVVhenN1aHhoMFpzRWFpbWtQNjdVWWxv?=
 =?utf-8?B?eHZiTzJPMmpWOENkZTUxSDlnMUtCS2Jid0RtbVUzQS9ON2dFM3dEQmlyZjNa?=
 =?utf-8?B?a2lka0pGd2xIam1seThzbFVQVEcyMHB1bCtRaTdrbEkwbHE2dUFsM3Q5N1FB?=
 =?utf-8?B?WHJBNEtFYVRDcTI3MERvQVk3WlM3UE1UYmlsTUpld09hSTc1d29NTy9pVDE3?=
 =?utf-8?B?OTlnZHliQUJ4SFFmcjBtZ1pmR1R1L3hka1hWVE5IaHgxckkrbUl6dEM0TGlm?=
 =?utf-8?B?aEcyYWRsaGtkSUFmb1ExK2xQdjd2VzI1WVkxNHdwdjhWMTQ1VGRFSzFIcG5R?=
 =?utf-8?Q?UvhoargP5qU/4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWhuOEp4Nm40bVJRa2tCZ1BjbFUwOUs5VnFiRGJhSVFQMTFaZ2tqUjBGM2xw?=
 =?utf-8?B?clREaWl1bXpYZWI2ak5TTEpSRkUwWDJFOWdRY3NEZkJVaGZjck1lRk9NQTAz?=
 =?utf-8?B?Sy9UbjBWamNuMVpxMUxjc21wU25NN2o1RnBtTkxOa1ZxNTVxbWZnVTJUNDh5?=
 =?utf-8?B?dXlObnVOVEc0V2VBYmxoM2U5bVR1VmJWWlNzbStmNWR5Z1VWeEFQU1c2K3V5?=
 =?utf-8?B?clU1TXhjdld2T2pKZnFaOU1EdDdaTzJuTHQyRE8zNGxZMjJ1SExqQkJsVGFu?=
 =?utf-8?B?aUNpOWF2WG1uY09tNFR3bEhmSHNMeCtrd0F2eVJVRmZQRnc3YlB3LzBIcGJt?=
 =?utf-8?B?R00wUnpzR241ZFBWZkxjdG1qN0k1TTZGeXYvNVhURkJMbEFKazRzQmRGV0E2?=
 =?utf-8?B?aUtBMWwzMEpla2I1LytiUTB5SDVrTnE0UERQSWJRZ3g5Mlc0dW5ESUp3Nmpm?=
 =?utf-8?B?UjhXVEJ4V0Mva1hkNmkvQXB4RVVYNElTeGtFeWZWSlpod24vajJrWXlEWUpl?=
 =?utf-8?B?dWZMNk1FV1dsT0ZqNC91THhoZi9kQ2ltelNab0dLVStpU0k4VEUrdG83THhS?=
 =?utf-8?B?RTJYR1hzRUMxQUxabFBqY2RIdHQvK3lzVWtMSlhDYlhqMXorL0pHVG5obGpR?=
 =?utf-8?B?a2I4VUorMEJXK3hNbFkyNzBTWUtDTXNsZ2RyZE5rK1BLQlhDaVhDaTl3MmFk?=
 =?utf-8?B?S083VXdJczV6cnJjVjhOQ3VPWW1rWUxZSkpVdHFXWDBUdEFyMEl3Wkt5T2FB?=
 =?utf-8?B?aXJZdjdXbkJycnZ3WGlBb0p1YWtBQ2k1aHd2SlJmMDBXVkU2MEVrdWdJcFBr?=
 =?utf-8?B?bFNHN0F1eDlCdUxkTHp0cTN2NzcvcUljSVhWeVdHM3daTDFuY2ZzcjJXNCts?=
 =?utf-8?B?SVhBU1lyMXVQNmRQTVRHVmJuZ25MZEV6Z0RhcnZIUUVZb3J0cEJTKzc2Rmhw?=
 =?utf-8?B?dnppczJzaVJxVWErdjFtU0hzK2lmcjZPQlZuUldwbU9pMnVxc01aeXVUaWNj?=
 =?utf-8?B?L0s2WDZmc21mVXkwdDFhZlR5RWlndzlVTDJqQ1dOcnpjWW5QTHJLaWo0QUlQ?=
 =?utf-8?B?SlBNbStPOXJ5SmUwV3FkRzF5ZTh6dEdpV0tCbG83cnZuL0ZjakdXZnMwaDJI?=
 =?utf-8?B?V1VMMjFpS0FBR0F1emdtRVA2WE5ObVFvdFA0OVBjL1V3SnVYN1Y5ekxNZzZi?=
 =?utf-8?B?VUgzNU1ISG0wNDZQQy9YQ0pLOSt6TCsrQVhWMXdIYncrMUxhZzVlbXlsY1dt?=
 =?utf-8?B?Z00xQkluckVydGVONVFoaE92WUNGUTBXUk1KazhyT29BcDZVS1NiMW8waDlG?=
 =?utf-8?B?T0xmbTlhaHdBRGFQd1c1TTBFSUdYcXJYS0wxVDBJUUVWSTF3V2hWNEFpZzFw?=
 =?utf-8?B?WFdQMXcwNHFsS3ViVHk3S1k5QU54SEd4NXhsVTFRamk3RXFvakV2dFdrbjkv?=
 =?utf-8?B?ekZRdTlySXJTb05qWVdCQUsrd0dDMXNPRU9XTEwra3NoZzVlTkluTFhQWmtr?=
 =?utf-8?B?MEpJQWFyZ0dKV3JlcW5MZzhPY21DTFo4WnljMEVocTh6NkFFSlJtd2tDcHBB?=
 =?utf-8?B?OWJua3JqOUR1RGVHeGNBVFNzVjVWR3RMVzMyb1JreHlwdndFZEdjMUROb1ZU?=
 =?utf-8?B?Z0FQc296aHp1Z2VjUE9BRW5sWE15S1FseWgvTVUzd3p4SDZEZHNWR3l5dk9z?=
 =?utf-8?B?ZXlGM1JQVkZ3MkdNaGhlaytoWS92Y1JwUzlLZ2tQNkFnaDV1WURZblY3ajBo?=
 =?utf-8?B?RUdlUFpOcUtpc2xXNG9NUFJCbjZhais5VzU4dXM4WjErWGd2REFMZkVIVGlu?=
 =?utf-8?B?WWM4bFRQakp3UlpETmtuVmVpc0FlRHBiS1hBUFVNQjVKcFJOL0tJZDljSGd1?=
 =?utf-8?B?eWZSSXN4dEpGeFloZmc5TGRrQUF0N3dXMkNrS2N1Ukc3cURMYm8rVlp4N2FK?=
 =?utf-8?B?a3NuQmxVUHMzR1hkK2lxLzZhUGtoSWwvYWJkYjJLZ0ZrK1Rpa1Z4WHcrbVdW?=
 =?utf-8?B?bmNLNG1CNWJqdUpsUVNyNXFLQmN6eVJxdExxZGlrR3NUbS9oa3V0NlM0Q3k4?=
 =?utf-8?B?K0pLVDk5K2pZUkFCazB3NU4wR3lJb0FKMWZobXNiNnVkd01kMTNPbzVrZXJo?=
 =?utf-8?B?ditDV2xFdE5pcmNvMThRVjVsaVgvVlptV1Rqem5uM3o2SmIzcUZDbzk5RktZ?=
 =?utf-8?Q?S0qPsIHO2Op9fSlXbKss1YpXBQNx/elf9KD55s35lqdO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efd183f-7783-462d-c158-08dd552c7147
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 23:39:12.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o44BtRQ+aUrWVhN3zzxa+bxdWaVe+s7ZjWeEQLMaIv4CSKXBlYDW7TUEWlt53mKJjhG8rLEzCSk2LLi1y7Akzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349

Hi Juri,

On 24/02/2025 14:03, Juri Lelli wrote:
> On 24/02/25 14:53, Dietmar Eggemann wrote:
>> On 21/02/2025 15:45, Dietmar Eggemann wrote:
>>> On 21/02/2025 12:56, Jon Hunter wrote:
>>>>
>>>> On 20/02/2025 15:25, Juri Lelli wrote:
>>>>> On 20/02/25 11:40, Juri Lelli wrote:
>>>>>> On 19/02/25 19:14, Dietmar Eggemann wrote:
>>>
>>> [...]
>>>
>>>> Latest branch is not building for me ...
>>>>
>>>>    CC      kernel/time/hrtimer.o
>>>> In file included from kernel/sched/build_utility.c:88:
>>>> kernel/sched/topology.c: In function ‘partition_sched_domains’:
>>>> kernel/sched/topology.c:2817:9: error: implicit declaration of function
>>>> ‘dl_rebuild_rd_accounting’ [-Werror=implicit-function-declaration]
>>>>   2817 |         dl_rebuild_rd_accounting();
>>>>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> This should fix it for now:
>>>
>>> -->8--
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 52243dcc61ab..3484dda93a94 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -954,7 +954,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>>>          css_task_iter_end(&it);
>>>   }
>>>   
>>> -static void dl_rebuild_rd_accounting(void)
>>> +extern void dl_rebuild_rd_accounting(void);
>>> +
>>> +void dl_rebuild_rd_accounting(void)
>>>   {
>>>          struct cpuset *cs = NULL;
>>>          struct cgroup_subsys_state *pos_css;
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 9892e6fa3e57..60c9996ccf47 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -2806,6 +2806,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>>>          update_sched_domain_debugfs();
>>>   }
>>>   
>>> +extern void dl_rebuild_rd_accounting(void);
>>> +
>>>   /*
>>>    * Call with hotplug lock held
>>>    */
>>>
>>>
>>
>> Looks OK now for me.
>>
>> So DL accounting in partition_and_rebuild_sched_domains() and
>> partition_sched_domains()!
> 
> Yeah that's the gist of it. Wait for domains to be stable and recompute
> everything.
> 
> Thanks for testing. Let's see if Jon can also report good news.


Sorry for the delay. Yes this is working for me too! If you have an 
official patch to fix this, then I can give it a test on my side.

Thanks!
Jon

-- 
nvpublic


