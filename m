Return-Path: <cgroups+bounces-17120-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ShaeCjW3OGquggcAu9opvQ
	(envelope-from <cgroups+bounces-17120-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:16:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B5F6AC7CB
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ox5tndNy;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17120-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17120-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C8663004DA2
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 04:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3135202A;
	Mon, 22 Jun 2026 04:16:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AA350A35
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 04:16:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101806; cv=none; b=EqxCV+2O9oD5Arigzl7n6jIpRIgtCFdx9ZJYw3oSr2inSMsZHhrcY2y87F5bkmCs+GVjxxx/Zmxy7F4ORXwr1zUvdjUTGL8mGQvKtMsSLE5mA9Pb47xJwSgV65zg/TlhHTF3I06uNlKnNlP+HHjHvUbnGwaUit3QBeTQRhXQd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101806; c=relaxed/simple;
	bh=sEOz2DrJmp1FKtI+rItkKa0ROKzasUMF+o5WmvS/lww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0F5bW30GD5ckQodD9nzCLub0YXGO0D+y4zWUV4+1nyfRMli0r2zm8KDSlq6vylfFi3cwYG7uAMxpeeP32frlrjpaqSTEHSkz3YsGACbPwLHfocoQ6GvLZxf89PBGpJRrXPT9zihFzknYsKg3FLxO8Jh6eaBljvRd8qaxLvV7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ox5tndNy; arc=none smtp.client-ip=95.215.58.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782101791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydhrMYh/FkXi0lKdXWn/leJ82BKVh5TQi1wwVrTwm4s=;
	b=ox5tndNyzofaF3LHxl+P2CzaB4PLN5KcCZb22z0Sm7flknBZkEgF+aQ/TRTtQAH15F1an4
	+wqLeEjzHBG8SvT05FrpW+AIhd5bjp4s6zjVJh+s5s7SBYuxClx/g0wGxCULHkvmV7jrA7
	QgU7+GGqBXWs21sl6X5raQrx/WzyoJ0=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Chinner <david@fromorbit.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	damon@lists.linux.dev,
	cgroups@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v3 3/7] mm: Use mutable list iterators
