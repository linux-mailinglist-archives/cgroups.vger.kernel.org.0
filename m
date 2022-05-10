Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA306521EC7
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbiEJPfU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbiEJPfB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 11:35:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F661E48
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id dv4so12835869qvb.13
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLvyvM3ubX4eYoVtvn+FUTceeN1el4qJVnrrDOh0mWM=;
        b=Zb6CFZ5yd2sUyG6vvSeDDR4WDMZNeiF/dcAWCvOZz6i8DiogrmiewzDNum3nFUlVWK
         73d9oushaToTTrnPj5xA9dGEB9CNhNBPwo+Zc1T3LJm79RPqS7L/gNF4KPTwZFUmO4KE
         J3fHfGhkkP34XdA/YgAjJiivK/1or9bh3ccgZvAFoSqRs2ZdQBonD4lSB0oz+braEhlp
         eJE2AB3HRPmui8cuZCZhA+mlg8ZEgohk+RLusWBmTZ7OdS8qAtNVpNn0LYgZBl+DUgAy
         qU3WoZj9P/Cc+e/S22czDMze3CwckqZr0QcRl8rZWx9Kin+E8COR9NO3PuM1OcemcBu8
         NCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLvyvM3ubX4eYoVtvn+FUTceeN1el4qJVnrrDOh0mWM=;
        b=tGP0qzAi+jYeKX5gs4WGQiikBRcQfQkWJZh1jXrab0ov2LgT+DcoTEGX0ePNdBISpu
         7Il9VN+EHPNrtEe2C5UWc2V/+ZtnSY26kZBzM/LkWR+VomVbQylVp25eKJumitT8ADBE
         qRxrRKiH4YhMMIIO7u3Ld1I3M1b9Ef7xlgXqnQXE/FP+Pah3WDzgoTYQwsBhchph6uF7
         BLMkeCXv3x/ke7KDvYaKLlMPzLajWislnHTDTh4XqgGzgJU+SZPI4sNaVOkzMPoxHh1R
         04arHkpEn3LNRLxEzgz/W/eiR0BVnq2rFV8KJzH8HK12FpsEFRllOoTZUxJO1RsIj+3s
         BtOA==
X-Gm-Message-State: AOAM530YI4no4DYL6elwnszavTuLaKhQ2vQdWVvXk2oq2ILdRVvWYbXK
        8kl9kxPBqUYWx/IAVnoCJR4vRw==
X-Google-Smtp-Source: ABdhPJy1HsobYhvbtYZTt42CBEzJzCaqVEfBjHerbnKrV1xcl+dklJQqFYbcKshl0m0qMA1rbwEpdA==
X-Received: by 2002:a05:6214:27c8:b0:456:3800:7b6e with SMTP id ge8-20020a05621427c800b0045638007b6emr18213942qvb.83.1652196595364;
        Tue, 10 May 2022 08:29:55 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id d5-20020ae9ef05000000b0069fc13ce1ebsm8573904qkg.28.2022.05.10.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:29:55 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 6/6] zswap: memcg accounting
Date:   Tue, 10 May 2022 11:28:47 -0400
Message-Id: <20220510152847.230957-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220510152847.230957-1-hannes@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applications can currently escape their cgroup memory containment when
zswap is enabled. This patch adds per-cgroup tracking and limiting of
zswap backend memory to rectify this.

The existing cgroup2 memory.stat file is extended to show zswap
statistics analogous to what's in meminfo and vmstat. Furthermore, two
new control files, memory.zswap.current and memory.zswap.max, are
added to allow tuning zswap usage on a per-workload basis. This is
important since not all workloads benefit from zswap equally; some
even suffer compared to disk swap when memory contents don't compress
well. The optimal size of the zswap pool, and the threshold for
writeback, also depends on the size of the workload's warm set.

