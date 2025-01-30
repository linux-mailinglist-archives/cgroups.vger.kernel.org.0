Return-Path: <cgroups+bounces-6403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA0A23734
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 23:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E2C1887F41
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA11B4253;
	Thu, 30 Jan 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJGt9hXP"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220512E7E;
	Thu, 30 Jan 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276041; cv=fail; b=HFBUr9wTpbF5+sUNH3z3x/aEoP/hB/LuZrTZMP4ZH5DjJvNfebJeowijV7bMgGqMIcgm84YQwpe5y5O332IWDFghPiIQZWe0Ptm5T6MwCUEjveR1yG5CUgXsukBqM1de8Cm+UuanQjv4x9IPVA8RVenNHxeduHTwZHP8xvGn8PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276041; c=relaxed/simple;
	bh=2zoqSz6WRW+1BUrrO/f0KS1ftufWwebKrCeG7T4kzr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VLA1ucFKqYyGNZOUm1XzS06thiZtr+ruLodRTwEOpShD4P/9wQcJzEdIFdIcLIYo3HUHEPhqS1Au5AQEMiC8YUQv4XV1H5rqdInrNHtkhJhlOk7t0EKteOgfBYGHN45c9eV49GX3aJ9JH+h7jnp3yNNV/WTrE2k2heh3tOw5rHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJGt9hXP; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0AKbyEFwEQZmDF8mN4L+SILYXjTE33qXfocQpNcGBZDjwBa6PFxgha/KoZsaoycnwwo6F5/v6tGDMqWJtFoi7UVG5fhDa7iSW485ypbjczJXW7maeuWtxNTV8lBOdnWf/eMTxQNu3pzw6BnKmQfoRd10G9gcF7G7yKayZ08LapZxPX5odb6CrGukAtylaSkPweAJ4UtOE1FLlJ4mQvHEzwkh3HhcGvI3PS/Qvot77/kDHp/o2XcanbcZw+Xbykh12Wf6tZoq7dfGzC/9c4OAc4Zt+J8jId1gacSAyyTbIStfZ/WsaqZ9jhbN7helRslll+yMX8LoymVnjk1apkltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYZa23wvWqJSmArI4Lo6bfwUi6vv5EtBPxm8nKvjBeQ=;
 b=swrleOxguKE5BSvJFIS5LcJJA6Dbf5yQQ3BbCZInPHD7W5MjPsOPwXZWstXKUKEMiCfO4ETY8cvgDT5vQLL7riGCYAqVsvKwMqMeWwWNj4tAdYXLS+0aPIWqNKuCJqwz/l6oJlIAW7sLLJtpHCtBKKQs0mf/BCKXtHkkeSHx9Q8JZi/TAmntz+SKluAaamWJMnzir3uxYFpKzCABky52aOcTxHGIF3jJoebvnpi5RJLcHzwDbBLjfw8tpxG1yGAw92oHEjY73MJ7El0AWN/9vmxz5+Mfk51O86vnOS7V569kM3FIwkpPMfXJNliV/hi2MzfJ1lSqdyJl+jmXGBI2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYZa23wvWqJSmArI4Lo6bfwUi6vv5EtBPxm8nKvjBeQ=;
 b=aJGt9hXPkO7KWrkBX7GlvkGbEszGDPYQuWt1HnXkzJZB1k0dQaYMcEOjq3EU5NcEmLRsCiL+QrHRS4rr3aafbkeLlfve6S51K7oGKNIvewFtGfy4+a8orvC7eenTP1/y3hcdKUuTt2OH4ogbn+qibQqGSTEAQwu7IIT9lsA4cPa9vEdanHCYpxrFgOROJLGM+ksf7aF+/siUme25O2O3Ela0fYbuQpOr1ZMyj8opoyYLGdfpD96Fz3axrfizUSCjEloSXiqOLMiHE6SslEZM1gCxyQOn7UhubaS6PPl6maGj2NVG9sPhjf1Z4WiIM0tEKRnsS4OBtUI47ZKp9s2lcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 22:27:16 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 22:27:15 +0000
