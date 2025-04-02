Return-Path: <cgroups+bounces-7302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E31A793DC
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E53B42E8
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2219C54C;
	Wed,  2 Apr 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyP3mGZi"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344B1373;
	Wed,  2 Apr 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615335; cv=fail; b=pfU83pW6yOn+YcZC9C3kcNCWTJCA7CWbG0c0eL29kqQ3FVIdUzp8e8UkuhNnIIo6rrxQvJ0r/Sig+glcocSB/ghdYtAEk7ljH8rPwtVh8S6aMtfsvu6k1KHVrmVe3St8J2w9m+3OqJbeqZnlpGatcO6FhqP2RxQzHoy0HqV1v1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615335; c=relaxed/simple;
	bh=f0Bi62M9dcane4K/XMQi1ZXPvFINKymFEuI2SX+u1qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HtFGlo9yZMvPLgd8zjMGGIKekg2M1gQ+O4J81r+ZJzDlTlCV7FlRxE4ThHEqNCb3DcUdDVCBgeI4MSwoHApGIN3nTY2dsohO7slI021piakWC18smF4rqWHSiGEE0vHZm++Wt83IhG0RoW8DuMYoGvtJJZBZvUMwIeyjDAMQ+Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QyP3mGZi; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anduuUrwF4oPra0CM20YLTyK/P+y7Eosw7KKTgG+n34L41OJ/Rw5lEkHMYkKx+o0nHn6F22yjNirBWxzapULUm/RL+hWeUqRe9ShmJrg9V4bcB5Ou1FU4FrzMj/DWvC5IDn9Gb6EzKMlRJAP6wZvK16WuhSO+HLYr4VfRRsZaYcdL9OhpIz1bHt1aMmVrFpQT87CyFPII029O8I6g7R3pzYd3FFmQHJxbYC478un27vCmf2HhxMExSPHnkC9HUSkhe3gauuHKEGLXf9+s6fcOQVahaILr1xgCl/scer2gcA3tajVWdAUpo1vfBe7CcQ/ONpdqNzya3Ge5Ib4CEkmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmXY18Upu2d1wVnFSG7sxALYlzsmPYjS8PnWoV3KTjQ=;
 b=jKNHeYvD2rQe2F2tzLmLkT4i3PLzR14VmoDMC30fNYsD8VBUpXMjN4hjhz6+FbqyX8VTiZ9SXqDZP0maEvzSiy+L03LnkwRnk+Bb4Upp6NEwklUganQaMT5KarURzeqrAcOyToYmnM6PaeFfgABdZeE4RnfvQPgHNuRCdMiOMmx5TogWYFkrTWCTvCmof5syYOd1tYp2pa94dhbZ4m0IjmcEsdbZ+tH43ngpyYZBEC7vjtkz/g/x7ng/pVyQSsYqAwfZShBLG8Fm7LGfdN3GCfcXOWwpbpSyC47ADv1n5ruUAXnyoPYScCsetabr+0c2uJo/clkOoyYE+1GV4oQ+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmXY18Upu2d1wVnFSG7sxALYlzsmPYjS8PnWoV3KTjQ=;
 b=QyP3mGZiSEG13Z+lCaf5msL2/etYYwOmYoMkNW80FL7/PxzKotvmirHhpgcS2/KB1M7raM/9ZZ6WSe5Iji9lMjp3ab2CMyVjK0ITGmGcGi5ZZL2tbvVyOLBa1gMMGp1f1XgYZ/TnzhGNYVfFFQuSI6KDA7xWWoorp3MXR77+jdA=
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 17:35:30 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::5d) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 17:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 17:35:29 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 12:35:23 -0500
Message-ID: <fff4f53b-eec6-409a-840a-0e8be64fe1a2@amd.com>
Date: Wed, 2 Apr 2025 23:05:16 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	"Ingo Molnar" <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
	"Johannes Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>
