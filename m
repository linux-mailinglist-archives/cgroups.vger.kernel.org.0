Return-Path: <cgroups+bounces-6887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE4A566F1
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 12:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F737A7C4C
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA874217719;
	Fri,  7 Mar 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q4zIk+07"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E5213252;
	Fri,  7 Mar 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347662; cv=fail; b=LRtkw26N3bjN+jK9F+iw5K8vdmRvxcXqltd+RxU7IEG1EzvVlVZIEnyeJJjqOE1lpplcHjPuWN31XolRdsTEVehoeQXD2v6KJPWHxd7gDWuzfu9cCfaqUXOA61qmsCYcze3jF/bZQtyIdF4PsrYb3PZZ7nYPr9fFC5w0f8tOoas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347662; c=relaxed/simple;
	bh=eQRXkdrhiUiW3RKWDoGGdPFPupVcFsV78JF69FSsxD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c28L2H1WULlWyXuQVbnegE0JVUFubDWF0x/cwQ9vCyWQgpOGnfn3yf1KhvL7DcovhuYNd57gI1mbH3El72MbYvVaXwn6UcTMUq+VGpFuBDKgx2o8WjPrVbDciWO9zW+xQIKmkOxulEHcdFdS+SB9WFafsJ2UJhK/ZtSELostgdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q4zIk+07; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUA+5yOmo1fMQeuzWapRayXxk5vDK5DgoGYm+iXL2vYseMkHy354shVp6lJBDhFHttdiw7m7CfT8lDgbUJ37yef1j4k8FT6fRQM35LyJrgPS+3wZbqZlRk1HMZ4KZnSl7hsZmUoS6gtKip28bGSxZIi1rNe/bljexllUbLD+8mXxNHlItp9ShKmH46XMBtm+WvynTvoySLeUtcH6kJ6Xkn535b9L6Ym6w+fpHgHAOysNo8BQF53l3RxUX6h0iRmbs91p9xuP1SeNnjZ97Tq7/JNJSbJ35FLm3JMU+WLSH2jWiK/5vS1RIJc7IJQP0jW2dfLRoYTGIjXUf5p4MU7kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpyz9aZ/iUy3dPzmCYPNk2UM9/reJ9xzPlwEVQkFiKM=;
 b=r5rb5yNrsZx+oE6JN56tV6B0vDs4nnyfd0JSX6u/tvuAxlR3Mkd9gEocFfB2VxqmxiqYMNtSfZtrymvZRdmPjdCxA+PpRDbRH4bx4d1G2Lv/F2g8J6i8Xqd1s1dhGrzjQYO94r0jE7JmK5+BZYjlwvDiEn1PFbe7ae/ArmInyFxD7mDdQpEF7suV5U6wniV2tq+dQGr7OiC6OXUnb8PQsyjyak5HmBVrXcDZSjxdzoWmqXEdI4TDCllxQs+1gaar1ulRHikAwO6ngnHP9cxWQZPsPjaEN+quDG1iOAc7VwxQzRWWEaAOXIvS7jXSMudzq2JzCAa6DUIj0ZYG68fHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpyz9aZ/iUy3dPzmCYPNk2UM9/reJ9xzPlwEVQkFiKM=;
 b=q4zIk+07RpYuPLcTLTi9elHulAd+iNN7lWEPUNiwQQvQL5kW9E89C5PL0++3kdSo6/wC60xT34hHO1fseQ68Ujoi9EPG7ceEPeLI5sGYPn0Qja6bApyevWEFdx4+vzJsacBQheEuT5AJ8vFc9+Oi4YRjhgxIwBZmmN3j6GCJeT0aJFBCI4xTCvSD5vqKEUOFwX1uAR1XW6jNbpnCy/TbOFVr1edHcQiOViJjKLLxAUcQZtLoAYYHmPJXtZpvLmpawAtydOge1H88Bjqf1lv9f88oqYKuoQB1esUklE9W5nUJpZOdhb01kXYUCBqAy5p1ldXn2rL2ke1XzR2DYDIkGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 7 Mar
 2025 11:40:58 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 11:40:57 +0000
