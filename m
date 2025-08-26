Return-Path: <cgroups+bounces-9411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86FB35688
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 10:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48C21B631AA
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 08:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12128641E;
	Tue, 26 Aug 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="KPW48HaO"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013038.outbound.protection.outlook.com [52.101.127.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4A2AE8D;
	Tue, 26 Aug 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196264; cv=fail; b=c0UGKYxAA44TzTRwUQFixBxiew5pGrd0Op+ds+MLcIC42EfpIM40yJhuNHDuCdQwdg6S9dJ6W9FcqI0G7CQCZtcJKXHl0ys/hhQ3u2jDWK3ewoYyItx9U72hAr5OHW/nM6Dhr2b2ronXa/w34lTSP3aLQNetIUQ9Y0U5c5BHyIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196264; c=relaxed/simple;
	bh=m6c4xqXiPunqnGFhqc1CXk7b0+ZggN+/c3mEJ5NHiEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jS4lYmHrxkH/1NX9LkZnSuFXgVqx2R8FUE9JTxJs77iU/jNPivCc61IwXhgfcoyMM8RE4Vo4+dI9HYzxGZatSvYXszjGmDctJ0D6d+WaCO9xhwpA8OKFMEponztGxiAUIFCYORHtEJYRiAHR1fvV+RX2v5ic8JC1/Z1ekf6nMXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=KPW48HaO; arc=fail smtp.client-ip=52.101.127.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bga896dWVkNKBF5z3uy+NzmunJXDdXwWFxNjRQHOdT08zCa6PgD/RNi1JyoUCQfIyUFM99ofHO7+7cDhRzLzcNPXm65d8YHACwrjigtImTWhknZr7RBwXLZpA8nHoiuttHVvzgtFKXsM6EtntJ7IBKMwS8rK7MctCKXeGdfKZwI8QLbT6s7c+RHk82dE97JDyrY8vVb6z59olJncONMKPFSW39Yur6TgC38dnUJJQIZuSMYrV9PRI5D1DYSqXOdHws76WQtgJltbtVljO4hoXXjpXkP6ZfeuwpR4gHKEeu6kXUSTvh5tB4Lp5l3CVlOBBfiUNnZ+BDhxFJ8sO+AgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAsn7S8fbK91NRXlGwIBoK8U77L4PgJnl5iTJt6VGWs=;
 b=GtP+wVIKW+GId8sfyUKVQLoHmmLbvqd9xaIak0fB/xMId3mXER3gxs8y5XWlkgu8kb6yhnxDLK1VvF12TBK0c5MajMPUMq69VcB/ADVeegjRgYmot5jW295jnKVYMoXIcrE/Yara+VY4eBMJXZdDpbZD8SIb7iaksBHszF01TR8gjJKJV/PeKkDy4DyQ1PkoJ7rYGuZsUv6Qm4sysqtdkrjuEyccb2f4eucbzRDavgdTaDpXc0OBw+8AadjlE2V1Wk3zKk8GuyBJn3ADU+27PAE9+zE5D1qoBaKej5dUEGIbJH/EBQDoebhJjEXMiZ73/IX+1M4A0LumwQQcsscPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=intel.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAsn7S8fbK91NRXlGwIBoK8U77L4PgJnl5iTJt6VGWs=;
 b=KPW48HaOkP2lrIxKM3MI/C6eL/VffxEfRYV8BZ7P5NADSNm9R8XJ3BbrZcpGTgOeA0VaVfoj9D0m8kP2G9kq/9K1xvZBb9JNMepypWtXOMCtCGoBoRoGgg2O5U9nQnNF//09sGKKfDFa04xeA3a8acZ3xfk9GAI5RedQL7SoK+Q=
Received: from SEWP216CA0037.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2b5::17)
 by PUZPR02MB6286.apcprd02.prod.outlook.com (2603:1096:301:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 26 Aug
 2025 08:17:40 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:101:2b5:cafe::4) by SEWP216CA0037.outlook.office365.com
 (2603:1096:101:2b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 08:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 08:17:38 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 16:17:37 +0800
From: xupengbo <xupengbo@oppo.com>
To: <xupengbo@oppo.com>
CC: <aaron.lu@intel.com>, <bsegall@google.com>, <cgroups@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<void@manifault.com>, <vschneid@redhat.com>, <xupengbo1029@163.com>,
	<ziqianlu@bytedance.com>
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Tue, 26 Aug 2025 16:17:31 +0800
Message-ID: <20250826081731.20384-1-xupengbo@oppo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826075743.19106-1-xupengbo@oppo.com>
References: <20250826075743.19106-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|PUZPR02MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: f49e5922-d95a-4ce8-979c-08dde479055c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a9kzJIYK6mvPaQpqS65Dh7r/+wGJyYLwwTHQadItsYJSVvhghtS15weSbG5k?=
 =?us-ascii?Q?uL4cCXdOqh2JaiHYmGztTYPhPjziRagXlvSlPcGc5kkRg4+lPXhky5d9kAti?=
 =?us-ascii?Q?fZ4JzJJpfbUNa31kMk8ADNC0K3iXAZ5bE3P0mEtUMhdWGRMv3oK7ivf8vAha?=
 =?us-ascii?Q?wXLTDFuAfXy1XbPTJ9ddqgrAHOeHhGqy3wnze+n7nwmdGvCuyvRJZySX4GZ0?=
 =?us-ascii?Q?/84McxmRkUCH06RuCnLlOj8YghZ+v+GNdN44JOs2m/g+W1gA3Q6cCsVx47/1?=
 =?us-ascii?Q?YZS55SFzpwLEmucX4EkvR48Kpbea4lWNDuJVFMKXIedAa2Eq04hYdHv5suw9?=
 =?us-ascii?Q?Okf7FlQ00Dwrgz6xuo3zCsa9bp5qgSz4JJzeHQ5q4LEBBUccojKrjTZwBN6c?=
 =?us-ascii?Q?pyhzaxubVWls/g/QdQqXEQM9WlIFG7KYzCfDqBs3a/hKW3W6eYFMgL6O6zxu?=
 =?us-ascii?Q?OyJkYqEICXKK5ZSsObYB6K/BOC9qbquYadySkQ3KFp50dmD+/oy3bmCd3wYq?=
 =?us-ascii?Q?7/lUZStBMvvk7sny9k+bKxXA621wwvNinSYWl7BjLfyHgtwyiSjpvyUMLdxc?=
 =?us-ascii?Q?qy8t1ZgESmNPqSHbzrTM9bggd0PnBB2hxTwsMiWtibIWiaN8EwrgeEw1dJ3E?=
 =?us-ascii?Q?OB4lxyk/p+n8flnIf3Pm8WIv6Hs1/GHHUjOtgBd6TVXIeG0befJyGNRpCZPW?=
 =?us-ascii?Q?6WHalLMjUMxG8Wf+1VGhE/uIJ/qPD7z6euJfZWWKvwPxmbXuBzrqUt5h44rs?=
 =?us-ascii?Q?VkGIas1xpITrn9ke3VInOL3ZibkWn/1Edf3NgG1sSgWU/HJ0cyQuzuMjYtJF?=
 =?us-ascii?Q?GrTDCuKLvExSBnyzOJRN4XSp9IsaWy01lX190etv1rtdBNxR1QPM5Tagdwzz?=
 =?us-ascii?Q?9hUAOaUvcVN47KoiF/M6dshBBUL2GsrHw+lsDwx9XEH7COX4qttm/ppsAfqP?=
 =?us-ascii?Q?ZJeUFJ6Zexu/HxPwdR+CN8ZbVPDY84TubpDAYQuuwcTez9Pm9Lyf1I+S2rlz?=
 =?us-ascii?Q?PmCa1aDJ5E3tImxNIMNmHJ2TQofhMT7ZtgPhO+pGmO71xS2k3O+K83GEln04?=
 =?us-ascii?Q?JH/zqM8rfQ0g3hREAxWuXadY9hrrSpB0USkQ2kDMgFy4iJBpFGVBlNYtBylH?=
 =?us-ascii?Q?UwDRSnMsFs+SiYbJ6x7G882pgdCH12r84d8x+PAH++aGTXezGBvN+kshHrwL?=
 =?us-ascii?Q?C2kDEQTRdS4+znos4lkAkOM0JBM/n9lOIu5n9eGsN0N7NjUYVeH6uTp5KIRO?=
 =?us-ascii?Q?S1Dr7ZLqCe8FuThfSQJPsxPbQIPPxuq28SmRQA50yCiOwOUOU/9vwc71Bk27?=
 =?us-ascii?Q?/jmG08/iJL/BYyATA/QUi8AQwkqxFXNfbxess0lYtYczo561/M32viJdfTZK?=
 =?us-ascii?Q?sHX9aXd1yPOqaQus+O9EqETuwaxro3judJPrLg0AJbhQxZWeQjAsgv/86RL7?=
 =?us-ascii?Q?JRhCcctQh2YfwwG1KHX002fjlh08uhMbsJJ6wflHfvvNHhFh2ZBnKmm8mIG6?=
 =?us-ascii?Q?ADDcJZ3J8+uBtYM2jDIpaLaDofibOFnAQDq2?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:17:38.6745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f49e5922-d95a-4ce8-979c-08dde479055c
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6286

>Hi xupengbo,
>
>On Wed, Aug 06, 2025 at 04:38:10PM +0800, xupengbo wrote:
>... ... 
>> 
>> It actually becomes:
>>     if (cfs_rq->tg_load_avg_contrib > 0)
>> if cfs_rq->tg_load_avg_contrib == 0 , it will be false. As it is an unsigned
>> long, this condition is equivalent to :
>>     if (cfs_rq->tg_load_avg_contrib)
>
>I suppose we have reached a conclusion that the right fix is to add a
>check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed()? Something
>like below:
>
>diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>index af33d107d8034..3ebcb683063f0 100644
>--- a/kernel/sched/fair.c
>+++ b/kernel/sched/fair.c
>@@ -4056,6 +4056,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> 	if (child_cfs_rq_on_list(cfs_rq))
> 		return false;
> 
>+	if (cfs_rq->tg_load_avg_contrib)
>+		return false;
>+
> 	return true;
> }
> 
>If you also agree, can you send an updated patch to fix this problem?
>Thanks.

I already sent an updated patch v3.
Link: https://lore.kernel.org/cgroups/20250826075743.19106-1-xupengbo@oppo.com/

Thanks,
xupengbo

