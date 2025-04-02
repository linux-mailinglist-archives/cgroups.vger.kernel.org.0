Return-Path: <cgroups+bounces-7303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078BA7949E
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B7A1730DA
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8201E9B1A;
	Wed,  2 Apr 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rxKkOGGg"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9321C84C0;
	Wed,  2 Apr 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615799; cv=fail; b=jCTC5pEKTBHCXKRlDG3U0tmqJ4JtWQuRXTbmenof9XRM+97ps4chW9ZyUbacURD07Ka0DNB9xCvzaKjBcCZGAcqbcY/+Q84uDvC+9VgAshuAZyvPvGXShMq2YIcHqNZ+OdZbxFjiL9pXOJGvbC/6aeeJU07uEIsoAa14UgJQ08M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615799; c=relaxed/simple;
	bh=YF2J3lXQ/b81kLexN5NqhDpxeJ366F1q2NSroIVA8is=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P4qpkxzfHFjSt6bLRI0v7MngAQ7Fd//g37osLiJJqPSgUBNoDL0lGNSUnXYbm1VVu0YLih1iFUkfEHsJlIZtbgZwB+V1KE8BkxbGKF/8/y1+/G5gF0o3M5fdRaZj9Y195rJCwZ4XuxfNsxIl+NYJD8LnugoFpNPez5eOoC9Iy0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rxKkOGGg; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf93+2qykz7LxElDV55lbi2sj543xtQTT9lck0MCzHm15m8E1wYHaQ7jwzvMs3zehP/srx2P8XHaZnxdS8lAUN/7ukYnwOJPLakTJBt/6hg1iIZbvm7exh7Et7DWw39XbybWs5IkPNChz/gAaVmt9xG8rNGgfQwqb5I/CfZu9OqJrTaW0UIOx0uEWLFt2i9EDLyvAvbSSeF7qmc6pPnvFX6BexBKMn69wQWXOk/5PHOy3fCaHYihPJaSj2BWwiZv2HRmjiDXpIUHtOGfY57rhlSMchmizqdLouUAfG6qIvlCk9am8cDhI8hKf1TdbU5jDs0qhz1IScSp9FREYR75YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSAjb0Dt9O/vKog4cl9Gr1v8HkZP0a7PP1epiFMnnZc=;
 b=XnbOBfctlgLdv17zpDWpZsj0C2rgguuuxRT/Ov3aeHoiEk6y7KlBSMU2gLn51KZpPStKzdZpoIDfaYOffXM2juebBy+EoJ2zeVsHjTq9qivpb47SZI45404yWZ8FdO9XNNF/4bTksmlyA/6qwjf07CPSxEvl2ZL3iIwLx1X97ttjAPGu+E7PqTKWKkIzeKUaQ/o9oUOrPdhrGNWTjBN4OGWvsyG7a/lXgxlzHnKzHxEswCq1XfmRESiXMnC9l1MkuqdEqBW6P7YQRchnwc5FEaRMfAkrHHA4XkGSwhA+cwwp5xJw90Vaqn/0UDmC9h4l162RT/HMKyI3Q6T/mAPD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSAjb0Dt9O/vKog4cl9Gr1v8HkZP0a7PP1epiFMnnZc=;
 b=rxKkOGGgcCOB2FtoS+APj0w0CstSsJMa2qmqVjiakzSo79YXfViQ9+vC45FEmkDoZxzzlie8IfLeMkF0GUjGE6A+NxpbUm6FclaNlIELN1yJYRZEuMdWKhWM6ESpcysRC/YsS9RKEXja2J0LRTGmeR+oIzYoDXqwm3NqOTd4+Hw=
