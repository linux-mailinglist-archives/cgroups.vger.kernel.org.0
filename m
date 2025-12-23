Return-Path: <cgroups+bounces-12603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D5CD8C7C
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 11:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F7A300E02B
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8E3612F1;
	Tue, 23 Dec 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f1FRR6A7"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81B3612E6;
	Tue, 23 Dec 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485483; cv=fail; b=h5V20aZhs1MZCtNVvjP7bgS7pmZBdQ2fOul1gbMEldrILw9JBrr63l/0Lp0ADQ2/chXf0lSakRHjrLfEy4EWKmoY9PolBts9aiwLtgDebtTL72WVtUdGIUZba7JG7GI5WwszmFX4MwYsRWrmQl+t0pvbPjw8nfAOpdO7+vKUbEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485483; c=relaxed/simple;
	bh=jNI0X2w40p85AO7rEXoUApjWRU5b4prtvmopK0gu0k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/dFEp9+5shQDKWuj0n9fPxDpV1Yu/uxPNAihda+7vfJ6oDaHUPlGqo9MWpG2OiJ0gt4UvgF/+qGePShwu8xFRHiR6yJDcqENmkA5/8Pk42mX8MUzkwUUTIiZlv1GaRRtjDhXChhV1yocPjzKPWjXnnxSpubwClCzcHMRMWALnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=f1FRR6A7; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+joKmWr/dEv0JZBaqsxGKtaMFe2RNFwFr0dpyFfQq9gnzdifxCPpMoMCGSbKpYtaIMIzl/jur2iloJ9HleBe8IOvbxc+U0BLxkuZfGF51297m9imW8Jgs5OvYIcpKbb2tDSenEzJTP1QLuRA0yMzwx4TYxl5z1gd3vHeO+P4FZBvAujc3BJ2GYeTppfygMAATtJcFEYv8xJFJIAl8J0oH8i9gFyQpEaQvmqzPTYBKHLQ2SfujljdaoFEoGfCax/4+bA8VB2Hq8/cilva1llWV8KtGOvuzroH5koAQBIY5QfI7uSxF/I2CStNkL0ex9Ob0r+ZUZt3n7fPGfOgDaYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWA4HCMaw1KOjSpz7q1FWv6oZn36rGxvmwBHHEL5Ah4=;
 b=AkkQ3uy3Ym8GuVBKUUAWimfegoPC6OAcHP2vTU8CZxEq2I/1Gjcgp8WjZAZII+ZfXoV0f8cCLLSS1ZhnCINkxyGQy+wC1nsBsxyZobNYAotCaRNPuZqaFvZXsII+wU3OtKxnnUVhClJkwOI5JM5RjUCNDYsxZQ1zrAaDLdW9L2RZ2hmjgRjNq2qlIhJQ7+UtCH/jQSJcTFvoc7t62f/NzBsKEy/dCA8ldBbPi5o17OYIF6YiD184IhTWEQM2hjdJB2ZPybH/S5CYa5p4RTv6HV1PDsMgv30Flau1UgQh+txpKwx9BgedmD1+qfd7Ein5kzbESFr664xnKT5kab1gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWA4HCMaw1KOjSpz7q1FWv6oZn36rGxvmwBHHEL5Ah4=;
 b=f1FRR6A7coLM9lyFuYC0GTsgV26MbQYoUhTWdeZKeQxRtdFMuXGi6+0PkScZWCPMHmGrHU4SP0KW5HcMVOk9RynKvI+NQPIlJrH4zwQXZzbkeMhMwgIxTQO884okWRBSf8t3q79kygd5ZyiRlD4iMv2Ded/XfuBblMGv1Tb28jjhk/Jb2B/AWRfHUoojRgJqHOyE/tv8InWKEsVkL2mMVLkz4hqeQmBRYScE3wtI4rg2H8ZgGZsmMeE/Mt/NXTCVuhKt90gf8LHPl7b/mbABHABob/tLZWO6RGSQO3qMYT+2oyhhIrHNt5DdnaiYHMmDqhsHiaUkfZGhOH3Sz/gfeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU4PR08MB10910.eurprd08.prod.outlook.com (2603:10a6:10:575::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 10:23:26 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 10:23:26 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 1/2] cgroup-v2/freezer: allow freezing with kthreads
