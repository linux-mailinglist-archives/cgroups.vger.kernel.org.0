Return-Path: <cgroups+bounces-14985-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFsFIFi6wGkFKgQAu9opvQ
	(envelope-from <cgroups+bounces-14985-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 04:58:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF82EC501
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 04:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEC5A3009F3D
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 03:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8FA21CC58;
	Mon, 23 Mar 2026 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Cc7uxK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FC1F5EA;
	Mon, 23 Mar 2026 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774238288; cv=none; b=jnnAzvWjaPd0sN201pjKokqmXR5vWgZ0tFOF2YUPcfLUHjiT2R6LBfLcHKBEU/Rpn5BdZveKyVcyEnu016IKoIIqltbIRokigIpzAKdAxeLODMK52zFYuB/vS9K7WfE3PTg498WOOxRhC92hM2PNPvHFfd5cKzhwcJF6ge0Pc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774238288; c=relaxed/simple;
	bh=1FSnHW0add6iqymFI/A+HGUQLUl6XLRt5UEw2din4BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMTqHCqKRbY8mMEjouaFcL2QnGSo9L4ozf9PKwoQA+IrEl8nRiCdtGH93scJNIh8rUbo/BNYFlQRgRSsdomxF8F3BocEfaAFMNH9K1LBImzLINOGPKBPlaJMpDPt1H/ooclP2OuG3UOLW6At/XKnZHY35JqkuysiPvClmVThioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Cc7uxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA6C4CEF7;
	Mon, 23 Mar 2026 03:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774238287;
	bh=1FSnHW0add6iqymFI/A+HGUQLUl6XLRt5UEw2din4BM=;
	h=From:To:Cc:Subject:Date:From;
	b=T4Cc7uxKHMhQL2WweMnGnghs8xRvBA5+zU2ic9gmN5gAha1cPSM/5I4+VXrQBFgfh
	 danzzR2shou0iNcQTnC9JmAr6qauF+Zhu1A/7T7ZHbqeg4EsbpyPG6lheTZw64Xrm0
	 QWkujamQGfY5jo5iOlzkcdE2nYky7sWHPAtbYVTm8MUvAeiazrVoY24xx/lluhKgZb
	 /f+fFXmXg7iG00XoBGqZO0slWQq5M2Guu7OpLZfS3or3Fes8ydXziowJTPzjneCklY
	 8u8zY8yE70Bk7/oCc+z93X6kVJBpPCkc+eIpLUBD967Tosd9x/QumONCcqgwIl0b9h
	 0M0ekNz1cTlXw==
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Bert Karwatzki <spasswolf@web.de>,
	Michal Koutny <mkoutny@suse.com>,
	kernel test robot <oliver.sang@intel.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] cgroup: Wait for dying tasks to leave on rmdir
Date: Sun, 22 Mar 2026 17:58:06 -1000
Message-ID: <20260323035806.724798-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,web.de,suse.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14985-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16DF82EC501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup") hid PF_EXITING
tasks from cgroup.procs so that systemd doesn't see tasks that have already
been reaped via waitpid(). However, the populated counter (nr_populated_csets)
is only decremented when the task later passes through cgroup_task_dead() in
finish_task_switch(). This means cgroup.procs can appear empty while the
cgroup is still populated, causing rmdir to fail with -EBUSY.

Fix this by making cgroup_rmdir() wait for dying tasks to fully leave. If the
cgroup is populated but all remaining tasks have PF_EXITING set (the task
iterator returns none due to the existing filter), wait for a kick from
cgroup_task_dead() and retry. The wait is brief as tasks are removed from the
cgroup's css_set between PF_EXITING assertion in do_exit() and
cgroup_task_dead() in finish_task_switch().

Fixes: a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202603222104.2c81684e-lkp@intel.com
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
---
 include/linux/cgroup-defs.h |  3 ++
 kernel/cgroup/cgroup.c      | 73 +++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index bb92f5c169ca..7f87399938fa 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -609,6 +609,9 @@ struct cgroup {
 	/* used to wait for offlining of csses */
 	wait_queue_head_t offline_waitq;
 
+	/* used by cgroup_rmdir() to wait for dying tasks to leave */
+	wait_queue_head_t dying_populated_waitq;
+
 	/* used to schedule release agent */
 	struct work_struct release_agent_work;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 01fc2a93f3ef..49c5622a1a63 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2126,6 +2126,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 #endif
 
 	init_waitqueue_head(&cgrp->offline_waitq);
+	init_waitqueue_head(&cgrp->dying_populated_waitq);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
@@ -6224,6 +6225,63 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	return 0;
 };
 
