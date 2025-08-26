Return-Path: <cgroups+bounces-9410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D33B35636
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE431B662C3
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC42F49FD;
	Tue, 26 Aug 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="vg+hOl/j"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013008.outbound.protection.outlook.com [52.101.127.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BB14F70;
	Tue, 26 Aug 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195100; cv=fail; b=dmWprl61/OsyGCg6aDB89Yu8+dHh8ngi+QgLloqvIJNf2Ldy9WLF3L0B+Sapn8qCNvCFwagM9Pe2E3fIZBJO9kXNHMMhr4Iaqvci3GPZgDSl0gRkfQyCLe/lyqQY+/Sn3TeEXArymFMK11aTmfMuZ/ndhGWXhVP0I8uDq2i5B8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195100; c=relaxed/simple;
	bh=sx0UdoKm9dhgD61d3cglOEIK9gIyTXDhCmhoMb3r+B4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qw9MoayufIuCDaYsG6bvgOUaOgeI2HVl2UCyCJo6vjMEy08BWXxTuHizQ2RYLs11Heq0hI0r86qpq9jVFMdVSd4FVRnz3akLDuuhgeDN8TqmETVOF1jgCJ9hmgnm+BgRAN0S4zT50oo8QpHLrxo1WolgosYYZR1sPaAViFg4eZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=vg+hOl/j; arc=fail smtp.client-ip=52.101.127.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPwhji0ISHFKVkenP/5F6DbI218v79e234+MAKQZq9aHR/bxppEs70i97PhtE2OFB90f8aUkNUI+t0ISBPsltu/OXmz/x3urgmYa203eiEaCzqelwZDZIHkgLCWDTW60qB0wKSPySUulGtXB12N1wla+/yPg6GFdIfgdwsYX2eo3M6THKQH6nUxmE8mAPac3tdzgvM/OwubqtSeUcoc7/maNg/AaWetan0V3AJ+WpLatvuBSRvmUQy8OxqDzN15yYy57BmBms24FjsW39KP+LT+gFxTQ3LwMlIfdL7YTDSNJUC7X+hkf96E4I1Mjl81tlxngfMiz3CrgHcNzFSvR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PayOgwyWe8i6FAq9X/9drB7iTs+RO39jQUSU7m+JKeQ=;
 b=HJ2lT6cLB8ci8suqFTh4+1tgCKaGsKCOhFd8oqMd410ArLkVgST70FfsaHRfKK+HflzB+MPWMQ5TE/MB4OV9OyOM+xsLKzrNT6regkTGPTVMtFlHKHA46W2oEwv20UZ7nhMmW0iXnvjrIToEB99uNX46m0TpAsSgYj/g7rjWjG5El/4wHwf0pvaUvTtiEgw9xnUprCJy9XxpOFopOHF0q4GhOHd0kuqp8+ybeIqq3sIh2B41M09iD77DMDZNGsgii/DNzi+bM0G5CaFLUKr6Olnccz5Vkjt9cp07kN4BHOSqGbuxFsolDcLm6+2MpPHYj+EnXIao3s07u3rU2iknnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PayOgwyWe8i6FAq9X/9drB7iTs+RO39jQUSU7m+JKeQ=;
 b=vg+hOl/jbD+WQ1bely2CaUf5rnNsOpoW5P36m6m+AkRWNVUfjlS8x/Wzg5QJZHxfyHSZZwC+ZfKujWqT2nRh+zQ1GOv1wUtKpl0Ez+eutuQiYWp8hmWFo0u3848OyHdyZOXHw/BAd8yqA92bAvbopqEgm5d455+f5HpZrbCzsOs=
Received: from SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15) by
 SEYPR02MB7274.apcprd02.prod.outlook.com (2603:1096:101:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 07:58:14 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:be:cafe::4e) by SG3P274CA0003.outlook.office365.com
 (2603:1096:4:be::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 07:58:12 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 15:58:03 +0800
From: xupengbo <xupengbo@oppo.com>
To: <ziqianlu@bytedance.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "David
 Vernet" <void@manifault.com>, Aaron Lu <aaron.lu@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <xupengbo@oppo.com>, <cgroups@vger.kernel.org>, <xupengbo1029@163.com>
Subject: [PATCH v3] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Tue, 26 Aug 2025 15:57:42 +0800
Message-ID: <20250826075743.19106-1-xupengbo@oppo.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEYPR02MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8d7e9e-670a-4b21-086a-08dde4764e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dk/BH15/Spx2oEl/pvB0JwQJF8byvF0O8Xr7uAnV7nJQHwAby7eanxQxeIEC?=
 =?us-ascii?Q?rrrpM8FuYw1JW7y4K9SVCJ0jeV9/fb190cdZKjA9q2hWdRHOgLD306E+Lstd?=
 =?us-ascii?Q?PnfyaAJ7Lt9MUAQaRrFNmIbYOgpyLcyGG82LrjEO/S2z/G3iBP5moRxj0NyB?=
 =?us-ascii?Q?/Gt8o7fX40KFGSc+vQpDzwaIEQFwE38hDvo0ZVrBG6HTZ//vz9xVdcFkTkQS?=
 =?us-ascii?Q?BjV+Q9YAXTUGuFpluJN3hdmgHNNR8CPA89iFmFGT1L5+/9ylyq0UmKJ06GIS?=
 =?us-ascii?Q?3fBQF+KsUg8oKXn9N9EmBkuJoYO2tpARjC/Na41h+Q1ypkvpHDtqeRxR3n8p?=
 =?us-ascii?Q?0+RaJNouT/fLXHq8nrlpOEpKoNN29ZuWWD4Inmp735lmRZLXTctVtUPlM4Gj?=
 =?us-ascii?Q?Q4nt6wu+RUFuuAZrLMY1TCSLdW/6QEA5DjAP3uVfxhuR4LiDwbV8dfRU8cJu?=
 =?us-ascii?Q?Xsc6ieB8oya6xAKtc/5Wz4wZtkQ3rWDM1MJbN96u+xf/EXZd+WVhEhltm+oI?=
 =?us-ascii?Q?sv7HeECrK6UcZLivmCjewNBpXc7NmiKNNUQVZBNbCrjZx+C+/keduIclPsa6?=
 =?us-ascii?Q?S/V53wZJsRjqU9kh4+wztc3lpHB0YVfNMjIG8H0alZM6WS+kT7DscsbBkdH6?=
 =?us-ascii?Q?ZJcEfY2jWT16AO1YL+70fwcEp21WrXhpSlOWF5ldc/ak72cWSj3rLs8rd6Su?=
 =?us-ascii?Q?SYtGBn/OGgIG3uQ/KckBg7a64+LBPlzwcXxFnjOBkAAPtcsLqcC7n2u4rpLB?=
 =?us-ascii?Q?rZxQEoayl1u4r1CFajE9lbVAn0QLtn5f/cJArAhOSWVe7SDp6rCRWZ3Ky+6C?=
 =?us-ascii?Q?Pz1sVI+VCZp5HLW1BL87EwUQCNtwBiMBH92CvSHBmPirpNHAwRzPinFF+F47?=
 =?us-ascii?Q?LCsAz6wudfQxBwmLVHnWyMm+dYBver1S2oQsDatM0DSrKQk19eBF5VPEvvmG?=
 =?us-ascii?Q?v+0nLTChZJ8/PiCJy8sd7JoqUc18w4wmQHe/XKg8RjJjJfjOKw6pl4BTC71t?=
 =?us-ascii?Q?CA6IXwY8LA8ro3KGJbxpCYXc65KHJ9E+b0KygHKyVP144qPaUflLPmnsgdG/?=
 =?us-ascii?Q?Wo0klIY4kgIB89zIvBnTTpHuw9IGuUn94C8a7lLeWitJlcNNYZ1gghiK6yf1?=
 =?us-ascii?Q?KYbnC1TS9t7I+rXYbGFL2AkrPMq23NnL7/WcPbP5aiIKqcGbOlqR+oCpOt8f?=
 =?us-ascii?Q?lFNf9zU+VTOfXqlGoEHetVE13VrclCS767q6OWbjgKP864m5M4d8B82jgRvi?=
 =?us-ascii?Q?E6md6+5MwGYyc0WV0hRY1eB4p2Ry2YKEdvGqmZwUeY729JQuEpK/UfW1S12S?=
 =?us-ascii?Q?e+ARGqTx2gX4/TPLT513bnsksncEzvxhczVj5YeNBYcdYi2YolgxkHsr5N1H?=
 =?us-ascii?Q?atOcmp2Ncq4eVIvsWaCcxbojxjFr3KEhO5vfpSkqDaXX6xaLgo3Ci9zj5qEy?=
 =?us-ascii?Q?y3yFxGS2m8jQBmQKxiBZ114OiHBnZ4RHDoovh6MvOc2zbr662jYt7JUXuScW?=
 =?us-ascii?Q?t6zZX2k6yrNxvat1oHwKfgBitIYFaYhmGXFdFdgwnqCi2ULkHAR2djlafA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:58:12.8484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8d7e9e-670a-4b21-086a-08dde4764e6d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7274

When a task is migrated out, there is a probability that the tg->load_avg
value will become abnormal. The reason is as follows.

1. Due to the 1ms update period limitation in update_tg_load_avg(), there
is a possibility that the reduced load_avg is not updated to tg->load_avg
when a task migrates out.
2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
function cfs_rq_is_decayed() does not check whether
cfs->tg_load_avg_contrib is null. Consequently, in some cases,
__update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
updated to tg->load_avg.

I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
which blocks the case (2.) mentioned above.
After some preliminary discussion and analysis, I think it is feasible to
directly check if cfs_rq->tg_load_avg_contrib is 0 in cfs_rq_is_decay().
So patch v3 was submitted.

Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
Signed-off-by: xupengbo <xupengbo@oppo.com>
---
Changes:
v1 -> v2: 
- Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in 
cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
- Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/
v2 -> v3:
- Check if cfs_rq->tg_load_avg_contrib is 0 derectly.
- Link to v2 : https://lore.kernel.org/cgroups/20250805144121.14871-1-xupengbo@oppo.com/

Please send emails to a different email address <xupengbo1029@163.com>
after September 3, 2025, after that date <xupengbo@oppo.com> will expire
for personal reasons.

Thanks,
Xu Pengbo

 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..df348cb6a5f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->tg_laod_avg_contrib)
+		return false;
+
 	return true;
 }
 

base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
-- 
2.43.0


