Return-Path: <cgroups+bounces-6431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B2A296DE
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B69A3A1737
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF391DC998;
	Wed,  5 Feb 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BrA4ljCI"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A171957E4;
	Wed,  5 Feb 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774606; cv=fail; b=FckrHr+OhwohbI0BA/K7HUiH2mtNLj0k2oSV3MtxSYXytR7tBlvy4XPfyIH508tgSKTAxTQSKYFWvPDYuI0kgWI+k87fpc+YXmzMZs6hlCtkLFq12uHjVVVUSTuU3jE1kWj4dvwca1HJpgmf9+bwNISNRcMCscXBtkHTmmQElSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774606; c=relaxed/simple;
	bh=AQjS7MIBg8em+vJYV0Kb+bDSGTmPdEQV25cCJ29MW8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MyVqvvr5MTdKqm3nKlcSARHB5BFsAzEcDunKtkU4b/Ph8qWDefNrm9DX7EBmhKU8JM6DRica7J6A9tmZvzVZu0X6Q6/1xzJbKVra0Bi47dKLeAfHO8aIHVPThj57YQogLKvbC+aHax2peOV5MqNDDlDSbL51jVjt31JkF4+Kf7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BrA4ljCI; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV2VpW2lE3Df3TcrBHZVgI228qieojFfZsKQAMV8+WxQavI0M20oIPFQwjRATlo96pPgpvYQztIKcNrI/4K+zhCiW7n84XVReQ1+1Z2WPGnASDXqIuyWQvs7QlJhBsZVZ67Q80u0AX2yI/yNB2syKK7OSBxZN7tkKUAcwi8jHH7/jYli5HgCcIks9gF19DSeGh6BMg/zOx30lQoqcv3tTKEg+tMBaXifIfWADRiwOfkT8sFhy1CZeVX9Ozs3/Lzbs+j9SJ64Bl9Cje/14syH8XnKI1+7CaPsWa3yZuP7O3yrM1h/YD6TZZDRxd6E3PcnqXfvLY6vfKFArefUioQlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cklowLQNcnZRHnMpULNbn1WjLc3LFVByZAis+G9eHVY=;
 b=iekkhoMqjam/BZUJ/MR8N9kT8kTIMWgyas/2ibZK4oqfzHeH7Lk50XNR/zXhZGHB0njkqgFTgC2ol/2vjGeoeVUZG76W39CDp9wmaZTGvtKA22SLXHmCuU8pAu6cRZ8gZN4YNTYPqFmVFcbb73j1sdIZqUgHNlg6DeJXsSUHP5RSCMmhMf4+phT0RvSLWXzGS3kotECEl4/i1VWXO7occhojE2AfA9tp1s5A+CZbzq7RkqbymmhgpSHiBDe0lnguFUDXggeANs8mJIVQ/kHrcfTRiqVZ9S7CtpHhf//f++H/jCUPWRLUarcJIbxeofqMijPZ9HcYkYmWkEhG8wvIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cklowLQNcnZRHnMpULNbn1WjLc3LFVByZAis+G9eHVY=;
 b=BrA4ljCICkbEFhqMlaatd9kHQhdDoDvIbswMrIe342KJvqCayqnrAfMM/ks2SQxm/wtim9z8vwz1suyYCLhNTY9XO554ProHw/wPzK6XBkEGEi5RjSGLMYjIt6EzjZf/DQx8Y/u50ysaVwGtcs/XaubiCbeJgDy+Z0Zj++8Msenjn+w6c1AqxL8/zso8mHt+HfNryYSsICPtk6qIVPQqQWO/8vDB3RrQ0e0CRxIOgKwBnajRPwzY6Iqq89GvyiJ8dk3arnyGE56kCszk1w5Zn1ikgIYtATXHq1K4XrT2lMDgkNX+dQqGezsQY/nVBXjJXGbkFLICywGUvXp4rPR5Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 16:56:38 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:56:38 +0000
