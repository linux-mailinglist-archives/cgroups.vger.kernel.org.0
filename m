Return-Path: <cgroups+bounces-7301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010EA793C4
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CCE16202F
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105519E826;
	Wed,  2 Apr 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bbnm6R76"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663519F419;
	Wed,  2 Apr 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614615; cv=fail; b=fNOmd0KxCIARDsSX7S0Nns+F7KQHljwi9Qu9kdL+sKZ3unnsu/bs+O5Zl2HpMYqu4ui1luu07SYe6u9gY5MC7ag9b++YilO+cPXcFfa+vhyorY0aYiNYUYLyXrq7aLi9EfgUe5B28XALfv9kLcaY/p+GZ/zqnUn5iI9liOFYH9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614615; c=relaxed/simple;
	bh=ZxDBfhqCOoAj52gfG21WmvFtJX5agFY7/yEXTWf7ZcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mUFD2OedxLFj7obqFjk+IgeIAYWy+6Udr6IbBeEgFKuDZ580NrUYEUH9WY21pM10f0lccE/X/DJbqKYxoUQyoVI1dVBKDGB1Gq48BDXds1ARYnbgSUrbqHKmtDRuGTY5t8ckCy1HyPqsdHBPLFtuKAgDI9c+9iOmh1c6VwCV+Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bbnm6R76; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3xRo6D+QqxNHFY4e2eL1hE9zSBSGdhrD1QJnAIQAsA2Pv3lESOXtU27BMtX/Vlk0IIkNf+le4c5g7vdlYNePYXWRvIq6tnUQMkOlVVheJiU71NY8Oy01W4QIx/kl2dlDljKj1f+cZS3AI6BSUEpd+/ijBKQfFuaucQfbZqS0ZpIEj7eIbDMa2HF+WzT6hxa8ctJmcNZVUUtGG5xOII0d10s5nRm2z/NWWPkx7zRgzbkIL3EbxE8W+6OeU5wkOOosEs9SZwFHIMA610TB+ztsWdGwAZvDVxK36ttVbfWWlAS+OjVLoXPZR5A2/TXfp5lXunPp1gTJDYrW+URwhG99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2achqMgeT74HNb90uS36R4Y2VBK8rRgFSGObt1U5+4=;
 b=VD7abZExFMUQWODBrM5z90mVremmtMy4OEB3h92NgLId8au2njGF2bRBbOGWCz64mm0pp1mKJH/AJJU/pP2pMs5oYYjQva8nPvVpVjvIdTwS1OdxkINdpXkklkvKVxJcpoDM8Lijelc/CpkdyAZaAmffH+ey9ZiNqyZl2U1vRBBnifRpkSlTKShKSR9mfgAzR/qeG+6Z/e+JXQxMCG8/rR97iN0/epWnWEgKs03N+Vpp0rQZs/4CJf1jLC5REbZq2tj9Mq1rQtreIVLs26R1PBDiYpPa16+1IsaMGEWTtnK4VQ9+OpkjuFwUsd1WRLzLsccTyYndFw0zdX6SO4iK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2achqMgeT74HNb90uS36R4Y2VBK8rRgFSGObt1U5+4=;
 b=bbnm6R76cNaZH3yZahyNCyNAMHWIC4DTtoMNAl0SSGjIiDgpkXvZKR20CReGBd0do1/uXG+zdqRQBHiIF+Pm3utMj7nIgowaSFOb7YhRh3yCXRosm2b1lflAGKqbs5K9AYzvNpL8aTNNkDt2pMyzi8k/J5SefG8IaCQXYWqJxuc=