CC: Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, "Rik van
 Riel" <riel@surriel.com>, Raghavendra K T <raghavendra.kt@amd.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, Xunlei Pang
	<xlpang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Chen Yu
	<yu.chen.surf@foxmail.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250402010611.3204674-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 87444780-b839-43d7-bdf4-08dd720cc2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q25tR25NL0haWDVVTU1GZ0crZnN6cHpQb3pvRDVTM3JzdzY0YzRBTENVNHRy?=
 =?utf-8?B?eU1GRlpOM1prZHptWjRYOVRiTnRnSkxKdUM3ZWd3TlF2MzBrQktEc2daLzda?=
 =?utf-8?B?eGcyb0IvVVUvNGF3c0ZlV1QydlZCdHpzVjhlL3lWV2o4dVpTcW93cFBsb1BN?=
 =?utf-8?B?WGExNUkvdUt0SWJxdDNmQWZoY2xuMVRQQktjWWZoQ2xqcUVRUjVaQUdLZm4w?=
 =?utf-8?B?MzZWTUovSjJZZlhUaEdMVlB3Z1pBSENseWxhakFmU0FiU3pRYXg0U0g4T2wx?=
 =?utf-8?B?MHd3MjRTcE9JanBZaitmcVBORVgydjd6Umd3cWVKbURDR1JkRndwUDBST1dl?=
 =?utf-8?B?TjAwTlQ2MGlQa09WbERSeExzNVhOSjBYNUNKYTQ0T0dpNk1mMGdNY09xZjZ1?=
 =?utf-8?B?VVlRdGpPc205bXl6UitFOHRvTDFIRkU2N0lURUlXS3pseDNtVW5GcXBidkxC?=
 =?utf-8?B?SDhQTGUvRTgxMGRhbHNmK0swUlo4OGx3N0dta0MvTmNuK2ZtR3hiQ3c2OVFo?=
 =?utf-8?B?Uzd3RzdLa3EyWlp5WGt3VEMvTUw5MktFZ0NqaWpucjVucm1pc2FTYUhwTEs2?=
 =?utf-8?B?RTg1NEdSc000Z0NHTlFkak4veXZIZDU1ekRIT2dUMmppZGVvMk44cW9QTU14?=
 =?utf-8?B?bm5GcDNaUVFWN0JDWG43dzJ1cDdQa21WakVJdkpyUnJYQVc5ckgxMVJ0aGpR?=
 =?utf-8?B?UVFOUmZZbHRtbmNVblMxbmV2bnJ0VU14VS9XbFFvYkEvd2p6bU4vSUxIbG94?=
 =?utf-8?B?VEtxM1U5UTNpQ0JOWWxXNkNoeFhFZk1LNVJSdXZhMWJHNVR6SytmTFNkeFFy?=
 =?utf-8?B?MnpsanJVdy9LeFYwTGQ0a055RENQeUtLZ3pCeEZQMG1lLzFRZWtWNTV2amFt?=
 =?utf-8?B?S1prVlk4STF1bmlxWEJaZmRyQjhyOXNoMzB2TVBER3V3bTRDTDZtMXJFbmM5?=
 =?utf-8?B?b0dONk4wWVN1ZzgzZ2xsMmE4Mk1UcVB0TlU0amVLNW9jZzZLbjdiOHJTSmFT?=
 =?utf-8?B?aU83c2Z5OEZkZUU0SXBDTmNJNU1Kblk4U3ErMit0dHlJTlNocG9RK0RENkxT?=
 =?utf-8?B?aEtWZHk3eUlNNThiUWlDL2VxNys4MmRRNmh2Z3graGd0QkJxWHZQeWw2dWtq?=
 =?utf-8?B?a2RQKzRoNnVCeStDaXQ5YUsvNHhiaUUrTG9DSDErd3Z5TzBCNk9kZmFibEpB?=
 =?utf-8?B?VW5wZmxlcjJiSElpdHptYmdUaERpdkNiZ3lLZkRtNHYxVE1NKzNKTTVTaThy?=
 =?utf-8?B?cnZWUTZ0U1J4VW05eHhNTlNCTVhlbk9KdU9XSGxHcmtYc0ZRZXV6ejVrMnpq?=
 =?utf-8?B?amNJUGtqS0hIT2VCdTFGdnErbURpUlhUY09NdjVwd21qd0ZWUGQyMzY0QUx0?=
 =?utf-8?B?OXpKV2ZWZFhZSEZYVnZOdlNoZGd4OGg5Z1JFUDlxckR5eHhBRy8zMEdvdUpF?=
 =?utf-8?B?ZXZYaUJyYmk0QkRrOXErclhoRzJPejIzbEFma3RmUStyeUUzOUxrT2dnMjhz?=
 =?utf-8?B?K2xwVlo5ekhjRTdObTVDUXJoaXhPc1NYWC9VeGNoY3pUTDYzbThESEs0N3F6?=
 =?utf-8?B?K2hSQUZpZjhXM21qenN0OWJvbXM5dTBnN0ZLTUw1bUhSb2ZnRDdXZkpRbVRy?=
 =?utf-8?B?b25PYnFWNmw5a2lrdUlYWUVvelFKWkJGcnFsSENBWCt3NldtYUdQU2NJaUFM?=
 =?utf-8?B?aFNENnBVMlBpVGVydnZhdHZDbFV5QVdxMk95bVZoNEZ0RjcxYkVmM2JBZENv?=
 =?utf-8?B?YzYySFlDMXhDc1JJa0Z0SDgyVlhwSVZKYzBBa1RTN1U1c080THFSNWxlNEFh?=
 =?utf-8?B?V0xBOGdoKy8wSnBMbnIwS1VLd2V1ZzUvbGNiVDZaU1FzR1RMLytydFdlVUdQ?=
 =?utf-8?B?VDZzdEE2SXl6SEpXWmxRY2trL01rRXVRaWhtWDMraXpCVHE0MHlTMVhlTXpM?=
 =?utf-8?B?eVBoYVVMNWtCTWFmcS9YeWdFWjFSRFZ4dnNvdEhWOGNLTW5URmtuUWRVWVFB?=
 =?utf-8?B?SnVDcENLd0ZGSGdkbkkwM1NVektzTDJoc3RIRDVGdWlhQmdpaXl1TDF1MVh4?=
 =?utf-8?Q?CRYo/s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:35:29.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87444780-b839-43d7-bdf4-08dd720cc2e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

