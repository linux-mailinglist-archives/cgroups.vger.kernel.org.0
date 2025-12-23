Return-Path: <cgroups+bounces-12604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E4CD8C82
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36772301CD3D
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065B8361DA6;
	Tue, 23 Dec 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nc2tCrbC"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CD3612F2;
	Tue, 23 Dec 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485485; cv=fail; b=h82bcpvqoGOZwVCSaKlXcQ2/P3VnPvijjZ53JxVT+kmLbEJmahqVPfCQ06xEzst/90jLsIKiF0pa4QNXbp1GpVWMlmBaik+wJIZynwceSHsJWiaAbVKUiIzRib6QFvvwgwzvZfMoUxzT4ZKCdjp6LGhFh2cNGFsiFdYFmOYh1yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485485; c=relaxed/simple;
	bh=2qfSVtOHaou6p+KuZbCNXmoo8djRZ2NldPwgpZiVtEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSu2RL0k/8MPHkGXtZX+XHgg+Ddev3nf6M7/nsdWI4K8EepiuKWgUvJFdINtsrwpQlldZB5fhob4rNsNLmKWoosSel09+etYQ0YmV3bi5G3XpRu0Ak0rL23SaLbktqF6vxmqnGIdWlL+t8MYBx/CirELw+m0GUU3F4J32HiDvZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Nc2tCrbC; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijx5fGNjCZqI7FN3UzYys08XD+IhSYFvYNO4M5jX6aS1k3wnzz5xoprIdqpwpiaehEG0nD6sBW+MYsf4rQkqNEb6VE5Kgv1m4q19iPqAKkTBFw2lpblWMFGkRAXcrpD8Nd74ilKmJTRuDhsjrcijIurEmH82mGolGFzQZ7mjHoFsq+0y8d1QgaaOfXlrDPplxP7qjdBICXQUC2asM5nAs5opnIHGs3RLAgoHSBWrbh5UrSOo6B1lHL8V+UG1yqkUu0HhaH6QHrgIPos2OSu6NoNHEdRQPm3WcZjBIerU91kdV3LypiSngoIRdhmrHVbPzi07bPvFmtR44Ayn4DSj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ovjwuBu3f0a9ajGD+mZFuQqGxvrXVqUdFCMsmR+wwM=;
 b=BFV7UPxHmMQczvoBumpbSfPG+0CPFpkd+3wD0RKBm8OzCNXlyqp7xBz3NKKrnbT3mYFWBsLkP9OM4H4PgvX2y4n5n0r59w29pBnDddik4qgiPWS3XBFHKaBh5jp1ThHr9tssqOhP45P/6gZh2Oq9YhmkKKYwQVwqZLzJq9XJy9CmMdBSke5iCehtLfkBZWErDHIjipoOuSLjLbrg37GC6r+ZhoY/EUsB36VZpCoVWIiK68A4fPbVrU7l06dmgrvHfbRDf3eJOPd1TyTwQiGiULJTw5sP5Ylv49RqfVFF0kcJyDzjJqqW+Zok2KILYCnho1U2Ffgm9ke2mux/JaY9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ovjwuBu3f0a9ajGD+mZFuQqGxvrXVqUdFCMsmR+wwM=;
 b=Nc2tCrbCFT2FwqxfH0HbBA1UOWUysiZjpf0i2PRfCFtIKvmKPS3+J1Uxoq9ov8ZURgNexPTr6360FDaHJoOA6bBs10VWO+SD3xG8X7cFufl7MiO8hzl+mqiBYUc60M+VCJpCOtYMIDn24OwDdF6rrEIT/ou2qaUoTkkLthjc5NTHBrTXJSOkj7NldwTDJC7FGpGYEau6n0LjjSspInhdMoxJuJzCKYDmhGki3Zb7AF5+HpFWObHGBtEQl4VdCV0vjfzJ8324z3LtwdogPmdR571jq127/ojQpDaqgX5OkMcmy/L7/6YTHMguSWz6VRE8KJNstD1yU1VBTBEsQKRMIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU4PR08MB10910.eurprd08.prod.outlook.com (2603:10a6:10:575::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 10:23:28 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 10:23:28 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 1/2] cgroup-v2/freezer: Allow freezing with kthreads
Date: Tue, 23 Dec 2025 18:20:08 +0800
Message-ID: <20251223102124.738818-3-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0028.apcprd04.prod.outlook.com
 (2603:1096:d10:25::12) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU4PR08MB10910:EE_
