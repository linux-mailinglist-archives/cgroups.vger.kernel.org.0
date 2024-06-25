Return-Path: <cgroups+bounces-3332-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C7915B65
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33B61C219F6
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BAE54F98;
	Tue, 25 Jun 2024 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CS6G31DD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A249620
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277193; cv=none; b=mqagfogcFW16r89PfAtsO/heOrDp4COKdO2WyD25cVNsFC2Og+IWRUiWeUSMl3dIsBjycePvf9n0HsmyBzZjC2+FbFwoM9KPLVLQlxPdmvlrnPrcc9znaUfOEW8aw8Dy+iu49chq24+Q7P+GtFplQNqxNf/ocpvW+8C1vw5Mapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277193; c=relaxed/simple;
	bh=WjwjXYumcVOpdrXi7YS+/E4hhBrfelVUrkqDwdixEXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szfMME5qyY+qcABSigDoe4Oj9zuxLXv7ZGFta+na9KCdPXL0Do8OpNPgw7Wnm1gmMWKKNMTjAizozLohzh1m26mBjTTdzBBAXv308iRLR099xqbvxKav3LFnIkiddURg3qiYNqdEUHAA+VPG1TE1YUmg6z7PpRWhNyYk+BbJHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CS6G31DD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPeyaNOSxBqGrmhIQ0Yy2cBzUve/uQScgREmCFFE80A=;
	b=CS6G31DDySi/Xt0aJx00BATVEUW2DIQKSsJ0IKZnXL6+TmgPsBUi5GK+Ap2FWWoXcGDcAR
	Q4KTj0NOAajPbPkhkSn27NKhCZY26SsS3jEniRpROz7KSL7rrGiIDH8W+6CcJ4LUZoUIrC
	cpLmvnsleHo/2OgjosFJ77JwOftICeI=
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
Subject: [PATCH v2 10/14] mm: memcg: move cgroup v1 interface files to memcontrol-v1.c
Date: Mon, 24 Jun 2024 17:59:02 -0700
Message-ID: <20240625005906.106920-11-roman.gushchin@linux.dev>
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

Move legacy cgroup v1 memory controller interfaces and corresponding
code into memcontrol-v1.c.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 739 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/memcontrol-v1.h |  29 +-
 mm/memcontrol.c    | 721 +------------------------------------------
 3 files changed, 767 insertions(+), 722 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 1d5608ee1606..1b7337d0170d 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -10,6 +10,7 @@
 #include <linux/poll.h>
 #include <linux/sort.h>
 #include <linux/file.h>
+#include <linux/seq_buf.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -110,6 +111,18 @@ struct mem_cgroup_event {
 	struct work_struct remove;
 };
 
+#define MEMFILE_PRIVATE(x, val)	((x) << 16 | (val))
+#define MEMFILE_TYPE(val)	((val) >> 16 & 0xffff)
+#define MEMFILE_ATTR(val)	((val) & 0xffff)
+
+enum {
+	RES_USAGE,
+	RES_LIMIT,
+	RES_MAX_USAGE,
+	RES_FAILCNT,
+	RES_SOFT_LIMIT,
+};
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map memcg_oom_lock_dep_map = {
 	.name = "memcg_oom_lock",
@@ -577,14 +590,14 @@ static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
 }
 #endif
 
-u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
+static u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
 				struct cftype *cft)
 {
 	return mem_cgroup_from_css(css)->move_charge_at_immigrate;
 }
 
 #ifdef CONFIG_MMU