Date: Tue, 23 Dec 2025 18:20:07 +0800
Message-ID: <20251223102124.738818-2-ptikhomirov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a59d3bdd-db22-409f-46e4-08de420d4f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tA0wnS5jnv86ngfV2++zsdw2ySQXosWEH8vB0SPImsO3YAVftH2KxU4hITUK?=
 =?us-ascii?Q?hZG23+dlGgD91CNJNZ1N6Qc6Y4RSqAWx7+FOGBy+EZgQitfBfUu05/GdMN+M?=
 =?us-ascii?Q?sjosV9l3hqwWW0Jg3A/4O6TQf7UqiHU1UlRRX44Wk5uchv39ocl2lTzs530B?=
 =?us-ascii?Q?efrpvotF/FxE1Jdw/yUOoRTMqy8H7NHz61zV1mPeTwjOl9uOLFnjKR2gejz/?=
 =?us-ascii?Q?/++07zwGkb6HcWPEHz4YjLIoQV8rrGd6pAEBoEK+AxmhhjFxwRlV7bW6Kfj6?=
 =?us-ascii?Q?cZt5ouWzZuwcPzzVlayjXeOcoW3kTDSeiODwBVyAsRAMApYV6whxyGZvF26g?=
 =?us-ascii?Q?Vwr/WLym7AbjlT5epnfbPOC9KpAJKC+VenHdcpiUbDtNuSsW67+Lx8WOU1LE?=
 =?us-ascii?Q?/1OZH7lcCIz3cbgrDsjElpvHTQuG7L91VlvSIvxvdS3mwmWfKLo75dVCYILD?=
 =?us-ascii?Q?MLLCy3BBRLOdcxWQ4UAYhDzhqZ/QliQsCnMLvCkotNMcsjfrT7RLb6ftjYti?=
 =?us-ascii?Q?vz/ypKUs8aiFkr6oqOk+7cjfrqBpmx9DFZzEX/u73Kx3+L/VsY3N2LxbJtzi?=
 =?us-ascii?Q?4y/1q143rv5MJBQthSJjNNof5nUA0wQwHXUruYcCS2ZplwZQ0L+XBReTyOdg?=
 =?us-ascii?Q?oh7HY7jyQt08+3weI1JoHo1vRzYQlshQ/mxPpfeVRzr5RoeXb1GCsH32hPtm?=
 =?us-ascii?Q?g/PTA0s6nlbG54voG8AKeGfRd+86wx3bzyu/8Dxs/EHNt5qYi6gQ2/kba94S?=
 =?us-ascii?Q?/snYlfaOKkg1gwIlxJDlVf4eCpfhgjM3i3fUXNZRSjq0FHLofBJEDPCBOGUR?=
 =?us-ascii?Q?9dGuO6YftpWCCOCpztou0/sjrxRxJ6yMey7M8drKO2HN4N17i03gqIa6U7ld?=
 =?us-ascii?Q?DkJ3AuTnnV/633dbT5MbZYidTH81XFaeNH8nNZEEXEiOgqD8VzowNtYMB7H2?=
 =?us-ascii?Q?oz6bXN0+Hspd1YL2SQiRJ1F+T+z3qa5yQXtGymnsiZjo0Krq03aXGTwzgk4F?=
 =?us-ascii?Q?aHfs/d0IjD4LEMYPtsgLEfEI8aMAvvHRa8ZqYXbSHUHvqJe4CzQ4JsVcL7bs?=
 =?us-ascii?Q?lyYQsUxhY9cFRiusD9GqpyOfvc/LS8tICrBidDH45mywzDkjttVfF1UlUGtZ?=
 =?us-ascii?Q?REBV/Jz785ca2T6zY+jxbnExJsRxadETSEwmbT2YMKNjlGAk/5g4cDSDSLSr?=
 =?us-ascii?Q?SIyfgGZ5VaV3eV6jQJYdGPJ0idmjCtTROAMxiyU1coenhde/155W9PlNaign?=
 =?us-ascii?Q?J9VR48EQGNvjvAVWFpQwCU67eXRwIme3srH5Kn7hbJcb2uNxmW7A17IvtDxJ?=
 =?us-ascii?Q?pyzTy8DzcsmlCRYyrxYX4AjxZZGnzSesSBuUFriiIHWP5yktPci0Wub1iUEm?=
 =?us-ascii?Q?vX61KPup+eXmO6bmVxCgeprQjOUJdOR9lPZh7ZHicLJB4k0GgeRO0VYzpyt3?=
 =?us-ascii?Q?m8tOaHtK9ymkwBWNsCRU2n5IwlY+wCmG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekYsraRGYzHa2o+HS8p/hUujL42Jh7C0FwUpmh8GuI416OPQmYN87qFUVNAD?=
 =?us-ascii?Q?qkdq+02vYF95Le9mFX9k+rO4RLrv/EDJgMiLwu6vJLNdi92+VAS+rioRaDA/?=
 =?us-ascii?Q?l6TO4CaOqg8oiZRJNDmRfHWuZJqXtKtuQjG8J10z8iZIU0yOqRj6x+riMWmT?=
 =?us-ascii?Q?IC1O22DZ3Svsb2XLvp171/eY3rmL9Q5b1VbkfRBcuVeE7fVm/+NX3edInJ2u?=
 =?us-ascii?Q?G4yt9QeLoLSmbZNRVGTJi1+GOdDHPMSU+821Taw0Mjjj1M2YTcQSo2kJzrpY?=
 =?us-ascii?Q?icNCUG6OnBoPoErZqqc001vpbKZG2SgYwiOAZPUesZUy6rtAoO/vJCMYBapd?=
 =?us-ascii?Q?sAgA/C/BkKRYtzJSJMz+K9PIM3FZCE/GNXrs+lRmzujXEhfuBnHSLgeSjV2N?=
 =?us-ascii?Q?kbJr81q3w8kDuHCoIoWtL0KwKtPN6DBkve7zyBQjl9kDXDlt8dC6MnPQD0Np?=
 =?us-ascii?Q?HiZAf74P/MDQv3l6r3hzhn4fDEJwASSztFkHigwqEze7+Ok4o2PSJ2vK7Kq8?=
 =?us-ascii?Q?bEQLsYndTdpcYzDpUPqxKwT4fkZn9wS4C+cMs3fJmKEKRXpTVA7O4Daa91tI?=
 =?us-ascii?Q?rG9EpTZ9V3wElF/1OMoRKhaWyOnCVxQMcP8Gs+ZgHUMsoOLbY49OQX/Er3pU?=
 =?us-ascii?Q?Xj6sVSpZHW3VdfDOFYQWHfmeRxvFQJXgXVZrBtrBoG2JB6DUA8/s5t0bfa2W?=
 =?us-ascii?Q?749VlwGKx74DuZTeeCbmDIou132fIb89IpQiIqKr7lE0/d/4aL4k0JHP7cM0?=
 =?us-ascii?Q?mT67D/ndRBakqTOpzrjx2Ks4aFZqOk4AuP6zQx+55RIA1WrPtQJC6ohtc0LE?=
 =?us-ascii?Q?7vE9ERVK74ost4TB69tIWzpbd+Ywx2NZlm9EZN8QtJRf+4CX/gqRaqz2fEnD?=
 =?us-ascii?Q?nyplSHwDvyAFDVoy06sX2gl1xVhMeMFVKR5Za126mJVH/YrNDFOYdVmYuLgK?=
 =?us-ascii?Q?eH7mB99kach2j8AjYU+N92KENDh/B7MEP3O6pynvStpoFywcRaJr7Jyg6YOl?=
 =?us-ascii?Q?WQ9oKF1lCrq4/4QJwmq0iTMu982rffHMJ+vsbhgsv2kovNDj5Wisfx4VQhr+?=
 =?us-ascii?Q?B6tx+4z3r5T8pT9sHF+IGxX4n5ki01bmxIgSOZKGtWGPKtkSJqdCG/3No3RB?=
 =?us-ascii?Q?xEgKXqTzmeWiJ6m/ogM7r7Ai3ZhwUqf90mP5WJ99Q9lWJXtVwSK+53/8xIHQ?=
 =?us-ascii?Q?B3uyuEAgJsxJo5tcowAlSN6qLYcvvPRrRGB/x/GvhIH0aGQa0vDZ/GTXrsQR?=
 =?us-ascii?Q?QvaMfEI5SNkv0iWXRtgVq39JtTXGZMggc9dpPixgtWP9cOfBEP/Bh2U2AXTb?=
 =?us-ascii?Q?z4IO60txQdjZ8Eqlhh22IiM6paovtbBVY3vHalplh/6e6xp8vSV4cIhy1iM/?=
 =?us-ascii?Q?9Jvj+vUBiSd2FqqCMSxFOZP2FI3ZIidwBrT5bZGyGgs2KFVYNexwelAsuOrT?=
 =?us-ascii?Q?Lb1qC5UEO8lbwpqy+jusb1Oe/VX2kL1ikXrTVKAwPbrbqXd7p37kre8rkm59?=
 =?us-ascii?Q?PaFwxtZfS7HMcAeEmoeSzwIemoEqaKIjyZiFPyIJS8SH+GXW3flKQz0xqRCL?=
 =?us-ascii?Q?DygqlURl1r+rf48hmmbV+iCr98hjEzz8EX+DvXx0azg5lVIed1bOd0T+6I1e?=
 =?us-ascii?Q?QbJ0pUv9d/XYbn5wqPRKB3EdevkWH3wgy/1RrmWVb3ScXPyqE0Z71HtK4Rvv?=
 =?us-ascii?Q?RQbfmPwpDajn07LWA352n+nZ1jN5uIDAl0bTpvkBrbnQp+n1TGVhU/Bsms27?=
 =?us-ascii?Q?AEoeu2Zbu20fGCb618yxbAhV69JhK074NecemRqmJ+qE0KwgI+oQqJaTIv1z?=
