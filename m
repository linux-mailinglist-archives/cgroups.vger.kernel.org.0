Return-Path: <cgroups+bounces-6459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D13A2C496
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC27C7A689D
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF21F7910;
	Fri,  7 Feb 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pD/y5EIz"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C71F7914;
	Fri,  7 Feb 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937075; cv=fail; b=cxbSw/VpHxQPvyvAZBpVrqLsVbOyO6EyS9LBZQptkO0/0ifX87+TCfm1OGuXDxZqBqka8ypIpdvdO6STKJvkCRs+Mc9oB2HoA8fL7aZ81olqdeFERv6Cxj5T/PFs2tpB6GKeDg2SDhBQPC2EaBwN3FMqVdB3hnjcTs+mqjXozJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937075; c=relaxed/simple;
	bh=I8AdG0Bw3ynibSpiwPjTIqaqIRqN61pHVsvXcRIRdnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYAHtD30BgqoOAZnCz8WVHPAI9Zd9sBuO6/FO6IuN2Ss7UGZKkuxGCDGPeGW+AxQQPRK9eBBcICf7UKm58ZCM5kPeB9M1xcgBvTAtXiAzusYLrXQ3gcJlH8zmagg7RXC+vWCB4CclFvvmnx1FGvIHIOhVwvK1Py2GQMpD3hX69M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pD/y5EIz; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVezWz3vJO3TsKZc+P7O5tMaCT6IRc3lmf8Re5vpQy/y5TRZ/R/J3MGEqXCl6foWQLTiBLFfWNRaZVxTwJg81uh1mjp0OrMAQ8zia6Jle8+XHeHXPb6TaW2Epmz4Z/hiK9Ex/HiJTaMe3QXSNTxxIWd4+zqcxd11EwRJDF68CIumidaoOMLPzUBuv3hxNL2BJDs9+MWOxA7Lxmc9zknOfA/6VSclHfEhUWUaOj1jZGfwFan1CmJM4kM/ZRVArChKqzJ/SgCZEw3/yM5SOc1YDYYexZKR3eHMJMyRJQ2tP3tAd27UpgfTsLTUwhDlaiDex2hkWcjvZpZ/WwJIa+GEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz/ixbf0XnLbhnNq13YDT9Vmh0/XjFwtsc391LrE9eg=;
 b=w+efSGMpWeFIZyj6wZSFN/NQScySaRpyUoXBJYbuwW/5pXtcBOJefbDlbh1OYT3olzjr1QeWVX/XLsigVdtpbI19kHKA8TCqcLnPcSxIlBURxRCpn7ZTLo9sZY3dQvfWrDN7GWNVhzJmD9SnqCvixlJkZU54p6xtgp0j/lZm8pY4zC20z3TQjx9LSzaDG6yo6h5wGYVdIi/9OqfN/38vSNgigwt5eZqrgngMPZ9rycTr3RLVOlML/pZ+IV0fn/mhyeAt7veNCk+phDlmaTOjgkoMDcz2zZl9VyOYpczK+yjxzO62jsDL4tFvxVC3xnCRERe5qEpgyYGiu5XIPfmvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz/ixbf0XnLbhnNq13YDT9Vmh0/XjFwtsc391LrE9eg=;
 b=pD/y5EIzVrwvHyrw41TnjwccN2aXZ8OjSwmrvO/jqGnMnU0+nRnw1HOSjsVo+AwC/aDzk/whx+nRNURflSHbWI7yBygqRWxAxtiZUQ/dlgQg/S0L4JlheBOPhUenp4pRoWPIGYGK19pshaz7ZGrQFbS3PMFmWNjQ6dTnfZ26LSacyxTurQdtLoiIjFiYiooO9Y0hI/+p9GkSuqHpkGNCDIf3ip9ciPiSDpmw58l6BSm4+9otPcJyExcC05pPd931uu1Qu61HAZC5oXeKQaikXCl1iVewD4GThER29CDie+z2KvM8FgOS5A/e9InSHII/DW9LKzLzf3rN4lHHkLJddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:04:28 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:04:28 +0000