Date: Mon, 22 Jun 2026 12:15:29 +0800
Message-ID: <20260622041529.30643-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260622040533.29824-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:sj@kernel.org,m:muchun.song@linux.dev,m:osalvador@suse.de,m:catalin.marinas@arm.com,m:david@fromorbit.com,m:shakeel.butt@linux.dev,m:linmiaohe@huawei.com,m:dennis@kernel.org,m:tj@kernel.org,m:cl@gentwo.org,m:hughd@google.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:urezki@gmail.com,m:minchan@kernel.org,m:senozhatsky@chromium.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:virtualization@lists.linux.dev,m:damon@lists.linux.dev,m:cgroups@vger.kernel.org,m:chengkaitao@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,linux.dev,suse.de,arm.com,fromorbit.com,huawei.com,gentwo.org,google.com,tencent.com,gmail.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[kaitao.cheng@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17120-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaitao.cheng@linux.dev,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8B5F6AC7CB

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The safe list iterators expose a temporary cursor at every call site,
even when the cursor is only needed by the iterator itself.  The mutable
iterator variants keep the removal-safe traversal semantics while hiding
that temporary cursor from callers that do not need it.

Convert mm users of the list, hlist and llist safe iterators to the new
mutable helpers.  Drop the temporary cursor variables where the loop does
not inspect or reset them, and keep the explicit cursor at the few sites
that rely on it across lock drops or after the loop.

This is a mechanical cleanup with no intended change in traversal order
or list mutation behavior.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 mm/backing-dev.c         |  8 +++---
 mm/balloon.c             |  8 +++---
 mm/cma.c                 |  4 +--
 mm/compaction.c          |  4 +--
 mm/damon/core.c          |  4 +--
 mm/damon/sysfs-schemes.c |  4 +--
 mm/dmapool.c             |  4 +--
 mm/huge_memory.c         |  8 +++---
 mm/hugetlb.c             | 56 ++++++++++++++++++++--------------------
 mm/hugetlb_vmemmap.c     | 16 ++++++------
 mm/khugepaged.c          | 14 +++++-----
 mm/kmemleak.c            |  7 +++--
 mm/ksm.c                 | 25 +++++++-----------
 mm/list_lru.c            |  4 +--
 mm/memcontrol-v1.c       |  8 +++---
 mm/memory-failure.c      | 12 ++++-----
 mm/memory-tiers.c        |  4 +--
 mm/migrate.c             | 23 ++++++++---------
 mm/mmu_notifier.c        |  9 +++----
 mm/page_alloc.c          |  8 +++---
 mm/page_reporting.c      |  2 +-
 mm/percpu.c              | 11 ++++----
 mm/pgtable-generic.c     |  4 +--
 mm/rmap.c                | 10 +++----
 mm/shmem.c               |  9 ++++---
 mm/slab_common.c         | 14 +++++-----
 mm/slub.c                | 33 ++++++++++++-----------
 mm/swapfile.c            |  4 +--
 mm/userfaultfd.c         | 12 ++++-----
 mm/vmalloc.c             | 24 ++++++++---------
 mm/vmscan.c              |  7 +++--
 mm/zsmalloc.c            |  4 +--
 32 files changed, 175 insertions(+), 189 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index cecbcf9060a6..944b9cc7a424 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -932,10 +932,10 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
 void wb_memcg_offline(struct mem_cgroup *memcg)
 {
 	struct list_head *memcg_cgwb_list = &memcg->cgwb_list;
-	struct bdi_writeback *wb, *next;
+	struct bdi_writeback *wb;
 
 	spin_lock_irq(&cgwb_lock);
-	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
+	list_for_each_entry_mutable(wb, memcg_cgwb_list, memcg_node)
 		cgwb_kill(wb);
 	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
@@ -951,11 +951,11 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
  */
 void wb_blkcg_offline(struct cgroup_subsys_state *css)
 {
-	struct bdi_writeback *wb, *next;
+	struct bdi_writeback *wb;
 	struct list_head *list = blkcg_get_cgwb_list(css);
 
 	spin_lock_irq(&cgwb_lock);
-	list_for_each_entry_safe(wb, next, list, blkcg_node)
+	list_for_each_entry_mutable(wb, list, blkcg_node)
 		cgwb_kill(wb);
 	list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc6..74a7c411b244 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -75,12 +75,12 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct list_head *pages)
 {
-	struct page *page, *tmp;
+	struct page *page;
 	unsigned long flags;
 	size_t n_pages = 0;
 
 	spin_lock_irqsave(&balloon_pages_lock, flags);
-	list_for_each_entry_safe(page, tmp, pages, lru) {
+	list_for_each_entry_mutable(page, pages, lru) {
 		list_del(&page->lru);
 		balloon_page_enqueue_one(b_dev_info, page);
 		n_pages++;
@@ -111,12 +111,12 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
 size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				 struct list_head *pages, size_t n_req_pages)
 {
-	struct page *page, *tmp;
+	struct page *page;
 	unsigned long flags;
 	size_t n_pages = 0;
 
 	spin_lock_irqsave(&balloon_pages_lock, flags);
-	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
+	list_for_each_entry_mutable(page, &b_dev_info->pages, lru) {
 		if (n_pages == n_req_pages)
 			break;
 		list_del(&page->lru);
diff --git a/mm/cma.c b/mm/cma.c
index a13ce4999b39..2c6543fe530e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -539,7 +539,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	struct cma_memrange *cmrp;
 	LIST_HEAD(ranges);
 	LIST_HEAD(final_ranges);
-	struct list_head *mp, *next;
+	struct list_head *mp;
 	int ret, nr = 1;
 	u64 i;
 	struct cma *cma;
@@ -648,7 +648,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	 * want to mimic a bottom-up memblock allocation.
 	 */
 	sizesum = 0;
-	list_for_each_safe(mp, next, &ranges) {
+	list_for_each_mutable(mp, &ranges) {
 		mlp = list_entry(mp, struct cma_init_memrange, list);
 		list_del(mp);
 		list_insert_sorted(&final_ranges, mlp, basecmp);
diff --git a/mm/compaction.c b/mm/compaction.c
index b776f35ad020..1734f7978983 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -94,9 +94,9 @@ static unsigned long release_free_list(struct list_head *freepages)
 	unsigned long high_pfn = 0;
 
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
-		struct page *page, *next;
+		struct page *page;
 
-		list_for_each_entry_safe(page, next, &freepages[order], lru) {
+		list_for_each_entry_mutable(page, &freepages[order], lru) {
 			unsigned long pfn = page_to_pfn(page);
 
 			list_del(&page->lru);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7e4b9affc5b0..bb1f4466f7af 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3394,7 +3394,7 @@ static void damon_verify_ctx(struct damon_ctx *c)
  */
 static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 {
-	struct damon_call_control *control, *next;
+	struct damon_call_control *control;
 	LIST_HEAD(controls);
 
 	damon_verify_ctx(ctx);
@@ -3403,7 +3403,7 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 	list_splice_tail_init(&ctx->call_controls, &controls);
 	mutex_unlock(&ctx->call_controls_lock);
 
-	list_for_each_entry_safe(control, next, &controls, list) {
+	list_for_each_entry_mutable(control, &controls, list) {
 		if (!control->repeat || cancel)
 			list_del(&control->list);
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..701b1947bad4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -329,9 +329,9 @@ static ssize_t total_bytes_show(struct kobject *kobj,
 static void damon_sysfs_scheme_regions_rm_dirs(
 		struct damon_sysfs_scheme_regions *regions)
 {
-	struct damon_sysfs_scheme_region *r, *next;
+	struct damon_sysfs_scheme_region *r;
 
-	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
+	list_for_each_entry_mutable(r, &regions->regions_list, list) {
 		damos_sysfs_region_rm_dirs(r);
 		list_del(&r->list);
 		kobject_put(&r->kobj);
diff --git a/mm/dmapool.c b/mm/dmapool.c
index 5d8af6e29127..226b505ace23 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -362,7 +362,7 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
  */
 void dma_pool_destroy(struct dma_pool *pool)
 {
-	struct dma_page *page, *tmp;
+	struct dma_page *page;
 	bool empty, busy = false;
 
 	if (unlikely(!pool))
@@ -382,7 +382,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 		busy = true;
 	}
 
-	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
+	list_for_each_entry_mutable(page, &pool->page_list, page_list) {
 		if (!busy)
 			dma_free_coherent(pool->dev, pool->allocation,
 					  page->vaddr, page->dma);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..39d604f0876d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -924,9 +924,9 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 
 static void __init hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 {
-	struct thpsize *thpsize, *tmp;
+	struct thpsize *thpsize;
 
-	list_for_each_entry_safe(thpsize, tmp, &thpsize_list, node) {
+	list_for_each_entry_mutable(thpsize, &thpsize_list, node) {
 		list_del(&thpsize->node);
 		kobject_put(&thpsize->kobj);
 	}
@@ -4462,14 +4462,14 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
 	LIST_HEAD(dispose);
-	struct folio *folio, *next;
+	struct folio *folio;
 	int split = 0;
 	unsigned long isolated;
 
 	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
 					    deferred_split_isolate, &dispose);
 
-	list_for_each_entry_safe(folio, next, &dispose, _deferred_list) {
+	list_for_each_entry_mutable(folio, &dispose, _deferred_list) {
 		bool did_split = false;
 		bool underused = false;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..765552a56086 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -598,7 +598,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	long add = 0;
 	struct list_head *head = &resv->regions;
 	long last_accounted_offset = f;
-	struct file_region *iter, *trg = NULL;
+	struct file_region *iter;
 	struct list_head *rg = NULL;
 
 	if (regions_needed)
@@ -608,7 +608,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	 * [last_accounted_offset, iter->from), at every iteration, with some
 	 * bounds checking.
 	 */
-	list_for_each_entry_safe(iter, trg, head, link) {
+	list_for_each_entry_mutable(iter, head, link) {
 		/* Skip irrelevant regions that start before our range. */
 		if (iter->from < f) {
 			/* If this region ends after the last accounted offset,
@@ -700,7 +700,7 @@ static int allocate_file_region_entries(struct resv_map *resv,
 	return 0;
 
 out_of_memory:
-	list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+	list_for_each_entry_mutable(rg, &allocated_regions, link) {
 		list_del(&rg->link);
 		kfree(rg);
 	}
@@ -853,13 +853,13 @@ static void region_abort(struct resv_map *resv, long f, long t,
 static long region_del(struct resv_map *resv, long f, long t)
 {
 	struct list_head *head = &resv->regions;
-	struct file_region *rg, *trg;
+	struct file_region *rg;
 	struct file_region *nrg = NULL;
 	long del = 0;
 
 retry:
 	spin_lock(&resv->lock);
-	list_for_each_entry_safe(rg, trg, head, link) {
+	list_for_each_entry_mutable(rg, head, link) {
 		/*
 		 * Skip regions before the range to be deleted.  file_region
 		 * ranges are normally of the form [from, to).  However, there
@@ -1109,13 +1109,13 @@ void resv_map_release(struct kref *ref)
 {
 	struct resv_map *resv_map = container_of(ref, struct resv_map, refs);
 	struct list_head *head = &resv_map->region_cache;
-	struct file_region *rg, *trg;
+	struct file_region *rg;
 
 	/* Clear out any active regions before we release the map. */
 	region_del(resv_map, 0, LONG_MAX);
 
 	/* ... and any entries left in the cache */
-	list_for_each_entry_safe(rg, trg, head, link) {
+	list_for_each_entry_mutable(rg, head, link) {
 		list_del(&rg->link);
 		kfree(rg);
 	}
@@ -1582,7 +1582,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios)
 {
-	struct folio *folio, *t_folio;
+	struct folio *folio;
 
 	if (!list_empty(non_hvo_folios)) {
 		/*
@@ -1592,7 +1592,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 		 * hugetlb pages with vmemmap we will free up memory so that we
 		 * can allocate vmemmap for more hugetlb pages.
 		 */
-		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
+		list_for_each_entry_mutable(folio, non_hvo_folios, lru) {
 			list_del(&folio->lru);
 			spin_lock_irq(&hugetlb_lock);
 			__folio_clear_hugetlb(folio);
@@ -1611,7 +1611,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
 		 * If are able to restore vmemmap and free one hugetlb page, we
 		 * quit processing the list to retry the bulk operation.
 		 */
-		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
+		list_for_each_entry_mutable(folio, folio_list, lru)
 			if (hugetlb_vmemmap_restore_folio(h, folio)) {
 				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
@@ -1633,7 +1633,7 @@ static void update_and_free_pages_bulk(struct hstate *h,
 						struct list_head *folio_list)
 {
 	long ret;
-	struct folio *folio, *t_folio;
+	struct folio *folio;
 	LIST_HEAD(non_hvo_folios);
 
 	/*
@@ -1664,7 +1664,7 @@ static void update_and_free_pages_bulk(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
+	list_for_each_entry_mutable(folio, &non_hvo_folios, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
@@ -1875,14 +1875,14 @@ void prep_and_add_allocated_folios(struct hstate *h,
 				   struct list_head *folio_list)
 {
 	unsigned long flags;
-	struct folio *folio, *tmp_f;
+	struct folio *folio;
 
 	/* Send list for bulk vmemmap optimization processing */
 	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
 	/* Add all new pool pages to free lists in one lock cycle */
 	spin_lock_irqsave(&hugetlb_lock, flags);
-	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+	list_for_each_entry_mutable(folio, folio_list, lru) {
 		account_new_hugetlb_folio(h, folio);
 		enqueue_hugetlb_folio(h, folio);
 	}
@@ -2246,7 +2246,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	LIST_HEAD(surplus_list);
-	struct folio *folio, *tmp;
+	struct folio *folio;
 	int ret;
 	long i;
 	long needed, allocated;
@@ -2319,7 +2319,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	ret = 0;
 
 	/* Free the needed pages to the hugetlb pool */
-	list_for_each_entry_safe(folio, tmp, &surplus_list, lru) {
+	list_for_each_entry_mutable(folio, &surplus_list, lru) {
 		if ((--needed) < 0)
 			break;
 		/* Add the page to the hugetlb allocator */
@@ -2332,7 +2332,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	 * Free unnecessary surplus pages to the buddy allocator.
 	 * Pages have no ref count, call free_huge_folio directly.
 	 */
-	list_for_each_entry_safe(folio, tmp, &surplus_list, lru)
+	list_for_each_entry_mutable(folio, &surplus_list, lru)
 		free_huge_folio(folio);
 	spin_lock_irq(&hugetlb_lock);
 
@@ -3197,12 +3197,12 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 					struct list_head *folio_list)
 {
 	unsigned long flags;
-	struct folio *folio, *tmp_f;
+	struct folio *folio;
 
 	/* Send list for bulk vmemmap optimization processing */
 	hugetlb_vmemmap_optimize_bootmem_folios(h, folio_list);
 
-	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+	list_for_each_entry_mutable(folio, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
 			/*
 			 * If HVO fails, initialize all tail struct pages
@@ -3281,10 +3281,10 @@ static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
 static void __init gather_bootmem_prealloc_node(unsigned long nid)
 {
 	LIST_HEAD(folio_list);
-	struct huge_bootmem_page *m, *tm;
+	struct huge_bootmem_page *m;
 	struct hstate *h = NULL, *prev_h = NULL;
 
-	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
+	list_for_each_entry_mutable(m, &huge_boot_pages[nid], list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
 
@@ -3669,9 +3669,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
-		struct folio *folio, *next;
+		struct folio *folio;
 		struct list_head *freel = &h->hugepage_freelists[i];
-		list_for_each_entry_safe(folio, next, freel, lru) {
+		list_for_each_entry_mutable(folio, freel, lru) {
 			if (count >= h->nr_huge_pages)
 				goto out;
 			if (folio_test_highmem(folio))
@@ -3920,7 +3920,7 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
 				       struct list_head *src_list)
 {
 	long rc;
-	struct folio *folio, *next;
+	struct folio *folio;
 	LIST_HEAD(dst_list);
 	LIST_HEAD(ret_list);
 
@@ -3937,7 +3937,7 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
 	 */
 	mutex_lock(&dst->resize_lock);
 
-	list_for_each_entry_safe(folio, next, src_list, lru) {
+	list_for_each_entry_mutable(folio, src_list, lru) {
 		int i;
 		bool cma;
 
@@ -3995,9 +3995,9 @@ long demote_pool_huge_page(struct hstate *src, nodemask_t *nodes_allowed,
 
 	for_each_node_mask_to_free(src, nr_nodes, node, nodes_allowed) {
 		LIST_HEAD(list);
-		struct folio *folio, *next;
+		struct folio *folio;
 
-		list_for_each_entry_safe(folio, next, &src->hugepage_freelists[node], lru) {
+		list_for_each_entry_mutable(folio, &src->hugepage_freelists[node], lru) {
 			if (folio_test_hwpoison(folio))
 				continue;
 
@@ -4014,7 +4014,7 @@ long demote_pool_huge_page(struct hstate *src, nodemask_t *nodes_allowed,
 
 		spin_lock_irq(&hugetlb_lock);
 
-		list_for_each_entry_safe(folio, next, &list, lru) {
+		list_for_each_entry_mutable(folio, &list, lru) {
 			list_del(&folio->lru);
 			add_hugetlb_folio(src, folio, false);
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 133b46dfb09f..88552d60ae60 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -193,9 +193,9 @@ static inline void free_vmemmap_page(struct page *page)
 /* Free a list of the vmemmap pages */
 static void free_vmemmap_page_list(struct list_head *list)
 {
-	struct page *page, *next;
+	struct page *page;
 
-	list_for_each_entry_safe(page, next, list, lru)
+	list_for_each_entry_mutable(page, list, lru)
 		free_vmemmap_page(page);
 }
 
@@ -339,7 +339,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
-	struct page *page, *next;
+	struct page *page;
 	int i;
 
 	for (i = 0; i < nr_pages; i++) {
@@ -352,7 +352,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 
 	return 0;
 out:
-	list_for_each_entry_safe(page, next, list, lru)
+	list_for_each_entry_mutable(page, list, lru)
 		__free_page(page);
 	return -ENOMEM;
 }
@@ -454,12 +454,12 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 					struct list_head *folio_list,
 					struct list_head *non_hvo_folios)
 {
-	struct folio *folio, *t_folio;
+	struct folio *folio;
 	long restored = 0;
 	long ret = 0;
 	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
-	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
+	list_for_each_entry_mutable(folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
 			ret = __hugetlb_vmemmap_restore_folio(h, folio, flags);
 			if (ret)
@@ -800,7 +800,7 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
 
 void __init hugetlb_vmemmap_init_late(int nid)
 {
-	struct huge_bootmem_page *m, *tm;
+	struct huge_bootmem_page *m;
 	unsigned long phys, nr_pages, start, end;
 	unsigned long pfn, nr_mmap;
 	struct zone *zone = NULL;
@@ -810,7 +810,7 @@ void __init hugetlb_vmemmap_init_late(int nid)
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return;
 
-	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
+	list_for_each_entry_mutable(m, &huge_boot_pages[nid], list) {
 		if (!(m->flags & HUGE_BOOTMEM_HVO))
 			continue;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 617bca76db49..66a1d72b5cb8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -640,7 +640,7 @@ static void release_pte_folio(struct folio *folio)
 static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		struct list_head *compound_pagelist)
 {
-	struct folio *folio, *tmp;
+	struct folio *folio;
 
 	while (--_pte >= pte) {
 		pte_t pteval = ptep_get(_pte);
@@ -658,7 +658,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		release_pte_folio(folio);
 	}
 
-	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
+	list_for_each_entry_mutable(folio, compound_pagelist, lru) {
 		list_del(&folio->lru);
 		release_pte_folio(folio);
 	}
@@ -835,7 +835,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 {
 	const unsigned long nr_pages = 1UL << order;
 	unsigned long end = address + (PAGE_SIZE * nr_pages);
-	struct folio *src, *tmp;
+	struct folio *src;
 	pte_t pteval;
 	pte_t *_pte;
 	unsigned int nr_ptes;
@@ -882,7 +882,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 		}
 	}
 
-	list_for_each_entry_safe(src, tmp, compound_pagelist, lru) {
+	list_for_each_entry_mutable(src, compound_pagelist, lru) {
 		list_del(&src->lru);
 		node_stat_sub_folio(src, NR_ISOLATED_ANON +
 				folio_is_file_lru(src));
@@ -2244,7 +2244,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 {
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
-	struct folio *folio, *tmp, *new_folio;
+	struct folio *folio, *new_folio;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -2629,7 +2629,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	/*
 	 * The collapse has succeeded, so free the old folios.
 	 */
-	list_for_each_entry_safe(folio, tmp, &pagelist, lru) {
+	list_for_each_entry_mutable(folio, &pagelist, lru) {
 		list_del(&folio->lru);
 		lruvec_stat_mod_folio(folio, NR_FILE_PAGES,
 				      -folio_nr_pages(folio));
@@ -2654,7 +2654,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		shmem_uncharge(mapping->host, nr_none);
 	}
 
-	list_for_each_entry_safe(folio, tmp, &pagelist, lru) {
+	list_for_each_entry_mutable(folio, &pagelist, lru) {
 		list_del(&folio->lru);
 		folio_unlock(folio);
 		folio_putback_lru(folio);
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7c7ba17ce7af..0c0265f7b19f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -537,7 +537,6 @@ static void mem_pool_free(struct kmemleak_object *object)
  */
 static void free_object_rcu(struct rcu_head *rcu)
 {
-	struct hlist_node *tmp;
 	struct kmemleak_scan_area *area;
 	struct kmemleak_object *object =
 		container_of(rcu, struct kmemleak_object, rcu);
@@ -546,7 +545,7 @@ static void free_object_rcu(struct rcu_head *rcu)
 	 * Once use_count is 0 (guaranteed by put_object), there is no other
 	 * code accessing this object, hence no need for locking.
 	 */
-	hlist_for_each_entry_safe(area, tmp, &object->area_list, node) {
+	hlist_for_each_entry_mutable(area, &object->area_list, node) {
 		hlist_del(&area->node);
 		kmem_cache_free(scan_area_cache, area);
 	}
@@ -2324,14 +2323,14 @@ static const struct file_operations kmemleak_fops = {
 
 static void __kmemleak_do_cleanup(void)
 {
-	struct kmemleak_object *object, *tmp;
+	struct kmemleak_object *object;
 	unsigned int cnt = 0;
 
 	/*
 	 * Kmemleak has already been disabled, no need for RCU list traversal
 	 * or kmemleak_lock held.
 	 */
-	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
+	list_for_each_entry_mutable(object, &object_list, object_list) {
 		__remove_object(object);
 		__delete_object(object);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 7d5b76478f0b..f42bc885f179 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1145,7 +1145,6 @@ static int remove_stable_node_chain(struct ksm_stable_node *stable_node,
 				    struct rb_root *root)
 {
 	struct ksm_stable_node *dup;
-	struct hlist_node *hlist_safe;
 
 	if (!is_stable_node_chain(stable_node)) {
 		VM_BUG_ON(is_stable_node_dup(stable_node));
@@ -1155,8 +1154,7 @@ static int remove_stable_node_chain(struct ksm_stable_node *stable_node,
 			return false;
 	}
 
-	hlist_for_each_entry_safe(dup, hlist_safe,
-				  &stable_node->hlist, hlist_dup) {
+	hlist_for_each_entry_mutable(dup, &stable_node->hlist, hlist_dup) {
 		VM_BUG_ON(!is_stable_node_dup(dup));
 		if (remove_stable_node(dup))
 			return true;
@@ -1168,7 +1166,7 @@ static int remove_stable_node_chain(struct ksm_stable_node *stable_node,
 
 static int remove_all_stable_nodes(void)
 {
-	struct ksm_stable_node *stable_node, *next;
+	struct ksm_stable_node *stable_node;
 	int nid;
 	int err = 0;
 
@@ -1184,7 +1182,7 @@ static int remove_all_stable_nodes(void)
 			cond_resched();
 		}
 	}
-	list_for_each_entry_safe(stable_node, next, &migrate_nodes, list) {
+	list_for_each_entry_mutable(stable_node, &migrate_nodes, list) {
 		if (remove_stable_node(stable_node))
 			err = -EBUSY;
 		cond_resched();
@@ -1665,7 +1663,6 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 				     bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
-	struct hlist_node *hlist_safe;
 	struct folio *folio, *tree_folio = NULL;
 	int found_rmap_hlist_len;
 
@@ -1677,8 +1674,7 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	else
 		stable_node->chain_prune_time = jiffies;
 
-	hlist_for_each_entry_safe(dup, hlist_safe,
-				  &stable_node->hlist, hlist_dup) {
+	hlist_for_each_entry_mutable(dup, &stable_node->hlist, hlist_dup) {
 		cond_resched();
 		/*
 		 * We must walk all stable_node_dup to prune the stale
@@ -2611,11 +2607,10 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * so prune them once before each full scan.
 		 */
 		if (!ksm_merge_across_nodes) {
-			struct ksm_stable_node *stable_node, *next;
+			struct ksm_stable_node *stable_node;
 			struct folio *folio;
 
-			list_for_each_entry_safe(stable_node, next,
-						 &migrate_nodes, list) {
+			list_for_each_entry_mutable(stable_node, &migrate_nodes, list) {
 				folio = ksm_get_folio(stable_node,
 						      KSM_GET_FOLIO_NOLOCK);
 				if (folio)
@@ -3323,7 +3318,6 @@ static bool stable_node_chain_remove_range(struct ksm_stable_node *stable_node,
 					   struct rb_root *root)
 {
 	struct ksm_stable_node *dup;
-	struct hlist_node *hlist_safe;
 
 	if (!is_stable_node_chain(stable_node)) {
 		VM_BUG_ON(is_stable_node_dup(stable_node));
@@ -3331,8 +3325,7 @@ static bool stable_node_chain_remove_range(struct ksm_stable_node *stable_node,
 						    end_pfn);
 	}
 
-	hlist_for_each_entry_safe(dup, hlist_safe,
-				  &stable_node->hlist, hlist_dup) {
+	hlist_for_each_entry_mutable(dup, &stable_node->hlist, hlist_dup) {
 		VM_BUG_ON(!is_stable_node_dup(dup));
 		stable_node_dup_remove_range(dup, start_pfn, end_pfn);
 	}
@@ -3346,7 +3339,7 @@ static bool stable_node_chain_remove_range(struct ksm_stable_node *stable_node,
 static void ksm_check_stable_tree(unsigned long start_pfn,
 				  unsigned long end_pfn)
 {
-	struct ksm_stable_node *stable_node, *next;
+	struct ksm_stable_node *stable_node;
 	struct rb_node *node;
 	int nid;
 
@@ -3364,7 +3357,7 @@ static void ksm_check_stable_tree(unsigned long start_pfn,
 			cond_resched();
 		}
 	}
-	list_for_each_entry_safe(stable_node, next, &migrate_nodes, list) {
+	list_for_each_entry_mutable(stable_node, &migrate_nodes, list) {
 		if (stable_node->kpfn >= start_pfn &&
 		    stable_node->kpfn < end_pfn)
 			remove_node_from_stable_tree(stable_node);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 36662d02ff96..ab9f48828a05 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -340,7 +340,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l = NULL;
-	struct list_head *item, *n;
+	struct list_head *item;
 	unsigned long isolated = 0;
 
 restart:
@@ -348,7 +348,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 				   /*irq_flags=*/NULL, /*skip_empty=*/true);
 	if (!l)
 		return isolated;
-	list_for_each_safe(item, n, &l->list) {
+	list_for_each_mutable(item, &l->list) {
 		enum lru_status ret;
 
 		/*
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 765069211567..2e32f84a109a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -986,11 +986,11 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
 static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd)
 {
-	struct mem_cgroup_eventfd_list *ev, *tmp;
+	struct mem_cgroup_eventfd_list *ev;
 
 	spin_lock(&memcg_oom_lock);
 
-	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
+	list_for_each_entry_mutable(ev, &memcg->oom_notify, list) {
 		if (ev->eventfd == eventfd) {
 			list_del(&ev->list);
 			kfree(ev);
@@ -1242,7 +1242,7 @@ void memcg1_memcg_init(struct mem_cgroup *memcg)
 
 void memcg1_css_offline(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup_event *event, *tmp;
+	struct mem_cgroup_event *event;
 
 	/*
 	 * Unregister events and notify userspace.
@@ -1250,7 +1250,7 @@ void memcg1_css_offline(struct mem_cgroup *memcg)
 	 * directory to avoid race between userspace and kernelspace.
 	 */
 	spin_lock_irq(&memcg->event_list_lock);
-	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
+	list_for_each_entry_mutable(event, &memcg->event_list, list) {
 		list_del_init(&event->list);
 		schedule_work(&event->remove);
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..e14d99adf378 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -423,9 +423,9 @@ static void add_to_kill_anon_file(struct task_struct *tsk, const struct page *p,
 static bool task_in_to_kill_list(struct list_head *to_kill,
 				 struct task_struct *tsk)
 {
-	struct to_kill *tk, *next;
+	struct to_kill *tk;
 
-	list_for_each_entry_safe(tk, next, to_kill, nd) {
+	list_for_each_entry_mutable(tk, to_kill, nd) {
 		if (tk->tsk == tsk)
 			return true;
 	}
@@ -450,9 +450,9 @@ void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
 static void kill_procs(struct list_head *to_kill, bool forcekill,
 		unsigned long pfn, int flags)
 {
-	struct to_kill *tk, *next;
+	struct to_kill *tk;
 
-	list_for_each_entry_safe(tk, next, to_kill, nd) {
+	list_for_each_entry_mutable(tk, to_kill, nd) {
 		if (forcekill) {
 			if (tk->addr == -EFAULT) {
 				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
@@ -1860,11 +1860,11 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
 	struct llist_node *head;
-	struct raw_hwp_page *p, *next;
+	struct raw_hwp_page *p;
 	unsigned long count = 0;
 
 	head = llist_del_all(raw_hwp_list_head(folio));
-	llist_for_each_entry_safe(p, next, head, node) {
+	llist_for_each_entry_mutable(p, head, node) {
 		if (move_flag)
 			SetPageHWPoison(p->page);
 		else
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 54851d8a195b..4e0585925ae3 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -690,9 +690,9 @@ EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
 
 void mt_put_memory_types(struct list_head *memory_types)
 {
-	struct memory_dev_type *mtype, *mtn;
+	struct memory_dev_type *mtype;
 
-	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
+	list_for_each_entry_mutable(mtype, memory_types, list) {
 		list_del(&mtype->list);
 		put_memory_type(mtype);
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716..acc7925d1d1b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -257,9 +257,8 @@ static int migrate_movable_ops_page(struct page *dst, struct page *src,
 void putback_movable_pages(struct list_head *l)
 {
 	struct folio *folio;
-	struct folio *folio2;
 
-	list_for_each_entry_safe(folio, folio2, l, lru) {
+	list_for_each_entry_mutable(folio, l, lru) {
 		if (unlikely(folio_test_hugetlb(folio))) {
 			folio_putback_hugetlb(folio);
 			continue;
@@ -336,7 +335,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 }
 
 struct rmap_walk_arg {
-	struct folio *folio;
+	struct folio *folio, *folio2;
 	bool map_unused_to_zeropage;
 };
 
@@ -1634,14 +1633,14 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 	int nr_failed = 0;
 	int nr_retry_pages = 0;
 	int pass = 0;
-	struct folio *folio, *folio2;
+	struct folio *folio;
 	int rc, nr_pages;
 
 	for (pass = 0; pass < NR_MAX_MIGRATE_PAGES_RETRY && retry; pass++) {
 		retry = 0;
 		nr_retry_pages = 0;
 
-		list_for_each_entry_safe(folio, folio2, from, lru) {
+		list_for_each_entry_mutable(folio, from, lru) {
 			if (!folio_test_hugetlb(folio))
 				continue;
 
@@ -1722,14 +1721,14 @@ static void migrate_folios_move(struct list_head *src_folios,
 		int *retry, int *thp_retry, int *nr_failed,
 		int *nr_retry_pages)
 {
-	struct folio *folio, *folio2, *dst, *dst2;
+	struct folio *folio, *dst, *dst2;
 	bool is_thp;
 	int nr_pages;
 	int rc;
 
 	dst = list_first_entry(dst_folios, struct folio, lru);
 	dst2 = list_next_entry(dst, lru);
-	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+	list_for_each_entry_mutable(folio, src_folios, lru) {
 		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 		nr_pages = folio_nr_pages(folio);
 
@@ -1770,11 +1769,11 @@ static void migrate_folios_undo(struct list_head *src_folios,
 		free_folio_t put_new_folio, unsigned long private,
 		struct list_head *ret_folios)
 {
-	struct folio *folio, *folio2, *dst, *dst2;
+	struct folio *folio, *dst, *dst2;
 
 	dst = list_first_entry(dst_folios, struct folio, lru);
 	dst2 = list_next_entry(dst, lru);
-	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+	list_for_each_entry_mutable(folio, src_folios, lru) {
 		int old_folio_state = 0;
 		struct anon_vma *anon_vma = NULL;
 
@@ -1810,7 +1809,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
-	struct folio *folio, *folio2, *dst = NULL;
+	struct folio *folio, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
@@ -1824,7 +1823,7 @@ static int migrate_pages_batch(struct list_head *from,
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		list_for_each_entry_safe(folio, folio2, from, lru) {
+		list_for_each_entry_mutable(folio, from, lru) {
 			is_large = folio_test_large(folio);
 			is_thp = folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
@@ -2109,7 +2108,7 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 
 again:
 	nr_pages = 0;
-	list_for_each_entry_safe(folio, folio2, from, lru) {
+	list_for_each_entry_mutable(folio, folio2, from, lru) {
 		/* Retried hugetlb folios will be kept in list  */
 		if (folio_test_hugetlb(folio)) {
 			list_move_tail(&folio->lru, &ret_folios);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 245b74f39f91..7d4ccf9853a3 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -131,7 +131,6 @@ mn_itree_inv_next(struct mmu_interval_notifier *interval_sub,
 static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 {
 	struct mmu_interval_notifier *interval_sub;
-	struct hlist_node *next;
 
 	spin_lock(&subscriptions->lock);
 	if (--subscriptions->active_invalidate_ranges ||
@@ -149,9 +148,7 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 	 * they are progressed. This arrangement for tree updates is used to
 	 * avoid using a blocking lock during invalidate_range_start.
 	 */
-	hlist_for_each_entry_safe(interval_sub, next,
-				  &subscriptions->deferred_list,
-				  deferred_item) {
+	hlist_for_each_entry_mutable(interval_sub, &subscriptions->deferred_list, deferred_item) {
 		if (RB_EMPTY_NODE(&interval_sub->interval_tree.rb))
 			interval_tree_insert(&interval_sub->interval_tree,
 					     &subscriptions->itree);
@@ -263,9 +260,9 @@ EXPORT_SYMBOL_GPL(mmu_interval_read_begin);
 static void mn_itree_finish_pass(struct llist_head *finish_passes)
 {
 	struct llist_node *first = llist_reverse_order(__llist_del_all(finish_passes));
-	struct mmu_interval_notifier_finish *f, *next;
+	struct mmu_interval_notifier_finish *f;
 
-	llist_for_each_entry_safe(f, next, first, link)
+	llist_for_each_entry_mutable(f, first, link)
 		f->notifier->ops->invalidate_finish(f);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee902a468c2f..6d29df3e2973 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1559,10 +1559,10 @@ static void free_one_page(struct zone *zone, struct page *page,
 	llhead = &zone->trylock_free_pages;
 	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
 		struct llist_node *llnode;
-		struct page *p, *tmp;
+		struct page *p;
 
 		llnode = llist_del_all(llhead);
-		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
+		llist_for_each_entry_mutable(p, llnode, pcp_llist) {
 			unsigned int p_order = p->private;
 
 			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
@@ -7022,10 +7022,10 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
 	int order;
 
 	for (order = 0; order < NR_PAGE_ORDERS; order++) {
-		struct page *page, *next;
+		struct page *page;
 		int nr_pages = 1 << order;
 
-		list_for_each_entry_safe(page, next, &list[order], lru) {
+		list_for_each_entry_mutable(page, &list[order], lru) {
 			int i;
 
 			post_alloc_hook(page, order, gfp_mask);
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 7418f2e500bb..849266216c9f 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -180,7 +180,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
 
 	/* loop through free list adding unreported pages to sg list */
-	list_for_each_entry_safe(page, next, list, lru) {
+	list_for_each_entry_mutable(page, next, list, lru) {
 		/* We are going to skip over the reported pages. */
 		if (PageReported(page))
 			continue;
diff --git a/mm/percpu.c b/mm/percpu.c
index b0676b8054ed..ae932e0e1ae6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1741,7 +1741,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 	bool do_warn;
 	struct obj_cgroup *objcg = NULL;
 	static atomic_t warn_limit = ATOMIC_INIT(10);
-	struct pcpu_chunk *chunk, *next;
+	struct pcpu_chunk *chunk;
 	const char *err;
 	int slot, off, cpu, ret;
 	unsigned long flags;
@@ -1814,8 +1814,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 restart:
 	/* search through normal chunks */
 	for (slot = pcpu_size_to_slot(size); slot <= pcpu_free_slot; slot++) {
-		list_for_each_entry_safe(chunk, next, &pcpu_chunk_lists[slot],
-					 list) {
+		list_for_each_entry_mutable(chunk, &pcpu_chunk_lists[slot], list) {
 			off = pcpu_find_block_fit(chunk, bits, bit_align,
 						  is_atomic);
 			if (off < 0) {
@@ -1952,7 +1951,7 @@ static void pcpu_balance_free(bool empty_only)
 {
 	LIST_HEAD(to_free);
 	struct list_head *free_head = &pcpu_chunk_lists[pcpu_free_slot];
-	struct pcpu_chunk *chunk, *next;
+	struct pcpu_chunk *chunk;
 
 	lockdep_assert_held(&pcpu_lock);
 
@@ -1960,7 +1959,7 @@ static void pcpu_balance_free(bool empty_only)
 	 * There's no reason to keep around multiple unused chunks and VM
 	 * areas can be scarce.  Destroy all free chunks except for one.
 	 */
-	list_for_each_entry_safe(chunk, next, free_head, list) {
+	list_for_each_entry_mutable(chunk, free_head, list) {
 		WARN_ON(chunk->immutable);
 
 		/* spare the first one */
@@ -1975,7 +1974,7 @@ static void pcpu_balance_free(bool empty_only)
 		return;
 
 	spin_unlock_irq(&pcpu_lock);
-	list_for_each_entry_safe(chunk, next, &to_free, list) {
+	list_for_each_entry_mutable(chunk, &to_free, list) {
 		unsigned int rs, re;
 
 		for_each_set_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..723b4bdb447d 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -426,7 +426,7 @@ static struct {
 
 static void kernel_pgtable_work_func(struct work_struct *work)
 {
-	struct ptdesc *pt, *next;
+	struct ptdesc *pt;
 	LIST_HEAD(page_list);
 
 	spin_lock(&kernel_pgtable_work.lock);
@@ -434,7 +434,7 @@ static void kernel_pgtable_work_func(struct work_struct *work)
 	spin_unlock(&kernel_pgtable_work.lock);
 
 	iommu_sva_invalidate_kva_range(PAGE_OFFSET, TLB_FLUSH_ALL);
-	list_for_each_entry_safe(pt, next, &page_list, pt_list)
+	list_for_each_entry_mutable(pt, &page_list, pt_list)
 		__pagetable_free(pt);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c77d5dc06e9..37164f446d2d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -451,9 +451,9 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
  */
 static void cleanup_partial_anon_vmas(struct vm_area_struct *vma)
 {
-	struct anon_vma_chain *avc, *next;
+	struct anon_vma_chain *avc;
 
-	list_for_each_entry_safe(avc, next, &vma->anon_vma_chain, same_vma) {
+	list_for_each_entry_mutable(avc, &vma->anon_vma_chain, same_vma) {
 		list_del(&avc->same_vma);
 		anon_vma_chain_free(avc);
 	}
@@ -478,7 +478,7 @@ static void cleanup_partial_anon_vmas(struct vm_area_struct *vma)
  */
 void unlink_anon_vmas(struct vm_area_struct *vma)
 {
-	struct anon_vma_chain *avc, *next;
+	struct anon_vma_chain *avc;
 	struct anon_vma *active_anon_vma = vma->anon_vma;
 
 	/* Always hold mmap lock, read-lock on unmap possibly. */
@@ -496,7 +496,7 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 	 * Unlink each anon_vma chained to the VMA.  This list is ordered
 	 * from newest to oldest, ensuring the root anon_vma gets freed last.
 	 */
-	list_for_each_entry_safe(avc, next, &vma->anon_vma_chain, same_vma) {
+	list_for_each_entry_mutable(avc, &vma->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma = avc->anon_vma;
 
 		anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
@@ -528,7 +528,7 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 	 * anon_vmas, destroy them. Could not do before due to __put_anon_vma()
 	 * needing to write-acquire the anon_vma->root->rwsem.
 	 */
-	list_for_each_entry_safe(avc, next, &vma->anon_vma_chain, same_vma) {
+	list_for_each_entry_mutable(avc, &vma->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma = avc->anon_vma;
 
 		VM_WARN_ON(anon_vma->num_children);
diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..9f03e46bfde2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -727,7 +727,8 @@ static const char *shmem_format_huge(int huge)
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		struct shrink_control *sc, unsigned long nr_to_free)
 {
-	LIST_HEAD(list), *pos, *next;
+	LIST_HEAD(list);
+	struct list_head *pos;
 	struct inode *inode;
 	struct shmem_inode_info *info;
 	struct folio *folio;
@@ -738,7 +739,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		return SHRINK_STOP;
 
 	spin_lock(&sbinfo->shrinklist_lock);
-	list_for_each_safe(pos, next, &sbinfo->shrinklist) {
+	list_for_each_mutable(pos, &sbinfo->shrinklist) {
 		info = list_entry(pos, struct shmem_inode_info, shrinklist);
 
 		/* pin the inode */
@@ -758,7 +759,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 	}
 	spin_unlock(&sbinfo->shrinklist_lock);
 
-	list_for_each_safe(pos, next, &list) {
+	list_for_each_mutable(pos, &list) {
 		pgoff_t next, end;
 		loff_t i_size;
 		int ret;
@@ -1547,7 +1548,7 @@ int shmem_unuse(unsigned int type)
 
 	spin_lock(&shmem_swaplist_lock);
 start_over:
-	list_for_each_entry_safe(info, next, &shmem_swaplist, swaplist) {
+	list_for_each_entry_mutable(info, next, &shmem_swaplist, swaplist) {
 		if (!info->swapped) {
 			list_del_init(&info->swaplist);
 			continue;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b6426d7ceec9..489e8e0800b6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1465,7 +1465,7 @@ static int
 drain_page_cache(struct kfree_rcu_cpu *krcp)
 {
 	unsigned long flags;
-	struct llist_node *page_list, *pos, *n;
+	struct llist_node *page_list, *pos;
 	int freed = 0;
 
 	if (!rcu_min_cached_objs)
@@ -1476,7 +1476,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 	WRITE_ONCE(krcp->nr_bkv_objs, 0);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	llist_for_each_safe(pos, n, page_list) {
+	llist_for_each_mutable(pos, page_list) {
 		free_page((unsigned long)pos);
 		freed++;
 	}
@@ -1550,7 +1550,7 @@ kvfree_rcu_list(struct rcu_head *head)
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
-	struct kvfree_rcu_bulk_data *bnode, *n;
+	struct kvfree_rcu_bulk_data *bnode;
 	struct list_head bulk_head[FREE_N_CHANNELS];
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
@@ -1576,7 +1576,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		// Start from the tail page, so a GP is likely passed for it.
-		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
+		list_for_each_entry_mutable(bnode, &bulk_head[i], list)
 			kvfree_rcu_bulk(krcp, bnode, i);
 	}
 
@@ -1674,7 +1674,7 @@ static void
 kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 {
 	struct list_head bulk_ready[FREE_N_CHANNELS];
-	struct kvfree_rcu_bulk_data *bnode, *n;
+	struct kvfree_rcu_bulk_data *bnode;
 	struct rcu_head *head_ready = NULL;
 	unsigned long flags;
 	int i;
@@ -1683,7 +1683,7 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		INIT_LIST_HEAD(&bulk_ready[i]);
 
-		list_for_each_entry_safe_reverse(bnode, n, &krcp->bulk_head[i], list) {
+		list_for_each_entry_mutable_reverse(bnode, &krcp->bulk_head[i], list) {
 			if (!poll_state_synchronize_rcu_full(&bnode->gp_snap))
 				break;
 
@@ -1700,7 +1700,7 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		list_for_each_entry_safe(bnode, n, &bulk_ready[i], list)
+		list_for_each_entry_mutable(bnode, &bulk_ready[i], list)
 			kvfree_rcu_bulk(krcp, bnode, i);
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index 9ec774dc7009..6f4a79e32d75 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3253,7 +3253,7 @@ static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
 {
 	LIST_HEAD(empty_list);
 	LIST_HEAD(full_list);
-	struct slab_sheaf *sheaf, *sheaf2;
+	struct slab_sheaf *sheaf;
 	unsigned long flags;
 
 	spin_lock_irqsave(&barn->lock, flags);
@@ -3265,12 +3265,12 @@ static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
 
 	spin_unlock_irqrestore(&barn->lock, flags);
 
-	list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) {
+	list_for_each_entry_mutable(sheaf, &full_list, barn_list) {
 		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
 	}
 
-	list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
+	list_for_each_entry_mutable(sheaf, &empty_list, barn_list)
 		free_empty_sheaf(s, sheaf);
 }
 
@@ -3757,7 +3757,7 @@ static bool get_partial_node_bulk(struct kmem_cache *s,
 				  struct partial_bulk_context *pc,
 				  bool allow_spin)
 {
-	struct slab *slab, *slab2;
+	struct slab *slab;
 	struct slab *first = NULL, *last = NULL;
 	unsigned int total_free = 0;
 	unsigned long flags;
@@ -3773,7 +3773,7 @@ static bool get_partial_node_bulk(struct kmem_cache *s,
 	else if (!spin_trylock_irqsave(&n->list_lock, flags))
 		return false;
 
-	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
+	list_for_each_entry_mutable(slab, &n->partial, slab_list) {
 		struct freelist_counters flc;
 		unsigned int slab_free;
 
@@ -3828,7 +3828,7 @@ static void *get_from_partial_node(struct kmem_cache *s,
 				   gfp_t gfp_flags,
 				   const struct slab_alloc_context *ac)
 {
-	struct slab *slab, *slab2;
+	struct slab *slab;
 	unsigned long flags;
 	void *object = NULL;
 
@@ -3845,7 +3845,7 @@ static void *get_from_partial_node(struct kmem_cache *s,
 		spin_lock_irqsave(&n->list_lock, flags);
 	else if (!spin_trylock_irqsave(&n->list_lock, flags))
 		return NULL;
-	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
+	list_for_each_entry_mutable(slab, &n->partial, slab_list) {
 
 		struct freelist_counters old, new;
 
@@ -6345,13 +6345,13 @@ static void free_deferred_objects(struct irq_work *work)
 {
 	struct defer_free *df = container_of(work, struct defer_free, work);
 	struct llist_head *objs = &df->objects;
-	struct llist_node *llnode, *pos, *t;
+	struct llist_node *llnode, *pos;
 
 	if (llist_empty(objs))
 		return;
 
 	llnode = llist_del_all(objs);
-	llist_for_each_safe(pos, t, llnode) {
+	llist_for_each_mutable(pos, llnode) {
 		struct kmem_cache *s;
 		struct slab *slab;
 		void *x = pos;
@@ -7185,7 +7185,7 @@ __refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int mi
 		      bool allow_spin)
 {
 	struct partial_bulk_context pc;
-	struct slab *slab, *slab2;
+	struct slab *slab;
 	unsigned int refilled = 0;
 	unsigned long flags;
 	void *object;
@@ -7197,7 +7197,7 @@ __refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int mi
 	if (!get_partial_node_bulk(s, n, &pc, allow_spin))
 		return 0;
 
-	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
+	list_for_each_entry_mutable(slab, &pc.slabs, slab_list) {
 
 		unsigned int count;
 
@@ -8031,11 +8031,11 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab)
 static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 {
 	LIST_HEAD(discard);
-	struct slab *slab, *h;
+	struct slab *slab;
 
 	BUG_ON(irqs_disabled());
 	spin_lock_irq(&n->list_lock);
-	list_for_each_entry_safe(slab, h, &n->partial, slab_list) {
+	list_for_each_entry_mutable(slab, &n->partial, slab_list) {
 		if (!slab->inuse) {
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
@@ -8045,7 +8045,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	}
 	spin_unlock_irq(&n->list_lock);
 
-	list_for_each_entry_safe(slab, h, &discard, slab_list)
+	list_for_each_entry_mutable(slab, &discard, slab_list)
 		discard_slab(s, slab);
 }
 
@@ -8286,7 +8286,6 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 	int i;
 	struct kmem_cache_node *n;
 	struct slab *slab;
-	struct slab *t;
 	struct list_head discard;
 	struct list_head promote[SHRINK_PROMOTE_MAX];
 	unsigned long flags;
@@ -8312,7 +8311,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 		 * Note that concurrent frees may occur while we hold the
 		 * list_lock. slab->inuse here is the upper limit.
 		 */
-		list_for_each_entry_safe(slab, t, &n->partial, slab_list) {
+		list_for_each_entry_mutable(slab, &n->partial, slab_list) {
 			int free = slab->objects - slab->inuse;
 
 			/* Do not reread slab->inuse */
@@ -8339,7 +8338,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 		spin_unlock_irqrestore(&n->list_lock, flags);
 
 		/* Release empty slabs */
-		list_for_each_entry_safe(slab, t, &discard, slab_list)
+		list_for_each_entry_mutable(slab, &discard, slab_list)
 			free_slab(s, slab);
 
 		if (node_nr_slabs(n))
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..e050b3894d6f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2825,14 +2825,14 @@ static int try_to_unuse(unsigned int type)
  */
 static void drain_mmlist(void)
 {
-	struct list_head *p, *next;
+	struct list_head *p;
 	unsigned int type;
 
 	for (type = 0; type < nr_swapfiles; type++)
 		if (swap_usage_in_pages(swap_info[type]))
 			return;
 	spin_lock(&mmlist_lock);
-	list_for_each_safe(p, next, &init_mm.mmlist)
+	list_for_each_mutable(p, &init_mm.mmlist)
 		list_del_init(p);
 	spin_unlock(&mmlist_lock);
 }
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b8d2d87ce8d7..78ef5f7e3f67 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3010,9 +3010,9 @@ static void dup_fctx(struct userfaultfd_fork_ctx *fctx)
 
 void dup_userfaultfd_complete(struct list_head *fcs)
 {
-	struct userfaultfd_fork_ctx *fctx, *n;
+	struct userfaultfd_fork_ctx *fctx;
 
-	list_for_each_entry_safe(fctx, n, fcs, list) {
+	list_for_each_entry_mutable(fctx, fcs, list) {
 		dup_fctx(fctx);
 		list_del(&fctx->list);
 		kfree(fctx);
@@ -3021,7 +3021,7 @@ void dup_userfaultfd_complete(struct list_head *fcs)
 
 void dup_userfaultfd_fail(struct list_head *fcs)
 {
-	struct userfaultfd_fork_ctx *fctx, *n;
+	struct userfaultfd_fork_ctx *fctx;
 
 	/*
 	 * An error has occurred on fork, we will tear memory down, but have
@@ -3033,7 +3033,7 @@ void dup_userfaultfd_fail(struct list_head *fcs)
 	 *
 	 * mm tear down will take care of cleaning up VMA contexts.
 	 */
-	list_for_each_entry_safe(fctx, n, fcs, list) {
+	list_for_each_entry_mutable(fctx, fcs, list) {
 		struct userfaultfd_ctx *octx = fctx->orig;
 		struct userfaultfd_ctx *ctx = fctx->new;
 
@@ -3170,10 +3170,10 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
 
 void userfaultfd_unmap_complete(struct mm_struct *mm, struct list_head *uf)
 {
-	struct userfaultfd_unmap_ctx *ctx, *n;
+	struct userfaultfd_unmap_ctx *ctx;
 	struct userfaultfd_wait_queue ewq;
 
-	list_for_each_entry_safe(ctx, n, uf, list) {
+	list_for_each_entry_mutable(ctx, uf, list) {
 		msg_init(&ewq.msg);
 
 		ewq.msg.event = UFFD_EVENT_UNMAP;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1afca3568b9b..2b510e7651df 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2202,13 +2202,13 @@ static void purge_fragmented_blocks_allcpus(void);
 static void
 reclaim_list_global(struct list_head *head)
 {
-	struct vmap_area *va, *n;
+	struct vmap_area *va;
 
 	if (list_empty(head))
 		return;
 
 	spin_lock(&free_vmap_area_lock);
-	list_for_each_entry_safe(va, n, head, list)
+	list_for_each_entry_mutable(va, head, list)
 		merge_or_add_vmap_area_augment(va,
 			&free_vmap_area_root, &free_vmap_area_list);
 	spin_unlock(&free_vmap_area_lock);
@@ -2219,7 +2219,7 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 {
 	LIST_HEAD(decay_list);
 	struct rb_root decay_root = RB_ROOT;
-	struct vmap_area *va, *nva;
+	struct vmap_area *va;
 	unsigned long n_decay, pool_len;
 	int i;
 
@@ -2242,7 +2242,7 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 			n_decay >>= 2;
 		pool_len -= n_decay;
 
-		list_for_each_entry_safe(va, nva, &tmp_list, list) {
+		list_for_each_entry_mutable(va, &tmp_list, list) {
 			if (!n_decay--)
 				break;
 
@@ -2299,7 +2299,7 @@ static void purge_vmap_node(struct work_struct *work)
 	struct vmap_node *vn = container_of(work,
 		struct vmap_node, purge_work);
 	unsigned long nr_purged_pages = 0;
-	struct vmap_area *va, *n_va;
+	struct vmap_area *va;
 	LIST_HEAD(local_list);
 
 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
@@ -2307,7 +2307,7 @@ static void purge_vmap_node(struct work_struct *work)
 
 	vn->nr_purged = 0;
 
-	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
+	list_for_each_entry_mutable(va, &vn->purge_list, list) {
 		unsigned long nr = va_size(va) >> PAGE_SHIFT;
 		unsigned int vn_id = decode_vn_id(va->flags);
 
@@ -2803,9 +2803,9 @@ static bool purge_fragmented_block(struct vmap_block *vb,
 
 static void free_purged_blocks(struct list_head *purge_list)
 {
-	struct vmap_block *vb, *n_vb;
+	struct vmap_block *vb;
 
-	list_for_each_entry_safe(vb, n_vb, purge_list, purge) {
+	list_for_each_entry_mutable(vb, purge_list, purge) {
 		list_del(&vb->purge);
 		free_vmap_block(vb);
 	}
@@ -3386,9 +3386,9 @@ static void vm_reset_perms(struct vm_struct *area)
 static void delayed_vfree_work(struct work_struct *w)
 {
 	struct vfree_deferred *p = container_of(w, struct vfree_deferred, wq);
-	struct llist_node *t, *llnode;
+	struct llist_node *llnode;
 
-	llist_for_each_safe(llnode, t, llist_del_all(&p->list))
+	llist_for_each_mutable(llnode, llist_del_all(&p->list))
 		vfree(llnode);
 }
 
@@ -3775,14 +3775,14 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 static LLIST_HEAD(pending_vm_area_cleanup);
 static void cleanup_vm_area_work(struct work_struct *work)
 {
-	struct vm_struct *area, *tmp;
+	struct vm_struct *area;
 	struct llist_node *head;
 
 	head = llist_del_all(&pending_vm_area_cleanup);
 	if (!head)
 		return;
 
-	llist_for_each_entry_safe(area, tmp, head, llnode) {
+	llist_for_each_entry_mutable(area, head, llnode) {
 		if (!area->pages)
 			free_vm_area(area);
 		else
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35c3bb15ae96..d7c4ded7a8fe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1598,11 +1598,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
-	struct folio *folio, *next;
+	struct folio *folio;
 	LIST_HEAD(clean_folios);
 	unsigned int noreclaim_flag;
 
-	list_for_each_entry_safe(folio, next, folio_list, lru) {
+	list_for_each_entry_mutable(folio, folio_list, lru) {
 		/* TODO: these pages should not even appear in this list. */
 		if (page_has_movable_ops(&folio->page))
 			continue;
@@ -4805,7 +4805,6 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	LIST_HEAD(list);
 	LIST_HEAD(clean);
 	struct folio *folio;
-	struct folio *next;
 	enum node_stat_item item;
 	struct reclaim_stat stat;
 	struct lru_gen_mm_walk *walk;
@@ -4841,7 +4840,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 			type_scanned, reclaimed, &stat, sc->priority,
 			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
-	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
+	list_for_each_entry_mutable_reverse(folio, &list, lru) {
 		DEFINE_MIN_SEQ(lruvec);
 
 		if (!folio_evictable(folio)) {
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 83f5820c45f9..2ac86c758e0b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1806,7 +1806,7 @@ static void async_free_zspage(struct work_struct *work)
 {
 	int i;
 	struct size_class *class;
-	struct zspage *zspage, *tmp;
+	struct zspage *zspage;
 	LIST_HEAD(free_pages);
 	struct zs_pool *pool = container_of(work, struct zs_pool,
 					free_work);
@@ -1822,7 +1822,7 @@ static void async_free_zspage(struct work_struct *work)
 		spin_unlock(&class->lock);
 	}
 
-	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
+	list_for_each_entry_mutable(zspage, &free_pages, list) {
 		list_del(&zspage->list);
 		lock_zspage(zspage);
 
-- 
2.43.0


