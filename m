Return-Path: <cgroups+bounces-15992-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH5ULenxB2qbQQMAu9opvQ
	(envelope-from <cgroups+bounces-15992-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:26:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB255A29C
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98393301751B
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 04:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C82D2385;
	Sat, 16 May 2026 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yu6QOaNS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93329BDBD
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778905538; cv=none; b=EUDnxfa6swt59PZAxylLBCgEbQUybLfq0rP3DVFCsfppe2XYRt+en27/WeF6nUlqJq0JEPvDBevhxxGLXmdf1B9D7mERemXE+h+hhXR3p/8Sb1vbpCPTjM2jTiX/po8bgkPYvlO3PQ+GASze9dTJUGpjOCXvu1R2T0KSE5rVBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778905538; c=relaxed/simple;
	bh=rbGdLUtRh/45TNs0kUnr6cNXG9aMg3sFaODuVTnN5U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw4ZqPw8SyXWkIe7EJmiZ3QfvvBpUsV7VaH/zaOywWZ+h7v/bCRX/STte99tnZtRtjUYfEhs99uS/DWQ9YA4N+swz1Qvvq6O7eLriVwl7XBpyRnhZ+0PZI9dgzFfRptIkVNarn1xEs/D3HrnyF1nWh7Z4J7UA7QR1vBaIDLfjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yu6QOaNS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778905536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZN+A9sq5vOtV3HLuxvOtE/eENwhZf3tS4rk+PEIQlQ=;
	b=Yu6QOaNSfTJrbCq5jb4+me0ylXMweyvNjijBdlDEe9hAwLedmqu/4hQo27GuGWaafUg4Qr
	OfnveyLHpgs4L42ytxGX5eVf1Qj14whD/83IddoIdrZgUOwyBBW/sX4IIufI/MX5kzDPy6
	82sVanRgg0/w0RanOAyMmOt+hZB3U14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Dfv19Cw9PxSm5enAObbgCQ-1; Sat,
 16 May 2026 00:25:30 -0400
X-MC-Unique: Dfv19Cw9PxSm5enAObbgCQ-1
X-Mimecast-MFC-AGG-ID: Dfv19Cw9PxSm5enAObbgCQ_1778905528
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30295180056E;
	Sat, 16 May 2026 04:25:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C0C01800465;
	Sat, 16 May 2026 04:25:21 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-next v2 3/5] cgroup/cpuset: Replace cpuset_attach_old_cs by a new attach_old_cs field in task_struct
Date: Sat, 16 May 2026 00:24:46 -0400
Message-ID: <20260516042448.698216-4-longman@redhat.com>
In-Reply-To: <20260516042448.698216-1-longman@redhat.com>
References: <20260516042448.698216-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 31AB255A29C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15992-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In cpuset_can_attach(), the source (old) cpuset of the tasks is
stored in an internal cpuset_attach_old_cs variable to be used later
in cpuset_attach(). It is because such task to old cpuset information
is no longer available when cpuset_attach() is called and it is assumed
that there is only one source cpuset.

To support cgroup_taskset containing tasks from multiple source
cpusets, such an approach will no longer work. The easier way to get
the old cpuset information is to temporarily store that information
in the task_struct itself at cpuset_can_attach() and reuse it in
cpuset_attach(). However, that does increase the size of task_struct
by a 8 bytes for 64-bit kernel.

Add a new attach_old_cs field into task_struct for such purpose and
retire the cpuset_attach_old_cs internal variable.

Even though attach_old_cs can be counted as a reference to the
old cpuset, like cpuset_attach_old_cs, it is strictly used only
for communication between cpuset_can_attach() and cpuset_attach()
within the same task migration session where cgroup_mutex will be held
throughout. So no actual reference counting will be performed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h  |  3 +++
 kernel/cgroup/cpuset.c | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 004e6d56a499..9b6bb1603592 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -63,6 +63,7 @@ struct bpf_run_ctx;
 struct bpf_net_context;
 struct capture_control;
 struct cfs_rq;
+struct cpuset;
 struct fs_struct;
 struct futex_pi_state;
 struct io_context;
@@ -1317,6 +1318,8 @@ struct task_struct {
 	/* Sequence number to catch updates: */
 	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
+	/* Old cpuset to be used in cpuset_attach() */
+	struct cpuset			*attach_old_cs;
 #endif
 #ifdef CONFIG_CGROUPS
 	/* Control Group info protected by css_set_lock: */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0d01b66f464d..fc632370d07c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2968,7 +2968,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
  * cpuset_can_attach() and cpuset_attach() specific internal data
  * Protected by cpuset_mutex
  */
-static struct cpuset *cpuset_attach_old_cs;
 static bool attach_cpus_updated;
 static bool attach_mems_updated;
 
@@ -3052,9 +3051,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	bool setsched_check;
 	int ret;
 
-	/* used later by cpuset_attach() */
-	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
-	oldcs = cpuset_attach_old_cs;
+	oldcs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
@@ -3075,6 +3072,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 				goto out_unlock;
 		}
 
+		/* Save a copy of oldcs to be used later in cpuset_attach() */
+		task->attach_old_cs = oldcs;
 		if (dl_task(task)) {
 			/*
 			 * Count all migrating DL tasks for cpuset task accounting.
@@ -3156,11 +3155,11 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct task_struct *leader;
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
+	struct cpuset *cs, *oldcs;
 	bool queue_task_work = false;
 
-	cgroup_taskset_first(tset, &css);
+	task = cgroup_taskset_first(tset, &css);
+	oldcs = task->attach_old_cs;
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
-- 
2.54.0


