Return-Path: <cgroups+bounces-6533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACAA33BA8
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833C63A5E44
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD020F089;
	Thu, 13 Feb 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kI8J2Hwr"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68881E2847;
	Thu, 13 Feb 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440409; cv=fail; b=pzgEWU54RX1P6aNOCkTdTymN2skkuthO4ZsOnn2t1gBCKU1jKgzl/6zTDwGd8bZiP3mj6FCVPfFYIs+fBD282+x0OY7yNs+kw37K7hkcFIfi18tbhGs0zZzwKBCjuPDKeZ78S+LRP35/xcLVuP18KrjxHSuvM3ZcZT/LHJ77UII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440409; c=relaxed/simple;
	bh=HPrWTPll6QbvEpa2mKq8z4QT1KkgQzXJ2tHKAPnHgCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F6Zh4jI/UHCB2LFycY9jrCOHeS2PWjRGmvcwOw0RriFJQRaeMt3XIpyM7YKb8PQ1+U3ypAXqSZFigmScn2ac1GNRqNUMirOQfisX1AvPOK1I/agc5nJ+bMROId1Fjv/7jGUSAOBg9WS7J1hXhIMz0pddBtHqkSRToftfgC4mbFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kI8J2Hwr; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srNuWq60xWCpTWvZFh9mZCCbXcxiSr0+hy1y4tilgvuRK55IPjaMYt5BpBVQVEk9jYmcQAL1z9AWzSJbzBc+DMtD0UpVl0SkrFIHGY2qx7Hsa4jEJU1yJEFTJiQZQrG1ZAkzJCeqEYxelI15MnY2ZmyiImQkuaBkM96WXvcPMId9AyRIzmJcMXVZ379k11ncyhZ5wabwcaiEltnkAlKs2rz7nSWhEbOTnzDLku+6UZ6f8EflhgJhRG7ivmvMZ1r/hl/Sx/q03g1Uei1r5wi1Tr8hqC0NPfwGlt7yHau/B86e1ECziXyMQ+A08o+YrX8caBSweCJAs+vL3vjcNeB/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqI0iwIf9CDFCWjT5cgjhgwdBj7/DeA2LLRspulO8II=;
 b=MXIDDiTfQbY+s3lEUmu0mNByVnwz9jRbB2ecTAZbaJL7+lrhpSR5wC0LFRuLv4x6mXLAjad+rpCuJFMXFBjlWTK5M73+z5O/i/P7EONG+MP5YIrGtch2KHJi/IU2tGE6zufEIX0Qlu/6tlIg+5nO7AcX9LCaq6JNQFyWjAoDSEQDF/4+331HJnB30QgTdgV6TOyHi0Sp4R3YMT/PLSVVABDtscayGt1UUfbdteSjEVMbDSmn96ty0bExyq9Rr257PyEpPAxwq1M0qJIxlFYa2siRTLq6+sjvb2+qOt0oFI2pVxZoUeUozycMqpj7UHmHErgtrrAXwvgtDtmIbQGW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqI0iwIf9CDFCWjT5cgjhgwdBj7/DeA2LLRspulO8II=;
 b=kI8J2HwrisvLRF0uVJRYqNMQVRN1cAS9RCbJco9csaTZIcRVPMF222MvqGqTCeDLOIPYhNkizKbOPMsMqc9CkuzqTsKRzdpDNUl3m9og6frfcW/2GUPfEoKN85kekvwz77yP93XBibaXLUXKPp7nvSkkhu0/NTCgiN5wMUS7qwdYxUlzTFUzFKD4ZuyFud61jDFI10ObY/ToFnrpdT4LqJx9T3QAA3p9yBiMdZR72Czo1ClapG5YZBzrDA6ZGDQ7hX7jPxYnyiSDSTLB7zYNLfdQ05KF2GHIjcrkxxehAAn9LOS7l9v9yeU5dgZAykZGsPZle52MkK5cVLa7WovsPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 09:53:22 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 09:53:21 +0000
