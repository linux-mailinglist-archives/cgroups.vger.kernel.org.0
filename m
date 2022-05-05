Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1067B51B6A6
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 05:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiEEDmi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEEDmh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 23:42:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB24993B;
        Wed,  4 May 2022 20:38:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e24so3024181pjt.2;
        Wed, 04 May 2022 20:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPBvAqUw20crx3aNHCyas6EixYg8m1kbUePaLTq2gJo=;
        b=e/vZ5NfbJjoFjAvkELH+FyGzoOlL7N0RXFR3GjfN6tOLxxwVNTErdyCFkGN/CFPV/C
         d73r8yaBU71rZQzvCx6kYdYfHaC6zGULrJlsxNsoHnFj/F6IZPJuiVKCuFVqVi1y8DN6
         /9G5buQGNubGRbJmPZgImZepy+MGzZz2NAvDJcuhdrgwGh+cbirA8IlsqeoIJMBUe/L3
         v7eF67dBua3OJs61zmQmyl0pVykUcLa74hRrjRHyVueNtiRNR7Ex6GVP75n1/XJr0vCd
         rBfmCK/M1tbXQhaovOYb28+4iqghk6IRZ0/vXWnzBzkqRGFShUNQeYeU+6JeNLOXjERB
         0f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPBvAqUw20crx3aNHCyas6EixYg8m1kbUePaLTq2gJo=;
        b=g7PKVgE1fFUoNwwXwofaVXLKDDOt4Qss3n2NuYS0cLi9dmETaHurrqh6+mEd+3jfeJ
         xKnWzUZ554fOR8061R62HAPNg9cZ1Wa5j2K0u9REJuQXvnAO6/5/dtK+vguYscmVG6Pe
         BEE80InOTg2LMPpg0NaiS7A75duSYXxrfu2KlLRLbyJz3UUotCYSoHe1qYPQzkZpEw98
         srZSiH2rnJT6T6e8qxYiLuN2pe9Zr/a8PQPVwLBs/fCR5KGReNNN506DdojimftSepfT
         NMNpBgFfjeX7rj/yeVS4R+oO/rN0ekJzY1ESQp6SBE0GKmtqlSppZeEOb5brLJfBpq/B
         G7ug==
X-Gm-Message-State: AOAM531BYvafTkEHpKRZUY8Kfw5TJ6XcPUZ1uqTz2pwaQajt00ifwVxX
        2EmFO2lkifXOmTFRZBGBYK0=
X-Google-Smtp-Source: ABdhPJyobp8oe3zvObToQ8GzYvP+nTJweQSsbEo5kvC2H+sK7voCdR5R7/1zpMDJG5zpj+O2tz99FA==
X-Received: by 2002:a17:90a:aa98:b0:1b8:5adb:e35f with SMTP id l24-20020a17090aaa9800b001b85adbe35fmr3598531pjq.192.1651721937817;
        Wed, 04 May 2022 20:38:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903028500b0015e8d4eb243sm270595plr.141.2022.05.04.20.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 20:38:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] mm/memcg: support control THP behaviour in cgroup
Date:   Thu,  5 May 2022 03:38:15 +0000
Message-Id: <20220505033814.103256-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn> 

Using THP may promote the performance of memory, but increase memory
footprint. Applications may use madvise to decrease footprint, but
not all applications support using madvise, and it takes much costs
to re-code all the applications. And we notice container becomes more
and more popular to manage a set of tasks.

So add support for cgroup to control THP behaviour will provide much
convenience, administrator may only enable THP for important containers,
and disable it for other containers. Then we can enjoy the high performance
of THP while minimize memory footprint without re-coding any application.

Cgroupv1 is used for many distributions, so and this it.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/huge_mm.h    | 33 +--------------
 include/linux/khugepaged.h | 19 +++------
 include/linux/memcontrol.h | 53 ++++++++++++++++++++++++
 mm/huge_memory.c           | 34 ++++++++++++++++
 mm/khugepaged.c            | 36 ++++++++++++++++-
 mm/memcontrol.c            | 82 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 211 insertions(+), 46 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fbf36bb1be22..fa2cb3d06ecb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -141,38 +141,6 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
 	return true;
 }
 