X-MS-Exchange-AntiSpam-MessageData-1: hamEZVa8GXmkZhC5ld3nbATE3qSJMztLTB0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59d3bdd-db22-409f-46e4-08de420d4f55
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 10:23:26.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YAY5bcvegARx5fsdWF3NxHp8hIQU234rWxaqk4JWgyUSEQuUdmTLT/GdaGOXa2W8Fi9YcfMUIJo+nd+6JYcyK7NKrTlCnMmtp+MDnjFD5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10910

Cgroup-v2 implementation of freezer ignores kernel threads, but still
counts them against nr_frozen_tasks. So the cgroup with kthread inside
will never report frozen.

It might be generally beneficial to put kthreads into cgroups. One
example is vhost-xxx kthreads used for qemu virtual machines, those are
already put into cgroups of their virtual machine. This way they can be
restricted by the same limits the instance they belong to is.

To make the cgroups with kthreads freezable, let's count the number of
kthreads in each cgroup when it is freezing, and offset nr_frozen_tasks
checks with it. This way we can ignore kthreads completely and report
cgroup frozen when all non-kthread tasks are frozen.

Note: The nr_kthreads_ignore is protected with css_set_lock. And it is
zero unless cgroup is freezing.
Note2: This restores parity with cgroup-v1 freezer behavior, which
already ignored kthreads when counting frozen tasks.

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