The implementation doesn't use a traditional page_counter transaction.
zswap is unconventional as a memory consumer in that we only know the
amount of memory to charge once expensive compression has occurred. If
zwap is disabled or the limit is already exceeded we obviously don't
want to compress page upon page only to reject them all. Instead, the
limit is checked against current usage, then we compress and charge.
This allows some limit overrun, but not enough to matter in practice.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  21 +++
 include/linux/memcontrol.h              |  54 +++++++
 mm/memcontrol.c                         | 196 +++++++++++++++++++++++-
 mm/zswap.c                              |  37 ++++-
 4 files changed, 293 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 19bcd73cad03..b4c262e99b5f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1347,6 +1347,12 @@ PAGE_SIZE multiple when read back.
 		Amount of cached filesystem data that is swap-backed,
 		such as tmpfs, shm segments, shared anonymous mmap()s
 
+	  zswap
+		Amount of memory consumed by the zswap compression backend.
+
+	  zswapped
+		Amount of application memory swapped out to zswap.
+
 	  file_mapped
 		Amount of cached filesystem data mapped with mmap()
 
@@ -1537,6 +1543,21 @@ PAGE_SIZE multiple when read back.
 	higher than the limit for an extended period of time.  This
 	reduces the impact on the workload and memory management.
 
+  memory.zswap.current
+	A read-only single value file which exists on non-root
+	cgroups.
+
+	The total amount of memory consumed by the zswap compression
+	backend.
+
+  memory.zswap.max
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "max".
+
+	Zswap usage hard limit. If a cgroup's zswap pool reaches this
+	limit, it will refuse to take any more stores before existing
+	entries fault back in or are written out to disk.
+
   memory.pressure
 	A read-only nested-keyed file.
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe580cb96683..3385ce81ecf3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -35,6 +35,8 @@ enum memcg_stat_item {
 	MEMCG_PERCPU_B,
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
+	MEMCG_ZSWAP_B,
+	MEMCG_ZSWAPPED,
 	MEMCG_NR_STAT,
 };
 
@@ -252,6 +254,10 @@ struct mem_cgroup {
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
+#ifdef CONFIG_ZSWAP
+	unsigned long zswap_max;
+#endif
+
 	unsigned long soft_limit;
 
 	/* vmpressure notifications */
@@ -1264,6 +1270,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 	return NULL;
 }
 
+static inline void obj_cgroup_put(struct obj_cgroup *objcg)
+{
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
@@ -1680,6 +1690,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
 struct obj_cgroup *get_obj_cgroup_from_current(void);
+struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
@@ -1716,6 +1727,20 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 
 struct mem_cgroup *mem_cgroup_from_obj(void *p);
 
+static inline void count_objcg_event(struct obj_cgroup *objcg,
+				     enum vm_event_item idx)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_kmem_disabled())
+		return;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	count_memcg_events(memcg, idx, 1);
+	rcu_read_unlock();
+}
+
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1742,6 +1767,11 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
+static inline struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline bool memcg_kmem_enabled(void)
 {
 	return false;
@@ -1757,6 +1787,30 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
        return NULL;
 }
 
+static inline void count_objcg_event(struct obj_cgroup *objcg,
+				     enum vm_event_item idx)
+{
+}
+
 #endif /* CONFIG_MEMCG_KMEM */
 
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
+void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
+void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
+#else
+static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
+{
+	return true;
+}
+static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
+					   size_t size)
+{
+}
+static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
+					     size_t size)
+{
+}
+#endif
+
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 04cea4fa362a..cbb9b43bdb80 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1398,6 +1398,10 @@ static const struct memory_stat memory_stats[] = {
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			MEMCG_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
+#ifdef CONFIG_ZSWAP
+	{ "zswap",			MEMCG_ZSWAP_B			},
+	{ "zswapped",			MEMCG_ZSWAPPED			},
+#endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
 	{ "file_writeback",		NR_WRITEBACK			},
@@ -1432,6 +1436,7 @@ static int memcg_page_state_unit(int item)
 {
 	switch (item) {
 	case MEMCG_PERCPU_B:
+	case MEMCG_ZSWAP_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
 	case WORKINGSET_REFAULT_ANON:
@@ -1512,6 +1517,13 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
 		       memcg_events(memcg, PGLAZYFREED));
 
+#ifdef CONFIG_ZSWAP
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPIN),
+		       memcg_events(memcg, ZSWPIN));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(ZSWPOUT),
+		       memcg_events(memcg, ZSWPOUT));
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
 		       memcg_events(memcg, THP_FAULT_ALLOC));