X-MS-Office365-Filtering-Correlation-Id: aa476028-c582-4d81-729c-08de420d5066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5Z7oi8lyRPy0sowb/2wGGTZz3Un53t58K+qHcRoy+pORBA1deuP+J0XeuMx?=
 =?us-ascii?Q?yWrMWCXcyMFZYwDpHcvhJMlAU2+aBmWM7fF71MJWj7hxKodMyz3GqOD5MSzb?=
 =?us-ascii?Q?jG9Ug7pxkoWvjXzkMAjF7vjmj7fY3NkoRQu5e3FgNs7VZCbImsMoh/jqRbZo?=
 =?us-ascii?Q?JGL5+xyo75jLRV7bUv0zWdWvAtqN+nHksyPFP8r9Ih9J1cMc94ytKErGUkkw?=
 =?us-ascii?Q?08Gr7Za781UTPm4cq5bLrUb+AukcSxPI1Qbz+Ch0jDAX8DEhQmN51pDtloTI?=
 =?us-ascii?Q?qXBwqsuaTJQBqIAOqm6esCEHtNgQmBXgWrrsQPcsTg9ky2Z4r44jtqJ/+wu5?=
 =?us-ascii?Q?D3BHtQpUeVLiBi0M2R8w9QJKUG439xqULr0WmRPXW2aIDyxmV+wpK+Ice7KP?=
 =?us-ascii?Q?LPmf01laMblhl5MFgoFaJhI8pnEO8v8+Mvr+K/D9LDGRtBVxKBXnT9QmZyQY?=
 =?us-ascii?Q?ZuRe10I2RAWBskeHk7EEI4Y5xXs7M62tmkqUiqz95JaZwaalvZBQflpvqtIY?=
 =?us-ascii?Q?wHc9czoB2BQm4HcOgTIqbJULg6Cb5W/Pnez7q6eCCUkRlsBIFtNq6fu0mUMJ?=
 =?us-ascii?Q?J1qhWy1WYb30OvqrkE7aOllz9pVgScuPgIB6wYtyOtcgCct7Omns790ydnHu?=
 =?us-ascii?Q?EY//GzusxftaGrsHKt/ykuJOadpkgcpY2lQYcd3CgH7dQ1hw08lF82ULm3Mb?=
 =?us-ascii?Q?tjInrsMGMU0XUsiK97FiSE7oCWlVki4eUSIxuSjmHfUWOY5x+jAOhtY17BUp?=
 =?us-ascii?Q?F1JMmYldcGC5P5jDNaHrqzrPC22VRzSWI5c9m1DbIGJFwPuC6CtXoph+milL?=
 =?us-ascii?Q?Xc+kOYgZdiU+7QzvdSolRYlCI4W6SIAkte99TtH2kF+MkBbnlrEs4eY1Gz68?=
 =?us-ascii?Q?rHQqxZa+ETUR7X1kTd6kfMAo82+iboHFl8/+YrAvoygprFVx8Qig7hshMT4a?=
 =?us-ascii?Q?wWBD2TXt9nLafq6mLcU81rQi1D4vLoffb9ezQhMdkQgVPUVSX3OfjjZRKZze?=
 =?us-ascii?Q?7Oh60zD/kedB4+VF/v2bf7V3Q6gsoU6zBt3HMKdggo38dBnr+kgKsNbQlwve?=
 =?us-ascii?Q?qWdtwKvF6SsuzsZ/pqc/FmDk1CNgb7CUksjs6nP3+bapjFVkQ6EktgO5h5ZL?=
 =?us-ascii?Q?++Om+Yu4KyHiOyo1Ml9GMy73gWiIfAdnAA7YvkwIAMudZ8cO+ShQVh/jzb1B?=
 =?us-ascii?Q?8vEFB0U0AzIxZl7W8rbW6Zs7b+RvH+M061GIqpHIAO8jfTab+7vvJ8Ag5lLY?=
 =?us-ascii?Q?Z7NnqSUlb+/oeib/YHYaZ12U39msW1TzlhODE4t7xUMqMZMd7bAeh4BXu1WK?=
 =?us-ascii?Q?1xxh1TWNEZkEuNMAOB/K8GyaXKpUa8yxaTbpomDfutrUMY0pV4ijiabuXvTF?=
 =?us-ascii?Q?enG2gBL8X9W1kWIvyrXfhnwj6UJcQ1kj9znZWRt/RNr/BXaqxg3CuxgmNoji?=
 =?us-ascii?Q?bWgaU4ewDliIloJhO5/evcC4vR878Gys?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AW/5ereZeK3s+mGjXEL68XKLdIcLzRcktE56C++2lFTuZUgPoB5uEcJA15iH?=
 =?us-ascii?Q?lQiY3ORwmhIYx3VJRjIkoxYsHK0h/Xs8qXc9JrsOli+Kuy+fugImNByRjYTI?=
 =?us-ascii?Q?cgmQ6okWKSnof7s9MgdCkhGA2M3mzmeser4YCQhVEdF8GgVgKHtEYVyMSNE4?=
 =?us-ascii?Q?FuokN6EImPhf0+dPZ59z54gMTGxPEz+2qBFRzi9Cf62fBn+kOUPQgjSJ/Ou4?=
 =?us-ascii?Q?EGNl7BrAt+E6b2cL/+JVHP3BJagYJq8U1c+KoYNvgR+GSqBHKguz07gm099P?=
 =?us-ascii?Q?Dbn9xWO5LWI8tWVuDYkfpcgqInENCs60ixXECDSiweo1THxKqIxWMTUNpXMq?=
 =?us-ascii?Q?KFJC788j9GL9HknckI5CIJbzE9KEBKAGLGvnygJSoQ2QAYCZOfH6KVW1soD+?=
 =?us-ascii?Q?fTPaoYlxdWZpG3euEK2fpilrs9scKtcY7InLkULf6sTOXJ5yUkm5gm+YtyLg?=
 =?us-ascii?Q?kocpGxw5q1Y7+Kwnn/p0LenF0r+oxdX6HzBt9AI+UTbilpgXBu0hREffJ/vT?=
 =?us-ascii?Q?qvr2Rcw1QwlJtbmRfahZhbSCkHhi2IhMHJWiQ6vO8W9aTuUOJ/jPL3339y7y?=
 =?us-ascii?Q?BJwGlJZlw51k+IjsTAOedAeWNtZXc2PFdvEqBkD8BuQoPh3rZm8zXXLuvpEY?=
 =?us-ascii?Q?VsYHju8u2/F9xndqJBMUmXyjzqPvriohMJWjSKPUgEEk+99mkCwleV2bwRca?=
 =?us-ascii?Q?ggA9mP1+u0QN9kwwqrdJ+3IrrIkD2qYltenvPMXAz30XvO/l1aWQq5pjy06i?=
 =?us-ascii?Q?G0Iyf6ghRaAwblu58EvUTDSXQp7XOQGiRlT1OCi7c8MhrmVJVGb+KhfIZVZs?=
 =?us-ascii?Q?I1KkwQXKZFz4o0zgvGlxc9HSU4jXwnLv1hFFS0eyTcFMIQ1CE4GedqN33M8h?=
 =?us-ascii?Q?KPIG7NyrvZEroR9iSXaTbT1D844dDcm60dPhAJnJP4fExdRkvrh5Qr5vgias?=
 =?us-ascii?Q?wsI2tUvFku3j8C0suRRO0bKl8ZV0dD+HqbrCWzsJ6PiyHNZHX4Gz8BPTn0zR?=
 =?us-ascii?Q?uLB7/nvxmqrlkT6hiieXnAKr9TuC8aZjjUYKQ8IQJL4rdy166cVL8WIf5puh?=
 =?us-ascii?Q?co5GnAppUlIjjGy7GuY8FlpmrROCYFxMrH9xPXyFRkaorwRmoMCtyfnoCxfk?=
 =?us-ascii?Q?S2A6QgYeAndCQjHCG+fW3okb4FHTbWA64LWfqtQI0L1WnOJDxfqyLeI9+8WP?=
 =?us-ascii?Q?ouX1+PPKksUVLarWCgP1R+L6k6RzQUU1VG/ABDgKEYXQ4ZQd2EUOMoDW+GhG?=
 =?us-ascii?Q?/Ll1RIEbMBS5ufHP86cwR5VQoEp1/BnrYkCT6GBv2RC72/oCwkpjccfqu4DY?=
 =?us-ascii?Q?IrBEH1kCwQnTKvwN1xWBm01iStCmV6eSlGuWDG8oxi77NqHSrNNX7ZYhkV4c?=
 =?us-ascii?Q?8KWZ7aRPXso3PAhkq83KStNej7+qAOm4F2w/0PR39k200qmfAvTfiwRwVPfA?=
 =?us-ascii?Q?y+7nVqvT3Bhnvqp6SUC8ziLVGK0exjtUmqbo6/3jQ14ZkzTi+2GGFmiihOMG?=
 =?us-ascii?Q?4OANMh3wnLlCkHjlNJGs/1bx8resSB5EaSnqo+i/Ppy9RE9M3lxGQPng7Nru?=
 =?us-ascii?Q?DcQSJfxJnetRCurpZmZ1+XQaDK0/JN9dVVsEo2tShRQ5KKj/xG7h4XRRVS+6?=
 =?us-ascii?Q?51KUFzO+HrfaIgQZOStcoePX9THUpe5tNvh8iclaLiOw01pNQzntlbKbJwEM?=
 =?us-ascii?Q?WJ+52q6nxUUjvSy3uOxyDiJzsB0HeUnEvLllc50Odes6xwzBgMQKjW34IbMA?=
 =?us-ascii?Q?Qi3kb4fKrimWhRlTx7h+CM/ltJzg2cr/iqzT2+1lUBWJSbROA+E0dddHjT5K?=
