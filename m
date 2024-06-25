Return-Path: <cgroups+bounces-3329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6406E915B5F
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9881C2175A
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE245979;
	Tue, 25 Jun 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8+KDAZP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C883AC0F
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277188; cv=none; b=s+lnMaPmLNrf/3xOMrnjZA5nOnavpbcB+Br4RtKcaJ7bLhJW+3S/rxdJgF0B5rXa6j7ZiWsRqxVBSBDjjlQIPdGy7fGiVisJTPdg98zy+NLIL+0tVAVZ82CPSjWAS3qKiu5mAJnCBV3pcVqpkXzK9tOJYII6aztYR4UPCaN7aCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277188; c=relaxed/simple;
	bh=X7/6qG8oE8wrz9JEGlev8I//DeA2kt2CoX++xGUF3lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/Q5gppI13wmFg7gtN/Ta8quBryH8sewpkcSjZzXJBD5WTpAuy+dsO2oZBOAUyourzdNXn5w+fJQro/VuLSbg+AVY/s0728kAhw06eAbhTQAbKjtG83G5Exem1briXvElXI2wMHGqp2UvxY2lb2uSr4PENoYyDR94HOj5bMY4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8+KDAZP; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDpuG7ZRLEX7/v6od4u5N3qPX9lXtC5VgDycpruJVCk=;
	b=m8+KDAZPBXlAxzuey8qbrsfLxOAcJ26BTSgsLqwb8PF3wE0mB/XAoZ0f8zjH/qfkiv9YU2
	QpNerO2d/+fK0XMGbpKDloXTC34+z0o4ohNH/pSLyRw/C/HsCR4F2/QiYTAlTujw4orXLN
	zxSDNGBTrTL2ylcvCaGz0tNPRfr3oS8=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 08/14] mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c
Date: Mon, 24 Jun 2024 17:59:00 -0700
Message-ID: <20240625005906.106920-9-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cgroup v1 supports a complicated OOM handling in userspace mechanism,
which is not supported by cgroup v2. Let's move the corresponding code
into memcontrol-v1.c.

Aside from mechanical code movement this patch introduces two new
functions: memcg1_oom_prepare() and memcg1_oom_finish().
Those are implementing cgroup v1-specific parts of the common memcg
OOM handling path.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 229 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/memcontrol-v1.h |   3 +-
 mm/memcontrol.c    | 216 +-----------------------------------------
 3 files changed, 231 insertions(+), 217 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index d7b5c4c14732..253d49d5fb12 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -110,7 +110,13 @@ struct mem_cgroup_event {
 	struct work_struct remove;
 };
 
-extern spinlock_t memcg_oom_lock;
+#ifdef CONFIG_LOCKDEP
+static struct lockdep_map memcg_oom_lock_dep_map = {
+	.name = "memcg_oom_lock",
+};
+#endif
+
+DEFINE_SPINLOCK(memcg_oom_lock);
 
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
@@ -1469,7 +1475,7 @@ static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
 	return 0;
 }
 
-void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
+static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *iter;
 
@@ -1959,6 +1965,225 @@ void memcg1_css_offline(struct mem_cgroup *memcg)
 	spin_unlock_irq(&memcg->event_list_lock);
 }
 
