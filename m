Return-Path: <cgroups+bounces-13332-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEU4L0u+b2kOMQAAu9opvQ
	(envelope-from <cgroups+bounces-13332-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 18:41:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1A48BDF
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD295A2BD41
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845434E75A;
	Tue, 20 Jan 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIpZmNkQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05934E774
	for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928952; cv=none; b=VkKI7B3i2JmekvplSnfIkt6K23EO5/kGeFtjRKU1GsqTfZcXfgBCfAHjzZIGEmiwHx8M/0sq+D+CVQWUDP0iGKkeLAIV3DMp0nGKf1LHuGb01g9GILDKLRggOET84EevxsU/aINoubNAeQy5KVuW6XGgKuvO1vnxBPSpYaZY71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928952; c=relaxed/simple;
	bh=kr7yBZlFs4v5mTRyHBuStMqJ7KcAT5LdX2UKtFW8lOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7qIHBzYBkzHUsSgyE598x9e1vsJ1oRKWMSKpBml8cKu1tfVjoNaPHyZLPbLQAz3w9d5LOQrMOfOcRy/XroM7PZvnv3TQs9ETBZDRpopsPS7iqFE/b5U70Qt7/HbhMrOuJzIH9Li5LKWobP0KCzeXhdIHz8U1ZnYmRKGcBsiA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIpZmNkQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b876c0d5318so755674766b.0
        for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768928948; x=1769533748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lty+/9ZQzucJOhyOUFJ57+6O2KRarMnOEKlOmEePGSU=;
        b=UIpZmNkQ5ltXdA+j+NziBU8Y2dW6hmR8sTryrTIYxDUvvpc1EWUrybQalWa1lOBOwW
         3/YmiSDV9TvUOdzLuOpcUKdwSDGVpjLBNfGmv/fYBjl99ivOO0XhbPJFK7XeJYhgkjhl
         21w/ly+rDgFAQb9AAGhUWa4MCB4BmRKAAw4FFtaJFaV3h7kUNvi3tY5k34e7S5NXh/lD
         RJm4PzjTNb6/yuYIGFmASdkiYWIfmSLF3qModa3DjUjAhaf2JmUALm7uOw9u2YoQOkH7
         neoYCgiBplNQU4+DTJW/g5fat7a2dC5EQVOK2V6b7WeYeuZm2eaBUTHOnUykOBLPJL4u
         PqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768928948; x=1769533748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lty+/9ZQzucJOhyOUFJ57+6O2KRarMnOEKlOmEePGSU=;
        b=g7syXfGfoxx6FLPvJ/McPARSMXnWkTFEgiL3FAUcNYsNfMeAbK3WcTNRGyPJEhK2R7
         8IpLg+mNJ6DWZ77AMnKJPvFLlNtVS7IXSoZeWoFPFtJgtLnJ5nhEzYJSujdbPmC/eluN
         AwRIWZY9r5nAlyXtKNp2WqG2TnJBVWyDJQTLg/2aX7CfSAzl9N+IiAuGasDdgZcAJcBc
         crGAPlg99TaiHSjQ99vBh+/XvXIZ/C6xtXBs/TI7TjfqvN75c66dKuoeI/92yEYZViT5
         mhDqNcGXndSG6OKbM/bEKMHL2hCcQP7Hn8g+kzp4n2tKR8GIWuSUbbkE86+nmTjPr2Bu
         NAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU075r6PR6ZbdniCDsDZj5lBegGjBgwzRsZMDmobK0tgVvrLDkrjahdVgKqUjY627R3Wklqjpm1@vger.kernel.org
X-Gm-Message-State: AOJu0YyDa/utgGyZ4wyplLEvxyzG+KEDw3Gu6Ix7ZdkYubbQYmjHAUzD
	/8AfhrQKUw+Qrkv1/FkFLRKvRZnOjK8dbRKU4JLJQz14nZmd1kHq9l+X
X-Gm-Gg: AY/fxX6E/k47kMikf4bF265R4QX8XoQjGIUcxI4HQRtSx26wvuWoNI9nzadNhk73gBy
	moAocET6sOJy7lOLPBJpWG4IkbjxGhFJdRTZwtF6rkZM69qgqQk5tFRUNUBobuWrrKb9DgFjNPA
	WB+ifw2oj3xQlp6CbOB/9WP+uJM/7e/hqkp0ctKRP/EVD3AmmSSXHSkHTnASy5scQ9sqQrPS5FQ
	0KEweA1z7KzZGaTGjfPkR9/Gt9X9Mm9GETN1Tdb+GXEu4kwHD/yLv+F30S1EFccaU9lLh2rtPRa
	z0ZrZtAs4+NY1TiJfydcSy5+FYXx4fQ10NH/ccqRE5tPcaiVPPWVY/FwZmKm3FAC7szz9kUwtDm
	2cPOI8yG3S1EZRwailnZES7q/txugPPMh5N7RhzxPgarbeBQXc9bKJk/gNkwlmC69lDDmcGmAaM
	dNxpRVPcTjGcjwep0kbC00CL65ubXS8qHpiZAUR2v0guyvpavmRp8gsCnfuLSClw==
X-Received: by 2002:a17:907:fdc1:b0:b87:4c74:b316 with SMTP id a640c23a62f3a-b8800364d26mr238859566b.50.1768928947973;
        Tue, 20 Jan 2026 09:09:07 -0800 (PST)
Received: from f.. (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9bc9sm1421895966b.33.2026.01.20.09.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:09:07 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Date: Tue, 20 Jan 2026 18:08:59 +0100
Message-ID: <20260120170859.1467868-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-13332-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5AB1A48BDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the stock kernel the css_set_lock is taken three times during thread
life cycle, turning it into the primary bottleneck in fork-heavy
workloads.

The acquire in perparation for clone can be avoided with a sequence
counter, which in turn pushes the lock down.

Accounts only for 6% speed up when creating threads in parallel on 20
cores as most of the contention shifts to pidmap_lock (from about 740k
ops/s to 790k ops/s).

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I don't really care for cgroups, I merely need the thing out of the way
for fork. If someone wants to handle this differently, I'm not going to
argue as long as the bottleneck is taken care of.

On the stock kernel pidmap_lock is still the biggest problem, but
there is a patch to fix it:
https://lore.kernel.org/linux-fsdevel/CAGudoHFuhbkJ+8iA92LYPmphBboJB7sxxC2L7A8OtBXA22UXzA@mail.gmail.com/T/#m832ac70f5e8f5ea14e69ca78459578d687efdd9f

.. afterwards it is cgroups and the commit message was written
pretending it already landed.

with the patch below contention is back on pidmap_lock

 kernel/cgroup/cgroup-internal.h | 11 ++++--
 kernel/cgroup/cgroup.c          | 60 ++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 16 deletions(-)

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
index 94788bd1fdf0..16d2a8d204e8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -87,7 +87,12 @@
  * cgroup.h can use them for lockdep annotations.
  */
 DEFINE_MUTEX(cgroup_mutex);
-DEFINE_SPINLOCK(css_set_lock);
+__cacheline_aligned DEFINE_SPINLOCK(css_set_lock);
+/*
+ * css_set_for_clone_seq is used to allow lockless operation in cgroup_css_set_fork()
+ */
+static __cacheline_aligned seqcount_spinlock_t css_set_for_clone_seq =
+	SEQCNT_SPINLOCK_ZERO(css_set_for_clone_seq, &css_set_lock);
 
 #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
 EXPORT_SYMBOL_GPL(cgroup_mutex);
@@ -907,6 +912,7 @@ static void css_set_skip_task_iters(struct css_set *cset,
  * @from_cset: css_set @task currently belongs to (may be NULL)
  * @to_cset: new css_set @task is being moved to (may be NULL)
  * @use_mg_tasks: move to @to_cset->mg_tasks instead of ->tasks
+ * @is_clone: indicator whether @task is amids clone
  *
  * Move @task from @from_cset to @to_cset.  If @task didn't belong to any
  * css_set, @from_cset can be NULL.  If @task is being disassociated
@@ -918,13 +924,16 @@ static void css_set_skip_task_iters(struct css_set *cset,
  */
 static void css_set_move_task(struct task_struct *task,
 			      struct css_set *from_cset, struct css_set *to_cset,
-			      bool use_mg_tasks)
+			      bool use_mg_tasks, bool is_clone)
 {
 	lockdep_assert_held(&css_set_lock);
 
 	if (to_cset && !css_set_populated(to_cset))
 		css_set_update_populated(to_cset, true);
 
+	if (!is_clone)
+		raw_write_seqcount_begin(&css_set_for_clone_seq);
+
 	if (from_cset) {
 		WARN_ON_ONCE(list_empty(&task->cg_list));
 
@@ -949,6 +958,9 @@ static void css_set_move_task(struct task_struct *task,
 		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
 							     &to_cset->tasks);
 	}
+
+	if (!is_clone)
+		raw_write_seqcount_end(&css_set_for_clone_seq);
 }
 
 /*
@@ -2723,7 +2735,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 
 			get_css_set(to_cset);
 			to_cset->nr_tasks++;
-			css_set_move_task(task, from_cset, to_cset, true);
+			css_set_move_task(task, from_cset, to_cset, true, false);
 			from_cset->nr_tasks--;
 			/*
 			 * If the source or destination cgroup is frozen,
@@ -4183,7 +4195,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
+	raw_write_seqcount_begin(&css_set_for_clone_seq);
 	cgrp->kill_seq++;
+	raw_write_seqcount_end(&css_set_for_clone_seq);
 	spin_unlock_irq(&css_set_lock);
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
@@ -6690,20 +6704,40 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct cgroup *dst_cgrp = NULL;
 	struct css_set *cset;
 	struct super_block *sb;
+	bool need_lock;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
 		cgroup_lock();
 
 	cgroup_threadgroup_change_begin(current);
 
-	spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
-	spin_unlock_irq(&css_set_lock);
+	need_lock = true;
+	scoped_guard(rcu) {
+		unsigned seq = raw_read_seqcount_begin(&css_set_for_clone_seq);
+		cset = task_css_set(current);
+		if (unlikely(!cset || !get_css_set_not_zero(cset)))
+			break;
+		if (kargs->cgrp)
+			kargs->kill_seq = kargs->cgrp->kill_seq;
+		else
+			kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+		if (read_seqcount_retry(&css_set_for_clone_seq, seq)) {
+			put_css_set(cset);
+			break;
+		}
+		need_lock = false;
+	}
+
+	if (unlikely(need_lock)) {
+		spin_lock_irq(&css_set_lock);
+		cset = task_css_set(current);
+		get_css_set(cset);
+		if (kargs->cgrp)
+			kargs->kill_seq = kargs->cgrp->kill_seq;
+		else
+			kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+		spin_unlock_irq(&css_set_lock);
+	}
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
 		kargs->cset = cset;
@@ -6907,7 +6941,7 @@ void cgroup_post_fork(struct task_struct *child,
 
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
-		css_set_move_task(child, NULL, cset, false);
+		css_set_move_task(child, NULL, cset, false, true);
 	} else {
 		put_css_set(cset);
 		cset = NULL;
@@ -6995,7 +7029,7 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
 
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset = task_css_set(tsk);
-	css_set_move_task(tsk, cset, NULL, false);
+	css_set_move_task(tsk, cset, NULL, false, false);
 	cset->nr_tasks--;
 	/* matches the signal->live check in css_task_iter_advance() */
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
-- 
2.48.1


