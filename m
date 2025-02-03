Return-Path: <cgroups+bounces-6413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D715EA257B8
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 12:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A371888AA4
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D26202C4C;
	Mon,  3 Feb 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smmN1g4s"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D0202C2E;
	Mon,  3 Feb 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580523; cv=fail; b=lgZrEBu27OrdPrOoidwie3whWr+iiVFGqKjDuH+sfnMJXDR7GYBOBIVDww72NfvM8rIcdUa1gpfoHNPi4gToXUMcBykYt+KfcmXOYIfEbO57fJPbdhS5FCKGwF06s6W0U/x50oLMjPAN2doi/9QXrNplUoz7JhvC7OV/yuD6+UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580523; c=relaxed/simple;
	bh=C40mKsw1NyOXav9anZJIMW3i8ieXsVbrZ8sDHFIyANs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjduNZNsY5IU3WQ3sFTFIDSfbWE8C50Ab0dLApgg+tT5UetaFYyVleHjCYkwqN9iHlp5hGdWeD3CmFXVbBIY6Oei8sNHyNA2Az4mDxDhFzsnC779JCvorlGTciLccNZuVrMe7bJ87lLPEe01bSQCdxdPGT0SXcwzXkfzZFaAsY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=smmN1g4s; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYQ13wP5Fj8myp45EYCIVy5d39QxNeqdfEAQw9kOiwedvxLT1mICPBFwGZaYqATumrw/D5NwmwZiFKtstiFFO/JW4GxQwXGj2V4tvtRt8oN4xxrcQXXNqWBemmb0dhULdCDHgrf8zBVcuyVYbrUTpYGVq6zS0GUKmSs6pvFENWljJHTcafiMOyb/Q6Zrpg8CMvERKeXICUutlEugAGDtHSUVBnp28eoUIyeMFpSvrV6DJU03qo46JToRiET45qrhfRKfGQ8pTx/LqWNtw9Jjt0ndT1mBUj4aH/Fb6/oq+6xXihvSP/insTbalmY9CCOjQQTNTpSms25RGkjVVbiiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZHQXduzEnkKHohpoFjxJqvQvp+EzR63p3AwqEplHqs=;
 b=kLOSpRLt9/VlIsDZ3Oboze+NI9INCYZ6TXM31qm5pWQSxhrHUbW5Ey4Dmq7lnK5BharB0pJ0VLzTqf2teHmzVahblFfq44eAxz/vhBP87bgAK7lo4OTPagfaS1wqTv009UBtSyxqfsNh2UEidqOIm5tp54qt6pqVLRl+ea/3bW1zlQ7qtfRzMAQ6LjeOoIJ/8LVwqTpUb394y8jjmxpy9iOXzpwyBTCdJ4ssdjMtAQx0Xqp7mx+CfUqvihpbBRoC1eGmMAo5PrvShyp1CfmNZ+Qg/C+Vg540WFkolksnTmblOHPuBF8/wYdWNCnJ5KOwpJVkjqKDgCSJREtFm/3nFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZHQXduzEnkKHohpoFjxJqvQvp+EzR63p3AwqEplHqs=;
 b=smmN1g4s5v6NrcawkY0cI9J2p9GNNdAMR0m2nFvaKbyuZc5FzrAGoR72lef3crEVM+h5YtVSX67EOsIgWEaJ7oATc/1zm7e0NayadWm0Ih+NpxFiNTzziCVCX6UpbJHW2pl2ggi57TBV9+a8e1+B4JyiZGdr1k/4W43rU7NIw5F0g2d0wtqZsXqVh5SyliYnPv7LHOu3qYwAlExnAq/Ie0fSwyaBYumVEcPfEFjdSLJpGP6ADHErYRySiYgr/BWOJcD9FRmyICW44idykm2teo3aSYd6laBACKy3oGHunG78U6tKgzTA1vI3CzZA7MxENnGrzTblgOPTq7bUzsy/eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 11:01:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 11:01:59 +0000