Received: from PH8PR02CA0054.namprd02.prod.outlook.com (2603:10b6:510:2da::14)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 17:43:11 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::e2) by PH8PR02CA0054.outlook.office365.com
 (2603:10b6:510:2da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.49 via Frontend Transport; Wed,
 2 Apr 2025 17:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 17:43:11 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 12:43:05 -0500
Message-ID: <7710c312-77da-4b8d-bb80-74598433ecd6@amd.com>
Date: Wed, 2 Apr 2025 23:13:03 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: Add statistics of numa balance task migration
 and swap
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Chen Yu
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
	<linux-mm@kvack.org>, Chen Yu <yu.chen.surf@foxmail.com>
References: <20250402010611.3204674-1-yu.c.chen@intel.com>
 <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ufu5fuhwzzdhjoltgt5bpoqaonqur4t44phmz4oninzqlqpop7@hbwza7jri3ly>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: e735a72d-1eb7-4923-dc8f-08dd720dd652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWJVZ1c5RDBXK2FuMkFzbXpESFA2UzhrR3loRWZIMmpEZ0lxcjliYWpsN3JG?=
 =?utf-8?B?SHc1cmtyU1JTQTBhQW1TajFvNHkvMVlvMVl0V1FMajdRTmVJT0hsdkx0disx?=
 =?utf-8?B?WWJWUG5GOHFueXJuaXlPWXM0bTJhS1RRNkVEZ2lyTU1RR0R5NEJobzhjM3g5?=
 =?utf-8?B?V1VsbWtML1FtaGQ2QU5SUkJJZmtTVk9RcDBCQXRQcjdzYlhwelBzTEk3OHhI?=
 =?utf-8?B?YTRsYmdFRlkxYXFRNWdRMlZpWFNpeDN4SmI1SG9uMHlRRm5YdWM3UnE4RUt6?=
 =?utf-8?B?a1RuVTVLdjNRemRUbXVZd2lSa1RQLzd0V2Q3eDZtT00wdHVvUm5ROFNXUHRI?=
 =?utf-8?B?Ujc5SENRUGxHbk84WFBlclphU1cwOHU0ZU93ZUV6QnVIeWNVSW84Wms5M3RM?=
 =?utf-8?B?MnVHZFRwT1AzT01scHhYYldDQ0o2TllkYXpvRVNNVmFDUnordUZrNTRybHFW?=
 =?utf-8?B?WVlYR0RxN3BzV2NubkV0STFQdk9wbjhaeVl0RXJCYm1YemQ3Um9qdFh3d24z?=
 =?utf-8?B?K1NsczRXb1lLekI3L0trQW9YRFZPcHI1K0RUd0d2ZmdndjMxUURoYURtc0RN?=
 =?utf-8?B?Q25MQklkUm5PcFkyUGo0cmhZbi9yNmZJY24wZnlob2NYaHJYU05BcWZmTk9O?=
 =?utf-8?B?SENZdEVwNjhlSEFoRFBPdjc4SjJkaDBlOGYzMTg5eGNXeVFZN3RpVGhUMDdW?=
 =?utf-8?B?U0Z6SlR0RXA5ZHFBakFwRGpRTnp3M041V1VuQkQ5b0lWd2NMa2c1RlE0UHlI?=
 =?utf-8?B?VXlMRUJhRndZVEt1UlozNXpSa1FDUm8yMjljaVAyM1MyUEN4TXdoUzFKdlpq?=
 =?utf-8?B?bW1BUGR5V0FHa01reDFhQmlESG9UY0lFbjd5bExoaUozbkVKN2VlVlhUdWNV?=
 =?utf-8?B?OVhqWUFXN0NWc056NFlVUEphcmxxSXZDUkp0Tm1EcUNxQU9DaXI4M0VRaFoy?=
 =?utf-8?B?d2QzTGt6L3BDcVU2WmZCQ2k5Nzk0UXVoRnhXVFU5SXByTms3MWpObmZnUk52?=
 =?utf-8?B?Y2J3Z2xwT3lWNHpwUndHb0oxenArL1hYaVJGTEs1MnUwTXZZejA5WmZOcmt1?=
 =?utf-8?B?NkJtYXJKcEVDQ01uZkVmUmhqb1Z5Z1B5MTdDeTVTOVVZNHBseU9OQWZaSlNq?=
 =?utf-8?B?emY4T0JhR290bHBKMmU0Smh6SHUwendRaHdKR3VWeDI2MEdnckVUQVQrQ0hH?=
 =?utf-8?B?TGlCSzNEbUhET1M4bUZaK2ZuL2U0akNZRFE4Sm1tVW1ja1N4emx4a2REMnhW?=
 =?utf-8?B?WHJlR1lwUXE4OXhwM2o1QXJ3NzhSQzljR2RqajFQREJqV0M1Z0pWYUZISStT?=
 =?utf-8?B?eXgyVUt2UmRHSnhrTXBKdWtwa3p0YUV6R0xCNlFVMlBoaHo2cWU0NzhHMDYz?=
 =?utf-8?B?bFYrZGsxbVVrQTVWWmNCcnk5UzJDVmk5ZnQ2VGlhU2VjTGIzL0xNRVpoM2FM?=
 =?utf-8?B?bTN1eGZhYVdpaFFYT1lTT2lHRFh5bGtWLzBGQjhLZDhCRWpPU0ZpcWNsLzgy?=
 =?utf-8?B?OWk2TlhzQnl3b3Q1dVZVNHFqTEtueGVmcE5hK1BFanlZam9zb2ZyRGlLelR5?=
 =?utf-8?B?bEFaeVV4bFFZRXFwMXh5L3Q2THBZQWFYY0gydXhQUUlyczZTRW9wOG90cWpo?=
 =?utf-8?B?QjZCcHltdlJxeWx1S21yRnBhdGV1aC9YSjNjS3BTdjEyTkxTSVl3dXcreTRH?=
 =?utf-8?B?ZFl5Rnd6ZkRNQ2l1aFg3MCtFbTVhdkJYNDQ0bktHUm53YWRsb0xRa3RHaWp5?=
 =?utf-8?B?YUdnNFA0MFBxajcvZzZMVlBjVVhuMk9lbGNqT29jalJqZjFoRTg2WUY2Rm5B?=
 =?utf-8?B?Ny9SRmVlZW5FTlpyZVRudEExcW5ZZUJqa3NsNm1jTEl2aVk3RWN2OGtKZ1dO?=
 =?utf-8?B?MTZkR1lGTWpKV1BESmwzSGJ2WjZ4d0FhL1pHRE41ZzZpM1VYS00zbzdQT3l4?=
 =?utf-8?B?Y05LNERJVHBBZ2s2ZWh5R0c0WXgwZTZJVVFNMDdnS0daNFdna3J2dkx4Qksy?=
 =?utf-8?B?SHVDNVYyem05RnpzemtmYjFPcDNaOFc0eU5RUzQvcDdxaExkSlFyZEFZS2ZS?=
 =?utf-8?Q?UvlpUL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:43:11.1749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e735a72d-1eb7-4923-dc8f-08dd720dd652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

Hello Michal,

On 4/2/2025 6:54 PM, Michal Koutný wrote:
> Hello Chen.
> 
> On Wed, Apr 02, 2025 at 09:06:11AM +0800, Chen Yu <yu.c.chen@intel.com> wrote:
>> On system with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful.
> ...
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be displayed in both
>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
> 
> Why is the field /proc/$pid/sched not enough?

The /proc/$pid/sched accounting is only done when schedstats are
enabled. memcg users might want to track it separately without relying
on schedstats which also enables a bunch of other scheduler related
stats collection adding more overheads.

> 
> Also, you may want to update Documentation/admin-guide/cgroup-v2.rst
> too.
> 
> Thanks,
> Michal

-- 
Thanks and Regards,
Prateek


