Return-Path: <cgroups+bounces-5328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54419B5DF6
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 09:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A25EB219C5
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905DE1E1C29;
	Wed, 30 Oct 2024 08:33:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AA1E0E0E;
	Wed, 30 Oct 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277227; cv=none; b=gbF3qUizDX25b10FuGrXTOH1ZNyIXKRxFViz/dMjUcGLcj9NakgO9D7Y9AA4ebyLXfQc8K5+w4RC0yoAm9wqeXyeMFxf9YzbL2TzmyEgAAXJPbUBMycImnKV5UedS232mv/KNFdB2PW4w6rwC+rJ+7snNhXzF2Pbj2ozM/g0EHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277227; c=relaxed/simple;
	bh=ZwYlA8wjYksRut5A2NARwGJBHxFeD34uTT4ncvmLdEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2nTkGuKTEmozTfgEE9oV8nBngZ0wabEMLZ5j3sJR3Omjq0irqrfqc/2SC6j+RuU90wc/PCacHtXrauT+yU5y24q2LAutOA7iktHdgNh+7iYk+FdSadu1Y7SSC8EvnlFX14XZWjepItpkJd0sA4aGg7wRfM4PoEcd/ueRBuh8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdgNR2dfdz6D95c;
	Wed, 30 Oct 2024 16:32:23 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id ED54F140C72;
	Wed, 30 Oct 2024 16:33:40 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 11:33:40 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stepanov.anatoly@huawei.com>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>
Subject: [RFC PATCH 2/3] mm: Support for huge pages in cgroups
Date: Wed, 30 Oct 2024 16:33:10 +0800
Message-ID: <20241030083311.965933-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

This patch adds support for the correct order mask depending on the memory THP
policy. Also, khugepaged lazy collpasing and kernel boot parameter THP override
were added.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Reviewed-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>

