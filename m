Return-Path: <cgroups+bounces-17673-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bx46EArTU2pUfQMAu9opvQ
	(envelope-from <cgroups+bounces-17673-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 19:46:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C084174584E
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 19:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NEk9xRIk;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17673-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17673-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0521B3015465
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04451367B84;
	Sun, 12 Jul 2026 17:46:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDB1FECBA;
	Sun, 12 Jul 2026 17:46:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878383; cv=none; b=TRtJHwLxm0RR3GfHcmqhT4uuo4Mw2BlPClKjTykRFt7CEtqAixNNAVNz7Zcn0vPHuxBM5lWfjAqvrHU/E2uwiJjaNYQqkb5kqytKjzMLoEi+zb+6Lra4Iv6pf3wCgesqtNhxwOa/OgVO2iN/Fvrtz1xk3ZFD0evpG9XPui0DCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878383; c=relaxed/simple;
	bh=dd9DydwuzWfB7mrA3K1kl7Uw+IIFI8jI8bGIUnpXkdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFIGjDZt8P89PI/zJojxk2ZjBWrBzKvp0c39fTcD5Y/9eXniz+2dKQFVuFvR35MoobWz30KxXjiw79U8breneA8uCg+n0ZTgepIaQvRPitAxrGZaj/00EaA1LTLuM49wcSmbMVUEvKSPVuLdA4qR0qPANQC2phMrLcXrFk+e/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEk9xRIk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40161F00A3A;
	Sun, 12 Jul 2026 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783878382;
	bh=1A/B42dHCXjGKT30DcsWli9CeAPqs+vigW+mgj1O7Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEk9xRIkMsRX9+C8wQ1e8iVbtP2T6yFIxiByfrDG01CaTjkSnqgnPXV7bcOxa592E
	 lQHCOGGEMTPWVyKruZE0uoVeePAUPFXu/atbHGolGFi1wCqNAQhGJwN8xKVzSS1b1d
	 +DNcfK7vFyVI0nQdI6fTQplOoL695cxzq4I4/qz85QtYoDNXlvjxaS+mZxnzjfAdDG
	 X8ywp2ddJLNO+5okHMJr8fiZvxqTBS932uz+kRTYiI0mAf7BCWgxHjnsO+KGiC6cjj
	 NByQOifow2V/vTYEGRhFENYAzyhu8i8THamgT+vXMqJ8Sg6c78dqyxMsPpEffZ6SQr
	 jjeg8ph3G5g4g==
From: Tejun Heo <tj@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"ziwei . dai" <ziwei.dai@unisoc.com>,
	"ke . wang" <ke.wang@unisoc.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched/psi: Create the psimon kthread outside of cgroup_mutex
Date: Sun, 12 Jul 2026 07:46:18 -1000
Message-ID: <20260712174619.3553231-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712174619.3553231-1-tj@kernel.org>
References: <20260712174619.3553231-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17673-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:tj@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,qq.com:email,cmpxchg.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C084174584E

a5b98009f16d ("sched/psi: fix race between file release and pressure write")
made pressure_write() hold cgroup_mutex across psi_trigger_create(), which
forks the psimon kthread for the first rtpoll trigger. As kthread creation
depends on the whole fork path, the commit inadvertently created a lot of
unwanted locking dependencies from cgroup_mutex.

sched_ext got hit by one: its enable path blocks forks and then grabs
cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, with
every other fork piling up behind.

Fix it by splitting trigger creation so that the worker is forked with
cgroup_mutex dropped and the kernfs active reference left broken. The latter
matters because rmdir and cgroup.pressure writes drain active references
under cgroup_mutex. Publishing the trigger last keeps error reporting
synchronous and preserves the of->priv lifetime rules.

The trigger registered in the first stage pins the group's rtpoll machinery
across the unlocked window, leaving only creation races to resolve. The
catch-up poll on installation covers scheduling attempts dropped while there
was no worker.

v2: Retagged sched/psi (was cgroup).

Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
Cc: stable@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrite.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/psi.h    |  4 ++-
 kernel/cgroup/cgroup.c | 23 +++++++++++++-
 kernel/sched/psi.c     | 69 ++++++++++++++++++++++++++++++++----------
 3 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index e0745873e3f2..7966e3ac03b9 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -25,7 +25,9 @@ void psi_memstall_leave(unsigned long *flags);
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 				       enum psi_res res, struct file *file,
-				       struct kernfs_open_file *of);
+				       struct kernfs_open_file *of,
+				       bool *need_rtpoll_worker);
+int psi_trigger_create_rtpoll_worker(struct psi_group *group);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 38f8d9df8fbc..b5b461d4418b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3996,6 +3996,7 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
+	bool need_rtpoll_worker;
 	ssize_t ret = 0;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
