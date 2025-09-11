Return-Path: <cgroups+bounces-9982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F72B52CA3
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5716C957
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AC2E7BB4;
	Thu, 11 Sep 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rcC76mMz"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51022E7659;
	Thu, 11 Sep 2025 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581595; cv=fail; b=gyoLaLd/aCcoqZo/bH/36Rl+MnDvFjVWKfB7Fl4RvZRHqHRybJVh9QXiJzN3NjxewWo4WTFDJEILGCZTZ0NxlX4brCKKEcaMv2DwXrvtCD+H8Dn96r2iVBL/YE8wtM6SCil0a5IPWQ0QxMTBzkJZFNqaz7Pf8IIqAoLPStFYDnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581595; c=relaxed/simple;
	bh=Egn4SAlQ/LMUDKL3ZqMYh0ZYW6DLclklIUCrPQQGEtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pNftQYkIpyXRDWiybEDigBdRDFkZhrgktxH/yF6XUthOoJY+XrO589Cf7Lu483yGx/6uj8Wur7wodiZwmVTbnyECn+xlFC9Qlq4JVgDUp4uAvnsSOCORIXem/HrE+D9c9hSRCFpthyxTWPW1ZabdjddYYsHwXEwcsyj68YnZaCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rcC76mMz; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIl0dwKNK+nq+pEVj7moLqkghc8CRDi8iYyPPxwlWX7n30kdXPwJ7LQjucqq8stLu9neI4EwuJ5Ggg8sUMs04wZ571yHPIdAk62OD7pO+ocuezzvBpO8U8WH7ZiaKR9rGKeQKC50Xn5W7G3VNNOpEhYgn1KfHjOmqKisFapx3KB1NZjvLBI4QgDCzZm85G83lSGgqjH2I00LGrBiQ4MgosfC2T0LmNmRvm0jhD9VGJrFcdqtkypgnLBAzSmFhIKfQ6ONaasDkXfII0CK0Nr7xyzZMThMJpJGdbaFEqms+6pwmK/m9Q7NRsQ9ZmO+9F5RB2eCNWoj4xF4zPQ8p6HdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9c3VY0S4/v6S4HxhatPgVrQg0ZCsU8ElYSYFELnSMw=;
 b=d3CrfXcl35juraOuN+PQEG/M+2KlEjetULdpmzP2947f0vJBL3E9eMPBCeLOQJjLCSYTP6lcuyN/zfKqoTtoncS1detzXJERcD5lbz2Rtu6o606b70NG5aiBa3x92bHWhpGqPbfrmmtFp8K8gx07eXi86tmSuFyvvbH9rKSY0Gm7xWcZgJjA3fxNHh8WAU9wfIgX21M6v+YzJYFwmOy+TB0xXXXm9Re0z9vihsLEjpYxtVGOkJe/gx+Q3LRHjmBZDDN3Qeejqz9RbJFtzetzTbkxw7oi7AtR6tLMvVB2B4fSKHKYu8WyIjr9eMsea4otNmstWljqPDZNW+ddiCUX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9c3VY0S4/v6S4HxhatPgVrQg0ZCsU8ElYSYFELnSMw=;
 b=rcC76mMzUqlw1jwXyrr41LO8zG2uKTgPEFdqhfdkGkDLPMbWrG//qTM3r0LOOOPAGaZGtLUJIbGqSyMAC1slsZiNcW9ZNlW96b7IsHcCepJ+A/7jXZjVmzJ+LN+LIuSSJ+nQ3h+rjX6m6XqKfXbQtODLQ+58xcUeGB24nWpZeR0=
