Return-Path: <cgroups+bounces-6106-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85461A0B8C8
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 14:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF201886AAD
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038D235C1F;
	Mon, 13 Jan 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tb6aRCvF"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612522AE42;
	Mon, 13 Jan 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776416; cv=fail; b=RvjJJOzqdYC3zRStnSSIZ7L5rj3cXYH6Jvhymu6MW/q5TwSErhlB0EKwM2GLDA0T8/2QctmF2DGlgAYKFaDKlV2Fea9T4YfN/L0xnj4ltaq9GMtrpixSyyGjY73I8+o9GFTNGuxGAdyC2/52VpOsUFHOVmCYjmrTvgRielWIdb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776416; c=relaxed/simple;
	bh=utpiAb1zfErlR32NwLxiqZJGK7ZXE61kk2jzSkHFgrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YozWhzEhzVNpkvXECuM1eJ6iQfNBw8ULa04KzVVXvc0bxCFMOedumOUUlFgqEWsRC4McmgRx8Pujr6pKSjq/Ec/wBbN+O4hCjNAas9hnvsTFE/90PsdgnBTy4cYPUgq9BjTsC1QwlgkaX0xZ/uDkSIEYKVgHqFZRCBWRlfJusKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tb6aRCvF; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luW0PYSvC5y43mxEGDEYqcZ2Ql/dsYPv4R4aFfKTO6fVLh72mSdMuMXgI03U9jlpzwcNjF5mO6eHaI/mKVkUyrUmiU6h4+Cpl5CQIDv/Xwggb6bgShT03n9RXa7+fS1g4aZYaV4SZWpb8ylEoqYnFBq6ozSn2v0Hr59PRK0rvkPZqziTHkF2FhmlUwKfEFuS8bshdWiKQWQC6Y+2Kk/4iq0ctxSTSFrg7pOv6LfkZxCld3Yoj287K3JwJtgmLTwkYhs1SYYiQ+oesUjvtpJWLGzevypGg7yC++WO3PgpSrFD1KujYnzoDtozHywwUlRlNzNKfwAaKLgdTRnu2wmaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE3FUaBVui3kA5mxVUVy64310OuWfnHHH05JsH6hcd8=;
 b=tw6J8ilZKaIHJ7inIdp/Y+OEvluaC23cAGXn//67qbhSEbAwOhRsMQkmFM2xBmdPlSxXF+gYURc6CB0Wp10obMazLHKxugscsmDPPRIBnXJKVasMf31xbilmr2r0mOhuox0M8to2qNRLYYzsY+D4GYZ5P4z4zHqICzTHkzGGdq3Og1IuBJkveOEMq5N8blr4Z6dJu3bSQ0S+DYXfUEzW/5pClnfNOoOGLsO9igO1FfkRUz11oVq1jYQdQFqf7jdl826g/uDtjFeKgSvW2nlOOH9Z2GaO/iPuBr0uEtqquxt4fs0wo88Q/24rS4r/4orvCITGwy86kEnJGHtQH4q1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE3FUaBVui3kA5mxVUVy64310OuWfnHHH05JsH6hcd8=;
 b=Tb6aRCvFA3Loh5NiMU8G5Cofq8Ztc0ttzPGBL87B1VBlj/YrrfCJGa7LrJgKaf4ZtpEDR3+fp6GA5xxFkhZvoyrgjrrmnnF918LGTgixPN0hTIkr9Ayp/3xfZGwXhC51KYvFnpy58geMhfaps8rs5zuo5Zhfqpxyy22HUePeGEstYDT+aYb/JPr4tunhphwuonyo7ktLjcfCuXPaBMFzdLY1L5QYTsCUOMkUbZHmOXuLCd0oS0wyycfhjwe9s3p/3w1V68p3GKrHZh2+Cd6ppsAX4jsb6gk3c4NDx2SFTmwrIVbxIzXxuFuFiK87jJM1xxzIhFNGzDjmXScWnJTioA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:53:30 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:53:29 +0000
