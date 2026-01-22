Return-Path: <cgroups+bounces-13364-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMboEpwUcmksawAAu9opvQ
	(envelope-from <cgroups+bounces-13364-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 13:14:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E749667C1
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 13:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22A49726194
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFE363C73;
	Thu, 22 Jan 2026 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFY1axzh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D43587A6
	for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081402; cv=none; b=tYx3aRW5On1I9E8AGtYEbFAgcHmxlGQ517LzGQhmFZqkolpsZ9VUtpjvcVbmicutU9rf4gMgX+PQ8dRt6/Z5TOGHxPWCylMswMUlxmHb5LmcPUle3W1ZfooyWBH70g4eSbgKscqjS5IvAPK0KA4aM8oWqL6rzouJluS93/QzZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081402; c=relaxed/simple;
	bh=qozDHw7wapC2zbxdbRxoQOUIKZ8xEwI3GBzwZOHeJyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpLldm/QU4s5Ttw5gk9+mkrgmR9NzJx+NGWegoZEvqZLbwXSH4HfcWTymwjyJH2jsDw5VZi4KNnCh0OlYlMnKJHhz7FY9FYwbFdwFQ4C7c5Kyiou+PuZWDH8CFFp5cutoHHNYNVL1UY52GgTn2fK0xLWr8EzUjsGbxIUNXh4nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFY1axzh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48049955f7fso4965525e9.0
        for <cgroups@vger.kernel.org>; Thu, 22 Jan 2026 03:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769081399; x=1769686199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=msl8g7qpFfJ2L4P4DSDVKxyjAE79rEl7eo2VMGktQDE=;
        b=VFY1axzhHVJMdg22HMOKp0Dksei5ZaCmqYewfLIhJszlcF3krrGYNhW5p9/pltS7oK
         W8y+G6Q7Om87TZURpkqELpqdMTHJNbN92Bsa/q9nxjgwKeQY7gzERhwVbB56mXlF0Uqe
         GVrsMcvVyN3pPs15SEs0EYdTGmZFvn/sp46COComGXcqf7aPIkvGUcEQcU1D3sENXBC/
         PTaKA3iWIh3MZLg5Td1dTTtEUTefPn81YMD+RwSaH0H0Zvt38r4+m7uRV1XkX7IjfDg2
         1HEVsshp1e5DV44A1iN+0B9tE8Rz1VjLSGxLFAbRQQvkRcAfX0liwlf5GGNWMtbbhv6k
         YMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769081399; x=1769686199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msl8g7qpFfJ2L4P4DSDVKxyjAE79rEl7eo2VMGktQDE=;
        b=UJ2KLxk6C+UzWedHpQhm9Me85M15bWYMmKX0vZgsc0Op80nctC06ZU0qUbaClTYM1h
         ABfH2OoIqBZYrtb/nRBup3Kk7Kry3ZYnYQLD/Tk8EiEXLSiwTnJ1NBgJcl5JK/WoxyOJ
         IWZrRqAkP1Z1IojIXFGUuLlZ9dVOVWrW6y8msWQmY2v55fP4wr0vRHgCx1kHjk3SQjnw
         CqQ0trOPV40g/pl9TlNIGErlU4/RQkArReym0rS+Fz5gUjKdCoWLHvCLiIIaS1Ag8+tn
         SNeNo780kwHJg8tfGWRZ3B3Lc1EfINesJhDWEAqRQPl72E+T7PqCPzyDLUWLMLedLYA/
         9eYg==
X-Forwarded-Encrypted: i=1; AJvYcCUarTkJEAauf10rL8GvMJEHV9lPXBeyrl7tXFS4/zBFQd1Xt6fHirtC9F9q2yJM/LXHNgFHKBnR@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYaDnvCKxfIR9+lb5+MbdI+n1NukjzBMghfWfUcxpstsDzfYV
	tFrywCDggHzeprzqrqh8LyynzI/v1VoXBbQOdUtTa7PTX4LG/bSWxt75
X-Gm-Gg: AZuq6aKC8GnEpkeEnMijIHhJRleE56HS7oK+eKeGuLJSqt515N8QGmdHTycR0ZLWx65
	762m/krk85nMPShTWOrDJK2ydrBRH64shmQdsoHIJZGnkFnV7FeQAJ+GmHTfpvCqo4SUc41ppVI
	Y+PdTulVCbt3gq3XvsNPJ8KviXMwNRRjpT8LCf8DpArRrNkVBCGA08Q5hRnc7boMgutU2W8ygbi
	3yPRqHILPhqRxtpIY6nuQiINLH4etXdxZSRYb0t2NPpGpXZnUchTbWzX7TbTG6ptp2+mirID28a
	zKavhWoeBioJ3yg2oxeWR8vIMHn/Hy1DG9HAmB6780YaK7ch6GwTzslfgnhl+DM/tw6V21jlcmI
	b2Nh0Acz9p+Od7aCdJ2xDlYL0LeUdV/0kvc3IH8xTft2wKkTOrPfFHS9t7xo+iXnPvVx8NS+dOX
	mweedBdkwe5CO00eQR72IoCiuV4YaID1hNo8OKERYG8GX0wOlhhxC74bdGhq09JA==
X-Received: by 2002:a05:600c:1991:b0:47e:e4ff:e2ac with SMTP id 5b1f17b1804b1-4801e356cebmr286256845e9.33.1769081398409;
        Thu, 22 Jan 2026 03:29:58 -0800 (PST)
Received: from f.. (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804252b02dsm50748695e9.5.2026.01.22.03.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:29:57 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Date: Thu, 22 Jan 2026 12:29:51 +0100
Message-ID: <20260122112951.1854124-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13364-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E749667C1
X-Rspamd-Action: no action

In the stock kernel the css_set_lock is taken three times during thread
life cycle, turning it into the primary bottleneck in fork-heavy
workloads.

The acquire in perparation for clone can be avoided with a sequence
counter, which in turn pushes the lock down.

Accounts only for 6% speed up when creating threads in parallel on 20
cores as most of the contention shifts to pidmap_lock.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- change comment about clone_seq
- raw_write_seqcount* -> write_seqcount
- just loop on failed seq check
- don't bump it on task exit

 kernel/cgroup/cgroup-internal.h | 11 +++++--
 kernel/cgroup/cgroup.c          | 54 +++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 22051b4f1ccb..04a3aadcbc7f 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -194,6 +194,9 @@ static inline bool notify_on_release(const struct cgroup *cgrp)
 	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
 }
 
+/*
+ * refcounted get/put for css_set objects
+ */
 void put_css_set_locked(struct css_set *cset);
 
 static inline void put_css_set(struct css_set *cset)
@@ -213,14 +216,16 @@ static inline void put_css_set(struct css_set *cset)
 	spin_unlock_irqrestore(&css_set_lock, flags);
 }
 