@@ -2883,6 +2895,19 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return page_memcg_check(folio_page(folio, 0));
 }
 
+static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg = NULL;
+
+	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+		objcg = NULL;
+	}
+	return objcg;
+}
+
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct obj_cgroup *objcg = NULL;
@@ -2896,15 +2921,32 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 		memcg = active_memcg();
 	else
 		memcg = mem_cgroup_from_task(current);
-
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
-		objcg = rcu_dereference(memcg->objcg);
-		if (objcg && obj_cgroup_tryget(objcg))
-			break;
-		objcg = NULL;
-	}
+	objcg = __get_obj_cgroup_from_memcg(memcg);
 	rcu_read_unlock();
+	return objcg;
+}
+
+struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
+{
+	struct obj_cgroup *objcg;
+
+	if (!memcg_kmem_enabled() || memcg_kmem_bypass())
+		return NULL;
 
+	if (PageMemcgKmem(page)) {
+		objcg = __folio_objcg(page_folio(page));
+		obj_cgroup_get(objcg);
+	} else {
+		struct mem_cgroup *memcg;
+
+		rcu_read_lock();
+		memcg = __folio_memcg(page_folio(page));
+		if (memcg)
+			objcg = __get_obj_cgroup_from_memcg(memcg);
+		else
+			objcg = NULL;
+		rcu_read_unlock();
+	}
 	return objcg;
 }
 
@@ -5142,6 +5184,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
+#ifdef CONFIG_ZSWAP
+	memcg->zswap_max = PAGE_COUNTER_MAX;
+#endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
@@ -7406,6 +7451,139 @@ static struct cftype memsw_files[] = {
 	{ },	/* terminate */
 };
 