Message-ID: <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
Date: Fri, 7 Feb 2025 14:04:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
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
References: <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a13c48-04ff-4e38-eadb-08dd478055ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJwOWJHaDh0SDJxQk53TXBVbmxEZk1vUENYaDc4RjVDanVzQ2ttallReVFG?=
 =?utf-8?B?a2RUeUh3Ryt5N0ZZc2lQbFppeTJJZkZtMXBhbGxpUEVYVytHd05FVGF3eUZU?=
 =?utf-8?B?WDZKbG0rUzNkSzFIL3VSMkcyNFQwYnBnaGdBRkV5MEI4dXpsUjc1NlVwUVdT?=
 =?utf-8?B?TTNRVzRXTExxclBod0kzeUx2SjA1TTdWa1NFRDJmeURvS1pUZEt2S3M0bmts?=
 =?utf-8?B?bldPMWF4cnRMUkZObExXa1RzSFNROUlUZEFKbzRicGJYcGhNRDRtOVpnenRO?=
 =?utf-8?B?NEtxNWJzOXdjUUZLaDUxb0swZjYrSVVvSTU5QXJSMTBYQlhzRmJPUHV2ZHFZ?=
 =?utf-8?B?ZjFIMXZkTmpRVnVWc2pqbkw3ZTdDOCtXWDI3bGdRSWxoY0JzMXEzc28wZmh4?=
 =?utf-8?B?NDJnVFNDWkkwbjhHQm9DQkR3cUw1TkkrSmlpVFBITWp2NHpCN1JBYmZDN0tm?=
 =?utf-8?B?MUZzcXpaa0llRDFmUGVyS2ZocUVLWlp2bUZ6V1NISFFmVUZvdGl2UjJ2Z0Ju?=
 =?utf-8?B?WkNoaEJhdktvWE9HbkpjZElrUExBNGk3NFRSaExHZG45ZVZGTnJyVkM5dk93?=
 =?utf-8?B?UTEwQmdlS2VLTXVmRlMxK05SMXRDK2piTStPTDdrOXlIeStnY2s5Z1pjZ3po?=
 =?utf-8?B?c0RIRzQ3S0REMU9iRm9GU2dhaG5BcG9NdEZnQWNVcXVSWjIwZy92ZG9iUkd6?=
 =?utf-8?B?Y0UwOTJLNjFSMXQ5QUxCTFR1NEoyWThEdFpqZXpKK3RSYWhBSnhjeTkyV1I4?=
 =?utf-8?B?Y3VqSy84YllvdjRDSDI5SlFVc1F3Z1RqanJaN2tjVSszOWhlbW9KQ0QxM2NO?=
 =?utf-8?B?ZDJVRmhKRWJuSk9BcVFTQXllbHdCZ2dNY3JWalAzU0k2UG05WWVuSE1XZ1kw?=
 =?utf-8?B?QVBuQVowZ2w1MzJnR3k0bmRuM1oyVGxIbUZqR2xIV0hFZ0RLWDlwR1JCbjJN?=
 =?utf-8?B?cURxbEN5RHRtU0ZTakVjN0VaSlJIN1hFY1l4UE5MU2FPR0UwdHRwYVMxMHBy?=
 =?utf-8?B?ek5lUG9MeFp2Vm1TcHBzbWsvS04xS3NCWldua2lEeTRjaU5hNUE2aCt3M0g2?=
 =?utf-8?B?WnZseUlGdm1TNG9jSVdVR0xQNEN1VkJ6OUZYQ1BNbFllc0tKS0g5cUZHNlBN?=
 =?utf-8?B?VFhRYUlUdGFEbzNBM1lraXQ3ak1HR1VCenNxUnc0cm1PODFJTmtLdk9JaFps?=
 =?utf-8?B?ZHA2VVJ0bFI0UXFibDdYVmg2VHd6a3FGY3kyQ25wR2pieTFDZW9Fd3ZmbTNE?=
 =?utf-8?B?VDkyb3RkOWNLaTZoUXlweWVFbU1tMjFMcldHNStndUxiT3NQQ0ljOFJ5enlr?=
 =?utf-8?B?andxVllhKzBjdGxSOGllUDB3UzE1VHRqNVFqK0JmbEFLQm9NdElNeG5MY1lz?=
 =?utf-8?B?N1NzMmU2VThwUFVDTFdGbkppbTFLQ2tuQ1VoTGZTVDVyamNST1dYdyttcU43?=
 =?utf-8?B?VWRlRnpYL2k3ejRia0FDeDJrejVTSlZuaTdzT2ZjMUxDc29kM2VFNVExODJ6?=
 =?utf-8?B?T3MrUDNVa3pyZnFjbEhNNFZjVFJqTFJWL0s1Z0tpcUpGMEVmWk1OSWVXQUV0?=
 =?utf-8?B?dVFidmdySjhLalA1WUlHcUg3RFZjcmV4R0ZIMzBIMmI5WmdEK1dUbEhKV0NL?=
 =?utf-8?B?em9pbllZOFBhS211Z0FXY2lxM0V4a3psRVNhSzhZZ1drdTV1TnBkZWZvV1Uz?=
 =?utf-8?B?aTVORUNEYUtpVkFPZWl6VkhDcnBtQVV5bWVtL1kzRjIyS1M0dXUvT1FtZnFK?=
 =?utf-8?B?MkxWYURIZlVVK2hUenpOMTQvTnNsanFDOVhhOWNrK1NQVTBpb09wcFkxRUxn?=
 =?utf-8?B?Sm9OY0RBalVmTjZQVFR1R1ZTUWtwVFU3cXE4NVV1WXBPTU9oSTRBVVZSTlFt?=
 =?utf-8?Q?C+rWOPIK5aeba?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0VTdHhOdTBUeHlUbURLemlkQlRSU0Iyay80dzFkZmg2MElCZWRIR0JKcWhV?=
 =?utf-8?B?RlJ1aE9jditobDdzMFk2WnFFamY3V2FudHluSFFtK0EzQWs1bTVUY1pJMTJa?=
 =?utf-8?B?WEVPdWxKWStpeVdYNk1ORnFvaW5laXdnQ3JxTkY1czViMjJaYW9nZDFKdmdw?=
 =?utf-8?B?SytvaW9LSFNZcGxsZnhOS005TXBaM1k4a3IyZlpSZURUem1UWlJzV2ZzZXBP?=
 =?utf-8?B?RDNDbEx4aktBMlBnYVo5TFpuQlQxYkpQZTRjb1FvR2ZzOVNwZ2tzaDUvUFpm?=
 =?utf-8?B?RHlEczFxTS9vTGM2U0tNclR1UTNRalhuUGg2N09IMUVyK2NFY291ODdSMnVo?=
 =?utf-8?B?eHJCN2JOVFJFbmcrVTgxYUxsLzVZdlEvb3VidDJDMFJDc21nakxRVFoyekdK?=
 =?utf-8?B?Z2dYeUNLZEZPMVg5amFVWjNUS1NDUytUZVNQT0x0cDlrQUU4ajg2SnNnYmVn?=
 =?utf-8?B?RldiYkYxS1I0NURZQ2ZBNitudmlQK0pXQjN6bGM0NUZwaEhZbDZERTlDV0FV?=
 =?utf-8?B?RmVnVE1tNjU1MXEreVNKVGJYVXFvN1loQitVRkJ1blFjYW9EUmxXWjVoR1pD?=
 =?utf-8?B?cjR3YmhXRGE2VUpiYlpuZEtKTGdlR0xTV2Q4RmFvQUg5SnMxL0luS05HTTYz?=
 =?utf-8?B?OVJyQkJVOWZUYklFdFdMaVRXelkyZEdSUXoyV1BkUkVUYlBSNEZmY3NsM1BB?=
 =?utf-8?B?R1BINGNZc25wMER4bUoxdktJdFJOK2xZaXM4RlhveTQ2S2NSejhYSkZWNjFk?=
 =?utf-8?B?L0x6VTk5bWNZMkk3YUhrcUVkQ2dMb3NEbEZBcEcyZy95Y0hGdEh4WW5oWmx3?=
 =?utf-8?B?MlhWQXZWb3BnSTUvTGtWUjVIWmREa2hndzYyUGRUblhJbzh5b2JlY0ZGVXBP?=
 =?utf-8?B?dGN0ZFA4bGx6dXRWUUpmY0UyalVCRS9uanlvT0hlTzJvOStKUlQ0NWR6TlZ0?=
 =?utf-8?B?b3pEWFJ6NVhVNVVMRXUwdTJmOXl6eHoza0dXYVNZaDBNNmtveTBWUWR3cVdG?=
 =?utf-8?B?WWRKWmwxSEx6bGozd203blpkVGpUNGJsTCs3ZmFjakp4MXhSOHhTYW9vekhj?=
 =?utf-8?B?dFBIcTBoTC8rRG96TllsS0VlbGhwNWl1dmR0MGZJWWpKanN2T3RXUW11eTkw?=
 =?utf-8?B?RnhNSGJQeHRyZlFDdGpSbWhYVzNUMFloaHpBREx1V1psTnpvelFZQzFKQWU3?=
 =?utf-8?B?cXg2dVRnVUZTS2J6RlJhelJIVjJqa1gxcDJIUDYxTmpGckxxelhRYzdhb2F6?=
 =?utf-8?B?ajYwTU91WDVpMVBFbm5wcjFPUFVBN3hqNzZ0cVRGS3hWdTltcU5LbU9XL1E2?=
 =?utf-8?B?QzQ5U3BaYzlPUW0xTlg5VDR0WnRDWk1BRC9sRFFNa0tJdENXRG5tWDNKaXBN?=
 =?utf-8?B?VDZlOFFWQXMvekoxK0FTK0JaZDFMakNJZWhKT3lGR2V0aDRzWVhudmlET2ls?=
 =?utf-8?B?bG12ZXJtMmJTbk52UlBUREpGMVowZUthSi9xcFovVW9Hd2xnd1ZzVFR6aElr?=
 =?utf-8?B?YndXcU8zYWpqbFpadjIzOXVtZC9DMzlMNnYvK2UvWDV3ZmJSd0JlNnJmNDl0?=
 =?utf-8?B?bHlsZTNDeDFycTdzaUxTV1paRnBPLzVBTDhMc2ROclRZQW9tTlRxL3JvY01I?=
 =?utf-8?B?U0g4N2c2U2FVKzBhRFpQSW5kb1JuUzRHTS96Ym5iSnlSTCt1TndFVWZ5RkdY?=
 =?utf-8?B?bERJK0IwbktXS2tPYVhXbG1wVnhqT3NHUlN2elFkNXN4dy95ZTdMWmRzV3Nz?=
 =?utf-8?B?MDcxdHVaL2ZsQmRDZzZVbi9UbTF6UXgyeTJ6WjRrdml2dVRCeVJwN3FBUzRN?=
 =?utf-8?B?Z2x6T2tnU3VleUx4TlBTOU8zdEczVU1vNEV3MXByVTk1WnJ6aGpLamtrTTBI?=
 =?utf-8?B?b3YzQjhiVEFwNzM5V2dUMXU5bkhaVUtrcmo5SDYvTHNkYnBVYXhTYzFqSFAw?=
 =?utf-8?B?Y0pQMEhPYTJJQlJzMlRIVWx3b0Jzc2dYc0dubkxmaVI1eWhYamxQekJNY0N1?=
 =?utf-8?B?YkcvYTM4dGx3ZFhXLzV0eUNoRHdNTkhSSlN4OW42QzEyb1RyUmdybndJS0xu?=
 =?utf-8?B?UWxOajFaM2w2NGVJbkhUSk0zdnY4eEY4SVpKbEN4YTRVVXZlYlNtRy9zZUs5?=
 =?utf-8?B?MzdKM2txNmcwRmtIa0o4dXQ3eHM2MDRheXhyc2RUd3M5ckx4V0pBUmY2Yng1?=
 =?utf-8?Q?xXd/sxH2l6Is9T7BMCqw5q9LwXV2CsJS/44Q5yt1AZYn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a13c48-04ff-4e38-eadb-08dd478055ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:04:28.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAbyFAuNnT4DXYEQg4SpUGfweIfY2W1yKC7AbgAtT48f8lpBA2XLQY0/KF28MXFW7gGEwYuG+8+Q+Tuh43X5bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248



On 07/02/2025 13:38, Dietmar Eggemann wrote:
> On 07/02/2025 11:38, Jon Hunter wrote:
>>
>> On 06/02/2025 09:29, Juri Lelli wrote:
>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>
>>> ...
>>>
>>>> Thanks! That did make it easier :-)
>>>>
>>>> Here is what I see ...
>>>
>>> Thanks!
>>>
>>> Still different from what I can repro over here, so, unfortunately, I
>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>
>>> Could I ask for another run with it? Please also share the complete
>>> dmesg from boot, as I would need to check debug output when CPUs are
>>> first onlined.
> 
> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
> isol CPUs?

I believe that 1-2 are the denvers (even thought they are listed as 0-1 
in device-tree).

> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]

Yes I think it is similar to this.

Thanks!
Jon

-- 
nvpublic