Message-ID: <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
Date: Mon, 3 Feb 2025 11:01:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
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
References: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ed216991-ad34-46fc-1bc2-08dd44422e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JvUmo0VEVPaWhXQk1JTW85aFlwVHJBZ0szUW1Hd25FTjhSNXBlUk8wYTVt?=
 =?utf-8?B?Q1BqMjFhaUJ4d1FESWxNVHNXNDkydWdhL1V0byt6ZytWVUVFL0FQTzlrSXVn?=
 =?utf-8?B?Z0NhdmR6ZG4rVVFCaU5XVmhZUHNpbTZNVXlmVkpQR3pyUlFhVThkbVJpKzA3?=
 =?utf-8?B?Y3VnQjhpSjA4MW9hMm5tdGQzWnFDeUFvd0xrVjUxa3RhZHlieGJhZFNDdjMw?=
 =?utf-8?B?aEdBYjZXVXRPU1FGRzlzcXA2amtiN1FJRFpHNUpGR3Y1SzBPTzIzazluRkd3?=
 =?utf-8?B?UkpSeXNBREJjeWtRVnpWWHlDSHpRMTVpb1U5bDhmVDRxbmlOZjdTQTdOOVU1?=
 =?utf-8?B?MVNYNUhvOVFKWnVOU05icEIvY0tEc3haN2FwUWt5OVlJSURDNFhJQitEb0Q4?=
 =?utf-8?B?SEdKOGQ0dWoyWHhyWHhmT0FhcWpGZkdCZ1dVTExTV3BHd1VxbHppeDQ3c0N1?=
 =?utf-8?B?eVBtTm9DeStHcU10M0Q2M3lsSXpiVGNwZ2pJUnQ5eUlvMWxZZnVQNjZsNHNX?=
 =?utf-8?B?TDhMaHBucnBTUVp0S0tSWXNEakZkZlZyMVp4VjAvcVNjWEprWE1pc2U2bnlT?=
 =?utf-8?B?bUwrRmtYK1JiV1ZoZE9nTHM1ZzczU2hXdnhyRlpTazVBek0waVJuM1FEaU1H?=
 =?utf-8?B?TkJPd0t0eXVnQmFBU2tRUzVJTVgzeTJBQnFTdTJ3ek1jdWtoajNodUtrWE55?=
 =?utf-8?B?eHZPWkdtS3N3YnZXV2VSZnk5bFRCVU8rVHRmbFFHUTZxcktkSW9oOGFKMWdD?=
 =?utf-8?B?TGlTdEZxSWhDM1hRRWJVY3p6NWNITzhFdkczRVlCQStGa0VaZEFMZU1qL09B?=
 =?utf-8?B?NGptT3U0aDY3M09zTDJreHExaWlRdnFlbS9ncnJrSWdNNXF4aDUxWGhxRC8r?=
 =?utf-8?B?QkdvVElDbjR1VkpWYlYrK0JXNmkwbUZDNnBPVEw2aHhWT0g0VDVoOVZ5MGFH?=
 =?utf-8?B?RG1YN1Vya2FTVHJXaDl4bW9mSmp3U3lYdGxhb3gvc3UxaHVrblhMZ1NRSFZj?=
 =?utf-8?B?UlJOcFYyTmc1M2VKY1pIa2VsdmtOTUdyS1BRWTZ0QzhGemplVUpTemFVTW5t?=
 =?utf-8?B?dDlKN2pUZ29oUk5XYk5hOTNNVTBTN29PRURzQkRqdG41d1VqY3VkSElGR0hW?=
 =?utf-8?B?RWpKU3JYZ250WWc4YjJGbEpnVHRGVzNLM1k0cWpYUEpXMzdsblhCU2tRMXI5?=
 =?utf-8?B?UVJyWmhOU21jdEdHa0REZ29Bc2IrTjdZVlU0d2FzV2dDNXE5OEpyVEpvb1B0?=
 =?utf-8?B?TzFMQkNNMng2TWt5aEE5V2kvSExnUHZVN1dvNTFiclhvWHVpeUwzVlV0eFg1?=
 =?utf-8?B?TEoxUS9FbmlTNmFhYjY1cWRlc040R0tJUnFtQnpabTRZbjdKV0FiOU01THVm?=
 =?utf-8?B?VGplRnpnQUhmTllRdkNpb3VmZTVXeWFQbDF4N0NhUVBCRVdxb3ZmdDJOekY4?=
 =?utf-8?B?MWZHaHllR0QrUzJGbDZLMEFHMm1iZjZzeW5MSFdFdEZkNnBFc2RlRG0zekZt?=
 =?utf-8?B?NkJEZGpud0xPK1RPU1A1djdteWRGRE1YbmFHZzlGR2xmTEJTQWo0VFM4K2ZQ?=
 =?utf-8?B?R0JTUkx4NW9QZ0QzbDM0Yzkxek0va21zWG5nbWtYQTFENWphbGhDcmNNbHh5?=
 =?utf-8?B?aHgyMmlVa0VpUlovODVkZ3B5MVV2bS9Qamx1MDVURTQ0aWFmc3BreWdvYzdv?=
 =?utf-8?B?OHVBU0FYSlQxN21DRTZHb2x6aGRuYVNpNm9UMHFnUTAyYkl0aHdnSW5hajZD?=
 =?utf-8?B?N0phWDhCZm9yWDlqR0FnYmZOMWwzYXhRckRrSStlOVVxaEZ1dTNFVWZIa1dK?=
 =?utf-8?B?MnRDZkRJdTQvSDFDQmRlcEJST2J6M1U1TUd5alcrOStZNXp2TG9VS3JqRWJR?=
 =?utf-8?Q?q2iv4C4xqVsfY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmdpaTBTU0J6KzFVSzVSWHdKNUFkaU44QzFHSFBBQjAyZ1pZdzZnelpZNFdw?=
 =?utf-8?B?NmIwRmlZcitVY0dQTG1JY3NqUHg2cWVUMjd1cHdCd29DcFNxRFVMWC8zeHZD?=
 =?utf-8?B?ZU1iQlJGY2h5R3VNd24wUGtvL0NhOGxiSUduM2pGZFpwbmd6SWNiZnhlRkFS?=
 =?utf-8?B?d2ZGb3ZlcjJMMFF2NUV3TkQ2bzV5QmpOV0NOTTV4ak9rZzJPNUo2L0NZSFhz?=
 =?utf-8?B?R1FzZnpXMUs3eit0Z3E4dFE3TUdsSitwd2VDcUMxOTdzR2w2M1R2L3NXUnFR?=
 =?utf-8?B?dHJhRnBqcC9XQTBPcUZCUlVIWVJnQ01Vay94cjcrWjB0UDFpMURIc3lSMTcz?=
 =?utf-8?B?WHB5NVV0OVJqUy8rODhvVDc3OHZyZDBPT0RMdlpZTWJ4ZlhhdzA5ZERuU1Iw?=
 =?utf-8?B?QVcvS01VQnZpRWt4b29oTGZBakZzNys0aFNyaWNqYW83NWx2WlU1SXY5aGJQ?=
 =?utf-8?B?ejhoVmxyZXp6aXVRS2MvUEZaTzQzbVVnUFFLYlR3cEpWaVJWNXUrOVRkbG51?=
 =?utf-8?B?cStVc1ZrSFhtbDVVRmFCYkxtVGgxVHFjdDB6bEJjUWY1aTlJbzZGRG1nSElH?=
 =?utf-8?B?TlNiY2g2ek42Qkt2cGMrL2xkVWRBeUlHM2l4NEc5YXRNR0lCQUlBM0xjeEdj?=
 =?utf-8?B?RG1vdzhITTI4aUlxNEM4THJNbG02bVMwTGRHVjJrV0l5YjRmU2FIdDBEMFlv?=
 =?utf-8?B?MjdncWhWTHRhWlEvS0E5V2ZyaTIzZFRDOXE0a2ZrMlNKSEloMkh3MmNBbVlX?=
 =?utf-8?B?WFNEYWtLcExPbTE0QmxoRlZzUDJiLzVlYTFJSElQNXdUZllQejdqN21NUTBy?=
 =?utf-8?B?dERFZ0pMVGRpV0YzS3RLSGdyRnRnSHNubDhBQjljd3dsNDkvZ3hNTVh3MDBw?=
 =?utf-8?B?T2hmb3p0eEQzekFJRWE0LzZROHhHYlhrdDdIaWI1M1lPMkFjcG5BU3FEOHEy?=
 =?utf-8?B?ZkpJSmpPZnd2ZWsyb2VFejFJNVkwZjllZjc2d0ZXdUR0U1NhZWd2MXUwSjV6?=
 =?utf-8?B?N2FMMEY4M2o4eTNRRk9rMjd5SnJHTjZuVkpsVWp6K2w2WlVkS25iQ3RYOWhx?=
 =?utf-8?B?bGZlUXh0MlVvejh2UExyZ25MTVo2eE9NZTBHR0RrYmxyaEdPMWp1NURWTFlk?=
 =?utf-8?B?L1hvMXF0M0ZwWHh4ZXFUdlo5Sk5wTVk0Z2lFNzFGQVk5M2xGQ2t6UjZEVnVj?=
 =?utf-8?B?aGN6WEVFL3VyQVEzS0hURmhqaTRLZkRhQk43MnpJc045Q2N4RUNBeDRNeW5q?=
 =?utf-8?B?QTlyYzVEbG9FcWVVZDIyUkthRmZSN3pQZmozTFN4WVBVUXNEZlRhaC8yWU5u?=
 =?utf-8?B?UlhSd0I5RktBYk5heG1ZTmJtUVpNTnUxcWJvcHFvSlZQSWVVUHlUZkdPR0Zj?=
 =?utf-8?B?MCtHOHJQMlMrOEZkR01uMzNYMWJGSEFZSjJWbFBKMWNOYzZUaEg3cWhnVXlR?=
 =?utf-8?B?cWNNc1lWS3R0aWptcXhOVlo2WDJyYkZKSUw3UDhrMlVRQmdZYWZvV1pVM1pI?=
 =?utf-8?B?UGYzN3JaL1hrTjFMUXQ1KzN3NldUSlM1MDF0akxxYjlsdnExTHIwY3dpYWJp?=
 =?utf-8?B?QTV2SkFpblY1VTE1bXJiNzFTR3VYZEVyNjFRRlNDZ2tMeGVnN3ZiVCtNZll2?=
 =?utf-8?B?WitnSWl0a3l5bGpRMlYvUzgrTnJlWGVsNWdjVVhYbnV5Vk1rcm8yYmQzS1lL?=
 =?utf-8?B?b1BuQWN3YzhMejJTeFN4ZnBaMGo4YWpqT1JiYlR1SmRCbHlyNXJ5d0ZOTzNE?=
 =?utf-8?B?T1N5eEM2TXBhbjFOTnFDMElVQ3RGZUQxWWtHQVorV3FCZkI4RlVSTlBnSFlO?=
 =?utf-8?B?dmdNc0Y5R21GTHBPaUtlY0UvQ2tKWXNZS1lKUkhDUE1KM0ZUVjdKWnZyaEUy?=
 =?utf-8?B?dXUvdytNRWl3Tml0aGd4SnRYejY0eEpiaE92b3VLT0NmdHJYODJZRlVMVDVW?=
 =?utf-8?B?RVB3ZlN4Y3VRTVhmeFJoSm1UKzB6dVNKUXlxdHoxM1czNVR5NGRqOXI2NkdC?=
 =?utf-8?B?SWFuMWJkdW1XK0pjZFdCWVhjWjhKYUZxU0lJRytvRjNyZkdBMzRicGRGV3dO?=
 =?utf-8?B?MEpXVXRRejYrSDN1OFRQT2Z5WW9lRy9IUWQvcFNHd3VvTWZuZDAvR2I1aWVK?=
 =?utf-8?B?cjM3K3owbUpKOWtvZUFmdGUzdjhieVN5TVROTjB0aXZFcGd0bitVVkJnbEdk?=
 =?utf-8?Q?TfZtqDdMvoFX6dwwWadkbBrbt+paFSWE6GBZxStpBns3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed216991-ad34-46fc-1bc2-08dd44422e6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 11:01:59.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IvLRkK+eERdcmK+h7WXCt97bqogbfbvm8sC68TNQju4BxBjzPMnHdWfMBO86wErFDa6sM6hf+6l92vNUnc4Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

