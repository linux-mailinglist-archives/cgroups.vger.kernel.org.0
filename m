Return-Path: <cgroups+bounces-13141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BDD185FF
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6382830402F8
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A038A71E;
	Tue, 13 Jan 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BBQef9Wz"
X-Original-To: cgroups@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD938BDCA;
	Tue, 13 Jan 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302322; cv=fail; b=bG7PpEXRSWs8GNHN6q1EPT4Qewt3gryxgk229U/Ct+9sGBPN80sNehN3ebVBmO/PIj6qFot/kPgO6rfi1VM/5HAoQFVuEKFO4GBibMk0Na0Svo2tUZtxFA8cHVWi5JljX2ZZqSxE4pJsO6A+sO6x9tohh6JB5WyO3K1/zHo9mWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302322; c=relaxed/simple;
	bh=9FJIOyACTxNsa/BnCviFihI5xEUoBro5PM5Jej+ilow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GsIHEeNcdeJ2DZjuDAWVeRwtRCSMdz56TAi3IaPy81q020q1U0wgiJLCF/GY2GD0yRYT1ExgdaLcwxo6z4SaeUhg0CaXeb2wAUA0OBjl81qGn/58chqAQh2ghIssdC6+OtxsnOJXA7zQpn7K2IIRQ64Jax3NM1Q82My2k5EryKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BBQef9Wz; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4wgGcGAwCawpV1VWQRt4n9p1AeviFM7fz4lbsfKVPSJG3QbilWAzEXY6xMhzrHAMKflXnnmb8AXU3+v0fPSzFQgJwr1Nc0RiwfpL5w0VLCF9KvSCkha1KpVFbSYpdHCJTb1jF1pSAg3UXA4AUHdvaaxSdedxy6TEoBcKd+WpGp3PxcjkdnAH43soMYlIXwYGtiuT68fFEdW9mLdNSurUJ/iSaKdbf2wBmmxdM69wzjyrzPn723n1N65kec+vpG3alpjQMrVXr61UXNkZnKyXAeeD3f6oEgjx6JS8jWk8P6cDI8fcR3/F9MOrLEAA4oJIAW5fJP99+ZTjHlt5ua7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTPP6pWXYUVab2HOGDmsSNnr01zS996nYrIFDuwhzs8=;
 b=Jln5wVeX4Yyo48pA1kP9luz6IjphHPkwx8FoO+/lu33ldzrAy6RpLIIBg42wf89pPNUo53k5lUrHaGVhcO5C9PzyiCnk0CVZvEJqyKH0bULNFHEzXF9XFdKXrHT2m5mI69VqXf0l6oodstLpiFHeJpTt/VmgH6SdA2L68luQR3dVdnAbqdQajhQUyzl5gXZFTkTb01Mu13afmslS4vE76pslF+tzjb/QqXTXI9z0PedIp6iFsxV8m/uGIHHlPPCh0xENddse+hf83QibQ18WMQthCp3h5DI0oDy+xR9p1jWGcua/Vy/lKK+e8SOtU7VNAaVW7TpB0GgfysVfVn9+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTPP6pWXYUVab2HOGDmsSNnr01zS996nYrIFDuwhzs8=;
 b=BBQef9Wz6q0j4mW2D/yATH8lXInzM5cTNHwXhrWKu/7o7p0IPDLqtHzHjTomw6GWy25QDva+EPoWuoLK/Q9X8mS3kQpMNQwsObCl9g+H+okh8CGtEYjX30eVmJC3G6m4fbfrifiI21LY0gbYRwBgWMOpPzVSbvezXpid2j9uwNs=
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 11:05:14 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::c2) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 11:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 11:05:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 05:05:14 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 05:05:13 -0600
Received: from [10.136.46.14] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 13 Jan 2026 05:05:08 -0600
Message-ID: <ef8d8e46-06eb-46c1-9402-d292c2eb51f9@amd.com>
Date: Tue, 13 Jan 2026 16:35:02 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
To: Pierre Gondois <pierre.gondois@arm.com>, Peter Zijlstra
	<peterz@infradead.org>, <tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
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
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: dd563a29-9421-4513-2cb9-08de5293a0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2ZQTUdQelZ6ZUl2YmZyU2J1WG1BVVk4cHUwNGV1OHVnZi9BSzRpdHgvZmxi?=
 =?utf-8?B?RnZ6eUQzeFZUU1Nib2w0QURzcTlLQTF2a3hzT2VNZWV4b2RuM0RpeXhsSkNF?=
 =?utf-8?B?MVYvdndNNDQyOWpBZ3RGR2VCRklWQXpJYUxkQVJXNkxhcERZazAzTDc1bHNH?=
 =?utf-8?B?RlQzSHFYVDI1WVNraG9JRVVTak5aMm55Vm5XVWZyM21zMTI5VzlFYmd4Q0Y5?=
 =?utf-8?B?K2NUYms1eDlQWDhwbzU2MHBvTm83dWhseWRVN1ZNMHlSa2I5NGV1ck9XNVE2?=
 =?utf-8?B?Vm9uSHZyOU9sNHdOTmd5d2VHbDB5OEZzSVFWTGl6dUVqeDFGVVhsU25rRFNs?=
 =?utf-8?B?L1JXQ2V0a0xseXMwZWxXZXhLbmh5RHdmUDg2TGVLZlpQT3ByK09UcWVXSzBq?=
 =?utf-8?B?eHM5RGpUTFlDSWtVM3dGaDRaeTBVM2NiK0l6R2dURnNvS3p5bERLTDkrMk43?=
 =?utf-8?B?L2tnajJySnVsZHIxb2dzOWtDbG02UUhCWnJ6cEJhWkFZd2pLMFZyZU8xZFNV?=
 =?utf-8?B?WkpmU3dNZ0xXS0Nna1RLa1FsV3J2MmczdzJJQVB4MlFWV2JTaklQQms4NFZs?=
 =?utf-8?B?NlhQSGNyRnJZODhQalZPRENHbVB6cnJPNkU4NTQ1RytCdUVSRUpKbHpENWVw?=
 =?utf-8?B?cnJyeGI0Z1FGZ0NWK3B1QVdrUXpwbFVlZDd2UWZkdHZtN3p6d205N0N0Z1M5?=
 =?utf-8?B?emprZDRUQXdhSE0yekkwN1Q1UzNjOWU4TUZ2U0Y0Q1crTGE0TEVaQWZCUXdW?=
 =?utf-8?B?a1BhWGZlczQ4VnQ5TkM2VzZLeDJXRnl6MXk5MHEyYTVHcEVQdE52aHpRV3U2?=
 =?utf-8?B?OGZwajcxWXNucmpNaTEyaEFwQm5uZGhvWU00MFE4eEwrOG1BSktBOC9GaUlT?=
 =?utf-8?B?Qk9WblJuSFpIMjNubzNpUWRmV1pzYmZVbmUvRnJmR3ozUXBQSGdoNE0yVERm?=
 =?utf-8?B?WUYwMEQySDRSV29RWjUvQThSYlBBNEdwSHdvdzZUZUw1Vy8vTkVHZjNXZm40?=
 =?utf-8?B?VW5pMW82dk9IYjA3anQyS2RKNTRTZzBhaENNdmM5Y3o5RDQrbEprMWxOSFVW?=
 =?utf-8?B?R1RGSXJXbDkxK2FORXhna1ZVK2lVSGRPUDV3alhRUW00OW9mcFZGZHJvaWYv?=
 =?utf-8?B?dHFIZk9ENjIwRjFEUjFtU2hZbGJ2aiszVEpPVURLWTdBNDExd2phQXJBbDF3?=
 =?utf-8?B?Y1pzdEVzdVlKUlVFUlVjR2h2b3pjQkZ1emZEN0lBVWxqRStGMm5yZndXSWtU?=
 =?utf-8?B?R2F3eVpRRTVxaDF0c0FtTlEwaDUrOEh0aEJ3RXhFMnkvdHZsZEFJc2NaamNr?=
 =?utf-8?B?K0dUZk1Hb2VVdURwSUFZQUx4eVdRYzVWYk5SNjJNakt4Y2hMeU9WU2lxclN1?=
 =?utf-8?B?bVNPUDR3cnQ2MTlnTGMrZXRGT1VtT2JmWVZHSXgvUFdONTRSaGl6VDRHQVBa?=
 =?utf-8?B?by9hZWQyUWUyWEhPZVNFR0lJYUk3cDRzVkZCeDdYeEpBUmwwSFpBNEJKeUNt?=
 =?utf-8?B?MGxWcFdYaUdjUm5ZZW5iTXFFY2dJWFVIMHhoNklzVG1Ja0p2MWJBVkljODJy?=
 =?utf-8?B?ZmltNmRRV3N2Uit2SmswV0FOWUpKR1VqOTdyd1dwWjNOUUd4VUswUUMxclQw?=
 =?utf-8?B?bHZ5MEgzRHpIQ2p3L0Nzc0RxSGZrc011SHVPSVRQMzFWbDFTWXJIN3B4bHRp?=
 =?utf-8?B?MTR3OCt6d3hnZi9uVlEvTWlTdFJFcEZ3SUJjbFdyZ2xnTDRtUU55YTBWVXB6?=
 =?utf-8?B?ZCtncEV0ZHhLQlk0U3RpaHBna3Y1NGg2bDQrQUxsM09oQTBUMkpHamFTcnFW?=
 =?utf-8?B?TVBldGZTYndWTXVkbHpoWWtEZVFFRVVKakxYVkVlY3N0UjdMQVorN2t0cUJ6?=
 =?utf-8?B?ZE1OOEZHZWdHN1dhS2gwNkwwQnlDN3dQMWR4THIxLzMvamFCZVVxbTdGLzA2?=
 =?utf-8?B?QXBzVE9lbXpyelJkNEQ5Mlh2T3ZSMVFHdDRHU0lUQ0Q4YWxqcnpTSU1BZHp3?=
 =?utf-8?B?VDVKQmdGV1Q3NSs3SFFoNmFsSkN2ZS9CQzFrV2lUQlVWaDcxc1Qya1hSYzRy?=
 =?utf-8?B?dDd0K2hIZjVOTnJTNkFtenVKeGZ4eFdDeHVnbE02WitHRnp4SFFSTHRSN1FR?=
 =?utf-8?Q?ngbo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:05:14.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd563a29-9421-4513-2cb9-08de5293a0be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281

