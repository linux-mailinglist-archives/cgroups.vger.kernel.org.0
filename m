Return-Path: <cgroups+bounces-14300-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EH4AYaGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14300-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:20:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F0191F50
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDE2C30A09DE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BE37D117;
	Wed, 25 Feb 2026 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxXP58lI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E237C107;
	Wed, 25 Feb 2026 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995742; cv=none; b=umpGCBgFSNFxOLDjiNDwIduYO3GfU9CQq3RN+7z/5XnrBZI4IXNuHJ2MwN6OHpgN4d+ICOr3yRUUXlM7MSxi61prwm+yRKEzKf7OFtc+/Q2/TWp061s6TPq+CFTOCgmj1imQn53OSWxD4G+A8TTyyaAGh8W9CZacUcjiQKdtbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995742; c=relaxed/simple;
	bh=Fb7/UWeLtV5P4M2W2h+5Nk7E7oRr4lH1GkWSWfJ1lWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXVFTFtnksjSBcyr2ONCPWy+LlqdIeLpz7uKJxHoC0za1YqDapnV3A91lvLiL0Bnpz+gtmhHf0HOGBUTEyZPhWDPGXLjxJAbbMKOJIj3e6wmEeWeWARNtl7HHtjie/78ipJG5PgB+4TqCq0zAG0b5UA4E0qFRut1Dud11JSdmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxXP58lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4013EC116D0;
	Wed, 25 Feb 2026 05:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995742;
	bh=Fb7/UWeLtV5P4M2W2h+5Nk7E7oRr4lH1GkWSWfJ1lWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxXP58lIjCuZf76EyR2v6Z/mFUVez9AH7MledvWbMloeCNj3IepToYt18QXS9A1Kj
	 DUpkklltOBCImKXL/1fiQdyWVQ057RCSxmmTwbDq/cV8rNc9OVybhaMC+EbDuvaEK6
	 +URMZKnmCwcDcAb/8fPH/gbv/agDmVNvLUyPe/oabUw22DZ6EwUNrmHRBjuMymkHbZ
	 9jWTJg6BbcCEnyjyzdYWUHG+ajel4HAxTBHG38RsenaSJ0uLZBxwEzuxQPOlTV4gwl
	 aN7CJmc4wtnVWHaWotCI8fAl6hAncdL2jyaiwZmLiarqKiTll+Ajpe1IKTwkdQYpi0
	 Jw5Hw+6YcMcEw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 26/34] sched_ext: Make watchdog sub-sched aware
Date: Tue, 24 Feb 2026 19:01:44 -1000
Message-ID: <20260225050152.1070601-27-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050152.1070601-1-tj@kernel.org>
References: <20260225050152.1070601-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14300-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D6F0191F50
X-Rspamd-Action: no action

Currently, the watchdog checks all tasks as if they are all on scx_root.
Move scx_watchdog_timeout inside scx_sched and make check_rq_for_timeouts()
use the timeout from the scx_sched associated with each task.
refresh_watchdog() is added, which determines the timer interval as half of
the shortest watchdog timeouts of all scheds and arms or disarms it as
necessary. Every scx_sched instance has equivalent or better detection
latency while sharing the same timer.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 74 ++++++++++++++++++++++++-------------
 kernel/sched/ext_internal.h |  7 ++++
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0c1b27ab00a0..be800ed5d9f3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -59,11 +59,10 @@ static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_enable_seq = ATOMIC_LONG_INIT(0);
 
 /*
- * The maximum amount of time in jiffies that a task may be runnable without
- * being scheduled on a CPU. If this timeout is exceeded, it will trigger
- * scx_error().
+ * Watchdog interval. All scx_sched's share a single watchdog timer and the
+ * interval is half of the shortest sch->watchdog_timeout.
  */
