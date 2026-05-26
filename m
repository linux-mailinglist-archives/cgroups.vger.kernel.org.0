Return-Path: <cgroups+bounces-16317-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QInmMbGvFWr2XwcAu9opvQ
	(envelope-from <cgroups+bounces-16317-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 16:35:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B45D7B1F
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AD3B302F7CB
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44003FF1A3;
	Tue, 26 May 2026 14:28:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022131.outbound.protection.outlook.com [52.101.101.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59883FE34B;
	Tue, 26 May 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805727; cv=fail; b=tksa6hF/xyXnfWq9kSClBu2Ae190ueHb0MYDJzAFO2KG2jI9pGlWuoM2ZYnezOLvjZKFyQ7KACtZkCG4JLlTW2XElRVRBcv86QBnuw0YYm2HLxJ9/9iajj2OZbTPs9ip1REVO5iSq1+JQLcX/r1D0SKv2k42ru9zmoY4wdN8X/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805727; c=relaxed/simple;
	bh=9tJ+uhtesdTNg6Mjsd+6RCtbqLxTf2c6z8WQ38ONNxY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZPSwPzf7vwHBhp6jfAWxCOiKKb/JfPk41OFCY3Bs1tNpqQyl9+Ot1Nc0XlTM3aw6SuA2WP/P4BLUA9ipo3D6cpxklMBvmE6DCr9xTgOZEps/MhfAXem24DMWLF7VID1JQeda3URgkn7RpChBreRPoC0elbIPd+LeaGwDA6DCjMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIQnQyznQNXaOsyeKeJfv1GBGaUb1+8/dXi3vt9owirZiyI8ol55xU9C7gK3DIuBIOPkdf5x3oXeVi9aYEKe5Yl8uRs6Ezlx2WPYqwNCzGdOdDQAZAx9/59L+uzz+gFNRvZ1A9glGE1E7KUmVn8qoWsqQVXOkMZzxCiBdHlhRo2Y/WbCgr3u/kvR9vkNYMHKT1sN/8THekS/+m+BxJAxnoxARCLVixD5g/hrMhyha/FyFTrQPTUgw+r0ihjEjprC3FMfRL3uCVwXUNcbRXzIEkwSglzj+4PM1prfhnyHkm/8wvJWMyFYU/mIGqgHgg7UgcKUI2KqnMsqCq5Mr4+yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kkSpMoMM/iUVslj1HBanotjmRqjjeZF2J8WHzGzMJuQ=;
 b=EMYoxA8xKG4eYs6kW2vdxuOCjFr/qBEJzQEHElAK9W2FdYiMaQeFZgf/R0BzyADkLqO3Z1Am8SZ9TJfRVBHpuCCSTaCPrXuCe3/DmVJcwVIL6YwdrfVobRAoWsaeOsh3JHptiz1SdWBSzHRP0NwsjgvHIHnYlX39SNzoqT7e6ZDNzyVRY9nN/mNfvSnusJCS1JWxa7lxoyVaOUiZH8e99DjaM9A/xurRVXY+J8h6OND47DXDxPVRjwqVnEdTQJHtGYN+mV5YfDRZmlXnRjEKdsNvsIJeM0jUSyMIsikWE+DJYW41J+exT28MXScpC3zVAEgaJuNSWgZnct6SdPxMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6631.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:28:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 14:28:41 +0000
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
Subject: [PATCH v3] security: Expand task_setscheduler LSM hook to include CPU affinity mask
Date: Tue, 26 May 2026 10:28:38 -0400
Message-ID: <20260526142838.774711-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dbc83a-2652-4d25-bbc9-08debb3315a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|921020|5023799004|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	8uFGeHLBYESMl87G27hXJLzZNNeDBnwjQCHsQ6VKlp8p5mkvX3SwKoI/O1wYMS03k64qF2n6QHUP1sLxDmiNtvE1+1CpQBJyMeImVWs5j/eCe1mUaC02y3StXy3/KRT8gENt0PBdynFkAH+8494ibs6mKNuglfXHobj7zSA1FMSo9dU7eZJx6/BEE8cZKXmr6ZZx+yyIIXolUhAlphY0lmtE4hFi2xQGjCmfDKHOKua7TsjjrVnjfVHe9/S0LAEQ9LL3NXyK3B/iBeR9lMublawi/guuUnoyy4bmTw96H/yPVKyTDYMA9jW55AtNrT49PQvAaHtzPsJhfSLpp2MIYuYJlnN5Pa3ROU3TMuzszX03eruvqcYWGpO/BxkMtssH2C9mT+PcYVuwmAsM8LW0EpOxGCbG3Jx9Ath/AtnrTROEEtMCNW/fWtC/lzdrL7vYWfLHB8J7laKAc2cbzS9RZ4SrrSmWgatS0oaCKGbCMPp3TZ/QYTnzGTudl9jbRTD8iT2fT2tV1J28OyebUVQnsP5V9j/ar4RaObbxeYer41OvsPUvU7RRxtitKDESgIHAlp+2unFjSsRYwU8JxnQ/vtvdBdWSZrBNhxpueJP8C1r7kOu5O0J1qHfcrGBZ4bBz5kJscEBNGjzjL0eogQTxgwWB/TAzPEHd0voc0piDDj61CsYfIQ1LOLtgoq3i0eI08wE/KKXSBLNdfUcYDJfOOUmWZnOtzWIm3NUnn3Q1hARdVJfTlAaArxSBZbuIYznh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(921020)(5023799004)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7t7eu+uqMvLe/U4mCsi+3LBLrYeeCgAwlGebMfd3gTR8BysVilLf7QazfDQ?=
 =?us-ascii?Q?bJ6xV1/cqGXktDKS9UQSdHxm0TFlZ4mGE+2ZAFnejZfCP6FSc/XB/QthLKt9?=
 =?us-ascii?Q?fNQiTb4s6/Ahmr+C89Zcl3pHjaqxXuqasU326eMKs0nEatMGq3f0jaV4bN8o?=
 =?us-ascii?Q?yms7fSuKGlTTF7FFma9jdjTzqojfVM3+k6t27qYxjPA11/qSzkkU54me3eYs?=
 =?us-ascii?Q?aSAGZyzmBfsl0RibWKIABqbMkUdMRgjtboW7Fxy15gAND9T1JwoU4lvKSFrV?=
 =?us-ascii?Q?a3+/Vez3O1QQR4Yck70HbXyXq/FSfZYBubK5ijPbuzXAr30EjRIcvK4wGtCl?=
 =?us-ascii?Q?7z1QNnSfrMIaTZhnYgfypEWnQNIRVrnHZiKXFrwf9yx0uNEoJyToE8RKoASw?=
 =?us-ascii?Q?mh8XmkU79AtmdGdnTNZT60Ew2vEWjzsJ67Cavw2wfNMk/bKUVBgMiuLwe00L?=
 =?us-ascii?Q?boqva5v9r9sbKMCl7ipF72sCVOAzuAm3hOKSA2jex4sRJVxhfC2ePhnJQrIj?=
 =?us-ascii?Q?vKhdXclNV+FlZPBbWsPB3rlIQzEjyAUGhue7eaDfT9NKS5uWUx9wQA5ouFs6?=
 =?us-ascii?Q?RijItCuIBympv2tZn9gwJp0U9/gIOw9UCcw3kT6qcJEzyOsMwMHuLS0E+6Io?=
 =?us-ascii?Q?LPmbZeDDOTOSeeWdiTXFT2ej7+jR3qzeRSK/mld2f44Udi/G/0Knu88yOHZc?=
 =?us-ascii?Q?p1MgsDTW4POur4vG8uk4uImB4RoaRGxJp46mq99bv4sLRvTdji36u3nIr37U?=
 =?us-ascii?Q?MHROKEecppT6yGmXfgGHVECfBGWbiuqSutWJNJ4baWPa6aQLcQo7rc+jV5YG?=
 =?us-ascii?Q?IMlE+vjYmEchaggZb6NBMLUCjEtx08ML9yFbrjssp2zeZiNW04o0vvWDaD5s?=
 =?us-ascii?Q?6u7TBmGphZqKLmZl/iY+5X6irsZoZC+Uw+PAr/4ijRU9f+PSZcFASzc2Xxma?=
 =?us-ascii?Q?3k7Pt771zUU9GR8yTbk6Gm+7e6MtLrY4ZbBbPV0/69F3b2ezYqVKfi+HoAba?=
 =?us-ascii?Q?UDDniWISsSfPLnPGKGXcL0FltjN2Xhorsd4H4OEYB5fgqYE9A4BDT7UmEp/1?=
 =?us-ascii?Q?CIpyvNV1fSTy7wy1xvq0LJCRWnrIOLRsvKZIBgUlAvFNrfixs1Q1RymmVDZh?=
 =?us-ascii?Q?v2vYApLP18fAbhfNuq8Rd5WrsFPR8Uh2402a5Xjhbk8gQImtShfBFmthdsxo?=
 =?us-ascii?Q?A3vW6dPwmunM4hDFC1VwFErJuv9/xSQ1+t82LAeohDiUkaa0UfQZc4oRwN+y?=
 =?us-ascii?Q?I9UOtpLFS/0d9aLWDgQ4P0ZgHJWZJJrUWumhOU9HjHhIDqvLQimCB/xJ+0dv?=
 =?us-ascii?Q?TEkPYOVSmKCUMx9rEq6zo1nR3T1FGQIaozdbNVmYJMmmjXSrb9kykN2RpbgZ?=
 =?us-ascii?Q?5414YdE+dcqtdkzKY+gOpOhqKFPzIZMSWUVKSHA+waszWo3YA7PMd8CAE0fZ?=
 =?us-ascii?Q?PqeIgQi2S2xfhctgvOi0A4de0Ogng0cKRkTkzgpR/PxLCstYF9FJwN3Sm4l+?=
 =?us-ascii?Q?ri+8ypPLCgO2ljB7vPaJBUdVTw4mE5dOaQm4MybqpLj864bSs4jUuOwAWbVY?=
 =?us-ascii?Q?EtWewYethGvBtnoNSSbh4sgYfeaq4eZ/W04yvbGSSuYoeB/NMfj9sXUi8OAX?=
 =?us-ascii?Q?7okmiwrF5851SwfCCoEUMouOK2lAqoDz19IRRLWSdUZCG8d6juq/zGcedWmL?=
 =?us-ascii?Q?OHmO3QAo5FhhRM+rP+MBpVopwuPJ18K+IKYs4B900Yuo03XvHpKFLM+9jmRZ?=
 =?us-ascii?Q?7/jf3Pcbig=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dbc83a-2652-4d25-bbc9-08debb3315a3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:28:41.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FDIkw1dXhNgD7Xrg+zQ/15tilU/HU7FJe2oyCrRnKr+ayN81+z0AZnzkI08U+cdRr1NUpJKkYEXkTS9aEZ0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6631
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
	TAGGED_FROM(0.00)[bounces-16317-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.664];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:mid,atomlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B0B45D7B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At present, the task_setscheduler LSM hook provides security modules
with the opportunity to mediate changes to a task's scheduling policy.
However, when invoked via sched_setaffinity(), the hook lacks
visibility into the actual CPU affinity mask being requested.
Consequently, BPF-based security modules are entirely blind to the
target CPUs and cannot make granular access control decisions based on
spatial isolation.

In modern multi-tenant and real-time environments, CPU isolation is a
critical boundary. The inability to audit or restrict specific CPU
pinning requests limits the effectiveness of eBPF-driven security
policies, particularly when attempting to shield isolated or
cryptographic cores from unprivileged or compromised tasks.

This patch expands the security_task_setscheduler() hook signature to
include a pointer to the requested cpumask. Because this is a shared
hook used for multiple scheduling attribute changes, call sites that do
not modify CPU affinity are updated to safely pass NULL.
To protect against unverified dereferences, the parameter is annotated
with __nullable in the LSM hook definition, ensuring the BPF verifier
mandates explicit NULL checks for attached eBPF programs.

This change updates all in-tree security modules (SELinux and Smack) to
accommodate the new parameter mechanically, whilst providing BPF LSMs
with the necessary context to enforce strict affinity policies.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
This patch is strictly dependent on the prior acceptance of "mips:
sched: Fix CPUMASK_OFFSTACK memory corruption in MT fpaff" (Message-ID:
20260526141651.773306-1-atomlin@atomlin.com), as expanding the LSM hook
signature requires passing the mask pointer from
mipsmt_sys_sched_setaffinity().

Changes since v2 [1]:
 - Dropped patch 1. This is to be addressed by the cgroup cpuset
   maintainer (Waiman Long)

 - Dropped patch 3. Will be submitted as a separate patch (Paul Moore)

Changes since v1 [2]:
 - Reordered the allocation and user-copy of new_mask in the MIPS
   architecture's mipsmt_sys_sched_setaffinity() to occur before the
   LSM hook is invoked. This ensures the security modules evaluate a fully
   populated mask rather than uninitialised memory, while cleanly handling
   error unwinding

 - Updated cpuset_can_fork() to pass the destination cpuset's effective CPU
   mask instead of NULL

[1]: https://lore.kernel.org/lkml/20260509213803.968464-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260509164847.939294-1-atomlin@atomlin.com/
---
 arch/mips/kernel/mips-mt-fpaff.c |  2 +-
 fs/proc/base.c                   |  2 +-
 include/linux/lsm_hook_defs.h    |  3 ++-
 include/linux/security.h         | 11 +++++++----
 kernel/cgroup/cpuset.c           |  4 ++--
 kernel/sched/syscalls.c          |  4 ++--
 security/commoncap.c             |  7 +++++--
 security/security.c              | 11 ++++++-----
 security/selinux/hooks.c         |  3 ++-
 security/smack/smack_lsm.c       | 11 +++++++++--
 10 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 4fead87d2f43..c68d1676350e 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -110,7 +110,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		goto out_unlock;
 	}
 
