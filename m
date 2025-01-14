Return-Path: <cgroups+bounces-6129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD398A1082F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BAC188932E
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648835943;
	Tue, 14 Jan 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFUdHH8C"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584117557;
	Tue, 14 Jan 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862789; cv=fail; b=JA23IHZUXQ6Vi+1i8u58ylWiV88bEa5wzGGQ2ZG9M1M+m35tUh/nID16xvPztKhXid8G/I4GxRNuk0jpLI2QVVERlUP2KxfbVcd/rzWw9pMp+h4pKc/fF9RG/lROC5BAz4udTpImvX6ABkZ79rTsBow8zUTHbUeCaI+0pb1dyBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862789; c=relaxed/simple;
	bh=tC4h3XjU+OJXnP1cC2Vw5r5xQdfLXPYc6uVhK5E2OEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P3Rx9nZ97rSYsuC3p4GWCPBTZC5j4ggaeOwjNvumAhvz0UPvFrCZm5wi9zOpCOdFTpIsoNvcwt3rridW1PlvCBRnQznEvU2xdr+7JDqLEFZQVj8TMkfVMupfDlBxwTKsyBF3YZeG7dMtqweHEPH+O1hwjdeXzYDOWYwtxSsqEVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFUdHH8C; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcgJb6mRtnGD+56gCp3+90Zj1KmolI6vlg8iNDVLMRvw4mpy6Qv/zB1Y5ALOp1QTpvi+BbPzXxS6i1zs9i4/up9gIwoxg1bMhtv/8KbeevzvMmrGl866Cc8aJGvBgID4JkvU4Yk5cW6iksHvaVSUwAzncH7I0YwfOEjFUvee17XUnU5R78iuH7fDLUJ/Dm23zAsRH9Z+u+Rlkbco4ozbqmRB72/Oqes0oFZ6P4PBaXbLbXQZV/5UFePP7FmVCWYAEp0kSC6BP+Ptgob+gt2g8V8UK+8azloCRaE+Vg33gq3PY1XndXvCP4Bf1steiZB5lwUsdFk3pkQVZBrLH9wSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gdUXMA2Ic4VMFkGoeUbWhRu+bqpPuv8st3ktuRt71s=;
 b=hVyIi0xl2FDJmw4NAWHn6abnVIgHIyTdO4CLwTHOkpFnax8fjB2RkBREqMebLtjH/HrvcGiO2ryNTfOv0VcVUBTZcqpQSgr8V1bENNcR7gxEjiIPOHqHHFHSIQzBg9cKTVi6wIHbuO4UPzyf9XQN1cADddApwMpYC32L7dC4oMQKbX004qCVI7ZisM1Ni2QhlnBZmcd92kvZpdrQiqKyIfyO7bH+h43unnQzResZc/heBz5ZsQhGM3sgynTZOJeHLW8z9f4kA/QOGGCoLu6AEFSKoc4xYMkidGhRnpvhT8dzDAVRdAscojzBo+qSERGa6ap5yjZL1H7YchuClqE1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gdUXMA2Ic4VMFkGoeUbWhRu+bqpPuv8st3ktuRt71s=;
 b=QFUdHH8CIs/jjZQ6G+iEEuOzWq3UBd6xnZ+yQqFXl6bW95GzWrtW3sW/z7+Gvf2aNzR7xP2pRSw+RXdWE0wzpMjil3lolDVuA4I4MnIB8AqA4T52FvPlQyY+Y6IPzHkGUcLqIda27ynN9QV8e3CJuw1JiBmZjcINqGE0UEBP2BW2+J/mbnM9unVGFtzYwRPe4/3Tkgx9RuGBKNUK5k30DBbCmcOsvW8w+uPMYPSc1ZnKsMcZjwshR2KSAdta9OwN+nymhILa+Km+y5y6UPDxYWuUeTi6cLZpA42c7G2bpzlkRRDi3FeXfMMsuIBhaRHhTzOJPxiab1wRDboGMafpUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 13:53:06 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 13:53:05 +0000
