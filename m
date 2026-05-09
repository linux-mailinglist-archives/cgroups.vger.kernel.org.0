Return-Path: <cgroups+bounces-15697-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH67NbRl/2lo6AAAu9opvQ
	(envelope-from <cgroups+bounces-15697-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249D5008FF
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 18:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5F4301F996
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85A30BB9B;
	Sat,  9 May 2026 16:48:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022080.outbound.protection.outlook.com [52.101.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D32FD66D;
	Sat,  9 May 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345338; cv=fail; b=nPZvd1lazHNe8XblC4azQWM7Vcugxaspkxfks64RIScpeD71ZAnwiAFBrerJhpUTJdRe7IjN7OMPsOIhvE6F+Tm7tZX1ZtcEntt80aSXky2Zsea9pQqq4Rz60jhTLS3qE1IBFOnwWDlyRHGlDuPlYMITDDZlNMDhvWMk3tojQDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345338; c=relaxed/simple;
	bh=uh20slUfdhqE7y2m33b6UYY+EklMaylyVK4dbkRwzes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9J8Xlug8n7bYJ/etv95prSBv4sjLz/rGN1pFbFRy4cFzU/bDznRwYjZPifbpgjO02O79mMG6hCS9hmsgagNeaU1G6QblHFMFF9LqJmj8xPxVu59MfROZhUfBd1iXu3wwbuDFjq5b/VwtgCAW/xpF4HDBj1KmsrH4RRXDfU/Cbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW7wHqaTrPuGWBKpWl+iGPJCzaOyXqYan4lSnBP5n3PkaZK5PjhYvRl0PiWOes9qUkN57vM/oIT0AFTreDk4MUrT1gnWEba3XydpNY+p8JFJ7gl61GUr8VuBeO/yR65bEtIUUfGknwo180jRFudveCIyh//6f2tyQFRPaSAlznPsVaE/kxAdnar7YxFKdNPWkkodC25ReHJq2NR5lv0HJo5bG1P2dYQn0JvqBtQtwlTW8GHc4SdFxUDXWeq79z7chw9iYcf79N30jc2fm1Wav0YEQfeyF7hEUttzgZW/TCyrEsaC40VEeEhk8515knidXfTx1Jl4sCGLaUgwJ1lcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeAlbHKemalWGtQv9Osq6NfZmAxT8OeU7qJBbKaVQp0=;
 b=ZDWRWsUYzgleNcQNtTQT+aC4dXlXOaxE2tQxKc71VEPzvASf0Gg6kXpuEh5jbQjR2BaPxVaVpufIvwJnIBuCfM09YVzbwpfdDFKMakeZNKzqsEfUEMCt6BXid7XZOo0hoWMy2jSxCocokVkTBS2/c5sJ0s/3v0hulcvMjcVMPltvoCRnOX9AnMyCfNGjoVRHosFOYLZBKsJwfqdUi5RRo5K7fRu9vW2OYN7U4r3QHbGNs+vYBNxg63p+2CFK+Ic3uj9krIaIOarBzNL1O98Ldsprm3AXjfodY4E+B3ZMQhIoe9LaA45kHKt4jRw/hVX5y72O1fURhxqijG869Rx3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6996.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 16:48:55 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 16:48:55 +0000
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
Subject: [PATCH 1/3] cgroup/cpuset: Fix deadline bandwidth leak in cpuset_can_attach()
Date: Sat,  9 May 2026 12:48:45 -0400
Message-ID: <20260509164847.939294-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509164847.939294-1-atomlin@atomlin.com>
References: <20260509164847.939294-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:408:e2::24) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0dcb95-7335-424f-211f-08deadeadb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|22082099003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6lXSH0yTXl2b6Oz1QEEkPWIYSJTmmfc6uqZeJZ7Qy4n/XQIbuqL0ZccLNkcNrwyON/V6wyIPPGxZK0i1EG2WXFqQ7TmzN8aE07IvAvN88ekrLNltczgN9whVmZ30zqD8qKbcLgNpQU03Gvrmss6460zIhN/QDNHbYkdUSJ48ESulPHf+Glc2ZZvXsKe5FDiFCb6DPyW1Sfj48OSADl5GwOhtrsK7sfRPzEH1AO0H5PYHxtR2eFPuxF+lAHfTncnLBG4U/vU75h1/AnHAIKgznMtbM3AbCQ9M4PSphQrdvruUJUODQ4Wj4EXdhHtKeSBODHxH3rCbWIggmMiVdfBExQ0scUWNoOMhgAYkf8//O5zCadh2DOQwZxtCKmGNp+7CQAxEP7xxE44fo7zn8jTgwNTIwdB9RLnpcOzsFdlZwr2lKS/XzsRK7tjoP8nkjWeoo8kvAaIJL7fN7dvXbktJbpyNBJKTbnnh8LAZOoRzbb7OW1AcGV1+PJliisGMfjQGt/fMShFFFJQ4J0WXl79YN554x13oa8fl/AmwxgvE+gdy1u+k7esgN7YLMGUbDoX32gz0FQ12On34uf1trUZu06B2v087z/cxG2J5CT0oW1CFOJWA/yNIGMyRB3Cc2+Ea9pKnVliMJdr0u32usbPqI1TV16nPiQZaWwBVdBlxNPGeoBkhL944UwVO1X5M3cPlAIRCvdQ74ZL0UJfDKsERo9Ot2FIRve5JP32fYXmezDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(22082099003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QfQ39QjBqMgJc7eYlFQJNNpC+ntdheVgIXJ99YAnN9OGkuZ5w0FOkUpGsi+N?=
 =?us-ascii?Q?uWY9XpHgdWpBaD8R9E7ILfErBrTjFPhhx2P5cw8aP8NhurDfxs/XSgYiK/0A?=
 =?us-ascii?Q?FO6ZXzlhAZQZug1MIaKiSs+RUI7D+MuK8RS6p74hL0oUcoRQw/dNZvpzqavN?=
 =?us-ascii?Q?SCut1ecps0b0Run0WrqFIE+2luMucHlYvgSfTGAzLRZmdH1O3rDMli4omwEN?=
 =?us-ascii?Q?wqCdRFaZTm+gHR8RiNos+RplspyAhM7dhk1kWlX/fA/r3mNzfvNcQNKHXgBC?=
 =?us-ascii?Q?ivW11bMVdgsqfQcRsK32zG84fp68y20+S2cinbXSgFjEqjXZ+ENVp7ugyXOy?=
 =?us-ascii?Q?OtmXsxsVHKGeU5freVlGeZ4xyZ8ZnT3DLzGWBG20OAALA7VirK+k6rjuxJxv?=
 =?us-ascii?Q?X7hvK6DhbL0Qud6ZcCMaNVQGPfKIlPjzLwq+oRwWezrLKECXfmLFGs2+o70x?=
 =?us-ascii?Q?YBPSBMuR0EzCXCpySg1cetjHsyXCJMR1rvw8k+hJzG7YdfJhqf9nfQX2mrvV?=
 =?us-ascii?Q?34H0fLBrtHHI8ToKYWeQR8fkumk6l0O7h7fKDCue9aLEXeMpF78C/KRjbu4/?=
 =?us-ascii?Q?++r3RtfInM9tclWdrbZ41kDqJaRoL0q+ti+McBuDAzOLTfFyV+C5U1yDbmuP?=
 =?us-ascii?Q?Dud5BwV4aO768HN61LRO5n8RBM9+bufAplxh5bYw+AxC/ZAn9Cis5vgS6A0J?=
 =?us-ascii?Q?un0JD6Tgfqunx5f+JS/L4/qEvWF5cwauYS3d9Q5yanotv9lrM5lJAEvGKk2R?=
 =?us-ascii?Q?b+8JLj+nBf9ZsMWin7bNfSEajBwgekh790gXlJJ+T8jyjmX1lJaiSkpVygA3?=
 =?us-ascii?Q?okQWNd3SHilW+T/heynWaVdVYuV/wGzfMvN8EzeR/dIKRhHALbnypJSKc5tx?=
 =?us-ascii?Q?pjBD4X4JyJ2iIcSVrit9PScpcj0gVp/Yas0dTgTB9jfcGP5tVCjViylHpMBN?=
 =?us-ascii?Q?RPXTRsNsEHqr1h/mVAlcB3EydZQyYGkJiQYCowU+S5EzCzxFHI0UXsD0guKW?=
 =?us-ascii?Q?5U07621638JDTOrXPnUgf3gS5JBlLQGhgxmYcUmF//L41IETYBDPRu7eC6uv?=
 =?us-ascii?Q?WDm1HtCZNQ+YW+4NSyCXO7EVzdQEJH+Di60fvOQcuBKmbo42v1ZiUIvC9p94?=
 =?us-ascii?Q?eIdBUXKxeOmALd24qAxZb/98AVUylIUilHu7d7d7MyroKZGz1/OEnUPAlf2h?=
 =?us-ascii?Q?oVgRrUDsoBDguDjd2Wac8AHRwAx35kDGsLEdELG21BlgM/SN13Y8cHTYh5Qh?=
 =?us-ascii?Q?GYAQnelCo56rZi0e/RvCfPtFimUwtSjUq/xUl2cd72vCtNHgp9So+MKJKshT?=
 =?us-ascii?Q?KuR6ta4j0fJpYHgFjFCnarcDQEdOc8JqOYxOaFgBl//DDGbelCi1YDJDUvVq?=
 =?us-ascii?Q?rXOI86vJlRY2GiN5OJMMFQoFU8pjsFhpDMoNmR32dV4gYWU9tiPrNnyUj2/o?=
 =?us-ascii?Q?cK6pd+G8QAgzk0DGCK7eLYKfcOsy/4XHkG9Xj5OfN5SL1B/ayPjhj9HqJH7s?=
 =?us-ascii?Q?4J/k7vzD0Pgd1uS2eEuGRfYwDDq4xw2RyvQAI8oqBxP+t8aAGOHg+QOvF4JF?=
 =?us-ascii?Q?wC14Z6mJPb7IEKQ49f89Y2iTQgUdlTaKbyVPH3R2SKrTKHQm259taLP3PPSb?=
 =?us-ascii?Q?i1ZOm2Jx37eGJ/KgXEdMf0lwwtUR9Dz5Zz41xOBzlLQZ6jXlAw+t0N+HmXw0?=
 =?us-ascii?Q?ZBt+JJaKeBM60TYAG6c6CQB20Y1ZpajhK5B/9X5BjG5sBlc8v+8JkuymVu/p?=
 =?us-ascii?Q?SCN23N78zA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0dcb95-7335-424f-211f-08deadeadb80
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 16:48:55.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG4r61gOqSbwbDwdwCjy7CIxxflsYZ4a8tp6fV3unUlJ8mw0EZ75M/5H5lGCBF+ofqSsQ7Gw0Xq7LOObcqHA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6996
X-Rspamd-Queue-Id: 5249D5008FF
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
	TAGGED_FROM(0.00)[bounces-15697-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,atomlin.com,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	NEURAL_SPAM(0.00)[0.325];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,atomlin.com:email,atomlin.com:mid]
X-Rspamd-Action: no action

During a cgroup migration, cpuset_can_attach() iterates over the
provided taskset. If a task within the batch is a deadline (DL) task,
the destination cpuset's DL metrics (i.e., nr_migrate_dl_tasks and
sum_migrate_dl_bw) are appropriately incremented.

