Return-Path: <cgroups+bounces-8982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C748B1B6C7
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D2D3AA27F
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52778278779;
	Tue,  5 Aug 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="wTTmM1h5"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4025394C;
	Tue,  5 Aug 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404925; cv=fail; b=gJ3eM5uKadKhTSkwNVI+tJhWzYO8jy/Q5+auD5iznbdABgWZzEGuXNHgnLino5dQmcH6kXz1wmdOcg4vx0UED1+2a/VGpg5rvR7pNFNtTzbEhs3RvCsHEUVOj5IVSeeA2bxmc7CeO0V/KzOWeADOAvyVewxrEaN4aGbeir8k6hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404925; c=relaxed/simple;
	bh=MIXQYDiERtBaWNgS+MaUW555qIPrFcp6bDYE1X12xeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eg+3P8/jyWrJB5w9Fy5RXiXA//GUZ9vRt25k6HpzCFDdOLXD4ylNuyp5QPDrCf8aTka0rIL43j/DgKvn/s+hNMvU7fGKsV9A6ghXk932fwF2p/W1WPFKGWqAFL9Gv3ozKsKNH6Ut3bI7K5lL7p1f5ZK0jzpSFvkp2R0u6AmMMB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=wTTmM1h5; arc=fail smtp.client-ip=52.101.127.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaPUbDb7wYScS914hYeG76wsJS4YFzBzMP3DdXlWGgYufficVVK/v/lTQ+IiCQSGPku6auOYP18cClPszO4Ac1hpV/9kY41TWzkktwv0COcCNj+1LrJ+JHigVuMCrjHVXhGOjgLFTZ36MJltb4tkhwoXn5KYB2WY8RikkljG0Btpxlgv7m+JHNqvJAtTigyov+I+53zBS2l7PCCuGJep+FWf2owSlc2RED0z4J3qkFxaGsx11T2c/uAPn5jRx3wevAdzxCfvQS7Xm2L7XLLR0D6X/xxfLG97bURmKjEsUa5ctJmn/lYO9jrb/mz5NSWLABJMxZeNAOhLlXArlmuxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFrjs5qH8um/UomFBbimeJImLbhH9k1w27j96hNsHUU=;
 b=OcRFP89l3oETmbH6OJldiH21MvUqaMWTtrfA25X2/QbYn+ytnNouiKKic3htMH3VL6hFd4udEGvS15tKRo3PlPKwHo6FW1+EtXCqPooKHQizKhrFZMIHZK61WwPkleXrLzQ+gfm6uoU+8u62zNAEuM75IihOHK6oiTOhMjpriDvpYFPenT6Mp+wJOckQs4pa2o9Wx/W/AtaswAPwgCO6NsPHtYcTMgqJZRSclCrvZ7KwgRoYzrgj1szQgtuYM0b0yfSOe7fjZ5VCnnTeYgQQuQIAuIcxhX+ezXvVLgFE0AQOCGNMyfS+Mu6qebBDAwLbJnG0muKOvkArOG6kCiqccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFrjs5qH8um/UomFBbimeJImLbhH9k1w27j96hNsHUU=;
 b=wTTmM1h5S3T7H5MKMppSGEJYeVYve8UPUij76wQ90WwjMJV5N9QeF3W47NcYFv3X9VWHoVR4M9MEDAgT1dGCl8MzUEgxpNt7z8jHQSckiQA0kr7eonp1eftjei72egyJ67pbBHDZwEjLahr0L7UrSWW/U57l+L3wr1HBaGVxo7Q=