---
 include/linux/huge_mm.h    |  10 ++-
 include/linux/khugepaged.h |   2 +-
 include/linux/memcontrol.h |  11 +++
 mm/huge_memory.c           |  22 ++++--
 mm/khugepaged.c            |   8 +-
 mm/memcontrol.c            | 147 ++++++++++++++++++++++++++++++++++++-
 6 files changed, 187 insertions(+), 13 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 86c0fb4c0b28..f99ac9b7e5bc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -207,6 +207,12 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+bool memcg_thp_vma_allowable_orders(struct vm_area_struct *vma,
+				unsigned long vm_flags,
+				unsigned long *res_mask);
+#endif
+
 static inline bool file_thp_enabled(struct vm_area_struct *vma)
 {
 	struct inode *inode;
@@ -255,7 +261,9 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 		if (hugepage_global_always() ||
 		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
 			mask |= READ_ONCE(huge_anon_orders_inherit);
-
+#if defined(CONFIG_MEMCG) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+		memcg_thp_vma_allowable_orders(vma, vm_flags, &mask);
+#endif
 		orders &= mask;
 		if (!orders)
 			return 0;
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index f68865e19b0b..50cabca48b93 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -9,7 +9,7 @@ extern struct attribute_group khugepaged_attr_group;
 
 extern int khugepaged_init(void);
 extern void khugepaged_destroy(void);
-extern int start_stop_khugepaged(void);
+extern int start_stop_khugepaged(bool force_stop);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma(struct vm_area_struct *vma,
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b5fe93e19d..d78318782af8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -23,6 +23,7 @@
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
 #include <linux/shrinker.h>
+#include <linux/khugepaged.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -1069,6 +1070,9 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
+bool memcg_thp_vma_allowable_orders(struct vm_area_struct *vma,
+				unsigned long vm_flags,
+				unsigned long *res_mask);
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1476,6 +1480,13 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
+
+static inline bool memcg_thp_vma_allowable_orders(struct vm_area_struct *vma,
+				unsigned long vm_flags,
+				unsigned long *res_mask)
+{
+	return false;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0fbdd8213443..fdffdfc8605c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -172,15 +172,23 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	}
 
 	if (!vma_is_anonymous(vma)) {
+		bool memcg_enabled = false;
 		/*
 		 * Enforce sysfs THP requirements as necessary. Anonymous vmas
 		 * were already handled in thp_vma_allowable_orders().
 		 */
-		if (enforce_sysfs &&
-		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
-						    !hugepage_global_always())))
-			return 0;
+		if (enforce_sysfs) {
+			unsigned long mask = 0UL;
+
+			memcg_enabled = memcg_thp_vma_allowable_orders(vma, vm_flags, &mask);
 
+			if (memcg_enabled && !mask)
+				return 0;
+			if (!memcg_enabled && (!hugepage_global_enabled() ||
+									(!(vm_flags & VM_HUGEPAGE) &&
+									!hugepage_global_always())))
+				return 0;
+		}
 		/*
 		 * Trust that ->huge_fault() handlers know what they are doing
 		 * in fault path.
@@ -343,7 +351,7 @@ static ssize_t enabled_store(struct kobject *kobj,
 		err = mem_cgroup_thp_flags_update_all(transparent_hugepage_flags,
 							HUGEPAGE_FLAGS_ENABLED_MASK);
 	else
-		err = start_stop_khugepaged();
+		err = start_stop_khugepaged(false);
 
 	if (err)
 		ret = err;
@@ -539,7 +547,7 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
 	if (ret > 0) {
 		int err;
 
-		err = start_stop_khugepaged();
+		err = start_stop_khugepaged(false);
 		if (err)
 			ret = err;
 	}
@@ -812,7 +820,7 @@ static int __init hugepage_init(void)
 		return 0;
 	}
 
-	err = start_stop_khugepaged();
+	err = start_stop_khugepaged(false);
 	if (err)
 		goto err_khugepaged;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76..ebed9bf8cfb5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -415,6 +415,8 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 
 static bool hugepage_pmd_enabled(void)
 {
+	if (IS_ENABLED(CONFIG_MEMCG) && !mem_cgroup_disabled())
+		return true;
 	/*
 	 * We cover both the anon and the file-backed case here; file-backed
 	 * hugepages, when configured in, are determined by the global control.
@@ -2586,7 +2588,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!hugepage_pmd_enabled()) {
+	if (!hugepage_pmd_enabled() || !khugepaged_thread) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2631,12 +2633,12 @@ static void set_recommended_min_free_kbytes(void)
 	setup_per_zone_wmarks();
 }
 
-int start_stop_khugepaged(void)
+int start_stop_khugepaged(bool force_stop)
 {
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled()) {
+	if (hugepage_pmd_enabled() && !force_stop) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2b25c45c85c3..938e6894c0b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -981,6 +981,37 @@ static inline bool memcg_thp_madvise_enabled(struct mem_cgroup *memcg)
 	return test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &memcg->thp_flags);
 }
 
+bool memcg_thp_vma_allowable_orders(struct vm_area_struct *vma,
+				unsigned long vm_flags,
+				unsigned long *res_mask)
+{
+	unsigned long mask = 0UL;
+
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+
+	if (!memcg)
+		return false;
+
+	if (memcg_thp_always_enabled(memcg) ||
+								 ((vm_flags & VM_HUGEPAGE) &&
+								 memcg_thp_madvise_enabled(memcg))) {
+		if (!vma_is_anonymous(vma))
+			mask = THP_ORDERS_ALL_FILE_DEFAULT;
+		else {
+			mask = READ_ONCE(memcg->thp_anon_orders_always);
+
+			if (vm_flags & VM_HUGEPAGE)
+				mask |= READ_ONCE(memcg->thp_anon_orders_madvise);
+
+			mask = mask | READ_ONCE(memcg->thp_anon_orders_inherit);
+		}
+	}
+
+	css_put(&memcg->css);
+	*res_mask = mask;
+	return true;
+}
+
 unsigned long memcg_get_thp_flags(struct vm_area_struct *vma)
 {
 	unsigned long flags = 0UL;
@@ -3986,10 +4017,52 @@ static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
 	}
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int mem_cgroup_notify_khugepaged_cb(struct task_struct *p, void *arg)
+{
+	struct vm_area_struct *vma = NULL;
+	struct mem_cgroup *memcg = arg;
+	bool is_madvise = memcg_thp_madvise_enabled(memcg);
+	bool is_always = memcg_thp_always_enabled(memcg);
+
+	VMA_ITERATOR(vmi, p->mm, 0);
+
+	if (!is_always && !is_madvise) {
+		khugepaged_exit(p->mm);
+		return 0;
+	}
+
+	for_each_vma(vmi, vma) {
+		if (is_madvise && !(vma->vm_flags & VM_HUGEPAGE))
+			continue;
+
+		khugepaged_enter_vma(vma, vma->vm_flags);
+
+		if (test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
+			break;
+	}
+
+	return 0;
+}
+
+static void mem_cgroup_thp_attach(struct cgroup_taskset *tset)
+{
+	struct task_struct *task;
+	struct cgroup_subsys_state *css;
+
+	cgroup_taskset_for_each(task, css, tset) {
+		mem_cgroup_notify_khugepaged_cb(task, mem_cgroup_from_css(css));
+	}
+}
+#else
+static void mem_cgroup_thp_attach(struct cgroup_taskset *tset) {}
+#endif
+
 static void mem_cgroup_attach(struct cgroup_taskset *tset)
 {
 	mem_cgroup_lru_gen_attach(tset);
 	mem_cgroup_kmem_attach(tset);
+	mem_cgroup_thp_attach(tset);
 }
 
 static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
@@ -4369,6 +4442,54 @@ int memory_thp_enabled_show(struct seq_file *m, void *v)
 	seq_printf(m, "%s\n", thp_enabled_string(flags));
 	return 0;
 }
+
+static int mem_cgroup_notify_khugepaged(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+	int ret = 0;
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		struct css_task_iter it;
+		struct task_struct *task;
+
+		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
+		while (!ret && (task = css_task_iter_next(&it))) {
+			if (!task->mm || (task->flags & PF_KTHREAD))
+				continue;
+
+			ret = mem_cgroup_notify_khugepaged_cb(task, memcg);
+		}
+		css_task_iter_end(&it);
+		if (ret) {
+			mem_cgroup_iter_break(memcg, iter);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+ssize_t memory_thp_enabled_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	int err;
+	int ret = nbytes;
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	buf = strstrip(buf);
+
+	mutex_lock(&memcg_thp_flags_mutex);
+	ret = thp_enabled_parse(buf, &memcg->thp_flags) ? : nbytes;
+	if (ret > 0) {
+		err = mem_cgroup_notify_khugepaged(memcg);
+		if (!err)
+			err = start_stop_khugepaged(false);
+		if (err)
+			ret = err;
+	}
+	mutex_unlock(&memcg_thp_flags_mutex);
+	return ret;
+}
 #endif
 
 static struct cftype memory_files[] = {
@@ -4443,6 +4564,7 @@ static struct cftype memory_files[] = {
 	{
 		.name = "thp_enabled",
 		.seq_show = memory_thp_enabled_show,
+		.write = memory_thp_enabled_write,
 	},
 #endif
 	{ }	/* terminate */
@@ -4909,7 +5031,9 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int mem_cgroup_thp_flags_update_all(unsigned long new_flags, unsigned long mask)
 {
-	int ret = 0;
+	int ret;
+	struct css_task_iter task_iter;
+	struct task_struct *task;
 	struct mem_cgroup *iter, *memcg = root_mem_cgroup;
 	unsigned long enabled_mask =
 		(1UL << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG) |
@@ -4922,8 +5046,18 @@ int mem_cgroup_thp_flags_update_all(unsigned long new_flags, unsigned long mask)
 		unsigned long old_flags = iter->thp_flags;
 
 		iter->thp_flags = (old_flags & ~mask) | new_flags;
+
+		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &task_iter);
+		while ((task = css_task_iter_next(&task_iter))) {
+			if (!task->mm || (task->flags & PF_KTHREAD))
+				continue;
+
+			mem_cgroup_notify_khugepaged_cb(task, iter);
+		}
+		css_task_iter_end(&task_iter);
 	}
 
+	ret = start_stop_khugepaged(!enabled_mask);
 	mutex_unlock(&memcg_thp_flags_mutex);
 	return ret;
 }
@@ -5509,4 +5643,15 @@ static int __init mem_cgroup_swap_init(void)
 }
 subsys_initcall(mem_cgroup_swap_init);
 
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int __init mem_cgroup_thp_init(void)
+{
+	if (IS_ENABLED(CONFIG_MEMCG))
+		root_mem_cgroup->thp_flags = transparent_hugepage_flags;
+
+	return 0;
+}
+subsys_initcall(mem_cgroup_thp_init);
+#endif
 #endif /* CONFIG_SWAP */
-- 
2.34.1