+/*
+ * Check OOM-Killer is already running under our hierarchy.
+ * If someone is running, return false.
+ */
+static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter, *failed = NULL;
+
+	spin_lock(&memcg_oom_lock);
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		if (iter->oom_lock) {
+			/*
+			 * this subtree of our hierarchy is already locked
+			 * so we cannot give a lock.
+			 */
+			failed = iter;
+			mem_cgroup_iter_break(memcg, iter);
+			break;
+		} else
+			iter->oom_lock = true;
+	}
+
+	if (failed) {
+		/*
+		 * OK, we failed to lock the whole subtree so we have
+		 * to clean up what we set up to the failing subtree
+		 */
+		for_each_mem_cgroup_tree(iter, memcg) {
+			if (iter == failed) {
+				mem_cgroup_iter_break(memcg, iter);
+				break;
+			}
+			iter->oom_lock = false;
+		}
+	} else
+		mutex_acquire(&memcg_oom_lock_dep_map, 0, 1, _RET_IP_);
+
+	spin_unlock(&memcg_oom_lock);
+
+	return !failed;
+}
+
+static void mem_cgroup_oom_unlock(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+
+	spin_lock(&memcg_oom_lock);
+	mutex_release(&memcg_oom_lock_dep_map, _RET_IP_);
+	for_each_mem_cgroup_tree(iter, memcg)
+		iter->oom_lock = false;
+	spin_unlock(&memcg_oom_lock);
+}
+
+static void mem_cgroup_mark_under_oom(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+
+	spin_lock(&memcg_oom_lock);
+	for_each_mem_cgroup_tree(iter, memcg)
+		iter->under_oom++;
+	spin_unlock(&memcg_oom_lock);
+}
+
+static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+
+	/*
+	 * Be careful about under_oom underflows because a child memcg
+	 * could have been added after mem_cgroup_mark_under_oom.
+	 */
+	spin_lock(&memcg_oom_lock);
+	for_each_mem_cgroup_tree(iter, memcg)
+		if (iter->under_oom > 0)
+			iter->under_oom--;
+	spin_unlock(&memcg_oom_lock);
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(memcg_oom_waitq);
+
+struct oom_wait_info {
+	struct mem_cgroup *memcg;
+	wait_queue_entry_t	wait;
+};
+
+static int memcg_oom_wake_function(wait_queue_entry_t *wait,
+	unsigned mode, int sync, void *arg)
+{
+	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
+	struct mem_cgroup *oom_wait_memcg;
+	struct oom_wait_info *oom_wait_info;
+
+	oom_wait_info = container_of(wait, struct oom_wait_info, wait);
+	oom_wait_memcg = oom_wait_info->memcg;
+
+	if (!mem_cgroup_is_descendant(wake_memcg, oom_wait_memcg) &&
+	    !mem_cgroup_is_descendant(oom_wait_memcg, wake_memcg))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, arg);
+}
+
+void memcg_oom_recover(struct mem_cgroup *memcg)
+{
+	/*
+	 * For the following lockless ->under_oom test, the only required
+	 * guarantee is that it must see the state asserted by an OOM when
+	 * this function is called as a result of userland actions
+	 * triggered by the notification of the OOM.  This is trivially
+	 * achieved by invoking mem_cgroup_mark_under_oom() before
+	 * triggering notification.
+	 */
+	if (memcg && memcg->under_oom)
+		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
+}
+
+/**
+ * mem_cgroup_oom_synchronize - complete memcg OOM handling
+ * @handle: actually kill/wait or just clean up the OOM state
+ *
+ * This has to be called at the end of a page fault if the memcg OOM
+ * handler was enabled.
+ *
+ * Memcg supports userspace OOM handling where failed allocations must
+ * sleep on a waitqueue until the userspace task resolves the
+ * situation.  Sleeping directly in the charge context with all kinds
+ * of locks held is not a good idea, instead we remember an OOM state
+ * in the task and mem_cgroup_oom_synchronize() has to be called at
+ * the end of the page fault to complete the OOM handling.
+ *
+ * Returns %true if an ongoing memcg OOM situation was detected and
+ * completed, %false otherwise.
+ */
+bool mem_cgroup_oom_synchronize(bool handle)
+{
+	struct mem_cgroup *memcg = current->memcg_in_oom;
+	struct oom_wait_info owait;
+	bool locked;
+
+	/* OOM is global, do not handle */
+	if (!memcg)
+		return false;
+
+	if (!handle)
+		goto cleanup;
+
+	owait.memcg = memcg;
+	owait.wait.flags = 0;
+	owait.wait.func = memcg_oom_wake_function;
+	owait.wait.private = current;
+	INIT_LIST_HEAD(&owait.wait.entry);
+
+	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
+	mem_cgroup_mark_under_oom(memcg);
+
+	locked = mem_cgroup_oom_trylock(memcg);
+
+	if (locked)
+		mem_cgroup_oom_notify(memcg);
+
+	schedule();
+	mem_cgroup_unmark_under_oom(memcg);
+	finish_wait(&memcg_oom_waitq, &owait.wait);
+
+	if (locked)
+		mem_cgroup_oom_unlock(memcg);
+cleanup:
+	current->memcg_in_oom = NULL;
+	css_put(&memcg->css);
+	return true;
+}
+
+
+bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked)
+{
+	/*
+	 * We are in the middle of the charge context here, so we
+	 * don't want to block when potentially sitting on a callstack
+	 * that holds all kinds of filesystem and mm locks.
+	 *
+	 * cgroup1 allows disabling the OOM killer and waiting for outside
+	 * handling until the charge can succeed; remember the context and put
+	 * the task to sleep at the end of the page fault when all locks are
+	 * released.
+	 *
+	 * On the other hand, in-kernel OOM killer allows for an async victim
+	 * memory reclaim (oom_reaper) and that means that we are not solely
+	 * relying on the oom victim to make a forward progress and we can
+	 * invoke the oom killer here.
+	 *
+	 * Please note that mem_cgroup_out_of_memory might fail to find a
+	 * victim and then we have to bail out from the charge path.
+	 */
+	if (READ_ONCE(memcg->oom_kill_disable)) {
+		if (current->in_user_fault) {
+			css_get(&memcg->css);
+			current->memcg_in_oom = memcg;
+		}
+		return false;
+	}
+
+	mem_cgroup_mark_under_oom(memcg);
+
+	*locked = mem_cgroup_oom_trylock(memcg);
+
+	if (*locked)
+		mem_cgroup_oom_notify(memcg);
+
+	mem_cgroup_unmark_under_oom(memcg);
+
+	return true;
+}
+
+void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked)
+{
+	if (locked)
+		mem_cgroup_oom_unlock(memcg);
+}
+
 static int __init memcg1_init(void)
 {
 	int node;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index ef1b7037cbdc..3de956b2422f 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -87,9 +87,10 @@ enum res_type {
 bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				enum mem_cgroup_events_target target);
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
-void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
 ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 				  char *buf, size_t nbytes, loff_t off);
 
+bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
+void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 
 #endif	/* __MM_MEMCONTROL_V1_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 92fb72bbd494..8abd364ac837 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1616,130 +1616,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return ret;
 }
 
-#ifdef CONFIG_LOCKDEP
-static struct lockdep_map memcg_oom_lock_dep_map = {
-	.name = "memcg_oom_lock",
-};
-#endif
-
-DEFINE_SPINLOCK(memcg_oom_lock);
-
-/*
- * Check OOM-Killer is already running under our hierarchy.
- * If someone is running, return false.
- */
-static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter, *failed = NULL;
-
-	spin_lock(&memcg_oom_lock);
-
-	for_each_mem_cgroup_tree(iter, memcg) {
-		if (iter->oom_lock) {
-			/*
-			 * this subtree of our hierarchy is already locked
-			 * so we cannot give a lock.
-			 */
-			failed = iter;
-			mem_cgroup_iter_break(memcg, iter);
-			break;
-		} else
-			iter->oom_lock = true;
-	}
-
-	if (failed) {
-		/*
-		 * OK, we failed to lock the whole subtree so we have
-		 * to clean up what we set up to the failing subtree
-		 */
-		for_each_mem_cgroup_tree(iter, memcg) {
-			if (iter == failed) {
-				mem_cgroup_iter_break(memcg, iter);
-				break;
-			}
-			iter->oom_lock = false;
-		}
-	} else
-		mutex_acquire(&memcg_oom_lock_dep_map, 0, 1, _RET_IP_);
-
-	spin_unlock(&memcg_oom_lock);
-
-	return !failed;
-}
-
-static void mem_cgroup_oom_unlock(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter;
-
-	spin_lock(&memcg_oom_lock);
-	mutex_release(&memcg_oom_lock_dep_map, _RET_IP_);
-	for_each_mem_cgroup_tree(iter, memcg)
-		iter->oom_lock = false;
-	spin_unlock(&memcg_oom_lock);
-}
-
-static void mem_cgroup_mark_under_oom(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter;
-
-	spin_lock(&memcg_oom_lock);
-	for_each_mem_cgroup_tree(iter, memcg)
-		iter->under_oom++;
-	spin_unlock(&memcg_oom_lock);
-}
-
-static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup *iter;
-
-	/*
-	 * Be careful about under_oom underflows because a child memcg
-	 * could have been added after mem_cgroup_mark_under_oom.
-	 */
-	spin_lock(&memcg_oom_lock);
-	for_each_mem_cgroup_tree(iter, memcg)
-		if (iter->under_oom > 0)
-			iter->under_oom--;
-	spin_unlock(&memcg_oom_lock);
-}
-
-static DECLARE_WAIT_QUEUE_HEAD(memcg_oom_waitq);
-
-struct oom_wait_info {
-	struct mem_cgroup *memcg;
-	wait_queue_entry_t	wait;
-};
-
-static int memcg_oom_wake_function(wait_queue_entry_t *wait,
-	unsigned mode, int sync, void *arg)
-{
-	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
-	struct mem_cgroup *oom_wait_memcg;
-	struct oom_wait_info *oom_wait_info;
-
-	oom_wait_info = container_of(wait, struct oom_wait_info, wait);
-	oom_wait_memcg = oom_wait_info->memcg;
-
-	if (!mem_cgroup_is_descendant(wake_memcg, oom_wait_memcg) &&
-	    !mem_cgroup_is_descendant(oom_wait_memcg, wake_memcg))
-		return 0;
-	return autoremove_wake_function(wait, mode, sync, arg);
-}
-
-void memcg_oom_recover(struct mem_cgroup *memcg)
-{
-	/*
-	 * For the following lockless ->under_oom test, the only required
-	 * guarantee is that it must see the state asserted by an OOM when
-	 * this function is called as a result of userland actions
-	 * triggered by the notification of the OOM.  This is trivially
-	 * achieved by invoking mem_cgroup_mark_under_oom() before
-	 * triggering notification.
-	 */
-	if (memcg && memcg->under_oom)
-		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
-}
-
 /*
  * Returns true if successfully killed one or more processes. Though in some
  * corner cases it can return true even without killing any process.
@@ -1753,104 +1629,16 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 
 	memcg_memory_event(memcg, MEMCG_OOM);
 
-	/*
-	 * We are in the middle of the charge context here, so we
-	 * don't want to block when potentially sitting on a callstack
-	 * that holds all kinds of filesystem and mm locks.
-	 *
-	 * cgroup1 allows disabling the OOM killer and waiting for outside
-	 * handling until the charge can succeed; remember the context and put
-	 * the task to sleep at the end of the page fault when all locks are
-	 * released.
-	 *
-	 * On the other hand, in-kernel OOM killer allows for an async victim
-	 * memory reclaim (oom_reaper) and that means that we are not solely
-	 * relying on the oom victim to make a forward progress and we can
-	 * invoke the oom killer here.
-	 *
-	 * Please note that mem_cgroup_out_of_memory might fail to find a
-	 * victim and then we have to bail out from the charge path.
-	 */
-	if (READ_ONCE(memcg->oom_kill_disable)) {
-		if (current->in_user_fault) {
-			css_get(&memcg->css);
-			current->memcg_in_oom = memcg;
-		}
+	if (!memcg1_oom_prepare(memcg, &locked))
 		return false;
-	}
-
-	mem_cgroup_mark_under_oom(memcg);
 