However, if a subsequent task in the same migration batch fails the
task_can_attach() check, the loop aborts and jumps directly to
out_unlock. Consequently, any DL metrics accumulated from previously
processed tasks in the batch remain permanently inflated in the
destination cpuset. Because the migration is subsequently aborted by the
cgroup core, cpuset_cancel_attach() is never invoked to unwind these
specific increments.

This behaviour results in a permanent leak of deadline bandwidth, which
incorrectly restricts the admission control capacity of the destination
cpuset.

To resolve this, introduce an out_unlock_reset failure path that
conditionally invokes reset_migrate_dl_data(). This guarantees that if a
batch migration is aborted for any reason, the pending DL metrics are
safely reset before returning the error.

Fixes: 0a67b847e1f06 ("cpuset: Allow setscheduler regardless of manipulated task")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/cgroup/cpuset.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..b8022f6e2a35 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3029,12 +3029,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
-			goto out_unlock;
+			goto out_unlock_reset;
 
 		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
-				goto out_unlock;
+				goto out_unlock_reset;
 		}
 
 		if (dl_task(task)) {
@@ -3070,6 +3070,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+	goto out_unlock;
+
+out_unlock_reset:
+	if (cs->nr_migrate_dl_tasks)
+		reset_migrate_dl_data(cs);
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return ret;
-- 
2.51.0


