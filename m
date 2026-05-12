Return-Path: <cgroups+bounces-15804-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nv9kDHx8AmqEtgEAu9opvQ
	(envelope-from <cgroups+bounces-15804-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 03:03:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A951806E
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 03:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA5B930179D1
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C01C5D44;
	Tue, 12 May 2026 01:03:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020137.outbound.protection.outlook.com [52.101.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEB175A92;
	Tue, 12 May 2026 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547832; cv=fail; b=ucRuGsExDdGLPzkIlrrJlBxulFobeUWBvTUbITzc2kYSqdZYZw+rQNvk1qixJUFOgg/HDSuHj0uLIV2tFH117CkxI9xgL46Xdbt7LY9qI52Y/ca7oCeiT0vkl08MbqZAuacQr/JcQemTgVAuxCPXdtrx48txlUmU+7BCaBBHiqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547832; c=relaxed/simple;
	bh=qR7DaAXPL0zf+3TrAcYyr0712STmz1lMG4d0YtmF89M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jGIbsc979TiyxyWowe/PM0Uk47xOGSEdv6enlQH1MiwlIQGhn7xgAA4mxQ9QPtiAwmURHVBnvTV9lEdBxP6T9dvf3I6boDaVAMGCV6giqx6gO26rLqmVclALa2bUdnErY1i4ozNQMmd8RE+/adsKSHCpWOABnySrB4ufC7fhrEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB4yDxINxsJWBLBL2BcXf/+DR0tjlPa4RKji9S1bEAh228B3OxYZpgbERF/K7LSR/Gy8MrRWsu2bKRmqavJQihcU6/165elkvoRZOyOH+RNbw68LnwZWZCArMS43UETkxLQDLr06Xr1kkNtM+yLHMDopkNCA213n99y4p18JAJ2UjtpyDtbIATmT6q5x9nkXJrBvivwcMBSk2POlJxzREuB+hBiNGF821qJbXzNSBliEId5sMTz77tBaISrsefLkezSR5P+K5AZtt1r5AFKM7x07OIja4o7RBbVsFdVwLN9gg8lJJmD5SPn2I6c8ySiRwVGjC1BZeZOdnyMmZzl7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+/o9CrmXno6220KuvJbZRaSz+D1XJvFxg3nrLysUMQ=;
 b=WSPf78scvVvynZi6gU9KyeApeVvD6eXZNThmGDBBj1Br8HrqnosFjSH2qL7+RE4UNGXv/j0R2Snxd02WD+crbNdm7u17vuiJMkKSkcAMV7QWXBf8sxx7ZXxXo058CpqIX8Vmmn8EIWJRiOvbZ0mj20oZ1hZVXgfgTNDkTQXSayMuR6gf2h3eFsd7KsOmt1/noaga5s6YoJvvi1HXtBBHzre4mzzMMXojsyuBUd6fAhqtULyJdDQZegJgMVUSeaMdSP3cME9PSSMEzERzj3JRfgiLNHsrf0YQHFP1uGUatLPQ6o9eb7gkk2+55KiH5WxO1sviAwAXdcdnuNGDspS2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB7331.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:375::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 01:03:46 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Tue, 12 May 2026
 01:03:45 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: chenridong@huaweicloud.com,
	neelx@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuset: Fix multi-source deadline task accounting and bandwidth bypass
Date: Mon, 11 May 2026 21:03:41 -0400
Message-ID: <20260512010341.101419-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d59b276-4c7c-478a-627b-08deafc25115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AhZUW48eD49Lq02aQ5jy6srfiFJSx8NOLrcro7UH3D/aLC0lIlkKT+OrNxiwKLpUUWcq3VwzSdlRfWpO/eW1d8KLBVAoscbDVryVfUg253Ea8nrXx81iJJ6XUACiKw63fWLvQFOWJ+McAhdzlhaBsKQsQlZqpontKwaeQipd96XXyo9ZO4G+lgPGnTvF41xjwZVIiRiU10H4P8EZUSRzIsTsYnVmDPZXJX/CAqj5ez2k8NVUzaA7ZVpQZifY73xrXpZbDjV5jwKfxU+r5dZU6Sk0RkRKJj0DzheXaREdfn+KoRaedrBoruDs+15XnlRkrhyWEXSaosdioOj7YFqi4sEYq31WE/0OTaMSwlmvQ6FWw5HIYwCffkJHB0FOgYuqjEJk229JFON/K54vHm+0Zg3kq9p+bBtlRS63VbKLiFoaDFhX3Gnwy1+mEhdp6m4qbJZvbvEFbeR1v6DY/0x7uqijRfNmFSdwKYeGoqV4GvLc3VVEzmIwmmyxy6btZf4X5La9WXDyWAK9W8mZF3w/Jp4upEkKO27rlZDrKN5a/O5nNGu1kSA8w+2hsTEkqg6CW61ALrGYY+b+01EuBo6RVbwZ5xXnSAyzpUTXqGcU8+cx0AbPu9Wp0hqL8RhueqDS0hASkZ5IuPrY2be/oxrGMoPQOh9oXQOTQhrMUaOzBHe6/cAABdorgqAOU14CSlS4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Kftx+hGGuqi8rVi/hYT0XlOaA1BKPhu3JFbAzYKqKjiPxhOiJ0OhlXXrjtt?=
 =?us-ascii?Q?89ge+8CcJ1Ufx6WM+GbvdHF7Ac2l7qOUGsKt0J1F4qckhRlgFvpNLJJR+8dC?=
 =?us-ascii?Q?VOiG7MWqlAjO6PbBNWE3iGP//qdUzVa94H/L3VcdENShov9DED3exSpht/yz?=
 =?us-ascii?Q?HpfZyzYEJWZHk2EQRcNhst4EXK0b8fJIHrYPUHG29Yd7VX/ZBZqn7tN/mb8I?=
 =?us-ascii?Q?GRQKZDQqB87VUOMXAh0aADQS1TCYSjYXY5TQ0eKZrLjY7JQD5+ubL0M4z5BD?=
 =?us-ascii?Q?/LXHXXXM025gYm7LzCuy6tqgJbwmFFrFsGo+1TIEAkLI4d2Wm70hFPYoXLBn?=
 =?us-ascii?Q?OcQ+MPHwIgWj3QyhZot5OiCe+sw+zg0feDDVuCph7D3tbPQmR4ozYa1+AuWw?=
 =?us-ascii?Q?skr/SawIsf5w/XpMGZSyMkWdh1VSDBBOUz7qL2Hn6Q2pIo5B4mxvtKEZIqAA?=
 =?us-ascii?Q?dh/sPxpZX6YMFaYDaX/7gqMVjffSQ0HyeNSkqOu6hs0wnc7K9u7gx6mkIpkl?=
 =?us-ascii?Q?I0AtsvmSCIbaRlBFmoWT+0meWd0HmW5EbkGNWRhGp8Nm7GWqpRmyFiTZR5Au?=
 =?us-ascii?Q?ko2Xmrlrh2HpZb/PIM6U06snkBxk9iswHsVdXK295mYcLKV7kyTahhKbWuby?=
 =?us-ascii?Q?KcEjFdjBgaa8iwgy6W7debI75L+cULRzheTXQURQ/e8yVRPvKmeX4bMgT8FC?=
 =?us-ascii?Q?0QbOQcnoZXXJVaTYLGvQIbKeTO/5+b2F5U0uMHJYBqkfVSqyICIQVQ2+Upem?=
 =?us-ascii?Q?yEmmF4r+hdNinw2CbWBAzwtQEKPtK/CeLAFnM248OEnVMy5grM7ab8cSomHm?=
 =?us-ascii?Q?/9DSPTun5ufo6mgyJ4CLu+GJYY3SCMx5HYieXNa+GnYiDMP0bj5WLw2fkdsH?=
 =?us-ascii?Q?28pAyRTUsPMxOyCs5kLxiIkwqsLgiWLEVYAdxHVYSw1xA/YJKh0sSmpg4dFx?=
 =?us-ascii?Q?myFxEej6e8x3KEFvsmgBVobK+zDPKRw236prMKvLhLVZz6a+bFRXsbmo+EEe?=
 =?us-ascii?Q?H4SVNx4ivRV9ZI+SFBbI6MzpslJLwvY0F+BclUAZXi9rA+e5Q44UHYpZlLgJ?=
 =?us-ascii?Q?PRKYQZIIGeGhYkCpmv6+ofmJGvckIBV6xqDZ+dO4BTDVJAW1DhGkhr6BQz0e?=
 =?us-ascii?Q?OHMc5YYL+YEoSYEtr00Ft7Iz9NT5Qae0/trMxsu35dBXVOl7e/Jw/LdNNz0m?=
 =?us-ascii?Q?mEpFdOSUKQo8LQL7pMvXW3PiQ+orkuyQBfcGx/HYEpQfcdthrYPEz9DGSQMz?=
 =?us-ascii?Q?BpWPwxoAZon2WiySmufzemgMz7tkXXaStiYBMWBRvzTGocBVw/H0UTKU+DRy?=
 =?us-ascii?Q?sy9f9NoAgtBwmdlgngGhJBpz0yzfqilaVLQ4M6K5T+DBSvurJSxtpPJSttvb?=
 =?us-ascii?Q?nhszLeCdAhzZEeEJy6mnRdEnAo2qgMzGmpO8nyZjy2dKWMGikCCuyykJI3Nw?=
 =?us-ascii?Q?W1Fa6VgnCTCzRSUBodFYsIYSx1/c1Z58vR3fig5zEF42NozPXFniuPE2EQwd?=
 =?us-ascii?Q?dlojnvFbLzjpwUDS6WiBXV20u6HgTMO/vuo/z7BaVELpD+T8TzWnizHPT1Eh?=
 =?us-ascii?Q?Oi2vw9E0ycNNW2dQR7H+9Q9P7Grpuwc7j4wkH4Rak5i7qkdbsN5WB2yEoSRR?=
 =?us-ascii?Q?QdJFEwqlMOt9Nv96odr4MIUAV06esk6wY3MvpHtfK3aSQcvloXLnx1vWBCJC?=
 =?us-ascii?Q?92gQnIOUMH+GXaTp1JxmW1ao/PqJMbmzYR6xd0l6Oo8xoFu3zlKXPGOTikwR?=
 =?us-ascii?Q?9qI84Btdbw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d59b276-4c7c-478a-627b-08deafc25115
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 01:03:45.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVLX2B+ukVh1ZXTsGQ/JAJq0lXpwlTyA1/PzM51B+d7AEgB4E/QiPHOGRvzmbnPQRHEorChI503DmCsB6nlnBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7331
X-Rspamd-Queue-Id: 7A1A951806E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15804-lists,cgroups=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.855];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

During a batch migration where threads in a taskset originate from
multiple source cpusets (e.g., via cgroup.procs), cpuset_can_attach()
and cpuset_attach() currently evaluate the source cpuset exactly once
by caching the first task's oldcs.

This creates two distinct critical flaws for SCHED_DEADLINE tasks:

    1.  oldcs->nr_deadline_tasks is decremented solely on the first
        source cpuset. If tasks originated from other cpusets, their
        counts are permanently leaked, and the first cpuset permanently
        underflows.

    2.  cpumask_intersects() is evaluated strictly against the first
        task's source cpuset. This allows tasks originating from
        entirely isolated root domains to silently bypass the
        dl_bw_alloc() admission control.

This patch refactors the deadline accounting to evaluate task_cs(task)
on a per-task basis during the cgroup_taskset_for_each() loops. To
achieve accurate accounting before the core cgroup migration actually
executes, the permanent nr_deadline_tasks increments/decrements are
shifted into cpuset_can_attach(). If the migration aborts, the counts
are gracefully reverted via an internal rollback loop or the
cpuset_cancel_attach() callback.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/cgroup/cpuset.c | 53 +++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..36f1d28f8ade 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3034,32 +3034,36 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
-				goto out_unlock;
+				goto out_unlock_reset;
 		}
 
 		if (dl_task(task)) {
+			struct cpuset *old_cs = task_cs(task);
+
 			cs->nr_migrate_dl_tasks++;
-			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+			old_cs->nr_deadline_tasks--;
+			cs->nr_deadline_tasks++;
+
+			if (!cpumask_intersects(old_cs->effective_cpus,
+						cs->effective_cpus))
+				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
 	}
 
 	if (!cs->nr_migrate_dl_tasks)
 		goto out_success;
 
