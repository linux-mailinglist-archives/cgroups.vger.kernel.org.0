Return-Path: <cgroups+bounces-15699-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHgyNZxl/2lo6AAAu9opvQ
	(envelope-from <cgroups+bounces-15699-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 688365008DA
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12B6A301487F
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED530AD1C;
	Sat,  9 May 2026 16:49:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0442F9C37;
	Sat,  9 May 2026 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345356; cv=fail; b=dygG2Zl8a3nFc0sNr2tGgcMHRg5mJmMNMwyuboUvQbX8P5nHyCETAErX5m9pSDINy1tX+ZU1k0XwyDaDL4VHwBmtHH614Uyidaedse4w+QcqnkP48cLwWqD17o/tiiZYULtkkJGrRBgmvzXHyb4exDI4Xaz7fG4c+1IdcCh78j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345356; c=relaxed/simple;
	bh=glZSUIaeNQOYtPbDdPSr/vZ2L/eXmC8xtn9WZ7BBiDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0D1Nvxc7OqRKwo7oeZqfQoNO2nptQsqGpaN/z3o2Y5Ah7F4P5c2+Mn5+VjQe8z/+o+sdKsN/8ztVQhMTguY2pENxpv+c8r/gmdLE61JumPAn0TP9CBR4YSwGHkxOJkCyUSsWhoAAdPr/wDIzaXq4MxqagSe/Pxl7wcn318gBEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmEUOsurBJTAFjGt78xm8cgStQeSbInIpziAwdgM7Fa7/QJn2gtQv138ercoLJ6ldIhe3qm7H6W0ImrhWZ66hk9g3C9p6EjiqFWt/WsR6PDm1WbglYJP/4DIC0bFPtWVgnfap3tT653CO+pkfA6NFfHH5BpYvRZ5pbGAa2Uzkcjm4T90pezdwHarza0/MQ+W376+9O2dGmkgrepZ8qj8rKG/KNzWLxhkThLs0IW6fs4s+NCqbgHiuLJVOCEeJ0/XKnQ+6KCQ8yrJzYO9GSQNEls8XnAf6lgTiqO7CM57D57BHjmiHoe3o9S7R9E4CkuysObYAapqZ/8c0AvHjkWPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8qEmORNB7IhYuLeIjk9ZBS8wnuIjFWKnZvSXaS5y1Y=;
 b=fzNq8BIt3PBP2xj4NonZFow+lQdM0/5NIMV3+tgYVvyghCAUP1eGiwmlKIgHmnwQB5PsMu4IQy4GWR2S13tTYemx+EIGszyW3qC0JkyCvQaMxzFI2tZ2dJaoz09WgHWwlvKAo5gc+sWqMZ5Oa69oSxmym6AlDecZG3kDrz4fdrGE6QZgv2h6ZW/djlun0AJOND8zOJIDV9PO6npe6XGacrKaX2UeuywPsJHZSeif+RJbJQRge8Ez1LTuaIYhBkiDZzbNn/rzFq6SbJeyQYWGocYU4mDrjBpLR/vtqhvrisOQYj46iJfcwydWyq/Tmq47L7tKSOpchIYteBvUV7m9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6996.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 16:49:02 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 16:49:02 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tsbogend@alpha.franken.de,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: chenridong@huaweicloud.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	omosnace@redhat.com,
	kees@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	chjohnst@gmail.com,
	steve@abita.co,
	mproche@gmail.com,
	nick.lange@gmail.com,
	cgroups@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mips: sched: Fix CPUMASK_OFFSTACK memory corruption
Date: Sat,  9 May 2026 12:48:47 -0400
Message-ID: <20260509164847.939294-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509164847.939294-1-atomlin@atomlin.com>
References: <20260509164847.939294-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0686.namprd03.prod.outlook.com
 (2603:10b6:408:10e::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: d606dd81-486d-4ed3-e215-08deadeadfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aa8hFVKPBJO4bTON7hzudNHXcH3aLxHS33zKg1QNRCgjcmfxOfRM99EMBs/w5QpSjp4X8+R8wjVjMjot29ovGkLzns5ah0S03WyAY5HGvp4PocivJ1Z+sJVwqACAyg2E9w2Qy+L5W5p7uNuNo+t7D3SDH7ivaPI52RwJsJ88/eH4B/DtM9yquPyBovPxP0ktf9hffW5epY2t8kMWuBL/5hK4szsWXnu3agOTbctwGaWgzjnNOZBMsBMMcuh4c3oHvcjMrtnTq1/ODGCDZQdCxhc5VaYS5mooKv66zuxnxIAjaSHCaA3aaqoUb7YAbXFd9ptDPZ2doOhDN781rSAA9YW0sJyItMk+4Az1CawTHR79b37SZL4vYEWkSXB+kLoELQ6He50EOD6vhY/Zj1Xnp/OyxtGFmzzcFD+Wx7+dVL5WRth1nIohAFGfVwKkVoPrTdDvwBDMm2dg5uvZF/lBBYIm4e73fphe/U3UoB8/7evfGxuijdJzuIHL/GiE7EKCS9hojywsZMWBYm5BHNPSJCxcV7Kb5eEvRxd16eLruTsq1tkmwFJ+2esyYMAOy/51Ics6eeUHxo6jWLwH1rz+RTeqh4C5T67D7+wCNpOQPubAf8bCHgEcYakN/TZTyPJbRSlycSAzEWaoZfRzcRoxeADV4Z5Ys3Wai41UZ6Y2ltidSXO3hOaoAgapcNfM/ONv9VRmGak7Tr0Fz9+VKGYXhwOkoGR23ufN3JHJ1XUINhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(22082099003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5/mzt/l7U1hWIOjDE2znCK2TjQaOBnVhvnZP8vUkIL5WuBr+bi091wAJf2l?=
 =?us-ascii?Q?AqiNolMnWT75qGv9P0FORdsOt2rtVVVFUgokTfVs6EVbPyPedOsUc4yuhmNc?=
 =?us-ascii?Q?eaCogoPCAgRHkCpRBV36Ub0ET+/mTvHh14Pl+TSsRnLBA1BA1itD3kutrdDM?=
 =?us-ascii?Q?+ThIW3+0HkQjNcWJsopX6FYEiBq1hMYYQZKOhsxtCPD8Bv3A4m5hwgd75qdi?=
 =?us-ascii?Q?475PvCetmqr5J9qJL2N4XpPiHECIQTT/Zv57qMAEaMmiy6oKWKmAazAV2txP?=
 =?us-ascii?Q?+6Pij9NMFKX3MqkSud6AxSKptzeeBFlXdndaNwPbjUxHuQx+3e1xarPpaYRK?=
 =?us-ascii?Q?DIB31LuNeT69IZy3wtfMPkQbHRM+auEjvlA7b5QnI7MxxB5tOL36R+8EWOAZ?=
 =?us-ascii?Q?CLD2zQjafUVbxp5PRpPFKC2tbLIW2zPHbfIb3QULlo3mbExf/RdO4uG4Xotf?=
 =?us-ascii?Q?OZ/Y+IQfFZPrjWv9PbkBTYUxSZt+TalU3dE3Cb7tNwsVHLj0hgFqeHY3K3Cb?=
 =?us-ascii?Q?g9X6xwlrhWkTq5WJYbdqkxW93Klgzpdblqhhgt2+5h+hGjJpGBjIPl5b9Lov?=
 =?us-ascii?Q?IxUf3v5joZVuownud5J/uNB1uO50UaYZiNgNCnvhdE5smVik9kdVm6wVIfC9?=
 =?us-ascii?Q?RVJN6pqJpSnPKezW78TjB7Sd/Cu7T7hPH2VsoFOuFoNHIalSOSL1R6jTLhWw?=
 =?us-ascii?Q?i985WjOu+en9zMMG4ADBXGMnGkidWA3OqNHqx+S3uwb875z3X/Pupo37fBf2?=
 =?us-ascii?Q?xr0bSBNVJXqt+RT2PFIru3yZyXuoh5TsLLa+xsLcsZLUCs3F7yLbUt3yW6kH?=
 =?us-ascii?Q?GyoGLiaSkdBUYSVJdE6MVTSZ0MMTWLDgGsqoaJq+mUMYoTMCHkn10HInnZuU?=
 =?us-ascii?Q?qr5geQPJ+6lMpFRjHZztqbJxXikOqZt69MKysZPb8qyeK9wR6hCYm3++sPiO?=
 =?us-ascii?Q?3jyfD5LUMCVmg0lP3FAuFNsO/7Pz7NcdsK2XbOCMga7mpzmHwsLxj7tFfMIe?=
 =?us-ascii?Q?36SajP8lPtTVbK2FYTh4JTpPOmoHZRcSlCkLf5kssP/ppKN8B9SRSaSXYr1O?=
 =?us-ascii?Q?6HNmu21jPybG2hqLrWtYgniCrcY++bJWPsFzEQtuXrdJlOVapjkx/5P8M14R?=
 =?us-ascii?Q?nig5+y26Al2W8xoNFv5e71tN7OaSQoeJdsRhP9f1t9xfg5XSR0C+V3oBgLMm?=
 =?us-ascii?Q?rA/LA5bUfG3zSXxvasA8TFYYE9cJm3qzYbGjM1DloAGKPqn2jKSIAG7o6B+v?=
 =?us-ascii?Q?kGSVc0OCjCxPaEhVINLIGxYovNqAYX2vbGWd2EPmwdJJRtR1pmGHU15YDTuJ?=
 =?us-ascii?Q?xj2kttQOejeJbv/85yjQWxD1Bl2EdjhyoSEyOTYLWo9lIXcBCwfT8b1AhQD7?=
 =?us-ascii?Q?I5rg2a1AS2aXlOqjLsTw5B02JdNIeplU3MIHP4NgdHht51T8HSY+F0wiwb1d?=
 =?us-ascii?Q?kpbjskyEV0i7pl9GbpCv6rML01rLnwKJhQmoUa1ON8b0pEXar3/g3Ixq1cuD?=
 =?us-ascii?Q?a+p9AkSilop4DYCccIzA6ePAhdIecs/ErGld5Gqp8116DWVUq4OmnnlX/XN5?=
 =?us-ascii?Q?llZfLPle2uKY+HsU7ijiCV9W5DDiTZefhSumoMtiPHTbWfHgfzFwYqjnIB9t?=
 =?us-ascii?Q?qVv+uV4a473XzPYX372oVI7tg18BWbrH7MYYHvTtUECEtE6FbIogBfVWFsKb?=
 =?us-ascii?Q?6CPi7Qfw+0lXo1YdI2PQ5WyFgi76v6kuMa3nQ+NfXyX7iNNWlL96ixCYF84g?=
 =?us-ascii?Q?zcmfFocV0w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d606dd81-486d-4ed3-e215-08deadeadfb8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 16:49:02.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMnRE/0hBY5SfznTw5jfMMhpUUuaJfAMYhBTbFTKZ31x8ArYkqaqUptuWXjPWg1IilVwjQbRFYFgnoQck3JtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6996
X-Rspamd-Queue-Id: 688365008DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15699-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.168];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,atomlin.com:email,atomlin.com:mid]
X-Rspamd-Action: no action

This patch addresses a critical memory management flaw.

When CONFIG_CPUMASK_OFFSTACK is enabled, cpumask_var_t is a pointer.
Consequently, sizeof(new_mask) evaluates to the pointer size, causing
copy_from_user() to clobber the stack pointer. The subsequent
alloc_cpumask_var() overwrites this with an uninitialised heap address,
discarding the user's mask and risking data leaks. Fix this by
allocating masks first, and using cpumask_size() to copy data directly
into the allocated buffer.

Additionally, reorder the failure goto labels to ensure task locks and
memory allocations are cleanly unwound.

Fixes: 295cbf6d63165 ("[MIPS] Move FPU affinity code into separate file.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index a6a61393fc1a..4b3424088302 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -71,11 +71,23 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	struct task_struct *p;
 	int retval;
 
-	if (len < sizeof(new_mask))
+	if (len < cpumask_size())
 		return -EINVAL;
 
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
-		return -EFAULT;
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
+		return -ENOMEM;
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
+		retval = -ENOMEM;
+		goto out_free_cpus_allowed;
+	}
+	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
+		retval = -ENOMEM;
+		goto out_free_new_mask;
+	}
+
+	retval = -EFAULT;
+	if (copy_from_user(new_mask, user_mask_ptr, cpumask_size()))
+		goto out_free_effective_mask;
 
 	cpus_read_lock();
 	rcu_read_lock();
@@ -84,25 +96,14 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	if (!p) {
 		rcu_read_unlock();
 		cpus_read_unlock();
-		return -ESRCH;
+		retval = -ESRCH;
+		goto out_free_effective_mask;
 	}
 
 	/* Prevent p going away */
 	get_task_struct(p);
 	rcu_read_unlock();
 
-	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_put_task;
-	}
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
-	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_new_mask;
-	}
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
 		retval = -EPERM;
 		goto out_unlock;
@@ -141,14 +142,14 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		}
 	}
 out_unlock:
+	put_task_struct(p);
+	cpus_read_unlock();
+out_free_effective_mask:
 	free_cpumask_var(effective_mask);
 out_free_new_mask:
 	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
-out_put_task:
-	put_task_struct(p);
-	cpus_read_unlock();
 	return retval;
 }
 
-- 
2.51.0


