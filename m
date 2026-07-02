Return-Path: <cgroups+bounces-17446-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 331cN5/dRmo8ewsAu9opvQ
	(envelope-from <cgroups+bounces-17446-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 23:52:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AC6FD138
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 23:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PwukeroD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17446-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17446-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDC4230EAC03
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E922312834;
	Thu,  2 Jul 2026 21:48:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFE3ACF0A
	for <cgroups@vger.kernel.org>; Thu,  2 Jul 2026 21:48:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028930; cv=none; b=huSCEKyfAGkt1mCagH5NH7If+CO/iDisVPwmRDl/iz4KiWgC09l2wv5QrZBeK2PnRlf1t4K/XcgoE9ViAOO3r2Li4Kw+LQjCceLLN50iSaFsCKN+h1Y/LWXPk151KSYccgmLS0R2Gzy1Tm2eiy1uLJVnwrY8AQ5tmsrJLHShQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028930; c=relaxed/simple;
	bh=pPyuXU28I/eEVsTJnDvc1LmzYf+vhDliXtolOn6x4Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM770Jnj8QJZjji5c7v7+lGY36i/Whb9KHUu/QtyXzupay4ZRplfiz6hZLUwJjE4F8nXtzZAZH1Uxq7rgy8vTSKaMCwpo1lQfhZSCvAOapXQYyftWAn0D5E85R4BS75oe3n9vgUwVmt1/TIspBS0b/2/jX4Dc+i5+YfiwQSrAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwukeroD; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783028927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRvnJjRNohRwuDYbzwstp9ovFM9s/pP6JKbcY65NB/o=;
	b=PwukeroDVstKIABChhYFGXndF8Hf1aoZPcylkN/PYu/kgwxp1xNe5jJenJcKlFQDidazIF
	LTzZpVpNv+hF303PICKFOUHO6VPi8bwVJza9K8NJ8f5YKtR7thnSTzH8jJFtH0t/2xfcMU
	6HIvDbQIQwXXHjak0Q4tkXnS8RYg9Y4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-nd5iQ_CEP1qNr3o5KUX1sg-1; Thu,
 02 Jul 2026 17:48:44 -0400
X-MC-Unique: nd5iQ_CEP1qNr3o5KUX1sg-1
X-Mimecast-MFC-AGG-ID: nd5iQ_CEP1qNr3o5KUX1sg_1783028922
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5050C1944CF2;
	Thu,  2 Jul 2026 21:48:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.58])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D4AE36F24;
	Thu,  2 Jul 2026 21:48:39 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v10 03/11] cgroup/cpuset: Prevent race between task attach and cpuset state change
Date: Thu,  2 Jul 2026 17:47:49 -0400
Message-ID: <20260702214757.579012-4-longman@redhat.com>
In-Reply-To: <20260702214757.579012-1-longman@redhat.com>
References: <20260702214757.579012-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17446-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B1AC6FD138