+/**
+ * cgroup_drain_dying - wait for dying tasks to leave before rmdir
+ * @cgrp: the cgroup being removed
+ *
+ * The PF_EXITING filter in css_task_iter_advance() hides exiting tasks from
+ * cgroup.procs so that userspace (e.g. systemd) doesn't see tasks that have
+ * already been reaped via waitpid(). However, the populated counter
+ * (nr_populated_csets) is only decremented when the task later passes through
+ * cgroup_task_dead() in finish_task_switch(). This creates a window where
+ * cgroup.procs appears empty but cgroup_is_populated() is still true, causing
+ * rmdir to fail with -EBUSY.
+ *
+ * This function bridges that gap. If the cgroup is populated but all remaining
+ * tasks have PF_EXITING set, we wait for cgroup_task_dead() to process them.
+ * Tasks are removed from the cgroup's css_set in cgroup_task_dead() called from
+ * finish_task_switch(). As the window between PF_EXITING and cgroup_task_dead()
+ * is short, the number of PF_EXITING tasks on the list is small and the wait
+ * is brief.
+ *
+ * Each cgroup_task_dead() kicks the waitqueue via cset->cgrp_links, and we
+ * retry the full check from scratch.
+ *
+ * Must be called with cgroup_mutex held.
+ */
+static int cgroup_drain_dying(struct cgroup *cgrp)
+	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+	DEFINE_WAIT(wait);
+
+	lockdep_assert_held(&cgroup_mutex);
+retry:
+	if (!cgroup_is_populated(cgrp))
+		return 0;
+
+	/* Same iterator as cgroup.threads - if any task is visible, it's busy */
+	css_task_iter_start(&cgrp->self, 0, &it);
+	task = css_task_iter_next(&it);
+	css_task_iter_end(&it);
+
+	if (task)
+		return -EBUSY;
+
+	/*
+	 * All remaining tasks are PF_EXITING and will pass through
+	 * cgroup_task_dead() shortly. Wait for a kick and retry.
+	 */
+	prepare_to_wait(&cgrp->dying_populated_waitq, &wait,
+			TASK_UNINTERRUPTIBLE);
+	mutex_unlock(&cgroup_mutex);
+	schedule();
+	finish_wait(&cgrp->dying_populated_waitq, &wait);
+	mutex_lock(&cgroup_mutex);
+	goto retry;
+}
+
 int cgroup_rmdir(struct kernfs_node *kn)
 {
 	struct cgroup *cgrp;
@@ -6233,9 +6291,12 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	if (!cgrp)
 		return 0;
 
-	ret = cgroup_destroy_locked(cgrp);
-	if (!ret)
-		TRACE_CGROUP_PATH(rmdir, cgrp);
+	ret = cgroup_drain_dying(cgrp);
+	if (!ret) {
+		ret = cgroup_destroy_locked(cgrp);
+		if (!ret)
+			TRACE_CGROUP_PATH(rmdir, cgrp);
+	}
 
 	cgroup_kn_unlock(kn);
 	return ret;
@@ -6995,6 +7056,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 
 static void do_cgroup_task_dead(struct task_struct *tsk)
 {
+	struct cgrp_cset_link *link;
 	struct css_set *cset;
 	unsigned long flags;
 
@@ -7008,6 +7070,11 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 
+	/* kick cgroup_drain_dying() waiters, see cgroup_rmdir() */
+	list_for_each_entry(link, &cset->cgrp_links, cgrp_link)
+		if (waitqueue_active(&link->cgrp->dying_populated_waitq))
+			wake_up(&link->cgrp->dying_populated_waitq);
+
 	if (dl_task(tsk))
 		dec_dl_tasks_cs(tsk);
 
-- 
2.53.0