Message-ID: <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
Date: Wed, 5 Feb 2025 16:56:30 +0000
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
References: <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: f72ee48a-3156-4952-7e42-08dd46060e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGtqZzFNWnpWMzloeURxT3hFcEpvSGlndk81OEpvazBRamNxcDhqRTBqS3Ew?=
 =?utf-8?B?SUxBRGExaElBanlTdVo5R0RuOEJKVE5NQ0djaWhkSzBoSGZWRXJCeGg3dXFm?=
 =?utf-8?B?YlFqeExROFZFek1CdUNsUnVFWGRiQUNTRnV3VWNaUmdoOCthYjhpaHZ6MWpp?=
 =?utf-8?B?Wmc5NUdNVjNFNTJzRTZkVS8yM2U0SWNPbTFScGJPclRpZVdIN1VaSGhtQyt6?=
 =?utf-8?B?SUFuWmR4Qlc1RTJlbzRqdmtHUHZPMTlCczhwY3pKRHRXMjNDeXhEYXFTZ2wy?=
 =?utf-8?B?NlNkNjlEejA3Q3E5ckgzcEhXNkhsZnpDMzdHbXg4VER0ZVdrdzFBN3BWMCtE?=
 =?utf-8?B?aWpiQ1RXSEhWQzdwdURJM0psMnNSRDZvbUthT0hEWDBZekpvd1RKQXAzSFRh?=
 =?utf-8?B?VHRtYlpndWsxRmR4Z0ZUdXJoNXFrMnRsUU9lVTRCbU5Gcko4MGd0MmNMN0lv?=
 =?utf-8?B?K04vQnF3RkhBRUZqMzlZOExiYTl4N25TNi9JZjM0a0Z5N3hVTzFkVjdYZEFz?=
 =?utf-8?B?bk4xdDJaV29FMjlyVU9ubFc0cGdxbmhSb1VoUnEwNDJBOTBCZVpqN2F1NitK?=
 =?utf-8?B?WThtTnZxeFlvQ1hwQ0dBNnZyR3hMQkE1TzlWdHdCVnRVZ3BOMzI2NmxaSGta?=
 =?utf-8?B?Z2FnakxXUVR3T050WURacnpRT2RlSUVCZlRwTkNQaGlzV0NuTnE5NzErcEN4?=
 =?utf-8?B?ZnBNUjNaSjRyRzY4VittRS9rdkUwVWlmclRmMXRtVXdCOFpjMlF0QjdhVTVx?=
 =?utf-8?B?UTVjMVVVS0l5Uk1SSUNlTXZodEtqREpuaWJ1YzJ2S09ocXRqYlFBRmZlSTZB?=
 =?utf-8?B?K1FJWGJkcTErZ2pTRVV6d3JpbHk4Ym9RNW9PQTd2OHl1dnZoMXo0bXFJZjNF?=
 =?utf-8?B?dDZzRmpWQktTK3NERDE0dmMyNFVNRzNTazdVWndxU25RSks0SUNGVWlhemcz?=
 =?utf-8?B?S1pOY2RFa1Q5MXRhK01lV0t1NVVVTjAzYUttZEZSSUJoTnYrMWdkMlV5VTZT?=
 =?utf-8?B?NHJIRWFLa0dGL2x2cmU5aExKVkNSYTlHQUtHWi8rK0RheXZyYzI2cUNrMjZO?=
 =?utf-8?B?RTB6VXNtQzE0aUNZU2tpSE93bjJHOURXaDVCWmlVcVgwaUFjVUJBZjY0WmhW?=
 =?utf-8?B?dEJzZmRmNTNCZUhpZ21McG03QnA2ZmFQZ2tVbkVWU3d5OWF0S0UwNUlHUVJW?=
 =?utf-8?B?aEsvZzg4aENWYzNveGtMZWpsRWQwQzNNd05Lbld0RmVyc0VBenAxME55Ykg4?=
 =?utf-8?B?Um9NMHFCaWxndXBGaHhNQVpaR2NZSTFMeExGSW8xQkdVWUE4UHRCNHMvQVhs?=
 =?utf-8?B?eTJtMmlNWHZZMVRJelpyelQzTVp4VTlFeGk3bmtWalRLTVUvVmZFNmM3RERl?=
 =?utf-8?B?Z0UzRlBRZnhDbkxNWjVpWDhoRjdqelhISWNRY1plN3d3QXgvSCsrNFM2Zm04?=
 =?utf-8?B?NnZUZGtobllMd3FDUUh2TklRREprMUJxRzgzV2ViVjNVZ0VpTGVCdk9ja2hD?=
 =?utf-8?B?RDFmNTN0YXlQSFp2blBLMzJHTWVMUGUrekJ1QTNqZWZLVFVCaFUvNlNZWnpu?=
 =?utf-8?B?ZnNYUXVtS29za1lLSmlHaTMxUzNmbThwMTRLblNaT3V1OGVqSjdNa09RUXJM?=
 =?utf-8?B?Z2NhOG5ZWUpGYUdsTWRyaVltY2xrRVlnWmkrRmt6eFJXTHA1TFN5UVJKZUF4?=
 =?utf-8?B?T3VYdVBDZWJhdXVhM2txblBNYjh4QmtiRFQ3cU9ZR0pJbWNEamtCdEVZZUI2?=
 =?utf-8?B?dHFyeUZCN3J0ZEExV25ZRTNKVU5QY3VHZUw4a3Axc3JNaWd0SDltR1QwRDkv?=
 =?utf-8?B?RFRrS0RVNE91bUtLNjFuUG1IMk0rNnpoeUdycUhIckczSXVwQU9vZ1lxN3hj?=
 =?utf-8?Q?SQDmuyXpk9F58?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm0zSDVydXowK3dGbGErZ1MwQUo5cmtYbzJYZDdmQ2NITzNJMmhSVXRzRUJC?=
 =?utf-8?B?b2wrSmMxT1l0eXV1NjU2R2ZJUUV4MmRicU1FSG5ycEdZWE5XRmhSMDc3QWtQ?=
 =?utf-8?B?MjRMM0FZZUtBRVBTMXZLUkV5WjN1TTFCY05LaFpLVkVyK3hrWnRUdXB6VGJW?=
 =?utf-8?B?bEJnUWhxNVAzdDQvZFpldWVLNmpvV1BiYm5KT0lXeVA4VjNUeS84bG5pZ1FT?=
 =?utf-8?B?cnFadWFkWFRZSkJ1NnVSV29YT3dMaDFSanpBZG1lRk5Lb3M4bTRJQkpaU25W?=
 =?utf-8?B?bVE1ZGxWajM2M3BXYjM5TGU5QzhlcCtVQlIyVUc4WnY4RU9RaFF0dVFBdXV4?=
 =?utf-8?B?c2JUNUtpNVM2Qnh6czNWT0pkYjUzYkpsanJweGlKc1BtWUtsQVpQYVpjbTRw?=
 =?utf-8?B?YWlOM3F0cXpVWU50Ui9jNFQvTG0vNTFLOEdYdE5tMVBqUVFpY0ZLblVFWGZj?=
 =?utf-8?B?OW1MNzFqVWhsSk1PeThYMnRaSWdUZjl6eTFRUHhObFhzTW1xUVh3UHFLd2tu?=
 =?utf-8?B?clpabmFhQWJ1SVRxclFTa3k5Z0Y1enhIMTNPMkp1QlpkUkwwM0t0K0VQWHpW?=
 =?utf-8?B?aTlDZE5WbUZCeW9Hb2ZxQWRHY1ZZQUtIVUgvTDFIdXErSDBVeTF4NXVRR0Yy?=
 =?utf-8?B?ek5qbDlMOHR1eHRYMmdVMVlDTFdCMDUvUVRKTVk5Tm9idFU3RWxYOVJETDN6?=
 =?utf-8?B?TzdLWm5udkV6ZTZlS0F6dXRPTW4yeEhSN3l2NDhHZm0zd3pkSXduVlRQY2xx?=
 =?utf-8?B?bU5xWDlyb3pqNFBETll5KzMrb0JIcklZbFZBZ0JjcDlBdERycGkvN1g1Nldp?=
 =?utf-8?B?ZlZvbFVUWUF4WEc4c0l4WGRLUXhaU1RaTVhKMzEyOUhBVnVVQlFkUFVMRnA1?=
 =?utf-8?B?Tm42VzZxMjEvWElYb3ZhcnJwc2d3aGRVMWY3V3MxODcveTkxSzAyNHMzRTNi?=
 =?utf-8?B?OFBBeGhUYmtIT3FyWVF0QmFjNE04NXZkTFM5NC9USW5EcEJMdXQ5YmxMYXlR?=
 =?utf-8?B?Y1RsQ3B3djc4OEcvYkZ3TGN0b1hDZllVSkZ5V0lQUjRua3drN28rUk5vRmwx?=
 =?utf-8?B?WUNkeC9kVHhmN3d5THpuZ01McnMrRWtvc2JnK3dNcisxNkh6bU1SNWJuM1F4?=
 =?utf-8?B?cXMyTkdZcmRFY2E1UTlVeHYxZTZxMUx1K1NMbWk2bzVvMzB6aG53ZVNvUXN1?=
 =?utf-8?B?OUltMlB0dkE1VWdDSUZIaXNZNzAvemVUVmNpMXlWZmtjN2gzUE5hbm13TEF2?=
 =?utf-8?B?ZmtheE5wU2Y3ZTNoZTlFK3BERDhxQ01BbjdnNHlVaU1PV29sWmo3UDM5MCtw?=
 =?utf-8?B?MWtielJxdGdGOThyWSs4RzExcVc4SnI3RVA0eEJ2Rk5kc1VaR3VPNWQvWVBH?=
 =?utf-8?B?dTJkOGhHS3hzZWE5RVQzbXFkWjduZTdXQytMNnQwRko0SS9aMytHeVBZNTQr?=
 =?utf-8?B?UWJnU2VDelFEZUU2NzlmcTNicEFpbDAycDBwRmJMNzdPZXY1blJDQ084WEVK?=
 =?utf-8?B?OXkwdzhmaHlIeVdWQlRuUlJLWkFyOHhjOStkUnB1d29VTjJSZVRqeXFqQnBZ?=
 =?utf-8?B?aWwrUm9NWGFETVZ2ODZVZGFBTGhnNmVRa3NmaU9CdjdnbG9aNCtNd3AxMWZB?=
 =?utf-8?B?MUc3d0MwNkE0M3l6c1NGTytoMUpVMWlFUHA5S2kvSVhSSC9IeER1MVBaLzJq?=
 =?utf-8?B?anRqUkxCWE5hSHoxVnBqNWp3UURWUnVGRm0xVnZzcW9acEVkZFVnRXBlSjAx?=
 =?utf-8?B?aWlCNDUwYXJoUmttcDJ4cmYyYy9HbmJtWGRQL2Z5cnoydUFEQ3IrVVJjMEJ2?=
 =?utf-8?B?MUl5S3VXNHNRZGZNaFltdVR5SWdlcUZCaGd5ZlJkL05BczVvc2VaaFE4L2tU?=
 =?utf-8?B?SFRnQysvVlpTZ2xQdS9SSTdHNmlsQ3BqRy9rNEJhcXM1eVRBUkZncDA3TS9x?=
 =?utf-8?B?WCtaZzVsWFNZWGlZeUlQVW9PMGp2MU5zcnBmbHJEc3U5bVR2Tkpra2ZvTjJn?=
 =?utf-8?B?YzR6a1NHK2xHMVM0Z3lxcHczRitDNi9vdnIxcTh5YVJkWVN3Wk5uakdtK25v?=
 =?utf-8?B?V1R6WnBTcmlQT2tEYmtXR2U0bXA3MktIelgyVXYzU0ppRm1tcUlQK3czaUhl?=
 =?utf-8?B?MjY0QnRleXRUVDBlZFhrQzN2dElZdXplQUord3VENlpJMzFRTVJhQjJnc2c1?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72ee48a-3156-4952-7e42-08dd46060e41
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:56:38.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLAFhUiIvJO71aktuo6IfTa6IHrSrA/N8JcbDPd13MHRq3hFpwpbLjVoM4ExuqlsxIIRZcaF0ONXHqgiXMtxdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