@@ -4015,12 +4016,32 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_psi(cgrp);
-	new = psi_trigger_create(psi, buf, res, of->file, of);
+	new = psi_trigger_create(psi, buf, res, of->file, of,
+				 &need_rtpoll_worker);
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto out_unlock;
 	}
 
+	/*
+	 * The worker fork must run with neither cgroup_mutex nor the file's
+	 * kernfs active reference held. The latter is broken since
+	 * cgroup_kn_lock_live(). @of->priv may be released while unlocked, so
+	 * recheck before publishing @new.
+	 */
+	if (need_rtpoll_worker) {
+		cgroup_unlock();
+		ret = psi_trigger_create_rtpoll_worker(psi);
+		cgroup_lock();
+
+		if (!ret && !of->priv)
+			ret = -ENODEV;
+		if (ret) {
+			psi_trigger_destroy(new);
+			goto out_unlock;
+		}
+	}
+
 	smp_store_release(&ctx->psi.trigger, new);
 
 out_unlock:
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d9c9d9480a45..565ec7b80743 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1292,9 +1292,44 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
+/*
+ * Create @group's rtpoll worker after psi_trigger_create() reported the need
+ * for one. kthread creation depends on the whole fork path and we don't want
+ * all of that nested inside cgroup_mutex, so the caller must drop it and any
+ * other lock that forks can wait behind. If two callers race, the loser stops
+ * its never-woken kthread.
+ */
+int psi_trigger_create_rtpoll_worker(struct psi_group *group)
+{
+	struct task_struct *task;
+
+	task = kthread_create(psi_rtpoll_worker, group, "psimon");
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	scoped_guard(mutex, &group->rtpoll_trigger_lock) {
+		if (!rcu_access_pointer(group->rtpoll_task)) {
+			atomic_set(&group->rtpoll_wakeup, 0);
+			wake_up_process(task);
+			rcu_assign_pointer(group->rtpoll_task, task);
+
+			/*
+			 * Poll once to catch up on scheduling attempts dropped
+			 * while there was no rtpoll worker.
+			 */
+			psi_schedule_rtpoll_work(group, 1, true);
+			return 0;
+		}
+	}
+
+	kthread_stop(task);
+	return 0;
+}
+
 struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 				       enum psi_res res, struct file *file,
-				       struct kernfs_open_file *of)
+				       struct kernfs_open_file *of,
+				       bool *need_rtpoll_worker)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
@@ -1302,6 +1337,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	bool privileged;
 	u32 window_us;
 
+	*need_rtpoll_worker = false;
+
 	if (static_branch_likely(&psi_disabled))
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -1362,26 +1399,14 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	if (privileged) {
 		mutex_lock(&group->rtpoll_trigger_lock);
 
-		if (!rcu_access_pointer(group->rtpoll_task)) {
-			struct task_struct *task;
-
-			task = kthread_create(psi_rtpoll_worker, group, "psimon");
-			if (IS_ERR(task)) {
-				kfree(t);
-				mutex_unlock(&group->rtpoll_trigger_lock);
-				return ERR_CAST(task);
-			}
-			atomic_set(&group->rtpoll_wakeup, 0);
-			wake_up_process(task);
-			rcu_assign_pointer(group->rtpoll_task, task);
-		}
-
 		list_add(&t->node, &group->rtpoll_triggers);
 		group->rtpoll_min_period = min(group->rtpoll_min_period,
 			div_u64(t->win.size, UPDATES_PER_WINDOW));
 		group->rtpoll_nr_triggers[t->state]++;
 		group->rtpoll_states |= (1 << t->state);
 
+		*need_rtpoll_worker = !rcu_access_pointer(group->rtpoll_task);
+
 		mutex_unlock(&group->rtpoll_trigger_lock);
 	} else {
 		mutex_lock(&group->avgs_lock);
@@ -1541,6 +1566,8 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	size_t buf_size;
 	struct seq_file *seq;
 	struct psi_trigger *new;
+	bool need_rtpoll_worker;
+	int ret;
 
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
@@ -1565,12 +1592,22 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res, file, NULL);
+	new = psi_trigger_create(&psi_system, buf, res, file, NULL,
+				 &need_rtpoll_worker);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
 	}
 
+	if (need_rtpoll_worker) {
+		ret = psi_trigger_create_rtpoll_worker(&psi_system);
+		if (ret) {
+			psi_trigger_destroy(new);
+			mutex_unlock(&seq->lock);
+			return ret;
+		}
+	}
+
 	smp_store_release(&seq->private, new);
 	mutex_unlock(&seq->lock);
 
-- 
2.55.0