Message-ID: <5cffdf8b-2670-4b46-9434-8024e18e4750@nvidia.com>
Date: Fri, 7 Mar 2025 11:40:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a73a87-429c-4c6d-c357-08dd5d6ced26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEhNbi8xQ2w5SmJGMVlHdldJSUxOTWl0MkhPVDZHeWJaaWJOU2JhUEwyVlAy?=
 =?utf-8?B?cElDR2I5VTN5QmpTM25GSEV1UjRuUUc0TU9HVUJ0dHZsRnRKdXJLMWlBaWhi?=
 =?utf-8?B?NVpHblZxMy9Idlp2RmhCYTZwRVIzOWo1bm52bTVnV2RyQ2dmME51aXFVZlJV?=
 =?utf-8?B?Wi9CM1Y1OGg1ZHZIdE5pWmFvM2VKemdKdnc0UFRWWktqYks3VjBZSHJxYXQz?=
 =?utf-8?B?bTN0OXV0TG9mNTc0eFcwTmI3TVNGMk9NWStmRlJldVN2dk5wVTRiZVhlcS9N?=
 =?utf-8?B?Q1V3LzBiemwwcjlqU2dPcWJ6WU9oM3RJM1ZLV2svM3FuaW1UZlA2b3Vzbk8w?=
 =?utf-8?B?ZnJTeWtXZTBMcWcwOU5md0NucXRQYWxleWNxNHVqZFhoWFM4NUdkNDJKZlBk?=
 =?utf-8?B?LytDeFFKdkx6eUU2RDVma3lvZDllNjRHQ1E1dlhTTEhabzBFQndQUjduczRm?=
 =?utf-8?B?aElJNWdmdm9DblozWUhuUHZJVG9ZdVdBeHY0UFlhbncza1V0ZVc0RU9lY00r?=
 =?utf-8?B?OWJuWDhFN0Fmd1lHSTJHUWNLQzN3NTBjQnA3VzRTV2Q2VCtGdDducFlXR0l0?=
 =?utf-8?B?RXpBSk1jQmlOQk5JeUowVmpLMnllcHJNa1FIOS81T0FHT0dTZDllSmNHZVpo?=
 =?utf-8?B?akNRdnNXVzVqTmNRTFJNWFBGRDkxV0o5ZlNOb2V6RG1MUnFzUDNLYTRRN1dQ?=
 =?utf-8?B?ZHl5MzhQVHhvd1Z3a3RwbjVlMWZaeEVlSU5SUjRHSE00dHlBRytSTDVFaTFR?=
 =?utf-8?B?S0h0SldrRDlpb2lvUExOOCtyTlJOMGVDcGVReVNvUm43SkZ6bEt0Q1ZyN2xM?=
 =?utf-8?B?YllkQ1pMSjNZUTRxa3o3STdPSXozclV4Qmd0d3Q2bTdYMXhpYVNuUEZXMHZu?=
 =?utf-8?B?T2czeTNLY2FIZjJPSXo0TFczTCtTVmFIVHpNaUVqVkRrWXlGdWF2bmNXNGlQ?=
 =?utf-8?B?YnlHRGpCdWRVeGdXdDVZbXdPYTcrR0UxNVB2L0RGMjFqYnFCK0NEZmU0ckM2?=
 =?utf-8?B?TzM4aUEyTGlGeTIxTWRYb3hmMW5CdG5hM0IrQWJUUTAyTU8wai81N3VQUmo4?=
 =?utf-8?B?djhpZ1g0cldpcks4bEx5WmNxMFFoSURxU1pvK01rS3FmQzJkSWJMdjJYajBs?=
 =?utf-8?B?R2diZzNjdkJMYjcyZThYSVpmdTFsaEZPZ0FadW8wQUdYcTlJNjB6eWpPVHI5?=
 =?utf-8?B?MnU2bGJUTTVSS2NFYTdyekZpRFhmVmdLQlFnOW5TTFpsV2FCbkgvSG9NQ2dN?=
 =?utf-8?B?YUMraUhTWTFaMmpHaXl2QjhQR2JFcnNMRkxnQWJUN2pJcExSYXlpdWR4TFVJ?=
 =?utf-8?B?UlNINWI5YjhYR2h4Y3k5TTIyYkFzdUJDUmNsMGVYK2s1YUpEVGhnemVCZzlV?=
 =?utf-8?B?V2RqclpmOTh4c0h0aWRCY2NieVhoc1d0Z2JUN0tsY05DUExHdVlXVXA0aSt0?=
 =?utf-8?B?eFdlRVlQT1pEb3MrRmcyRXU3WjJNZFN3cjZzZUxtSjR3bmNrRkt6MzJDdTRT?=
 =?utf-8?B?QWM0ZUNlWmVORUZ4Vys4WVdtODZncUc0M2QwQVl3MUdNbC9TVGowMnpLT0hL?=
 =?utf-8?B?Skx0RHhuSjJLdXYyRTl1V2V1dXZRYkpwZkN5YTdLZnp2TmluTnlvUHZMN3h6?=
 =?utf-8?B?T3YwbFQ3TWxjUEMrNWZucjlRSjlka010VlpnT1F4Z1RmNE5TRWF0SE12ZjBH?=
 =?utf-8?B?NFhoMXRTTUJJQm1nTmw5b3pXWmJoNW8yRnJ6djd3TW5wK3RmRDI1N2NUUjRX?=
 =?utf-8?B?UEpXdUsrZGtIUWxyR2hJanRqeWhIamFHdDJSem8yRzNHd2dFSGNRZ2k4VjdS?=
 =?utf-8?B?eExHMXlHbERlZUMwM29WZTg2TWVPbGZmRWYxOXN0UTB3QUhUNmtjSzFJdEc1?=
 =?utf-8?Q?yjfAOU1Do5wmd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlQekFQcGVGOXVZcEc0dnJocWI1cFA3ZUVWZFhhZGtsdFNDVkRQNWlPLzBZ?=
 =?utf-8?B?NU12Zy9uaHBkbGgrWGVRNE9TSUJMQWxxdkkrRXVjREMzMjlsbWFEanpiZ2Mr?=
 =?utf-8?B?czNEYTZiLzRYYW9qM0QvL3NmZ0ZqbC9Dd1Z6cUNXYWd0Zk5XLzIrWXo4eTlo?=
 =?utf-8?B?VVh6ZTlnY0FTYVZxWGdiUW41MzBTcTd4Mm9KbnBKdy9vZDlieWJ6eHFkb3Fh?=
 =?utf-8?B?VloyYlRrbU9NRDFkYzJIUVVEb2hkOFlqUi93a2ZiZDNYRHZmL05tSnhjNlhW?=
 =?utf-8?B?OUpoL0pDVldqUVYzR0k2YmpFYjk3UFdWdlV6UXlzUDZrWUxJZGt1OE1KdFBU?=
 =?utf-8?B?YXZKVzVXMnJTbkt6SkhlUWtSTTZVcjNrNk5pUTZ5S0xWYmtFcVFrRmdmUkht?=
 =?utf-8?B?Ty9aRGJNSHFJMkFnRVRvVTVzNU15UFdVK0xscS9QSzkvYnhPL2FsSmtOR05M?=
 =?utf-8?B?cDMvSGloOWxtT2JRYVRvT2hlRzBuU3IxUktDeXlXVnF2TmNMN0xpL1FTeE1F?=
 =?utf-8?B?OEZtZytCbTBTMmJZWmFrTXpWME9kZUxHVTVSclgrS1MyUGRURkk5MmVzVGZY?=
 =?utf-8?B?eFNxc2RONytibldlcC83ZzVwbUJselV5WENKRHFUQnBPRjhtNzlaeG5ROFpG?=
 =?utf-8?B?ZEFIb0dmRWczM2hIVm1zM21ubVBub1FOWkU0MHpjMGdtd1NyWFhGQ1J4T01Y?=
 =?utf-8?B?UklHZXgzTzl0THQ1UkE0dzgyWlk0UEkzb1RFYWJrbzZ0RnJ6bmRxVHZ5eWk4?=
 =?utf-8?B?VFhoWjdBL0lWbE0vYnFrMEpBcDVQRE5TQWQvdjNRNVJOaEVKMDVLZGVQazhV?=
 =?utf-8?B?OG1UQTBweGkwb3BoeS9iTGdPQ08wRFVzZ05ESVRCSHA0Y2xGb1UzY3IwY1l2?=
 =?utf-8?B?ZVl5Vk5OMFFPWXJ5U1QvZWlKOUJnWE0veUsrMDhqRy9oWW1YY2NMK1VvbDRC?=
 =?utf-8?B?ZThIQngyMXNKa3NKK3Myd2lYWkNzaGQ0bWozOVhMbHdVVlI0dDBZWWZiWVE2?=
 =?utf-8?B?dFNLbkJxNXNHcHVIODdEeER0TUtuekdIcVFmYWZjOUpsQStiaTd6ZzdLWFFB?=
 =?utf-8?B?Vkl1cTF1M3VMbnFMVmljVmZaMHhueW85SWJtb1hvNWdSelh1c2kzckU0VDVm?=
 =?utf-8?B?TXA5SjVWTnN1OEs1MWlkOWNYdFQ4MTZ4QnZxeGNEZlNXbVd1cHBkWGU3c0Ur?=
 =?utf-8?B?WHp6OWloY2tnYXV3M1paUVRGaEpCclV2bXIzYytlbTQ3OG1YV2RMWElkV1Mz?=
 =?utf-8?B?ZFdCMmZkNUg3V3Y3WHZHODRvV2xyNk1Hc0pVWEQvd2VWWDNucW8vVit2ZGVa?=
 =?utf-8?B?WmpsVzRJZnJPOHllM1l4aE9HanZGWFp6Q1FKMlQyRDUrckxDUzA2VnFEL3Bk?=
 =?utf-8?B?VkVKV3d3QjVUekc5ckl5eHlXZDBKY1ZyTTViYmVQaFZXcWU3Y2RWVjVMKy92?=
 =?utf-8?B?cGRVdktGSWpWeGZIR21sVVFaa2o0RkVFWTROeElaUUdicFoyTzlqaEZBWlkw?=
 =?utf-8?B?Y1hqMWNsMTUxNTI5c1FZeDI1OHNDanUzYkZ3LzZrY2lUNEJDaGZTdmIrZ01r?=
 =?utf-8?B?b1J2SS9OS1RybUgxNDZHWFh2YStIbk1jWWhtaUxSTlZ0REFoenc4bE4ybnBE?=
 =?utf-8?B?SHVKcWVrc2Fnb1BHdFRsaEh6bm43WDhZY25vU2ZPd2Nkc3prVVVHM2FTaS9I?=
 =?utf-8?B?SXV3QkdnZFdDMG8wQ0RMaGpZSldNbjFIL05yZ2NIamkxb2lFcmdoL1ZOZ2Yy?=
 =?utf-8?B?cUV1Wk5Cajl1T2pqQVNxZ212eW5ZcG8rdVRKWFVJaURlQ0g0VVZxUVhvc2Fj?=
 =?utf-8?B?cjA0NW5xckxtVlZvRTVGeTQrQituNEdJNktiNUxZUnFSZWJPTXRhcktaNGd6?=
 =?utf-8?B?aXptWnQ4cGNab2tOWEVoQUJ5cENqUFhkRm5qdVAxM1JmdGZidU5lM2Y3Zkp6?=
 =?utf-8?B?SmhGS0JqSys4Wm1xTWlSQ21kYzhvMjRXd0JBeFIvM3NoVHYrbkROeFhMU3ZE?=
 =?utf-8?B?cW5MWTltRnh1TFUwYUZYTHRCZ1ZlRHBKZlpQQjdHdCtHNXZ5elVXZEdWNmhi?=
 =?utf-8?B?dGVFREFrdVB4UkhiWWJvS0U3VFpuM0VQME4yRVhiV0xRWWpuVWE1THVOV3Jo?=
 =?utf-8?B?SWg1NGhXMFNnNXJnUUtLUEZ0R0N5dTRWS3B5dkxSdEMzNHpKVU9XRG0wdjhD?=
 =?utf-8?Q?z2qDums0BtJQqDfJWc0BM7jxgLQ4FzN9g5sfBatamzgl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a73a87-429c-4c6d-c357-08dd5d6ced26
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 11:40:57.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etxEBflhmFxRCzxE3er1DKJWIOANnR2jmNXcGqI98XtEdtaOrHA7Ei4QPu2AtykWNFEI4y5m2i6DKAN6YvMwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

Hi Juri,

On 06/03/2025 14:10, Juri Lelli wrote:
> Hello!
> 
> Jon reported [1] a suspend regression on a Tegra board configured to
> boot with isolcpus and bisected it to commit 53916d5fd3c0
> ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> 
> Root cause analysis pointed out that we are currently failing to
> correctly clear and restore bandwidth accounting on root domains after
> changes that initiate from partition_sched_domains(), as it is the case
> for suspend operations on that board.
> 
> This is v2 [2] of the proposed approach to fix the issue. With respect
> to v1, the following implements the approach by:
> 
> - 01: filter out DEADLINE special tasks
> - 02: preparatory wrappers to be able to grab sched_domains_mutex on
>        UP (remove !SMP wrappers - Waiman)
> - 03: generalize unique visiting of root domains so that we can
>        re-use the mechanism elsewhere
> - 04: the bulk of the approach, clean and rebuild after changes
> - 05: clean up a now redundant call
> - 06: remove partition_and_rebuild_sched_domains() (Waiman)
> - 07: stop exposing partition_sched_domains_locked (Waiman)
> 
> Please test and review. The set is also available at


Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


