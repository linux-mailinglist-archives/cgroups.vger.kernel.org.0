Return-Path: <cgroups+bounces-10281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1592B87D65
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 05:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7851895330
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C0263F34;
	Fri, 19 Sep 2025 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jEtAt2kn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93825CC64
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253795; cv=none; b=lmDZstObNQbgjoiRk9JY4R/xKZOhvmOa1K3Wc0j8eoKbEg4QLWHd+3PRQyE4z8MxzXa7thAhbxSTrTB0ipQCv+sybqbSwvB14a6hkQhmOZGuvckDAFfeaD1sfpJakYxFuPe9bx0GZMAF5SnslXCynvIXmoWVSHIwfBIHNROt7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253795; c=relaxed/simple;
	bh=g37vYcabJEJRYlDTW+ACXK5cF4/Rt3LDmjbXj6OCrpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzpAEgnPQ89tk48pEXLybcriPnz1rqIrjVK0q28QDxv6gSs+n7DJxsUsuHrM1R9iI05pH9xAleJEJIquyNNYDOG+9hw9HA6ypuHbc9MFAbeXjF/d9lMSkfOepOuc6D8Y+F3vYH18o/FPEEzp/Hf5pd3U7wHYNPlb0R8Hn/2O06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jEtAt2kn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806df50so14046085ad.1
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758253793; x=1758858593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH+wF1kXarYaSv3rskQg/2hJ0DlvmAW+2Zdq+CMJuUY=;
        b=jEtAt2knZRiQ5iSY9jk0JZ+ljiZSlaAiye4tjAH4fR5nZMUpK1E23+HT4dtCyhpZgE
         kvzdP6cGHsir60SX4Esbi3GsAQdVnBTD1J3M5K9twD7qXbuc2BG0Pg/eFQilN4n92hwK
         Wz5O8DEwmybskCjd/xectAKcuD241eWfZ6yRLwUmMKZRuy4nRKBIjdimElKCGE05+og7
         7IVjqQnszqSjRcAUAWHk8B4f8a6mDMwEWI43qGeRTWBIvlLxYzqtkcXdVWeloEgZwRVn
         mqXHVmtRfiUhXPaOM6cLtvIeKJqS6ngvb7HuMKUrNgWYmrYhbBN9kkPMQ+JM4oUWJr/s
         ymgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253793; x=1758858593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH+wF1kXarYaSv3rskQg/2hJ0DlvmAW+2Zdq+CMJuUY=;
        b=CE7Pv/iKR1eud8f1r4b5iIN0cIBu9/YKjosZd8HjkoQQzB/pKDao3Fo/hOalxW4zUK
         LgfgodFT3X7uf6RY0nzzOOhS/PNya5uQJKDdnncxyJG4KJyVY0wSdahpNd7TqWGs8cp8
         S6kJZj11eSWCTI+mkL13ilLjqvWtd4CHYIXIdj7OloLP/gLp4FARdwnHnjMNCCE1jru3
         whd+2VwyG+/fGTUlOAKhZmqup6tcqCdwBqd4QblljEzOpDq48LLnmhTJtN3Jg1OlUnSC
         pkqSBlrYus/zi0HM0wrYMg+L6WqhQK0xNge6/pYxSOSsQHe4ykXWjjp13unIWD4VkqR6
         D2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUwOTo0fmdPawzZpkfoQi8QSzzZBfvWRq6hAHiAIJygqTBC5Pc6DreR/5GHZru+wu3xxvyNzGM3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgv7StVZzvDD4caamWG9q7rei01/G8RayaeLj2gJxSk20k0nNj
	DhlUyD0abtM6mfrMiefoMeGgHn6+ZZcgfHOgZ7xUqJ8RhzaHFUdtR9Coc/JAxAoXFKw=
X-Gm-Gg: ASbGncs+cPCua859vKMIyGDPa46DU5LOJ4qaXvFtsOb/mFXBavyvgpHRXXjQmce9Z/a
	nLn0jYKUqm3MSbMy6bUMVL89inveM/c9dc7GJo9LHOTaD5QP1QC6ux2w5ZPeQZoEb8sjTbRUCVr
	/2yjqInHPjWGv+F27ip8krBEDaIVW7jh3MndJBgO7TLUwZ3tHEBCDg3lN1FbB9teJW7+FdsrtE0
	Scmff3vsIwKevky6aE5ZW25xsg1M1H7JlHoaYKjiD9Ssi1CEfH2HcIOp7xZ8EXwEvrgmQLpqx5n
	6wzFSk6wfdf0pJMK7FlwtTyvirSI5Psc7oldBBBjWbepY8u6WPFTG1cIVXAStcbNT7uvvBTru3x
	NS/04LJe0m0vibbFT/8+uxd9cNfWBk1Lyvi/gH9grTXcmdcL43mDf6drQwR+ykFfA9WFrHsg=