-int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
+static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 				 struct cftype *cft, u64 val)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -606,7 +619,7 @@ int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 #else
-int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
+static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 				 struct cftype *cft, u64 val)
 {
 	return -ENOSYS;
@@ -1803,8 +1816,8 @@ static void memcg_event_ptable_queue_proc(struct file *file,
  * Input must be in format '<event_fd> <control_fd> <args>'.
  * Interpretation of args is defined by control file implementation.
  */
-ssize_t memcg_write_event_control(struct kernfs_open_file *of,
-				  char *buf, size_t nbytes, loff_t off)
+static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
 {
 	struct cgroup_subsys_state *css = of_css(of);
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -2184,6 +2197,722 @@ void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked)
 		mem_cgroup_oom_unlock(memcg);
 }
 
+static DEFINE_MUTEX(memcg_max_mutex);
+
+static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
+				 unsigned long max, bool memsw)
+{
+	bool enlarge = false;
+	bool drained = false;
+	int ret;
+	bool limits_invariant;
+	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
+
+	do {
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		mutex_lock(&memcg_max_mutex);
+		/*
+		 * Make sure that the new limit (memsw or memory limit) doesn't
+		 * break our basic invariant rule memory.max <= memsw.max.
+		 */
+		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
+					   max <= memcg->memsw.max;
+		if (!limits_invariant) {
+			mutex_unlock(&memcg_max_mutex);
+			ret = -EINVAL;
+			break;
+		}
+		if (max > counter->max)
+			enlarge = true;
+		ret = page_counter_set_max(counter, max);
+		mutex_unlock(&memcg_max_mutex);
+
+		if (!ret)
+			break;
+
+		if (!drained) {
+			drain_all_stock(memcg);
+			drained = true;
+			continue;
+		}
+
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+						  memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
+			ret = -EBUSY;
+			break;
+		}
+	} while (true);
+
+	if (!ret && enlarge)
+		memcg1_oom_recover(memcg);
+
+	return ret;
+}
+
+/*
+ * Reclaims as many pages from the given memcg as possible.
+ *
+ * Caller is responsible for holding css reference for memcg.
+ */
+static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
+{
+	int nr_retries = MAX_RECLAIM_RETRIES;
+
+	/* we call try-to-free pages for make this cgroup empty */
+	lru_add_drain_all();
+
+	drain_all_stock(memcg);
+
+	/* try to free all pages in this cgroup */
+	while (nr_retries && page_counter_read(&memcg->memory)) {
+		if (signal_pending(current))
+			return -EINTR;
+
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+						  MEMCG_RECLAIM_MAY_SWAP, NULL))
+			nr_retries--;
+	}
+
+	return 0;
+}
+
+static ssize_t mem_cgroup_force_empty_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+
+	if (mem_cgroup_is_root(memcg))
+		return -EINVAL;
+	return mem_cgroup_force_empty(memcg) ?: nbytes;
+}
+
+static u64 mem_cgroup_hierarchy_read(struct cgroup_subsys_state *css,
+				     struct cftype *cft)
+{
+	return 1;
+}
+
+static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
+				      struct cftype *cft, u64 val)
+{
+	if (val == 1)
+		return 0;
+
+	pr_warn_once("Non-hierarchical mode is deprecated. "
+		     "Please report your usecase to linux-mm@kvack.org if you "
+		     "depend on this functionality.\n");
+
+	return -EINVAL;
+}
+
+static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct page_counter *counter;
+
+	switch (MEMFILE_TYPE(cft->private)) {
+	case _MEM:
+		counter = &memcg->memory;
+		break;
+	case _MEMSWAP:
+		counter = &memcg->memsw;
+		break;
+	case _KMEM:
+		counter = &memcg->kmem;
+		break;
+	case _TCP:
+		counter = &memcg->tcpmem;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (MEMFILE_ATTR(cft->private)) {
+	case RES_USAGE:
+		if (counter == &memcg->memory)
+			return (u64)mem_cgroup_usage(memcg, false) * PAGE_SIZE;
+		if (counter == &memcg->memsw)
+			return (u64)mem_cgroup_usage(memcg, true) * PAGE_SIZE;
+		return (u64)page_counter_read(counter) * PAGE_SIZE;
+	case RES_LIMIT:
+		return (u64)counter->max * PAGE_SIZE;
+	case RES_MAX_USAGE:
+		return (u64)counter->watermark * PAGE_SIZE;
+	case RES_FAILCNT:
+		return counter->failcnt;
+	case RES_SOFT_LIMIT:
+		return (u64)READ_ONCE(memcg->soft_limit) * PAGE_SIZE;
+	default:
+		BUG();
+	}
+}
+
+/*
+ * This function doesn't do anything useful. Its only job is to provide a read
+ * handler for a file so that cgroup_file_mode() will add read permissions.
+ */
+static int mem_cgroup_dummy_seq_show(__always_unused struct seq_file *m,
+				     __always_unused void *v)
+{
+	return -EINVAL;
+}
+
+static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
+{
+	int ret;
+
+	mutex_lock(&memcg_max_mutex);
+
+	ret = page_counter_set_max(&memcg->tcpmem, max);
+	if (ret)
+		goto out;
+
+	if (!memcg->tcpmem_active) {
+		/*
+		 * The active flag needs to be written after the static_key
+		 * update. This is what guarantees that the socket activation
+		 * function is the last one to run. See mem_cgroup_sk_alloc()
+		 * for details, and note that we don't mark any socket as
+		 * belonging to this memcg until that flag is up.
+		 *
+		 * We need to do this, because static_keys will span multiple
+		 * sites, but we can't control their order. If we mark a socket
+		 * as accounted, but the accounting functions are not patched in
+		 * yet, we'll lose accounting.
+		 *
+		 * We never race with the readers in mem_cgroup_sk_alloc(),
+		 * because when this value change, the code to process it is not
+		 * patched in yet.
+		 */
+		static_branch_inc(&memcg_sockets_enabled_key);
+		memcg->tcpmem_active = true;
+	}
+out:
+	mutex_unlock(&memcg_max_mutex);
+	return ret;
+}
+
+/*
+ * The user of this function is...
+ * RES_LIMIT.
+ */
+static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long nr_pages;
+	int ret;
+
+	buf = strstrip(buf);
+	ret = page_counter_memparse(buf, "-1", &nr_pages);
+	if (ret)
+		return ret;
+
+	switch (MEMFILE_ATTR(of_cft(of)->private)) {
+	case RES_LIMIT:
+		if (mem_cgroup_is_root(memcg)) { /* Can't set limit on root */
+			ret = -EINVAL;
+			break;
+		}
+		switch (MEMFILE_TYPE(of_cft(of)->private)) {
+		case _MEM:
+			ret = mem_cgroup_resize_max(memcg, nr_pages, false);
+			break;
+		case _MEMSWAP:
+			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
+			break;
+		case _KMEM:
+			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
+				     "Writing any value to this file has no effect. "
+				     "Please report your usecase to linux-mm@kvack.org if you "
+				     "depend on this functionality.\n");
+			ret = 0;
+			break;
+		case _TCP:
+			ret = memcg_update_tcp_max(memcg, nr_pages);
+			break;
+		}
+		break;
+	case RES_SOFT_LIMIT:
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			ret = -EOPNOTSUPP;
+		} else {
+			WRITE_ONCE(memcg->soft_limit, nr_pages);
+			ret = 0;
+		}
+		break;
+	}
+	return ret ?: nbytes;
+}
+
+static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
+				size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct page_counter *counter;
+
+	switch (MEMFILE_TYPE(of_cft(of)->private)) {
+	case _MEM:
+		counter = &memcg->memory;
+		break;
+	case _MEMSWAP:
+		counter = &memcg->memsw;
+		break;
+	case _KMEM:
+		counter = &memcg->kmem;
+		break;
+	case _TCP:
+		counter = &memcg->tcpmem;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (MEMFILE_ATTR(of_cft(of)->private)) {
+	case RES_MAX_USAGE:
+		page_counter_reset_watermark(counter);
+		break;
+	case RES_FAILCNT:
+		counter->failcnt = 0;
+		break;
+	default:
+		BUG();
+	}
+
+	return nbytes;
+}
+
+#ifdef CONFIG_NUMA
+
+#define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
+#define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
+#define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
+
+/* static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg, */
+/* 				int nid, unsigned int lru_mask, bool tree) */
+/* { */
+/* 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid)); */
+/* 	unsigned long nr = 0; */
+/* 	enum lru_list lru; */
+
+/* 	VM_BUG_ON((unsigned)nid >= nr_node_ids); */
+
+/* 	for_each_lru(lru) { */
+/* 		if (!(BIT(lru) & lru_mask)) */
+/* 			continue; */
+/* 		if (tree) */
+/* 			nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru); */
+/* 		else */
+/* 			nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru); */
+/* 	} */
+/* 	return nr; */
+/* } */
+
+/* static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg, */
+/* 					     unsigned int lru_mask, */
+/* 					     bool tree) */
+/* { */
+/* 	unsigned long nr = 0; */
+/* 	enum lru_list lru; */
+
+/* 	for_each_lru(lru) { */
+/* 		if (!(BIT(lru) & lru_mask)) */
+/* 			continue; */
+/* 		if (tree) */
+/* 			nr += memcg_page_state(memcg, NR_LRU_BASE + lru); */
+/* 		else */
+/* 			nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru); */
+/* 	} */
+/* 	return nr; */
+/* } */
+
+static int memcg_numa_stat_show(struct seq_file *m, void *v)
+{
+	struct numa_stat {
+		const char *name;
+		unsigned int lru_mask;
+	};
+
+	static const struct numa_stat stats[] = {
+		{ "total", LRU_ALL },
+		{ "file", LRU_ALL_FILE },
+		{ "anon", LRU_ALL_ANON },
+		{ "unevictable", BIT(LRU_UNEVICTABLE) },
+	};
+	const struct numa_stat *stat;
+	int nid;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	mem_cgroup_flush_stats(memcg);
+
+	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
+		seq_printf(m, "%s=%lu", stat->name,
+			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+						   false));
+		for_each_node_state(nid, N_MEMORY)
+			seq_printf(m, " N%d=%lu", nid,
+				   mem_cgroup_node_nr_lru_pages(memcg, nid,
+							stat->lru_mask, false));
+		seq_putc(m, '\n');
+	}
+
+	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
+
+		seq_printf(m, "hierarchical_%s=%lu", stat->name,
+			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+						   true));
+		for_each_node_state(nid, N_MEMORY)
+			seq_printf(m, " N%d=%lu", nid,
+				   mem_cgroup_node_nr_lru_pages(memcg, nid,
+							stat->lru_mask, true));
+		seq_putc(m, '\n');
+	}
+
+	return 0;
+}
+#endif /* CONFIG_NUMA */
+
+static const unsigned int memcg1_stats[] = {
+	NR_FILE_PAGES,
+	NR_ANON_MAPPED,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	NR_ANON_THPS,
+#endif
+	NR_SHMEM,
+	NR_FILE_MAPPED,
+	NR_FILE_DIRTY,
+	NR_WRITEBACK,
+	WORKINGSET_REFAULT_ANON,
+	WORKINGSET_REFAULT_FILE,
+#ifdef CONFIG_SWAP
+	MEMCG_SWAP,
+	NR_SWAPCACHE,
+#endif
+};
+
+static const char *const memcg1_stat_names[] = {
+	"cache",
+	"rss",
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	"rss_huge",
+#endif
+	"shmem",
+	"mapped_file",
+	"dirty",
+	"writeback",
+	"workingset_refault_anon",
+	"workingset_refault_file",
+#ifdef CONFIG_SWAP
+	"swap",
+	"swapcached",
+#endif
+};
+
+/* Universal VM events cgroup1 shows, original sort order */
+static const unsigned int memcg1_events[] = {
+	PGPGIN,
+	PGPGOUT,
+	PGFAULT,
+	PGMAJFAULT,
+};
+
+void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
+{
+	unsigned long memory, memsw;
+	struct mem_cgroup *mi;
+	unsigned int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
+
+	mem_cgroup_flush_stats(memcg);
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
+		unsigned long nr;
+
+		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
+		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
+		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
+			       memcg_events_local(memcg, memcg1_events[i]));
+
+	for (i = 0; i < NR_LRU_LISTS; i++)
+		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
+			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
+			       PAGE_SIZE);
+
+	/* Hierarchical information */
+	memory = memsw = PAGE_COUNTER_MAX;
+	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
+		memory = min(memory, READ_ONCE(mi->memory.max));
+		memsw = min(memsw, READ_ONCE(mi->memsw.max));
+	}
+	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
+		       (u64)memory * PAGE_SIZE);
+	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
+		       (u64)memsw * PAGE_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
+		unsigned long nr;
+
+		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
+		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
+			       (u64)nr);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
+		seq_buf_printf(s, "total_%s %llu\n",
+			       vm_event_name(memcg1_events[i]),
+			       (u64)memcg_events(memcg, memcg1_events[i]));
+
+	for (i = 0; i < NR_LRU_LISTS; i++)
+		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
+			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
+			       PAGE_SIZE);
+
+#ifdef CONFIG_DEBUG_VM
+	{
+		pg_data_t *pgdat;
+		struct mem_cgroup_per_node *mz;
+		unsigned long anon_cost = 0;
+		unsigned long file_cost = 0;
+
+		for_each_online_pgdat(pgdat) {
+			mz = memcg->nodeinfo[pgdat->node_id];
+
+			anon_cost += mz->lruvec.anon_cost;
+			file_cost += mz->lruvec.file_cost;
+		}
+		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
+		seq_buf_printf(s, "file_cost %lu\n", file_cost);
+	}
+#endif
+}
+
+static u64 mem_cgroup_swappiness_read(struct cgroup_subsys_state *css,
+				      struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return mem_cgroup_swappiness(memcg);
+}
+
+static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
+				       struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	if (val > MAX_SWAPPINESS)
+		return -EINVAL;
+
+	if (!mem_cgroup_is_root(memcg))
+		WRITE_ONCE(memcg->swappiness, val);
+	else
+		WRITE_ONCE(vm_swappiness, val);
+
+	return 0;
+}
+
+static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
+
+	seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill_disable));
+	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
+	seq_printf(sf, "oom_kill %lu\n",
+		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
+	return 0;
+}
+
+static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
+	struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	/* cannot set to root cgroup and only 0 and 1 are allowed */
+	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->oom_kill_disable, val);
+	if (!val)
+		memcg1_oom_recover(memcg);
+
+	return 0;
+}
+
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
+static int mem_cgroup_slab_show(struct seq_file *m, void *p)
+{
+	/*
+	 * Deprecated.
+	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
+	 */
+	return 0;
+}
+#endif
+
+struct cftype mem_cgroup_legacy_files[] = {
+	{
+		.name = "usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEM, RES_USAGE),
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "max_usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEM, RES_MAX_USAGE),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEM, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "soft_limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEM, RES_SOFT_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "failcnt",
+		.private = MEMFILE_PRIVATE(_MEM, RES_FAILCNT),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "stat",
+		.seq_show = memory_stat_show,
+	},
+	{
+		.name = "force_empty",
+		.write = mem_cgroup_force_empty_write,
+	},
+	{
+		.name = "use_hierarchy",
+		.write_u64 = mem_cgroup_hierarchy_write,
+		.read_u64 = mem_cgroup_hierarchy_read,
+	},
+	{
+		.name = "cgroup.event_control",		/* XXX: for compat */
+		.write = memcg_write_event_control,
+		.flags = CFTYPE_NO_PREFIX | CFTYPE_WORLD_WRITABLE,
+	},
+	{
+		.name = "swappiness",
+		.read_u64 = mem_cgroup_swappiness_read,
+		.write_u64 = mem_cgroup_swappiness_write,
+	},
+	{
+		.name = "move_charge_at_immigrate",
+		.read_u64 = mem_cgroup_move_charge_read,
+		.write_u64 = mem_cgroup_move_charge_write,
+	},
+	{
+		.name = "oom_control",
+		.seq_show = mem_cgroup_oom_control_read,
+		.write_u64 = mem_cgroup_oom_control_write,
+	},
+	{
+		.name = "pressure_level",
+		.seq_show = mem_cgroup_dummy_seq_show,
+	},
+#ifdef CONFIG_NUMA
+	{
+		.name = "numa_stat",
+		.seq_show = memcg_numa_stat_show,
+	},
+#endif
+	{
+		.name = "kmem.limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "kmem.usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "kmem.failcnt",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_FAILCNT),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "kmem.max_usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_MAX_USAGE),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
+	{
+		.name = "kmem.slabinfo",
+		.seq_show = mem_cgroup_slab_show,
+	},
+#endif
+	{
+		.name = "kmem.tcp.limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_TCP, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "kmem.tcp.usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_TCP, RES_USAGE),
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "kmem.tcp.failcnt",
+		.private = MEMFILE_PRIVATE(_TCP, RES_FAILCNT),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "kmem.tcp.max_usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_TCP, RES_MAX_USAGE),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{ },	/* terminate */
+};
+
+struct cftype memsw_files[] = {
+	{
+		.name = "memsw.usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_USAGE),
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "memsw.max_usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_MAX_USAGE),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "memsw.limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
+		.name = "memsw.failcnt",
+		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_FAILCNT),
+		.write = mem_cgroup_reset,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{ },	/* terminate */
+};
+
 static int __init memcg1_init(void)
 {
 	int node;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 972c493a8ae3..7be4670d9abb 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -3,6 +3,8 @@
 #ifndef __MM_MEMCONTROL_V1_H
 #define __MM_MEMCONTROL_V1_H
 
+#include <linux/cgroup-defs.h>
+
 void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
 void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
@@ -34,12 +36,6 @@ int memcg1_can_attach(struct cgroup_taskset *tset);
 void memcg1_cancel_attach(struct cgroup_taskset *tset);
 void memcg1_move_task(void);
 
-struct cftype;
-u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
-				struct cftype *cft);
-int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
-				 struct cftype *cft, u64 val);
-
 /*
  * Per memcg event counter is incremented at every pagein/pageout. With THP,
  * it will be incremented by the number of pages. This counter is used
@@ -86,11 +82,28 @@ enum res_type {
 bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				enum mem_cgroup_events_target target);
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
-ssize_t memcg_write_event_control(struct kernfs_open_file *of,
-				  char *buf, size_t nbytes, loff_t off);
 
 bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
 void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
 
+void drain_all_stock(struct mem_cgroup *root_memcg);
+unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
+				      unsigned int lru_mask, bool tree);
+unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+					   int nid, unsigned int lru_mask,
+					   bool tree);
+
+unsigned long memcg_events(struct mem_cgroup *memcg, int event);
+unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
+unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
+unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
+unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
+int memory_stat_show(struct seq_file *m, void *v);
+
+void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
+
+extern struct cftype memsw_files[];
+extern struct cftype mem_cgroup_legacy_files[];
+
 #endif	/* __MM_MEMCONTROL_V1_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 37e0af5b26f3..c7341e811945 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,10 +96,6 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
-#define MEMFILE_PRIVATE(x, val)	((x) << 16 | (val))
-#define MEMFILE_TYPE(val)	((val) >> 16 & 0xffff)
-#define MEMFILE_ATTR(val)	((val) & 0xffff)
-
 static inline bool task_is_dying(void)
 {
 	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
@@ -676,7 +672,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
-static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
+unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
 	long x;
 	int i = memcg_stats_index(idx);
@@ -825,7 +821,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	memcg_stats_unlock();
 }
 
-static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
+unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
 
@@ -835,7 +831,7 @@ static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 	return READ_ONCE(memcg->vmstats->events[i]);
 }
 
-static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
+unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
 	int i = memcg_events_index(event);
 
@@ -1420,15 +1416,13 @@ static int memcg_page_state_output_unit(int item)
 	}
 }
 
-static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
-						    int item)
+unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item)
 {
 	return memcg_page_state(memcg, item) *
 		memcg_page_state_output_unit(item);
 }
 
-static inline unsigned long memcg_page_state_local_output(
-		struct mem_cgroup *memcg, int item)
+unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item)
 {
 	return memcg_page_state_local(memcg, item) *
 		memcg_page_state_output_unit(item);
@@ -1487,8 +1481,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }
 
-static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
-
 static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
@@ -1861,7 +1853,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
  */