Hello Pierre,

On 1/13/2026 4:15 PM, Pierre Gondois wrote:
> Hello Prateek,
> 
> On 1/13/26 05:12, K Prateek Nayak wrote:
>> Hello Pierre,
>>
>> On 1/13/2026 2:14 AM, Pierre Gondois wrote:
>>> Hello Peter,
>>>
>>> It seems this patch:
>>> 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change pattern")
>>> is triggering the following warning:
>>> rq_pin_lock()
>>> \-WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
>> Can you check if the following solution helps your case too:
>> https://lore.kernel.org/all/20260106104113.GX3707891@noisy.programming.kicks-ass.net/
>>
> I can still see the issue.
> It seems the task deadline is also updated in:
> sched_change_end()
> \-enqueue_task_dl()
>   \-enqueue_dl_entity()
>     \-setup_new_dl_entity()
>       \-replenish_dl_new_period()
> if the task's period finished.

Ah! Got it. Thank you for testing the fix.

I'm curious, why is setup_new_dl_entity() doing an
update_rq_clock()? That can advance the rq->clock and make it look like
we need a replenish.

Does enabling WARN_DOUBLE_CLOCK warn of a double clock update before
hitting this warning?

> 
> So in sched_change_end(), the task priority (i.e. p->dl.deadline) is updated.
> This results in having an old_deadline earlier than the new p->dl.deadline.
> Thus the rq->balance_callback:
> 
> prio_changed_dl() {
> ...
> if (dl_time_before(old_deadline, p->dl.deadline))
>   deadline_queue_pull_task(rq);
> ...
> }
> 

Thank you for your analysis.

-- 
Thanks and Regards,
Prateek