Commit e44193d39e8d ("cpuset: let hotplug propagation work wait for
task attaching") was introduced to let hotplug operation to wait
until the completion of task attach operation. However, it is still
possible that the states of the source or destination cpuset can
be changed between the cpuset_can_attach() call and the subsequent
cpuset_attach()/cpuset_cancel_attach() call.

As a result, data gathered during cpuset_can_attach() cannot be reliably
used in the subsequent cpuset_attach()/cpuset_cancel_attach()
call at all. Make the task attach operation more robust
and allow the sharing of data between cpuset_can_attach() and
cpuset_attach()/cpuset_cancel_attach() by making cpuset_write_resmask()
and cpuset_partition_write() wait for the completion of task attach
as well.

Ideally, an ongoing task attach operation should block any cpuset write
operation that can change its internal state until the operation is
completed. However, the attach_in_progress flag is currently per cpuset
and only the destination cpuset will have this flag set. The flag is not
set in the source cpuset where the tasks will be moved from. Even if we
extend the scope to include the source cpuset, it will not block cpuset
operation that changes the state of one of its ancestor cpuset which may
indirectly impact the state of the source or destination cpuset. It may
be too costly to set the flag for the whole subtree, it is far easier
to just make the flag global and block all the cpuset write operation
whenever a task attach operation is in progress.

Make that change by creating a new cpuset attach context (attach_ctx)
structure to hold the global in_progress flag and use it for blocking
cpuset write operation if a cpuset attach operation is in progress. Also
add a new wait_attach_done_lock() helper to do the waiting for an
ongoing attach operation and acquire the cpuset_mutex.

The comments about validate_change() are no longer valid as it won't
be called at all if an attach operation is in progress. So the comments
can be removed.

The per-cpuset attach_in_progress flag is also currently used in
partition_is_populated() and cpuset_is_populated() to determine if
an empty cpuset will have incoming task. This check will no longer be
needed as this function will not be called when there is a task attach
in progress. So the flag check is now removed.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h | 11 +---
 kernel/cgroup/cpuset.c          | 90 +++++++++++++++++++--------------
 2 files changed, 53 insertions(+), 48 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 140700e5e236..df662c7fd1a4 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -145,12 +145,6 @@ struct cpuset {
 	 */
 	nodemask_t old_mems_allowed;
 
-	/*
-	 * Tasks are being attached to this cpuset.  Used to prevent
-	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
-	 */
-	int attach_in_progress;
-
 	/* partition root state */
 	int partition_root_state;
 
@@ -269,10 +263,7 @@ static inline int nr_cpusets(void)
 static inline bool cpuset_is_populated(struct cpuset *cs)
 {
 	lockdep_assert_cpuset_lock_held();
-
-	/* Cpusets in the process of attaching should be considered as populated */
-	return cgroup_is_populated(cs->css.cgroup) ||
-		cs->attach_in_progress;
+	return cgroup_is_populated(cs->css.cgroup);
 }
 
 /**
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 431bf210aa52..1a78d0590737 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -356,6 +356,33 @@ static struct workqueue_struct *cpuset_migrate_mm_wq;
 
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
 
+/*
+ * Cpuset task attach context
+ * Protected by cpuset_mutex
+ */
+static struct {
+	int in_progress;
+} attach_ctx;
+
+/*
+ * Wait if task attach is in progress until it is done and then acquire
+ * cpuset_mutex before returning.
+ */
+static void wait_attach_done_lock(void)
+	    __acquires(&cpuset_mutex)
+{
+	for (;;) {
+		mutex_lock(&cpuset_mutex);
+		if (!attach_ctx.in_progress)
+			return;
+
+		mutex_unlock(&cpuset_mutex);
+
+		/* Wait until attach operation is done to prevent racing */
+		wait_event(cpuset_attach_wq, attach_ctx.in_progress == 0);
+	}
+}
+
 static inline void check_insane_mems_config(nodemask_t *nodes)
 {
 	if (!cpusets_insane_config() &&
@@ -368,22 +395,22 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 }
 
 /*
- * decrease cs->attach_in_progress.
- * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
+ * decrease attach_ctx.in_progress.
+ * wake_up cpuset_attach_wq if attach_ctx.in_progress==0.
  */
-static inline void dec_attach_in_progress_locked(struct cpuset *cs)
+static inline void dec_attach_in_progress_locked(void)
 {
 	lockdep_assert_cpuset_lock_held();
 
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
+	attach_ctx.in_progress--;
+	if (!attach_ctx.in_progress)
 		wake_up(&cpuset_attach_wq);
 }
 
-static inline void dec_attach_in_progress(struct cpuset *cs)
+static inline void dec_attach_in_progress(void)
 {
 	mutex_lock(&cpuset_mutex);
-	dec_attach_in_progress_locked(cs);
+	dec_attach_in_progress_locked();
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -432,8 +459,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
 	 * nr_populated_domain_children may include populated
 	 * csets from descendants that are partitions.
 	 */
-	if (cgroup_has_tasks(cs->css.cgroup) ||
-	    cs->attach_in_progress)
+	if (cgroup_has_tasks(cs->css.cgroup))
 		return true;
 
 	rcu_read_lock();
@@ -3091,11 +3117,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs->dl_bw_cpu = cpu;
 
 out_success:
-	/*
-	 * Mark attach is in progress.  This makes validate_change() fail
-	 * changes which zero cpus/mems_allowed.
-	 */
-	cs->attach_in_progress++;
+	attach_ctx.in_progress++;
 
 out_unlock:
 	if (ret)
@@ -3113,7 +3135,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
-	dec_attach_in_progress_locked(cs);
+	dec_attach_in_progress_locked();
 
 	if (cs->dl_bw_cpu >= 0)
 		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
@@ -3226,7 +3248,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		reset_migrate_dl_data(cs);
 	}
 
-	dec_attach_in_progress_locked(cs);
+	dec_attach_in_progress_locked();
 
 	mutex_unlock(&cpuset_mutex);
 }
@@ -3246,7 +3268,12 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		return -EACCES;
 
 	buf = strstrip(buf);
-	cpuset_full_lock();
+
+	/* cpuset_mutex acquired in wait_attach_done_lock() */
+	mutex_lock(&cpuset_top_mutex);
+	cpus_read_lock();
+	wait_attach_done_lock();
+
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -3377,7 +3404,10 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	else
 		return -EINVAL;
 
-	cpuset_full_lock();
+	mutex_lock(&cpuset_top_mutex);
+	cpus_read_lock();
+	wait_attach_done_lock();
+
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
 	cpuset_update_sd_hk_unlock();
@@ -3616,11 +3646,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * Mark attach is in progress.  This makes validate_change() fail
-	 * changes which zero cpus/mems_allowed.
-	 */
-	cs->attach_in_progress++;
+	attach_ctx.in_progress++;
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return ret;
@@ -3638,7 +3664,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
 	if (same_cs)
 		return;
 
-	dec_attach_in_progress(cs);
+	dec_attach_in_progress();
 }
 
 /*
@@ -3670,7 +3696,7 @@ static void cpuset_fork(struct task_struct *task)
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
-	dec_attach_in_progress_locked(cs);
+	dec_attach_in_progress_locked();
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3774,20 +3800,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	bool remote;
 	int partcmd = -1;
 	struct cpuset *parent;
-retry:
-	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
-
-	mutex_lock(&cpuset_mutex);
-
-	/*
-	 * We have raced with task attaching. We wait until attaching
-	 * is finished, so we won't attach a task to an empty cpuset.
-	 */
-	if (cs->attach_in_progress) {
-		mutex_unlock(&cpuset_mutex);
-		goto retry;
-	}
 
+	wait_attach_done_lock();
 	parent = parent_cs(cs);
 	compute_effective_cpumask(&new_cpus, cs, parent);
 	compute_effective_nodemask(&new_mems, cs, parent);
-- 
2.54.0


