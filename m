Return-Path: <cgroups+bounces-15578-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBukIYjx9Gl+FwIAu9opvQ
	(envelope-from <cgroups+bounces-15578-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 20:31:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A12E4AED7C
	for <lists+cgroups@lfdr.de>; Fri, 01 May 2026 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5628730182B7
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2026 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF910322749;
	Fri,  1 May 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdRXq87d"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15129BDBF;
	Fri,  1 May 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660283; cv=none; b=eak1Vna5qL7aAqy+M9sXtmwt/4wPS6r+81hffgg3OxrfdJ9O2q1+4lnLQNc8w75ZA60SIFeOtyo7o2b+GGYHiCkQMFR8I34NMI0yPVF/iihGuyLMI7P6jaPmmkM3BaXtpXy3ngsMrrwywv5s7fcyrGlnxah9LjyaX51inyDAIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660283; c=relaxed/simple;
	bh=9DMjRKPtqxwLf0+9fFuXm9d9ujr5eRU1foY6WRxF7/w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=kg2H24pIO6EekPQOSZ4x+UhEJ+kQICXs+u6ASkOAoInLNbuP2m4fw43TvaM88aRzgpYJkzmealjp3gBYg8S6IrtnxW+UgsC00LxtU7Vq4HhbbAt7f9CbqzTJc/SK2xinopmUjMEPa0xe1M15zpvRYA1/jzs/tpzDdXFTbfnH/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdRXq87d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF9C2BCB9;
	Fri,  1 May 2026 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777660283;
	bh=9DMjRKPtqxwLf0+9fFuXm9d9ujr5eRU1foY6WRxF7/w=;
	h=Date:From:To:Cc:Subject:From;
	b=PdRXq87dpIbh3A3COF85fS8oGBbGbl93JO4IPFm3OUrD1FY0sGLrwsmrMoNMeZCTR
	 AVZIeehmm78yq+AWzlPaCaBz80dmFR4ITjV+rdwV2IAEw0wHiqqWGJXNS8qZTSODPR
	 350sFur71xOrXg0WOvQpMQGM1gcP+R2utj/4FAz6oWd/8LTiOf9yShq5Q/w3PGX3gJ
	 1kjbyjHM/7IABuOiBxm85enFX37BZTmo6MHykHnoE+QZfNv6ZacGNBGBuQX6E7KEBO
	 uTwhdHPI0chX3m24LuQ/ya5oZRO01J7AGtVx6ddJAPDicr+pQU2cN3wHOOu/uNgQnh
	 lrfdT7Jg+Ih0g==
Date: Fri, 01 May 2026 08:31:22 -1000
Message-ID: <ad3b4597f3df81914b871618535370db@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Martin Pitt <martin@piware.de>
Cc: regressions@lists.linux.dev,
 cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 cgroup/for-7.1-fixes sched_ext/for-7.1-fixes] cgroup: Defer
 css percpu_ref kill on rmdir until cgroup is depopulated
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3A12E4AED7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15578-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

A chain of commits going back to v7.0 reworked rmdir to satisfy the
controller invariant that a subsystem's ->css_offline() must not run while
tasks are still doing kernel-side work in the cgroup.

[1] d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
[2] a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup")
[3] 1b164b876c36 ("cgroup: Wait for dying tasks to leave on rmdir")
[4] 4c56a8ac6869 ("cgroup: Fix cgroup_drain_dying() testing the wrong condition")
[5] 13e786b64bd3 ("cgroup: Increment nr_dying_subsys_* from rmdir context")

[1] moved task cset unlink from do_exit() to finish_task_switch() so a
task's cset link drops only after the task has fully stopped scheduling.
That made tasks past exit_signals() linger on cset->tasks until their final
context switch, which led to a series of problems as what userspace expected
to see after rmdir diverged from what the kernel needs to wait for. [2]-[5]
tried to bridge that divergence: [2] filtered the exiting tasks from
cgroup.procs; [3] had rmdir(2) sleep in TASK_UNINTERRUPTIBLE for them; [4]
fixed the wait's condition; [5] made nr_dying_subsys_* visible
synchronously.

The cgroup_drain_dying() wait in [3] turned out to be a dead end. When the
rmdir caller is also the reaper of a zombie that pins a pidns teardown (e.g.
host PID 1 systemd reaping orphan pids that were re-parented to it during
the same teardown), rmdir blocks in TASK_UNINTERRUPTIBLE waiting for those
pids to free, the pids can't free because PID 1 is the reaper and it's stuck
in rmdir, and the system A-A deadlocks. No internal lock ordering breaks
this; the wait itself is the bug.

