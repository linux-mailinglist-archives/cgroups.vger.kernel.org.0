Return-Path: <cgroups+bounces-15599-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHztChw/+WkZ7QIAu9opvQ
	(envelope-from <cgroups+bounces-15599-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB794C58F1
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5F143009E2D
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F50317170;
	Tue,  5 May 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQAsj5jY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DF315D46;
	Tue,  5 May 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942286; cv=none; b=s/McaN64D/gDG5tpcakus0hLf1vn9ORkIMmTMFzpS4SIJstEdNuFn1dHDUODhfEdM2pAG+2UiDDDuBzmZPOCm2jzv+trsjTyezdCjRJhw6nwXmKWK1Mxb6aSfAW9U3hlJptbZqYRlH1j5QISP6EJEBTg56omjXE2lH4nAHMiVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942286; c=relaxed/simple;
	bh=kPgaQnrHp4AYawmT5BkPngm5eN+TTeRnoqQDEjlg1Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyUI3y4V8SE/8LlDCDjEdExRraC7Lc6IoU2cKDuZuYdpb05VN7rQXSeGvn0I6y3mdiLsLb3jtqzaQeq+5Ao7fWWKcXeFEpAIy0b1pqijcC5RJx1xiNdiePMOLkcLeYr75bjywmqAklboU+hSLB9UvrbLnNAGY4WB874snh1M1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQAsj5jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405A9C2BCF7;
	Tue,  5 May 2026 00:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942286;
	bh=kPgaQnrHp4AYawmT5BkPngm5eN+TTeRnoqQDEjlg1Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQAsj5jY3w7fygtR/62MkvzJizLL7J0E0UPLFj+g3eg1bHq4lgZANaSf5KULcADW2
	 0G3iJHfO6ODB8LsO0dOnfeOfN1kiZyNC8RpgWPxaz+8QaWl2wKN9X6WrVD4Udh59Zz
	 k1kSAuOgK1SKwMcn+IkkVEXIqYJLKshZpkldjsM943aRSCAWM8fI1eFpP6Mim4fTJG
	 om+LJQOaYnZQE3qZhplSJ/+/1yvf40WMSLGRyFTPVcvef++vs+UWgwcc1o8Ojuu8GQ
	 n4DqLfxAULAkq5nSvT7yKY1uebDWvW3qvSBjEN2upWhH8z3xkgHSv7SuxCb56x7l8L
	 kJD1zAQ6WYSQQ==
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] cgroup: Add per-subsys-css kill_css_finish deferral
Date: Mon,  4 May 2026 14:51:20 -1000
Message-ID: <20260505005121.1230198-5-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505005121.1230198-1-tj@kernel.org>
References: <20260505005121.1230198-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CB794C58F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-15599-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