-	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
+	if (cs->sum_migrate_dl_bw) {
 		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
 
 		if (unlikely(cpu >= nr_cpu_ids)) {
-			reset_migrate_dl_data(cs);
 			ret = -EINVAL;
-			goto out_unlock;
+			goto out_unlock_reset;
 		}
 
 		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret) {
-			reset_migrate_dl_data(cs);
-			goto out_unlock;
-		}
+		if (ret)
+			goto out_unlock_reset;
 
 		cs->dl_bw_cpu = cpu;
 	}
@@ -3070,6 +3074,22 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+	goto out_unlock;
+
+out_unlock_reset:
+	if (cs->nr_migrate_dl_tasks) {
+		struct task_struct *t;
+
+		cgroup_taskset_for_each(t, css, tset) {
+			if (t == task)
+				break;
+			if (dl_task(t)) {
+				task_cs(t)->nr_deadline_tasks++;
+				cs->nr_deadline_tasks--;
+			}
+		}
+		reset_migrate_dl_data(cs);
+	}
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return ret;
@@ -3079,6 +3099,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
+	struct task_struct *task;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
@@ -3089,8 +3110,15 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	if (cs->dl_bw_cpu >= 0)
 		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
 
-	if (cs->nr_migrate_dl_tasks)
+	if (cs->nr_migrate_dl_tasks) {
+		cgroup_taskset_for_each(task, css, tset) {
+			if (dl_task(task)) {
+				task_cs(task)->nr_deadline_tasks++;
+				cs->nr_deadline_tasks--;
+			}
+		}
 		reset_migrate_dl_data(cs);
+	}
 
 	mutex_unlock(&cpuset_mutex);
 }
@@ -3195,11 +3223,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		schedule_flush_migrate_mm();
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
-	if (cs->nr_migrate_dl_tasks) {
-		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+	if (cs->nr_migrate_dl_tasks)
 		reset_migrate_dl_data(cs);
-	}
 
 	dec_attach_in_progress_locked(cs);
 
-- 
2.51.0