-/*
- * to be used on vmas which are known to support THP.
- * Use transparent_hugepage_active otherwise
- */
-static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
-{
-
-	/*
-	 * If the hardware/firmware marked hugepage support disabled.
-	 */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
-		return false;
-
-	if (!transhuge_vma_enabled(vma, vma->vm_flags))
-		return false;
-
-	if (vma_is_temporary_stack(vma))
-		return false;
-
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
-		return true;
-
-	if (vma_is_dax(vma))
-		return true;
-
-	if (transparent_hugepage_flags &
-				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
-		return !!(vma->vm_flags & VM_HUGEPAGE);
-
-	return false;
-}
-
 bool transparent_hugepage_active(struct vm_area_struct *vma);
 
 #define transparent_hugepage_use_zero_page()				\
@@ -302,6 +270,7 @@ static inline struct list_head *page_deferred_list(struct page *page)
 	 */
 	return &page[2].deferred_list;
 }
+inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma);
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 2fcc01891b47..b77b065ebf16 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -26,16 +26,9 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 }
 #endif
 
-#define khugepaged_enabled()					       \
-	(transparent_hugepage_flags &				       \
-	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
-	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
-#define khugepaged_always()				\
-	(transparent_hugepage_flags &			\
-	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
-#define khugepaged_req_madv()					\
-	(transparent_hugepage_flags &				\
-	 (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
+extern inline int khugepaged_enabled(void);
+extern inline int khugepaged_always(struct vm_area_struct *vma);
+extern inline int khugepaged_req_madv(struct vm_area_struct *vma);
 #define khugepaged_defrag()					\
 	(transparent_hugepage_flags &				\
 	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
@@ -57,9 +50,9 @@ static inline int khugepaged_enter(struct vm_area_struct *vma,
 				   unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
-		if ((khugepaged_always() ||
-		     (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
-		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
+		if ((khugepaged_always(vma) ||
+		    (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
+		    (khugepaged_req_madv(vma) && (vm_flags & VM_HUGEPAGE))) &&
 		    !(vm_flags & VM_NOHUGEPAGE) &&
 		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 			if (__khugepaged_enter(vma->vm_mm))
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8ea4b541c31e..c5f9f4b267bd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -28,6 +28,13 @@ struct page;
 struct mm_struct;
 struct kmem_cache;
 
+/*
+ * Increase when sub cgroup enable transparent hugepage, decrease when
+ * sub cgroup disable transparent hugepage. Help decide whether to run
+ * khugepaged.
+ */
+extern atomic_t sub_thp_count;
+
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
@@ -343,6 +350,7 @@ struct mem_cgroup {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct deferred_split deferred_split_queue;
 #endif
+	unsigned long thp_flag;
 
 	struct mem_cgroup_per_node *nodeinfo[];
 };
@@ -1127,6 +1135,32 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+static inline unsigned long mem_cgroup_thp_flag(struct mem_cgroup *memcg)
+{
+	if (unlikely(memcg == NULL) || mem_cgroup_disabled() ||
+	    mem_cgroup_is_root(memcg))
+		return transparent_hugepage_flags;
+
+	return memcg->thp_flag;
+}
+
+static inline int memcg_sub_thp_enabled(void)
+{
+	return atomic_read(&sub_thp_count) != 0;
+}
+
+static inline void memcg_sub_thp_enable(struct mem_cgroup *memcg)
+{
+	if (!mem_cgroup_is_root(memcg))
+		atomic_inc(&sub_thp_count);
+}
+
+static inline void memcg_sub_thp_disable(struct mem_cgroup *memcg)
+{
+	if (!mem_cgroup_is_root(memcg))
+		atomic_dec(&sub_thp_count);
+}
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1524,6 +1558,25 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+
+static inline unsigned long mem_cgroup_thp_flag(struct mem_cgroup *memcg)
+{
+	return transparent_hugepage_flags;
+}
+
+static inline int memcg_sub_thp_enabled(void)
+{
+	return 0;
+}
+
+static inline void memcg_sub_thp_enable(struct mem_cgroup *memcg)
+{
+}
+
+static inline void memcg_sub_thp_disable(struct mem_cgroup *memcg)
+{
+}
+
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6bf0ec9ac4e4..09c80b6a18d6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3173,4 +3173,38 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 	trace_remove_migration_pmd(address, pmd_val(pmde));
 }
+
+/*
+ * to be used on vmas which are known to support THP.
+ * Use transparent_hugepage_active otherwise
+ */
+inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+
+	/*
+	 * If the hardware/firmware marked hugepage support disabled.
+	 */
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
+		return false;
+
+	if (!transhuge_vma_enabled(vma, vma->vm_flags))
+		return false;
+
+	if (vma_is_temporary_stack(vma))
+		return false;
+
+	if (mem_cgroup_thp_flag(memcg) & (1 << TRANSPARENT_HUGEPAGE_FLAG))
+		return true;
+
+	if (vma_is_dax(vma))
+		return true;
+
+	if (mem_cgroup_thp_flag(memcg) &
+	    (1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
+		return !!(vma->vm_flags & VM_HUGEPAGE);
+
+	return false;
+}
+
 #endif
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eb444fd45568..8386d8d1d423 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -454,7 +454,7 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 		return shmem_huge_enabled(vma);
 
 	/* THP settings require madvise. */
-	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
+	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always(vma))
 		return false;
 
 	/* Only regular file is valid */
@@ -1537,6 +1537,40 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	goto drop_hpage;
 }
 
+inline int khugepaged_enabled(void)
+{
+	if ((transparent_hugepage_flags &
+	    ((1<<TRANSPARENT_HUGEPAGE_FLAG) |
+	    (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))) ||
+	    memcg_sub_thp_enabled())
+		return 1;
+	else
+		return 0;
+}
+
+inline int khugepaged_req_madv(struct vm_area_struct *vma)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+
+	if (mem_cgroup_thp_flag(memcg) &
+	    (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
+		return 1;
+	else
+		return 0;
+}
+
+inline int khugepaged_always(struct vm_area_struct *vma)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+
+	if (mem_cgroup_thp_flag(memcg) &
+	    (1<<TRANSPARENT_HUGEPAGE_FLAG))
+		return 1;
+	else
+		return 0;
+}
+
+
 static void khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
 {
 	struct mm_struct *mm = mm_slot->mm;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e1b5823ac060..1372324f76e3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/khugepaged.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -99,6 +100,8 @@ static bool cgroup_memory_noswap __ro_after_init;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
+atomic_t sub_thp_count __read_mostly = ATOMIC_INIT(0);
+
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
@@ -4823,6 +4826,71 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 }
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int mem_cgroup_thp_flag_show(struct seq_file *sf, void *v)
+{
+	const char *output;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
+	unsigned long flag = mem_cgroup_thp_flag(memcg);
+
+	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &flag))
+		output = "[always] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &flag))
+		output = "always [madvise] never";
+	else
+		output = "always madvise [never]";
+
+	seq_printf(sf, "%s\n", output);
+	return 0;
+}
+
+static ssize_t mem_cgroup_thp_flag_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	ssize_t ret = nbytes;
+	unsigned long *flag;
+
+	if (!mem_cgroup_is_root(memcg))
+		flag = &memcg->thp_flag;
+	else
+		flag = &transparent_hugepage_flags;
+
+	if (sysfs_streq(buf, "always")) {
+		if (!test_bit(TRANSPARENT_HUGEPAGE_FLAG, flag)) {
+			set_bit(TRANSPARENT_HUGEPAGE_FLAG, flag);
+			/* change disable to enable */
+			if (!test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flag))
+				memcg_sub_thp_enable(memcg);
+		}
+	} else if (sysfs_streq(buf, "madvise")) {
+		if (!test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flag)) {
+			set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flag);
+			/* change disable to enable */
+			if (!test_bit(TRANSPARENT_HUGEPAGE_FLAG, flag))
+				memcg_sub_thp_enable(memcg);
+		}
+	} else if (sysfs_streq(buf, "never")) {
+		/* change enable to disable */
+		if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, flag) ||
+		    test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flag)) {
+			clear_bit(TRANSPARENT_HUGEPAGE_FLAG, flag);
+			clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, flag);
+			memcg_sub_thp_disable(memcg);
+		}
+	} else
+		ret = -EINVAL;
+
+	if (ret > 0) {
+		int err = start_stop_khugepaged();
+
+		if (err)
+			ret = err;
+	}
+	return ret;
+}
+#endif
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -4948,6 +5016,13 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	{
+		.name = "transparent_hugepage.enabled",
+		.seq_show = mem_cgroup_thp_flag_show,
+		.write = mem_cgroup_thp_flag_write,
+	},
+#endif
 	{ },	/* terminate */
 };
 
@@ -5145,8 +5220,14 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
+		memcg->thp_flag = mem_cgroup_thp_flag(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
 
+		if (memcg->thp_flag &
+		    ((1<<TRANSPARENT_HUGEPAGE_FLAG) |
+		    (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
+			memcg_sub_thp_enable(memcg);
+
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
@@ -5220,6 +5301,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg_offline_kmem(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
+	memcg_sub_thp_disable(memcg);
 
 	drain_all_stock(memcg);
 
-- 
2.25.1

