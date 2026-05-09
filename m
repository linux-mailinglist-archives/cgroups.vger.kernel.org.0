Return-Path: <cgroups+bounces-15702-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJgBEICp/2ng8wAAu9opvQ
	(envelope-from <cgroups+bounces-15702-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:39:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A639F50186E
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D8A0300DF72
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4239B4A2;
	Sat,  9 May 2026 21:38:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1339A040;
	Sat,  9 May 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362694; cv=fail; b=kFr/tuuahns/Q/9FNYOQkOHpw6gqyGSgAtlVG4q0m8n3gk+bW7iTA2Vy1IXeNMtAUCkVfzGfsqJe5r9piazMliwpZOFkAbbhm/XYZh52R5VkaBh7e4QpbKiP/4t4BSOZUU8ZvsdsQI4FbZ0jsF8zUMId3JFA3ZyXpm/EzZrGZ58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362694; c=relaxed/simple;
	bh=buKCANOeWDyGgV/o0ydCJO1RW5cuCMXo7FttBSt1fyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6yygFsZZgGzOh/2dyk1R05CDYUJOrlYotTs3nqSopI0pxQAxDxFOjbkLfXQ10uoaaIVXC4yEcTKDb5oYYsfeIywuL2ur7UO2ehV5rkSb59R2AormyhrkDdkWBbkHjseQxsMGOc+HYTmp9eWeNSR8Q7pZqoezBBle62GYXV6J9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpwQB/p7JZCyRDs9aRZZvpi6h5+OomYEKm8Zs48j07YeYWLKRS+LxedecfgHmnwjrCtrgSRaoSl/uh5zWJJ46tt60PGNv/fcgudVR6zJ9wytykyTuGEDN9bjOzXIzsJ85RmVT5Ac45fKP5ZalNoJnAablF+2jwifpQ9oP/10ZWAjQ493/PuFdKP6AjA2N9mRZX72doAJaeAotEPMaYtW73wmohadoti/mMQNTQWKti0cdg4lf3c0gyX8dO0ZGGx+66vSIfJkPy9+kJD9/KJAbmWqhfAkNTLbL5xHz3VFRwDeGg33X9lttqBQsy3HG8L+HbnBFoA7ttMHxwiSQhgt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ+XcmLFKtP65cEQfGCEYtnuWzFnT5QvytvnoKA1qX0=;
 b=UzvW/oUPsBg0o6f20YBAbEEHAzNisq9v6yXTrDNU8DL4ofC4G2jZSLDgWAL97yxJtQLTP4i8R/DbQY3o1AxZH5nqdFLtHEwyJ71pc/lbmPLg+PiEkXMoIVCfN+UfGAp+q2uNNmy2Q7yoCHUxH+2vKvT54gaNwA8N176ul2CYH7f5eWKdkS/A9vtAa1sf4K+YhP4ks73HhMWnfcuEINmTKcUAlpxmG+Jl+O/1y1Fb+75LnrZ0AKKX5pzuHNpWHENdraf+MvP8Voed2vyYBgzrUpS2FEfaeGrnnti9EuiKo9+jgsLedGdhv1U5bw248RdcZLgDvYLxqMsBkO8Z8nCyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5888.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 21:38:10 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 21:38:10 +0000
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
Subject: [PATCH v2 0/3] security, sched: Expand task_setscheduler LSM hook and related fixes
Date: Sat,  9 May 2026 17:38:00 -0400
Message-ID: <20260509213803.968464-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509213803.968464-1-atomlin@atomlin.com>
References: <20260509213803.968464-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:408:fe::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: d522ef87-aa0b-499d-7c1c-08deae13444b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ImqOzF8PwzEpHUbIWjRGM7LGgjzA9dnX+rQA2VRz9ZaQIgzLy6z660XzY3aCpL+2ZsOUQJ3/3o7kQBeNic+QpwiEa+JkU3wY4iD8UG2kLUg5SzVsm1FTOY3CYKaY+xrl1Zh9x21JbRb++duw1e7szY+KF+Ke3Wm06yz2hRLNvGoWwgGCPJAPU/8rSW7+a3YVNQ2XdT7gr9M6DUXGalc4TnN+58k9R6DcL0B0Xd4Amn8nrxgxjMWo26KjC7AMR8o3jGtj5M6XvnuqTD0gxcYQ8JQiecbFvBzlyjJHoC/7qqRWmboojqUbOMBdfWkBt/lmtJshqaSqQLE6I6dGZ9tWvwzFYovGurOXaxNpiwUPq/keINBBOMegWEaoCvywleh3NYLvbxZKsfRa8FpoXA34eD1NCWXpeaBFrOJU9CoF0nXA0sIJBYHBBUoL4+0ailSlELZZ51E3rkj1kUNWDqniV1c7VMnA3B6S7BLifx0BwqJigfyMg1258lhq3nAv7EQEAVAWOphclmh2f5DeN48YCGiuZtXzCKbRUQ5BPphRYKksoFAm3TrTY8nlQ639v84hFPnr+3G8Cz4WSoP7bhI/mRMBfRmftlSKVUi7yBQ9HkOX59+jVGuDeMRbKKzxHxfSRu1RjhQFsVgKb4oz1TkH0OGziMzQuusHZd48oyDfDElNkPBFSp3rCaEAbbJtv2/IwUjPNrpDRi42pUYSyC74ELY70sJrOL51ZPsmMN0ZZy6ZxWLMD6q5rhQBh0xN3GlN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5O7N9S469cuLCFT/OgyTgtgOXpU67yzqanacSF+AAlOlZYtE8UtAZaGD85yf?=
 =?us-ascii?Q?IPWaOYhgfZJArZbsM2dFNFUJxXbC0CPjofz6uLgq/lvjzARN+yewo3NwLo/9?=
 =?us-ascii?Q?pYmxBAIeERo09hkjhYAwaCMCRaVPaxqi25NsS3x0kAYWvxOHSvtqbfAq4nFt?=
 =?us-ascii?Q?3q8IZdnpm+8r1Mb+6u7RiNiR9bLnVALy1hLHkS7wh6V5dNt5cfMktp6K1KsG?=
 =?us-ascii?Q?HWw9dlWBTlzh5Ta4acNfNgVvI1GLy3YBXAM/oPTdfd82DmhYkN/s37lgqS0J?=
 =?us-ascii?Q?9Lf/MmibLh5B1GsYxnagRI6+1qpvz/FFEEMx+2LgJkWZZ6rBwGL1xE0zw0x4?=
 =?us-ascii?Q?OCfFCNMp6qi02cPLVuLDts46+Trc95OPDOZ4M+sTKyxzvurMXZzqVpdZ1ZJ4?=
 =?us-ascii?Q?AftvzUMeZhnktllaNP9K+CDaYnC0bsAZRCjLgJkRDBjLbwxJyPCR6sK77cXG?=
 =?us-ascii?Q?e72acVA7r3DSdAO99qz3TBXIVBPOqa2M4M4IlR2atCUqUosoIJUurwu2MaRj?=
 =?us-ascii?Q?EkOhrsREz6K194orbpe4SL+XU7g2FyVqlMDfZRbfphZaAWLV5n0NrngP1hrm?=
 =?us-ascii?Q?Evob0DghYu4N+vBmXqOLJAVImpTzv8TsOBtYaiKqfOZMhyL6I2wXccDMj4iO?=
 =?us-ascii?Q?e858lnhEt/nJuQuXAhRj+82D5nzJQqZP7mDa8DkgpL1bh/sIvRA4kNc6HKk8?=
 =?us-ascii?Q?CdlF+4AdimlWGXYwJExZJjuUkUi4w+SgLx6uYHVtuftg4CQAUbWQV5jjI5HJ?=
 =?us-ascii?Q?z2jiplwt3s4q3/cHY1iaZ+Qu1lHX45p/0WHLOc3460/96vxeOZmK9gZF/yH1?=
 =?us-ascii?Q?s7BMtWWr0AU1WeohY/RMIN9vK2mevxETEdbQol9qbWCWzmc8hR636m+JnE4z?=
 =?us-ascii?Q?Znk+MKuaC0btbuWg1QLPxMJoqmwhhx9mH9p7J9RE6COv9/c/cpAWOZqrTbUu?=
 =?us-ascii?Q?70Vm0Jq4XqKVbtlTh51/e7wQYYP7AbWtyaqkp5/qScJTvfqNixgHUMIXMxSQ?=
 =?us-ascii?Q?Wf8fcaQKNxyBmsnmC3U6adw8q7HkVavLxMWON8ax/G0k2YqbuE9XnrLMS5e/?=
 =?us-ascii?Q?AyjDVp98RXSUmVXPO7zRjOWyQeJdLCHei1R3NSt/wuyWxul7BDZQz5Hw6r0m?=
 =?us-ascii?Q?RPBeWTpKLf0u7U3JHV7ANcm3lhMbPnVXqOoCRc+MMy5YZxXhw0j0psprf0LN?=
 =?us-ascii?Q?jxsLkearfa1AEwbAFV6yUYKGhnyySOUJ/C0kM558dvR2v2GrdjHqUY4JkmuY?=
 =?us-ascii?Q?Zh+ewvGUWDpX3yfHpOYeMGI6xF3zG2Tw4PpB6BAZuPjv57tBcAgBME1Cwf6Y?=
 =?us-ascii?Q?RYLFj/rEaKg5deac7TrWnkV7VRHzI/DDvnKgMUOMmATxq2WTLa4Drb0rdmJW?=
 =?us-ascii?Q?ial8Fbx9o8aeC+mlTsIssHs4mQa8blCuOLF/5uRyLFnPi8as4+Rb9PNlqKzb?=
 =?us-ascii?Q?Ep8oOTQ2ZdfReNOUFTKQvEz8uaylv+kcTVBXBvJlGqAuKBgETjnY5hRZWAA1?=
 =?us-ascii?Q?kdeYSo44dIZbJpN/2DO4Aw22poLqxzr8aP4XZn/KfNERXc2E7i+x+bRxavvB?=
 =?us-ascii?Q?alxoR5a/rkIBW3moQ6kgs2VhP1ZzzXIKTadcevNcU+5B8Qk/ql+e2jiRgVBD?=
 =?us-ascii?Q?V9LNm4AJu8cvszvxWfR1tb7NIcmsJKkrtmmWFEM9l1tq0wOEz1+uoI7xqbJA?=
 =?us-ascii?Q?l1YkR9Gg1Xe4hA7fXEUfhT2UVBBQ3rv6KpBwjUXExWSbWWbVcu+EiAe0rPfb?=
 =?us-ascii?Q?vfm6ePCnuw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d522ef87-aa0b-499d-7c1c-08deae13444b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:38:10.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: femtTY8kTFbNBkocFVEqhEkfAfSY9B/TsGC/NJZ71m8KuKnf26CiFbtAtrLFdfMJhTHZtbLilVDl958WTWgaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5888
X-Rspamd-Queue-Id: A639F50186E
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
	TAGGED_FROM(0.00)[bounces-15702-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.812];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,atomlin.com:mid]
