Return-Path: <cgroups+bounces-9437-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C4B377AB
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 04:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88091B65383
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83132737E7;
	Wed, 27 Aug 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="uoPgPbZq"
X-Original-To: cgroups@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012005.outbound.protection.outlook.com [52.101.126.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2127707;
	Wed, 27 Aug 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261359; cv=fail; b=L1IZQYYlM0DrHF4v99CCbr0rj/zI/idj0W9IPVid/KS6xc3CyT2QcwN7JSfAMqrYml0mz1lhLo4aKrMYOpchA+BkcOMivDzarpqpZYBstmbC8stSlFdmKSvZqPInjPO4kpdwfwBDJ7R4RqU06WT/7EVJNgiegN7M6AWGc3L7Vqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261359; c=relaxed/simple;
	bh=cEhcWC9SJcfRPr8jdSUF5s/JQoifp5s9fJBirPhSLoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bl994TgrraLN3GsvwplHwR62p0csZYDeFHzZwgUqqZo6Ws+4K9x0Uj8m7NLXt44Rk60EYG9I5IB3F6WqWmcInmZy4Ij1N02vsuLFbG2FMqA2ilR2De/9EVGXSd3ShPzPcBZFyrmreo7+zYyfdI9h8huBgFU3qdVD4qCPpddcpyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=uoPgPbZq; arc=fail smtp.client-ip=52.101.126.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vd5IqpitTQfiljj/NmiREppo2QUbEh2y+VRv9D342/KPxQwrFD9CwOd0FpFZCon77YkZ1XVi0wItpEfroXQze/TbL0V1PS3w0GQSlfNWSBV6+rw/Iv+SavbllvXZUSQoJjf7PYvz0qAumXRKss3SK8raj212xi4vu2h1qSTIZYm4VFuf7+aL2yBjJyBNOTwFQgZ8hFUspICQuIcKEk5S9dw73pWtp5/dtQ+Qz6W7SeO96t93vgHp9QnCOHrVEgJLDg/sW4pMGlbB71vadzupY6MzpuJDapyqZ6lOtLe5RvuTVp2h9Gwgo2wq16uumG8rJIekE8OM1r5HG6VcLIGZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWSPZojpdNmOE+6L7pouSkerXw2zIbiaFWjETMJpR9M=;
 b=hsJH2UjiIrcz3TpCmd+ZR8g+VXPyukTP5GazHSecMWcVDzuRuSDz4hGzZkRLCHwVzNdW77exuki8z3uUhQ1tArjTYZGyDYwlNRSEyzty9yQ9B/ZPn/SsQtDTRnRhAIe+ou2VxrSTU17w9OrDTPGCQnEPoYKk0/k9zmKCtL3jBS9kwZJazyKadcJh2xlcKaJNeLrSU1DKbD1ujl0mLXOtPvxOvTaMmblceQ8JTJEfV1jRpIZMLvC3oJrR5JID/e1ffAAlCyp7Nvo865VF7eetj6Z3f/0nkpNaXPS3k7a47HVVjGGa2/Ow6e1kRlFPhjb6L8yJl4pcwNN9y9kyS/C/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWSPZojpdNmOE+6L7pouSkerXw2zIbiaFWjETMJpR9M=;
 b=uoPgPbZqPuBw1M9E8feJ6YSjYZr9xPfJ4nE9td3bRbTcYUdM7UDtUY2XSyS5Y2tU9lPW3GDMxmA0zEoxj+a0L21RyrPnQTVRo/0y+Lrb7n/juwwncGOmtCaBwrJq5+wJSR67IN5DLgbghLYXg4GeJfIoXVp0hdMoFVctjKdCGnA=
Received: from SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9) by
 KL1PR02MB7827.apcprd02.prod.outlook.com (2603:1096:820:138::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Wed, 27 Aug 2025 02:22:33 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::9d) by SG2P153CA0022.outlook.office365.com
 (2603:1096:4:c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.3 via Frontend Transport; Wed,
 27 Aug 2025 02:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 02:22:32 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 27 Aug
 2025 10:22:31 +0800
From: xupengbo <xupengbo@oppo.com>
To: <ziqianlu@bytedance.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Aaron Lu
	<aaron.lu@intel.com>, David Vernet <void@manifault.com>,
	<linux-kernel@vger.kernel.org>
CC: <xupengbo@oppo.com>, <cgroups@vger.kernel.org>, <xupengbo1029@163.com>
Subject: [PATCH v5] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Wed, 27 Aug 2025 10:22:07 +0800
Message-ID: <20250827022208.14487-1-xupengbo@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|KL1PR02MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0ff309-d924-44c8-eb30-08dde5109453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJ4hvktoXrlSMGfuVfKDIYieQdFHmwZPgJ8Hi0k1BhbT/24cDRgaPqRyUXvH?=
 =?us-ascii?Q?k3SUiIvSS8r6CKbkHzZ4Tfv0+IZcAlsnX3MBn+3Xc2vJSyldoH8JYqR4iAXS?=
 =?us-ascii?Q?QVy7b29DLt3pXIOofbQHPPunT2b0baoS8i9OB1C0W+mLMko7WkyiY57d2NH6?=
 =?us-ascii?Q?M/1x7L3izdA67Kc0oNDXaAHUb3sM1xL/Uh4v5byn5DjyPN1/haWAUY9gKC+O?=
 =?us-ascii?Q?GoiIX9LqfgOZMBslBdTkV9EsPbIyUhDav2/iGXfqhy/GeO3u0Dk2aOuO489q?=
 =?us-ascii?Q?35XlyLeEFFnPUoAeda/qjzO+E5Gusqdwxbw2lJbZHGtKu+t8Fta9ea0b2Du8?=
 =?us-ascii?Q?LBOQtRxIbFD6AyBL8DMxhRIOSRPtpM1hCBpxmKRDS07qqcFkgW3A5e3TkrAa?=
 =?us-ascii?Q?xbdWA40NMhASSJXSLOi8pGS0IBsZ4vQfoBd2DLKvtUmYke9Y1YuKgVA5f78B?=
 =?us-ascii?Q?p/YUaZAF/AYQbSpWe2MEYP4HQSsQNYySLg/R7OOu8jZGSoNCZ+gniGGjAwaY?=
 =?us-ascii?Q?MLKLC0Q3gIKfUppnp+urEUKftGbD3uirwasWrWcHJ1LgL2nAVB6rMosepeD3?=
 =?us-ascii?Q?cZWP0C7p15YRxUpAsvA3tZeuuOjyOpkuXzPCMV3m50E47hIUBg2FINwIqWq3?=
 =?us-ascii?Q?5fLnMfEhDA8qWibBxjvgNhlnfScBqs/UIOlqfCRquMq2GHzNWTD55CY/JvFj?=
 =?us-ascii?Q?LR7Z0op+VmVjv4xNXD6UcyzL2+TO0N8YDVWYWzHrQSB3twzWth3sUDqNXr0v?=
 =?us-ascii?Q?yFGyrF0dR3u1ZF3p0qbPox6NwqhoRI7MScbyvVliKBoPPdFFaFYoZZsXrkol?=
 =?us-ascii?Q?0CRjKW18PRrWn6vwT8g2h9N95pid2d/OrhecL7OBepHkLf1OwlfObdbPVyfm?=
 =?us-ascii?Q?BU9eRpZFowKg9lf5qCB9jpWtP+6VdkFF/OvYUHIxbdOT6RxV3/OpMKu7lLuO?=
 =?us-ascii?Q?xBzgHdwNVhon55AjyWVkaA3FNZGt9AHx1GJ4RhifgmdQP4pq4ujoKr2n2NZq?=
 =?us-ascii?Q?7WCrEOfDN611RNVTwLEtDRJwSd1fYJ4j1YTNdcjwVKEygHlVYaSDSmSL+knu?=
 =?us-ascii?Q?ulJPPVje4jVF8MdikHpZpvlnjLEpxOvTwnRsWDgO7uTbUMzKfO/gBJLHiLja?=
 =?us-ascii?Q?07CQkAuGcJuSvyuDDxS6IrXjwsmqHsrhKtl/CdZ7zgsLPj8OPoExQahfDzLD?=
 =?us-ascii?Q?jB/cN3rjtTIyfCX4ZkTdXwgnHPkPpCNLm1/M9OC93cA3czUdZHubRNEX24PN?=
 =?us-ascii?Q?lCRom2YMY352v5a3M5dZjWHeX0mzAY3CbuvFAboIaz1u5SWO0ExsfxEw5aHm?=
 =?us-ascii?Q?+e+qyOcriT4jtUqi16pqa0kQi/kTvDXi4K8dA9GyYZ61f/ndUDFvlk1JPxg5?=
 =?us-ascii?Q?jdOMgAQjsB5vsFjx1razegfg697DkBoy4dQaPO6ZSrfyDXR7FSXY6oL6+qrG?=
 =?us-ascii?Q?d86rDN/Y1bpRdX6aUhFy3wsRE4pfeiEBxN5f4rpzNFMzgHoDgG7m6dmHy0Eo?=
 =?us-ascii?Q?qEBEMXkYALromrA5jNwujFWyFtWDhVaYdhDXikSlXmuiYeJeJlUPRTVAWw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:22:32.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0ff309-d924-44c8-eb30-08dde5109453
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7827

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

Add a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
which fixes the case (2.) mentioned above.

Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
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
v3 -> v4:
- Fix typo
- Link to v3 : https://lore.kernel.org/cgroups/20250826075743.19106-1-xupengbo@oppo.com/
v4 -> v5:
- Amend the commit message
- Link to v4 : https://lore.kernel.org/cgroups/20250826084854.25956-1-xupengbo@oppo.com/

After some preliminary discussion and analysis, I think it is feasible to
directly check if cfs_rq->tg_load_avg_contrib is 0 in cfs_rq_is_decay().
So patch v3 was submitted.

Please send emails to a different email address <xupengbo1029@163.com>
after September 3, 2025, after that date <xupengbo@oppo.com> will expire
for personal reasons.

Thanks,
Xu Pengbo
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..81b7df87f1ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
 

base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
-- 
2.43.0