Received: from SJ0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:2c0::10)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 09:06:29 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ee) by SJ0PR13CA0005.outlook.office365.com
 (2603:10b6:a03:2c0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Thu,
 11 Sep 2025 09:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 09:06:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 02:06:29 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 02:06:28 -0700
Received: from [172.31.178.191] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 02:06:22 -0700
Message-ID: <c4955d95-8d23-49da-9214-da481f28f797@amd.com>
Date: Thu, 11 Sep 2025 14:36:21 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] sched: Employ sched_change guards
To: Peter Zijlstra <peterz@infradead.org>, <tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <longman@redhat.com>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <cgroups@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <liuwenfang@honor.com>, <tglx@linutronix.de>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.415580225@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250910155808.415580225@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: a2404602-2510-4b4e-0fb4-08ddf1127ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2lSam9vZlRtQ2dlOEJXUlE4bXFoRU14VHZPdFB3ZHdaS3h3a1ZpZnNlazgy?=
 =?utf-8?B?VjM1WWVhWEdLMjB4MXlkRDNzbGxXNDJwemgrQnFVd0ZEbTlHclhEeTFhV2xI?=
 =?utf-8?B?WFlWOUpKb2sxOGlwdUxRZXJiQXZDMmxRUEFEb1ZieitMbWNCU3ZqUkF3WUpD?=
 =?utf-8?B?OEMwK2FmMVJIM2QyTlEyMG5uMlptSy9RNk53dmNPL2xYUElSMWFBaW1WZ1Ni?=
 =?utf-8?B?R3gva1UxSS9SK1d4YU45bnlVQW5iSjBwNjlPT01KdVNxMXFoeGRSWFl2dmNG?=
 =?utf-8?B?WWZnVXZaMjlWeUNCRm5sYmNBQWVlR2trdU9icmN3aDFKRTgySWw5RXBKOWRt?=
 =?utf-8?B?ZDg3N2pHQWlranhxdWxqUllVc21rSXo5QUNza2VmdkVRMkUxS1Btb1FOQ3Nv?=
 =?utf-8?B?a0tjalV4Vkp3dmVuYnNEV2lQVDFnWjhNajU2VGhHZUVGMDk4UnRqeTdzY2Vz?=
 =?utf-8?B?UEtHRmYrZ3o2Ui9memd0MVBkN0V0c2lFRmtVdmlEd1QyK05xN1RVaWFiWWNS?=
 =?utf-8?B?blF3UW1OcnY1ZnBSUmY0UHcyaThMLzZ0N2RUalFGWVA2SndVdXl4TWdaMXJJ?=
 =?utf-8?B?REs1ZXcwSG9nblROV0ZPY3BrclNKYzRBNHZmM1J2QkMySXViYyt0STB2SXk4?=
 =?utf-8?B?YXBkN1ZQU2ROQXJiT2dZK1FxdTB3WFhPSUdtNGZDSDFyYnJXVWpOaERxL3Fx?=
 =?utf-8?B?WUp1WERLU0tleWJtT09GM0w3cjVtMDJCMlBLTXBYTzRNczJJYktuMklBaEVE?=
 =?utf-8?B?UWhsMXdJMWgyNEtrNUVuTldpWTlVUmVyS2pjbjF4cFptT05LL0hvRmJsR3BJ?=
 =?utf-8?B?MEZGQXR0ZWlCN0RGUnVVMmhUYVpIZXMyVDdzK3RGQUpkaVdJQzdqeWZjYW9K?=
 =?utf-8?B?cFh4RkxWckN2c2xsQ0FrOFhlTlVIUXZvcFh5L1A2WjRyazE1V1BwU0VyZnJu?=
 =?utf-8?B?RlluUVhaU0ZVcXh3MDhTNzJTZ2Z1d3VzT0haZm1RT1greTN6OXBSTHVCZlZR?=
 =?utf-8?B?Vm1WUHRQOE1kQmZYaXpnYW16YXpaekdmTUVOR0VWTUI2eHc4b2c5V1BJekpp?=
 =?utf-8?B?SWM0RWFTYUlCYVFBbVZBM3lXa3YwNU5NTTRvemFvU3pTVTZ4RkRTSHdBQUpu?=
 =?utf-8?B?b1JRZGowaXpuZ2JBWEtIY01rOUVJMEhvWjNDRDI1Z1UxVkRsTzRvSHVxSTln?=
 =?utf-8?B?NGIydHZ6MVYxMUpXeXk4T3RUbG1xbTV1ZzVjUWR5b24wcWdkQlZUVWRxcDl5?=
 =?utf-8?B?R0kveldDd3hKclBHWXd2aCtvVXpBK1VQOTJGY0pFN1RIRWVwQW9YUVF5dnc4?=
 =?utf-8?B?VmlEWGU5WVlmVFBRZXZLcDJzcWN6ZmVFbGVxUTZKbmZySGJDcWg3YkVDTXZm?=
 =?utf-8?B?VTQyR0NDUEN0VGhaOXBnV0ZVdi96V0xIN2VCZGNJNWdxMXM5U3hBWHYzSkJh?=
 =?utf-8?B?SHFWR1U1cmVEa0VzQWhFQXd6TFkxVm5WWnJsYnorVFhNVzFXTk44a0V2Y3Uz?=
 =?utf-8?B?SlhkelN6Zzc2Sm5aRmN5NEpDSXNRZVpML2RVN3ZRK25IWnNuRnhuMlJhTEZy?=
 =?utf-8?B?ckNVSmdoSnVuamlpRXozaHBSbk1MK0M3aWNOaUErL1p1bml1Q2xDblVrK0pu?=
 =?utf-8?B?UWdBZGpxT1J6OWdDZU52OS9YTWQ5Z1Fxc2hiRThFUzlCUEdoOXhtYkR0ZU9r?=
 =?utf-8?B?YnRCaTlhZFdxTFY3Q2ZwNkZtSURBcWwrMmxDWTFRdk5kWmR6SE94cEQrTUEw?=
 =?utf-8?B?U0tQYUVjMlpIRlVuMTdveDloNjY4dHpSdG9ZYnFVZWQyY2hpcHNZNERDZVhl?=
 =?utf-8?B?aWNVd1M4TnhncmFScnR6YmxNMm83R0duNmg5OGkyRmZZNW9vVmpDTUxlTUNw?=
 =?utf-8?B?QzdoeGFCYkRhMFBjalRYZGVZaURrYUZsckFyRkhtTmxPQzRsblVDek9YWXB6?=
 =?utf-8?B?ZzNaRFFOQXFqYzhrQjd5WmppWUV2TXduMHRjVGtYNDFJajR3aWxSbVNRazdC?=
 =?utf-8?B?VWNncGxsejd6NmNsRCszdzlPSXZIZmpIZitINW5XMzNIS2N3blEzVGJHOGdt?=
 =?utf-8?Q?aV8rmD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:06:29.4130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2404602-2510-4b4e-0fb4-08ddf1127ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