X-Rspamd-Action: no action

Hi,

This series expands the task_setscheduler LSM hook to include the requested
CPU affinity mask, enabling BPF-based security modules to enforce strict
spatial isolation boundaries. During the development of this expansion, two
pre-existing subsystem bugs were identified and fixed.

In modern multi-tenant and real-time environments, CPU isolation is a
critical boundary. Currently, the task_setscheduler hook lacks visibility
into the actual CPU affinity mask being requested via sched_setaffinity()
or cgroup migrations. This limits the effectiveness of eBPF-driven security
policies when attempting to monitor and shield specific cores.

By expanding the LSM hook signature, BPF LSMs are provided with the
necessary context to audit and even restrict specific CPU pinning requests.

    Patch 1 (cgroup/cpuset): Fixes a pre-existing deadline (DL) bandwidth
    metric leak in cpuset_can_attach(). It was discovered that if a task
    fails its security checks mid-batch during a thread group migration,
    the loop aborts without unwinding previously accumulated DL metrics
    (nr_migrate_dl_tasks and sum_migrate_dl_bw). This patch introduces an
    out_unlock_reset path to guarantee clean unwinding.

    Patch 2 (security): Implements the core LSM hook expansion. It safely
    propagates either the requested cpumask (via sched_setaffinity and
    cpuset_can_attach) or passes NULL for unchanged affinities. It also
    adds proper __nullable annotations to ensure the BPF verifier mandates
    explicit NULL checks for attached eBPF programs, and mechanically
    updates SELinux, Smack, and Commoncap.

    Patch 3 (mips): Resolves a critical memory corruption vulnerability in
    the MIPS MT architecture's sched_setaffinity implementation. When
    CONFIG_CPUMASK_OFFSTACK=y is enabled, copy_from_user() was clobbering
    the stack pointer due to an invalid sizeof() evaluation, followed by an
    uninitialised heap allocation. This patch safely reorders the
    allocations and properly utilises cpumask_size().