-static unsigned long scx_watchdog_timeout;
+static unsigned long scx_watchdog_interval;
 
 /*
  * The last time the delayed work was run. This delayed work relies on
@@ -3032,10 +3031,11 @@ static bool check_rq_for_timeouts(struct rq *rq)
 		goto out_unlock;
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
+		struct scx_sched *sch = scx_task_sched(p);
 		unsigned long last_runnable = p->scx.runnable_at;
 
 		if (unlikely(time_after(jiffies,
-					last_runnable + scx_watchdog_timeout))) {
+					last_runnable + sch->watchdog_timeout))) {
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
 			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
@@ -3052,6 +3052,7 @@ static bool check_rq_for_timeouts(struct rq *rq)
 
 static void scx_watchdog_workfn(struct work_struct *work)
 {
+	unsigned long intv;
 	int cpu;
 
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
@@ -3062,28 +3063,31 @@ static void scx_watchdog_workfn(struct work_struct *work)
 
 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
-			   scx_watchdog_timeout / 2);
+
+	intv = READ_ONCE(scx_watchdog_interval);
+	if (intv < ULONG_MAX)
+		queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+				   intv);
 }
 
 void scx_tick(struct rq *rq)
 {
-	struct scx_sched *sch;
+	struct scx_sched *root;
 	unsigned long last_check;
 
 	if (!scx_enabled())
 		return;
 
-	sch = rcu_dereference_bh(scx_root);
-	if (unlikely(!sch))
+	root = rcu_dereference_bh(scx_root);
+	if (unlikely(!root))
 		return;
 
 	last_check = READ_ONCE(scx_watchdog_timestamp);
 	if (unlikely(time_after(jiffies,
-				last_check + READ_ONCE(scx_watchdog_timeout)))) {
+				last_check + READ_ONCE(root->watchdog_timeout)))) {
 		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
 
-		scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
+		scx_exit(root, SCX_EXIT_ERROR_STALL, 0,
 			 "watchdog failed to check in for %u.%03us",
 			 dur_ms / 1000, dur_ms % 1000);
 	}
@@ -4741,6 +4745,26 @@ static void free_kick_syncs(void)
 	}
 }
 
+static void refresh_watchdog(void)
+{
+	struct scx_sched *sch;
+	unsigned long intv = ULONG_MAX;
+
+	/* take the shortest timeout and use its half for watchdog interval */
+	rcu_read_lock();
+	list_for_each_entry_rcu(sch, &scx_sched_all, all)
+		intv = max(min(intv, sch->watchdog_timeout / 2), 1);
+	rcu_read_unlock();
+
+	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
+	WRITE_ONCE(scx_watchdog_interval, intv);
+
+	if (intv < ULONG_MAX)
+		mod_delayed_work(system_unbound_wq, &scx_watchdog_work, intv);
+	else
+		cancel_delayed_work_sync(&scx_watchdog_work);
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -4779,6 +4803,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 	list_del_rcu(&sch->all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -4913,12 +4939,12 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, ei);
 
-	cancel_delayed_work_sync(&scx_watchdog_work);
-
 	raw_spin_lock_irq(&scx_sched_lock);
 	list_del_rcu(&sch->all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	/*
 	 * scx_root clearing must be inside cpus_read_lock(). See
 	 * handle_hotplug().
@@ -5454,6 +5480,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	sch->ancestors[level] = sch;
 	sch->level = level;
 
+	if (ops->timeout_ms)
+		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
+	else
+		sch->watchdog_timeout = SCX_WATCHDOG_MAX_TIMEOUT;
+
 	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
@@ -5581,7 +5612,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	unsigned long timeout;
 	s32 i, cpu, ret;
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
@@ -5639,6 +5669,8 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	list_add_tail_rcu(&sch->all, &scx_sched_all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	scx_idle_enable(ops);
 
 	if (sch->ops.init) {
@@ -5669,16 +5701,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable;
 
-	if (ops->timeout_ms)
-		timeout = msecs_to_jiffies(ops->timeout_ms);
-	else
-		timeout = SCX_WATCHDOG_MAX_TIMEOUT;
-
-	WRITE_ONCE(scx_watchdog_timeout, timeout);
-	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
-	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
-			   scx_watchdog_timeout / 2);
-
 	/*
 	 * Once __scx_enabled is set, %current can be switched to SCX anytime.
 	 * This can lead to stalls as some BPF schedulers (e.g. userspace
@@ -5896,6 +5918,8 @@ static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	list_add_tail_rcu(&sch->all, &scx_sched_all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
 			  SCX_SUB_MAX_DEPTH);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index cce8dfbbdada..0a19af6ad3ff 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1019,6 +1019,13 @@ struct scx_sched {
 	bool			sub_attached;
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * The maximum amount of time in jiffies that a task may be runnable
+	 * without being scheduled on a CPU. If this timeout is exceeded, it
+	 * will trigger scx_error().
+	 */
+	unsigned long		watchdog_timeout;
+
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
 
-- 
2.53.0