93618edf7538 ("cgroup: Defer css percpu_ref kill on rmdir until cgroup is
depopulated") deferred kill_css_finish() at the cgroup level: rmdir waits
for the entire cgroup's populated count to drop to zero, then fires
kill_css_finish() on every subsystem css at once. Replace that with
per-subsys-css deferral. Each subsystem css now tracks its own hierarchical
populated count and independently defers its kill_css_finish() until its own
subtree drains.

The rmdir-race fix carries through unchanged in shape. The dying css's
->css_offline() still waits until no PF_EXITING task references it, and v2's
cgroup-level machinery goes away.

cgroup_apply_control_disable() has the same race shape (PF_EXITING tasks
pinning a css whose ->css_offline() is about to run) and stays synchronous
here. This patch lays the groundwork for fixing it - per-cgroup waiting
can't gate one subsys css being killed while the rest of the cgroup stays
live, but per-css can.

Subtree-wide invariant preserved: a dying ancestor css stays populated
through nr_populated_children until every dying descendant's task drains, so
the walker fires the ancestor's kill_finish_work only after all descendants
have drained.

Add paired smp_mb()s in kill_css_sync() and css_update_populated() to fence
the StoreLoad on (CSS_DYING, populated counter), guaranteeing that either
the walker queues kill_finish_work or the caller fires synchronously.
cgroup_destroy_locked() was implicitly fenced by an unrelated css_set_lock
pair; cgroup_apply_control_disable() in the next patch is not.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h |  6 +--
 kernel/cgroup/cgroup.c      | 83 +++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c4929f7bbe5a..de2cd6238c2a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -262,6 +262,9 @@ struct cgroup_subsys_state {
 	int nr_populated_csets;
 	int nr_populated_children;
 
+	/* deferred kill_css_finish() queued by css_update_populated() */
+	struct work_struct kill_finish_work;
+
 	/*
 	 * A singly-linked list of css structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
@@ -615,9 +618,6 @@ struct cgroup {
 	/* used to wait for offlining of csses */
 	wait_queue_head_t offline_waitq;
 
-	/* defers killing csses after removal until cgroup is depopulated */
-	struct work_struct finish_destroy_work;
-
 	/* used to schedule release agent */
 	struct work_struct release_agent_work;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd4ea9d83100..fa24102535d9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -264,7 +264,6 @@ static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
 static void css_task_iter_skip(struct css_task_iter *it,
 			       struct task_struct *task);
 static int cgroup_destroy_locked(struct cgroup *cgrp);
-static void cgroup_finish_destroy(struct cgroup *cgrp);
 static void kill_css_sync(struct cgroup_subsys_state *css);
 static void kill_css_finish(struct cgroup_subsys_state *css);
 static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
@@ -801,13 +800,19 @@ static void css_update_populated(struct cgroup_subsys_state *css, bool populated
 			break;
 
 		/*
-		 * Subtree just emptied below an offlined cgrp. Fire deferred
-		 * destroy. The transition is one-shot.
+		 * Pair with smp_mb() in kill_css_sync(). Either we observe
+		 * CSS_DYING and queue, or the caller observes our decrement
+		 * and fires synchronously.
 		 */
-		if (cgrp && was_populated && !css_is_online(css)) {
-			cgroup_get(cgrp);
-			WARN_ON_ONCE(!queue_work(cgroup_offline_wq,
-						 &cgrp->finish_destroy_work));
+		smp_mb();
+
+		/*
+		 * Subtree just emptied below a dying css. Fire deferred kill.
+		 * The transition is one-shot for a dying css.
+		 */
+		if (was_populated && css_is_dying(css)) {
+			css_get(css);
+			WARN_ON_ONCE(!queue_work(cgroup_offline_wq, &css->kill_finish_work));
 		}
 
 		if (cgrp) {
@@ -2064,16 +2069,6 @@ static int cgroup_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
-static void cgroup_finish_destroy_work_fn(struct work_struct *work)
-{
-	struct cgroup *cgrp = container_of(work, struct cgroup, finish_destroy_work);
-
-	cgroup_lock();
-	cgroup_finish_destroy(cgrp);
-	cgroup_unlock();
-	cgroup_put(cgrp);
-}
-
 static void init_cgroup_housekeeping(struct cgroup *cgrp)
 {
 	struct cgroup_subsys *ss;
@@ -2100,7 +2095,6 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 #endif
 
 	init_waitqueue_head(&cgrp->offline_waitq);
-	INIT_WORK(&cgrp->finish_destroy_work, cgroup_finish_destroy_work_fn);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
@@ -5695,6 +5689,22 @@ static void css_release(struct percpu_ref *ref)
 	queue_work(cgroup_release_wq, &css->destroy_work);
 }
 
+/*
+ * Deferred kill_css_finish() fired from css_update_populated() once a dying
+ * css's hierarchical populated state drops to zero. Pinned by css_get() at the
+ * queue site; matched by css_put() here.
+ */
+static void kill_css_finish_work_fn(struct work_struct *work)
+{
+	struct cgroup_subsys_state *css =
+		container_of(work, struct cgroup_subsys_state, kill_finish_work);
+
+	cgroup_lock();
+	kill_css_finish(css);
+	cgroup_unlock();
+	css_put(css);
+}
+
 static void init_and_link_css(struct cgroup_subsys_state *css,
 			      struct cgroup_subsys *ss, struct cgroup *cgrp)
 {
@@ -5708,6 +5718,7 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
+	INIT_WORK(&css->kill_finish_work, kill_css_finish_work_fn);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -6083,6 +6094,13 @@ static void kill_css_sync(struct cgroup_subsys_state *css)
 
 	css->flags |= CSS_DYING;
 
+	/*
+	 * Pair with smp_mb() in css_update_populated(). Either our
+	 * caller observes the walker's decrement and fires
+	 * synchronously, or the walker observes CSS_DYING and queues.
+	 */
+	smp_mb();
+
 	/*
 	 * This must happen before css is disassociated with its cgroup.
 	 * See seq_css() for details.
@@ -6158,9 +6176,9 @@ static void kill_css_finish(struct cgroup_subsys_state *css)
  * - This function: synchronous user-visible state teardown plus kill_css_sync()
  *   on each subsystem css.
  *
- * - cgroup_finish_destroy(): kicks the percpu_ref kill via kill_css_finish() on
- *   each subsystem css. Fires once @cgrp's subtree is fully drained, either
- *   inline here or from css_update_populated().
+ * - For each subsys css: fire kill_css_finish() synchronously if the subtree is
+ *   already drained, otherwise rely on css_update_populated() to queue
+ *   kill_finish_work when the last populated cset under the css empties.
  *
  * - The percpu_ref kill chain: css_killed_ref_fn -> css_killed_work_fn ->
  *   ->css_offline() -> release/free.
@@ -6238,29 +6256,14 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
 
-	if (!cgroup_is_populated(cgrp))
-		cgroup_finish_destroy(cgrp);
+	for_each_css(css, ssid, cgrp) {
+		if (!css_is_populated(css))
+			kill_css_finish(css);
+	}
 
 	return 0;
 };
 
-/**
- * cgroup_finish_destroy - deferred half of @cgrp destruction
- * @cgrp: cgroup whose subtree just became empty
- *
- * See cgroup_destroy_locked() for the rationale.
- */
-static void cgroup_finish_destroy(struct cgroup *cgrp)
-{
-	struct cgroup_subsys_state *css;
-	int ssid;
-
-	lockdep_assert_held(&cgroup_mutex);
-
-	for_each_css(css, ssid, cgrp)
-		kill_css_finish(css);
-}
-
 int cgroup_rmdir(struct kernfs_node *kn)
 {
 	struct cgroup *cgrp;
-- 
2.54.0


