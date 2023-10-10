Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460D67BEF84
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379111AbjJJAKJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379138AbjJJAKG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:10:06 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D366A6
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 17:10:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696896601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UB8UCsgBBNwm/lYUhug39JXjgrJB25jOFlVEA0SwZ1w=;
        b=vYGiTYSof5OwIfp3SCsmVVAqIIOHV/2QRu9KSEpIse6pPitUQLPoDY3+768geHIe1OotqT
        gQVtl8qNLJ/m8/vVb6QjGtwGNF5Ng1ivDTPPJOXsC152HcMV8t2pO85z3+N7HypmzHOCBd
        PAkUbeSbCfQEs0F1f4lfujM5IDfCuz4=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 2/5] mm: kmem: add direct objcg pointer to task_struct
Date:   Mon,  9 Oct 2023 17:09:26 -0700
Message-ID: <20231010000929.450702-3-roman.gushchin@linux.dev>
In-Reply-To: <20231010000929.450702-1-roman.gushchin@linux.dev>
References: <20231010000929.450702-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
   significant bit of the objcg pointer is set atomically.

3) On the allocation path the objcg pointer is obtained locklessly
   using the READ_ONCE() macro and the least significant bit is
   checked. If it's set, the following procedure is used to update
   it locklessly:
       - task->objcg is zeroed using cmpxcg
       - new objcg pointer is obtained
       - task->objcg is updated using try_cmpxchg
       - operation is repeated if try_cmpxcg fails
   It guarantees that no updates will be lost if task migration
   is racing against objcg pointer update. It also allows to keep
   both read and write paths fully lockless.

Because the task is keeping a reference to the objcg, it can't go away
while the task is alive.

This commit doesn't change the way the remote memcg charging works.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/sched.h |   4 ++
 mm/memcontrol.c       | 130 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 125 insertions(+), 9 deletions(-)

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
index 16ac2a5838fb..a2efeea43058 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -249,6 +249,8 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
 
+#define CURRENT_OBJCG_UPDATE_FLAG 0x1UL
+
 #ifdef CONFIG_MEMCG_KMEM
 static DEFINE_SPINLOCK(objcg_lock);
 
@@ -3001,6 +3003,50 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 	return objcg;
 }
 
+static struct obj_cgroup *current_objcg_update(void)
+{
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *old, *objcg = NULL;
+
+	do {
+		/* Atomically drop the update bit. */
+		old = xchg(&current->objcg, NULL);
+		if (old) {
+			old = (struct obj_cgroup *)
+				((unsigned long)old & ~CURRENT_OBJCG_UPDATE_FLAG);
+			if (old)
+				obj_cgroup_put(old);
+
+			old = NULL;
+		}
+
+		/* Obtain the new objcg pointer. */
+		rcu_read_lock();
+		memcg = mem_cgroup_from_task(current);
+		/*
+		 * The current task can be asynchronously moved to another
+		 * memcg and the previous memcg can be offlined. So let's
+		 * get the memcg pointer and try get a reference to objcg
+		 * under a rcu read lock.
+		 */
+		for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+			objcg = rcu_dereference(memcg->objcg);
+			if (likely(objcg && obj_cgroup_tryget(objcg)))
+				break;
+			objcg = NULL;
+		}
+		rcu_read_unlock();
+
+		/*
+		 * Try set up a new objcg pointer atomically. If it
+		 * fails, it means the update flag was set concurrently, so
+		 * the whole procedure should be repeated.
+		 */
+	} while (!try_cmpxchg(&current->objcg, &old, objcg));
+
+	return objcg;
+}
+
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct mem_cgroup *memcg;
@@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 
 	if (in_task()) {
 		memcg = current->active_memcg;
+		if (unlikely(memcg))
+			goto from_memcg;
 
-		/* Memcg to charge can't be determined. */
-		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
-			return NULL;
+		objcg = READ_ONCE(current->objcg);
+		if (unlikely((unsigned long)objcg & CURRENT_OBJCG_UPDATE_FLAG))
+			objcg = current_objcg_update();
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
@@ -6345,6 +6398,7 @@ static void mem_cgroup_move_task(void)
 		mem_cgroup_clear_mc();
 	}
 }
+
 #else	/* !CONFIG_MMU */
 static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 {
@@ -6358,8 +6412,39 @@ static void mem_cgroup_move_task(void)
 }
 #endif
 
+#ifdef CONFIG_MEMCG_KMEM
+static void mem_cgroup_fork(struct task_struct *task)
+{
+	/*
+	 * Set the update flag to cause task->objcg to be initialized lazily
+	 * on the first allocation. It can be done without any synchronization
+	 * because it's always performed on the current task, so does
+	 * current_objcg_update().
+	 */
+	task->objcg = (struct obj_cgroup *)CURRENT_OBJCG_UPDATE_FLAG;
+}
+
+static void mem_cgroup_exit(struct task_struct *task)
+{
+	struct obj_cgroup *objcg = task->objcg;
+
+	objcg = (struct obj_cgroup *)
+		((unsigned long)objcg & ~CURRENT_OBJCG_UPDATE_FLAG);
+	if (objcg)
+		obj_cgroup_put(objcg);
+
+	/*
+	 * Some kernel allocations can happen after this point,
+	 * but let's ignore them. It can be done without any synchronization
+	 * because it's always performed on the current task, so does
+	 * current_objcg_update().
+	 */
+	task->objcg = NULL;
+}
+#endif
+
 #ifdef CONFIG_LRU_GEN
-static void mem_cgroup_attach(struct cgroup_taskset *tset)
+static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
@@ -6377,10 +6462,31 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
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
+	cgroup_taskset_for_each(task, css, tset) {
+		/* atomically set the update bit */
+		set_bit(0, (unsigned long *)&current->objcg);
+	}
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
@@ -6824,9 +6930,15 @@ struct cgroup_subsys memory_cgrp_subsys = {
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