-	retval = security_task_setscheduler(p);
+	retval = security_task_setscheduler(p, new_mask);
 	if (retval)
 		goto out_unlock;
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..ac4096958a00 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2619,7 +2619,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 		}
 		rcu_read_unlock();
 
-		err = security_task_setscheduler(p);
+		err = security_task_setscheduler(p, NULL);
 		if (err) {
 			count = err;
 			goto out;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..6ec7bc04a1b7 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -255,7 +255,8 @@ LSM_HOOK(int, 0, task_prlimit, const struct cred *cred,
 	 const struct cred *tcred, unsigned int flags)
 LSM_HOOK(int, 0, task_setrlimit, struct task_struct *p, unsigned int resource,
 	 struct rlimit *new_rlim)
-LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p)
+LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p,
+	 const struct cpumask *in_mask__nullable)
 LSM_HOOK(int, 0, task_getscheduler, struct task_struct *p)
 LSM_HOOK(int, 0, task_movememory, struct task_struct *p)
 LSM_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_siginfo *info,
diff --git a/include/linux/security.h b/include/linux/security.h
index 41d7367cf403..8b74153daa43 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -196,7 +196,8 @@ extern int cap_mmap_addr(unsigned long addr);
 extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
 extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5);
-extern int cap_task_setscheduler(struct task_struct *p);
+extern int cap_task_setscheduler(struct task_struct *p,
+				 const struct cpumask *in_mask);
 extern int cap_task_setioprio(struct task_struct *p, int ioprio);
 extern int cap_task_setnice(struct task_struct *p, int nice);
 extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