X-Google-Smtp-Source: AGHT+IE5FHZ53nVuEAm0EyvYyGaqEltHg/7s5hCn2sKWBeSzIX/++Bb6G05UYvRwpJYwFHv887Zr4Q==
X-Received: by 2002:a17:902:ccd2:b0:252:50ad:4e6f with SMTP id d9443c01a7336-269ba566603mr31897395ad.54.1758253792612;
        Thu, 18 Sep 2025 20:49:52 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm39629235ad.72.2025.09.18.20.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 20:49:52 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/4] mm: thp: introduce folio_split_queue_lock and its variants
Date: Fri, 19 Sep 2025 11:46:33 +0800
Message-ID: <eb072e71cc39a0ea915347f39f2af29d2e82897f.1758253018.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758253018.git.zhengqi.arch@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muchun Song <songmuchun@bytedance.com>

In future memcg removal, the binding between a folio and a memcg may
change, making the split lock within the memcg unstable when held.

A new approach is required to reparent the split queue to its parent. This
patch starts introducing a unified way to acquire the split lock for
future work.

It's a code-only refactoring with no functional changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h | 10 +++++
 mm/huge_memory.c           | 89 ++++++++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 16fe0306e50ea..99876af13c315 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1662,6 +1662,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 void reparent_shrinker_deferred(struct mem_cgroup *memcg);
+
+static inline int shrinker_id(struct shrinker *shrinker)
+{
+	return shrinker->id;
+}
 #else
 #define mem_cgroup_sockets_enabled 0
 
@@ -1693,6 +1698,11 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 				    int nid, int shrinker_id)
 {
 }
+
+static inline int shrinker_id(struct shrinker *shrinker)
+{
+	return -1;
+}
 #endif
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 582628ddf3f33..d34516a22f5bb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1078,26 +1078,62 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 #ifdef CONFIG_MEMCG
 static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
+struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
+					   struct deferred_split *queue)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
-
-	if (memcg)
-		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
+	if (mem_cgroup_disabled())
+		return NULL;
+	if (&NODE_DATA(folio_nid(folio))->deferred_split_queue == queue)
+		return NULL;
+	return container_of(queue, struct mem_cgroup, deferred_split_queue);
 }
 #else
 static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
+struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
+					   struct deferred_split *queue)
 {
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
-
-	return &pgdat->deferred_split_queue;
+	return NULL;
 }
 #endif
 
+static struct deferred_split *folio_split_queue_lock(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+	struct deferred_split *queue;
+
+	memcg = folio_memcg(folio);
+	queue = memcg ? &memcg->deferred_split_queue :
+			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
+	spin_lock(&queue->split_queue_lock);
+
+	return queue;
+}
+
+static struct deferred_split *
+folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
+{
+	struct mem_cgroup *memcg;
+	struct deferred_split *queue;
+
+	memcg = folio_memcg(folio);
+	queue = memcg ? &memcg->deferred_split_queue :
+			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	return queue;
+}
+
+static inline void split_queue_unlock(struct deferred_split *queue)
+{
+	spin_unlock(&queue->split_queue_lock);
+}
+
+static inline void split_queue_unlock_irqrestore(struct deferred_split *queue,
+						 unsigned long flags)
+{
+	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
+}
+
 static inline bool is_transparent_hugepage(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
@@ -3579,7 +3615,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct page *lock_at,
 		struct list_head *list, bool uniform_split)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
+	struct deferred_split *ds_queue;
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
@@ -3718,7 +3754,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = folio_split_queue_lock(folio);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		struct swap_cluster_info *ci = NULL;
 		struct lruvec *lruvec;
@@ -3740,7 +3776,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 */
 			list_del_init(&folio->_deferred_list);
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
@@ -3835,7 +3871,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (ci)
 			swap_cluster_unlock(ci);
 	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		ret = -EAGAIN;
 	}
 fail:
@@ -4016,8 +4052,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	WARN_ON_ONCE(folio_ref_count(folio));
 	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
 
-	ds_queue = get_deferred_split_queue(folio);
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		if (folio_test_partially_mapped(folio)) {
@@ -4028,7 +4063,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 		list_del_init(&folio->_deferred_list);
 		unqueued = true;
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 
 	return unqueued;	/* useful for debug warnings */
 }
@@ -4036,10 +4071,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 /* partially_mapped=false won't clear PG_partially_mapped folio flag */
 void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-#ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg = folio_memcg(folio);
-#endif
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
 	/*
@@ -4062,7 +4094,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	if (folio_test_swapcache(folio))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
 	if (partially_mapped) {
 		if (!folio_test_partially_mapped(folio)) {
 			folio_set_partially_mapped(folio);
@@ -4077,15 +4109,16 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
 	}
 	if (list_empty(&folio->_deferred_list)) {
+		struct mem_cgroup *memcg;
+
+		memcg = folio_split_queue_memcg(folio, ds_queue);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
-#ifdef CONFIG_MEMCG
 		if (memcg)
 			set_shrinker_bit(memcg, folio_nid(folio),
-					 deferred_split_shrinker->id);
-#endif
+					 shrinker_id(deferred_split_shrinker));
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
-- 
2.20.1


