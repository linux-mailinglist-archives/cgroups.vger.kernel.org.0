Return-Path: <cgroups+bounces-13168-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC715D1CB64
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 07:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486C73005497
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83136C599;
	Wed, 14 Jan 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="duuVDALo"
X-Original-To: cgroups@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5D30EF7D;
	Wed, 14 Jan 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373257; cv=fail; b=l2fVaG/nqUXze82gfoQyw7VLuUB9gW5/earO3uXvA2CnINi3Ql+18Q+ILmG9IIx1XZfOW0SVb+XK7sPEKwXzenLiOYKoU9+H+w83Qk79E1OIMgGbwzRJSNbGPYR7UxtoZVXD87IzU3K7r5Oc8WQdE9Jl9Ey6tmQ3uNPiObC98oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373257; c=relaxed/simple;
	bh=K5DfkAO9O91cYppwzjSlmnd6vi+PwSnV/sWWdn3E/30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OVggjME39EXmLe3K7ocBDBytawXRjQ5cD0QE9kendvu46Hl4b3O+e61vESNdCMHuZLdMKvvvEOd0uJWaRlV+LpkfY22ylLlyF9UZj+ab35l1HqZAR3eBJfYSU4rOQmFQu7Ri+7x6kSqIcrEMDu8BRfwyWF02dCKGMn91v+uxdgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=duuVDALo; arc=fail smtp.client-ip=40.93.194.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iikTxRcZ1/DPEe2V+IEg5BKmN+u2nnISGMbU8OTEuE+VQF1AIHGX4SmOBZDqImiUEOQc3orAOrLwHRnT5KqUdCLTHyC2q11DACXyRNTHxXvR+QR4Zg5tDv3pokK7/CAFZic6RCxdzcFW/lDAYJuh6HYsTNAu4aC6oY0BpqnTLVI5AXXl6UW/CqdhT8HsJFACZHsHP7+dy65QBzVtXKU02h5Gd3+BFRbeyTLDAGLb1Uw0lt4KBPZS91+6rfPsgAlxqpxyi3pIPqpiAL9tbDtWIrD6GHBQUXwTK3S0F5Af5r0iBnHg8ufAf8qh8sFXvSEfWDCkWkARtESuqzK0xb2P/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvCkYiexx50e0Navry2IteYzqghozLjw0C5PEs/Ytfs=;
 b=uGhGhmtGR7D5ggG176Kbnw7iYHHh7FUdbzxIOnd8cNMxiw9/JbeLqTPHvW2vFbfz9B7PtbfVe6wAPwhpu+9OGxSogNyQb/+0nhW6bEbapNedn+3rWlpTs7HyFWmEc5N4uRWOrm7hz8ANBxJuMo9imL6LFhu4ZjKdntDwVdDrXb5uaHbQCybIF2eSNg754o3fTWnCroG3XySa4dzU31IuqMnOxYE/NcyZaP5jpabf9GTFEV93SkXip54ftB32c/a+V53I2dUfMiHAqd+/EmPT3uZaSXeNweiz74wm3j3UPBnMYb9MjBJA0PvMY5lYDMUZGFHS+AA/37i6TMKBX0O4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvCkYiexx50e0Navry2IteYzqghozLjw0C5PEs/Ytfs=;
 b=duuVDALosRx3L4n3zLkHFwzBQIB4Aai2GBuRdzyvvwC/dzwVbw6h2edbe/kh9yrExvrk5JkAKnIGYGgS4LakIHI6XRAFL+qIV0jrvLxjrzp/dON72O8LQ9y2nsWTh7VMZaYQGcaLXvWCY3QfSlG4DbwcPcq32jaotW+ybOH+YsQ=
