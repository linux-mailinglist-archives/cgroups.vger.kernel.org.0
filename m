Return-Path: <cgroups+bounces-7788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2904BA9A02D
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 06:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB71C5A2F75
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 04:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1D1B4F1F;
	Thu, 24 Apr 2025 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R7LOo3xJ"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C071B0420;
	Thu, 24 Apr 2025 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469770; cv=fail; b=G1zw0fLAmBjP+7YjAEYe+UeoZwO4AOLpYpZjjYE7MMFbQdGPwc2WnsR3z/XT3P3+2vnbMc7hTexz5gICi3kdrEDoag7HNGkv0yExFl5pZ8SsjPEqlPx8NQjkJkYbD7/kynjR6j+HNA+yET50jNWNIp4lrPdx1nriF5wYfojZPxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469770; c=relaxed/simple;
	bh=uYHHPdOE5txkETjOcONJDsP7V/3V6tW7YGyaG5I9fuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=skV4auuiDoq8mo69sdAWBOLvk/Y8TlUy/23z+lgkOeHhUg3iLcOAmbdEYbDuMuCcuZimh8+XEfNZY3jQ2qDOEcgEWjmBVyaKEpvxDfZ+gnayx5LDuuK3/0b79NiZP/JMcIcNTVHnUK4r+EvzbDewYafCJMNxX7v+lbUbQ82/LeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R7LOo3xJ; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8mGwJnhTEEHOB4/BVAFUXL0kN9oGS9QFbxkiLCbKtoYYHHCnTy9zex6a0xBvVIByqlfmMrLL90zPndNSqQFlSPtFmuPrrZDMVH+SBaIGr7rTM9Km6K1+3t3SDtavrSpEaSzr5IuWVDk/Hmab2qsdDgYe56TqXh1uaGlMXCZZAgcsZexVc3wKinr7QXdYtJVVYaOQx7FxI1FV7HYBWwA/7gwABsNdMalB1bich1eQJm8mmtvzlSZAluDMTebz1Lk2um95tDw5trKeSqm9TLVzZYY6FcYlIXPPpuUVOFSC9lIvBDv29zk7qjdKxWXoZhtGtcBLX78d3uYBTN4ey2B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=facezBp/oZo7ZpupVB1fyjftxF2iCzt5Cl5P0SBzPCI=;
 b=frSfeae/dcYXLIwFQKBshDTubpvwgNFYwDeBQBpzMltmj4csto3h5+xSUHdr9Nz01k/m8Y/Xu57IskkjYOBF7TCjuFo5ACRDkweTlipLxwEwB4xh5xxs+/7k9pgrCRqD+ES+qRmsgpkCawYABM2jcDT3WXVQXUNLnJ2HLl34AuhSAKw2VjbXroHzD9zNpDRFgb3P89KdyAjs6OekMBJi4hz1gsvk4eO4ovnnFj3DU++lTPtAyWJQWMEx3+/c1GX7HbaQ5RdqqzVrWjliLlbMrx/35w23ynT3ep9kSLe2k+/FWaI4ki6iJXkEqbH0v1c/8yeXzi9NGSetTobfNLbOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=facezBp/oZo7ZpupVB1fyjftxF2iCzt5Cl5P0SBzPCI=;
 b=R7LOo3xJb4ceU39lGq+ximoSuGdeAQv6EfmmOuYg21DMNRxS1ehgzwM2y/imBmR8gvRbNTPicoh7CsF+90SEShT1DSnWWryh85QnjN4zs2JrX5+bOA2cpWWhFSe97Y6vNWjzbNeq0vVzGYcMN88D7vdddlusuyYcE9OHLEjnLhg=
