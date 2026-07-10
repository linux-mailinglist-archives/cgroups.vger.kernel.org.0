Return-Path: <cgroups+bounces-17656-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4UHxEnKFUWr6FgMAu9opvQ
	(envelope-from <cgroups+bounces-17656-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 01:51:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC373FC69
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 01:51:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q1FTKagN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17656-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17656-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3928300DF4A
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D01409134;
	Fri, 10 Jul 2026 23:50:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371111FD4;
	Fri, 10 Jul 2026 23:50:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727457; cv=none; b=izA2YgtDhGO0AEhwW0PbJQHjespoKL5sm0BD6yM9cOJSKrayOeCbhSXipW1JiOhAIWo5a2J20mDNthWUZVY+z0+ynRO+YXDeLSR5RrGggAdQTPG6t5AGuggpQGZYCcAHvLA9C8gSe67wnfqUN6YzWyZB1HavcFd1lOSbD3C7irY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727457; c=relaxed/simple;
	bh=RSEGxZ1PgU2dr8f2jpFd4gYB+iOI8ZoxSDTIWPkaT5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=CeYk19AQA02RhYIf3A+eyxe2/+Op3zVYSI0KRS1i4o/j6jMCaGUO+8vhSxScoZvfY2GZNDtCi4G+z2NvHBVqE+V2u8EVSOU15DVBKIgof00bCTUvROpfaIf7PsUxjkqr2gu9N0PRhYLl6L5QGdWcLEp+00u9XHf/DyA+y3v37IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1FTKagN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FC31F000E9;
	Fri, 10 Jul 2026 23:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783727455;
	bh=+0AS+0BwFMqyvkO7inyySqiZzeTKsjQpkukmVEEFFX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1FTKagN2ubXzfGp+9ors74m1PsfcnwCBwrPbuY0QJRK0Tv2bVeZ1CevORgYToGLO
	 gn+Jr5Hw9E3ejbZLiSDJDrkSWvYAC7hq8eAinvynMBzCZs1Mcdnmf1dmtxRn6jSPMT
	 zXPy0cGgyTRVA+4YlRmN49Ul2KXcxiheugoFqFySD0UNXKV916FAfdPDj5BuvgJaEY
	 OnsWfoa4Hcrz9ikqVtqqNPhaJixHfVTc3G59Jzve20k+x5/S3PuNBwgbTfBepaMN5s
	 pWzC3GTmAvql7bbPXtEhCgXZf+1B7Jq9bbh5lY1s+6hgV8sUFJzfjJxju278ZiO7HB
	 9lQk7CYmi6zSg==
From: Tejun Heo <tj@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	sched-ext@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthread
 outside of cgroup_mutex
Date: Fri, 10 Jul 2026 13:49:45 -1000
Message-ID: <20260710134945-psimon-fix-tj@kernel.org>
In-Reply-To: <20260710100441.2653477-1-matt@readmodwrite.com>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17656-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DBC373FC69

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

Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
Cc: stable@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrite.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Matt, your reordering trades one deadlock for another: CLONE_INTO_CGROUP
forks grab cgroup_mutex inside the scx_fork_rwsem read section, so an
enable racing such a clone deadlocks the other way around. The fork has to
move out of the locked sections instead. Can you verify this fixes the
deadlock in your setup?

 include/linux/psi.h    |    4 ++
 kernel/cgroup/cgroup.c |   23 +++++++++++++++-
 kernel/sched/psi.c     |   69 +++++++++++++++++++++++++++++++++++++------------
 3 files changed, 78 insertions(+), 18 deletions(-)

--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -25,7 +25,9 @@ void psi_memstall_leave(unsigned long *f
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 				       enum psi_res res, struct file *file,
-				       struct kernfs_open_file *of);
+				       struct kernfs_open_file *of,
+				       bool *need_rtpoll_worker);
+int psi_trigger_create_rtpoll_worker(struct psi_group *group);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3996,6 +3996,7 @@ static ssize_t pressure_write(struct ker
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
+	bool need_rtpoll_worker;
 	ssize_t ret = 0;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
@@ -4015,12 +4016,32 @@ static ssize_t pressure_write(struct ker
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
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1292,9 +1292,44 @@ int psi_show(struct seq_file *m, struct
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
@@ -1302,6 +1337,8 @@ struct psi_trigger *psi_trigger_create(s
 	bool privileged;
 	u32 window_us;
 
+	*need_rtpoll_worker = false;
+
 	if (static_branch_likely(&psi_disabled))
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -1362,26 +1399,14 @@ struct psi_trigger *psi_trigger_create(s
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
@@ -1541,6 +1566,8 @@ static ssize_t psi_write(struct file *fi
 	size_t buf_size;
 	struct seq_file *seq;
 	struct psi_trigger *new;
+	bool need_rtpoll_worker;
+	int ret;
 
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
@@ -1565,12 +1592,22 @@ static ssize_t psi_write(struct file *fi
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
 