Received: from SN1PR12CA0068.namprd12.prod.outlook.com (2603:10b6:802:20::39)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 06:47:19 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::6d) by SN1PR12CA0068.outlook.office365.com
 (2603:10b6:802:20::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 06:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 06:47:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 00:47:18 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 22:47:18 -0800
Received: from [10.136.46.14] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 13 Jan 2026 22:47:12 -0800
Message-ID: <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
Date: Wed, 14 Jan 2026 12:17:11 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: Peter Zijlstra <peterz@infradead.org>, Pierre Gondois
	<pierre.gondois@arm.com>
CC: <tj@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <longman@redhat.com>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <cgroups@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <liuwenfang@honor.com>, <tglx@linutronix.de>,
	Christian Loehle <christian.loehle@arm.com>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260113114718.GA831050@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b3564e-8f31-4375-9029-08de5338c312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEZoaWZ5UGYwcTdWL3NlZlYxbHR4WmF0ekNXQTQvUXY1NXJQZzdtYkZBc2cz?=
 =?utf-8?B?cUkxcFl4dmRKaTNVcGY3U1FmSlNQUkw2Tzg4WTVNMmZxOTcwMXpVenZpRWc0?=
 =?utf-8?B?Qk1Lb2M2RDVxSlBZK2ZYQ3J6SHJuckgza3RLZ05SUWVPY1VHNEs5TW9rYmps?=
 =?utf-8?B?RHZrZFJYSk1LRlB5VXRFUmUzVlpoOGZ5MmdjMTA2YTdrVlNpaUVmOVVDUjQ2?=
 =?utf-8?B?emFyZEpYYXlJSnRyVXpIOVpPcXI1ZUJGYjhpa3loZVJUMElKK2hYMVZVV0Vu?=
 =?utf-8?B?dDhvd2ZEVEpMbzU4bDZiOHIzQTFWcVlXNjFmajNQTUYvZ01NaVVJYlZ0VGFU?=
 =?utf-8?B?Z0tNVkkrck1BZVdoSUw4ZHhJNXBwUEVBU0lKZTlpWC9kTGd1ZEpZdnVuSDJ0?=
 =?utf-8?B?OUZDYmNsQm13a2RvVTE2dkFpbk1JTVE4UTduOGV4dXVRVFBWcHU0bU9nSWhV?=
 =?utf-8?B?UjlJN3YvQ1hJTVBCRGNlc0JDdHFtUGJiWmV6aWdFZnIvN3JIb2NMWTErb0o3?=
 =?utf-8?B?TENSbE14em9LU0RucHlwemRaZkNaU09Ub0pIeUUvR3AvQzZsNUFMWlpBdHd6?=
 =?utf-8?B?RnhIWXo1MnVjOUlXWEgyZ3VOMFNjRDFjQzhCSTB5bjIzMHNDNEhCUVRmTlM3?=
 =?utf-8?B?Q2xMWGl6NFBtcEx6NlZKNDNmVE9kL3k4ZHdpdmU5Qk5VL0JrZHhJVVJsekpF?=
 =?utf-8?B?OVVkamNiKzg3L2RVdEJTcGhVRWRsS2RULzF5eGJuTVpaTGZwdC80SkhRMzNM?=
 =?utf-8?B?QjJLTFJPbVVQcnpIUGtnUnJRTDFJb1JwU0Z5b0RyWGE0b2N5VCtEM3ppbVo2?=
 =?utf-8?B?bFQvVG9aVU9ZMmlFUGxPQUlaWFFSNlJOZ3FYMzlkQ2NoMEYybFlZWjlrcU12?=
 =?utf-8?B?cFl1bmNvM0EzNW9pcUl1a1ZsWWNjTFNadnNYWUxjZHZ5VXZ6UzUzS2RYVVp3?=
 =?utf-8?B?VE5OTXRrdS8xY3UxY2xKUktzS21oREJIYm0xVlBTU0hid2dQWTAxdzFjUDQy?=
 =?utf-8?B?TzB2L2VMdnplTE5LZWk3WENxVVBBdldYV1ZGMFhaNDJ2OGljaThBeWEzYU5j?=
 =?utf-8?B?T0VSUFF0eFpFcDNUd0hOMFNyZmhhcE5CU29QNytGYXhVb0RpbUJIRXBpdmpN?=
 =?utf-8?B?MkViRmV0cWRIcU9ISzVmWWE2M2I1U2dTbmVJSzZmSWNwM09yajBoQjNDSUZB?=
 =?utf-8?B?eDFWVEdGM1g3Y1lDYmVkeXU0ait5TjVHRWJtRnBGMTV5ZU5VWFV1eXl1WE0x?=
 =?utf-8?B?ditubE81aXIyN05CYittakRMMWFuRmpvY1A4Vlc4aXhkNndiOVRMVytKb1d1?=
 =?utf-8?B?TDF0a1JRS2dTQWJLbXZieW1sNjdhUEUweGNEZUhVUWtsY2YrdDUrMGNLTmMv?=
 =?utf-8?B?UUhWdWxoMnBrU25oRmFjMVdlNEd2KzdKRllNeFpUNzV2U3MzbkFpcC84Yklo?=
 =?utf-8?B?Ty9QS1ljNUJsUGwzWnRRemo5bm9kRVZYQ3dzckZ1NzFTMTFjZGNnUjhMTGJZ?=
 =?utf-8?B?WmFVR2Rlbk9peFJ6b05WTHg5R2R0NDJRcWpPTjlDc3pONXJQbE50b3pnaXFk?=
 =?utf-8?B?QmhxSXJ6emxteVVJd2RncDhsL1dlV0Q2WEpMWVFnV1NrMmx6b2FxVWowV01W?=
 =?utf-8?B?akhRRGpEUEs2VzNtSDJJUkNFbGhOK0VRV09jQUNCRDVueGZxcmhVNWZSNDBo?=
 =?utf-8?B?NHpidWl5dVB0OG9XL2RUSXRrSjljZ0JxOUx0K2EwYjBmWVlPd3FySVFCY0lx?=
 =?utf-8?B?U0NzYTRSVmRFcU9td2x1NU5pc0NMelh1cDFWc3dZcVYrYUtBK25RNDN0Z1RI?=
 =?utf-8?B?NDIyOS9LVndYK2daRG9laFU4cDZEZ0xZeHNmME1uUXB4ck5PdTdXc1VkNDcy?=
 =?utf-8?B?R1puU29DdUJrc3ExR2NsNVliRlpadU1LOGU1VGttTGRiKzlRcDBkVFF2a1dw?=
 =?utf-8?B?Q1QvVHR0cGo1cEx2RmtzQVljc0FrVnZ3MHdUQlJxNE40ck1XZFVhTDJrWUFw?=
 =?utf-8?B?cHN1SytTdktmbW5jQjJrZE9Ia0dkOC9ZZmZIM0tjY05kaitDTEdFb1lCd3pM?=
 =?utf-8?B?WndUYmhTMzB2OUZGTXFoZTQ1QkF4T1hxblN5RWRFNUltVEtkSEx0d1NOeGZx?=
 =?utf-8?Q?GelE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 06:47:18.8510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b3564e-8f31-4375-9029-08de5338c312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395

Hello Peter,

On 1/13/2026 5:17 PM, Peter Zijlstra wrote:
> Hum... so this one is a little more tricky.
> 
> So the normal rules are that DEQUEUE_SAVE + ENQUEUE_RESTORE should be as
> invariant as possible.
> 
> But what I think happens here is that at the point of dequeue we are
> effectively ready to throttle/replenish, but we don't.
> 
> Then at enqueue, we do. The replenish changes the deadline and we're up
> a creek.

I've the following data from the scenario in which I observe
the same splat as Pierre splat wit the two fixes on top of tip:

    yes-4108    [194] d..2.    53.396872: get_prio_dl: get_prio_dl: clock(53060728757)
    yes-4108    [194] d..2.    53.396873: update_curr_dl_se: update_curr_dl_se: past throttle label
    yes-4108    [194] d..2.    53.396873: update_curr_dl_se: dl_throttled(0) dl_overrun(0) timer_queued(0) server?(0)
    yes-4108    [194] d..2.    53.396873: update_curr_dl_se: dl_se->runtime(190623) rq->dl.overloaded(0)
    yes-4108    [194] d..2.    53.396874: get_prio_dl: get_prio_dl: deadline(53060017809)

    yes-4108    [194] d..2.    53.396878: enqueue_dl_entity: ENQUEUE_RESTORE update_dl_entity
    yes-4108    [194] d..2.    53.396878: enqueue_dl_entity: setup_new_dl_entity
    yes-4108    [194] d..2.    53.396878: enqueue_dl_entity: Replenish: Old: 53060017809 dl_deadline(1000000)
    yes-4108    [194] d..2.    53.396879: enqueue_dl_entity: Replenish: New: 53061728757
    yes-4108    [194] d..2.    53.396882: prio_changed_dl.part.0: Woops! prio_changed_dl: CPU(194) clock(53060728757) overloaded(0): Task: yes(4108), Curr: yes(4108) deadline: 53060017809 -> 53061728757

get_prio_dl() sees "deadline < rq->clock" but dl_se->runtime is still
positive so update_curr_dl_se() doesn't fiddle with the deadline.

ENQUEUE_RESTORE sees "deadline" before "rq->clock" and calls
setup_new_dl_entity() which calls replenish.

sched_change_end() will call prio_changed() with the old deadline from
get_prio_dl() but enqueue advanced the deadline so we land in a
pickle.

> 
> Let me think about this for a bit...

Should prio_changed_dl() care about "dl_se->dl_deadline" having changed
within the sched_change guard since that is the attribute that can be
changed using sched_setattr() right?

-- 
Thanks and Regards,
Prateek