Received: from DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) by
 PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Thu, 24 Apr 2025 04:42:41 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::37) by DM6PR01CA0001.outlook.office365.com
 (2603:10b6:5:296::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 04:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 04:42:40 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 23:42:34 -0500
Message-ID: <98092a32-f903-49a3-a5b6-7edffa9edd55@amd.com>
Date: Thu, 24 Apr 2025 10:12:32 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
To: Libo Chen <libo.chen@oracle.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <peterz@infradead.org>, <mgorman@suse.de>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<tj@kernel.org>, <llong@redhat.com>
CC: <sraithal@amd.com>, <venkat88@linux.ibm.com>, <raghavendra.kt@amd.com>,
	<yu.c.chen@intel.com>, <tim.c.chen@intel.com>, <vineethr@linux.ibm.com>,
	<chris.hyser@oracle.com>, <daniel.m.jordan@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <mkoutny@suse.com>, <linux-mm@kvack.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250424024523.2298272-1-libo.chen@oracle.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250424024523.2298272-1-libo.chen@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce65af2-d528-4741-f553-08dd82ea725a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0REdXNCOEtvZjNiUWpacGRXOWlxSGJzekdKb2hxZE1BQWZISGVyNzA4Qm1S?=
 =?utf-8?B?cVZxMStWR0EvR1RBV1FjSGMzNjZxQXhqdDJCcnNmQ0FlT3g1WHZsYWZYWTFx?=
 =?utf-8?B?OFd1ZHV4OFFSVjgza0ZmcFBZWWZUMUxJcDJKVTZFS2trZk0vTTdFS2JYdzky?=
 =?utf-8?B?QWJVK0RjdFNGRDRhNHZIeEhBYjRjWnJTWTdremQ3SHBuR2JPYjYzSHlFSkFu?=
 =?utf-8?B?VWluRUVuQ0hFOUM1ZEJubWJ5ZkhPN1FYZWVJNFRYUEVLTXFCUGQ3YXhtVWZX?=
 =?utf-8?B?WUwzY2lka3BBejFFY2ZaYXVDV1BsakNYUFpENG5YelFzejloYyt0M3JjS1hB?=
 =?utf-8?B?eUJUZnh4SFB1dERSL21pMFl5NGFuVkpGblJKUzJqWWtrOTg5R1VuN3ZtUHRj?=
 =?utf-8?B?cUJtQzJSSjFmWEM0OVNDUXNCeVVKNmJXWUxRTldEVWlZZHVKZkVWdVAvQm44?=
 =?utf-8?B?Q3RpQ2p2VWtUZUhDbmRXQUVielpkSHZxcGUrOTNBaVV6K2xIMTZ4d1dONkJP?=
 =?utf-8?B?SHp5L1g0RzZoV2hKaHErajFGT2pBc1BYcFhZOWdGZHZkK3hTT1pMdFFLZWEz?=
 =?utf-8?B?THAvY1gveG55c20zREIyY1JoNXVySVdRcUpRRDhVaU9NYzZkcGhOR01uSEJ2?=
 =?utf-8?B?c3hWZXdGdkVrdWVhMkVvcHhJQWswTkdjVlVvYVFkSEdMdFpoUEtZMVNCN3cz?=
 =?utf-8?B?MGhqQyt0S096K3dmRWpYOElGM01wc01vbHlxVmhCbW1YaHNLRHFVdUVZR0ln?=
 =?utf-8?B?RzRpeU1GRWtESHhxQTY3cW8xQUJxT1hJZ3VxU01rRHZXb3ZTK2xrdkljcWJG?=
 =?utf-8?B?TFRXeWdjbUtYQlFEV0FJOVhtUC8wZ21YeEF2WXA1Ym1oUHdhT0FwcDlTTVl2?=
 =?utf-8?B?bGpNd2pMdXkwWmxHUDk1b0huNytyZ1BycGo1cjJBcmx4OTBuRVJpa25DdWp5?=
 =?utf-8?B?T3ZhNmM5dFpOLzgzZ2tNZWFSR3o4amFyQ1M3TTRwQkVBVmpxSFRrUXVqVDFG?=
 =?utf-8?B?KzhybUQ0ZnBad2Z4Q0RBRUxzQ2FRRUhLUUcxSERONTJML2JsOVgyTmFlMUMw?=
 =?utf-8?B?ay90NUFHNnJHWE9MbkpjTUltSGhsbUY1dEhQa2hkcFhHV0g3RHdXZnAzQ2E0?=
 =?utf-8?B?Z3R2by9vT21XaTZ6Yzg1cXdkQitnYXpVelR4a2tmSXI0b1JTejJSMlNQd0xr?=
 =?utf-8?B?bE92YlhnbW1jVkVOaStmQTUyZk15R21ZZ1d4NFk2ZEo4K29JcFp2WWJ4dUFu?=
 =?utf-8?B?QzRXSlFQYkxJTUNOSHl5U2gvS1JzbUdMZGE0Y1VsZ2F2Z2RpQTAwMXZ5eVl6?=
 =?utf-8?B?andYWnNTd0ZTbWVaUGZOTWhTWW9ITTR5NHlwcHFOM3BQSG1iTU1UZ01GekJZ?=
 =?utf-8?B?VGZzTjc5ZWtmUFVrdVVCcnFXOXpKeUFjejJSbktQZ2lzZklDbVc4MUxuK00v?=
 =?utf-8?B?Z1JHaFZZVDNnYTcrN1gycUhHczVEU2UxZHhZUUNkU1pPU2RsNUJQRktQRERp?=
 =?utf-8?B?RWVXaERPOGI1QkZHSHJzT3EzcDZJMmZBLzBWY0EyNHBTS040ZUE3UzQrV1E2?=
 =?utf-8?B?OEpjQi9yaVlBVFkzYVp2NHZmSjFwUlozYXkwKy9uOWErL3JOVUhnSkVHcE9P?=
 =?utf-8?B?MDM2UWxNem5vMUFaNUJWU1Mwc09YZ3RWWU4wM1Q4WGhFWEFwb05lUzB6ZXps?=
 =?utf-8?B?TmRwSURQdGVjVEQ4dnJKdExxQlNXVitvMWtXUzZtakpoeTZjNDM2YVhESTE4?=
 =?utf-8?B?Q1lCc1VqSDE2REloNnNrYnhhU0I4MmdIekplNWdOa0l6TG1yT1FpN3FkRjZa?=
 =?utf-8?B?S2tyV1I4RXBadEdrVnJZSm9GL0FQdWxYSmszWU0wM1FYVHhpSi9SamNpNiti?=
 =?utf-8?B?SHVONGVTdDNuMEJLTzlvVlNSZlZGNlZhS1R1NjJrZWh6TWRhSGtMK3hER2FX?=
 =?utf-8?B?ZXBBRS9iMFAwbm1zc1FKSzRsQkpEcUJwWUtkejNvQzRwYUMranA3RXNMdjVH?=
 =?utf-8?B?Zjh4RlhyRDdBbjg5b0tRb3U5V1BCMllTcHUzWmJhcVRDeG5aWS9Ra3NLcFUw?=
 =?utf-8?B?OUJJRHFmeEVTM1UvK1ZjR3F1b3pjT3FVcDQ5UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 04:42:40.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce65af2-d528-4741-f553-08dd82ea725a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

Hello Libo,

On 4/24/2025 8:15 AM, Libo Chen wrote:
> v1->v2:
> 1. add perf improvment numbers in commit log. Yet to find perf diff on
> will-it-scale, so not included here. Plan to run more workloads.
> 2. add tracepoint.
> 3. To peterz's comment, this will make it impossible to attract tasks to
> those memory just like other VMA skippings. This is the current
> implementation, I think we can improve that in the future, but at the
> moment it's probabaly better to keep it consistent.

I tested the series with hackbench running on a dual socket system with
memory pinned to one node and I could see the skip_cpuset_numa traces
being logged:

  sched-messaging-9430    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9430 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9640    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9640 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9645    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9645 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9637    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9637 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9629    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9629 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9639    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9639 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9630    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9630 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9487    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9487 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9635    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9635 tgid=9007 ngid=0 mem_nodes_allowed=0
  sched-messaging-9647    ...: sched_skip_cpuset_numa: comm=sched-messaging pid=9647 tgid=9007 ngid=0 mem_nodes_allowed=0
  ...

Feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> 
> v2->v3:
> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
> redundant.
> 2. print out nodemask with %*p.. format in the tracepoint.
> 
> v3->v4:
> 1. fix an unsafe dereference of a pointer to content not on ring buffer,
> namely mem_allowed_ptr in the tracepoint.
> 
> v4->v5:
> 1. add BUILD_BUG_ON() in TP_fast_assign() to guard against future
> changes (particularly in size) in nodemask_t.
> 
> Libo Chen (2):
>    sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
>      cpuset.mems
>    sched/numa: Add tracepoint that tracks the skipping of numa balancing
>      due to cpuset memory pinning
> 
>   include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++++++
>   kernel/sched/fair.c          |  9 +++++++++
>   2 files changed, 42 insertions(+)
> 