Hi Juri,

On 16/01/2025 15:55, Juri Lelli wrote:
> On 16/01/25 13:14, Jon Hunter wrote:
>>
>> On 15/01/2025 16:10, Juri Lelli wrote:
>>> On 14/01/25 15:02, Juri Lelli wrote:
>>>> On 14/01/25 13:52, Jon Hunter wrote:
>>>>>
>>>>> On 13/01/2025 09:32, Juri Lelli wrote:
>>>>>> On 10/01/25 18:40, Jon Hunter wrote:
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>> With the above I see the following ...
>>>>>>>
>>>>>>> [   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>>>>>>> [   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
>>>>>>> [   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
>>>>>>
>>>>>> So far so good.
>>>>>>
>>>>>>> [   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
>>>>>>
>>>>>> But, this above doesn't sound right.
>>>>>>
>>>>>>> [   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
>>>>>>> [   53.971068] Error taking CPU1 down: -16
>>>>>>> [   53.974912] Non-boot CPUs are not disabled
>>>>>>
>>>>>> What is the topology of your board?
>>>>>>
>>>>>> Are you using any cpuset configuration for partitioning CPUs?
>>>>>
>>>>>
>>>>> I just noticed that by default we do boot this board with 'isolcpus=1-2'. I
>>>>> see that this is a deprecated cmdline argument now and I must admit I don't
>>>>> know the history of this for this specific board. It is quite old now.
>>>>>
>>>>> Thierry, I am curious if you have this set for Tegra186 or not? Looks like
>>>>> our BSP (r35 based) sets this by default.
>>>>>
>>>>> I did try removing this and that does appear to fix it.
>>>>
>>>> OK, good.
>>>>
>>>>> Juri, let me know your thoughts.
>>>>
>>>> Thanks for the additional info. I guess I could now try to repro using
>>>> isolcpus at boot on systems I have access to (to possibly understand
>>>> what the underlying problem is).
>>>
>>> I think the problem lies in the def_root_domain accounting of dl_servers
>>> (which isolated cpus remains attached to).
>>>
>>> Came up with the following, of which I'm not yet fully convinced, but
>>> could you please try it out on top of the debug patch and see how it
>>> does with the original failing setup using isolcpus?
>>
>>
>> Thanks I added the change, but suspend is still failing with this ...
> 
> Thanks!
> 
>> [  210.595431] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>> [  210.606269] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
>> [  210.617281] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
>> [  210.627205] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2
>> [  210.637752] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1
>                                                                            ^
> Different than before but still not what I expected. Looks like there
> are conditions/path I currently cannot replicate on my setup, so more
> thinking. Unfortunately I will be out traveling next week, so this
> might required a bit of time.


I see that this is now in the mainline and our board is still failing to 
suspend. Let me know if there is anything else you need me to test.

Thanks
Jon

-- 
nvpublic


