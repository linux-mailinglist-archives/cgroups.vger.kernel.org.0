Return-Path: <cgroups+bounces-15701-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BYaGFCp/2ng8wAAu9opvQ
	(envelope-from <cgroups+bounces-15701-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:38:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED7F501812
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 23:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E6C301428B
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAA39934E;
	Sat,  9 May 2026 21:38:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124B38D018;
	Sat,  9 May 2026 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362693; cv=fail; b=uQK/y+XfpVBMH5uZ1Pc3bkauW6okQwP4SQLyjTODdDQft+wjyMnFIWXEPJ4ocPIIHxMLFFq/0aDyKCFNoD0gLQjJ6XXy55SR/zCNL0DtRlQZLPKhP0iYzKmCyq4JbSRhI32RL7qUphFVWp/jB6HLSCYhWVOxquYuPuvSCeqFoNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362693; c=relaxed/simple;
	bh=buKCANOeWDyGgV/o0ydCJO1RW5cuCMXo7FttBSt1fyk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F896HIKoc7xW6lW1zInxt1P176GFjSsUyq/GBf4NRNJDHjaAChPxyY9zWkBNC4t+cqKTVxUG6Qs8vPpNCWTcAamGI1T3joTFREuW85J461J0rrKXnQ1G12seg0C6vsEloAgZyQZs0g1MKNDbvSBxKnLk9rItZ8DcY5sYgzjOJy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykCszCoXeRvDzGt6RJtaVvttkGmFbNtD64gAFpyoztvb5wNOZick/Y1RMT6HlAPkKZ1q15UMUjDqcph2TSRoyd98BrnJbUsCpo5WnFnIfb7VEJHyGV9TgmgFD/JaP9QE/UzV9QLRpa0PYyRm4yJDZyRkXAcmKy0nZUwm+nV7EXycuKJtM5AyO/FEXT8m93Occj8TyVLhkAXu7qrvZhgCVMnzAiKOFamMl0zRkrDktnsZXoiC0J8NOCe6fzX4RX42DckM0bpDnR/ZzTPQRf1o+dDulfPffL/yZtNiECBVdgTIxhfQj2/L4AOP98vlurS8RafuvfdwHILAJ91PiMOKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ+XcmLFKtP65cEQfGCEYtnuWzFnT5QvytvnoKA1qX0=;
 b=TRc8CYjgc/auPokgrz5Ulc66utfERrqzjq4QVBsVEAFx7dDYS3MtrbfLwFUnRHwDK43VhHSbBEN07KJj2guG49ERCR7pMykhRltFfs2fJ7F3iVDz8ngN1CF7zLQQhqN1L3dyC25Kp8VPeN6HoPNTxyRVtno8tJgDNYOdu/tn+AcVg0+U2jZ9kTuJcHL/TEKWRLBqqKDE8xYIJbMkzytjbdZ1OZRb5LavQ21lIyCHwbEjof+G+fPtRAtmc7R0FDvKvtBSyC3dsstICtY8W0YacRkV8qt57ZDyafh+9+7Ja2p/NGC7Xt2nG0Z7uLbuu/0axtwpBrssWXR+evBbJrGLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB5888.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 21:38:07 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 21:38:07 +0000
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
Date: Sat,  9 May 2026 17:37:59 -0400
Message-ID: <20260509213803.968464-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:408:ea::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: cafdaa9b-428b-4b99-467c-08deae1341f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2713yXbbE5P3jEtaWA9INqc5BdokFeishe1wgUPN906mbY8A6kxThEFFbhZ1B32PekufVhygBQI4OdytbL6GSY5Pw/ZBP2GjllZD4XXKJ7YR/TENtIre524O8+7o2DO5LNBWxsWoUppIcCEYlhQVt6/3rwax4tyiIQiD0Tm+TCJvukGnTiL0saXi39P5xSA8Us4z1tl+4GMYhe00grPXtD3lLm2oWe8VA9YtwKREYPa4g1VPnoL63c3oWJh1wy1MtA4tP1+YHnT1OvmRaHDCU2h7lldqR+GWiS139/M/de0p64WDbfaUaYu3CCjODCtdRJuqFxWd1WRosBGnBNkws6o6469FZ7B+SEW//ryk7hFOEEONZkE/vVhzdJCT4mIlQItRyFwdJIIy5Z1DVLl7I4bLwdKWn+Og5AJZRVD79OK4Y9zQNoJCM7Cdfbk/kfjDLUeZWoXeTWtm7Uki1d3sq0WFSRirYjyXhdiflDdQBxyPdUAt21NGmFOcAkH+PjHn5yCC9E5yklOZvdsKDK/hWrEDG7MVb3uXjCoiwwpDB0bPysdgwEbfAsWhl1dV2D5nPibcq6bl0PhSWRcaLV6cuPE2sGWDzUGpCt35mzaPDUVjt+9CUzfacWfJpTdawlS1yM1QvD5YWaSTNyBDD3mAEngIz+TAcLYakdQCiiq4abrCd5vYs8i/cePlv36y4z0tv2DCZ0QESRqerqqRee3y8sVRz0xJpwv4P/qnlsyrk5gxqKX95frdXFRDaB0LBDQg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WQ/d5HH7+aOLzDeXZOA9x0tOT6SvZGtqVl7/jhLkgtO+cKrJMU0+DRyELfj?=
 =?us-ascii?Q?LhOOPG5iweVYNFBmWttG1ZSZjntB4eXbv5bmn3XU5rPnUkMmU0ujEhizrTLH?=
 =?us-ascii?Q?VWOieStopXsQZ3slMke39AfzVdoALGXDh3Lm++ks9ncV3kd7uhMNzP+EwpNO?=
 =?us-ascii?Q?bddBn90PNH3xha3PaRKbHSE86pvDhIVebXLRjElBnlx4DMJTNxICt0igfv4L?=
 =?us-ascii?Q?NLElF9ptb5+b1DQpV3hoVMNBMUqdeR/YxoXb3DH9LiUSsLdWQ1Cw5/dHjdEv?=
 =?us-ascii?Q?Fy3sBrJclbkrQlyUl3vgto0kRmWScy5+r1GLZRd/DRV9wuMeQ5aCNWgmD37F?=
 =?us-ascii?Q?6toi4k0SHICHRFxdl2BMy8Y7TT4eMpHFnYDQQvEaqjyOg4ydhQSilAvWeDEV?=
 =?us-ascii?Q?lwc6w7SHaUXBxtL3kPp9uHGMkpFcr9NFl88pogtA8j+6gQuDJNyjaWnXnyu0?=
 =?us-ascii?Q?Yrnb9lHtmZ3KUQMc6fb7mt8fIMzn+LDCCyCvHa1IsGaC9ULk+TO7iB2exiRo?=
 =?us-ascii?Q?U4ajsT8Fbjc5gALecqEA6Fg3kLLIYijvBIa7Xl0OzmNrOCrpYr4llOR7z9Jt?=
 =?us-ascii?Q?ZEEdqwrNu8nLJixonmVSEho8kTDXwKw9FrOMQhXTnPL03C3G7wny7WbiCB/R?=
 =?us-ascii?Q?wtH5Q+j0B9jUe8SFuq3jhW7i/p92Z4++6Y7mRhh65QQ6FE+dBXDYWQJkZGE0?=
 =?us-ascii?Q?HA0pQvNStBZsTvZGajkYQYzTLfgHG76auJGd+Z7rtBoBAG/DVY8SO59bj9e9?=
 =?us-ascii?Q?hBfUo1ofAeZRByNh6QY2IiI5iMVHB+Pg4Vq92HN6iXS/5JRbYM+EkAArvcgW?=
 =?us-ascii?Q?mEJ/8+WXr9J0aCYwlh3RqFvoRqJ8Ri3dbIEcM9NQ1xdUtPaWw5s3ywlyE/r4?=
 =?us-ascii?Q?Iv6xzK3fVVsL2SbYtj4+/ZXUsfsSFkoRzZwc1cUbXHILK1+WLHOxJ/Rs58Pw?=
 =?us-ascii?Q?mD2nUO459qwl2PotTg+BYUn11dREsZ3kWEIsXYAy3peeZNttoAGEL0Sf/idz?=
 =?us-ascii?Q?UbOSls0ttjp+0k2dMZNp1har5fLDwQdoTV3EyRVQs//KYnyN9p60MCFfR2pV?=
 =?us-ascii?Q?w9OW26wdtGUd4jsijnvp9+Mof5CfA1IRMdprHDc8/exnOZpjXj4O3SjRne6E?=
 =?us-ascii?Q?Iths/qL4av8UY91u9XQTrLWltEguYqGK5eGnQNqToGRWEoDjYfhsmHH6tEk1?=
 =?us-ascii?Q?NzlVOobcCUvBRt2tCrSNaHThlIlTMeZdwYsUspa+ovCIdwikzScmw3HTA2dD?=
 =?us-ascii?Q?ummww/VjSEQRwci+yg3iywukbEbzwgCXqLmNUqm6mdgXPVuTEZpZBD1vQykG?=
 =?us-ascii?Q?CY9tk9HaGJM6s1QXeyTnFFBxQzW9aPRGlzSXmVhFlNofX24w8GluGOgCPxj4?=
 =?us-ascii?Q?hsTZSk+SS6yckat0X49rHYOk9PuXbPfL5e8KTL2LMZe0duTehpGWTdnzXWV1?=
 =?us-ascii?Q?STUrYqTwXdMk4QQvEfG1xe6b/fmAmfwcRxzMYO4MJd/sjfmz4265MQrg3KO6?=
 =?us-ascii?Q?rkzSkit1lM2K8rcmW8C33T1w8+rPLecFd9RbZD8V1Ahm2WHBM1PyEzfA7XWX?=
 =?us-ascii?Q?lG6YSfqelvGfaSUv4l22sXaUoRlJE3D7uc/sEdXRhFbd2HxGdZDsIbRyp3jN?=
 =?us-ascii?Q?V90sVC0jTVPOG99jhhPsSjtMS3vb54DPJc6cD0iCCg1cCerzz6iFuB3gzkCA?=
 =?us-ascii?Q?/+sXoCAtMltDxKlEE6upKwPN9CmhUAPjc4471qBq4foXJOK80LfX4KRhFspG?=
 =?us-ascii?Q?ZM8kTexzgg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafdaa9b-428b-4b99-467c-08deae1341f9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:38:07.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpO9L3fPMQLmQ2fpvb7UiJcP3XE3QQjhA1FGO0NIo1jQ9ioUfI6VEHVJpTiuBydhEfYYrPx9dbl6Xj31nSm8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB5888
X-Rspamd-Queue-Id: EED7F501812
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
	TAGGED_FROM(0.00)[bounces-15701-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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