Received: from BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::18)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 17:23:30 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:5b5:cafe::a2) by BL1P221CA0034.outlook.office365.com
 (2603:10b6:208:5b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 17:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.2 via Frontend Transport; Wed, 2 Apr 2025 17:23:29 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 12:23:23 -0500
Message-ID: <57f5803b-11e5-4b91-a4c3-9be191fbf8d3@amd.com>
Date: Wed, 2 Apr 2025 22:53:21 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: <20250402010611.3204674-1-yu.c.chen@intel.com>, Chen Yu
	<yu.c.chen@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
	"Tim Chen" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Rik van
 Riel <riel@surriel.com>, Raghavendra K T <raghavendra.kt@amd.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Xunlei Pang <xlpang@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, Chen Yu <yu.chen.surf@foxmail.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <3ba327b9-3020-4a63-9623-e6eea0120056@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3ba327b9-3020-4a63-9623-e6eea0120056@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 576394aa-46a7-4af8-618c-08dd720b1602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3htdncwc25RanpxeEZpelJxQlU1dVVvMytXNnBSUEF6YjRHQVByQ1pDNE5y?=
 =?utf-8?B?OXZwd1VXYktHUnd2ZG5hMUxXRlR4eU9YZ2dRRCszUjZkS2JlYmZvdUR0L1hn?=
 =?utf-8?B?OFZiZTRvZmc5cjBlRmFLdFE3SmxQeTY4SS9pRzZRSlF5U3VvRTAxVWtpMWEw?=
 =?utf-8?B?TnIrYStUb3NqYlRMTEV0ZDk4dVk3NDdiYzlkUDUrbGgxaHhRRUJOSElWbHBm?=
 =?utf-8?B?c0Q4dGV0bmc5NkZwYTN5WWlyc1VBRmVTTEUxNi9MRSthUGluK0t4RVlwVDJs?=
 =?utf-8?B?QU5PdEVkUkdScGN0d05MREk2VDdMTEt5ekhJNHpJZFUyQUk0a0Y4eHVaNElB?=
 =?utf-8?B?aWVKU2l5WG1DZ1dLZzdVTTNScnllZk5VcXdTdjBkMTFtZ0RmbjlSYmViVGt1?=
 =?utf-8?B?R29CQlI1WVZGcWN2N1h6SnQ4UE5NUkdMUnQ4VU1YMlRWVm1TR1lqYk9iOXJo?=
 =?utf-8?B?TGJ5dHV5eU14SlB5TWtMRnZndnY3dmxSRk42MnpzSUZTbk5KYXVxQzFDdVRB?=
 =?utf-8?B?M2krWTIzOEN1elFjS2kzYlVCRHRSMjJyT1Z4a1MxcDFzU2g0ZWhTNWFEMnE2?=
 =?utf-8?B?SUtsN1cwenNFQ2hkdUp4VmsvY2hTSzBtMlFBYm02SjVIcVNOa3dxV1JyR0R0?=
 =?utf-8?B?UnlaZDJKZjFFaTd6dU1JT2VnejBNVUp5UklJYkpnWXhERUFOKzJ6QzE4ckZs?=
 =?utf-8?B?QVpaOThDSTBSU1U0R2x1L2FjelBhTDFGcnRwb3QrcmttNXFzbHlpcFdCWnRL?=
 =?utf-8?B?YlBJUWxlcHIxWkJZYTVSUkJHOXhyNXlMT1piaG5RUzFVb0pmeTV2NDY2WlJt?=
 =?utf-8?B?NnhyRHJ5NFdqSGJsb212WldZRHlDZ3ZlM0FFeEVMZzhWZFU1TndNck5mOEl0?=
 =?utf-8?B?Z3R5Z21hTXU5bTExdm4vRVAzNUx5ZHQ1YXF0LzNjSjFNOVF6Z2FKcGtjQVEw?=
 =?utf-8?B?Mmx6ZVNUQzJjOFlCbS9MbnBoeHlCeXpYOGtLbEIwNmlMVXZSRHhRNlpCNWVQ?=
 =?utf-8?B?MWs4MHhqZzhObkV2QTk2RS94S0xwSkdVUTJHZitCcEVoUFBKTXhwL05kaitt?=
 =?utf-8?B?eHhRckRTODZ1U1ozTzhQTmZ5d2RhM2NxZkVxNXVaR3FOcjRLNUdtZ1hOWnU2?=
 =?utf-8?B?Q1pya0xGSzhqam9MaDhMVERVQ0VGaVNsUGMrT3JtWldxZnJhb0pGTXZ1bUVL?=
 =?utf-8?B?Rk5MTXNCT3NmZ0VxTlRpQzExN3dzZFl6TUVWdzlONHUrL3B1d3JFNXdkelBN?=
 =?utf-8?B?YnpreFBIWXRiWTZsZXlCV0t4Uit2OGVFK2RaNHlXK2R1Snk3aGxzNldpcUx4?=
 =?utf-8?B?RitEN2xTdUVET2xtQWdrRjM3OCtpcmdPVkJLdlZZUVB3dVdHUVV1dHFDTm5j?=
 =?utf-8?B?aDVTdFIrVkdEYmFoR0I4SjhJQVhQOUpOVHcxc0dER0o2dUgyNFNxb2J3OUNq?=
 =?utf-8?B?UmRSYXFRWGVLcVNIRjlSVGRvWHRzNHpzb3prcTZwVEV5RVZpWHByM2tiTnlr?=
 =?utf-8?B?bVlhMW5SMDlMV3dMZGNPWGprclhkODJwQVZGWTBwankvODg5ek5BbC9iaHdk?=
 =?utf-8?B?Ti81UGh0L3NOeEJBTFZZYTM3cXZVbko2WEMvNWdMOWtHNWdkaXhaTm1jckNz?=
 =?utf-8?B?d1pGcmI0VncyZGMvWVlqL29ZRHNkcUk0dkZacnJiajBSTEkwRzVrdFpsWGt6?=
 =?utf-8?B?R2dEVmt0UlBSVHZsWWtzQzFrRmJvZEl4cExEaTNzMzI0bDBQNjYyd1RjZjY3?=
 =?utf-8?B?OVdUMzltQ3R1TFNJS1NDdW5rR0FNamtYdnpHaHNqQ2RQb3R6RFZNdzRBNzlU?=
 =?utf-8?B?UnB1SllKS1Y2U1BVZ1VVdzFWMkFBa1ZWUWVtQXdPdllZTVpYeTZXMERDN3E1?=
 =?utf-8?B?MGdKNTRQSmcvZ09EWjhaWHZ0M254TVgvbEEyeGMwQzl3MzU5MFNmLzJtWTha?=
 =?utf-8?B?R3FQSllUZU5senVkeU9Gd2gxNHVUL00yQ0tlVzRkWGlXNHEyRGRHMmt6ekpP?=
 =?utf-8?Q?+QsLYhoi2iUqsL4StnbSuOLwuGhevc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:23:29.5512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576394aa-46a7-4af8-618c-08dd720b1602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

On 4/2/2025 7:03 PM, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 02/04/25 06:36, Chen Yu wrote:
>> On system with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful. NUMA balancing
>> has two mechanisms for task migration: one is to migrate the task to
>> an idle CPU in its preferred node, the other is to swap tasks on
>> different nodes if they are on each other's preferred node.
>>
>> The kernel already has NUMA page migration statistics in
>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched.
>> but does not have statistics for task migration/swap.
>> Add the task migration and swap count accordingly.
>>
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be displayed in both
>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
> 
> I applied this patch, but I still don't see the two new fields
> in /proc/{PID}/sched.
> 
> Am I missing any additional steps?

You also need to enable schedstats:

echo 1 > /proc/sys/kernel/sched_schedstats

After that it should be visible:

$ cat /proc/4030/sched
sched-messaging (4030, #threads: 641)
-------------------------------------------------------------------
se.exec_start                                :        283818.948537

...

nr_forced_migrations                         :                    0
numa_task_migrated                           :                    0
numa_task_swapped                            :                    0
nr_wakeups                                   :                    0

...

-- 
Thanks and Regards,
Prateek

> 
> Thanks,
> Madadi Vineeth Reddy
> 
>>
>> Previous RFC version can be found here:
>> https://lore.kernel.org/lkml/1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com/
>>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>> RFC->v1: Rename the nr_numa_task_migrated to
>>           numa_task_migrated, and nr_numa_task_swapped
>>           numa_task_swapped in /proc/{PID}/sched,
>>           so both cgroup's memory.stat and task's
>>           sched have the same field name.
>> ---
>>   include/linux/sched.h         |  4 ++++
>>   include/linux/vm_event_item.h |  2 ++
>>   kernel/sched/core.c           | 10 ++++++++--
>>   kernel/sched/debug.c          |  4 ++++
>>   mm/memcontrol.c               |  2 ++
>>   mm/vmstat.c                   |  2 ++
>>   6 files changed, 22 insertions(+), 2 deletions(-)
> 
> 