@@ -531,7 +532,8 @@ int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
 			  unsigned int flags);
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim);
-int security_task_setscheduler(struct task_struct *p);
+int security_task_setscheduler(struct task_struct *p,
+			       const struct cpumask *in_mask);
 int security_task_getscheduler(struct task_struct *p);
 int security_task_movememory(struct task_struct *p);
 int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
@@ -1392,9 +1394,10 @@ static inline int security_task_setrlimit(struct task_struct *p,
 	return 0;
 }
 
-static inline int security_task_setscheduler(struct task_struct *p)
+static inline int security_task_setscheduler(struct task_struct *p,
+					     const struct cpumask *in_mask)
 {
-	return cap_task_setscheduler(p);
+	return cap_task_setscheduler(p, in_mask);
 }
 
 static inline int security_task_getscheduler(struct task_struct *p)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c33ab20cc20..7b3dfccb77d8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3033,7 +3033,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			goto out_unlock;
 
 		if (setsched_check) {
-			ret = security_task_setscheduler(task);
+			ret = security_task_setscheduler(task, cs->effective_cpus);
 			if (ret)
 				goto out_unlock;
 		}
@@ -3591,7 +3591,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	if (ret)
 		goto out_unlock;
 
-	ret = security_task_setscheduler(task);
+	ret = security_task_setscheduler(task, cs->effective_cpus);
 	if (ret)
 		goto out_unlock;
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a6..68bc7e466fb1 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -540,7 +540,7 @@ int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_SUGOV)
 			return -EINVAL;
 
