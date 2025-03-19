Return-Path: <cgroups+bounces-7178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA07A69A85
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BF64849DB
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 21:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377BB21B196;
	Wed, 19 Mar 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/SIRs7q"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4521ABD2
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418043; cv=none; b=JbvzQq553+IFbaMdHwu52G+gnl8Pe/ZKpgGWnwLlkANT/inrTQ9e63UDzOab9RkqS1mDioXizVQvbtCxQ5MPX/gXDCPrf+9UU3L9kmJduGABOyX6++aw2tTtYkOUQQmctiinkYqWxY3g6V4XcnNaWV03Q945inwuF/VrPJmwYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418043; c=relaxed/simple;
	bh=E6B8L5hq+OC8KU1bidQMlMlcpJemsjolhzSTKsieqoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goz12R47+UUlidoEguFu5S5ebaJIRevQnztNUSqAWnnU7gHVtIYJcsYTbduhW0qNqevpGFPamypMabUlRJa6ekK/11dWBUAbvDige9OLWQJVoeLvB3LKO27XVPLhqOwvP53F9Kd37thN41jGyz3Nqh9k/XW3d178bPUszxQWB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/SIRs7q; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742418028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2D5bEcAAgOlpJrINg/LQg7aCdYFRnTJufts8MX/QuDU=;
	b=e/SIRs7q4v+5jR/pyoL/DEk4mZgH5RnEbOEuSPWGewlQP9+zZ5UMjynfif2ozrp9817O0e
	eIIWDLjGvYLL/liiOGq+WFWIOt60Fs0+q4K2eOkC8ePRHr7UQCtClQ5XEni2oIzQYPvXgF
	uexX2XY6rH2tNrorDOcFeptw/YD6gXA=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Greg Thelen <gthelen@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH cgroup/for-6.15] cgroup: rstat: Cleanup flushing functions and locking
Date: Wed, 19 Mar 2025 21:00:13 +0000
Message-ID: <20250319210013.3572360-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that the rstat lock is being re-acquired on every CPU iteration in
cgroup_rstat_flush_locked(), having the initially acquire the lock is
unnecessary and unclear.

Inline cgroup_rstat_flush_locked() into cgroup_rstat_flush() and move
the lock/unlock calls to the beginning and ending of the loop body to
make the critical section obvious.

cgroup_rstat_flush_hold/release() do not make much sense with the lock
being dropped and reacquired internally. Since it has no external
callers, remove it and explicitly acquire the lock in
cgroup_base_stat_cputime_show() instead.

This leaves the code with a single flushing function,
cgroup_rstat_flush().

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---

Applies on top of Greg's commit 0efc297a3c497 ("cgroup/rstat: avoid
disabling irqs for O(num_cpu)").

---
 include/linux/cgroup.h |  2 --
 kernel/cgroup/rstat.c  | 79 +++++++++++-------------------------------
 2 files changed, 20 insertions(+), 61 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 8e7415c64ed1d..28e999f2c6421 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -690,8 +690,6 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_hold(struct cgroup *cgrp);
-void cgroup_rstat_flush_release(struct cgroup *cgrp);
 
 /*
  * Basic resource stats.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 2c1053e83945e..7831978a26bb9 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -299,17 +299,29 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
-/* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
-	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
+/**
+ * cgroup_rstat_flush - flush stats in @cgrp's subtree
+ * @cgrp: target cgroup
+ *
+ * Collect all per-cpu stats in @cgrp's subtree into the global counters
+ * and propagate them upwards.  After this function returns, all cgroups in
+ * the subtree have up-to-date ->stat.
+ *
+ * This also gets all cgroups in the subtree including @cgrp off the
+ * ->updated_children lists.
+ *
+ * This function may block.
+ */
+__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_lock);
-
+	might_sleep();
 	for_each_possible_cpu(cpu) {
 		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
 
+		/* Reacquire for each CPU to avoid disabling IRQs too long */
+		__cgroup_rstat_lock(cgrp, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
@@ -322,64 +334,12 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-
-		/* play nice and avoid disabling interrupts for a long time */
 		__cgroup_rstat_unlock(cgrp, cpu);
 		if (!cond_resched())
 			cpu_relax();
-		__cgroup_rstat_lock(cgrp, cpu);
 	}
 }
 
-/**
- * cgroup_rstat_flush - flush stats in @cgrp's subtree
- * @cgrp: target cgroup
- *
- * Collect all per-cpu stats in @cgrp's subtree into the global counters
- * and propagate them upwards.  After this function returns, all cgroups in
- * the subtree have up-to-date ->stat.
- *
- * This also gets all cgroups in the subtree including @cgrp off the
- * ->updated_children lists.
- *
- * This function may block.
- */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
-{
-	might_sleep();
-
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
-}
-
-/**
- * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
- * @cgrp: target cgroup
- *
- * Flush stats in @cgrp's subtree and prevent further flushes.  Must be
- * paired with cgroup_rstat_flush_release().
- *
- * This function may block.
- */
-void cgroup_rstat_flush_hold(struct cgroup *cgrp)
-	__acquires(&cgroup_rstat_lock)
-{
-	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-}
-
-/**
- * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
- * @cgrp: cgroup used by tracepoint
- */
-void cgroup_rstat_flush_release(struct cgroup *cgrp)
-	__releases(&cgroup_rstat_lock)
-{
-	__cgroup_rstat_unlock(cgrp, -1);
-}
-
 int cgroup_rstat_init(struct cgroup *cgrp)
 {
 	int cpu;
@@ -614,11 +574,12 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	struct cgroup_base_stat bstat;
 
 	if (cgroup_parent(cgrp)) {
-		cgroup_rstat_flush_hold(cgrp);
+		cgroup_rstat_flush(cgrp);
+		__cgroup_rstat_lock(cgrp, -1);
 		bstat = cgrp->bstat;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &bstat.cputime.utime, &bstat.cputime.stime);
-		cgroup_rstat_flush_release(cgrp);
+		__cgroup_rstat_unlock(cgrp, -1);
 	} else {
 		root_cgroup_cputime(&bstat);
 	}
-- 
2.49.0.395.g12beb8f557-goog