-/*
- * refcounted get/put for css_set objects
- */
 static inline void get_css_set(struct css_set *cset)
 {
 	refcount_inc(&cset->refcount);
 }
 
+static inline bool get_css_set_not_zero(struct css_set *cset)
+{
+	return refcount_inc_not_zero(&cset->refcount);
+}
+
 bool cgroup_ssid_enabled(int ssid);
 bool cgroup_on_dfl(const struct cgroup *cgrp);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 94788bd1fdf0..0053582b9b56 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -87,7 +87,14 @@
  * cgroup.h can use them for lockdep annotations.
  */
 DEFINE_MUTEX(cgroup_mutex);
-DEFINE_SPINLOCK(css_set_lock);
+__cacheline_aligned DEFINE_SPINLOCK(css_set_lock);
+
+/*
+ * css_set_for_clone_seq synchronizes access to task_struct::cgroup
+ * and cgroup::kill_seq used on clone path
+ */
+static __cacheline_aligned seqcount_spinlock_t css_set_for_clone_seq =
+	SEQCNT_SPINLOCK_ZERO(css_set_for_clone_seq, &css_set_lock);
 
 #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
 EXPORT_SYMBOL_GPL(cgroup_mutex);
@@ -907,6 +914,7 @@ static void css_set_skip_task_iters(struct css_set *cset,
  * @from_cset: css_set @task currently belongs to (may be NULL)
  * @to_cset: new css_set @task is being moved to (may be NULL)
  * @use_mg_tasks: move to @to_cset->mg_tasks instead of ->tasks
+ * @skip_clone_seq: don't bump css_set_for_clone_seq
  *
  * Move @task from @from_cset to @to_cset.  If @task didn't belong to any
  * css_set, @from_cset can be NULL.  If @task is being disassociated
@@ -918,13 +926,16 @@ static void css_set_skip_task_iters(struct css_set *cset,
  */
 static void css_set_move_task(struct task_struct *task,
 			      struct css_set *from_cset, struct css_set *to_cset,
-			      bool use_mg_tasks)
+			      bool use_mg_tasks, bool skip_clone_seq)
 {
 	lockdep_assert_held(&css_set_lock);
 
 	if (to_cset && !css_set_populated(to_cset))
 		css_set_update_populated(to_cset, true);
 
+	if (!skip_clone_seq)
+		write_seqcount_begin(&css_set_for_clone_seq);
+
 	if (from_cset) {
 		WARN_ON_ONCE(list_empty(&task->cg_list));
 
@@ -949,6 +960,9 @@ static void css_set_move_task(struct task_struct *task,
 		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
 							     &to_cset->tasks);
 	}
+
+	if (!skip_clone_seq)
+		write_seqcount_end(&css_set_for_clone_seq);
 }
 
 /*
@@ -2723,7 +2737,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 
 			get_css_set(to_cset);
 			to_cset->nr_tasks++;
-			css_set_move_task(task, from_cset, to_cset, true);
+			css_set_move_task(task, from_cset, to_cset, true, false);
 			from_cset->nr_tasks--;
 			/*
 			 * If the source or destination cgroup is frozen,
@@ -4183,7 +4197,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
+	write_seqcount_begin(&css_set_for_clone_seq);
 	cgrp->kill_seq++;
+	write_seqcount_end(&css_set_for_clone_seq);
 	spin_unlock_irq(&css_set_lock);
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
@@ -6696,14 +6712,26 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 	cgroup_threadgroup_change_begin(current);
 
-	spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
-	spin_unlock_irq(&css_set_lock);
+	for (;;) {
+		unsigned seq = raw_read_seqcount_begin(&css_set_for_clone_seq);
+		bool got_ref = false;
+		rcu_read_lock();
+		cset = task_css_set(current);
+		if (kargs->cgrp)
+			kargs->kill_seq = kargs->cgrp->kill_seq;
+		else
+			kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+		if (get_css_set_not_zero(cset))
+			got_ref = true;
+		rcu_read_unlock();
+		if (unlikely(!got_ref || read_seqcount_retry(&css_set_for_clone_seq, seq))) {
+			if (got_ref)
+				put_css_set(cset);
+			cpu_relax();
+			continue;
+		}
+		break;
+	}
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
 		kargs->cset = cset;
@@ -6907,7 +6935,7 @@ void cgroup_post_fork(struct task_struct *child,
 
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
-		css_set_move_task(child, NULL, cset, false);
+		css_set_move_task(child, NULL, cset, false, true);
 	} else {
 		put_css_set(cset);
 		cset = NULL;
@@ -6995,7 +7023,7 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
 
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset = task_css_set(tsk);
-	css_set_move_task(tsk, cset, NULL, false);
+	css_set_move_task(tsk, cset, NULL, false, true);
 	cset->nr_tasks--;
 	/* matches the signal->live check in css_task_iter_advance() */
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
-- 
2.48.1


