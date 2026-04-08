Return-Path: <cgroups+bounces-15197-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMKvEI6p1mlKHAgAu9opvQ
	(envelope-from <cgroups+bounces-15197-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 21:16:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854463C2AA2
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 21:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962A3325798D
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2026 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A433D75C9;
	Wed,  8 Apr 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jEdyxlx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E48337B81;
	Wed,  8 Apr 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674317; cv=none; b=b/dFFnVMAGF6msru/xWlW0Hl4bam08rw+qiEpMourRPQ710EN0IH6aRtpdgNzPU4EFY6vQs/DmueNIameszzwKl35t0R4vCUA9XEQQHfjgQjulThrb7O0U5iM1H9hHToNBp80F8MLAyNgNnpymmepfuhoFU1JHUuUdjOCLeuw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674317; c=relaxed/simple;
	bh=rYnwl9ozbcRDsExaEKFrD/dV4o7dreV5JI01LEfOIVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTuwACv1nhlP2sBFyxplycZ5ln4LnD5FYXqEC5h1J55Pd58Lr8GAyXQXWqMbNpWewTQePruJFhL/XGjOlEiiFOpwZZB3yvuYMDJYOpN5SVwBdyKvLJ3jyEIjvlAUdwApSbzvGF0NvE07hbU2Jnz6YwKV5Ss559zRHhg/LiudsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jEdyxlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0EFC19421;
	Wed,  8 Apr 2026 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674316;
	bh=rYnwl9ozbcRDsExaEKFrD/dV4o7dreV5JI01LEfOIVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1jEdyxlxCpyr6cD6qU7WLd0DNcH34/R0aG6mCHFRpdhkdMA6S3u4XQrt0kXoZjw8F
	 A0RNgUhLNnv5p9yGIK/rpTWY6vKKTMxmKSxGNk1jdEEjbuGW5fzKs2JTzT8ieQlaik
	 +k+Cku3DGoN5r/xzEndM+smXe6P2/rRWqwrFMI6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Bert Karwatzki <spasswolf@web.de>,
	Michal Koutny <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 033/311] cgroup: Wait for dying tasks to leave on rmdir
Date: Wed,  8 Apr 2026 20:00:33 +0200
Message-ID: <20260408175940.650588610@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,linutronix.de,kernel.org,web.de,suse.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15197-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email,intel.com:email]
X-Rspamd-Queue-Id: 854463C2AA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 1b164b876c36c3eb5561dd9b37702b04401b0166 ]

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

v2: cgroup_is_populated() true to false transition happens under css_set_lock
    not cgroup_mutex, so retest under css_set_lock before sleeping to avoid
    missed wakeups (Sebastian).

Fixes: a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202603222104.2c81684e-lkp@intel.com
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cgroup-defs.h |  3 ++
 kernel/cgroup/cgroup.c      | 86 +++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f7cc60de00583..2bff3e2be0d3b 100644
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
index 3f9e4bcd71988..257d1ddea1ada 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2126,6 +2126,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 #endif
 
 	init_waitqueue_head(&cgrp->offline_waitq);
+	init_waitqueue_head(&cgrp->dying_populated_waitq);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
@@ -6224,6 +6225,76 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
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
+	 *
+	 * cgroup_is_populated() can't transition from false to true while
+	 * we're holding cgroup_mutex, but the true to false transition
+	 * happens under css_set_lock (via cgroup_task_dead()). We must
+	 * retest and prepare_to_wait() under css_set_lock. Otherwise, the
+	 * transition can happen between our first test and
+	 * prepare_to_wait(), and we sleep with no one to wake us.
+	 */
+	spin_lock_irq(&css_set_lock);
+	if (!cgroup_is_populated(cgrp)) {
+		spin_unlock_irq(&css_set_lock);
+		return 0;
+	}
+	prepare_to_wait(&cgrp->dying_populated_waitq, &wait,
+			TASK_UNINTERRUPTIBLE);
+	spin_unlock_irq(&css_set_lock);
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
@@ -6233,9 +6304,12 @@ int cgroup_rmdir(struct kernfs_node *kn)
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
@@ -6995,6 +7069,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 
 static void do_cgroup_task_dead(struct task_struct *tsk)
 {
+	struct cgrp_cset_link *link;
 	struct css_set *cset;
 	unsigned long flags;
 
@@ -7008,6 +7083,11 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
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