Hi Juri,

On 05/02/2025 10:12, Juri Lelli wrote:
> On 05/02/25 07:53, Juri Lelli wrote:
>> On 03/02/25 11:01, Jon Hunter wrote:
>>> Hi Juri,
>>>
>>> On 16/01/2025 15:55, Juri Lelli wrote:
>>>> On 16/01/25 13:14, Jon Hunter wrote:
>>
>> ...
>>
>>>>> [  210.595431] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>>>>> [  210.606269] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
>>>>> [  210.617281] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
>>>>> [  210.627205] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2
>>>>> [  210.637752] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1
>>>>                                                                             ^
>>>> Different than before but still not what I expected. Looks like there
>>>> are conditions/path I currently cannot replicate on my setup, so more
>>>> thinking. Unfortunately I will be out traveling next week, so this
>>>> might required a bit of time.
>>>
>>>
>>> I see that this is now in the mainline and our board is still failing to
>>> suspend. Let me know if there is anything else you need me to test.
>>
>> Ah, can you actually add 'sched_verbose' and to your kernel cmdline? It
>> should print our additional debug info on the console when domains get
>> reconfigured by hotplug/suspends, e.g.
>>
>>   dl_bw_manage: cpu=3 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>>   CPU0 attaching NULL sched-domain.
>>   CPU3 attaching NULL sched-domain.
>>   CPU4 attaching NULL sched-domain.
>>   CPU5 attaching NULL sched-domain.
>>   CPU0 attaching sched-domain(s):
>>    domain-0: span=0,4-5 level=MC
>>     groups: 0:{ span=0 cap=766 }, 4:{ span=4 cap=908 }, 5:{ span=5 cap=989 }
>>   CPU4 attaching sched-domain(s):
>>    domain-0: span=0,4-5 level=MC
>>     groups: 4:{ span=4 cap=908 }, 5:{ span=5 cap=989 }, 0:{ span=0 cap=766 }
>>   CPU5 attaching sched-domain(s):
>>    domain-0: span=0,4-5 level=MC
>>     groups: 5:{ span=5 cap=989 }, 0:{ span=0 cap=766 }, 4:{ span=4 cap=908 }
>>   root domain span: 0,4-5
>>   rd 0,4-5: Checking EAS, CPUs do not have asymmetric capacities
>>   psci: CPU3 killed (polled 0 ms)
>>
>> Can you please share this information as well if you are able to collect
>> it (while still running with my last proposed fix)?
> 
> Also, if you don't mind, add the following on top of the existing
> changes.
> 
> Just to be sure we don't get out of sync, I pushed current set to
> 
> https://github.com/jlelli/linux.git experimental/dl-debug


