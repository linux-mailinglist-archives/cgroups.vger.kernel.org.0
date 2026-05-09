Return-Path: <cgroups+bounces-15698-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNQXD5Jl/2lo6AAAu9opvQ
	(envelope-from <cgroups+bounces-15698-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04A5008C3
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00A0B30120F7
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B82F691D;
	Sat,  9 May 2026 16:49:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D12184;
	Sat,  9 May 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345354; cv=fail; b=GbHkxIxtMaoptdv3mI7RDl7P6tgeNNKgMTLphIvHtbb/H57xxI3/y6d9k6U5XrNSAu0UZD1DD9VYVdUrOuUd36VZ+vfKgqN303zMWk5WgCZN9peq8UMnGsuX/P6BgVmCXK/v0sYcPioHz1X607H35WQIHT0Rajr0H8zGZB63chA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345354; c=relaxed/simple;
	bh=7o30tnoSVBCME0ERP6M6yziW/8Htk2UnJ9dSs/odKKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tsYJiWpHJSO6G7crJoQ5AgzX2CqwfFk9eobPkUC0NBUfHLJo2bWkTtmQY5Jx1JijzOGd5jPwIzRslu6m0tYolv6rWIFMtYs61QidRYb4tclKjKxDwi9hb9EDBtu/olPTe+XF4eHFSIJl+rBvP2YdRxsirZ9IFGm83wklTZa/U5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEnIvZDolVqqrSuQ0j9QPfCTSnL4ZqXGY95wY4dRg6wOL7wEPQStfV310vpZcniGBy64Emv4wJO2bLSfq64EJ63XPfV0dKmnVayKVzv8vFmHQ/YtkfEFr2UItURtbxo3p4wiTyIlFSWwXvMsVQIHN8pdFdsURzb/vNeMR/W86DAX1Dw5Ljf/mT9KIndFJnl2ngWkefJ/FXbumwYrPpbqYw2twz6IH87GOyS2rZpH6ulxl65jJh+fq75gmLtdYkaTnsGdf1VQO9ADZTOoqlwl8oPVKbdo/o7AcVSjc6XXrm3tgqPace80g3eiqY1/GB+pyeJwLXStW9HvTwbqmK7xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fEEK4uHv2EMhNBBdgxA3b6/vN+5VxLyxBw9e/rBN/M=;
 b=URB8QJhRbvB7Br248Cj+6pa0zo6CrO8keb4ls8J3orZqK3vYAFWXOPfLgPIVzbcttfERzAsTAyw/7j7Kh43+UlKPtBFwEV1O/HlAFR5Av0DOm6vDflt6n6h6xmbyNu1nyZvWgvvgIMWILv1aa3Kg6dhqmn0MqgneW/epQLluMk13SeCGLYli3INBWIgrS6p05F0jrtuV3Vb7lA1kmzGB5jUthZKxoXZ9drQaUj3MaFiyfEJPe2go3JKYrOCO9k61ElOEwNHmZKVm3EMWHV58GlQbp225xTJSRQhj9Tcs1NhleeqKRHxm+x68Nt42IFZJ6bLywWuZmeQ0kTXWJb3lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6996.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 16:48:58 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 16:48:58 +0000
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
Subject: [PATCH 2/3] security: Expand task_setscheduler LSM hook to include CPU affinity mask
Date: Sat,  9 May 2026 12:48:46 -0400
Message-ID: <20260509164847.939294-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509164847.939294-1-atomlin@atomlin.com>
References: <20260509164847.939294-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:408:e8::8) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ad8956-3083-4004-40d2-08deadeadda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	omROMtyoJITN7rJcT2lCPM6k+zzesyjRqfzPu7UIWaRe6bcTQzBdR3TBpb7x1rGB9+ax9WGyEwyHBg8hrb52LKuD2mjy99TK1PSgw8weFyABo4LK0YXapUZ9a0iwdm1B4ir9GEkuyBhVK7A4LFul+kEA/iqrQD9Jy2fTM57Ii5eT6N+8rD26PPzLXeKXxjA17M3WR/GGril5tc/nIssDeNmFE9VMfRhsgx4dr3olfA3y9hWHpGhynhqUQPPnXvuHEvANX6IBF3NQWnZuqOu6BvG6UAAZZdu6oEhJ9QCnixc+2nlExw99jvNUqPQCl+PExx3DHOxTZpGnpUxOS+PNIPtXRj/99dpIVv3WLiDKs78OcGS8bNGefzy4W2ValPFPz6SDmZZV7T1Pltg8aJ/HmhW4xN8HChIWsSpUqZuLAzT/B+E3lVZtUvbEooq9eGrtbe38Xm2LunWrlLJ93RkqkMQ6Sa5LUyHuNBFYHzau6YrMJeUctCIOjXThdb7fYUYhBukrjevsx7iLVct8FN15rgiiOb063qmo6Y2PKhi4WxzhuqGxstZTLxs2ht6/TZgd9+aQuD2yYddlWI9Fefy4HrNINxK+c2nXlJXhclh/HcC0FyV3amNqTuI/VDrUA9I1U3B7aHZ55DjUUa3WCBbJU+GO3WN2+ffKVKL/1dC6lJAkv9xIa7sONZQ+BhwuCcAaXTt1YLU+rl5ckvJ5KmColRXPiYN2K/HshU+g8giNM2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(22082099003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpU9vQiW1M2UXMsSoki4KZINhXYs6bcGmviLupPVy6N0QtFbTcMFEkb0idJV?=
 =?us-ascii?Q?cdirIOdKPPAAfMYjXBuzE+Bhtb99ExQFXqg4TyiksJxoqt82XRn+x7zPVTYy?=
 =?us-ascii?Q?40x2HhwB7pc53UvC+Qel6/ea89zcfTN4YcPDetTFp/CGc2884+SI/CA47dkr?=
 =?us-ascii?Q?fJe3is6MkIjyvghfq5K4mWzm/EUreHIJqIht2bW/KEqrOocCJ8PGL104H4JH?=
 =?us-ascii?Q?KrG6ziJ/drEmc7nZekg9HrsAfD9+A1Jw4V/i1NQwGglHK2+JpnQ2ZFPhiT47?=
 =?us-ascii?Q?y0dTbv6JYUhZSCvrOFsHWDTm2bPhNol+l7Ayyv7Lru5Y+AKX8dy6VDqWZtpV?=
 =?us-ascii?Q?2U5bfq2V77obUG04lpA/Sh7/bC2eqDJid31/zqTNQYqzXgf9j+1Nz6Fz8LQ4?=
 =?us-ascii?Q?DvMRgJqa4yVFpi4Ho74mg12j9WNoIwP+phWlENuLfpzFdh92Rpk81k/FVDZk?=
 =?us-ascii?Q?M+xDmv9rLM+YA4dWK5XheaDMCW4a7Dya6F66kqNPVglPizzF1Bw/qtEQooB+?=
 =?us-ascii?Q?zJnU0bTFvM4Ucuy2UUWweGtW+rMOgw9HlnDGHYAj2kRV+i0RRinzHinlUEOO?=
 =?us-ascii?Q?EK9HV9q/HG2DisG81BKM2QBCzkmKibu3qdOAoD8sGUhasaLcyWhcxC1O/biF?=
 =?us-ascii?Q?l/ym9rcrts5FnLXt6kL0nR4UigdaO4IX0G2h3sObZqWfD4leGrySa1R/1hRt?=
 =?us-ascii?Q?aPZ/3OE2JWd+XndrPHuFcL2YMLbuzRqFCz3Gbth+av256RpFGTD1XEKQR0P7?=
 =?us-ascii?Q?7//gOXZ/Nh+FruEV23/lXTN8EbVoyDAiJ61KKN5mIXYR9TuK8BSA25iNqUxJ?=
 =?us-ascii?Q?l/gnIbYykn6M7RH2F3SO7aDjDvYT/hfAQJ393WCvVf/xABx4PtDTYabiHThS?=
 =?us-ascii?Q?3TgHcd+saAx8an9pmaF7C15TsDtUDramCSb+Rkv2Dzsbs0+zLvD8z4tK53dN?=
 =?us-ascii?Q?cWx4i1i/hOtJIfPomvKoDzmuiTTwbBRs1NnRWBrrD9Fp8VA0jUf8dHHCW5GN?=
 =?us-ascii?Q?Rz5Oc3j1ZfWu2T/YjsvMb8AC3K6XNpvq3gb6M5sx+DI+372MEdKOEePoMyzr?=
 =?us-ascii?Q?K1/99tvrqRedU7uaiu4+/6qJuE5BiGJ3dF8F/lo0ltAenfAdPEUf0SZYBudj?=
 =?us-ascii?Q?0vgh1jfNNyu3T8NmRU1CFXZimmKU3zlYOrmocmLnAN2Gnhg4h61riELuV+hC?=
 =?us-ascii?Q?070GSUTLJ/5gn1oPh0aw066tAuWyBR/W4Mk5tWXpC8V2u6WzqzuNR2hQiVUI?=
 =?us-ascii?Q?XzH9nnSkttcrNT947wtEmDD4KMiG5NJn1+tY/cwnNZSQ13qnalgNTDddCiEx?=
 =?us-ascii?Q?phzhgKgIWWq3M+l04yj9+xf1erOVi4tyxK7r/57pXE+Xxs7l4UuFFNaQlZ7q?=
 =?us-ascii?Q?78v213o5oVN10h6mhwHjHL8WoX34n/OGeqDuXdBuzbu1uSpb9//rJu2Fs5cM?=
 =?us-ascii?Q?2gcwjy73dBjCSudEh7PhZvhKLIqVQ9frEBVX+5Rp6PiCc7ms3PQeZfPm6kSg?=
 =?us-ascii?Q?CP6Dyw35Uz43EU/+eejCKs7yGOBiWVTZ/F8JE6IegCKjkt+aYwMlNN/cS76E?=
 =?us-ascii?Q?ucChMBOoaPfmoI94hM8ITvakohzVx4yJvUycV6hthu3wW3xav32W/3JyUd6N?=
 =?us-ascii?Q?yJUBVkGWxRxai4szkqXzFsf0xEDxoRCC9dL3/6lW8RakBi6CfcUemQDlpaSe?=
 =?us-ascii?Q?E2MIk0jyVLSRArV7cmk/YI9hL0pt7+eW4tRZZ/R3uj7wF0bl9HgQKxQA3ns0?=
 =?us-ascii?Q?oGn0vf2llw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ad8956-3083-4004-40d2-08deadeadda6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 16:48:58.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmp5n788F3XcEXViKEN25BgVpqOp+l1G21DwrgoGXpqdkMphhpWXgmOCpce9B1hoLy7BQ7DxRKu0eGH7dVK3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6996
X-Rspamd-Queue-Id: BC04A5008C3
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
	TAGGED_FROM(0.00)[bounces-15698-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.231];
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
index 10172fc4f627..a6a61393fc1a 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -108,7 +108,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
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
index b8022f6e2a35..68cf89b17af2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3032,7 +3032,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			goto out_unlock_reset;
 
 		if (setsched_check) {
-			ret = security_task_setscheduler(task);
+			ret = security_task_setscheduler(task, cs->effective_cpus);
 			if (ret)
 				goto out_unlock_reset;
 		}
@@ -3592,7 +3592,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	if (ret)
 		goto out_unlock;
 
-	ret = security_task_setscheduler(task);
+	ret = security_task_setscheduler(task, NULL);
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
-- 
2.51.0