-		retval = security_task_setscheduler(p);
+		retval = security_task_setscheduler(p, NULL);
 		if (retval)
 			return retval;
 	}
@@ -1213,7 +1213,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 			return -EPERM;
 	}
 
-	retval = security_task_setscheduler(p);
+	retval = security_task_setscheduler(p, in_mask);
 	if (retval)
 		return retval;
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 3399535808fe..d86f1c2b9210 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1222,13 +1222,16 @@ static int cap_safe_nice(struct task_struct *p)
 /**
  * cap_task_setscheduler - Determine if scheduler policy change is permitted
  * @p: The task to affect
+ * @in_mask: Requested CPU affinity mask (ignored)
  *
  * Determine if the requested scheduler policy change is permitted for the
- * specified task.
+ * specified task. The capabilities security module does not evaluate the
+ * @in_mask parameter, relying solely on cap_safe_nice().
  *
  * Return: 0 if permission is granted, -ve if denied.
  */
-int cap_task_setscheduler(struct task_struct *p)
+int cap_task_setscheduler(struct task_struct *p,
+			  const struct cpumask *in_mask __always_unused)
 {
 	return cap_safe_nice(p);
 }
diff --git a/security/security.c b/security/security.c
index 4e999f023651..53804ee40df5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3240,17 +3240,18 @@ int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 }
 
 /**
- * security_task_setscheduler() - Check if setting sched policy/param is allowed
+ * security_task_setscheduler() - Check if setting sched policy/param/affinity is allowed
  * @p: target task
+ * @in_mask: requested CPU affinity mask, or NULL if not changing affinity
  *
- * Check permission before setting scheduling policy and/or parameters of
- * process @p.
+ * Check permission before setting the scheduling policy, parameters, and/or
+ * CPU affinity of process @p.
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_setscheduler(struct task_struct *p)
+int security_task_setscheduler(struct task_struct *p, const struct cpumask *in_mask)
 {
-	return call_int_hook(task_setscheduler, p);
+	return call_int_hook(task_setscheduler, p, in_mask);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..5f0914db23f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4557,7 +4557,8 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	return 0;
 }
 
-static int selinux_task_setscheduler(struct task_struct *p)
+static int selinux_task_setscheduler(struct task_struct *p,
+				     const struct cpumask *in_mask __always_unused)
 {
 	return avc_has_perm(current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3f9ae05039a2..a77143beff44 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2343,10 +2343,17 @@ static int smack_task_getioprio(struct task_struct *p)
 /**
  * smack_task_setscheduler - Smack check on setting scheduler
  * @p: the task object
+ * @in_mask: Requested CPU affinity mask (ignored)
  *
- * Return 0 if read access is permitted
+ * Evaluate whether the current task has write access to the target task @p
+ * to change its scheduling policy. The Smack security module relies
+ * strictly on label-based access control and does not evaluate CPU
+ * affinity masks.
+ *
+ * Return: 0 if write access is permitted
  */
-static int smack_task_setscheduler(struct task_struct *p)
+static int smack_task_setscheduler(struct task_struct *p,
+				   const struct cpumask *in_mask __always_unused)
 {
 	return smk_curacc_on_task(p, MAY_WRITE, __func__);
 }

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
prerequisite-patch-id: f9200d420002c9fd0663d0ec00c83db866889c19
-- 
2.51.0


