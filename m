Return-Path: <cgroups+bounces-15696-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE5BJYRl/2lo6AAAu9opvQ
	(envelope-from <cgroups+bounces-15696-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D025008BC
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 182CC3011860
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097732EE611;
	Sat,  9 May 2026 16:48:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022080.outbound.protection.outlook.com [52.101.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0702D2397;
	Sat,  9 May 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345336; cv=fail; b=BmdriSgWnOfjoPSp/O/RUbwoTSYois8aHGn0YPPjChENKZJ/7kT1rWQ1hxkXaLX5DrtyOFNikuJN/g7U+4P+s5pclIt/fZyloUiGJtmQ1jbT1m6BaNGvfSyrxKmMOFGTJFOgLqeyk3DqsKFV0UjuRVSgpbK1GUIsHNdL6f3zrsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345336; c=relaxed/simple;
	bh=SYFXpDSW1F8xxnD0Y1yodYOXwlVIXP8FXiHdsPpj9co=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uOTvhPvUfTiAa4E3BngIs1pUlalYG/i0/r3VGmBEAkg8eMDpnn4ITyS+tuP1dJ2s75xH8xS5mW2YfEZvTeX5gJsQ4vrfDzyRurYhkYJlnb6E3PBtmUps4MIrKp9TI4gK3JeApdc3SottC6GKoWQtc6ZDwyBki4Q9CqR5S0GcENQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmukhprMCkLJjGG7N3ewHBldcRX/+ZcfKV4WF/tjGVgpA0yOoVwYWcIMD4SGQcH7pgPr0M1AGJc1Lj5yOfVajrSxIRJbJQrGQqkI1F6/l5PqNPJCWB2NUg0q9zeThcOk2asKxkNRejaphYkU2y77UJeUB5Q4o1TkknZDLwU3j5KYlYap+o6pRlBI1vRjGeLmY+QB3xjTQ9zzdiurc5ofNbkR+q3ah/zOYY3iv/q3W1o02whzbeJ1EIH0jI7HIjhg4+9nO/w4HwxZlMuLT3HdPqiNKjnkGF8aRH+cT0ZOHNz8ibXMLEwoURaNpPC3+2+teYesPB2jBIzcY0c+93IvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZkB36RKhsi/hL1NlutAcSX0nHdgHD46/mLYW5UgrSw=;
 b=g3cygSLXbfqVq5wYEb9BCsg4rRdP2o6zaGMt4tPTb680m1CdXcFTnV/lHfPI0/+nOy7o2xAddXEE0GT9hW9u2kTINTfiDQQv3L9AKGlMnN7KOgTIZ4HPLQtQ9tLZeygv7PtI1ubSq5+JssDFOVccSrBjNw/8I1xnocxw1+8KSz9CKnJZ8zV7mETC53XNUCaevCXHd9Lfsk5mtYRtENbmjiGC3j4xMhAP+qUXljLZ/npfpxxZ3HkGXwct2QrPukyateJtc/zzh2qNb8tT1DEsHQbfIceKj8v0RykRvfFetKI/H+keEPNEA2wl5cKqUMrNTwRUgsJtATTsIOMOAzyp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6996.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 16:48:51 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 16:48:51 +0000
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
Subject: [PATCH 0/3] security, sched: Expand task_setscheduler LSM hook and related fixes
Date: Sat,  9 May 2026 12:48:44 -0400
Message-ID: <20260509164847.939294-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0470.namprd03.prod.outlook.com
 (2603:10b6:408:139::25) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: e79efda5-829e-4f03-5a4f-08deadead8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yNhD6W/7jtrEwQsoEgTzDs2BHrFydk1uXnoraQywLUTWBfWbvE7SLMjWIK0qI8mVwwB2YtG/KifuStsLJgEHBDGEX8heilB2OZaGbwTdgjjNhkvK4u/NpH5fUYuRitCmdNKwnrgiwwjdDz5oNDD22WGO7j8f6VqV3Zvt2mErvIf5EWtv8bXreu57LDc2pmFzqbtpMRq86t1Kg6Jlu99aaqeCXP8gT/fhEUN9DBTroZA3LXhSIgpSXI+O8uthqTTMkdIPgCaxMj1QFiJLHAeYVWL5P8oaSgVZgwDrqf63wS346jK1f07g+QGtLyS9+OiIP+MfcNSr43mZHKW3hShA3tu6PMVR5Ewf5uJMdV43Soubn5UI6MxMnPQVmFXV7ep60hY9jgmCSQiFZoquL0e6j+XsSk/0kNGX1wDZV1rZwNPvnN3e/TYe3i2qjReQaAkSeQi+Y4IifA0luRAtwtDSKlidZOk4/FWol9KJcR35cIplbaIcpQuEFgS/ImVxkaOzmAvBKY39SbcfpnkESNzDFld/xUFlwfh8xxjdln2GAw+CMnMkj539rAEnfGVKv4x4QcfVphPqW6LaeiSFGTr4m7uJ3i61q8Jw6hFyLCC1wOMV5UFdVIvcbBAzwqfYCzZ0T9SJuKNSg0eeGW/yXAz2WsFn2CFFGDnMZ/mzxaO2cHjizmdgq8nWzHvhRDOucXOhjVVYHmfCxzkoxayco9GLyVk59VbIFXe76JmZwCeUiow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MB8hhV4ikI0u5TtwKVD1tZ12/s97r2jBTkMIgHNxFBeOeTszDmX4B2oNH94L?=
 =?us-ascii?Q?OtWmfPpzZaq3UieqdpKZh1NAPfqpRpXYXvAy3aoZAMI2aClLlC5k7ZNYVaKt?=
 =?us-ascii?Q?LyRsqjw7ezMhLTWfydR5JFCyfJBL7KkqDQytKvrYbojOpgWO9GjXecUaIg42?=
 =?us-ascii?Q?F18xtwh0CQ0WaRFc/1OhwVTnnY7fC6j9O5zsbJJC9FJDt2Qks1p9RNH4FSPT?=
 =?us-ascii?Q?noO93hGhILVe+RiZOWp1vCSFfpSWlSF9tTnwAFfdaUeVsWRESFcAjaiWBEOA?=
 =?us-ascii?Q?56pfblNcW1F4GrvpgUYaOBaTuSBcZaWFzQIXnGhyG331VmLPCTdAIubL0rUW?=
 =?us-ascii?Q?xKl72QJNqNgr/dTIS9IxSZyWjC585CEE3hQhaUq+EJbf9sLlJewcBdt5AziJ?=
 =?us-ascii?Q?gWpaimg25hWvjxCoLhecVa+i+l8OADFkBEibGtbQQFkRD/NBIk3sQGh9zToI?=
 =?us-ascii?Q?DySiZWhoHey5MUQtwsYEI+Xgj39j+8SZg9igSHn929F2+2IfLDXpseQUULyt?=
 =?us-ascii?Q?HJAbRUALdlR7QTlI8mbrJ+qbDWBVLvto6WEiiZxX3ZIl1/JjHl+d6DlCL8sE?=
 =?us-ascii?Q?nYGtlyY2GbqlfSN8dwBv8Gtot/MBgnrwkv3PIp6Yc61O/m3b8DlOJyso1fGW?=
 =?us-ascii?Q?MexQ3n7PgVNBa3S+vkgb9gBZXP+UGQsWQYSKW1e7CChJNNR6l1HLN51OR91x?=
 =?us-ascii?Q?Vd2+6QehVoR76U0SqooWTcsJd1zCz3CfKxOLkH6ktkGw8iFwYbm9oxdOxANh?=
 =?us-ascii?Q?ZjUFhhkxmw64NvphW3FPjmBCXQYMHvSsEWaE4wRveQRdK7g0b+/rlCn1NQ8Q?=
 =?us-ascii?Q?D/dL8JdUK0Cpb+gJrbgwu8g1JiJLoNsjO3JySkydQqCjqc1jWOm7ehwhyxhs?=
 =?us-ascii?Q?nCxn7PUal9jzl+bj4Zw+yer3UZIS42j01fAUb2q4AAUo0caQpobfATOyyZ/L?=
 =?us-ascii?Q?kt0oinhbDFa7YCcd7PfmvJGLurefhyUaoKQo0pqUoRehuiZ2TMJkpJQCedHj?=
 =?us-ascii?Q?IhQXRVFgupGmrH/FqyunHRi66MKm76jrSraV/uen3eoh8jL3KhX9VHO3minI?=
 =?us-ascii?Q?Jod/bnnm0/2zGgmwAa5cw7vOU5R0jFounNblxEDR/Gjdy6JoeLVcftH2cDxW?=
 =?us-ascii?Q?s10fI9UbbpnFUUdKM472hBkFtm4Cl3rGL05m6ghFzT83Ba5yg0c/qRux6sNj?=
 =?us-ascii?Q?7g0WjmTanwl9i4k1rxN2lAzfv/B2y5EXbgmX63Pn9aJmmTNjOXdCfKKIIJFT?=
 =?us-ascii?Q?DRsND3BZk2LZX/NqcPNKFsWl2GGsQU/Os7qhEyYO9BXwZs73WcFHvSCT72Ep?=
 =?us-ascii?Q?XLiwzY56E2ZhVkRhjivq6RKLh+48DE9xFwHvCYr9wE6OFV5weggcJu2GwVjM?=
 =?us-ascii?Q?hWWVk4dKNiv3u50VpuFUp1pmLdB2mNyJwgMZ6MOWiw5ICtpSA28MakEwKr2v?=
 =?us-ascii?Q?nwx4JJwhW3Ms4MpWscmlEBPin2tlt4he4nBLNmmbGOgM/QPyoK+MRF0oOLF0?=
 =?us-ascii?Q?oiT+k6rwELuYh7/JUJvSTork7D9PEr9E9pREJQYt8TpPIvrcEc0KPxN39eos?=
 =?us-ascii?Q?L/KFZYmOjP8Ilsy47EMr2PK5dcpopiCHPTJZxbNEaeTFnWm/4VWwmTew+X2O?=
 =?us-ascii?Q?cxjV3ApGIY7YLK5DRNo8DN7cBXSjSbiIn7KWwTT4DYJUNwp/SoembS43H6ei?=
 =?us-ascii?Q?sQe/jQo6NXLj0eNUsGP7eDF32JegYmBWkQfp6w1aGWn4h0Qly0PuAUVlml/R?=
 =?us-ascii?Q?cVg7iJMS5A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79efda5-829e-4f03-5a4f-08deadead8e3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 16:48:51.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YztpON5eWsvqSKQvVW35dyi3KMZAc1Nej7pHu0B+MeaTy59yg5tbfTHhwko13rCJjX4n8kJaMGQ4ftoet0Zqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6996
X-Rspamd-Queue-Id: 35D025008BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15696-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.403];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


Aaron Tomlin (3):
  cgroup/cpuset: Fix deadline bandwidth leak in cpuset_can_attach()
  security: Expand task_setscheduler LSM hook to include CPU affinity
    mask
  mips: sched: Fix CPUMASK_OFFSTACK memory corruption

 arch/mips/kernel/mips-mt-fpaff.c | 41 ++++++++++++++++----------------
 fs/proc/base.c                   |  2 +-
 include/linux/lsm_hook_defs.h    |  3 ++-
 include/linux/security.h         | 11 +++++----
 kernel/cgroup/cpuset.c           | 13 ++++++----
 kernel/sched/syscalls.c          |  4 ++--
 security/commoncap.c             |  7 ++++--
 security/security.c              | 11 +++++----
 security/selinux/hooks.c         |  3 ++-
 security/smack/smack_lsm.c       | 11 +++++++--
 10 files changed, 64 insertions(+), 42 deletions(-)

-- 
2.51.0


