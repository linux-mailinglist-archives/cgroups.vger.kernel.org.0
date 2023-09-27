Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0847B07B2
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjI0PJB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjI0PJA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 11:09:00 -0400
Received: from out-193.mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87BA12A
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 08:08:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695827337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rcjc8iZxDm0DIYnvNFEg9AlvdD1o0gQiWksXrzSEaP4=;
        b=UsUhkDMLWoqWyU+5nbHGAFCVQZ5r2vg+XsHsShhnKPKLyiziXVyVxR9lcV7QyDWCZsJ8KL
        7K/IZURrLDyBSSujwFVKE2aqWxPUYANqDoYmQ7nFA92KgzQTpifzj6n13nvCNmo4/FEFGw
        NyMkSUQBXz32JTg1sqlghlRIHfkR4f8=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 2/5] mm: kmem: add direct objcg pointer to task_struct
Date:   Wed, 27 Sep 2023 08:08:29 -0700
Message-ID: <20230927150832.335132-3-roman.gushchin@linux.dev>
In-Reply-To: <20230927150832.335132-1-roman.gushchin@linux.dev>
References: <20230927150832.335132-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To charge a freshly allocated kernel object to a memory cgroup, the
kernel needs to obtain an objcg pointer. Currently it does it
indirectly by obtaining the memcg pointer first and then calling to
__get_obj_cgroup_from_memcg().

Usually tasks spend their entire life belonging to the same object
cgroup. So it makes sense to save the objcg pointer on task_struct
directly, so it can be obtained faster. It requires some work on fork,
exit and cgroup migrate paths, but these paths are way colder.

To avoid any costly synchronization the following rules are applied:
1) A task sets it's objcg pointer itself.

2) If a task is being migrated to another cgroup, the least
   significant bit of the objcg pointer is set.

3) On the allocation path the objcg pointer is obtained locklessly
   using the READ_ONCE() macro and the least significant bit is
   checked. If it set, the task updates it's objcg before proceeding
   with an allocation.

4) Operations 1) and 4) are synchronized via a new spinlock, so that
   if a task is moved twice, the update bit can't be lost.

This allows to keep the hot path fully lockless. Because the task
is keeping a reference to the objcg, it can't go away while the task
is alive.

This commit doesn't change the way the remote memcg charging works.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  10 ++++
 include/linux/sched.h      |   4 ++
 mm/memcontrol.c            | 107 +++++++++++++++++++++++++++++++++----
 3 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab94ad4597d0..84425bfe4124 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -553,6 +553,16 @@ static inline bool folio_memcg_kmem(struct folio *folio)
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
+static inline bool current_objcg_needs_update(struct obj_cgroup *objcg)
+{
+	return (struct obj_cgroup *)((unsigned long)objcg & 0x1);
+}
+
+static inline struct obj_cgroup *
+current_objcg_clear_update_flag(struct obj_cgroup *objcg)
+{
+	return (struct obj_cgroup *)((unsigned long)objcg & ~0x1);
+}
 
 #else
 static inline bool folio_memcg_kmem(struct folio *folio)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..60de42715b56 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1443,6 +1443,10 @@ struct task_struct {
 	struct mem_cgroup		*active_memcg;
 #endif
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup		*objcg;
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 	struct gendisk			*throttle_disk;
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 16ac2a5838fb..7f33a503d600 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3001,6 +3001,47 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 	return objcg;
 }
 
+static DEFINE_SPINLOCK(current_objcg_lock);
+
+static struct obj_cgroup *current_objcg_update(struct obj_cgroup *old)
+{
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
+	unsigned long flags;
+
+	old = current_objcg_clear_update_flag(old);
+	if (old)
+		obj_cgroup_put(old);
+
+	spin_lock_irqsave(&current_objcg_lock, flags);
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+		objcg = NULL;
+	}
+	rcu_read_unlock();
+
+	WRITE_ONCE(current->objcg, objcg);
+	spin_unlock_irqrestore(&current_objcg_lock, flags);
+
+	return objcg;
+}
+
+static inline void current_objcg_set_needs_update(struct task_struct *task)
+{
+	struct obj_cgroup *objcg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&current_objcg_lock, flags);
+	objcg = READ_ONCE(task->objcg);
+	objcg = (struct obj_cgroup *)((unsigned long)objcg | 0x1);
+	WRITE_ONCE(task->objcg, objcg);
+	spin_unlock_irqrestore(&current_objcg_lock, flags);
+}
+
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct mem_cgroup *memcg;
@@ -3008,19 +3049,26 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 
 	if (in_task()) {
 		memcg = current->active_memcg;
+		if (unlikely(memcg))
+			goto from_memcg;
 
-		/* Memcg to charge can't be determined. */
-		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
-			return NULL;
+		objcg = READ_ONCE(current->objcg);
+		if (unlikely(current_objcg_needs_update(objcg)))
+			objcg = current_objcg_update(objcg);
+
+		if (objcg) {
+			obj_cgroup_get(objcg);
+			return objcg;
+		}
 	} else {
 		memcg = this_cpu_read(int_active_memcg);
-		if (likely(!memcg))
-			return NULL;
+		if (unlikely(memcg))
+			goto from_memcg;
 	}
+	return NULL;
 
+from_memcg:
 	rcu_read_lock();
-	if (!memcg)
-		memcg = mem_cgroup_from_task(current);
 	objcg = __get_obj_cgroup_from_memcg(memcg);
 	rcu_read_unlock();
 	return objcg;
@@ -6345,6 +6393,22 @@ static void mem_cgroup_move_task(void)
 		mem_cgroup_clear_mc();
 	}
 }
+
+#ifdef CONFIG_MEMCG_KMEM
+static void mem_cgroup_fork(struct task_struct *task)
+{
+	task->objcg = (struct obj_cgroup *)0x1;
+}
+
+static void mem_cgroup_exit(struct task_struct *task)
+{
+	struct obj_cgroup *objcg = current_objcg_clear_update_flag(task->objcg);
+
+	if (objcg)
+		obj_cgroup_put(objcg);
+}
+#endif
+
 #else	/* !CONFIG_MMU */
 static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 {
@@ -6359,7 +6423,7 @@ static void mem_cgroup_move_task(void)
 #endif
 
 #ifdef CONFIG_LRU_GEN
-static void mem_cgroup_attach(struct cgroup_taskset *tset)
+static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
@@ -6377,10 +6441,29 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
 	task_unlock(task);
 }
 #else
+static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset) {}
+#endif /* CONFIG_LRU_GEN */
+
+#ifdef CONFIG_MEMCG_KMEM
+static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
+{
+	struct task_struct *task;
+	struct cgroup_subsys_state *css;
+
+	cgroup_taskset_for_each(task, css, tset)
+		current_objcg_set_needs_update(task);
+}
+#else
+static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset) {}
+#endif /* CONFIG_MEMCG_KMEM */
+
+#if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 static void mem_cgroup_attach(struct cgroup_taskset *tset)
 {
+	mem_cgroup_lru_gen_attach(tset);
+	mem_cgroup_kmem_attach(tset);
 }
-#endif /* CONFIG_LRU_GEN */
+#endif
 
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
 {
@@ -6824,9 +6907,15 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
 	.can_attach = mem_cgroup_can_attach,
+#if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
+#endif
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
+#ifdef CONFIG_MEMCG_KMEM
+	.fork = mem_cgroup_fork,
+	.exit = mem_cgroup_exit,
+#endif
 	.dfl_cftypes = memory_files,
 	.legacy_cftypes = mem_cgroup_legacy_files,
 	.early_init = 0,
-- 
2.42.0