Message-ID: <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
Date: Tue, 14 Jan 2025 13:52:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Thierry Reding <treding@nvidia.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0161.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::22) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 5144bb0b-f68f-44ec-ac2e-08dd34a2c4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ky9TVEgrb0pOa20yS3RMQXlwZUFRWGxXZ0Y3Z2E0OG1idW1nOXh2L2hKMTlv?=
 =?utf-8?B?MHcwREtsZCtxcm14K1pGZHlsRkkrU2trK0RLSEcxNlhwSzdDS2dpci9MeEoy?=
 =?utf-8?B?OC9oS0ZlU2dCZU9SU25CY0EwMU1hWjVQR2pFd0wwRXZWd05HSndkcE9lOUdE?=
 =?utf-8?B?MFQxRE4xZXlrUlN6cnFQRVNHNnFTd2ZXV2JKUHJUSUFEV2E3NEUrUXh3VTVp?=
 =?utf-8?B?RjdpS1hPR0Qwa1ljSXV5WGt1a3NRdHlUdTY0UU9Dd3FSaExONHhwNklWSEtv?=
 =?utf-8?B?TVR2akZNUXFVVFlTaEdHNVBFbkcxUmZZbHZWUElHQ3RuSDFyLzFXQ3o5REpw?=
 =?utf-8?B?bExVdzBwSUdFK1BFR05JV3pNVmNYRnp2NU1vWkJEMVY3dWEva0w3aVVxWVZP?=
 =?utf-8?B?TGF6Rm5TV2VORFJzWGxOVHI1YS82VEJJWEFEN1NmRWFvby9WMUFCbnc5R3cr?=
 =?utf-8?B?TDlkQ2FZUGZzeURPSDJlMjhxUGxiTWMwTTBGQi9FRExrai8zK0JSaGk1WExP?=
 =?utf-8?B?aHdoZngyOEdMRUw0bVllVTZNV0NoVE90SnpxZnVnbkFPajlTb3JJcDBhTnc1?=
 =?utf-8?B?cmRUVFR3UUtrdWo1bC9OTTIwWUlFTGt4b3F5L0NXTVFGd1hJeXRERXVNMU5F?=
 =?utf-8?B?NnRjY3pZTER1NncxK2R1NThTTThjWXU0RWNhQXI0VVF4WmxSUEJQR3hkRnlN?=
 =?utf-8?B?R2VhMXlWZmVLMWhyS3ZieG5xWWVVeU54ZWdUYVNoaSs2YTJDc0I0MzdlZTBz?=
 =?utf-8?B?b0NLckw4a3c4YnJQSm1xR2NvQUhHRE43TkhZWWNad3FJVTUvQnBjR2VzY08w?=
 =?utf-8?B?ZUtXanlLQTF3MUZxWWF6OEtwVGNFSUJVMXM3c2xka0JZWHQ2K0xMdXNIQml4?=
 =?utf-8?B?Qms0V3UzbjJ1MUZ2d2k4N1dzb3krNVJjRUVSck5RUDZUWHZCUC9GTU5RaFRD?=
 =?utf-8?B?YWFhcEROSXhhSXA3TUlrbVRNNm1BOTI0RVluUyttcjdSUk91T21mL3I1cDJm?=
 =?utf-8?B?dGdITGFseXJhWlducWU0QUdYdVNqWWlFUVBGZGFoNnJoaHZOYWFnTmw2Vkwv?=
 =?utf-8?B?dFBoak0vbU9UQzRKUHhDK3JHVUN1emZXZXIwK1Q2NTF3MjhXVDI4dnhIN0Uv?=
 =?utf-8?B?Ri9pMFZmQVBNWG5vSkRua0lDdzExV0Q0ZHAxWVg2cWtnK0srbGJuaUtBVzd3?=
 =?utf-8?B?TmtJUS94UkJxRDZZKy9pWlVhSUIwcUdHVXFLb3FMR29LeDhTK3hvK3JjdHVT?=
 =?utf-8?B?TnBpNUxzZ2J3WmdnQ0hnQkgreHVWb2p4akFkQ3pQSkhndnFQcHkzSk16dkJt?=
 =?utf-8?B?OGpBN2lTUGZscmNQOENyNlVEMUI5TXB5UXE2MjdMT3lLLzZ5YStnYXBxNWVq?=
 =?utf-8?B?N1R2MWc2cVI4ZWNIcFVoTlg0bVdHZ1RBSGJvaGR6LzlHcVBLRmFYL1VqdDlH?=
 =?utf-8?B?d0J3M2h3bUdqNHI5L2FTaDBNOEY1ZWIybzJCZnNsb2szci9TTzBlUFlLNVdw?=
 =?utf-8?B?a1d5ZDhQUE9GQ3F2dUdvbXpNYzZpZmdSRWJwRmRlbEwrUE9QVyt1TVBNakNS?=
 =?utf-8?B?UDRQVnd2TkFwU3Jra1RkTFNhRWpDREcvWXlOaWlXbjN0WG05UVVUajhjbk5N?=
 =?utf-8?B?ek1uRFE0eFZOTVRYQ3BJdUlyK1RDbTZrUndpamhDdko2MzZ6UnAvR0RpWWph?=
 =?utf-8?B?NFAyUFZjRmxBUXRNLyt2MmcrMVFEUW5CZVVxcFJrMFFjT3JHd1BGTzZJQVMx?=
 =?utf-8?B?R0dzWVU4dDNRcHBJOTZqM2hMck5vN0ViQWRKMkNXR2orcGMrWkFKTmlQM1pl?=
 =?utf-8?B?S0xPU0ZvS2dwZnZNNWtXdzMzZllLVThyM1JWeEhaMG9QQTJXQmNtRFZBbnFG?=
 =?utf-8?Q?NvDTVv+8YsPRk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXY0NHVkVVZ5b3p6R2dac0NCeURSaFdNcmZMOXZxV1lXUnlCTm00M3BzYmpo?=
 =?utf-8?B?WGlkSi84OXBOb3EwVmFhdWRIN2l5MmJCUk0zV3dVeHB1bk9kdjZ2b2pYeG1Q?=
 =?utf-8?B?dzJRZTU5NjlVTDdmTitvaXhLUUFFQ3lQb0xYK1AzL3dzTkVpR09wOTJ1Vkp1?=
 =?utf-8?B?WW1LOW9wMEd4cHlGSmxKS1J4M0xoOElSTkZya0VSbHFBL1k5ME5EcDlRZGMz?=
 =?utf-8?B?a1Y5Sll1c21PU0VveUVFSTJ4TnlyMzFSRW5wMnFyTmQwQmo5NnEvdWlwV2Zi?=
 =?utf-8?B?RG1pQ0g3Z0hGWEF3WWlNbThuOHNLMmFmTThES25qU3o5NlMxMlRSYjQ4V3Ju?=
 =?utf-8?B?VFU2Z1RQa0FjQWpGOExQZ1Y0NldwWXRUUU1jbHBPb1d3aEFjMWd1aldGaHdQ?=
 =?utf-8?B?NVFvKzZNUS8vdnlKTEdQM0xBVVdIbGNSZkcvZVdUL1p5NzdiWDQ2VnR5QS9i?=
 =?utf-8?B?R2lFWnpTb1lPN3granpWbVpDOFgxS2FyaTVuZERvZmlraEZ6Z2pteC9MQmNi?=
 =?utf-8?B?N0lyekMxbVBsU2Y3WGZLMXRvVWplRXRFYTZLRXo0TVBneUxoMGJ5dVIwK2NR?=
 =?utf-8?B?YSsyQnNpY3FjQ012NWczYTh3ZGd3WURMNjJ6SWJrQ205NjBFbVlzVjZkS0di?=
 =?utf-8?B?aEFsNWczNG5zZmJZcU9qN1FyeTUvT1VoaDU5MjV2eDlCZ0RwZEpDeXM3RE9a?=
 =?utf-8?B?OVhXK1ZsLzl1WFd3c0ZsYWhPWjJESFlsaVRNREJVK1VVWmdtRDZNelJMMGRH?=
 =?utf-8?B?UkJlVTNiemE1a3Q0OVZDZkVkMlFGeWtYQVBOTHJtRkhjdW5IQ0U0MUNPWlRI?=
 =?utf-8?B?ckRSdHNWSTZzNUxiT2FpU00zZThUV2VYcGJVUUx4aEw0SVFPRW04RitiZHJ5?=
 =?utf-8?B?akw5UTlzZ2U1ajVGWEhkc2dITldlRWhaWnd3WEVjOG1wSmdJeVdsbTl0Wnp4?=
 =?utf-8?B?T0ZQcDhjclFxSWppWGlRMTRKcUZWWm95QVJUQ28yUFM1RmZzT2JUb3pEakti?=
 =?utf-8?B?L2Q3dW80T1VpZ1padFRjN0ZxVHR2QU1SaDdocmNURHI5Rm01VXRQZ1VGU3Z6?=
 =?utf-8?B?aFdQVTAvZWlKbEJTYlVLWFRleXJpdUFRUDJxNUJid0YzdVlIWW4zQ29SS01I?=
 =?utf-8?B?U2RDNkIvRE1laXE0RmJFN2tjSmxpZEk5K3JtaUNMeVlKaFdFR0J1aGx4cGRT?=
 =?utf-8?B?a2FUSHJEQm0ybit5amtQcWs3bGNzcEVUaEdJWU9mb25XVzhORVk3WGVaTGpQ?=
 =?utf-8?B?QzhYcFlaY0o4QjRjempHUUhlMXYzS0E1eTBhMlA2bExCQkpaQmExb1BNTVBw?=
 =?utf-8?B?VmpyVXJPTTQvblZ2aXU1MmdUZHdzYkRzc1pyVkp5NXRidGp6YkJQOWNsSWNF?=
 =?utf-8?B?bGJXVjBoMnlOblY4OWh4V29nb2tFcjA3T1NRV2JBNUZ2ajd1U2ZFWU9ISFNW?=
 =?utf-8?B?TlJrZ0pEMzZXTm9ST2cvSzhtUlJsRmlPZzI0a012OU5BMVRyanozQXAwcmsw?=
 =?utf-8?B?T2hKYmhNeE9TR3k1Q1YwbWtWbzNXcjFjRCtKWWgwR2k1L1RCUVlEOGVQTHdk?=
 =?utf-8?B?QkUyZnlBMlZ0aHFkVlNkNG9ZczB5Z3ROdytjVGJQK0JqbHVCOEZVVGtXNCtR?=
 =?utf-8?B?K3FaMThaZDByQllGU2dUNW91QVUxR0VHSGcrRWxYMWdzaVhqN3FyaGlYVk9r?=
 =?utf-8?B?SDVrdGFPVjJKWDNxaGJTcDYyYUtQMHN1TjhGQkpwdzNDS2YvQzZDY21MbVc4?=
 =?utf-8?B?Z1hZUUVoNHZpSy9WWjl0VzY0S2pESThkNjBaNXRtRFpGUTZNdmxOMGRPV3pp?=
 =?utf-8?B?WkNZd3V0VWVhS3BnVURyaTdqSzVmSTVQRFN1aG52dE9UMzhvR1EwWitCVUl5?=
 =?utf-8?B?MXBEM2J3THVJQTJUc2JjWFdLZ1Q0MnVDSG4vdWdOa2RTVG5tWVJMRGt1MHZ3?=
 =?utf-8?B?enRGWXdMUVE4aTNzYlhyeE1md1NhTFkrdEI0bmtabVZwU2E5NzZJYkFHMnly?=
 =?utf-8?B?SWw5bVgvY2x1VGZ3V0VGZytxQWc0RTJHcHdEVS9aalpWSTFPMUx4Nm5qZWxO?=
 =?utf-8?B?QWlYT1R5YVM0VDZsS05aR2JVVC9jR1IxdER3TTF0K1Q3WUxPbWFjZCs1MXUx?=
 =?utf-8?B?aXllZ08venNNck9lNmxMRXpLL1pXZG9xOUlUUDVkcy9EVHpFekVuK0YzS0hD?=
 =?utf-8?Q?eFWyzLekmC9OwxmS3e/mOk9n+Vcx9VePFmVX5t0zHHHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5144bb0b-f68f-44ec-ac2e-08dd34a2c4f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:53:05.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Akca4+UeJZhw1WA62yhH20ZUxBus8q3cg89NThqIgplcFkaJ/2TlVzFSHtdvjKE3ldaOGzfRQfzBpogAnVHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471


On 13/01/2025 09:32, Juri Lelli wrote:
> On 10/01/25 18:40, Jon Hunter wrote:
> 
> ...
> 
>> With the above I see the following ...
>>
>> [   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>> [   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
>> [   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> 
> So far so good.
> 
>> [   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
> 
> But, this above doesn't sound right.
> 
>> [   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
>> [   53.971068] Error taking CPU1 down: -16
>> [   53.974912] Non-boot CPUs are not disabled
> 
> What is the topology of your board?
> 
> Are you using any cpuset configuration for partitioning CPUs?


I just noticed that by default we do boot this board with 
'isolcpus=1-2'. I see that this is a deprecated cmdline argument now and 
I must admit I don't know the history of this for this specific board. 
It is quite old now.

Thierry, I am curious if you have this set for Tegra186 or not? Looks 
like our BSP (r35 based) sets this by default.

I did try removing this and that does appear to fix it.

Juri, let me know your thoughts.

Thanks!
Jon

-- 
nvpublic