The css killing side that drove the original reorder, however, can be made
cleanly asynchronous: ->css_offline() is already async, run from
css_killed_work_fn() driven by percpu_ref_kill_and_confirm(). The fix is to
make that chain start only after all tasks have left the cgroup. rmdir's
user-visible side then returns as soon as cgroup.procs and friends are
empty, while ->css_offline() still runs only after the cgroup is fully
drained.

Verified by the original reproducer (pidns teardown + zombie reaper, runs
under vng) which hangs vanilla and succeeds here, and by per-commit
deterministic repros for [2], [3], [4], [5] with a boot parameter that
widens the post-exit_signals() window so each state is reliably reachable.
Some stress tests on top of that.

cgroup_apply_control_disable() has the same shape of pre-existing race:
when a controller is disabled via subtree_control, kill_css() ran
synchronously while tasks past exit_signals() could still be linked to
the cgroup's csets, and ->css_offline() could fire before they drained.
This patch preserves the existing synchronous behavior at that call site
(kill_css_sync() + kill_css_finish() back-to-back) and a follow-up patch
will defer kill_css_finish() there using a per-css trigger.

This seems like the right approach and I don't see problems with it. The
changes are somewhat invasive but not excessively so, so backporting to
-stable should be okay. If something does turn out to be wrong, the fallback
is to revert the entire chain ([1]-[5]) and rework in the development branch
instead.

v2: Pin cgrp across the deferred destroy work with explicit
    cgroup_get()/cgroup_put() around queue_work() and the work_fn. v1
    wasn't actually broken (ordered cgroup_offline_wq + queue_work order
    in cgroup_task_dead() saved it) but the explicit ref removes the
    dependency on those non-obvious invariants. Also note the
    pre-existing cgroup_apply_control_disable() race in the description;
    a follow-up will defer kill_css_finish() there.

Fixes: 1b164b876c36 ("cgroup: Wait for dying tasks to leave on rmdir")
Cc: stable@vger.kernel.org # v7.0+
Reported-by: Martin Pitt <martin@piware.de>
Link: https://lore.kernel.org/all/afHNg2VX2jy9bW7y@piware.de/
Link: https://lore.kernel.org/all/35e0670adb4abeab13da2c321582af9f@kernel.org/
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Hello Martin,

Could you give v2 a try? Same defer-the-percpu_ref-kill mechanism as
v1, with an explicit cgroup_get/put around the deferred work to make
the lifetime invariant obvious (Sashiko bot review on v1; v1 wasn't
broken but the explicit ref removes a dependency on non-obvious
ordering). Fix should behave identically to v1 for your reproducer.

Thanks.

 include/linux/cgroup-defs.h |    4 
 kernel/cgroup/cgroup.c      |  250 ++++++++++++++++++++------------------------
 2 files changed, 119 insertions(+), 135 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -611,8 +611,8 @@ struct cgroup {
 	/* used to wait for offlining of csses */
 	wait_queue_head_t offline_waitq;
 
-	/* used by cgroup_rmdir() to wait for dying tasks to leave */
-	wait_queue_head_t dying_populated_waitq;
+	/* defers killing csses after removal until cgroup is depopulated */
+	struct work_struct finish_destroy_work;
 
 	/* used to schedule release agent */
 	struct work_struct release_agent_work;
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -264,10 +264,12 @@ static void cgroup_finalize_control(stru
 static void css_task_iter_skip(struct css_task_iter *it,
 			       struct task_struct *task);
 static int cgroup_destroy_locked(struct cgroup *cgrp);
+static void cgroup_finish_destroy(struct cgroup *cgrp);
+static void kill_css_sync(struct cgroup_subsys_state *css);
+static void kill_css_finish(struct cgroup_subsys_state *css);
 static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss);
 static void css_release(struct percpu_ref *ref);
-static void kill_css(struct cgroup_subsys_state *css);
 static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add);