Message-ID: <fc780143-2f2f-4b2d-9737-fb64bc8306b2@nvidia.com>
Date: Mon, 13 Jan 2025 13:53:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
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
X-ClientProxiedBy: LO4P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cc72e4-c8e4-4afb-9fd7-08dd33d9a8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFjZ1BoYlRrekY3b0c5NHp6d09wbmlwS0w3UVpxWDhsN3R0ZHNHZ3lRQitk?=
 =?utf-8?B?bTV3VlRzaVMyTzJQUWJuQ0N0RWI1NUhQaVJpVVM3N0g1Q0w2WUJ0UDh6Y1F4?=
 =?utf-8?B?eE5GK2lFZ2JHaC9lVXpINmFCakFIVi94elM4RlRaVzBxeVRpRjgvampJbUhR?=
 =?utf-8?B?bXducENQN2lwV0NBY2FVV2U1RDl2UjFuVU5haHhyTkErS0tUZmFiSEtFMUVW?=
 =?utf-8?B?cllXbWxmMGxDeElLRHRabTloeGs5Wm13SjZsYlNOMW1WdU9LMStsekhWZGhT?=
 =?utf-8?B?WFcza1lhdWwvMTJra0duNGtXMGswZWxVQ2lPaVcyU3lySjF0N2NKbHRKV0Ew?=
 =?utf-8?B?MzVJZFgxSW1ndWF3SWRoaEhFaVBBZGhpNlJFVmZpNU1DWWliMkd6ZTVWMmdu?=
 =?utf-8?B?ZmNtTTQ2WHdxTFVRUktybGpBOUIwWDdJbmVQYUpXQ1lrS2RUMXBVK2R5cktV?=
 =?utf-8?B?YVp5ZzA4bkZmS1RrSkdEc3VBWVZ6MFkwNlMzYzFUTXZub1ZGdXFSUUd3Um5J?=
 =?utf-8?B?NDl5NDI1ZHZJSUx5SW1YcFhvOWlOdGhraHJJMEpDQzhrbE1NU0lSazdyYUVF?=
 =?utf-8?B?ZDBVTTZLQ09KZDRVRkoreEpzdVBuTmFmYXl6WkJGcVRiVXM5ajh1Wnp5akJs?=
 =?utf-8?B?Y1NCOG1KN0ZscXhSbGoxOVRXOGVPNlJFb0FKUVpDTGMzU1ZNSHQ2S0V0dzRU?=
 =?utf-8?B?b2ZGV1lJclgrZFJZblBJUHZ0dGk2K3RlOG5jYUFmQjJwazhpNXpJdTdzL3lS?=
 =?utf-8?B?dUQ4Qm8wS3JheFViTDJsSTlKTUl5czIzM0NiT2hHemJadkhFU0wxWjBUMFkx?=
 =?utf-8?B?L2Q3R2d1UUNqTzBvWVR3UDB5THVBa29WUWtpY1lJUlFMa0licnZPSUdlTmIx?=
 =?utf-8?B?Nm00d3Q1Mk5OV0d3N1VFRXZYbjA2Qmk3OXl2WFZXV05McVpOd1Z3dVpUd1VW?=
 =?utf-8?B?TXZsM2oxbzk2OFZYT1pYVktmRndkZWRFeTVkMGgvc1hLT0QzYW1qeks1T1VX?=
 =?utf-8?B?eTZPWkVNZmF0MkxSenUyVVkrZkZ2L2dTRjRMYzJ0aHJ0U3lTV3B0R2VlZlVC?=
 =?utf-8?B?eDBxdThNcVNQUmVsRHJrV3Q2VVYyUDVjNHJBZUkyL1o2VVcrN0FqQVpzbXdt?=
 =?utf-8?B?TnM1dXZkU1d6UGxEcjAveUI3cjJrcEhPRnArM2J1UUhEWjNTR2dCb2NmaVMr?=
 =?utf-8?B?SmxlWEVwNUkxRVNxUVd2QVpka3RRdzN2MzB2c0FnaDNZOGVnNTMvTFJVQ1ZB?=
 =?utf-8?B?cjFYMkpCOVpJdStOcmxQbXR0NHVOck1jMUlaeE9CK2wvcXV2cVEramhFOWdy?=
 =?utf-8?B?alBGc25BVnk1TzJ3U2tVTmJWRGxRZGpIdnlzemZPakVpbGNDUHJLTHJOTFJ4?=
 =?utf-8?B?RTA5eldPSEZwRTBBeVRRa3lJVjRLRERoVUtPQVBsdDZJdmpya2M0RXg0UjBr?=
 =?utf-8?B?WVVCMzZmejUyQVVKVHNrTlp6a2lhRmw3dmZHT2tGa1J2RTBndnhiK3pGbzFU?=
 =?utf-8?B?bC96emxIQXEvZ2lvM3pOUHQzZFZ5dXlvNUk0bHVpTy9LOVppTmpvaEdXTWNN?=
 =?utf-8?B?SzBQVkc2a0hlUnFramptS3hMZFlRRGdJVisxSnBsRjBVSi85anIvYUY2TXRy?=
 =?utf-8?B?eU1zOHNGQ0NnQVNpeDg2N2piTXhTU0tEOHV4WjlJeVZFTS9IejllOFRWcG9o?=
 =?utf-8?B?eWFrSERSSUpkdTJBNU5aaTBqUzliMXlQTk8zZnRNYitienZDcmlQT0JDa29z?=
 =?utf-8?B?WFNxbmZYYUdmYW1RTGV4MisrV3BiaDlSc2x3V1pEaEZsYnE3YmZGVFNLbnd2?=
 =?utf-8?B?enR5dXFFQzNUVW5zMzZmOWdqSXpWeDU3VTVwMll4QmpValViQVZ5YlQ0eThN?=
 =?utf-8?Q?hVWVqxW7yAqbf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW9Bb2VaQjRUZ0tPaitrUjNpb1hZS3ZmeWZCRmF3Z1VKWEJqbzBYL09NenJk?=
 =?utf-8?B?TjZNeFgzT0lEclZPOW14cU9MRnJWSG5nb2xzdlcwOTFieHI2SmZha2JKb0hy?=
 =?utf-8?B?em9qclkwZzl3UHJHYVhicGhucjBIOUhRSVZTdVFuM0NUOVhZck1tZG9MRm1s?=
 =?utf-8?B?R3BMbUpSUE9VK2UyV2FjcFp6aVRISnRMQm9Ja3ZyVTY2OVZwREtpa0FEeTZx?=
 =?utf-8?B?UUZRdEFRTCtkd05FNDVOUml4Nk9oRWl2OUF4K2J6RkYwWUtXU2dSUTJETnAy?=
 =?utf-8?B?M1pMU2J3WjYydDBzNXl3NGp6YkYyWkZ0ZjRicjV6Rm5jTnl0QzkrZEllbFRi?=
 =?utf-8?B?S2hUUG15MHJaOUNCczdtbHhWcDh0NzljeFFJeEduWm1QZTFkQXZCUnVkb2FU?=
 =?utf-8?B?THhhQkNCR0g5bStuK1BtTncrMURmaEYyaWtEVVFYRktUV1F2TTZmRU1ZVnV6?=
 =?utf-8?B?emcvSGZTUGFtekJvV3Y1dG1VYkpXZGVGY01HUm5kSEJBRUFQaEpwa1NsZ2tB?=
 =?utf-8?B?UFoySnVwNW8rVlczOUlDaTAwQWhFRXhnbVVPYXpMWHlGY3RuRTJlc2FsWkFZ?=
 =?utf-8?B?dFpkTnNzWmd5UnBIRkxXMG1pVzRjb2pmNmNrR1VFN0d5V3pHMFZ6YzU5a1JG?=
 =?utf-8?B?aGI5NEZjSDVGanRYbGhPRVNwbEppcFM3UjN4M1g2Y2VjZCswWWNubThpZFpF?=
 =?utf-8?B?Y2VCOTJyKzFiaVhJbSs2QnJrc1VvU1hwekwvcmtJbndiMnFZSE9vdmI2My9D?=
 =?utf-8?B?R0RBbmV6c0ZDZmxwMXZVN0R0S0NMSHdLS2FCejlKNmcwQ2Z5UURJUUM2bjVt?=
 =?utf-8?B?NUxMZHM0dm8vOU5IYUtjNSthR1dHK1g0YmtkaW04Tk9wOFRWSUowTm9LSmlr?=
 =?utf-8?B?eUJadi82S2ExZ3dqZXY0NHI2ZE16NXFKVk1Pa0xML29VUjU4KzJLUy9QZEtD?=
 =?utf-8?B?aENtd3d1SnFaVTFTZGxoai9reG1KakhqcU9Ta2JjS0d6LzliMU4zMUlSNkFu?=
 =?utf-8?B?M2M1UzVMZmNYc1Y5Ly9nSnd1MGxSNUt0SlZRWmdvMElNNVMzdzJxeUN3Z0tK?=
 =?utf-8?B?djlvcGlua2MrWVViejE4anNJL2pzYVpxdm0zWHRsQkRmZHA2VERLK0FxNWxT?=
 =?utf-8?B?Yk0raGI1Z21lbVJncm5qZFozOWRlbm53ZmhaNDdDWHluOWFtazFOTVFpZkpG?=
 =?utf-8?B?MUdDaGp6QzlLKy9aQ1MydlBFMTk4T1ZJdndMTStSUTFHZ0NEekVNamtKN2sz?=
 =?utf-8?B?NmFPakhMVERVNElLSENVRi8zMTErV0pTMmI4RjB0TFByZnkrYnd3SmJLbkdC?=
 =?utf-8?B?RnVuNG96Y1lSN2crV2RMUU1YRHVjUVJ0MFlFdkcyRGJOR0FHalhSRnFreG5i?=
 =?utf-8?B?YXFicDRuditqRm51SnA4aUFpZ3pLRXQwVjdReGxGOHdaY0I0RmpFQUlna1hG?=
 =?utf-8?B?WjBFRUw3azhMMWV4YllXMWJhWFBoNHVubFdlVFh0Rkt4TG1ZTG5xUW9USExt?=
 =?utf-8?B?MTBzR1VzK1JvN3BDdWxTRW0xVmpZci9aczNCUFNRZWFva3FHN0V1RHBqNFd6?=
 =?utf-8?B?MWVScFhDelc3VzZqK2VkdWtZeGVjaXBtQU9iWHQvLzNSL0ZCNitWa0V3MzVh?=
 =?utf-8?B?bjVCbUozdlAzdnRwUFRZenV6Q2lLRERGakxweFhaZ0c1WFRoaW0rQ2hxVXhq?=
 =?utf-8?B?UUJnRnFZeW9FVDl2UU9KS1ZsZXorK1lOWktFeFhoSjhvMVJyVkE5Zm52dmZi?=
 =?utf-8?B?T2ZzT3RNMkVKa29hSkp0UUY1YndiSE1PYlhIU1l2RWZMSnFlLzV4WWdDbFQw?=
 =?utf-8?B?Nm9lWHRpOUtPZWprWkpRRjVCblgyMHhlYTMrQnorTkk4Y0tUMFFheGtJNzhX?=
 =?utf-8?B?WHlmR3QzdlVuY3NLRTZhMldpVHVSK1ZwWERIR0dPZEMwMkZJRkZDN0ZFUWx3?=
 =?utf-8?B?TW9zekFqQ0d2TmNvN0pCaWVvODYxZVh1VmNMbG1ZOE4xTHpLdXYwQU9uL2xx?=
 =?utf-8?B?MENYRnZQbjFhcWQxcEdodUpjWXZsT0NUc2JKaThiRHlWakZ1VDd5cmh1N3FS?=
 =?utf-8?B?Y3NkNjZoTTducFRpQmNsMERINE5wSFBWaEZXa1JIRytWV0cweVc4Q3U0Q3lh?=
 =?utf-8?B?VHhkcVNRVjVCU0Ezc2RkQ2tRcVlOWW1jUkFONzZqZ3VKYWVaalRYM1JQcUtR?=
 =?utf-8?B?NDRydXYyOWQrUUIzTDhrR0lESUJtbXY0MkdNdEFSaDBxWFZhRzdNZm9aTDBl?=
 =?utf-8?B?YXZLODhtUWEvWkhIVGlHRFhoeVNBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cc72e4-c8e4-4afb-9fd7-08dd33d9a8f1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:53:29.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1BI3dXOBxteXUm0px3twZKafifHcopnbqdLAB2tqLUFk73TE8qng2m/3bz29FIJB1X+mdmkuO1xNFXZaSNi1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635


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

This is a Tegra186 and the topology is described in 
arch/arm64/boot/dts/nvidia/tegra186.dtsi. This is from the datasheet ...

"Two CPU clusters connected by a high-performance coherent interconnect 
fabric designed by NVIDIA; enables simultaneous operation of both CPU 
clusters for a true heterogeneous multi-processing (HMP) environment. 
The Denver 2 (Dual-Core) CPU clusters is optimized for higher 
single-thread performance; the ARM Cortex-A57 MPCore (Quad-Core) CPU 
clusters is better suited for multi-threaded applications and lighter 
loads."

So one of these ARM big.LITTLE style topologies.

> Are you using any cpuset configuration for partitioning CPUs?

Not that I am aware of.

> Also, could you please add sched_debug to the kernel cmdline and enable
> CONFIG_SCHED_DEBUG (if not enabled already)? That should print
> additional information about scheduling domains in case they get
> reconfigured for some reason.

OK I can enable that.

Thanks
Jon

-- 
nvpublic