Message-ID: <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
Date: Thu, 13 Feb 2025 09:53:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::14) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d35e9a8-0ba6-4123-5f9a-08dd4c143ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBvQ0tWZW9CM1hzdzNiWHhpTTFlSUg5aUxoZklYRmdWWEd1TjUvSll1aFIw?=
 =?utf-8?B?ZU1EOXBYZVlydkdMTWJVaG0wZUNqTTZQb2d0dWtZdUlqaHpNOWFRMW9jc3hs?=
 =?utf-8?B?RmdpLzdWYmRVYy95TytVS20rM0dJRUpwb2FxTWM4bEFKN0RESHQ0TU9naWQ3?=
 =?utf-8?B?MHhnb29xQUFuKzBTOTBWWkdlYlhYaHdUWGJlaWRDVWJqTm5EbEMrR3ZGQzFs?=
 =?utf-8?B?MzA1NG1tQXhrSmtla2QyTUJaekhhaGo4dFU5YXV4RWtrM3lIcnVEaFBteFQy?=
 =?utf-8?B?aDhJZm5MdXRXVGtPeDNFWEg5bzBEMWxLQVRGOFA1Ni9Ta0hxcTZmUFQrNU9h?=
 =?utf-8?B?dzF1M3hVMUs1ckhYYUlBV2Qra3hNbVlhY3cwbWZpNmR5QlhyQVVTZFpvYXBK?=
 =?utf-8?B?bERCY05TVTB4ZDN1c3hBamVrTjFQYjErZmVuMnpGWVJUVGhHdGtLUWQ0Vksw?=
 =?utf-8?B?a0Y3S3RDdFJIUThUSjVsSjZjeWpQK1RUeERva0RmOHV5WG5QSlp5bnJsaVNX?=
 =?utf-8?B?bVN4Q1RTMVhHSXp6c21YaEZHbTVFckkvZlIwR3ZUSnp5THgrVFN5RUd4T1Mv?=
 =?utf-8?B?T0NhN2VOY3kyMTg4NE9qTzdEWThld3h2SWhxTGdxbG1Ld1JFcTBZNWNnWGls?=
 =?utf-8?B?OWFGMGZ0SUFTb1dIcDAza0ZmdjVTb1BUK0RqT2ZGSVU3bFlJays0bGNqV1VL?=
 =?utf-8?B?eTllbXJDTUpZR3g3TFBOK3crUmZFVzZydFIxdEM1aW1WcWtTWFJQbWJzV2Na?=
 =?utf-8?B?WTkzM1RMTklWaUxaR0hXUmg5dXJNSEJSUFJRc3ZFQnFlK3FDdENWWGxuN29X?=
 =?utf-8?B?ejN3QzFsU2Q0WkVOcVFNdWxTdkFPMTdML0J5c2o5UTJqZGxjTWlPUDEyQmU4?=
 =?utf-8?B?SC9sUW5IL2NLMGUvcmZUV0RWeWJlbHpsKzdUUERYTmpCTFdyekEreHJKOUt3?=
 =?utf-8?B?cGdWSm5ZVW9yb1NYZHJXajdJY1dHckhIVU50eFF0VHJXeHpmV0drQWZJek1B?=
 =?utf-8?B?U0FwRkZqakJERVBpZHJoRHBCcFI5RXY4U2V5TEFiWXlHNE1zQ2o0OXFtSUh0?=
 =?utf-8?B?WUJucFlhODlpMTNEUWRTb0pLM2RHSFcxbkJxT3RaKzU5WFE2L2dzNks3aFBq?=
 =?utf-8?B?VUpzaEljWGxyVXdFNEZHS3h1SGZaNldjMnFYaTh2eWprdjhWcWYwMmQ2ZWdz?=
 =?utf-8?B?T3I4UnNEd2FSZEp0OW5keXhaN1Q4NmFQVXgvZFpmZi90SkF4alN3cktBTnBs?=
 =?utf-8?B?YzMxaWovTnIxYWtIUHBRREtsZFF1RW16V05Oc3FpWFVPRmNYSDVBVFBQNENP?=
 =?utf-8?B?WjZNdDNSVEcxYXpEQjdQTnpyUXlYR29MNjFZTFJZSUtwQTgvRmI2UWp3dzZ1?=
 =?utf-8?B?Um1EeXNndEp6NFB1YWhCU0ZmZysrNUhRMk1JVGZOYTYvbGlSTy9rTGczNXUx?=
 =?utf-8?B?M1Y1UDd2LzVYREd4cjQyS3RBTkRZV2pjcVVRVm1FQWd0eDdydTNvY0l1b0xK?=
 =?utf-8?B?NmJzWEl6Z2h1UzBZcytEMHlsZ1lqRFRMY1VHSVJYRmVycDNBTlVUb0QwOEpl?=
 =?utf-8?B?d1JpaHlhcVgwNjRLcTEvWVRKSXloM0hVZEV2ZC9GRmJ0NkNwbDl6MnZwTDg1?=
 =?utf-8?B?TmdUaFV2cFJiSzI3cmlrR2JUTWE5Zng1bSt5OTliTElYWjJhaGFTdlQydzlD?=
 =?utf-8?B?MFkxVUdpbjJjUG5aYU1jaFRkd1JNRU9YQzBZNm9ZVFVMVytBQjk1VkJZTHNW?=
 =?utf-8?B?cHJHd0VMandpRDFVSDRiS3lrZ0t0UWF3OWVNbllDRXY4Yy9vbkhJNURYZk9E?=
 =?utf-8?B?RXRzRXBTNnY5VGovckE5VXhEMG8rZHBzZ0tWRk1zWHAzVzIvZmVUZThYWWwz?=
 =?utf-8?Q?timnvAOZBiG9k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWQvaGEwb0QxTUU2OWV4cGhpM2dTZkhCT05vZzVWTzJSKzBDN21wS3JMcFg2?=
 =?utf-8?B?UVNwTndXSk5WVGcvME1XK2RxRVM2OXNyWFJJcjJqYXM2bUYzWGxxWVpxR0Ex?=
 =?utf-8?B?SlMxdHJBVFRWemQyT200c0hpRFV6Uk1vNE81RkxSRVFXNlYwNzd3RVhJSzRp?=
 =?utf-8?B?UTVYbXU2NFp4Smg3YjdkN1hIUkRITHYwbHNkSHV3Z3ZMaXdUbVVoK2VrVEtk?=
 =?utf-8?B?YWN0Wk1XWHpOUjMrQW9oZEMxbWNLTStxbFNic1R5TGR1RVJYeHVYZkhUUzJY?=
 =?utf-8?B?UVdOOGs3emVOY2ZPc2tMY29Fcis0MzZPZ2JZVmZHeHU1WU1EcWNvU3pPNUV1?=
 =?utf-8?B?aW5sdm0zdndrZTc0U3dzUW5qRjFhY093NklteUlRNXBlWU9WcmhCV00ycE1l?=
 =?utf-8?B?T0dxY2h1ZFYxOUlmSFN3dU1tdUJxakl0bnRwazhUbHVyT0V5azNTRUpuY3Bv?=
 =?utf-8?B?RS9Fd1VWUkpjdDlBQzZDZHgwcEsyaUQ5dEI2d1JROXBMOGZXL0JYRENQTXBK?=
 =?utf-8?B?T0x1dXFKYjdJbHZiT3AzK0x0NG5BZ1Nwd3pCZG5DSkxwYVVWbG0xbDdJeFhO?=
 =?utf-8?B?VEdlc0hVbWUySG1Lc0FoUjhNTWx1UFpGMlZnMnBEVE4rTUxneTc3SzJOczdI?=
 =?utf-8?B?NjhNeGtHeGpJVGVKbUhCeFJRY1RTWm1CNlpKU0VVUFRzQmVZU2t6NWY3MGVL?=
 =?utf-8?B?SGxmTldnQklVZE8wNFFzUDVVKzVNSWtaTUVUTTRCRVRueElTZENiS2dwNjR0?=
 =?utf-8?B?djlwMkhBK3ZKeFlUb0Irc0g5ZU14MDZoLzVlNDZRb2hnbk9RakpvWTNQaGtJ?=
 =?utf-8?B?S0lQOEVCQ2RrOFhqc1dqZEh3VFJVcFZnSzZTdjFVQllTcTRGWnZRZnp1YUZI?=
 =?utf-8?B?NDhtZmpPWnBubzFzSmg3TWQwMTFjK3NOMXRHQ0dRYitNSFJEbUtnSGdwbFNH?=
 =?utf-8?B?OWxYdVE3OFRZYXR3NmZVcElrUkI4Z0VrTDlmVU1XZ2pUa2FwbllTZFQxUWdt?=
 =?utf-8?B?aG5YN3h0ejRlT2FaY29va0QvWm5mWWtBM25xSHhxNG1CT2hRQTJEU3BtZ0tv?=
 =?utf-8?B?bmc3OWorWklubFlwbklZS3Z3Y0dRcVpWMXZCcTNZVkgxenNEYlRLc3pMR1RO?=
 =?utf-8?B?SjVucStHa3NYR2hxTWJZRUVON0M4MWF2S2U1cFo1UDZHNkRGMkdERlN5eEtq?=
 =?utf-8?B?TEhaUFpYTEhnampRbGltWEJ0a1NwaUlQR3NOTmVmeXJuSW9GZFkyV01SMFds?=
 =?utf-8?B?VUp0UFBmRzcwUGNsVEwydEFDZUNDUVhrT0sxRlNqQWFHbVRsZzEzMERXdG5x?=
 =?utf-8?B?TFF4L0xNcEMvWC9uU1k2S1ZYTHc0K0hrMFpMb0M0cW1pN1VnbThXVlBDNHNv?=
 =?utf-8?B?TzZwM0FUdkNEQU1LTVBuQWtqdHloZTJxQm81Mm04Mjd3KzR1Rk5KQkNQVXkz?=
 =?utf-8?B?K1V6U25SQWEwd1ZhU09oV2ZrTUR0N282U3VIM0IxdUhrbG50amdUc05lRmlk?=
 =?utf-8?B?OGlrVjVyS1RKR3ZRclN6K282SWFNaXVIY1huKzE0ZHFqSFZXVldrV0ZGajU0?=
 =?utf-8?B?ZmxEUE8rRTErSkNsaHRleU8wOUw5ZDFaTnRETjhwbW1rU1g5Zk1FZHI5UnBv?=
 =?utf-8?B?NDhoaG1vNlBNa1BIYVVJYkVrYVR2OUY5T3N0UG1WN2d2YXdycHQ3Q2lhVGY2?=
 =?utf-8?B?Tys3aGZIRmI1TlRwaHhyMytrYUYzcmxpUmlvWEpYVXJibE9MQVF3S2UzQ2dU?=
 =?utf-8?B?OU5iUDE1K0toZUR2UEt5ODdCOUk3VjhTREg5OW9TN1IzeXRIOURKRER6Ykcy?=
 =?utf-8?B?N2FZQ1lzVFZURWFkNzFMTjB0OEllZFJZa2RuSTU0K3dOVDJrRmFPSkZ2Ukxn?=
 =?utf-8?B?YnpBQWdrSFlNVWdmM2JodHR5Z0p2a0V4QnpVaXhuWjJKNWgwQ3E4UHRsUWVN?=
 =?utf-8?B?MzZDdXdkTm1vNkJ6bjR5dG9ablpUYTFvcHkrcjhFK3NscFR2eVhBYUNXOXU2?=
 =?utf-8?B?QzQ4dWg3ZmN6ZHVxaDlwbGE3QlZqSlZQa0pJY0liZnpWU0c1RmhWbWcvVGZH?=
 =?utf-8?B?MnVyZTBMRFdCMzM2bXQvbEZRVWM1cVlpUk1SY2FIWkN0UElmbGZQQ0g2S1hq?=
 =?utf-8?B?MVFjbFdpNHk3ZlV5Z1YyTkhnZHNZM1hlUzU1SURHVWp0dTV1TWFVVWlIU0kr?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d35e9a8-0ba6-4123-5f9a-08dd4c143ff8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:53:21.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rr4G6wSfLzhgs54z4MpT9AlAqFLLYhdYQPvI15QYRmflNfvCsEyLtDQd6AxCRoLG5YfRad9axPYTrW0BJuLE1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926