-static void drain_all_stock(struct mem_cgroup *root_memcg)
+void drain_all_stock(struct mem_cgroup *root_memcg)
 {
 	int cpu, curcpu;
 
@@ -3115,120 +3107,6 @@ void split_page_memcg(struct page *head, int old_order, int new_order)
 		css_get_many(&memcg->css, old_nr / new_nr - 1);
 }
 
-
-static DEFINE_MUTEX(memcg_max_mutex);
-
-static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
-				 unsigned long max, bool memsw)
-{
-	bool enlarge = false;
-	bool drained = false;
-	int ret;
-	bool limits_invariant;
-	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
-
-	do {
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		mutex_lock(&memcg_max_mutex);
-		/*
-		 * Make sure that the new limit (memsw or memory limit) doesn't
-		 * break our basic invariant rule memory.max <= memsw.max.
-		 */
-		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
-					   max <= memcg->memsw.max;
-		if (!limits_invariant) {
-			mutex_unlock(&memcg_max_mutex);
-			ret = -EINVAL;
-			break;
-		}
-		if (max > counter->max)
-			enlarge = true;
-		ret = page_counter_set_max(counter, max);
-		mutex_unlock(&memcg_max_mutex);
-
-		if (!ret)
-			break;
-
-		if (!drained) {
-			drain_all_stock(memcg);
-			drained = true;
-			continue;
-		}
-
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
-			ret = -EBUSY;
-			break;
-		}
-	} while (true);
-
-	if (!ret && enlarge)
-		memcg1_oom_recover(memcg);
-
-	return ret;
-}
-
-/*
- * Reclaims as many pages from the given memcg as possible.
- *
- * Caller is responsible for holding css reference for memcg.
- */
-static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
-{
-	int nr_retries = MAX_RECLAIM_RETRIES;
-
-	/* we call try-to-free pages for make this cgroup empty */
-	lru_add_drain_all();
-
-	drain_all_stock(memcg);
-
-	/* try to free all pages in this cgroup */
-	while (nr_retries && page_counter_read(&memcg->memory)) {
-		if (signal_pending(current))
-			return -EINTR;
-
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP, NULL))
-			nr_retries--;
-	}
-
-	return 0;
-}
-
-static ssize_t mem_cgroup_force_empty_write(struct kernfs_open_file *of,
-					    char *buf, size_t nbytes,
-					    loff_t off)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-
-	if (mem_cgroup_is_root(memcg))
-		return -EINVAL;
-	return mem_cgroup_force_empty(memcg) ?: nbytes;
-}
-
-static u64 mem_cgroup_hierarchy_read(struct cgroup_subsys_state *css,
-				     struct cftype *cft)
-{
-	return 1;
-}
-
-static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
-				      struct cftype *cft, u64 val)
-{
-	if (val == 1)
-		return 0;
-
-	pr_warn_once("Non-hierarchical mode is deprecated. "
-		     "Please report your usecase to linux-mm@kvack.org if you "
-		     "depend on this functionality.\n");
-
-	return -EINVAL;
-}
-
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 {
 	unsigned long val;
@@ -3251,67 +3129,6 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	return val;
 }
 
