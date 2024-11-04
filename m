Return-Path: <cgroups+bounces-5425-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70779BBF37
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6207B21786
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDA1FA264;
	Mon,  4 Nov 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LBGDMQwO"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3811FA260
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754377; cv=none; b=M1/MJka6KtypPQK1z4AFPQ9UBx3/bgqAsmEfRx5p5fePgB1dJ9y2pzt/nfqgNlpevarKtS7+gNsue+HkifwMGpGgYs74DHZ6zcpFHeDAXiIfLc7tpsY5voYQLsXtpKL+dXqqbQcO80yeWJj5eLRddpXeKJoViWJY9X3mrGf9/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754377; c=relaxed/simple;
	bh=/gpCiFZ+vwDG0vBZ2Hxn9lJFwjNLB5hLVjj+xLi9T7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7RGOE9Vr+bh/uXNWoObIMZIoEEOGHy5rKxnmosKWKp1cXzyB9a0oNyLBuZvCEUeY/Pf4OpdtYF0BiMha57BM1FaXj/vc2T9vJZidRH/vmBiFP9NHx93SnYJRS38dabfgfsiuh0Km0Ps8D4PFfWmcD+bvD111TAAJr1E2t6Ajck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LBGDMQwO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=n4HJqHIFL6KoDyu6o3HDh3SUN9SIibGS4LEHqczrBb0=; b=LBGDMQwOUt8tta8VHNMF+zE9ED
	SVBWmfKJzxz+yptFcLR0vrOQCmdJ9MPFhP9i/N/OTwaUsy7KfnOY2V/QeD9deQuKfWrxakLdBbpRM
	ddImJROE0Ug4pFwod2ux+4/ao6ATz71tF7RTeSGcQhoUz142XbT4FH5V750HdeGxhk4DBEqA5Y2KR
	rGDqgBflCT1dpbTbiXe0X9lrMIgEMrouVA7GYw66o7sbQ7H94EFQsIuBho3ivKvCkGntqyzBPKnE9
	nNS4KpMWfWmiHR16S9pzfqeBz4s3zNtRbkVKpE3rdm0PcQYUUSpKGhDdp0dMVkxzzezuuQ1jm+SdP
	AIkfZaIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t84Gy-00000001ZYN-15RY;
	Mon, 04 Nov 2024 21:06:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm: Simplify split_page_memcg()
Date: Mon,  4 Nov 2024 21:05:59 +0000
Message-ID: <20241104210602.374975-3-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241104210602.374975-1-willy@infradead.org>
References: <20241104210602.374975-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last argument to split_page_memcg() is now always 0, so remove it,
effectively reverting commit b8791381d7ed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 26 ++++++++++++++------------
 mm/page_alloc.c            |  4 ++--
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5502aa8e138e..a787080f814f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1044,7 +1044,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 	rcu_read_unlock();
 }
 
-void split_page_memcg(struct page *head, int old_order, int new_order);
+void split_page_memcg(struct page *first, int order);
 
 #else /* CONFIG_MEMCG */
 
@@ -1463,7 +1463,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
 
-static inline void split_page_memcg(struct page *head, int old_order, int new_order)
+static inline void split_page_memcg(struct page *first, int order)
 {
 }
 #endif /* CONFIG_MEMCG */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e44d6e7591e..506439a5dcfe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3034,25 +3034,27 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 }
 
 /*
- * Because folio_memcg(head) is not set on tails, set it now.
+ * The memcg data is only set on the first page, now transfer it to all the
+ * other pages.
  */
-void split_page_memcg(struct page *head, int old_order, int new_order)
+void split_page_memcg(struct page *first, int order)
 {
-	struct folio *folio = page_folio(head);
+	unsigned long memcg_data = first->memcg_data;
+	struct obj_cgroup *objcg;
 	int i;
-	unsigned int old_nr = 1 << old_order;
-	unsigned int new_nr = 1 << new_order;
+	unsigned int nr = 1 << order;
 
-	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
+	if (!memcg_data)
 		return;
 
-	for (i = new_nr; i < old_nr; i += new_nr)
-		folio_page(folio, i)->memcg_data = folio->memcg_data;
+	VM_BUG_ON_PAGE((memcg_data & OBJEXTS_FLAGS_MASK) != MEMCG_DATA_KMEM,
+			first);
+	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 
-	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
-	else
-		css_get_many(&folio_memcg(folio)->css, old_nr / new_nr - 1);
+	for (i = 1; i < nr; i++)
+		first[i].memcg_data = memcg_data;
+
+	obj_cgroup_get_many(objcg, nr - 1);
 }
 
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47048b39b8ca..5523654c9759 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2823,7 +2823,7 @@ void split_page(struct page *page, unsigned int order)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
 	pgalloc_tag_split(page_folio(page), order, 0);
-	split_page_memcg(page, order, 0);
+	split_page_memcg(page, order);
 }
 EXPORT_SYMBOL_GPL(split_page);
 
@@ -5020,7 +5020,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 
 		split_page_owner(page, order, 0);
 		pgalloc_tag_split(page_folio(page), order, 0);
-		split_page_memcg(page, order, 0);
+		split_page_memcg(page, order);
 		while (page < --last)
 			set_page_refcounted(last);
 
-- 
2.43.0