Received: from TYCP286CA0349.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:7c::18)
 by SEYPR02MB5510.apcprd02.prod.outlook.com (2603:1096:101:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 14:41:53 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:405:7c:cafe::df) by TYCP286CA0349.outlook.office365.com
 (2603:1096:405:7c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 14:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 14:41:52 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:41:52 +0800
From: xupengbo <xupengbo@oppo.com>
To: <ziqianlu@bytedance.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Aaron Lu
	<aaron.lu@intel.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<linux-kernel@vger.kernel.org>
CC: <xupengbo@oppo.com>, <cgroups@vger.kernel.org>
Subject: [PATCH v2] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Tue, 5 Aug 2025 22:41:20 +0800
Message-ID: <20250805144121.14871-1-xupengbo@oppo.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|SEYPR02MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: d20b3b6b-d782-4e83-eb3e-08ddd42e37f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0CLX8vbTvpulRQPqcl5cS9ROagi90fbOHdntQ6c04x3DvsLTSGFloevoOK+?=
 =?us-ascii?Q?rSbra7MHyKMZfkWw+JaKtYDIwEzJyNmQYIzTKMRa+bSModu654Jn4TTXaZFk?=
 =?us-ascii?Q?7+snRmiLPX15pdTIsSG24jaDrac6mf62+9I1aDdnQYmid8umd1Kc59cttFgl?=
 =?us-ascii?Q?YDUdL/voUfuyd8tBZDX3tPH7Eyd/cShhGeWLLsZvbIwUMGGQw3JZninPGsUn?=
 =?us-ascii?Q?ipVrGexqq4AcZWHErE6x36etSXXKwHtwqaZc3ElJDOCSKw37Nm4p9Ty/ZR6P?=
 =?us-ascii?Q?Dd8WOHCo/jJwc6fqOjSIV5GlYcFzmE303bfq1+9mZA3B5v3AhbQHtLUqrris?=
 =?us-ascii?Q?WnpsthQQm4lseiXT2DTsY8ANeU4sLCV6OhcErMChz3gyOlnBkBcHWNUDJnAh?=
 =?us-ascii?Q?shH9S61VX4aWKpNsD0/AjkQTaQJCB5wOoU69kMA31+1kUfdvV1Uiq6JlKcjy?=
 =?us-ascii?Q?ZGA8WQRVWcz8iVILeB7EzUPphw5zkIHabUxkRB5pa9FuU6M4DnYCh/fD+XM9?=
 =?us-ascii?Q?qLvBaNR6/Qzxa0wYT7970lgIrp3JJ8lFKsI9GkgoIGfPSFDz10Fa62tFNtqB?=
 =?us-ascii?Q?wqtni5UoKNcrISNRbuI9wDbwexovdFbyp7zMoqX5Pvwe9StICb95WfbD0TUc?=
 =?us-ascii?Q?dzD+kxK3JHj3mqmUR5OwRfiqcEE5Qi3+LSKtEw2+vx+exs5mj46TboiPvm9B?=
 =?us-ascii?Q?HXFx526G1Tkh8bcSvB2RDjn3K1d/kyy67NYTAGJn25YKs7UncH0Mcpf4wuIf?=
 =?us-ascii?Q?8RcOth1aJUOu5KKN+aEcXFNF7WZFbcu8RC2YdcjFm+CbCObrIXYVu+F1muOL?=
 =?us-ascii?Q?B6pvmAmnzzJ1DmsOo8Fbd884oFJ2GdT8K5XUfDtLwfdh55qouULnRX821UWy?=
 =?us-ascii?Q?qe7VWaLU+wyfeFqjS8KwdfUmn4rTDnkxTS2EFL4BC1cIQIWzGgkZe5gCI+YJ?=
 =?us-ascii?Q?goplPs/VL168gQgZKckwSrN+kJfrNT32NPV3Ndg1ASU512lQZvbr+JNq3jkd?=
 =?us-ascii?Q?aC64BxjG5XjK8G3VaIeRofubedlU+p6M1M7OWks2oSLDEEMnf/KvTMJifC+l?=
 =?us-ascii?Q?G9JX+t7qb6gddJaST3i9p5POSpfyZEQ4e+djbA9Z8LYr+deiwzDOA83CS3xC?=
 =?us-ascii?Q?IKRov9EBIB02WSlHb4/HkSkE0jp81ZPKo+XsQZVYP64gHs2E3qF/LFkE9MJg?=
 =?us-ascii?Q?CeRKH9BXT6mqf2ynthAyvITq/BQFgjCRrH4/3ZhY8AuHXNOwSaj9zmUBRIR4?=
 =?us-ascii?Q?/GLpiF+DVacxoTgS7RbmWWaHNojpMct8d5VpQ+DF/yaT8JVs72c6x3H0DUu/?=
 =?us-ascii?Q?Vc6yr5QfGvtXkZVtDSWZ7k4OJboKpUYpxuSKFlQvFqu69yPyhDlXCau9kpBO?=
 =?us-ascii?Q?cAu86WpNYvr9Jr/VjQcQx9i17aUkkasHHY7FlkfcJ9gErE3yYVHOT25UUqVw?=
 =?us-ascii?Q?a+oIGcjy50NjW9CiUDQlu+moyhHkZBx0xuY2bA2u4cye9O9IRDP+GcTRuRZV?=
 =?us-ascii?Q?QicUg8MAWMN9YIg=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:41:52.7107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20b3b6b-d782-4e83-eb3e-08ddd42e37f8
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5510

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
which blocks the case (2.) mentioned above. I follow the condition in
update_tg_load_avg() instead of directly checking if
cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
condition consistent in both places, otherwise unexpected problems may
occur.

Thanks for your comments,
Xu Pengbo

Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
Signed-off-by: xupengbo <xupengbo@oppo.com>
---
Changes:
v1 -> v2: 
- Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in 
cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
- Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u

 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..a35083a2d006 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+
+	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
+		return false;
+
 	return true;
 }
 
-- 
2.43.0


