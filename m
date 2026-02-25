Return-Path: <cgroups+bounces-14275-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBsoB0OFnmnPVwQAu9opvQ
	(envelope-from <cgroups+bounces-14275-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:14:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAE6191DFB
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24C9830116A1
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630342E7165;
	Wed, 25 Feb 2026 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGVz1WH5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E552E92BA;
	Wed, 25 Feb 2026 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995714; cv=none; b=j012k7E78vtBqJlJ1b64tJqiDp/fW2lLNf841PUcs2vsTFM1WhddcsCVijoKC24CbVUbfm0TghPgSWW7JFEHoPsy3a2v73ok0e9I4c5QyMBKigUyItNkE9bWobOLPeGBi5YB4VB7p/XKjpFFcZUBHUawsWHB8pvM5rPoSESTMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995714; c=relaxed/simple;
	bh=gIQavw7nnSQBPtvR64x4CT554azmfJV2O88vL03iXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx4vP1cnnhrXAxKyds2iA7ptGKNbEDeodLqQFqd+HUhQbYrEhfppr5OV5WWLyp5zn8K9zbZ5kIs03JrkEiu52E9mXa1Ti243Mq/sRjFI98p/F5ZTw62mfX7+43drm+X/LZ+h08WGhbnpiX2yNiy0K7AbilwC4eJrQnA542M/90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGVz1WH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2655C116D0;
	Wed, 25 Feb 2026 05:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995714;
	bh=gIQavw7nnSQBPtvR64x4CT554azmfJV2O88vL03iXX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGVz1WH5xeqSUASdlg23Usz7YVVOfT0iAg33feLsPVRMbhA5k6yczNDH9n3XBa9oG
	 H+pC3mEUrkS+mtSjaXUD8M9KshaABLkAaS5G47byIAz8HhKCgyYb6ZWmp+fHaj08xv
	 5tzHjj1ahXf5jBwpqTQMszWowlRABN9d4EBZzKVXk8q6sFeW8nNUkScp6oxD7dlMR0
	 CBADXhTRDM64EaO2M9HqK94XOOl7lZJ6c45/13lW/LqI6/tl95TsYH09GfBy0TFEST
	 JN5CX3cQySJMoiH45BZhEp1A7TOaIjWB6Zjc7bXgxU3fCfKqu6H3NtJFDhYPPVKyWZ
	 AByPXNHEiNDTw==
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
Date: Tue, 24 Feb 2026 19:01:19 -1000
Message-ID: <20260225050152.1070601-2-tj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14275-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3CAE6191DFB
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


