Return-Path: <cgroups+bounces-9414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D67B35793
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971E31B637F4
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6369C2874FB;
	Tue, 26 Aug 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="qn9aZvXP"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012045.outbound.protection.outlook.com [40.107.75.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414483D984;
	Tue, 26 Aug 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198155; cv=fail; b=tLGTPj6TPjA2UtaeANLT77su7lnQpHi1Sdzgq12k0KQAMpAO6QurQ+wPeXw7dry64fWHjot9TzNej86/txcGFAjoGGz5oyV/ZaCKEuRFICoMrObdyWVAYFj32xOpAYrSD8SaVeEmtOgWOtYSTgK29m08Wj4SWzV+AYO/Fs+ZI3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198155; c=relaxed/simple;
	bh=nbLdJTM+3hcL78zONX/5oHkxWwyfy826ichOmF0xPYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5PG8qvJ2wnE7oHl/rD3tat0f+NWn/nSXYSmB4f+LYomDDLvst9tKwa6oys7+GLEqqFHU/eTa8toQKNxg7ToG/xGACqqiJzZANkXV2dxq/s8tQHB1JVaBIn4W45P3Q9Y6bH0M9c0MYTvEl6fnS7pHzTZgaWL+eDhGT99gXVo2GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=qn9aZvXP; arc=fail smtp.client-ip=40.107.75.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTtg30v0opxyvm231RBIhZZy13hkg1+d1mpIHzIQirIPi5wmCunta9jmBc5H8bZ6VDkkf0pd1s4XnNzi/Tbt3Z/t1rzROX1oj7EppWRQ5t+Hn3fbtqpo1FeCfdSSJLWNSEYbymmOPjigw7w/Bv7/NkaaTDjPiYPPY90OiV+IsuEELo8iWlCjYIm/Eb066vpmcoSJvLu9d7ppnilhkuLej8W2euUEjzHFvV8lSaDREaMWk+wXBMQgsqv6qkLeajd9EkfjzedOlGh39zwc9L6tpMmW0a0IGmVjKYQKaSC6HSI/3tbIZ3vcK1z0N8XnRLgH3c/7FeCh6DMgC5CZxBGjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7MizEhBmlqR683y1Bnt7x46s/mhANoAUzzf4sCUf2M=;
 b=kyBSA+JHmle+jG/2V1pTkaHXbuwuTTGfQ6fLhpdk7M+F6ipDebHPWpxbTMpg3/1Hxfu8NgOs0CoT04IS7KKLL0nv/s1MqOOU/644eWP7oyqQzeWyKLb9t7jGE/mt/0cITZkdQurS0IjGq7UMqt442AXA4h1TqpgU10XacvSQgXYEIeTU19CwYa2/SIFqbbT5vP5Dds/PaTvDL2qJ6jipePZosw+Qq6OzeUj2CMyY++FohajdYTNvOkQXSchF8bSWitXMEbMWQ7AFjn8HyRM/mJtjfkXNCJMauV6BuZZzcHdvk/YGNyKtMhhRDdlayWIUhH71XtytAbZkUjL/wVI8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=bytedance.com smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7MizEhBmlqR683y1Bnt7x46s/mhANoAUzzf4sCUf2M=;
 b=qn9aZvXP5M0NwzcDQADL1TMh9XwUsmYR5Oxokfs8P1bwwweVfuE/FR8NZKcEftkXrwJU0p0oSdjZQZdemnluYcdNwc77njjTc2l/KkD4mVgkl+3kDfMKrfj1t5CEgXeLc+iUD5Drx3Xs55QxY7xoFAIfUM29RIJFC70MgbW65AM=
Received: from SI2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:4:194::14)
 by SEZPR02MB7495.apcprd02.prod.outlook.com (2603:1096:101:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:49:05 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:194:cafe::ba) by SI2PR02CA0004.outlook.office365.com
 (2603:1096:4:194::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 08:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 08:49:04 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 16:49:02 +0800
From: xupengbo <xupengbo@oppo.com>
To: <ziqianlu@bytedance.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Aaron Lu
	<aaron.lu@intel.com>, David Vernet <void@manifault.com>,
	<linux-kernel@vger.kernel.org>
CC: <xupengbo@oppo.com>, <cgroups@vger.kernel.org>, <xupengbo1029@163.com>
Subject: [PATCH v4] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Tue, 26 Aug 2025 16:48:54 +0800
Message-ID: <20250826084854.25956-1-xupengbo@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR02MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf5f296-fe78-401e-ab22-08dde47d6999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wBMhRrZbPytpbSYpwSESwIjLvQkQhUWahn4OuTtsw2LEmV5P7T6BdEUVr/QP?=
 =?us-ascii?Q?+yoTB8nlv/mJYZlTyLC7WUj0Hek10fsDVGkz7qKLxAD3AyMPmTQy87tFEycs?=
 =?us-ascii?Q?hEeI+TuLlScDrboCjsiCKTh5BeryZ8EobbQB3rLl6UDWFSeu8oE/dTH2RwL2?=
 =?us-ascii?Q?ePfTshxIjxzG7QihEg06DwFGFLlYVxUOA5rw0Y0d0YVCb4XMVnikVLSIQytA?=
 =?us-ascii?Q?cgdwgSiecKWWw7NCJPwc5xfdW2E7AxpxHlvBKolpssQZI+bP4shKgxvKOVws?=
 =?us-ascii?Q?wOYB6umQMvGuoL7HKzRCbv0HQKlJuL5XzwcXCRxGTtmd3eBuJXGA8Hwxkj15?=
 =?us-ascii?Q?bqqAvGCxjYCPEDDKFHaMVnxth0XhVVT3jCZ15r/jG/RfOIkFPkoBM/5nRENs?=
 =?us-ascii?Q?fimA7/tQ2953BwEyiBN35ozRny+AlRg8VhB6tH4h9dL7mK8mTnlAjZ35UEA+?=
 =?us-ascii?Q?EfFu78yUf/gwUgnQB6JWLceI6NRRNksdO+AJRLyly7/goDFJfEFJGl7skAqu?=
 =?us-ascii?Q?MvbmzNugOxOHvOva7oNRnFtEq4VP0+JLV9I0WOmEdO3M5A9HNy0gKD3Z/7EJ?=
 =?us-ascii?Q?frIhVfZD9WtlLllqZvwBLHNpQdR0HIYyomE3aYg7GM5dnUxn3vLX66iU39Ys?=
 =?us-ascii?Q?d77/Kbtxc/99ObDQOuzZR0Nnuh9IZwlRNBa3G0HN35ZrvxBNSrRt2E1s/c3m?=
 =?us-ascii?Q?fGm1hvhB+kiBsQxmcxSEBqsiInUX0rxdQ5ugfKqtQxniUwX0pQFxmVzlnn6o?=
 =?us-ascii?Q?hKBUVyzPSLQ1UTFBIPdtAKm7GG0GpOmA1ACjxUT8h++MYaaTasBXfHDE5G6Y?=
 =?us-ascii?Q?8LBujUkpqAvhNjjBi6iZUnBylv9wIdEweFLsuobwBbFWsjyU9Lwu9PLoPV1h?=
 =?us-ascii?Q?Ut7gr8fH+QBedRVTfOkDIVX0AWgmtHs1QOpTrwZ/cKsovPohv/xHsGwjLdSF?=
 =?us-ascii?Q?iTSphk0X2GQPQtOskfkslZkeKOuq2Y8om+tusxUQz7zYuJC/OTW4XIKuUkNO?=
 =?us-ascii?Q?3DFMBMzABSnuxG1hqh00XKtDBZrNkR/iIyicFeTgIcLjii9MfDKycHtmK1BA?=
 =?us-ascii?Q?gX4RKVq8O1DkvTl7F8+EfAVx/2BhM7eisvoXgZiCSKtHneaApD24A/2zBdNN?=
 =?us-ascii?Q?5AC9NQuCSQbd+I+wuPBFVATu3W+GkLP0bu8oNFuK4bx1F1CVf72uocYnCjde?=
 =?us-ascii?Q?DCsOiMqhpe05HZkfr98Ufv/vkfcA3LquYGFO5UJKwS1dt5Pg/4OWaGHdgHFV?=
 =?us-ascii?Q?5AD7jMa5GXcSBHnnzdtFda6Pq62hEa1W3kuLFIiKtLObuDEaJD7MV6Jq1+tn?=
 =?us-ascii?Q?uwrbZJ7pUnkgOKE//0GkGe0Xy9RzqZStmQeWUk2yz218CMPEo6O9qoDOgNos?=
 =?us-ascii?Q?fS6YJXI4LfpnPLOLcjfK1+mQQGkD0D524oNVMMBrzY9Fqf+ELMaIVEn4CZ8o?=
 =?us-ascii?Q?GmFd4uN+Q5pCfG5ORUuwOyUxeD7WPAp2uYkagNMf1PjXVpKW4JKgSfoN4pGo?=
 =?us-ascii?Q?cPd41A9IJ+DRc0bIj7tkk1nehS7kGRRECverg9MXeZbszlvBKSWXGpxR+w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:49:04.9138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf5f296-fe78-401e-ab22-08dde47d6999
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7495

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
Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
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
- fix typo
- Link to v3 : https://lore.kernel.org/cgroups/20250826075743.19106-1-xupengbo@oppo.com/

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