-enum {
-	RES_USAGE,
-	RES_LIMIT,
-	RES_MAX_USAGE,
-	RES_FAILCNT,
-	RES_SOFT_LIMIT,
-};
-
-static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
-			       struct cftype *cft)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-	struct page_counter *counter;
-
-	switch (MEMFILE_TYPE(cft->private)) {
-	case _MEM:
-		counter = &memcg->memory;
-		break;
-	case _MEMSWAP:
-		counter = &memcg->memsw;
-		break;
-	case _KMEM:
-		counter = &memcg->kmem;
-		break;
-	case _TCP:
-		counter = &memcg->tcpmem;
-		break;
-	default:
-		BUG();
-	}
-
-	switch (MEMFILE_ATTR(cft->private)) {
-	case RES_USAGE:
-		if (counter == &memcg->memory)
-			return (u64)mem_cgroup_usage(memcg, false) * PAGE_SIZE;
-		if (counter == &memcg->memsw)
-			return (u64)mem_cgroup_usage(memcg, true) * PAGE_SIZE;
-		return (u64)page_counter_read(counter) * PAGE_SIZE;
-	case RES_LIMIT:
-		return (u64)counter->max * PAGE_SIZE;
-	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
-	case RES_FAILCNT:
-		return counter->failcnt;
-	case RES_SOFT_LIMIT:
-		return (u64)READ_ONCE(memcg->soft_limit) * PAGE_SIZE;
-	default:
-		BUG();
-	}
-}
-
-/*
- * This function doesn't do anything useful. Its only job is to provide a read
- * handler for a file so that cgroup_file_mode() will add read permissions.
- */
-static int mem_cgroup_dummy_seq_show(__always_unused struct seq_file *m,
-				     __always_unused void *v)
-{
-	return -EINVAL;
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
@@ -3373,139 +3190,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
-{
-	int ret;
-
-	mutex_lock(&memcg_max_mutex);
-
-	ret = page_counter_set_max(&memcg->tcpmem, max);
-	if (ret)
-		goto out;
-
-	if (!memcg->tcpmem_active) {
-		/*
-		 * The active flag needs to be written after the static_key
-		 * update. This is what guarantees that the socket activation
-		 * function is the last one to run. See mem_cgroup_sk_alloc()
-		 * for details, and note that we don't mark any socket as
-		 * belonging to this memcg until that flag is up.
-		 *
-		 * We need to do this, because static_keys will span multiple
-		 * sites, but we can't control their order. If we mark a socket
-		 * as accounted, but the accounting functions are not patched in
-		 * yet, we'll lose accounting.
-		 *
-		 * We never race with the readers in mem_cgroup_sk_alloc(),
-		 * because when this value change, the code to process it is not
-		 * patched in yet.
-		 */
-		static_branch_inc(&memcg_sockets_enabled_key);
-		memcg->tcpmem_active = true;
-	}
-out:
-	mutex_unlock(&memcg_max_mutex);
-	return ret;
-}
-
-/*
- * The user of this function is...
- * RES_LIMIT.
- */
-static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
-				char *buf, size_t nbytes, loff_t off)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned long nr_pages;
-	int ret;
-
-	buf = strstrip(buf);
-	ret = page_counter_memparse(buf, "-1", &nr_pages);
-	if (ret)
-		return ret;
-
-	switch (MEMFILE_ATTR(of_cft(of)->private)) {
-	case RES_LIMIT:
-		if (mem_cgroup_is_root(memcg)) { /* Can't set limit on root */
-			ret = -EINVAL;
-			break;
-		}
-		switch (MEMFILE_TYPE(of_cft(of)->private)) {
-		case _MEM:
-			ret = mem_cgroup_resize_max(memcg, nr_pages, false);
-			break;
-		case _MEMSWAP:
-			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
-			break;
-		case _KMEM:
-			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
-				     "Writing any value to this file has no effect. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
-			ret = 0;
-			break;
-		case _TCP:
-			ret = memcg_update_tcp_max(memcg, nr_pages);
-			break;
-		}
-		break;
-	case RES_SOFT_LIMIT:
-		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			ret = -EOPNOTSUPP;
-		} else {
-			WRITE_ONCE(memcg->soft_limit, nr_pages);
-			ret = 0;
-		}
-		break;
-	}
-	return ret ?: nbytes;
-}
-
-static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
-				size_t nbytes, loff_t off)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	struct page_counter *counter;
-
-	switch (MEMFILE_TYPE(of_cft(of)->private)) {
-	case _MEM:
-		counter = &memcg->memory;
-		break;
-	case _MEMSWAP:
-		counter = &memcg->memsw;
-		break;
-	case _KMEM:
-		counter = &memcg->kmem;
-		break;
-	case _TCP:
-		counter = &memcg->tcpmem;
-		break;
-	default:
-		BUG();
-	}
-
-	switch (MEMFILE_ATTR(of_cft(of)->private)) {
-	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
-		break;
-	case RES_FAILCNT:
-		counter->failcnt = 0;
-		break;
-	default:
-		BUG();
-	}
-
-	return nbytes;
-}
-
-#ifdef CONFIG_NUMA
-
-#define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
-#define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
-#define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
-
-static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-				int nid, unsigned int lru_mask, bool tree)
+unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+					   int nid, unsigned int lru_mask,
+					   bool tree)
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 	unsigned long nr = 0;
@@ -3524,9 +3211,8 @@ static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 	return nr;
 }
 