Message-ID: <3cb3e01f-e9d2-4a3f-878b-ba4501764a2f@nvidia.com>
Date: Fri, 31 Jan 2025 09:27:08 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
To: Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <llong@redhat.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Peter Hunt <pehunt@redhat.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5qLQ1o6cXbcvc0o@google.com>
 <366fd30f-033d-48d6-92b4-ac67c44d0d9b@redhat.com>
 <20250130163904.GB1283@cmpxchg.org>
 <baf1f9bf-4226-47f5-b795-c8862fd0554f@redhat.com>
 <20250130201945.GA13575@cmpxchg.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250130201945.GA13575@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 173b162b-b066-4428-8d5a-08dd417d4000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3h2VUxqSHhCL3RqV0U2eHA1dFRXbjI3VWtrbjNpTWN1bEJ6enlVN3Q1a1BL?=
 =?utf-8?B?aUtaTGRlbGNtTVkvUWpWYmc0Qm5JRDc5RWRtcVBIOWJscnVUK2RHNzkxeWUx?=
 =?utf-8?B?ZVV4Z2V2R292dlEvTFVWZzlteXlndEQxQW5QR2NMNlpZV3EyRlg1OVoxRXEy?=
 =?utf-8?B?TzMvTUVFS09yUmlpeitobVpIaStLeG9pWTRHcWIyVzV2dFB2YVo5S29LcGZH?=
 =?utf-8?B?TENPaGYydWkvS1ZCZWJ0Mi80Tk4xS2VmRDlCVHYyTklZdWZkSGx2UUxnb212?=
 =?utf-8?B?VXpxK2hRcm04cjFycnhycTZPcVJCM24wc3pRbW1lRUlEVTRYdkV5cXBTUUE1?=
 =?utf-8?B?SVM4MlFFUURIU3VNVWtzd0FjNGJrc1Z0RUdvTG1ENTVKTW1hQ2ZnU0xqWllB?=
 =?utf-8?B?N1VmQSsvRjkwVTh4N3loWk5ZcDZrR1QwOWI4K09TSGp3VnY4K3lDL3UzMk5Q?=
 =?utf-8?B?RzVGdmMvVm5Fa0VJMW5XOGxjdzJwUzNTQUU0UjBqM0tIakFMc1FxOTkzQ3NQ?=
 =?utf-8?B?SlBMN2IvTjh0cTZ5ZDdVSndLV1VuY2YrVi9meERCelFXdmZpdXdUandYeWcy?=
 =?utf-8?B?dGdzdGVCOUhLNkcyejdoOVBiSzVKa1B2ZDcvR3ZoQS9mZHhpMGh3dVlzSUNa?=
 =?utf-8?B?NEpFeHgvYk9rTDZKc3MvMFNpbWdURU1IeTZCUXFWdy9UUjNGOUJlN3ZCL2ls?=
 =?utf-8?B?L2t5MXZhZUI0M1BhSTBWYXFaTDNIMjhiM1ZwajVFOWErWmZSNjNnWTFGTm1r?=
 =?utf-8?B?bEZkSmU1T0U5N2FjbFVIRUVXUE1JR1RmS0pnL050dG9BQ2R4OWRSMXZDUkdr?=
 =?utf-8?B?UUR6aGNrQkZYZGp5VkszQ3BTd3VVOHlmOFdKaEpPNUZtWkZPMCtLYU9jMC9v?=
 =?utf-8?B?b29OMDdUSys5K1MvVUY2TWtGdFNTN055azBRT0RLKzg4aFlraTBDYlo1UG5U?=
 =?utf-8?B?WU1oRHZoNDlZRlZLcm41aU1mZEpaWnR4RFQ5N1NsSVc1RXowcnZqZ1IwVEdl?=
 =?utf-8?B?QWpkaUJoRmxzamlLWmhXQkQxT1FHL2xhUDIzMFN5NHVjNnd3NEdkR3BPRjhL?=
 =?utf-8?B?WGx6MDNhak42L0VnRHp4UExtQ1l1OFlJalZ1MnFxSzFqTnFrVDBlRmlCaVE0?=
 =?utf-8?B?ci81SUttdGkxVHRRQzlhMW5Vajk0TUtIaGtKWld4NkN6N0tUbVBudEhTWTE1?=
 =?utf-8?B?bDNNTWtxb3QvenJtZmlROG1WSU9RVk15S3o2YVlxQTd5SVUxZS8rVGxSODNP?=
 =?utf-8?B?c1FiWWlSQjhDdlJiZ280TVdsL2V6Qmc2QnpmZVpHbC9uZ09rMCt5dVJSQkJv?=
 =?utf-8?B?eEYrQkx4bldZQzhNYStUVkVSSHU4aktTVThlQzNLaURDb1FFNjNCcGFTUnBz?=
 =?utf-8?B?azZtdEI2cHlTekhHKzM0L0EwK1NaaS9EQ2N0TXR6OXpYR0tHbmhiK1hwTHJL?=
 =?utf-8?B?cGMvWWhUMm1DTnBCNHJzWUZROWN6Zm4wRTVFYm41UE13dVordk5WUitUcG5G?=
 =?utf-8?B?R1BFS0pZTmgvRkkyMDZ2YVU3eHl1eVd3bWJKMHZjSGRINjk3c25Xc3JEaTcr?=
 =?utf-8?B?NmlPM0dEd0ltUHFUakhFU3gwRHhKQjJqcmNBR2MvbXgzWkdGNDNVRW9ZUG9G?=
 =?utf-8?B?OFRPOHZIcTJ4WUNpaUd5MTNPRzhEbjJJZUxydnN6SmZZR3BaNGphaVJXNzFN?=
 =?utf-8?B?M3habnNJdEdKUVZXM0xSM0hBTHgvYWs2TVkySy81dW9JT2RMU1pWYlFzaU9O?=
 =?utf-8?B?WmFuMngvN2lXZ0tUa0pvWnJhOHlPYWJxTXNmVDZhZjA2ZGZsdTlwQzJ2b0JX?=
 =?utf-8?B?ZUl1dE9DbGhlc3hSU3FGN2xOUXE0UGI5eGR3TVlrUGU2MVBKbVBHa1Z2MjA4?=
 =?utf-8?Q?uxjv4zGInmBnS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2c5NXNuZmw0NUkyWWlDWTVjc3VEclV1c1lkVytNWW5qc3BGNk1yaFdzYnBm?=
 =?utf-8?B?Rm0xOGh6ZHppY3BWZW90QStzMGhzUWZWc3UxRzFMN0poaE1LMEpySmplWEhT?=
 =?utf-8?B?TTFobDdONGdNOU05RlpPRC9GVHhQamU5ZkNsdVBIaXVId2VUL1h5L3RmbXdD?=
 =?utf-8?B?SEhFaXRjUmNHcDllUC9iV3IzMVpmWmxWSHRRaS9UaTVwKzdaU2hZeG9iWklN?=
 =?utf-8?B?QmE1cUJRNWs2dUhCRXVoN2NMV1haTHhJYUxlajB1YU1KcE5LV0R3L3VDWUVu?=
 =?utf-8?B?VVR4SGJUM3FYQTRjWXpCL3BFZFBkOHpuYzVhY1VZaWNacXlIWGd2Y1BOTXl5?=
 =?utf-8?B?U3FZSnZpQTkreVZtY2VyYU1na1piV0dSelNSR3ZhMitZZmxqSXo2T1VyU2U2?=
 =?utf-8?B?SXVvSHNIbWdmNFVSb3dvNmszWExSYzF2QWNwYjFZY1RianM1Wm9ZWTdnT2dR?=
 =?utf-8?B?YXhENEg5RGVLWTM3V0g3MGQyNWkwckFTbXkxSjVYQ2pKd216T3NZaVEyVXd5?=
 =?utf-8?B?Ly80Sk41bjlBYTJhbGJ1VXU5THptUnFlZisrYVBwOXV0Y2ZaUEpRRTBBVVBs?=
 =?utf-8?B?NDN5YWxOSVFVMHVmaXREdm5XbHR4bDcrME5PelBFSWcycE9sdDF5N0E4dDNV?=
 =?utf-8?B?SFREQ3JqclBHSjJGYm9ZeWFSUDB4dlJxVUR0TDIrZ1FGaUkwSEtnbFh0T3g0?=
 =?utf-8?B?RDA2bjY3b2x5cUZXUUw5R3VubVlrZGhKelFHbk1hcEt4elpSVmlNMGI5RGE5?=
 =?utf-8?B?TWNYTDZ5ZUkxckd1QWtWMEJTRWNNanI3Wk9mSlUxZVlxT2VIaTFYbmZmeGdj?=
 =?utf-8?B?cWFDbjVBTG93SHNHc0VGQkx1T1VHV2ZrdDRjRXA4eXNhcDdlSUQ2cUdxUnFN?=
 =?utf-8?B?SHBmdG9Bb2VIQmNoMW15KzhZQU41WnNBdXZ2d2NtbHZxcElZaDMyQ2orYUh3?=
 =?utf-8?B?d2wwdW4ydk10YWFRamlYbGxZbEt3dkxDRnk1U3NwRm5vNHk1OUg0eTk4amtU?=
 =?utf-8?B?b1NmKytFay9MTnF3T2o3K24xeTZCRlB5MnBwVXU4TXZzcXlVNjROcUx6emFq?=
 =?utf-8?B?QXljak9YbUI3Z29DSEc4TzlqeVdreG1QMGVLY0dNa1BwOUhqRHJGaWdXam8z?=
 =?utf-8?B?ZEdJamFXdkVFTUFCYlpEWWpvQTJONklWclpud0VSWko1K2laNk9TQjZVVmRY?=
 =?utf-8?B?UzJwb05mWk5HQlpiVkJYRXNyamJQZVBoTENQZkhMK2wvWkZlZ3hzTlk2Zmx6?=
 =?utf-8?B?TW04VFZmTWhzMnVxMUhUNFJLRVBPcGhDTGpSb3laelorYS8yU3hsUXFmMHhW?=
 =?utf-8?B?R2hPc1ZSS0JLK21FbTFDQ0s2dEozRXRCckM4bmp5U3VWZ2c2dmtGYnpnbkVs?=
 =?utf-8?B?WDlEVjB1Uy85eUVCQVN6b3g3TU1wa0w0OC82Q3R5SGFHNDBmU0U2SGxsa0NM?=
 =?utf-8?B?cU1rZTFPUHR4dVRsWlJualk3ei8wMmtoQkZnZ3hzRE9YOURjTDdMZzVXTFNx?=
 =?utf-8?B?RFFVbUJnM3ZuK0dUYjd3SDNteFZ1akJKL2lmbXZwZjRkT0FGaVg0QmFheW9B?=
 =?utf-8?B?UGJXZG5IeFhLb205QUNiMXE1R1ZyVS9RSnd2S2JnSk5jdDRIYkhKTG4zUDR3?=
 =?utf-8?B?dGtnVlFyV2V1cG5XeFZGeGhjZjFtenRKQVFtTVpYUmQ3dFVMaVFIckdTbm5v?=
 =?utf-8?B?Z2EydS9ZcUhXMlR1bEQ3b2toazV6c3hZcHFOMk5lLzcvUlJNWGViSGRUWk0x?=
 =?utf-8?B?SnQ1SnNlZUlnc1BJODUxMDVyNnJCaXNOQm51L3lVZFlOR24rY2c0YWpvVXY1?=
 =?utf-8?B?QlEvZlByMXlwdjZEVU0wMTlrVndrQ0k2dGVUbTNyOXVwV0lyK2c0d2FWSXhi?=
 =?utf-8?B?VkFPWTRST1RJYnpPaU91L0JWTndOa040UURHUE1Tdzl4MVAvVVFaVk92K3dk?=
 =?utf-8?B?YzBHeUtYQ0JjWi91V1kyc2JiYVNmelJjWnRYSUFmQnpEOW5FN1lzV2ZTVjly?=
 =?utf-8?B?ZWxaM2V5eU9kR3JkdWpPa1VvaWlDNmtiSjlPbU5FSVFkeXF5eTdEY3BCSThH?=
 =?utf-8?B?QldPbTlHZlBZaXIvUzhkS1BzVDR6RVFlWTZpME4zcE9WcE5ZWG9kUk9nbWs5?=
 =?utf-8?Q?nYPHpiMLukGuSl9IopGzntiX0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173b162b-b066-4428-8d5a-08dd417d4000
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 22:27:15.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWqMLlkQn0hgCbsz1TFTgJdorog+39dd/KoSk9lUQBnqQ+JTQhAm4ZcinwwFV7FYCdDwx0W7cNGaQM7w+QrsFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