X-MS-Exchange-AntiSpam-MessageData-1: 4jnk1ePc1ySRC9PDmVQ0VzC0mscKqE9Mc6k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa476028-c582-4d81-729c-08de420d5066
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 10:23:28.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wha1hONg7dvOiYWS6LYvv1IR9gH1169lRahhVdoT/sLT3R1/vOFpkMzGnyfyxQp9v1VVCx23BX3V8NtdtOFVnrvh4CPBpC598CpnlFt9f4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10910

Cgroup-v2 implementation of freezer ignores kernel threads, but still
counts them against nr_frozen_tasks. So the cgroup with kthread inside
will never report frozen.

It might be generally beneficial to put kthreads into cgroups. One
example is vhost-xxx kthreads used for qemu virtual machines, are put
into cgroups of their virtual machine. This way they can be restricted
by the same limits the instance they belong to is.

To make the cgroups with kthreads freezable, let's count the number of
kthreads in each cgroup when it is freezing, and offset nr_frozen_tasks
checks with it. This way we can ignore kthreads completely and report
cgroup frozen when all non-kthread tasks are frozen.

Note: The nr_kthreads_ignore is protected with css_set_lock. And it is
zero unless cgroup is freezing.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 include/linux/cgroup-defs.h |  5 +++++
 kernel/cgroup/freezer.c     | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b760a3c470a5..949f80dc33c5 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -451,6 +451,11 @@ struct cgroup_freezer_state {
 	 */
 	int nr_frozen_tasks;
 
+	/*
+	 * Number of kernel threads to ignore while freezing
+	 */
+	int nr_kthreads_ignore;
+
 	/* Freeze time data consistency protection */
 	seqcount_spinlock_t freeze_seq;
 
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 6c18854bff34..02a1db180b70 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -73,7 +73,8 @@ void cgroup_update_frozen(struct cgroup *cgrp)
 	 * the cgroup frozen. Otherwise it's not frozen.
 	 */
 	frozen = test_bit(CGRP_FREEZE, &cgrp->flags) &&
-		cgrp->freezer.nr_frozen_tasks == __cgroup_task_count(cgrp);
+		 (cgrp->freezer.nr_frozen_tasks +
+		  cgrp->freezer.nr_kthreads_ignore == __cgroup_task_count(cgrp));
 
 	/* If flags is updated, update the state of ancestor cgroups. */
 	if (cgroup_update_frozen_flag(cgrp, frozen))
@@ -145,6 +146,17 @@ void cgroup_leave_frozen(bool always_leave)
 	spin_unlock_irq(&css_set_lock);
 }
 