These patches have been logically separated to assist subsystem maintainers
with review and backporting.

Comments and feedback are welcome.

Kind regards,


Changes since v1 [1]:
 - Reordered the allocation and user-copy of new_mask in the MIPS
   architecture's mipsmt_sys_sched_setaffinity() to occur before the
   LSM hook is invoked. This ensures the security modules evaluate a fully
   populated mask rather than uninitialised memory, while cleanly handling
   error unwinding

 - Updated cpuset_can_fork() to pass the destination cpuset's effective CPU
   mask instead of NULL

[1]: https://lore.kernel.org/lkml/20260509164847.939294-1-atomlin@atomlin.com/


Aaron Tomlin (3):
  cgroup/cpuset: Fix deadline bandwidth leak in cpuset_can_attach()
  security: Expand task_setscheduler LSM hook to include CPU affinity
    mask
  mips: sched: Fix CPUMASK_OFFSTACK memory corruption

 arch/mips/kernel/mips-mt-fpaff.c | 46 +++++++++++++++++---------------
 fs/proc/base.c                   |  2 +-
 include/linux/lsm_hook_defs.h    |  3 ++-
 include/linux/security.h         | 11 +++++---
 kernel/cgroup/cpuset.c           | 13 ++++++---
 kernel/sched/syscalls.c          |  4 +--
 security/commoncap.c             |  7 +++--
 security/security.c              | 11 ++++----
 security/selinux/hooks.c         |  3 ++-
 security/smack/smack_lsm.c       | 11 ++++++--
 10 files changed, 67 insertions(+), 44 deletions(-)

-- 
2.51.0