Hello Peter,

On 9/10/2025 9:14 PM, Peter Zijlstra wrote:
> @@ -9240,8 +9213,9 @@ static void sched_change_group(struct ta
>   */
>  void sched_move_task(struct task_struct *tsk, bool for_autogroup)
>  {
> -	int queued, running, queue_flags =
> +	unsigned int queue_flags =
>  		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;

nit.

Since we don't do a complete dequeue for delayed task in
sched_move_task(), can we get rid of that DEQUEUE_NOCLOCK and ...

> +	bool resched = false;
>  	struct rq *rq;
>  
>  	CLASS(task_rq_lock, rq_guard)(tsk);
> @@ -9249,28 +9223,12 @@ void sched_move_task(struct task_struct
>  
>  	update_rq_clock(rq);

... this clock update and instead rely on sched_change_begin() to
handle it within the guard?

>  
> -	running = task_current_donor(rq, tsk);
> -	queued = task_on_rq_queued(tsk);
> -
> -	if (queued)
> -		dequeue_task(rq, tsk, queue_flags);
> -	if (running)
> -		put_prev_task(rq, tsk);
> -
> -	sched_change_group(tsk);
> -	if (!for_autogroup)
> -		scx_cgroup_move_task(tsk);
> -
> -	if (queued)
> -		enqueue_task(rq, tsk, queue_flags);
> -	if (running) {
> -		set_next_task(rq, tsk);
> -		/*
> -		 * After changing group, the running task may have joined a
> -		 * throttled one but it's still the running task. Trigger a
> -		 * resched to make sure that task can still run.
> -		 */
> -		resched_curr(rq);
> +	scoped_guard (sched_change, tsk, queue_flags) {
> +		sched_change_group(tsk);
> +		if (!for_autogroup)
> +			scx_cgroup_move_task(tsk);
> +		if (scope->running)
> +			resched = true;
>  	}

Also, are we missing a:

	if (resched)
		resched_curr(rq);

here after the guard? I don't see anything in sched_change_end() at this
point that would trigger a resched.

>  }
-- 
Thanks and Regards,
Prateek


