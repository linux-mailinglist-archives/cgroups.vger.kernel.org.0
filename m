Return-Path: <cgroups+bounces-15704-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YODzORiq/2ng8wAAu9opvQ
	(envelope-from <cgroups+bounces-15704-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:41:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE205018B2
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DDF2303A8C1
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46839B959;
	Sat,  9 May 2026 21:38:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078C39DBC2;
	Sat,  9 May 2026 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362707; cv=fail; b=j2s4yx1ZkLJ0CKqfyLkRILYl1GaZsc4APzL2jQpeP9BpND6U7ovOcJoau0i4MKM1D82osRru6MzOD2QYBq3q16E8h4iEV8pQpznxTcC8uTqZxrtOi28311AUiiUXnsPKZo1viiFNqIN6RU8yyrjnD7lZy01aVhU6bbqQgBDE3sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362707; c=relaxed/simple;
	bh=m5grnZ/G9gVMH4EyGQ/iFAToQd8PQNWxdLUJ5MdlBM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V243tAPXgMq2VIcYW4NoR9lGwj2QgUR144OqLlE1NLk2qFGFjn+MW2fUp9ojd74+Q4jqleLpvEd4G8i87uOS5qmBVvDiWDHBjEERVuR1jGwBmfT/VOt3udrYz6aWwySc0xTXW80PwI43d89KwYT5mq5elqIxVvxkQERatBkpR28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsNttao1OTu4eTuEJS9VqVHJKrrT/AjGCgriUsoQz/q36GTpdfIGPy0zv02CPOy0XoS+rTHpJQxRbF/jjN57GCSsp7uB5J3WeLeB2NPHggqAcN8kmdm107YGqBJF8NwgEDDAzqjnJpZcO+QZzE5LvH9CV0W6F5vminy3+PUJJCaEaXl6RiRd4jqyHbiWSmJEhoENM+AprPzfDNbi+8TqYf+jz/RM5KWnda56rt8prXa7R60/kqDke6D4TzEoY0JOmMbgR3TyeVmRUx4OvuCBj4lJzPkSEIsFyaCvvbFkowmys/35F2IabkEEX/vNFSMbimUXPPSaTLMdvDzrNaXAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgu2zTA6W4t8+U0uXc8lLWgp6j2clyDEFahnn5zORM4=;
 b=ayWM2+jXjZvVtz0pHBk3WrJs6j3OqICFHUWByh6W1GqPRLUDcronTLN+QEmwrvZwhtmVRXB4iuI7Bq7GqS8F9HOFIwcRXvUT+9nMBgfCJZKZZG3+SaVV2rgYITErBI3Q38RH3ZkGOvlJ4+l+05qFWPBmj0J82Tt6gHMq/n7Q1WEOZ5tFyYzOavbRF07uYh40zWKXOFPY9iXDLxNpFCR9Xd7B7HdABOM6xmQLOel1UaqhXcykpj/fYbkdVLNlB8QparmLauqD1XsfNxWdaD0Oi+WQN8AK/AJPRoXYJaMoRKKp9CLckJ1JPOawj6PPjgjY/hlGUDuN4akXlQLsUshV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5888.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 21:38:18 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 21:38:18 +0000
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
Subject: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to include CPU affinity mask
Date: Sat,  9 May 2026 17:38:02 -0400
Message-ID: <20260509213803.968464-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509213803.968464-1-atomlin@atomlin.com>
References: <20260509213803.968464-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:408:ee::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 909c026a-6150-4ae1-1560-08deae134906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jnmeFNb363SAW8vD5f6BaoOxHs7Hda79u1pSzk+S3M7JIwCjh5pobh8gx8sPK8WO6Qz/3s5D7Y4gT6cdGvWWhdUyuzhbkbx0q4LC8FVDK/tjZbVv0Mlu1IXslmKhKgYh9AAgD7Od9+asCd7R6fkQRRhM5ZGKZjiI4RZXrqEeIDKThg/i1wkdo9vwPtGN1dnEqn5yj/AeR7Xf6iJVTFurPjYvI2SJA7O8ovqn2PlksCIJEfE8RBXorpq+KcEF6f6TJeWHfpg58J7eSuo3jrdKGZodVe8g+8QegZbWojqXO3rXervYA1Ny7li5EMFtIG+HPuNXZZSy1p0pA/McbgVymfK8VNwy57jfXM6wqktkHG/OK7wWnSbu/s/ZCA5cBoagj0LmLJtArPpZzX6sKyu6+nkOtleMhoCEvdihZs5HqWcEehiXxAGespP4FySdUWKlR2y1yfVdMl7jz+CJpgThsovD0cthklKLlDQ4YS/kASREAX8+4/R8p1a/I3+lyP0wWe/2n+vfSRccRERstC+kUDySR7O4RlO03mG+6eBs+/gq0/mC0Qc1uOuueqGJfMjqFxlXsrSjGT2DzwVne57/D8kT0Q7/fCGJEXHNOgXz/pNzB8Opdqt/lx4AZc7izAVGaSJwR21Nh0RwyY4Z5svvvBKTa3JxoL33crKhAUDnLrrLsTocVxLWvuzAE1E0frMmokw9T1o2t8bcFF+YzyEYN0PX/1bHJ4ZacYX6YJUMSak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0b5LbX6aDUnBJllcL++8Ee7IMOQtOa9f6Y32yr/VjrR6/WSS1UjdCJSYKEJu?=
 =?us-ascii?Q?T/fyDAb2OkwrNaGUTFpBLXpZjf8fLtwZfKid0tzfGEy/BtAtRIMymazkpbHX?=
 =?us-ascii?Q?WTvK9DTeTRYTYr6t2c1RYU8leO0C+hijLWFO3J2ClcS3hANeIRMQegTAFg34?=
 =?us-ascii?Q?0Es305ldaAu1lLuy+EtEHDfHAU/ElDKcaH1azaaHNpIuYfJ1hpovJD4snhes?=
 =?us-ascii?Q?2Bb/aL/p6X8SuFAEnVcsMDGw+RQg0cS62FYApWj1od4QjL8htalpDXVvQ4jK?=
 =?us-ascii?Q?HYlaL0+Jc01B2n/20E6/DCtW+13vbdjIgwSk2YVXvPbA+ekweHMZNoZsdsnb?=
 =?us-ascii?Q?StdaCh6HAmQHPLcREJ6frS7QI6IUF2cOZr37+p7oh7oGF3otoy6C7jat8h3S?=
 =?us-ascii?Q?qei73vd1AnPqYlV+QI26gTcnjI0P5fbCBrpa+e/x9U+Gad7pruraBiZZ8JPm?=
 =?us-ascii?Q?kecxmIZjOdlwT/nm4zk47mx5azc5rIwRr23rYdsM6k3MStyMFb1E3ud1tbw3?=
 =?us-ascii?Q?ZMCUIhEwINo+UDNtZ0nWG5gWqBW3MAvWoZVFmnNI5OhurjmLeo4NtXTlpTjq?=
 =?us-ascii?Q?mUyNTACz7Prk0odaboFBIZeulefw+lETc1xkpQZJVr6vjDeEPeZpciLdxbHl?=
 =?us-ascii?Q?Y+5Du3dDdWCIWkPMJWZz9z5rqYfdBfg22GjgNEASGX0xnnZWcGAo7+VSNaB2?=
 =?us-ascii?Q?xdoAWXpNm0LOSTgw0nTmS1JH5krdz8YyrncFs3jSS/JkP8eGcOJzthfPrxVX?=
 =?us-ascii?Q?YjGSNWONZ0czzq17AZkgcAttnrb/RV4gbc4lTyD1hLZoC65ZezY9rWx/FyhY?=
 =?us-ascii?Q?qIBI6Wz65Bm2jWfP+rCdQysswisTqtykmw9SXlnNH4JGBwVmqj7vRrSGqunE?=
 =?us-ascii?Q?UhGcjRDUjqSuf0Ne9royTuePbx6BiBwRGjsxAa+XPBlGwPsQgiChMC4H+6MV?=
 =?us-ascii?Q?Ah4ixmsP8D0OovLnUWTwgJp699kJzZosQJ7tnvEHFr1b24CiPnTy7/JyvgDm?=
 =?us-ascii?Q?Z5mtE62cVTcnFiKfSXfC47ih4Yz3vroFnJHvenMM2keUB9CIjlDscTAsOeeB?=
 =?us-ascii?Q?m9NrhOwd6qpsOQ1Hb9/Ddq1MeQ93SxPlLy1IktYB2ICxI8EenJBP8ycu3yDi?=
 =?us-ascii?Q?KHLGj9ugS/OPnswGz5gp5RuPsiPNMkYkVGSIAJdPQIwz8ofGKTZ2P425yO0K?=
 =?us-ascii?Q?e8Mrzj4GoREgyjPkxg/L+qgGqiChG8RgxiKCLWTrcZkshYMVxiRKsNAGB2Lf?=
 =?us-ascii?Q?TXPJUwhccQQ2mTm9qpDI8HtOqgkRO9bIL0bOkAeDLK/f2Y/xe2bBw9vmffZ9?=
 =?us-ascii?Q?I6CrEnJgRKfJwD15KKXA77g2/3sbDh4UKQRomzOU5HDrYo8n61vHizAG+lMM?=
 =?us-ascii?Q?GUHO4+p2xnSBBT3veEFNP+2BRxC/f9X89WyE1pp81gHd0HqUpYDfUqgBiYwc?=
 =?us-ascii?Q?enlQoT2an9EQtU5DiPr7YBlmSAVwSwgwHTNM1MwIFXWPv0SOWNkPAN6mi66N?=
 =?us-ascii?Q?HyZvLCswZ29Q9+YcVR4BsOETIvLSxvfWwN+81ZOH6auQ+rkPAz0Zm7U9Zuuu?=
 =?us-ascii?Q?/PlQ3pndu+ew+vcyVV1soLlrSiUtn1idHlJcyvbg3kyODc2TBIy2Z+PWcRvd?=
 =?us-ascii?Q?bAPSa4KJDm4WwrkBMFgI+mh8hVkjqaSXjGvq5Oi5457qK6H8XB5594I6MKgl?=
 =?us-ascii?Q?qh/SdnwcEOIdRAxP3aUDL4YshTxndZQqKbBz+XF7g/oUZcvGifiynNtp1Xgx?=
 =?us-ascii?Q?hh/EiMKbVw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909c026a-6150-4ae1-1560-08deae134906
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:38:18.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9CQ7AqcQw0+EGpyOOGZTofhB/cVRbpS1ws64HAzuWxri8EDd2JeMUiTLUdRtySr5bFiSFO2D+Bk2ZbboYpqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5888
X-Rspamd-Queue-Id: 8AE205018B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15704-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.193];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:email,atomlin.com:mid]
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
 arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
 fs/proc/base.c                   |  2 +-
 include/linux/lsm_hook_defs.h    |  3 ++-
 include/linux/security.h         | 11 +++++++----
 kernel/cgroup/cpuset.c           |  4 ++--
 kernel/sched/syscalls.c          |  4 ++--
 security/commoncap.c             |  7 +++++--
 security/security.c              | 11 ++++++-----
 security/selinux/hooks.c         |  3 ++-
 security/smack/smack_lsm.c       | 11 +++++++++--
 10 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 10172fc4f627..6424152d9091 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -71,11 +71,18 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	struct task_struct *p;
 	int retval;
 