+#ifdef CONFIG_ZSWAP
+/**
+ * obj_cgroup_may_zswap - check if this cgroup can zswap
+ * @objcg: the object cgroup
+ *
+ * Check if the hierarchical zswap limit has been reached.
+ *
+ * This doesn't check for specific headroom, and it is not atomic
+ * either. But with zswap, the size of the allocation is only known
+ * once compression has occured, and this optimistic pre-check avoids
+ * spending cycles on compression when there is already no room left
+ * or zswap is disabled altogether somewhere in the hierarchy.
+ */
+bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
+{
+	struct mem_cgroup *memcg, *original_memcg;
+	bool ret = true;
+
+	original_memcg = get_mem_cgroup_from_objcg(objcg);
+	for (memcg = original_memcg; memcg != root_mem_cgroup;
+	     memcg = parent_mem_cgroup(memcg)) {
+		unsigned long max = READ_ONCE(memcg->zswap_max);
+		unsigned long pages;
+
+		if (max == PAGE_COUNTER_MAX)
+			continue;
+		if (max == 0) {
+			ret = false;
+			break;
+		}
+
+		cgroup_rstat_flush(memcg->css.cgroup);
+		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
+		if (pages < max)
+			continue;
+		ret = false;
+		break;
+	}
+	mem_cgroup_put(original_memcg);
+	return ret;
+}
+
+/**
+ * obj_cgroup_charge_zswap - charge compression backend memory
+ * @objcg: the object cgroup
+ * @size: size of compressed object
+ *
+ * This forces the charge after obj_cgroup_may_swap() allowed
+ * compression and storage in zwap for this cgroup to go ahead.
+ */
+void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
+{
+	struct mem_cgroup *memcg;
+
+	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
+
+	/* PF_MEMALLOC context, charging must succeed */
+	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
+		VM_WARN_ON_ONCE(1);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
+	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
+	rcu_read_unlock();
+}
+
+/**
+ * obj_cgroup_uncharge_zswap - uncharge compression backend memory
+ * @objcg: the object cgroup
+ * @size: size of compressed object
+ *
+ * Uncharges zswap memory on page in.
+ */
+void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
+{
+	struct mem_cgroup *memcg;
+
+	obj_cgroup_uncharge(objcg, size);
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
+	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
+	rcu_read_unlock();
+}
+
+static u64 zswap_current_read(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	cgroup_rstat_flush(css->cgroup);
+	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
+}
+
+static int zswap_max_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->zswap_max));
+}
+
+static ssize_t zswap_max_write(struct kernfs_open_file *of,
+			       char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long max;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &max);
+	if (err)
+		return err;
+
+	xchg(&memcg->zswap_max, max);
+
+	return nbytes;
+}
+
+static struct cftype zswap_files[] = {
+	{
+		.name = "zswap.current",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = zswap_current_read,
+	},
+	{
+		.name = "zswap.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = zswap_max_show,
+		.write = zswap_max_write,
+	},
+	{ }	/* terminate */
+};
+#endif /* CONFIG_ZSWAP */
+
 /*
  * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
  * instead of a core_initcall(), this could mean cgroup_memory_noswap still
@@ -7424,7 +7602,9 @@ static int __init mem_cgroup_swap_init(void)
 
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
-
+#ifdef CONFIG_ZSWAP
+	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
+#endif
 	return 0;
 }
 core_initcall(mem_cgroup_swap_init);
diff --git a/mm/zswap.c b/mm/zswap.c
index e3c16a70f533..104835b379ec 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -188,6 +188,7 @@ struct zswap_entry {
 		unsigned long handle;
 		unsigned long value;
 	};
+	struct obj_cgroup *objcg;
 };
 
 struct zswap_header {
@@ -359,6 +360,10 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
  */
 static void zswap_free_entry(struct zswap_entry *entry)
 {
+	if (entry->objcg) {
+		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
+		obj_cgroup_put(entry->objcg);
+	}
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
@@ -1096,6 +1101,8 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	struct zswap_entry *entry, *dupentry;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	struct obj_cgroup *objcg = NULL;
+	struct zswap_pool *pool;
 	int ret;
 	unsigned int hlen, dlen = PAGE_SIZE;
 	unsigned long handle, value;
@@ -1115,17 +1122,15 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto reject;
 	}
 
+	objcg = get_obj_cgroup_from_page(page);
+	if (objcg && !obj_cgroup_may_zswap(objcg))
+		goto shrink;
+
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
-		struct zswap_pool *pool;
-
 		zswap_pool_limit_hit++;
 		zswap_pool_reached_full = true;
-		pool = zswap_pool_last_get();
-		if (pool)
-			queue_work(shrink_wq, &pool->shrink_work);
-		ret = -ENOMEM;
-		goto reject;
+		goto shrink;
 	}
 
 	if (zswap_pool_reached_full) {
@@ -1227,6 +1232,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	entry->length = dlen;
 
 insert_entry:
+	entry->objcg = objcg;
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, entry->length);
+		/* Account before objcg ref is moved to tree */
+		count_objcg_event(objcg, ZSWPOUT);
+	}
+
 	/* map */
 	spin_lock(&tree->lock);
 	do {
@@ -1253,7 +1265,16 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
+	if (objcg)
+		obj_cgroup_put(objcg);
 	return ret;
+
+shrink:
+	pool = zswap_pool_last_get();
+	if (pool)
+		queue_work(shrink_wq, &pool->shrink_work);
+	ret = -ENOMEM;
+	goto reject;
 }
 
 /*
@@ -1326,6 +1347,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	BUG_ON(ret);
 stats:
 	count_vm_event(ZSWPIN);
+	if (entry->objcg)
+		count_objcg_event(entry->objcg, ZSWPIN);
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
-- 
2.35.3