On 1/31/25 07:19, Johannes Weiner wrote:
> On Thu, Jan 30, 2025 at 12:07:31PM -0500, Waiman Long wrote:
>> On 1/30/25 11:39 AM, Johannes Weiner wrote:
>>> On Thu, Jan 30, 2025 at 09:52:29AM -0500, Waiman Long wrote:
>>>> On 1/29/25 3:10 PM, Yosry Ahmed wrote:
>>>>> On Wed, Jan 29, 2025 at 02:12:04PM -0500, Waiman Long wrote:
>>>>>> Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
>>>>>> reclaim over memory.high"), the amount of allocator throttling had
>>>>>> increased substantially. As a result, it could be difficult for a
>>>>>> misbehaving application that consumes increasing amount of memory from
>>>>>> being OOM-killed if memory.high is set. Instead, the application may
>>>>>> just be crawling along holding close to the allowed memory.high memory
>>>>>> for the current memory cgroup for a very long time especially those
>>>>>> that do a lot of memcg charging and uncharging operations.
>>>>>>
>>>>>> This behavior makes the upstream Kubernetes community hesitate to
>>>>>> use memory.high. Instead, they use only memory.max for memory control
>>>>>> similar to what is being done for cgroup v1 [1].
>>>>>>
>>>>>> To allow better control of the amount of throttling and hence the
>>>>>> speed that a misbehving task can be OOM killed, a new single-value
>>>>>> memory.high.throttle control file is now added. The allowable range
>>>>>> is 0-32.  By default, it has a value of 0 which means maximum throttling
>>>>>> like before. Any non-zero positive value represents the corresponding
>>>>>> power of 2 reduction of throttling and makes OOM kills easier to happen.
>>>>>>
>>>>>> System administrators can now use this parameter to determine how easy
>>>>>> they want OOM kills to happen for applications that tend to consume
>>>>>> a lot of memory without the need to run a special userspace memory
>>>>>> management tool to monitor memory consumption when memory.high is set.
>>>>>>
>>>>>> Below are the test results of a simple program showing how different
>>>>>> values of memory.high.throttle can affect its run time (in secs) until
>>>>>> it gets OOM killed. This test program allocates pages from kernel
>>>>>> continuously. There are some run-to-run variations and the results
>>>>>> are just one possible set of samples.
>>>>>>
>>>>>>     # systemd-run -p MemoryHigh=10M -p MemoryMax=20M -p MemorySwapMax=10M \
>>>>>> 	--wait -t timeout 300 /tmp/mmap-oom
>>>>>>
>>>>>>     memory.high.throttle	service runtime
>>>>>>     --------------------	---------------
>>>>>>               0		    120.521
>>>>>>               1		    103.376
>>>>>>               2		     85.881
>>>>>>               3		     69.698
>>>>>>               4		     42.668
>>>>>>               5		     45.782
>>>>>>               6		     22.179
>>>>>>               7		      9.909
>>>>>>               8		      5.347
>>>>>>               9		      3.100
>>>>>>              10		      1.757
>>>>>>              11		      1.084
>>>>>>              12		      0.919
>>>>>>              13		      0.650
>>>>>>              14		      0.650
>>>>>>              15		      0.655
>>>>>>
>>>>>> [1] https://docs.google.com/document/d/1mY0MTT34P-Eyv5G1t_Pqs4OWyIH-cg9caRKWmqYlSbI/edit?tab=t.0
>>>>>>
>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>> ---
>>>>>>    Documentation/admin-guide/cgroup-v2.rst | 16 ++++++++--
>>>>>>    include/linux/memcontrol.h              |  2 ++
>>>>>>    mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
>>>>>>    3 files changed, 57 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>>>>> index cb1b4e759b7e..df9410ad8b3b 100644
>>>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>>>> @@ -1291,8 +1291,20 @@ PAGE_SIZE multiple when read back.
>>>>>>    	Going over the high limit never invokes the OOM killer and
>>>>>>    	under extreme conditions the limit may be breached. The high
>>>>>>    	limit should be used in scenarios where an external process
>>>>>> -	monitors the limited cgroup to alleviate heavy reclaim
>>>>>> -	pressure.
>>>>>> +	monitors the limited cgroup to alleviate heavy reclaim pressure
>>>>>> +	unless a high enough value is set in "memory.high.throttle".
>>>>>> +
>>>>>> +  memory.high.throttle
>>>>>> +	A read-write single value file which exists on non-root
>>>>>> +	cgroups.  The default is 0.
>>>>>> +
>>>>>> +	Memory usage throttle control.	This value controls the amount
>>>>>> +	of throttling that will be applied when memory consumption
>>>>>> +	exceeds the "memory.high" limit.  The larger the value is,
>>>>>> +	the smaller the amount of throttling will be and the easier an
>>>>>> +	offending application may get OOM killed.
>>>>> memory.high is supposed to never invoke the OOM killer (see above). It's
>>>>> unclear to me if you are referring to OOM kills from the kernel or
>>>>> userspace in the commit message. If the latter, I think it shouldn't be
>>>>> in kernel docs.
>>>> I am sorry for not being clear. What I meant is that if an application
>>>> is consuming more memory than what can be recovered by memory reclaim,
>>>> it will reach memory.max faster, if set, and get OOM killed. Will
>>>> clarify that in the next version.
>>> You're not really supposed to use max and high in conjunction. One is
>>> for kernel OOM killing, the other for userspace OOM killing. That's tho
>>> what the documentation that you edited is trying to explain.
>>>
>>> What's the usecase you have in mind?
>>
>> That is new to me that high and max are not supposed to be used 
>> together. One problem with v1 is that by the time the limit is reached 
>> and memory reclaim is not able to recover enough memory in time, the 
>> task will be OOM killed. I always thought that by setting high to a bit 
>> below max, say 90%, early memory reclaim will reduce the chance of OOM 
>> kills. There are certainly others that think like that.
> 
> I can't fault you or them for this, because this was the original plan
> for these knobs. However, this didn't end up working in practice.
> 
> If you have a non-throttling, non-killing limit, then reclaim will
> either work and keep the workload to that limit; or it won't work, and
> the workload escapes to the hard limit and gets killed.
> 
> You'll notice you get the same behavior with just memory.max set by
> itself - either reclaim can keep up, or OOM is triggered.