Thanks! That did make it easier :-)

Here is what I see ...

[   53.823979] PM: suspend entry (deep)
[   53.827715] Filesystems sync: 0.000 seconds
[   53.832859] Freezing user space processes
[   53.838132] Freezing user space processes completed (elapsed 0.001 seconds)
[   53.845118] OOM killer disabled.
[   53.848348] Freezing remaining freezable tasks
[   53.853884] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   53.900686] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[   53.918492] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
[   53.962316] Disabling non-boot CPUs ...
[   53.966192] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0,3-5
[   53.966231] CPU0 attaching NULL sched-domain.
[   53.980574] span=1-2
[   53.982767] CPU3 attaching NULL sched-domain.
[   53.987119] span=0-2
[   53.989309] CPU4 attaching NULL sched-domain.
[   53.993662] span=0-3
[   53.995853] CPU5 attaching NULL sched-domain.
[   54.000206] span=0-4
[   54.002433] CPU0 attaching sched-domain(s):
[   54.006614]  domain-0: span=0,3-4 level=MC
[   54.010711]   groups: 0:{ span=0 cap=1022 }, 3:{ span=3 cap=1022 }, 4:{ span=4 }
[   54.018126] CPU3 attaching sched-domain(s):
[   54.022307]  domain-0: span=0,3-4 level=MC
[   54.026404]   groups: 3:{ span=3 cap=1022 }, 4:{ span=4 }, 0:{ span=0 cap=1023 }
[   54.033821] CPU4 attaching sched-domain(s):
[   54.038001]  domain-0: span=0,3-4 level=MC
[   54.042098]   groups: 4:{ span=4 }, 0:{ span=0 cap=1023 }, 3:{ span=3 cap=1022 }
[   54.049508] root domain span: 0,3-4
[   54.052997] default domain span: 1-2,5
[   54.056756] rd 0,3-4: Checking EAS, CPUs do not have asymmetric capacities
[   54.064688] psci: CPU5 killed (polled 0 ms)
[   54.069495] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3 type=DYN span=0,3-4
[   54.069547] CPU0 attaching NULL sched-domain.
[   54.083910] span=1-2,5
[   54.086277] CPU3 attaching NULL sched-domain.
[   54.090633] span=0-2,5
[   54.092999] CPU4 attaching NULL sched-domain.
[   54.097351] span=0-3,5
[   54.099756] CPU0 attaching sched-domain(s):
[   54.103941]  domain-0: span=0,3 level=MC
[   54.107865]   groups: 0:{ span=0 }, 3:{ span=3 cap=1023 }
[   54.113279] CPU3 attaching sched-domain(s):
[   54.117459]  domain-0: span=0,3 level=MC
[   54.121382]   groups: 3:{ span=3 cap=1023 }, 0:{ span=0 }
[   54.126793] root domain span: 0,3
[   54.130109] default domain span: 1-2,4-5
[   54.134040] rd 0,3: Checking EAS, CPUs do not have asymmetric capacities
[   54.141597] psci: CPU4 killed (polled 0 ms)
[   54.146819] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DYN span=0,3
[   54.156727] CPU0 attaching NULL sched-domain.
[   54.161086] span=1-2,4-5
[   54.163632] CPU3 attaching NULL sched-domain.
[   54.167988] span=0-2,4-5
[   54.170553] CPU0 attaching NULL sched-domain.
[   54.174909] span=0-5
[   54.177096] root domain span: 0
[   54.180239] default domain span: 1-5
[   54.183821] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[   54.191728] psci: CPU3 killed (polled 4 ms)
[   54.196389] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2 type=DEF span=1-5
[   54.196518] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[   54.214816] psci: CPU2 killed (polled 0 ms)
[   54.219411] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1 type=DEF span=1-5
[   54.219493] Error taking CPU1 down: -16
[   54.232948] Non-boot CPUs are not disabled
[   54.237046] Enabling non-boot CPUs ...
[   54.241216] Detected PIPT I-cache on CPU2
[   54.245258] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
[   54.256744] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
[   54.268954] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
[   54.280865] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
[   54.288270] rd 0: Checking EAS, CPUs do not have asymmetric capacities
[   54.295061] CPU2 is up
[   54.297599] Detected PIPT I-cache on CPU3
[   54.301642] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
[   54.308419] CPU0 attaching NULL sched-domain.
[   54.312786] span=1-5
[   54.315031] CPU0 attaching sched-domain(s):
[   54.319220]  domain-0: span=0,3 level=MC
[   54.323145]   groups: 0:{ span=0 }, 3:{ span=3 cap=1016 }
[   54.328564] CPU3 attaching sched-domain(s):
[   54.332746]  domain-0: span=0,3 level=MC
[   54.336671]   groups: 3:{ span=3 cap=1016 }, 0:{ span=0 }
[   54.342080] root domain span: 0,3
[   54.345405] default domain span: 1-2,4-5
[   54.349338] rd 0,3: Checking EAS, CPUs do not have asymmetric capacities
[   54.356122] CPU3 is up
[   54.358649] Detected PIPT I-cache on CPU4
[   54.362677] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
[   54.369399] CPU0 attaching NULL sched-domain.
[   54.373767] span=1-2,4-5
[   54.376310] CPU3 attaching NULL sched-domain.
[   54.380667] span=0-2,4-5
[   54.383251] CPU0 attaching sched-domain(s):
[   54.387439]  domain-0: span=0,3-4 level=MC
[   54.391538]   groups: 0:{ span=0 }, 3:{ span=3 cap=1021 }, 4:{ span=4 }
[   54.398173] CPU3 attaching sched-domain(s):
[   54.402356]  domain-0: span=0,3-4 level=MC
[   54.406456]   groups: 3:{ span=3 cap=1021 }, 4:{ span=4 }, 0:{ span=0 }
[   54.413090] CPU4 attaching sched-domain(s):
[   54.417271]  domain-0: span=0,3-4 level=MC
[   54.421373]   groups: 4:{ span=4 }, 0:{ span=0 }, 3:{ span=3 cap=1021 }
[   54.428005] root domain span: 0,3-4
[   54.431503] default domain span: 1-2,5
[   54.435259] rd 0,3-4: Checking EAS, CPUs do not have asymmetric capacities
[   54.442287] CPU4 is up
[   54.444821] Detected PIPT I-cache on CPU5
[   54.448848] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
[   54.455574] CPU0 attaching NULL sched-domain.
[   54.459950] span=1-2,5
[   54.462315] CPU3 attaching NULL sched-domain.
[   54.466674] span=0-2,5
[   54.469042] CPU4 attaching NULL sched-domain.
[   54.473401] span=0-3,5
[   54.475812] CPU0 attaching sched-domain(s):
[   54.480000]  domain-0: span=0,3-5 level=MC
[   54.484099]   groups: 0:{ span=0 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
[   54.491171] CPU3 attaching sched-domain(s):
[   54.495352]  domain-0: span=0,3-5 level=MC
[   54.499452]   groups: 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }
[   54.506519] CPU4 attaching sched-domain(s):
[   54.510703]  domain-0: span=0,3-5 level=MC
[   54.514800]   groups: 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }, 3:{ span=3 }
[   54.521869] CPU5 attaching sched-domain(s):
[   54.526050]  domain-0: span=0,3-5 level=MC
[   54.530150]   groups: 5:{ span=5 }, 0:{ span=0 }, 3:{ span=3 }, 4:{ span=4 }
[   54.537217] root domain span: 0,3-5
[   54.540716] default domain span: 1-2
[   54.544303] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
[   54.551393] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
[   54.558281] CPU5 is up
[   54.568000] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[   55.585391] dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
[   55.591664] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
[   55.600905] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   55.615015] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
[   55.617967] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[   55.655665] OOM killer enabled.
[   55.658813] Restarting tasks ... done.
[   55.664082] random: crng reseeded on system resumption
[   55.664403] VDDIO_SDMMC3_AP: voltage operation not allowed
[   55.674862] PM: suspend exit

-- 
nvpublic


