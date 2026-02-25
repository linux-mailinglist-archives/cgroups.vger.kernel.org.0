Return-Path: <cgroups+bounces-14240-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LKIBjaCnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14240-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:01:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8C191B14
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 581E0309B9B0
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFD2D63F6;
	Wed, 25 Feb 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RojRiqSN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B692D592E;
	Wed, 25 Feb 2026 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995672; cv=none; b=Vv2Ty3q/W2ArGcnf/Lpn3J3tbLWgIOJ4prvGs1G0S0wkaKQKSTy9C2R2OoTD9HYlweJD/cVb2QidihKuA0QW83jXHMGmIWGxbM4PvelErPU1pdfSHMwIFFSfU/R/zzbfrIru9LxF/c1NoF+bE78XEdxDYUQIMqquTExcY3h2vVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995672; c=relaxed/simple;
	bh=gIQavw7nnSQBPtvR64x4CT554azmfJV2O88vL03iXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB6ilBUE3KwvinU39mSVFCYaBR2vPNylna4CX0Et1CU1woOIKjxG+4GibkDwq57ibt3wykR8nwxw9qFvMvO+yUi/L0KdVK6/n2knT30ZMy6BhWScVTwql20o7bMXre3KtTs/vPCMae4M3JEZjalBUSFJ7okQwSVjHukb30REWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RojRiqSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD70AC2BC86;
	Wed, 25 Feb 2026 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995671;
	bh=gIQavw7nnSQBPtvR64x4CT554azmfJV2O88vL03iXX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RojRiqSNKjmloNVSwtyji/jEz/XjJGI0KqXFqyDZf6TRJb4KYw1rRXxTQM/V50vX7
	 MGjYUaFEUQ9CA4wtXuy0uZDGU7fVUDdWttjY8JjPs/lg0UC1E+ofhs97hnnWZbTU5W
	 VZ/cVGXoduAJC/UAh1Aw/JyugqGLCAvv8NYXwGlmEvZN1uphBE/2q3AMJvIj1vnoR5
	 NhWRirmtG7hhPAXbzRgHRzzQcPrE6dmYDR8jAnFlCbXhtdoN8cAO3DrqIVYNWC+V5H
	 hKWsrd6MXsKGmg9M/xTMSt60O/K80QY1vc184XXyrV6gE/7gViZRHs1sM6JlwyB1Dz
	 DYvbesEvrJtBA==
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
Subject: [PATCH 01/34] sched_ext: Implement cgroup subtree iteration for scx_task_iter
Date: Tue, 24 Feb 2026 19:00:36 -1000
Message-ID: <20260225050109.1070059-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050109.1070059-1-tj@kernel.org>
References: <20260225050109.1070059-1-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14240-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1A8C191B14
X-Rspamd-Action: no action

For the planned cgroup sub-scheduler support, enable/disable operations are
going to be subtree specific and iterating all tasks in the system for those
operations can be unnecessarily expensive and disruptive.

cgroup already has mechanisms to perform subtree task iterations. Implement
cgroup subtree iteration for scx_task_iter:

- Add optional @cgrp to scx_task_iter_start() which enables cgroup subtree
  iteration.

- Make scx_task_iter use css_next_descendant_pre() and css_task_iter to
  iterate all tasks in the cgroup subtree.

- Update all existing callers to pass NULL to maintain current behavior.

The two iteration mechanisms are independent and duplicate. It's likely that
scx_tasks can be removed in favor of always using cgroup iteration if
CONFIG_SCHED_CLASS_EXT depends on CONFIG_CGROUPS.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 64 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d191dbc9e981..25b9b488ed1f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -514,14 +514,31 @@ struct scx_task_iter {
 	struct rq_flags			rf;
 	u32				cnt;
 	bool				list_locked;
+#ifdef CONFIG_CGROUPS
+	struct cgroup			*cgrp;
+	struct cgroup_subsys_state	*css_pos;
+	struct css_task_iter		css_iter;
+#endif
 };
 
 /**
  * scx_task_iter_start - Lock scx_tasks_lock and start a task iteration
  * @iter: iterator to init
+ * @cgrp: Optional root of cgroup subhierarchy to iterate
+ *
+ * Initialize @iter. Once initialized, @iter must eventually be stopped with
+ * scx_task_iter_stop().
+ *
+ * If @cgrp is %NULL, scx_tasks is used for iteration and this function returns
+ * with scx_tasks_lock held and @iter->cursor inserted into scx_tasks.
+ *
+ * If @cgrp is not %NULL, @cgrp and its descendants' tasks are walked using
+ * @iter->css_iter. The caller must be holding cgroup_lock() to prevent cgroup
+ * task migrations.
  *
- * Initialize @iter and return with scx_tasks_lock held. Once initialized, @iter
- * must eventually be stopped with scx_task_iter_stop().
+ * The two modes of iterations are largely independent and it's likely that
+ * scx_tasks can be removed in favor of always using cgroup iteration if
+ * CONFIG_SCHED_CLASS_EXT depends on CONFIG_CGROUPS.
  *
  * scx_tasks_lock and the rq lock may be released using scx_task_iter_unlock()
  * between this and the first next() call or between any two next() calls. If
@@ -532,10 +549,19 @@ struct scx_task_iter {
  * All tasks which existed when the iteration started are guaranteed to be
  * visited as long as they are not dead.
  */
-static void scx_task_iter_start(struct scx_task_iter *iter)
+static void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
 {
 	memset(iter, 0, sizeof(*iter));
 
+#ifdef CONFIG_CGROUPS
+	if (cgrp) {
+		lockdep_assert_held(&cgroup_mutex);
+		iter->cgrp = cgrp;
+		iter->css_pos = css_next_descendant_pre(NULL, &iter->cgrp->self);
+		css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+		return;
+	}
+#endif
 	raw_spin_lock_irq(&scx_tasks_lock);
 
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
@@ -588,6 +614,14 @@ static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
  */
 static void scx_task_iter_stop(struct scx_task_iter *iter)
 {
+#ifdef CONFIG_CGROUPS
+	if (iter->cgrp) {
+		if (iter->css_pos)
+			css_task_iter_end(&iter->css_iter);
+		__scx_task_iter_rq_unlock(iter);
+		return;
+	}
+#endif
 	__scx_task_iter_maybe_relock(iter);
 	list_del_init(&iter->cursor.tasks_node);
 	scx_task_iter_unlock(iter);
@@ -611,6 +645,24 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 		cond_resched();
 	}
 
+#ifdef CONFIG_CGROUPS
+	if (iter->cgrp) {
+		while (iter->css_pos) {
+			struct task_struct *p;
+
+			p = css_task_iter_next(&iter->css_iter);
+			if (p)
+				return p;
+
+			css_task_iter_end(&iter->css_iter);
+			iter->css_pos = css_next_descendant_pre(iter->css_pos,
+								&iter->cgrp->self);
+			if (iter->css_pos)
+				css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+		}
+		return NULL;
+	}
+#endif
 	__scx_task_iter_maybe_relock(iter);
 
 	list_for_each_entry(pos, cursor, tasks_node) {
@@ -4433,7 +4485,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
@@ -5213,7 +5265,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable_unlock_all;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
 		 * @p may already be dead, have lost all its usages counts and
@@ -5255,7 +5307,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * scx_tasks_lock.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
-- 
2.53.0


