Return-Path: <cgroups+bounces-5422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEB09BBF35
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A01B20F23
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1F71FA260;
	Mon,  4 Nov 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qhp+i0Z8"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA11FA24A
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754369; cv=none; b=f99XpG63pqiu3fhNh7Zjxgi5pBjHEnhseVfxO1cdhYygtspzQI3SFGcXwSbYKalOH1o5wU8OWDOUmeghQnyisQDIcrRw3ruKmuP+nXKwf4KAZoya8RgPPlZ1cZHLQSQZXIkrlwiUMUFzwW/ZZ//Wr0i4EdwWjXgDDEVS8kh1fHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754369; c=relaxed/simple;
	bh=z+LRWJmYeOcXNXi7+edgPi2n7oTo/Tv0A1CQwqymYwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUZrZkgv+O98pbjs+09TY1UkUXLtSoYuzyGK5VuTF2ngJ/X2wD/ai6uwaOgMHFdiNZvAC9AhhE2yS6a7l8X4gmSd3r2J09BY1bcdVdrNoI/hSi1eav2wsddYAujeN3gTtXx4lvHWSKfRU+tEng+0tm27N0BQoF2l9Nz7Lu1Lrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qhp+i0Z8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MlKXMVkwoR8OxX3WpEQg0gTq0YNyoaDmxbJW107WDCQ=; b=Qhp+i0Z8Wvi3p0vj2GbUlbmevq
	6Huxn+l0vgzCe1MsbhAUVi0/+gJixni6PkK/HqegEN8hSaLTldkKEKv0Fy6MCl0JGj9LFZMkfqqi8
	fMj4Sg2/hQ70lLVDYy+bGSaZaj9J7VYZV7g8hIgJvuIE0bPUzN4gB/zDp8/g8K/wnT+qyzis7kOHo
	SuWNK+mci/XiNBdhfauPOmPBN3MZlTFtDC6sKnLkCoGTU63Ytpd8k8ibY9lmI7vJZI7HHz4aZxwJu
	MAjwEpqgggawL5LTKk/JxCusvGFPoB3QGRA5F8aD0jDEngnEUJNLOAVjE7UCiDHguUw8fdhpRfYPc
	zE9FKzcA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t84Gy-00000001ZYP-1XXt;
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
Subject: [PATCH 3/3] mm: Introduce acctmem
Date: Mon,  4 Nov 2024 21:06:00 +0000
Message-ID: <20241104210602.374975-4-willy@infradead.org>
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

struct acctmem is used for MEMCG_DATA_KMEM allocations.  We're still a
bit loose with our casting to folios instead of acctmem, but that's a
problem to solve later.  The build asserts ensure that this carelessness
doesn't cause any new bugs today.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 24 ++++++++++++++++++++++++
 include/linux/mm_types.h   |  6 +++---
 mm/memcontrol.c            |  7 ++++---
 mm/page_alloc.c            |  4 ++--
 mm/page_owner.c            |  2 +-
 mm/slab.h                  |  2 +-
 6 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a787080f814f..19ee98abea0f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -30,6 +30,30 @@ struct page;
 struct mm_struct;
 struct kmem_cache;
 