@@ -797,6 +799,16 @@ static void cgroup_update_populated(stru
 		if (was_populated == cgroup_is_populated(cgrp))
 			break;
 
+		/*
+		 * Subtree just emptied below an offlined cgrp. Fire deferred
+		 * destroy. The transition is one-shot.
+		 */
+		if (was_populated && !css_is_online(&cgrp->self)) {
+			cgroup_get(cgrp);
+			WARN_ON_ONCE(!queue_work(cgroup_offline_wq,
+						 &cgrp->finish_destroy_work));
+		}
+
 		cgroup1_check_for_release(cgrp);
 		TRACE_CGROUP_PATH(notify_populated, cgrp,
 				  cgroup_is_populated(cgrp));
@@ -2039,6 +2051,16 @@ static int cgroup_reconfigure(struct fs_
 	return 0;
 }
 
+static void cgroup_finish_destroy_work_fn(struct work_struct *work)
+{
+	struct cgroup *cgrp = container_of(work, struct cgroup, finish_destroy_work);
+
+	cgroup_lock();
+	cgroup_finish_destroy(cgrp);
+	cgroup_unlock();
+	cgroup_put(cgrp);
+}
+
 static void init_cgroup_housekeeping(struct cgroup *cgrp)
 {
 	struct cgroup_subsys *ss;
@@ -2065,7 +2087,7 @@ static void init_cgroup_housekeeping(str
 #endif
 
 	init_waitqueue_head(&cgrp->offline_waitq);
-	init_waitqueue_head(&cgrp->dying_populated_waitq);
+	INIT_WORK(&cgrp->finish_destroy_work, cgroup_finish_destroy_work_fn);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
@@ -3375,7 +3397,8 @@ static void cgroup_apply_control_disable
 
 			if (css->parent &&
 			    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
-				kill_css(css);
+				kill_css_sync(css);
+				kill_css_finish(css);
 			} else if (!css_visible(css)) {
 				css_clear_dir(css);
 				if (ss->css_reset)
@@ -5514,7 +5537,7 @@ static struct cftype cgroup_psi_files[]
  * css destruction is four-stage process.
  *
  * 1. Destruction starts.  Killing of the percpu_ref is initiated.
- *    Implemented in kill_css().
+ *    Implemented in kill_css_finish().
  *
  * 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
  *    and thus css_tryget_online() is guaranteed to fail, the css can be
@@ -5993,7 +6016,7 @@ out_unlock:
 /*
  * This is called when the refcnt of a css is confirmed to be killed.
  * css_tryget_online() is now guaranteed to fail.  Tell the subsystem to
- * initiate destruction and put the css ref from kill_css().
+ * initiate destruction and put the css ref from kill_css_finish().
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
@@ -6025,15 +6048,12 @@ static void css_killed_ref_fn(struct per
 }
 
 /**
- * kill_css - destroy a css
- * @css: css to destroy
+ * kill_css_sync - synchronous half of css teardown
+ * @css: css being killed
  *
- * This function initiates destruction of @css by removing cgroup interface
- * files and putting its base reference.  ->css_offline() will be invoked
- * asynchronously once css_tryget_online() is guaranteed to fail and when
- * the reference count reaches zero, @css will be released.
+ * See cgroup_destroy_locked().
  */
-static void kill_css(struct cgroup_subsys_state *css)
+static void kill_css_sync(struct cgroup_subsys_state *css)
 {
 	struct cgroup_subsys *ss = css->ss;
 
@@ -6056,24 +6076,6 @@ static void kill_css(struct cgroup_subsy
 	 */
 	css_clear_dir(css);
 
-	/*
-	 * Killing would put the base ref, but we need to keep it alive
-	 * until after ->css_offline().
-	 */
-	css_get(css);
-
-	/*
-	 * cgroup core guarantees that, by the time ->css_offline() is
-	 * invoked, no new css reference will be given out via
-	 * css_tryget_online().  We can't simply call percpu_ref_kill() and
-	 * proceed to offlining css's because percpu_ref_kill() doesn't
-	 * guarantee that the ref is seen as killed on all CPUs on return.
-	 *
-	 * Use percpu_ref_kill_and_confirm() to get notifications as each
-	 * css is confirmed to be seen as killed on all CPUs.
-	 */
-	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
-
 	css->cgroup->nr_dying_subsys[ss->id]++;
 	/*
 	 * Parent css and cgroup cannot be freed until after the freeing
@@ -6086,44 +6088,88 @@ static void kill_css(struct cgroup_subsy
 }
 
 /**
- * cgroup_destroy_locked - the first stage of cgroup destruction
+ * kill_css_finish - deferred half of css teardown
+ * @css: css being killed
+ *
+ * See cgroup_destroy_locked().
+ */
+static void kill_css_finish(struct cgroup_subsys_state *css)
+{
+	lockdep_assert_held(&cgroup_mutex);
+
+	/*
+	 * Skip on re-entry: cgroup_apply_control_disable() may have killed @css
+	 * earlier. cgroup_destroy_locked() can still walk it because
+	 * offline_css() (which NULLs cgrp->subsys[ssid]) runs async.
+	 */
+	if (percpu_ref_is_dying(&css->refcnt))
+		return;
+
+	/*
+	 * Killing would put the base ref, but we need to keep it alive until
+	 * after ->css_offline().
+	 */
+	css_get(css);
+
+	/*
+	 * cgroup core guarantees that, by the time ->css_offline() is invoked,
+	 * no new css reference will be given out via css_tryget_online(). We
+	 * can't simply call percpu_ref_kill() and proceed to offlining css's
+	 * because percpu_ref_kill() doesn't guarantee that the ref is seen as
+	 * killed on all CPUs on return.
+	 *
+	 * Use percpu_ref_kill_and_confirm() to get notifications as each css is
+	 * confirmed to be seen as killed on all CPUs.
+	 */
+	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
+}
+
+/**
+ * cgroup_destroy_locked - destroy @cgrp (called on rmdir)
  * @cgrp: cgroup to be destroyed
  *
- * css's make use of percpu refcnts whose killing latency shouldn't be
- * exposed to userland and are RCU protected.  Also, cgroup core needs to
- * guarantee that css_tryget_online() won't succeed by the time
- * ->css_offline() is invoked.  To satisfy all the requirements,
- * destruction is implemented in the following two steps.
- *
- * s1. Verify @cgrp can be destroyed and mark it dying.  Remove all
- *     userland visible parts and start killing the percpu refcnts of
- *     css's.  Set up so that the next stage will be kicked off once all
- *     the percpu refcnts are confirmed to be killed.
- *
- * s2. Invoke ->css_offline(), mark the cgroup dead and proceed with the
- *     rest of destruction.  Once all cgroup references are gone, the
- *     cgroup is RCU-freed.
- *
- * This function implements s1.  After this step, @cgrp is gone as far as
- * the userland is concerned and a new cgroup with the same name may be
- * created.  As cgroup doesn't care about the names internally, this
- * doesn't cause any problem.
+ * Tear down @cgrp on behalf of rmdir. Constraints:
+ *
+ * - Userspace: rmdir must succeed when cgroup.procs and friends are empty.
+ *
+ * - Kernel: subsystem ->css_offline() must not run while any task in @cgrp's
+ *   subtree is still doing kernel work. A task hidden from cgroup.procs (past
+ *   exit_signals() with signal->live cleared) can still schedule, allocate, and
+ *   consume resources until its final context switch. Dying descendants in the
+ *   subtree can host such tasks too.
+ *
+ * - Kernel: css_tryget_online() must fail by the time ->css_offline() runs.
+ *
+ * The destruction runs in three parts:
+ *
+ * - This function: synchronous user-visible state teardown plus kill_css_sync()
+ *   on each subsystem css.
+ *
+ * - cgroup_finish_destroy(): kicks the percpu_ref kill via kill_css_finish() on
+ *   each subsystem css. Fires once @cgrp's subtree is fully drained, either
+ *   inline here or from cgroup_update_populated().
+ *
+ * - The percpu_ref kill chain: css_killed_ref_fn -> css_killed_work_fn ->
+ *   ->css_offline() -> release/free.
+ *
+ * Return 0 on success, -EBUSY if a userspace-visible task or an online child
+ * remains.
  */
 static int cgroup_destroy_locked(struct cgroup *cgrp)
-	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
 {
 	struct cgroup *tcgrp, *parent = cgroup_parent(cgrp);
 	struct cgroup_subsys_state *css;
 	struct cgrp_cset_link *link;
+	struct css_task_iter it;
+	struct task_struct *task;
 	int ssid, ret;
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	/*
-	 * Only migration can raise populated from zero and we're already
-	 * holding cgroup_mutex.
-	 */
-	if (cgroup_is_populated(cgrp))
+	css_task_iter_start(&cgrp->self, 0, &it);
+	task = css_task_iter_next(&it);
+	css_task_iter_end(&it);
+	if (task)
 		return -EBUSY;
 
 	/*
@@ -6147,9 +6193,8 @@ static int cgroup_destroy_locked(struct
 		link->cset->dead = true;
 	spin_unlock_irq(&css_set_lock);
 
-	/* initiate massacre of all css's */
 	for_each_css(css, ssid, cgrp)
-		kill_css(css);
+		kill_css_sync(css);
 
 	/* clear and remove @cgrp dir, @cgrp has an extra ref on its kn */
 	css_clear_dir(&cgrp->self);
@@ -6180,79 +6225,27 @@ static int cgroup_destroy_locked(struct
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
 
+	if (!cgroup_is_populated(cgrp))
+		cgroup_finish_destroy(cgrp);
+
 	return 0;
 };
 
 /**
- * cgroup_drain_dying - wait for dying tasks to leave before rmdir
- * @cgrp: the cgroup being removed
+ * cgroup_finish_destroy - deferred half of @cgrp destruction
+ * @cgrp: cgroup whose subtree just became empty
  *
- * cgroup.procs and cgroup.threads use css_task_iter which filters out
- * PF_EXITING tasks so that userspace doesn't see tasks that have already been
- * reaped via waitpid(). However, cgroup_has_tasks() - which tests whether the
- * cgroup has non-empty css_sets - is only updated when dying tasks pass through
- * cgroup_task_dead() in finish_task_switch(). This creates a window where
- * cgroup.procs reads empty but cgroup_has_tasks() is still true, making rmdir
- * fail with -EBUSY from cgroup_destroy_locked() even though userspace sees no
- * tasks.
- *
- * This function aligns cgroup_has_tasks() with what userspace can observe. If
- * cgroup_has_tasks() but the task iterator sees nothing (all remaining tasks are
- * PF_EXITING), we wait for cgroup_task_dead() to finish processing them. As the
- * window between PF_EXITING and cgroup_task_dead() is short, the wait is brief.
- *
- * This function only concerns itself with this cgroup's own dying tasks.
- * Whether the cgroup has children is cgroup_destroy_locked()'s problem.
- *
- * Each cgroup_task_dead() kicks the waitqueue via cset->cgrp_links, and we
- * retry the full check from scratch.
- *
- * Must be called with cgroup_mutex held.
+ * See cgroup_destroy_locked() for the rationale.
  */
-static int cgroup_drain_dying(struct cgroup *cgrp)
-	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
+static void cgroup_finish_destroy(struct cgroup *cgrp)
 {
-	struct css_task_iter it;
-	struct task_struct *task;
-	DEFINE_WAIT(wait);
+	struct cgroup_subsys_state *css;
+	int ssid;
 
 	lockdep_assert_held(&cgroup_mutex);
-retry:
-	if (!cgroup_has_tasks(cgrp))
-		return 0;
 
-	/* Same iterator as cgroup.threads - if any task is visible, it's busy */
-	css_task_iter_start(&cgrp->self, 0, &it);
-	task = css_task_iter_next(&it);
-	css_task_iter_end(&it);
-
-	if (task)
-		return -EBUSY;
-
-	/*
-	 * All remaining tasks are PF_EXITING and will pass through
-	 * cgroup_task_dead() shortly. Wait for a kick and retry.
-	 *
-	 * cgroup_has_tasks() can't transition from false to true while we're
-	 * holding cgroup_mutex, but the true to false transition happens
-	 * under css_set_lock (via cgroup_task_dead()). We must retest and
-	 * prepare_to_wait() under css_set_lock. Otherwise, the transition
-	 * can happen between our first test and prepare_to_wait(), and we
-	 * sleep with no one to wake us.
-	 */
-	spin_lock_irq(&css_set_lock);
-	if (!cgroup_has_tasks(cgrp)) {
-		spin_unlock_irq(&css_set_lock);
-		return 0;
-	}
-	prepare_to_wait(&cgrp->dying_populated_waitq, &wait,
-			TASK_UNINTERRUPTIBLE);
-	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
-	schedule();
-	finish_wait(&cgrp->dying_populated_waitq, &wait);
-	mutex_lock(&cgroup_mutex);
-	goto retry;
+	for_each_css(css, ssid, cgrp)
+		kill_css_finish(css);
 }
 
 int cgroup_rmdir(struct kernfs_node *kn)
@@ -6264,12 +6257,9 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	if (!cgrp)
 		return 0;
 
-	ret = cgroup_drain_dying(cgrp);
-	if (!ret) {
-		ret = cgroup_destroy_locked(cgrp);
-		if (!ret)
-			TRACE_CGROUP_PATH(rmdir, cgrp);
-	}
+	ret = cgroup_destroy_locked(cgrp);
+	if (!ret)
+		TRACE_CGROUP_PATH(rmdir, cgrp);
 
 	cgroup_kn_unlock(kn);
 	return ret;
@@ -7029,7 +7019,6 @@ void cgroup_task_exit(struct task_struct
 
 static void do_cgroup_task_dead(struct task_struct *tsk)
 {
-	struct cgrp_cset_link *link;
 	struct css_set *cset;
 	unsigned long flags;
 
@@ -7043,11 +7032,6 @@ static void do_cgroup_task_dead(struct t
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 
-	/* kick cgroup_drain_dying() waiters, see cgroup_rmdir() */
-	list_for_each_entry(link, &cset->cgrp_links, cgrp_link)
-		if (waitqueue_active(&link->cgrp->dying_populated_waitq))
-			wake_up(&link->cgrp->dying_populated_waitq);
-
 	if (dl_task(tsk))
 		dec_dl_tasks_cs(tsk);
 