-	locked = mem_cgroup_oom_trylock(memcg);
-
-	if (locked)
-		mem_cgroup_oom_notify(memcg);
-
-	mem_cgroup_unmark_under_oom(memcg);
 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
 
-	if (locked)
-		mem_cgroup_oom_unlock(memcg);
+	memcg1_oom_finish(memcg, locked);
 
 	return ret;
 }
 
-/**
- * mem_cgroup_oom_synchronize - complete memcg OOM handling
- * @handle: actually kill/wait or just clean up the OOM state
- *
- * This has to be called at the end of a page fault if the memcg OOM
- * handler was enabled.
- *
- * Memcg supports userspace OOM handling where failed allocations must
- * sleep on a waitqueue until the userspace task resolves the
- * situation.  Sleeping directly in the charge context with all kinds
- * of locks held is not a good idea, instead we remember an OOM state
- * in the task and mem_cgroup_oom_synchronize() has to be called at
- * the end of the page fault to complete the OOM handling.
- *
- * Returns %true if an ongoing memcg OOM situation was detected and
- * completed, %false otherwise.
- */
-bool mem_cgroup_oom_synchronize(bool handle)
-{
-	struct mem_cgroup *memcg = current->memcg_in_oom;
-	struct oom_wait_info owait;
-	bool locked;
-
-	/* OOM is global, do not handle */
-	if (!memcg)
-		return false;
-
-	if (!handle)
-		goto cleanup;
-
-	owait.memcg = memcg;
-	owait.wait.flags = 0;
-	owait.wait.func = memcg_oom_wake_function;
-	owait.wait.private = current;
-	INIT_LIST_HEAD(&owait.wait.entry);
-
-	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
-	mem_cgroup_mark_under_oom(memcg);
-
-	locked = mem_cgroup_oom_trylock(memcg);
-
-	if (locked)
-		mem_cgroup_oom_notify(memcg);
-
-	schedule();
-	mem_cgroup_unmark_under_oom(memcg);
-	finish_wait(&memcg_oom_waitq, &owait.wait);
-
-	if (locked)
-		mem_cgroup_oom_unlock(memcg);
-cleanup:
-	current->memcg_in_oom = NULL;
-	css_put(&memcg->css);
-	return true;
-}
-
 /**
  * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
  * @victim: task to be killed by the OOM killer
-- 
2.45.2