Yep that was intentional, it was best effort.

> 
>> So the use case here is to reduce the chance of OOM kills without 
>> letting really mishaving tasks from holding up useful memory for too long.
> 
> That brings us to the idea of a medium amount of throttling.
> 
> The premise would be that, by throttling *to a certain degree*, you
> can slow the workload down just enough to tide over the pressure peak
> and avert the OOM kill.
> 
> This assumes that some tasks inside the cgroup can independently make
> forward progress and release memory, while allocating tasks inside the
> group are already throttled.
> 
> [ Keep in mind, it's a cgroup-internal limit, so no memory freeing
>   outside of the group can alleviate the situation. Progress must
>   happen from within the cgroup. ]
> 
> But this sort of parallelism in a pressured cgroup is unlikely in
> practice. By the time reclaim fails, usually *every task* in the
> cgroup ends up having to allocate. Because they lose executables to
> cache reclaim, or heap memory to swap etc, and then page fault.
> 
> We found that more often than not, it just deteriorates into a single
> sequence of events. Slowing it down just drags out the inevitable.
> 
> As a result we eventually moved away from the idea of gradual
> throttling. The last remnants of this idea finally disappeared from
> the docs last year (commit 5647e53f7856bb39dae781fe26aa65a699e2fc9f).
> 
> memory.high now effectively puts the cgroup to sleep when reclaim
> fails (similar to oom killer disabling in v1, but without the caveats
> of that implementation). This is useful to let userspace implement
> custom OOM killing policies.
> 

I've found using memory.high as limiting the way you've defined (using a benchmark
like STREAM, the benchmark did not finish and was stalled for several hours when
it was short of a few GB's of memory) and I did not have a background user space process
to do a user space kill. In my case, reclaim was able to reclaim a little bit, so some
forward progress was made and nr_retries limit was never hit (IIRC).

Effectively in v1 soft_limit was supposed to be best effort pushing back and OOM kill
could find a task to kill globally (initial design) if there was global memory pressure.

For this discussion adding memory.high.throttle seems like it's bridging the transition
from memory.high to memory.max/OOM without external intervention. I do feel that not
killing the task, just locks the task in the memcg forever (at-least in my case) and
it sounds like using memory.high requires an external process monitor to kill the task
if it does not make progress.

Warm Regards,
Balbir Singh