On 13/02/2025 06:16, Juri Lelli wrote:
> On 12/02/25 23:01, Jon Hunter wrote:
>>
>> On 11/02/2025 10:42, Juri Lelli wrote:
>>> On 11/02/25 10:15, Christian Loehle wrote:
>>>> On 2/10/25 17:09, Juri Lelli wrote:
>>>>> Hi Christian,
>>>>>
>>>>> Thanks for taking a look as well.
>>>>>
>>>>> On 07/02/25 15:55, Christian Loehle wrote:
>>>>>> On 2/7/25 14:04, Jon Hunter wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 07/02/2025 13:38, Dietmar Eggemann wrote:
>>>>>>>> On 07/02/2025 11:38, Jon Hunter wrote:
>>>>>>>>>
>>>>>>>>> On 06/02/2025 09:29, Juri Lelli wrote:
>>>>>>>>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>>>>>>>>
>>>>>>>>>> ...
>>>>>>>>>>
>>>>>>>>>>> Thanks! That did make it easier :-)
>>>>>>>>>>>
>>>>>>>>>>> Here is what I see ...
>>>>>>>>>>
>>>>>>>>>> Thanks!
>>>>>>>>>>
>>>>>>>>>> Still different from what I can repro over here, so, unfortunately, I
>>>>>>>>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>>>>>>>>
>>>>>>>>>> Could I ask for another run with it? Please also share the complete
>>>>>>>>>> dmesg from boot, as I would need to check debug output when CPUs are
>>>>>>>>>> first onlined.
>>>>>>>>
>>>>>>>> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
>>>>>>>> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
>>>>>>>> isol CPUs?
>>>>>>>
>>>>>>> I believe that 1-2 are the denvers (even thought they are listed as 0-1 in device-tree).
>>>>>>
>>>>>> Interesting, I have yet to reproduce this with equal capacities in isolcpus.
>>>>>> Maybe I didn't try hard enough yet.
>>>>>>
>>>>>>>
>>>>>>>> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]
>>>>>>>
>>>>>>> Yes I think it is similar to this.
>>>>>>>
>>>>>>> Thanks!
>>>>>>> Jon
>>>>>>>
>>>>>>
>>>>>> I could reproduce that on a different LLLLbb with isolcpus=3,4 (Lb) and
>>>>>> the offlining order:
>>>>>> echo 0 > /sys/devices/system/cpu/cpu5/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>>>>>
>>>>>> while the following offlining order succeeds:
>>>>>> echo 0 > /sys/devices/system/cpu/cpu5/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>>>>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>>>>> (Both offline an isolcpus last, both have CPU0 online)
>>>>>>
>>>>>> The issue only triggers with sugov DL threads (I guess that's obvious, but
>>>>>> just to mention it).
>>>>>
>>>>> It wasn't obvious to me at first :). So thanks for confirming.
>>>>>
>>>>>> I'll investigate some more later but wanted to share for now.
>>>>>
>>>>> So, problem actually is that I am not yet sure what we should do with
>>>>> sugovs' bandwidth wrt root domain accounting. W/o isolation it's all
>>>>> good, as it gets accounted for correctly on the dynamic domains sugov
>>>>> tasks can run on. But with isolation and sugov affected_cpus that cross
>>>>> isolation domains (e.g., one BIG one little), we can get into troubles
>>>>> not knowing if sugov contribution should fall on the DEF or DYN domain.
>>>>>
>>>>> Hummm, need to think more about it.
>>>>
>>>> That is indeed tricky.
>>>> I would've found it super appealing to always just have sugov DL tasks activate
>>>> on this_cpu and not have to worry about all this, but then you have contention
>>>> amongst CPUs of a cluster and there are energy improvements from always
>>>> having little cores handle all sugov DL tasks, even for the big CPUs,
>>>> that's why I introduced
>>>> commit 93940fbdc468 ("cpufreq/schedutil: Only bind threads if needed")
>>>> but that really doesn't make this any easier.
>>>
>>> What about we actually ignore them consistently? We already do that for
>>> admission control, so maybe we can do that when rebuilding domains as
>>> well (until we find maybe a better way to deal with them).
>>>
>>> Does the following make any difference?
>>>
>>> ---
>>>    kernel/sched/deadline.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index b254d878789d..8f7420e0c9d6 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -2995,7 +2995,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>>>    	struct dl_bw *dl_b;
>>>    	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>>> -	if (!dl_task(p)) {
>>> +	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
>>>    		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>>>    		return;
>>>    	}
>>>
>>
>> I have tested this on top of v6.14-rc2, but this is still not resolving the
>> issue for me :-(
> 
> Thanks for testing.
> 
> Was the testing using the full stack of changes I proposed so far? I
> believe we still have to fix the accounting of dl_servers for def
> root domain (there is a patch that should do that).
> 
> I updated the branch with the full set. In case it still fails, could
> you please collect dmesg and tracing output as I suggested and share?


Ah no it was not! OK, let me test the latest branch now.

Thanks
Jon

-- 
nvpublic