+/*
+ * For now, this data structure overlays struct page.  Eventually it
+ * will be separately allocated and become a memdesc type of its own
+ * like slab and ptdesc.  memcg_data is only valid on the first page
+ * of an allocation, but that allocation might not be compound!
+ */
+struct acctmem {
+	unsigned long __page_flags;
+	unsigned long __padding[5];
+	unsigned int ___padding[2];
+	unsigned long memcg_data;
+};
+#ifdef CONFIG_MEMCG
+static_assert(offsetof(struct page, __acct_memcg_data) ==
+		offsetof(struct acctmem, memcg_data));
+static_assert(offsetof(struct folio, memcg_data) ==
+		offsetof(struct acctmem, memcg_data));
+static_assert(sizeof(struct acctmem) <= sizeof(struct page));
+#endif
+
+#define page_acctmem(_page)	(_Generic((_page),			\
+	const struct page *:	(const struct acctmem *)(_page),	\
+	struct page *:		(struct acctmem *)(_page)))
+
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2b694f9a4518..274b125df0df 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -181,7 +181,7 @@ struct page {
 	atomic_t _refcount;
 
 #ifdef CONFIG_MEMCG
-	unsigned long memcg_data;
+	unsigned long __acct_memcg_data;
 #elif defined(CONFIG_SLAB_OBJ_EXT)
 	unsigned long _unused_slab_obj_exts;
 #endif
@@ -410,7 +410,7 @@ FOLIO_MATCH(private, private);
 FOLIO_MATCH(_mapcount, _mapcount);
 FOLIO_MATCH(_refcount, _refcount);
 #ifdef CONFIG_MEMCG
-FOLIO_MATCH(memcg_data, memcg_data);
+FOLIO_MATCH(__acct_memcg_data, memcg_data);
 #endif
 #if defined(WANT_PAGE_VIRTUAL)
 FOLIO_MATCH(virtual, virtual);
@@ -499,7 +499,7 @@ TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
-TABLE_MATCH(memcg_data, pt_memcg_data);
+TABLE_MATCH(__acct_memcg_data, pt_memcg_data);
 #endif
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 506439a5dcfe..89c9d206c209 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2661,6 +2661,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
  */
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 {
+	struct acctmem *acctmem = page_acctmem(page);
 	struct obj_cgroup *objcg;
 	int ret = 0;
 
@@ -2669,7 +2670,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
 			obj_cgroup_get(objcg);
-			page->memcg_data = (unsigned long)objcg |
+			acctmem->memcg_data = (unsigned long)objcg |
 				MEMCG_DATA_KMEM;
 			return 0;
 		}
@@ -3039,7 +3040,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
  */
 void split_page_memcg(struct page *first, int order)
 {
-	unsigned long memcg_data = first->memcg_data;
+	unsigned long memcg_data = page_acctmem(first)->memcg_data;
 	struct obj_cgroup *objcg;
 	int i;
 	unsigned int nr = 1 << order;
@@ -3052,7 +3053,7 @@ void split_page_memcg(struct page *first, int order)
 	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 
 	for (i = 1; i < nr; i++)
-		first[i].memcg_data = memcg_data;
+		page_acctmem(first + i)->memcg_data = memcg_data;
 
 	obj_cgroup_get_many(objcg, nr - 1);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5523654c9759..07d9302882b2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -870,7 +870,7 @@ static inline bool page_expected_state(struct page *page,
 	if (unlikely((unsigned long)page->mapping |
 			page_ref_count(page) |
 #ifdef CONFIG_MEMCG
-			page->memcg_data |
+			page_acctmem(page)->memcg_data |
 #endif
 #ifdef CONFIG_PAGE_POOL
 			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
@@ -898,7 +898,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
 	}
 #ifdef CONFIG_MEMCG
-	if (unlikely(page->memcg_data))
+	if (unlikely(page_acctmem(page)->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
 #ifdef CONFIG_PAGE_POOL
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d6360eaccbb..71e183f8988b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -506,7 +506,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 	char name[80];
 
 	rcu_read_lock();
-	memcg_data = READ_ONCE(page->memcg_data);
+	memcg_data = READ_ONCE(page_acctmem(page)->memcg_data);
 	if (!memcg_data)
 		goto out_unlock;
 
diff --git a/mm/slab.h b/mm/slab.h
index 632fedd71fea..ee9ab84f7c4d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -103,7 +103,7 @@ SLAB_MATCH(flags, __page_flags);
 SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
 SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
-SLAB_MATCH(memcg_data, obj_exts);
+SLAB_MATCH(__acct_memcg_data, obj_exts);
 #elif defined(CONFIG_SLAB_OBJ_EXT)
 SLAB_MATCH(_unused_slab_obj_exts, obj_exts);
 #endif
-- 
2.43.0


