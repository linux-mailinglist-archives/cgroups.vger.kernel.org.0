Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99C652636
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiLTS2L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 13:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiLTS2I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 13:28:08 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8524CE07;
        Tue, 20 Dec 2022 10:28:06 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671560885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YesO5scRwOOin7uW7PZmPoS44XmivgS0ElHSpIPIVmE=;
        b=uj/7yvtKjoxajolPjtroGBuMqcW9xd/ppyLXn1op6xg0jwxNhV/i7tWBgzXE7hMxU7ZOg2
        5YnAteiyU3LPromj1Y2rl9NJzDsH3ZSZvNaCXoL5YyWtmpdEj5VNLkeKsdpOM0ZXg9BxQ1
        nwtLRs6SLSSxrFSJHvJFeux6PLl778Y=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH RFC 2/2] mm: kmem: add direct objcg pointer to task_struct
Date:   Tue, 20 Dec 2022 10:27:45 -0800
Message-Id: <20221220182745.1903540-3-roman.gushchin@linux.dev>
In-Reply-To: <20221220182745.1903540-1-roman.gushchin@linux.dev>
References: <20221220182745.1903540-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The old indirect way is still used for remote memcg charging.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/sched.h |  4 +++
 mm/memcontrol.c       | 84 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..e17be609cbcb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1435,6 +1435,10 @@ struct task_struct {
 	struct mem_cgroup		*active_memcg;
 #endif
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup		*objcg;
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 	struct request_queue		*throttle_queue;
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 82828c51d2ea..e0547b224f40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3001,23 +3001,29 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct mem_cgroup *memcg;
-	struct obj_cgroup *objcg;
+	struct obj_cgroup *objcg = NULL;
 
 	if (in_task()) {
 		memcg = current->active_memcg;
-
-		/* Memcg to charge can't be determined. */
-		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
-			return NULL;
+		if (unlikely(memcg))
+			goto from_memcg;
+
+		if (current->objcg) {
+			rcu_read_lock();
+			do {
+				objcg = READ_ONCE(current->objcg);
+			} while (objcg && !obj_cgroup_tryget(objcg));
+			rcu_read_unlock();
+		}
 	} else {
 		memcg = this_cpu_read(int_active_memcg);
-		if (likely(!memcg))
-			return NULL;
+		if (unlikely(memcg))
+			goto from_memcg;
 	}
+	return objcg;
 
+from_memcg:
 	rcu_read_lock();
-	if (!memcg)
-		memcg = mem_cgroup_from_task(current);
 	objcg = __get_obj_cgroup_from_memcg(memcg);
 	rcu_read_unlock();
 	return objcg;
@@ -6303,6 +6309,28 @@ static void mem_cgroup_move_task(void)
 		mem_cgroup_clear_mc();
 	}
 }
+
+#ifdef CONFIG_MEMCG_KMEM
+static void mem_cgroup_fork(struct task_struct *task)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(task);
+	if (!memcg || mem_cgroup_is_root(memcg))
+		task->objcg = NULL;
+	else
+		task->objcg = __get_obj_cgroup_from_memcg(memcg);
+	rcu_read_unlock();
+}
+
+static void mem_cgroup_exit(struct task_struct *task)
+{
+	if (task->objcg)
+		obj_cgroup_put(task->objcg);
+}
+#endif
+
 #else	/* !CONFIG_MMU */
 static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 {
@@ -6317,7 +6345,7 @@ static void mem_cgroup_move_task(void)
 #endif
 
 #ifdef CONFIG_LRU_GEN
-static void mem_cgroup_attach(struct cgroup_taskset *tset)
+static void mem_cgroup_lru_gen_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
@@ -6335,10 +6363,38 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
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
+		struct mem_cgroup *memcg;
+
+		if (task->objcg)
+			obj_cgroup_put(task->objcg);
+
+		rcu_read_lock();
+		memcg = container_of(css, struct mem_cgroup, css);
+		task->objcg = __get_obj_cgroup_from_memcg(memcg);
+		rcu_read_unlock();
+	}
+}
+#else
+static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset) {}
+#endif /* CONFIG_MEMCG_KMEM */
+
+#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEMCG_KMEM)
 static void mem_cgroup_attach(struct cgroup_taskset *tset)
 {
+	mem_cgroup_lru_gen_attach(tset);
+	mem_cgroup_kmem_attach(tset);
 }
-#endif /* CONFIG_LRU_GEN */
+#endif
 
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
 {
@@ -6816,9 +6872,15 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
 	.can_attach = mem_cgroup_can_attach,
+#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MEMCG_KMEM)
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
2.39.0