-	if (len < sizeof(new_mask))
-		return -EINVAL;
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
 
-	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
-		return -EFAULT;
+	if (len < sizeof(new_mask)) {
+		retval = -EINVAL;
+		goto out_free_new_mask;
+	}
+
+	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask))) {
+		retval = -EFAULT;
+		goto out_free_new_mask;
+	}
 
 	cpus_read_lock();
 	rcu_read_lock();
@@ -84,7 +91,8 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	if (!p) {
 		rcu_read_unlock();
 		cpus_read_unlock();
-		return -ESRCH;
+		retval = -ESRCH;
+		goto out_free_new_mask;
 	}
 
 	/* Prevent p going away */
@@ -95,20 +103,16 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		retval = -ENOMEM;
 		goto out_put_task;
 	}
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
 	if (!alloc_cpumask_var(&effective_mask, GFP_KERNEL)) {
 		retval = -ENOMEM;
-		goto out_free_new_mask;
+		goto out_free_cpus_allowed;
 	}
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
 		retval = -EPERM;
 		goto out_unlock;
 	}
 
-	retval = security_task_setscheduler(p);
+	retval = security_task_setscheduler(p, new_mask);
 	if (retval)
 		goto out_unlock;
 
@@ -142,13 +146,13 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	}
 out_unlock:
 	free_cpumask_var(effective_mask);
-out_free_new_mask:
-	free_cpumask_var(new_mask);
 out_free_cpus_allowed:
 	free_cpumask_var(cpus_allowed);
 out_put_task:
 	put_task_struct(p);
 	cpus_read_unlock();
+out_free_new_mask:
+	free_cpumask_var(new_mask);
 	return retval;
 }
 
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
index b8022f6e2a35..e463f5cbbb06 100644
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
-- 
2.51.0