-static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
-					     unsigned int lru_mask,
-					     bool tree)
+unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
+				      unsigned int lru_mask, bool tree)
 {
 	unsigned long nr = 0;
 	enum lru_list lru;
@@ -3542,221 +3228,6 @@ static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
 	return nr;
 }
 
-static int memcg_numa_stat_show(struct seq_file *m, void *v)
-{
-	struct numa_stat {
-		const char *name;
-		unsigned int lru_mask;
-	};
-
-	static const struct numa_stat stats[] = {
-		{ "total", LRU_ALL },
-		{ "file", LRU_ALL_FILE },
-		{ "anon", LRU_ALL_ANON },
-		{ "unevictable", BIT(LRU_UNEVICTABLE) },
-	};
-	const struct numa_stat *stat;
-	int nid;
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-
-	mem_cgroup_flush_stats(memcg);
-
-	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-		seq_printf(m, "%s=%lu", stat->name,
-			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-						   false));
-		for_each_node_state(nid, N_MEMORY)
-			seq_printf(m, " N%d=%lu", nid,
-				   mem_cgroup_node_nr_lru_pages(memcg, nid,
-							stat->lru_mask, false));
-		seq_putc(m, '\n');
-	}
-
-	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-
-		seq_printf(m, "hierarchical_%s=%lu", stat->name,
-			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
-						   true));
-		for_each_node_state(nid, N_MEMORY)
-			seq_printf(m, " N%d=%lu", nid,
-				   mem_cgroup_node_nr_lru_pages(memcg, nid,
-							stat->lru_mask, true));
-		seq_putc(m, '\n');
-	}
-
-	return 0;
-}
-#endif /* CONFIG_NUMA */
-
-static const unsigned int memcg1_stats[] = {
-	NR_FILE_PAGES,
-	NR_ANON_MAPPED,
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	NR_ANON_THPS,
-#endif
-	NR_SHMEM,
-	NR_FILE_MAPPED,
-	NR_FILE_DIRTY,
-	NR_WRITEBACK,
-	WORKINGSET_REFAULT_ANON,
-	WORKINGSET_REFAULT_FILE,
-#ifdef CONFIG_SWAP
-	MEMCG_SWAP,
-	NR_SWAPCACHE,
-#endif
-};
-
-static const char *const memcg1_stat_names[] = {
-	"cache",
-	"rss",
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	"rss_huge",
-#endif
-	"shmem",
-	"mapped_file",
-	"dirty",
-	"writeback",
-	"workingset_refault_anon",
-	"workingset_refault_file",
-#ifdef CONFIG_SWAP
-	"swap",
-	"swapcached",
-#endif
-};
-
-/* Universal VM events cgroup1 shows, original sort order */
-static const unsigned int memcg1_events[] = {
-	PGPGIN,
-	PGPGOUT,
-	PGFAULT,
-	PGMAJFAULT,
-};
-
-static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
-{
-	unsigned long memory, memsw;
-	struct mem_cgroup *mi;
-	unsigned int i;
-
-	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
-
-	mem_cgroup_flush_stats(memcg);
-
-	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
-		unsigned long nr;
-
-		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
-			       memcg_events_local(memcg, memcg1_events[i]));
-
-	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
-			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
-
-	/* Hierarchical information */
-	memory = memsw = PAGE_COUNTER_MAX;
-	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
-		memory = min(memory, READ_ONCE(mi->memory.max));
-		memsw = min(memsw, READ_ONCE(mi->memsw.max));
-	}
-	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
-		       (u64)memory * PAGE_SIZE);
-	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
-		       (u64)memsw * PAGE_SIZE);
-
-	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
-		unsigned long nr;
-
-		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
-			       (u64)nr);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_buf_printf(s, "total_%s %llu\n",
-			       vm_event_name(memcg1_events[i]),
-			       (u64)memcg_events(memcg, memcg1_events[i]));
-
-	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
-			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
-
-#ifdef CONFIG_DEBUG_VM
-	{
-		pg_data_t *pgdat;
-		struct mem_cgroup_per_node *mz;
-		unsigned long anon_cost = 0;
-		unsigned long file_cost = 0;
-
-		for_each_online_pgdat(pgdat) {
-			mz = memcg->nodeinfo[pgdat->node_id];
-
-			anon_cost += mz->lruvec.anon_cost;
-			file_cost += mz->lruvec.file_cost;
-		}
-		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
-		seq_buf_printf(s, "file_cost %lu\n", file_cost);
-	}
-#endif
-}
-
-static u64 mem_cgroup_swappiness_read(struct cgroup_subsys_state *css,
-				      struct cftype *cft)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-
-	return mem_cgroup_swappiness(memcg);
-}
-
-static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
-				       struct cftype *cft, u64 val)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-
-	if (val > MAX_SWAPPINESS)
-		return -EINVAL;
-
-	if (!mem_cgroup_is_root(memcg))
-		WRITE_ONCE(memcg->swappiness, val);
-	else
-		WRITE_ONCE(vm_swappiness, val);
-
-	return 0;
-}
-
-static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
-
-	seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill_disable));
-	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
-	seq_printf(sf, "oom_kill %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
-	return 0;
-}
-
-static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
-	struct cftype *cft, u64 val)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-
-	/* cannot set to root cgroup and only 0 and 1 are allowed */
-	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
-		return -EINVAL;
-
-	WRITE_ONCE(memcg->oom_kill_disable, val);
-	if (!val)
-		memcg1_oom_recover(memcg);
-
-	return 0;
-}
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <trace/events/writeback.h>
@@ -3970,147 +3441,6 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
-static int mem_cgroup_slab_show(struct seq_file *m, void *p)
-{
-	/*
-	 * Deprecated.
-	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
-	 */
-	return 0;
-}
-#endif
-
-static int memory_stat_show(struct seq_file *m, void *v);
-
-static struct cftype mem_cgroup_legacy_files[] = {
-	{
-		.name = "usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_USAGE),
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_MAX_USAGE),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_LIMIT),
-		.write = mem_cgroup_write,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "soft_limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_SOFT_LIMIT),
-		.write = mem_cgroup_write,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "failcnt",
-		.private = MEMFILE_PRIVATE(_MEM, RES_FAILCNT),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "stat",
-		.seq_show = memory_stat_show,
-	},
-	{
-		.name = "force_empty",
-		.write = mem_cgroup_force_empty_write,
-	},
-	{
-		.name = "use_hierarchy",
-		.write_u64 = mem_cgroup_hierarchy_write,
-		.read_u64 = mem_cgroup_hierarchy_read,
-	},
-	{
-		.name = "cgroup.event_control",		/* XXX: for compat */
-		.write = memcg_write_event_control,
-		.flags = CFTYPE_NO_PREFIX | CFTYPE_WORLD_WRITABLE,
-	},
-	{
-		.name = "swappiness",
-		.read_u64 = mem_cgroup_swappiness_read,
-		.write_u64 = mem_cgroup_swappiness_write,
-	},
-	{
-		.name = "move_charge_at_immigrate",
-		.read_u64 = mem_cgroup_move_charge_read,
-		.write_u64 = mem_cgroup_move_charge_write,
-	},
-	{
-		.name = "oom_control",
-		.seq_show = mem_cgroup_oom_control_read,
-		.write_u64 = mem_cgroup_oom_control_write,
-	},
-	{
-		.name = "pressure_level",
-		.seq_show = mem_cgroup_dummy_seq_show,
-	},
-#ifdef CONFIG_NUMA
-	{
-		.name = "numa_stat",
-		.seq_show = memcg_numa_stat_show,
-	},
-#endif
-	{
-		.name = "kmem.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
-		.write = mem_cgroup_write,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "kmem.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "kmem.failcnt",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_FAILCNT),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "kmem.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_MAX_USAGE),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
-	{
-		.name = "kmem.slabinfo",
-		.seq_show = mem_cgroup_slab_show,
-	},
-#endif
-	{
-		.name = "kmem.tcp.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_LIMIT),
-		.write = mem_cgroup_write,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "kmem.tcp.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_USAGE),
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "kmem.tcp.failcnt",
-		.private = MEMFILE_PRIVATE(_TCP, RES_FAILCNT),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "kmem.tcp.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_MAX_USAGE),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{ },	/* terminate */
-};
-
 /*
  * Private memory cgroup IDR
  *
@@ -4902,7 +4232,7 @@ static int memory_events_local_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int memory_stat_show(struct seq_file *m, void *v)
+int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
@@ -6133,33 +5463,6 @@ static struct cftype swap_files[] = {
 	{ }	/* terminate */
 };
 
-static struct cftype memsw_files[] = {
-	{
-		.name = "memsw.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_USAGE),
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "memsw.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_MAX_USAGE),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "memsw.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_LIMIT),
-		.write = mem_cgroup_write,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
-		.name = "memsw.failcnt",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_FAILCNT),
-		.write = mem_cgroup_reset,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{ },	/* terminate */
-};
-
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 /**
  * obj_cgroup_may_zswap - check if this cgroup can zswap
-- 
2.45.2