Hello Chenyu,

On 4/2/2025 6:36 AM, Chen Yu wrote:
> On system with NUMA balancing enabled, it is found that tracking
> the task activities due to NUMA balancing is helpful. NUMA balancing
> has two mechanisms for task migration: one is to migrate the task to
> an idle CPU in its preferred node, the other is to swap tasks on
> different nodes if they are on each other's preferred node.
> 
> The kernel already has NUMA page migration statistics in
> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched.
> but does not have statistics for task migration/swap.
> Add the task migration and swap count accordingly.
> 
> The following two new fields:
> 
> numa_task_migrated
> numa_task_swapped
> 
> will be displayed in both
> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched

Running sched-messaging with schedstats enabled, I could see both
"numa_task_migrated" and "numa_task_swapped" being populated for the
sched-messaging threads:

$ for i in $(ls /proc/4030/task/); do grep "numa_task_migrated" /proc/$i/sched; done | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c
     400 0
     231 1
      10 2

$ for i in $(ls /proc/4030/task/); do grep "numa_task_swapped" /proc/$i/sched; done | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c
     389 0
     193 1
      47 2
      11 3
       1 4

> 
> Previous RFC version can be found here:
> https://lore.kernel.org/lkml/1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com/
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
> RFC->v1: Rename the nr_numa_task_migrated to
>           numa_task_migrated, and nr_numa_task_swapped
>           numa_task_swapped in /proc/{PID}/sched,
>           so both cgroup's memory.stat and task's
>           sched have the same field name.
>

[..snip..]