+static inline void cgroup_inc_kthread_ignore_cnt(struct cgroup *cgrp)
+{
+	cgrp->freezer.nr_kthreads_ignore++;
+}
+
+static inline void cgroup_dec_kthread_ignore_cnt(struct cgroup *cgrp)
+{
+	cgrp->freezer.nr_kthreads_ignore--;
+	WARN_ON_ONCE(cgrp->freezer.nr_kthreads_ignore < 0);
+}
+
 /*
  * Freeze or unfreeze the task by setting or clearing the JOBCTL_TRAP_FREEZE
  * jobctl bit.
@@ -199,11 +211,15 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze, u64 ts_nsec)
 	css_task_iter_start(&cgrp->self, 0, &it);
 	while ((task = css_task_iter_next(&it))) {
 		/*
-		 * Ignore kernel threads here. Freezing cgroups containing
-		 * kthreads isn't supported.
+		 * Count kernel threads to ignore them during freezing.
 		 */
-		if (task->flags & PF_KTHREAD)
+		if (task->flags & PF_KTHREAD) {
+			if (freeze)
+				cgroup_inc_kthread_ignore_cnt(cgrp);
+			else
+				cgroup_dec_kthread_ignore_cnt(cgrp);
 			continue;
+		}
 		cgroup_freeze_task(task, freeze);
 	}
 	css_task_iter_end(&it);
@@ -228,10 +244,19 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	lockdep_assert_held(&css_set_lock);
 
 	/*
-	 * Kernel threads are not supposed to be frozen at all.
+	 * Kernel threads are not supposed to be frozen at all, but we need to
+	 * count them in order to properly ignore.
 	 */
-	if (task->flags & PF_KTHREAD)
+	if (task->flags & PF_KTHREAD) {
+		if (test_bit(CGRP_FREEZE, &dst->flags))
+			cgroup_inc_kthread_ignore_cnt(dst);
+		if (test_bit(CGRP_FREEZE, &src->flags))
+			cgroup_dec_kthread_ignore_cnt(src);
+
+		cgroup_update_frozen(dst);
+		cgroup_update_frozen(src);
 		return;
+	}
 
 	/*
 	 * It's not necessary to do changes if both of the src and dst cgroups
-- 
2.52.0


